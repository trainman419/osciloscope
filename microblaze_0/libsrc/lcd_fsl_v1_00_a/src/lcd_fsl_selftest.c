//////////////////////////////////////////////////////////////////////////////
// Filename:          C:\edk_user_repository\MyProcessorIPLib\drivers/lcd_fsl_v1_00_a/src/lcd_fsl_selftest.c
// Version:           1.00.a
// Description:       
// Date:              Fri May 21 16:20:21 2010 (by Create and Import Peripheral Wizard)
//////////////////////////////////////////////////////////////////////////////

#include "xparameters.h"
#include "lcd_fsl.h"

/* IMPORTANT:
*  In order to run this self test, you need to modify the value of following
*  micros according to the slot ID defined in xparameters.h file. 
*/
#define input_slot_id   XPAR_FSL_LCD_FSL_0_INPUT_SLOT_ID
XStatus LCD_FSL_SelfTest()
{
	 unsigned int input_0[1];     

	 //Initialize your input data over here: 
	 input_0[0] = 12345;     

	 //Call the macro with instance specific slot IDs
	 lcd_fsl(
		 input_slot_id,
		 input_0    
		 );


	 return XST_SUCCESS;
}
