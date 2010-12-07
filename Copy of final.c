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

void pwm_setup(unsigned int * timer) {
	timer[1] = (255 << 7) + 1; // base frequency
	timer[5] = 128 << 7; // 50% initial duty cycle
	
	timer[0] = 0x20;
	timer[4] = 0x20;
	timer[4] = 0x396; // 010 1001 0110
	timer[0] = 0x396; // 010 1001 0110
}

void pwm_set(unsigned int * timer, unsigned char pwm) {
	timer[5] = (int)pwm << 7; // duty cycle
}

unsigned short int spi_read() {
	unsigned short int ret = 0;
	int i=0;
	char lo, hi;
	// write data to get a reading
	SPISSR = 0; // select lowest slave
	SPIDTR = 0;
	SPIDTR = 0;
		
	// wait for receive buffer non-empty
	while( (SPISR & RX_EMPTY) );
	// read buffer
	hi = SPIDRR;
	// wait for receive buffer non-empty
	while( (SPISR & RX_EMPTY) );
	// read buffer
	lo = SPIDRR;
	ret = (lo&0xFF) | ((hi&0xFF) << 8);

	SPISSR = 1; // de-select slave
	return ret;
}

#define SAMPLES 1024
// smaples sets center at 0
unsigned short * c1;
unsigned short * c2;
unsigned short * cc1;
unsigned short * cc2;
signed short * d1;
signed short * d2;
volatile unsigned int c_ptr;

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
		
	T3_TCSR0 = T3_TCSR0;
	IAR = ISR;
	
	SPIDTR = 0;
	SPIDTR = 0;		
}

unsigned short int * LCD_buffer;

void * malloc(int sz) {
	static int brk = (int)MEM;
	int ret = brk;
	brk += sz;
	return (void*)ret;
}

// returns statically allocated buffer
// use or copy before calling itoa again
char * itoa(int n) {
	static char buf[12]; // enough for 4,000,000,000 + sign + null
	int i=0;
	int m = 1; //modulus
	if( n < 0 ) {
		n = -n;
		i++;
		buf[0] = '-';
	}
	while( n / m ) m *= 10;
	m /= 10;
	while( m > 0 ) {
		buf[i] = '0' + (n/m);
		i++;
		n %= m;
		m /= 10;
	}	
	buf[i] = 0;
	return buf;
}

int strlen(char * s) {
	int i=-1;
	while(s[++i]);
	return i;
}

