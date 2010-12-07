/* $Id: xspi_stats.c,v 1.1 2006/02/17 21:21:36 moleres Exp $ */
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
*       (c) Copyright 2002 Xilinx Inc.
*       All rights reserved.
*
******************************************************************************/
/*****************************************************************************/
/**
*
* @file xspi_stats.c
*
* This component contains the implementation of statistics functions for the
* XSpi driver component.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -----------------------------------------------
* 1.00b jhl  03/14/02 First release
* 1.00b rpm  04/25/02 Changed macro naming convention
* </pre>
*
******************************************************************************/

/***************************** Include Files *********************************/

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
* Gets a copy of the statistics for an SPI device.
*
* @param    InstancePtr is a pointer to the XSpi instance to be worked on.
* @param    StatsPtr is a pointer to a XSpi_Stats structure which will get a
*           copy of current statistics.
*
* @return
*
* None.
*
* @note
*
* None.
*
******************************************************************************/
void XSpi_GetStats(XSpi *InstancePtr, XSpi_Stats *StatsPtr)
{
    XASSERT_VOID(InstancePtr != XNULL);
    XASSERT_VOID(StatsPtr != XNULL);
    XASSERT_VOID(InstancePtr->IsReady == XCOMPONENT_IS_READY);

    StatsPtr->ModeFaults = InstancePtr->Stats.ModeFaults;
    StatsPtr->XmitUnderruns = InstancePtr->Stats.XmitUnderruns;
    StatsPtr->RecvOverruns = InstancePtr->Stats.RecvOverruns;
    StatsPtr->SlaveModeFaults = InstancePtr->Stats.SlaveModeFaults;
    StatsPtr->BytesTransferred = InstancePtr->Stats.BytesTransferred;
    StatsPtr->NumInterrupts = InstancePtr->Stats.NumInterrupts;
}

/*****************************************************************************/
/**
*
* Clears the statistics for the SPI device.
*
* @param    InstancePtr is a pointer to the XSpi instance to be worked on.
*
* @return
*
* None.
*
* @note
*
* None.
*
******************************************************************************/
void XSpi_ClearStats(XSpi *InstancePtr)
{
    XASSERT_VOID(InstancePtr != XNULL);
    XASSERT_VOID(InstancePtr->IsReady == XCOMPONENT_IS_READY);

    XSpi_mClearStats(InstancePtr);
}
