#include "xio.h"
#include "m_map.h"
#include "fsl.h"
#include "lcd.h"

/*
TODO:

Hardware:
LCD driver
A/D driver

Software:
LCD drawing library
Memory test
Everything else: A/D -> screen

DONE:
board drivers
external button drivers
external LED PWM drivers

*/

#define RX_EMPTY 0x1
#define RX_FULL 0x2

#define MS (12000)
#define US (12)

void delay_us(int t) {
	int i=0;
	for(i=0; i< (t * US); i++);
}

void delay_ms(int t) {
	int i=0;
	for(i=0 ;i < (t * MS); i++ );
}

#define SAMPLES 512
// smaples sets center at 0
signed short * c1;
signed short * c2;
signed short * cc1;
signed short * cc2;
signed short * d1;
signed short * d2;
volatile unsigned int c_ptr;
volatile unsigned int c_count;

void isr(void * p) {
	unsigned short int ret = 0;
	int i=0;
	char lo, hi;
	
	SPISSR = 1; // de-select slave	
	// write data to initiate next reading
	SPISSR = 0; // select lowest slave

	hi = SPIDRR;
	lo = SPIDRR;
	ret = (lo&0xFF) | ((hi&0xFF) << 8);
	c1[c_ptr] = ret;
	c2[c_ptr++] = SPI2; // TODO: fix this in hardware
	
	c_ptr = c_ptr % SAMPLES;
	
	if( c_count < SAMPLES ) c_count++;
		
	T3_TCSR0 = T3_TCSR0;
	IAR = ISR;
	SPICR = SPICR | 0x60;
	
	SPIDTR = 0;
	SPIDTR = 0;		
}

void * malloc(int sz) {
	static int brk = (int)MEM;
	int ret = brk;
	brk += sz;
	return (void*)ret;
}

#define LCD4_BUFSZ 8640
unsigned char * lcd4_buf;

void lcd4_clear() {
	int i;
	for( i=0; i<LCD4_BUFSZ; i++ ) {
		lcd4_buf[i] = 0; // two black pixels
	}
}

void lcd4_pixel(int x, int y, unsigned char idx) {
	// ordering: row-major order
	int i = (x/2) + (y * 80);
	unsigned char tmp = lcd4_buf[i];
	if( x%2 == 0 ) {
		// even. let's pick one
		// this seems right
		// upper bits
		tmp = (tmp & 0xF) | (idx << 4);
	} else {
		// lower bits
		tmp = (tmp & 0xF0) | (idx & 0xF);
	}
	lcd4_buf[i] = tmp;
}

void lcd4_line(int x0, int y0, int x1, int y1, unsigned char idx) {
	int dy = y1 - y0;
	int dx = x1 - x0;
	int stepx, stepy;
	
	if (dy < 0) { dy = -dy; stepy = -1; } else { stepy = 1; }
	if (dx < 0) { dx = -dx; stepx = -1; } else { stepx = 1; }
	
	dy <<= 1; // dy is now 2*dy
	dx <<= 1; // dx is now 2*dx
	
	lcd4_pixel(x0, y0, idx);
	
	if (dx > dy) {
		int fraction = dy - (dx >> 1); // same as 2*dy - dx

		while (x0 != x1) {
			if (fraction >= 0) {
				y0 += stepy;
				fraction -= dx; // same as fraction -= 2*dx
			}
			x0 += stepx;
			fraction += dy; // same as fraction -= 2*dy
			lcd4_pixel(x0, y0, idx);
		}
	} else {
		int fraction = dx - (dy >> 1);

		while (y0 != y1) {
			if (fraction >= 0) {
				x0 += stepx;
				fraction -= dy;
			}
			y0 += stepy;
			fraction += dx;
			lcd4_pixel(x0, y0, idx);
		}
	}
}