void draw(int timebase) {
	char * buf;
	int l;
	LCDb_clear(BLACK, LCD_buffer);
	
	// upper status bar
	LCDb_set_line(0, 9, 159, 9, RED, LCD_buffer);
	//           "                     "
	LCDb_put_str("T: ", 1, 0, SMALL, RED, BLACK, LCD_buffer);
	if( timebase < 1000 ) {
		buf = itoa(timebase);
		l = strlen(buf);
		LCDb_put_str(itoa(timebase), 1 + 6*3, 0, SMALL, RED, BLACK, LCD_buffer);
		LCDb_put_str("us", 1 + 6*(3+l), 0, SMALL, RED, BLACK, LCD_buffer);
	} else if( timebase < 1000000 ) {
		buf = itoa(timebase/1000);
		l = strlen(buf);
		LCDb_put_str(itoa(timebase), 1 + 6*3, 0, SMALL, RED, BLACK, LCD_buffer);
		LCDb_put_str("us", 1 + 6*(3+l), 0, SMALL, RED, BLACK, LCD_buffer);
	} else {
		buf = itoa(timebase/1000000);
		l = strlen(buf);
		LCDb_put_str(itoa(timebase), 1 + 6*3, 0, SMALL, RED, BLACK, LCD_buffer);
		LCDb_put_str("s", 1 + 6*(3+l), 0, SMALL, RED, BLACK, LCD_buffer);
	}
	
	// lower status bar
	LCDb_set_rect(0, 118, 159, 127, 0, RED, LCD_buffer);
	LCDb_set_rect(2, 120, 7, 125, 0, RED, LCD_buffer);
	LCDb_set_rect(9, 120, 14, 125, 0, RED, LCD_buffer);
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
	int i;
	int j;
	unsigned short int spi;
	unsigned short int spi2;
	unsigned char sw;
	unsigned short max;
	unsigned short min;
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
	
	int lcd_on = 1;
	
	// overall scope control parameters
	int timebase = 10; // in 10^-6 sec
	int timebase_table[] = {10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 
	10000, 20000, 50000, 100000, 200000, 500000, 1000000}; // 16 settings
	int timebase_i = 0;

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
	LCD_buffer = malloc(LCD_BUFSZ);
	lcd4_buf = malloc(LCD4_BUFSZ);
	
	// analog capture setup:
	//  gobal initialization
	for( i=0; i < SAMPLES; i++ ) {
		c1[i] = 0;
		c2[i] = 0;
	}
	c_ptr = 0;
	
	for( i=0; i < LCD_BUFSZ; i++ ) {
		LCD_buffer[i] = GREEN;
	}

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

	
	pwm_setup(TIMER_0); // red
	pwm_setup(TIMER_1); // blue
	pwm_setup(TIMER_2); // green
	
	// proper settings for white-ish light
	pwm_set(TIMER_0, 0xEE); // little red
	pwm_set(TIMER_1, 0xE0); // slightly more blue
	pwm_set(TIMER_2, 0x00); // lots of green
	
	LED = 0;
	
	//InitLcd();
	GPIO = 0; // reset low
	delay_ms(1);
	GPIO = 1; // reset high
	delay_ms(300); // wait for display init
	LCD_CR = 0x3; // reset fifos
	LCD_CR = 0x0;
	delay_ms(2000);

	//LCDContrast(0x26); // determined by experiment

	// void LCDSetRect(x0, y0, x1, y1, fill?, color);
	//
	// void LCDPutStr(char *pString, int x, int y, int Size, int fColor, int bColor);
	//
	// void LCDSetLine(int x1, int y1, int x2, int y2, int color);
	//
	// screen is 130x130; this draws a perfect set of borders
	/*LCDSetRect(0, 0, 129, 129, 0, GREEN);
	LCDSetRect(1, 1, 128, 128, 0, BLUE);
	LCDSetRect(2, 2, 127, 127, 0, RED);*/
	
	// crazy contrast pattern
	/*LCDSetRect(0, 0, 129, 129, 1, GREEN);
	LCDSetRect(10, 20, 109, 109, 1, BLUE);
	LCDSetRect(40, 40, 89, 89, 1, RED);
	LCDSetRect(60, 60, 69, 69, 1, BLACK);
	LCDPutStr("Hello World this is a", 0, 1, SMALL, BLACK, GREEN);
	LCDPutStr("This is anothert", 11, 1, MEDIUM, BLACK, WHITE);
	LCDPutStr("A test for big C", 21, 1, LARGE, BLACK, BLUE);*/
	
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
	//LCDSetRect(0, 0, 9, 129, 0, RED);
	
	//LCD_pen_size(0);
	
	//draw(timebase); // draw background graphics

	//LCD_blit(LCD_buffer);
	SSEG = timebase_i;
	
	btn = BTN;
	btn_old = btn;
	while(lcd_on) {
		btn = BTN;
		btn ^= 0x3; // invert external buttons
		btn &= 0x1C; // mask "external" buttons
		//LED = SW;
		
		if( btn != btn_old ) {
			// handle button pushes here
			//unsigned char press = btn & ~btn_old;
			//unsigned char release = ~btn & btn_old;
			
			if( btn & 0x04 ) {
				timebase_i++;
				timebase_i %= 16;
				timebase = timebase_table[timebase_i];
				SSEG = timebase_i;
				T3_TLR0  = (50*timebase) - 1; // timer load value (divide by 50000: 100 kHz)
			}
			
			if( btn & 0x10 ) {
				lcd_on = 0;
			}
			
			// done
			btn_old = btn;
		}
		LED = btn;
				
		/*spi = spi_read();
		spi2 = SPI2;*/
		spi  = c1[c_ptr];
		spi2 = c2[c_ptr];
		//SSEG = btn;
		//SSEG = ((spi2 << 8) & 0xFF00) | (spi & 0xFF);
		//SSEG = ((spi2 << 4) & 0xFF00) | (spi >> 4);
		//SSEG = spi2;
		
		// Drawing code here:
		// void LCDSetRect(x0, y0, x1, y1, fill?, color);
		sw = SW;
		/*unsigned char r,g,b;
		r = ((sw & 0xC0) >> 6);
		r = r * 0x05; // 0=>0, 1=>5, 2=>10, 3=>15
		g = ((sw & 0x38) >> 3);
		b = (sw & 0x7);
		// 0=>0, 1=>2, 2=>4, 3=>6, 4=>8, 5=>11, 6=>13, 7=>15
		g = (g*2) + ((g & 0x4) >> 2);
		b = (b*2) + ((b & 0x4) >> 2);*/
		
		// calculate simple auto-scale value
		max = 0;
		min = 0xFFFF;
		maxd1 = 0x8000; // smallest signed short
		maxd1 = 0x8000; // smallest signed short
		mind1 = 0x7FFF; // biggest signed short
		mind2 = 0x7FFF; // biggest signed short
		tmp = 0; // using to keep track of over/under flow
		
		// c_end and c_start define a range of data that should be
		// considered invalid
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
		
		//tmp |= 0x10;
		
		for( j=c_end; j < c_start; j++ ) {
			i = j % SAMPLES;
			// derivative
			d1[i] = cc1[(i+1)%SAMPLES] - cc1[i];
			d2[i] = cc2[(i+1)%SAMPLES] - cc2[i];
			
			// find maximum derivative
			if( d1[i] > maxd1 ) {
				maxd1 = d1[i];
				if( j < (c_start - LCD_COLS) ) maxd1_pos = i;
			}
			if( d2[i] > maxd2 ) {
				maxd2 = d2[i];
				if( j < (c_start - LCD_COLS) ) maxd2_pos = i;
			}
			// find min derivative
			if( d1[i] > mind1 ) {
				mind1 = d1[i];
				if( j < (c_start - LCD_COLS) ) mind1_pos = i;
			}
			if( d2[i] > mind2 ) {
				mind2 = d2[i];
				if( j < (c_start - LCD_COLS) ) mind2_pos = i;
			}
			
			// min/max
			if( cc1[i] > max ) {
				max = cc1[i];
				// limit valid start points to those that leave valid data
				if( j < (c_start - LCD_COLS) ) max_pos = i;
			}
			if( cc2[i] > max ) {
				max = cc2[i];
				// limit valid start points
				if( j < (c_start - LCD_COLS) ) max_pos = i;
			}
			if( cc1[i] < min ) {
				min = cc1[i];
				if( j < (c_start - LCD_COLS) ) min_pos = i;
			}
			if( cc2[i] < min ) {
				min = cc2[i];
				if( j < (c_start - LCD_COLS) ) min_pos = i;
			}
		}
		div = (max/108) + 1; // scale for display and offset for integer rounding
		//if( max == 0 ) max = 1;
		// magic triggering
		if( maxd1 > (max - min)/4 ) {
			start = maxd1_pos;
		} else if( (mind1*-1) > (max - min)/4 ) {
			start = mind1_pos;
		} else {
			start = max_pos;
		}

		while( start < c_end ) start += SAMPLES;
				
		//draw(timebase);
		//LCD_draw_rect(0, 10, 159, 117, BLACK);
		//LCDb_set_rect(10, 0, 119, 129, 1, BLACK, LCD_buffer);
		
		lcd4_clear();
				
		//LCD_draw_line(0, 10, 0, 117, BLACK);
		for( i=start; i < start + (LCD_COLS-1); i++ ) {
//		for( i=start; i < start + LCD_COLS; i++ ) {
			int y1, y2;
			
			//delay_us(400);
			
			//LCD_draw_line(i-start+1, 10, i-start+1, 117, BLACK);
			
			y1 = 117 - (cc1[i%SAMPLES]/div); // 38
			y2 = 117 - (cc1[(i+1)%SAMPLES]/div); // 38
			y1 = y1 > 119 ? 119 : y1;
			y1 = y1 < 10 ? 10 : y1;
			y2 = y2 > 119 ? 119 : y2;
			y2 = y2 < 10 ? 10 : y2;
			//LCDb_set_pixel(x, i-start, YELLOW, LCD_buffer);
			//LCDb_set_line(i-start, y1, i-start+1, y2, YELLOW, LCD_buffer);
			//LCD_draw_line(i-start, y1, i-start+1, y2, YELLOW);

			lcd4_line(i-start, y1-10, i-start+1, y2-10, 2);
//			lcd4_line(i-start, 54, i-start+1, 54, 2);
			
			//lcd_tx(y1);
			//LCD_put_pixel(i-start, y1, YELLOW);
			
			//x = 117 - (cc2[i%SAMPLES]/div); // 38
			y1 = 117 - (cc2[i%SAMPLES]/div); // 38
			y2 = 117 - (cc2[(i+1)%SAMPLES]/div); // 38
			y1 = y1 > 119 ? 119 : y1;
			y1 = y1 < 10 ? 10 : y1;
			y2 = y2 > 119 ? 119 : y2;
			y2 = y2 < 10 ? 10 : y2;
			//LCDb_set_pixel(x, i-start, YELLOW, LCD_buffer);
			//LCDb_set_line(i-start, y1, i-start+1, y2, GREEN, LCD_buffer);
			//LCD_draw_line(i-start, y1, i-start+1, y2, GREEN);

			lcd4_line(i-start, y1-10, i-start+1, y2-10, 3);
			
			//LCD_put_pixel(i-start, y1, GREEN);
			
			//LCDb_set_pixel(x, i-start, GREEN,  LCD_buffer);
		}
		//lcd4_line(0,2,159,105,2);
		while( lcd_rx_timeout(0) != -1 ); // clear input fifo
		lcd_tx('D');
		lcd_rx_timeout(1000);
		delay_ms(1);
		for( i=0; i<LCD4_BUFSZ; i++ ) {
			//delay_us(22); // 11 bit-times
			lcd_tx(lcd4_buf[i]);
		}
		lcd_rx_timeout(1000);
		
		//SSEG = min;
		//delay_ms(30);
		//LCD_blit(LCD_buffer);
	}
	
	//LCD_off();
	
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
