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


void InitLcd(void);
void LCD_off();
void LCDClearScreen(unsigned short int color);

#define LCDb_set_pixel(x, y, color, b) b[((y) * LCD_COLS) + (x)] = color

void LCDb_set_line(int x0, int y0, int x1, int y1, int color, 
	unsigned short * b);
void LCDb_set_rect(int x0, int y0, int x1, int y1, unsigned char fill, int color,
	unsigned short * b);
void LCDb_set_circle(int x0, int y0, int radius, int color,
	unsigned short * b);
void LCDb_put_char(char c, int x, int y, int size, int fColor, int bColor,
	unsigned short * b);
void LCDb_put_str(char *pString, int x, int y, int Size, int fColor, int bColor,
	unsigned short * b);
	
void LCD_blit(unsigned short int * buffer);

void LCD_draw_rect(unsigned char x1, unsigned char y1,
						 unsigned char x2, unsigned char y2,
						 unsigned short color);
void LCD_draw_line(unsigned char x1, unsigned char y1,
						 unsigned char x2, unsigned char y2,
						 unsigned short color);
void LCD_put_pixel(unsigned char x, unsigned char y, unsigned short color);
void LCD_pen_size(unsigned char s);

void lcd_tx(unsigned char b);

// returns char or -1 on timeout
short int lcd_rx();
short int lcd_rx_timeout(int timeout);


//#ifdef EPSON
// Epson display controller codes
#define DISON 0xAF // Display on
#define DISOFF 0xAE // Display off
#define DISNOR 0xA6 // Normal display
#define DISINV 0xA7 // Inverse display
#define COMSCN 0xBB // Common scan direction
#define DISCTL 0xCA // Display control
#define SLPIN 0x95 // Sleep in
#define SLPOUT 0x94 // Sleep out
#define PASET 0x75 // Page address set
#define CASET 0x15 // Column address set
#define DATCTL 0xBC // Data scan direction, etc.
#define RGBSET8 0xCE // 256-color position set
#define RAMWR 0x5C // Writing to memory
#define RAMRD 0x5D // Reading from memory
#define PTLIN 0xA8 // Partial display in
#define PTLOUT 0xA9 // Partial display out
#define RMWIN 0xE0 // Read and modify write
#define RMWOUT 0xEE // End
#define ASCSET 0xAA // Area scroll set
#define SCSTART 0xAB // Scroll start set
#define OSCON 0xD1 // Internal oscillation on
#define OSCOFF 0xD2 // Internal oscillation off
#define PWRCTR 0x20 // Power control
#define VOLCTR 0x81 // Electronic volume control
#define VOLUP 0xD6 // Increment electronic control by 1
#define VOLDOWN 0xD7 // Decrement electronic control by 1
#define TMPGRD 0x82 // Temperature gradient set
#define EPCTIN 0xCD // Control EEPROM
#define EPCOUT 0xCC // Cancel EEPROM control
#define EPMWR 0xFC // Write into EEPROM
#define EPMRD 0xFD // Read from EEPROM
#define EPSRRD1 0x7C // Read register 1
#define EPSRRD2 0x7D // Read register 2
#define NOP 0x25 // NOP instruction
#define BKLGHT_LCD_ON 1
#define BKLGHT_LCD_OFF 2
// backlight control
#define BKLGHT_LCD_ON 1
#define BKLGHT_LCD_OFF 2
// Booleans
#define NOFILL 0
#define FILL 1
// 16-bit color definitions
// Format RRRRRGGG GGGBBBBB
#define WHITE		0xFFFF
#define BLACK		0x0000
#define RED			0xF800
#define GREEN		0x07E0
#define BLUE		0x001F
#define CYAN		0x07FF
#define MAGENTA	0xF81F
#define YELLOW		0xFFE0
#define BROWN		0xB22
#define ORANGE		0xFA0
#define PINK		0xF6A

// font sizes
#define SMALL 0
#define MEDIUM 1
#define LARGE 2
// hardware definitions
#define SPI_SR_TXEMPTY
// mask definitions
#define BIT0 0x00000001
#define BIT1 0x00000002
#define BIT2 0x00000004
#define BIT3 0x00000008
#define BIT4 0x00000010
#define BIT5 0x00000020
#define BIT6 0x00000040
#define BIT7 0x00000080
#define BIT8 0x00000100
#define BIT9 0x00000200
#define BIT10 0x00000400
#define BIT11 0x00000800
#define BIT12 0x00001000
#define BIT13 0x00002000
#define BIT14 0x00004000
#define BIT15 0x00008000
#define BIT16 0x00010000
#define BIT17 0x00020000
#define BIT18 0x00040000
#define BIT19 0x00080000
#define BIT20 0x00100000
#define BIT21 0x00200000
#define BIT22 0x00400000
#define BIT23 0x00800000
#define BIT24 0x01000000
#define BIT25 0x02000000
#define BIT26 0x04000000
#define BIT27 0x08000000
#define BIT28 0x10000000
#define BIT29 0x20000000
#define BIT30 0x40000000
#define BIT31 0x80000000
//#endif // EPSON


#endif // Lcd_h