int main() {
	unsigned char btn;
	unsigned char btn_old;
	signed short tmp;
	unsigned short btn_screen;
	int i;
	int j;
	unsigned short int spi;
	unsigned short int spi2;
	unsigned char sw;
	signed short max;
	signed short min;
	signed short center;
	signed short maxd1;
	signed short maxd2;
	signed short mind1;
	signed short mind2;
	int min_pos;
	int max_pos;
	int maxd1_pos;
	int maxd2_pos;
	int mind1_pos;
	int mind2_pos;
	
	int div;
	int start;
	int tmp;
	int c_start;
	int c_end;
	int count;
	
	int lcd_on = 1;
	
	int frames;
	
	// overall scope control parameters
	int timebase = 10; // in 10^-6 sec
	int timebase_table[] = {10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 
	10000, 20000, 50000, 100000, 200000, 500000, 1000000}; // 16 settings
	int timebase_i = 0;
	
	// 0 for auto-scale. units of uV/pixel
	int volts = 10000; // don't care about accuracy here yet, just UI
	int volts_i = 1;
	int volts_table[] = {0, 10000, 20000, 50000, 100000, 200000, 500000, 
		1000000, 2000000, 5000000}; // 10 entries
	int select = 0; // what's selected in the UI
	// 0x1: ch1 enable
	// 0x2: ch2 enable
	// 0x4: ch1 trigger
	// 0x8: ch2 trigger
	int channels = 0xF;

	XIo_Out32(XPAR_PUSH_BUTTONS_3BIT_BASEADDR + 0x04, 0xFF); // inputs
	XIo_Out32(XPAR_LEDS_8BIT_BASEADDR + 0x04, 0x00); // outputs
	XIo_Out32(XPAR_SWITCHES_8BIT_BASEADDR + 0x04, 0xFF); // inputs
	XIo_Out32(XPAR_SPI2_DATA_BASEADDR + 0x4, 0xFFFF); // inputs
	// SPI initialization
	SPICR = 0x8E; // 0 1000 1110
	SPI_DGIE = 0x0; // SPI global interrupt disable

	// RAM allocation
	c1 = malloc(SAMPLES * 2);
	c2 = malloc(SAMPLES * 2);
	cc1 = malloc(SAMPLES * 2);
	cc2 = malloc(SAMPLES * 2);
	d1 = malloc(SAMPLES * 2);
	d2 = malloc(SAMPLES * 2);
	lcd4_buf = malloc(LCD4_BUFSZ);
	
	// analog capture setup:
	//  gobal initialization
	for( i=0; i < SAMPLES; i++ ) {
		c1[i] = 0;
		c2[i] = 0;
	}
	c_ptr = 0;
	c_count = 0;
	
	microblaze_enable_interrupts();
	microblaze_register_handler(isr, 0);
		
	IER = INT_T3;
	MER = 0x3; // enable hardware interrupts
	
	SPISSR = 1; // de-select slave	
	// write data to initiate next reading
	SPISSR = 0; // select lowest slave
	SPIDTR = 0;
	SPIDTR = 0;		
	
	T3_TLR0  = (50*timebase) - 1; // timer load value (divide by 50000: 100 kHz)
	T3_TCSR0 = 0x20;
	T3_TCSR0 = 0x1D2; // 1 1101 0010
	
	LED = 0;
	
	//InitLcd();
	GPIO = 0; // reset low
	delay_ms(1);
	GPIO = 1; // reset high
	delay_ms(300); // wait for display init
	LCD_CR = 0x3; // reset fifos
	LCD_CR = 0x0;
	delay_ms(2000);

	// UI design notes:
	// 20 pixels is a bit too much for UI borders
	// 10px should be about right
	//
	// General info on fonts:
	//  fonts are monospace (no surprise)
	//  fonts include space to the right of the letters
	//
	// small font is 8px tall;
	// characters are 6px wide; can fit 21 across a screen
	//
	// medium font is 8px tall
	// characters are 8px wide; can fit 16 across a screen
	//
	// large font is 16px tall
	// characters are 8px wide; can fit 16 across a screen
	
	// UI design tests:
	SSEG = timebase_i;
	
	frames = 0;
	btn = BTN;
	btn_old = btn;
	while(lcd_on) {
		btn = BTN;
		btn &= 0x1C; // mask "external" buttons

		while( lcd_rx_timeout(0) != -1 ); // clear input fifo
			
		lcd_tx('A');
		// read high byte
		tmp = lcd_rx_timeout(1000000);
		btn_screen = tmp;
		// read low byte
		tmp = lcd_rx_timeout(1000000);
		btn_screen = (btn_screen << 8) | tmp;
		// read end byte
		lcd_rx_timeout(1000000);
		
		
		if( btn != btn_old ) {
			// handle button pushes here
			unsigned char press = btn & ~btn_old;
			unsigned char release = ~btn & btn_old;
			
			if( press & 0x04 ) {
				switch(select) {
				case 0:
					// time set
					timebase_i++;
					timebase_i %= 14;
					timebase = timebase_table[timebase_i];
					T3_TLR0  = (50*timebase) - 1; // timer load value (divide by 50000: 100 kHz)
					
					// clear the sample buffers
					//  turn off interrupts so that we can work in peace
					microblaze_disable_interrupts();
					for( i=0; i<SAMPLES; i++ ) {
						c1[i] = 0x800;
						c2[i] = 0x800;
					}
					c_ptr = 0;
					c_count = 0;
					
					//  don't forget to turn interrupts back on
					microblaze_enable_interrupts();
					break;
				case 1:
					// voltage set
					volts_i = (volts_i + 1) % 10;
					volts = volts_table[volts_i];
					//if( volts > 10000000 ) volts = 10000;
					break;
				case 2:
					// ch1 enable
					channels ^= 0x1;
					if( !(channels&0x1) ) {
						channels &= 0xB;
					}
					break;
				case 3:
					// ch2 enable
					channels ^= 0x2;
					if( !(channels&0x2) ) {
						channels &= 0x7;
					}
					break;
				case 4:
					// trigger select
					channels = (channels&0x3)|((((channels>>2)+1)%4)<<2);
					break;
				}
			}
			
			if( press & 0x8 ) {
				select = (select+1)%5;
			}
			
			if( press & 0x10 ) {
				lcd_on = 0;
			}
			
			if( press ) {
				// transmit new UI data to display
				while( lcd_rx_timeout(0) != -1 ); // clear input fifo
					
				lcd_tx('S');
				if( timebase < 1000 ) {
					lcd_tx(timebase & 0xFF);
					lcd_tx((timebase >> 8) & 0xFF);
					lcd_tx(2); // uS
				} else if( timebase < 1000000 ) {
					lcd_tx( (timebase/1000) & 0xFF);
					lcd_tx( ((timebase/1000) >> 8) & 0xFF);
					lcd_tx(1); // mS
				} else {
					lcd_tx( (timebase/1000000) & 0xFF );
					lcd_tx( ((timebase/1000000) >> 8) & 0xFF );
					lcd_tx(0); // S
				}
				if( volts < 1000 ) {
					lcd_tx(volts & 0xFF);
					lcd_tx((volts >> 8) & 0xFF);
					lcd_tx(2); // uV
				} else if( volts < 1000000 ) {
					lcd_tx( (volts/1000) & 0xFF);
					lcd_tx( ((volts/1000) >> 8) & 0xFF);
					lcd_tx(1); // mV
				} else {
					lcd_tx( (volts/1000000) & 0xFF );
					lcd_tx( ((volts/1000000) >> 8) & 0xFF );
					lcd_tx(0); // V
				}
				lcd_tx(channels & 0xFF);
				lcd_tx(select & 0xFF);
				
				lcd_rx_timeout(1000000); //wait for confirmation
			}
			
			// done
			btn_old = btn;
		}
		LED = btn;
				
		spi  = c1[c_ptr];
		spi2 = c2[c_ptr];
		
		// Drawing code here:
		sw = SW;
		
		// calculate simple auto-scale value
		max = 0x8000; // max negative
		min = 0x7FFF; // max positive
		maxd1 = 0x8000; // smallest signed short
		maxd1 = 0x8000; // smallest signed short
		mind1 = 0x7FFF; // biggest signed short
		mind2 = 0x7FFF; // biggest signed short
		tmp = 0; // using to keep track of over/under flow
		
		// CAPTURE DATA
		// c_end and c_start define a range of data that should be
		// considered invalid
		count = c_count;
		c_start = c_ptr;
		for( i=0; i < SAMPLES; i++ ) {
			cc1[i] = c1[i];
			cc2[i] = c2[i];
		}
		c_end = c_ptr;
		// interrupts 275 times (consistently!)
		
		// gaurantee that c_end > c_start
		if( c_start > c_end ) c_end += SAMPLES;
		
		// since c_end > c_start
		//  make c_start > c_end
		c_start += SAMPLES;
		
		// PROCESS DATA FOR TRIGGERING
		for( j=c_end; j < c_start; j++ ) {
			i = j % SAMPLES;
			// derivative
			d1[i] = cc1[(i+1)%SAMPLES] - cc1[i];
			d2[i] = cc2[(i+1)%SAMPLES] - cc2[i];
			
			// find maximum derivative
			if( d1[i] > maxd1 && channels&0x1 ) {
				maxd1 = d1[i];
				if( j < (c_start - LCD_COLS) ) maxd1_pos = i;
			}
			if( d2[i] > maxd2 && channels&0x2 ) {
				maxd2 = d2[i];
				if( j < (c_start - LCD_COLS) ) maxd2_pos = i;
			}
			// find min derivative
			if( d1[i] > mind1 && channels&0x1 ) {
				mind1 = d1[i];
				if( j < (c_start - LCD_COLS) ) mind1_pos = i;
			}
			if( d2[i] > mind2 && channels&0x2 ) {
				mind2 = d2[i];
				if( j < (c_start - LCD_COLS) ) mind2_pos = i;
			}
			
			// min/max
			if( cc1[i] > max && channels&0x1) {
				max = cc1[i];
				// limit valid start points to those that leave valid data
				if( j < (c_start - LCD_COLS) ) max_pos = i;
			}
			if( cc2[i] > max && channels&0x2 ) {
				max = cc2[i];
				// limit valid start points
				if( j < (c_start - LCD_COLS) ) max_pos = i;
			}
			if( cc1[i] < min && channels&0x1 ) {
				min = cc1[i];
				if( j < (c_start - LCD_COLS) ) min_pos = i;
			}
			if( cc2[i] < min && channels&0x2 ) {
				min = cc2[i];
				if( j < (c_start - LCD_COLS) ) min_pos = i;
			}
		}
		
		// Scaling and centering
		//div = ((max-min)/108) + 1; // scale for display and offset for integer rounding
		//center = 0; // center
		center = (max + min)/2;
		// volts in uV per pixel
		if( volts == 0 ) {
			div = ((max-min)/108) + 1; // scale for display and offset for integer rounding
		} else {
			div = volts / 10000; // 
		}
		//div = ((max-min)/108) + 1; // scale for display and offset for integer rounding
		
		// TRIGGERING
		// magic triggering
		if( maxd1 > (max - min)/4 ) {
			start = maxd1_pos;
		} else if( (mind1*-1) > (max - min)/4 ) {
			start = mind1_pos;
		} else {
			start = max_pos;
		}

		while( start < c_end ) start += SAMPLES;
				
		// screen buffer clear
		lcd4_clear();
		
		// FIXME: get a real solution here
		if( count < SAMPLES ) start = 0;
				
		// draw traces to buffer
		for( i=start; i < start + (LCD_COLS-1) && 
				(count == SAMPLES || i<(count-1)); i++ ) {
			int y1, y2;
			
			if( channels & 0x02 ) {
				y1 = 54 - ((cc2[i%SAMPLES]-center)/div); // 38
				y2 = 54 - ((cc2[(i+1)%SAMPLES]-center)/div); // 38
				//y1 = ((cc2[i%SAMPLES]-min)/div); // 38
				//y2 = ((cc2[(i+1)%SAMPLES]-min)/div); // 38
				y1 = y1 > 107 ? 107 : y1;
				y1 = y1 < 0 ? 0 : y1;
				y2 = y2 > 107 ? 107 : y2;
				y2 = y2 < 0 ? 0 : y2;
	
				lcd4_line(i-start, y1, i-start+1, y2, 3);
			}
			
			if( channels & 0x1 ) {
				y1 = 54 - ((cc1[i%SAMPLES]-center)/div); // 38
				y2 = 54 - ((cc1[(i+1)%SAMPLES]-center)/div); // 38
				//y1 = ((cc1[i%SAMPLES]-min)/div); // 38
				//y2 = ((cc1[(i+1)%SAMPLES]-min)/div); // 38
				y1 = y1 > 107 ? 107 : y1;
				y1 = y1 < 0 ? 0 : y1;
				y2 = y2 > 107 ? 107 : y2;
				y2 = y2 < 0 ? 0 : y2;
	
				lcd4_line(i-start, y1, i-start+1, y2, 2);	
			}
		}

		// Blit image to screen
		while( lcd_rx_timeout(0) != -1 ); // clear input fifo
		lcd_tx('D');
		if( lcd_rx_timeout(1000000) != -1 ) {
		//		delay_ms(1);
			for( i=0; i<LCD4_BUFSZ; i++ ) {
				lcd_tx(lcd4_buf[i]);
			}
			lcd_rx_timeout(1000000);
			frames++;
		} else {
			for( i=0; i<LCD_BUFSZ; i++) {
				lcd_tx(0);
			}
		}
		
		//SSEG = timebase_i;
		switch(select) {
		case 0:
			SSEG = div;
			break;
		case 1:
			SSEG = center;
			break;
		case 2:
			SSEG = min;
			break;
		case 3:
			SSEG = max;
			break;
		case 4:
			SSEG = 0;
			break;
		}
	}
		
	while(1);
}

