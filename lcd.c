
#include "lcd.h"
#include "m_map.h"
#include "fsl.h"

const unsigned char FONT6x8[97][8];
void InitLcd(void);

#define WriteSpiCommand(c) putfsl(c, 0)
#define WriteSpiData(d) cputfsl(d, 0)

void lcd_tx(unsigned char x) {
	while(LCD_SR & 0x8);
	LCD_TX = x;
}

signed short lcd_rx() {
	return lcd_rx_timeout(1000000); // hopefully about 1s
}

signed short lcd_rx_timeout(int timeout) {
	int i=0;
	for( i=0; (i<timeout) && !(LCD_SR & 0x1); i++);
	if( LCD_SR & 0x1 ) return LCD_RX;
	else return -1;
}

signed short lcd_rx_notimeout() {
	while( !(LCD_SR & 0x1) );
	return LCD_RX;
}
