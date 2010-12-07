
/*******************************************************************
*
* CAUTION: This file is automatically generated by libgen.
* Version: Xilinx EDK 9.1.02 EDK_J_SP2.4
* DO NOT EDIT.
*
* Copyright (c) 2005 Xilinx, Inc.  All rights reserved. 
* 
* Description: Driver configuration
*
*******************************************************************/

#include "xparameters.h"
#include "xuartlite.h"

/*
* The configuration table for devices
*/

XUartLite_Config XUartLite_ConfigTable[] =
{
	{
		XPAR_RS232_PORT_DEVICE_ID,
		XPAR_RS232_PORT_BASEADDR,
		XPAR_RS232_PORT_BAUDRATE,
		XPAR_RS232_PORT_USE_PARITY,
		XPAR_RS232_PORT_ODD_PARITY,
		XPAR_RS232_PORT_DATA_BITS
	},
	{
		XPAR_LCD_UART_DEVICE_ID,
		XPAR_LCD_UART_BASEADDR,
		XPAR_LCD_UART_BAUDRATE,
		XPAR_LCD_UART_USE_PARITY,
		XPAR_LCD_UART_ODD_PARITY,
		XPAR_LCD_UART_DATA_BITS
	}
};