/*
Microblaze runs as 5-stage pipeline at 50 MIPS
	3+ instruction overhead for interrupt
	unknown overhead for microblaze interrupt handling
	29 instructions in current interrupt
	estimate 40-50 cycles for interrupt processing

A/D convertor sample rates and general scope design:

A/D max sample rate of 1MHz
Max achievable with a 50MHz clock: (2 low + 1 high)x16 + 2 cs
	requires massive amounts of VHDL to implement the data-flow processing
	processor would have to handle 1 sample every 50 instructions
	this _might_ be doable with lots of FSL magic
	
Max sampling rate achievable with SPI peripheral around +190kHz (<200kHz)
	main limitation: SPI clock max = OPB clk / 16
	best clock divider around 263, f = 190.11 kHz
	max sampled signal frequency ~95kHz
	~210/263 instructions for signal/clock processing
		(spend 50/263 ~= 9/50 instructions reading data)
	~39.9 MIPS for signal processing/display
	
50000 = 2^4 * 5^5
		= 100 * 500
		= 125 * 400
		= 250 * 200
		= 263 * 190.114
		
display target: 30fps
	sample buffer should be enough for 1 frame at least
	190114.06 samples per second
	6337.135 samples per frame
	130 pixels wide screen
	
target frequency divisions:
	1,2,5,10,20,50,...50kHz (can't quite make 100kHz)
	this says I should sample at 100kHz (1 sample per 500 ticks)
	this gives lots of processing power for signal processing and display
	100000 samples per second
	if we want 1Hz divisions, we'll need 100000 samples per division
		or play with our sampling rate :(
		looks like we have to play with the sample rate
			target rates: 100kHz, 50kHz, 20kHz, 10kHz, 5kHz, 2kHz, 1kHz, 500Hz, 200Hz
			time divisions: 10us,  20us,  50us, 100us, 200us, 500us, 1ms,  2ms, 5ms
			div = 500 * time div (in micro-seconds)
	division size: 10px maybe? max rate is then 10kHz/div
	
Nyquist was right!
	I actually need to do a LOT better than the nyquist frequency:
		need at least 10 samples/period to distinguish a waveform by eye
	now I really need to run my A/D at full speed
	
A/D DC offset seems consistently around 0x20

Button usage:
	1st button: select parameter
	2nd button: modify parameter (separate selections for up/down)
*/
