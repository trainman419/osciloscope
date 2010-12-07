/* $Id: xspi_sinit.c,v 1.1 2006/02/17 21:21:36 moleres Exp $ */
/******************************************************************************
*
*       XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
*       AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
*       SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
*       OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
*       APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
*       THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
*       AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
*       FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
*       WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
*       IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
*       REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
*       INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
*       FOR A PARTICULAR PURPOSE.
*
*       (c) Copyright 2005 Xilinx Inc.
*       All rights reserved.
*
******************************************************************************/
/*****************************************************************************/
/**
*
* @file xspi_sinit.c
*
* The implementation of the XSpi component's static initialzation functionality.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -----------------------------------------------
* 1.01a jvb  10/13/05 First release
* </pre>
*
******************************************************************************/

/***************************** Include Files *********************************/

#include "xstatus.h"
#include "xparameters.h"
#include "xspi.h"
#include "xspi_i.h"

/************************** Constant Definitions *****************************/


/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/

/************************** Variable Definitions *****************************/

/*****************************************************************************/
/**
*
* Looks up the device configuration based on the unique device ID. A table
* contains the configuration info for each device in the system.
*
* @param    DeviceId contains the ID of the device to look up the configuration
*           for.
*
* @return
*
* A pointer to the configuration found or XNULL if the specified device ID was
* not found. See xspi.h for the definition of XSpi_Config.
*
* @note
*
* None.
*
******************************************************************************/
XSpi_Config *XSpi_LookupConfig(Xuint16 DeviceId)
{
    XSpi_Config *CfgPtr = XNULL;
    int i;

    for (i=0; i < XPAR_XSPI_NUM_INSTANCES; i++)
    {
        if (XSpi_ConfigTable[i].DeviceId == DeviceId)
        {
            CfgPtr = &XSpi_ConfigTable[i];
            break;
        }
    }

    return CfgPtr;
}

/*****************************************************************************/
/**
*
* Initializes a specific XSpi instance such that the driver is ready to use.
*
* The state of the device after initialization is:
*   - Device is disabled
*   - Slave mode
*   - Active high clock polarity
*   - Clock phase 0
*
* @param    InstancePtr is a pointer to the XSpi instance to be worked on.
* @param    DeviceId is the unique id of the device controlled by this XSpi
*           instance. Passing in a device id associates the generic XSpi
*           instance to a specific device, as chosen by the caller or
*           application developer.
*
* @return
*
* The return value is XST_SUCCESS if successful.  On error, a code indicating
* the specific error is returned.  Possible error codes are:
* - XST_DEVICE_IS_STARTED if the device is started. It must be stopped to
*   re-initialize.
* - XST_DEVICE_NOT_FOUND if the device was not found in the configuration such
*   that initialization could not be accomplished.
*
* @note
*
* None.
*
******************************************************************************/
XStatus XSpi_Initialize(XSpi *InstancePtr, Xuint16 DeviceId)
{
    XSpi_Config *ConfigPtr;   /* Pointer to Configuration ROM data */

    XASSERT_NONVOID(InstancePtr != XNULL);

    /*
     * Lookup the device configuration in the temporary CROM table. Use this
     * configuration info down below when initializing this component.
     */
    ConfigPtr = XSpi_LookupConfig(DeviceId);
    if (ConfigPtr == XNULL)
    {
        return XST_DEVICE_NOT_FOUND;
    }

    return XSpi_CfgInitialize(InstancePtr, ConfigPtr, ConfigPtr->BaseAddress);

}
