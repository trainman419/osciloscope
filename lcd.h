#ifndef Lcd_h
#define Lcd_h
// *****************************************************************************
// lcd.h
//
// include file for Epson S1D15G00 LCD Controller
//
//
// Author: James P Lynch August 30, 2007
// *****************************************************************************

#define LCD_ROWS 128
#define LCD_COLS 160
#define LCD_BPP 2

#define LCD_BUFSZ (LCD_ROWS * LCD_COLS * LCD_BPP)

void lcd_tx(unsigned char b);

// returns char or -1 on timeout
short int lcd_rx();
short int lcd_rx_timeout(int timeout);

#endif // Lcd_h
