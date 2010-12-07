/* $Id: xspi_l.h,v 1.1 2006/02/17 21:21:36 moleres Exp $ */
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
* @file xspi_l.h
*
* This header file contains identifiers and low-level driver functions (or
* macros) that can be used to access the device.  High-level driver functions
* are defined in xspi.h.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- -----------------------------------------------
* 1.00b rpm  04/24/02 First release
* </pre>
*
******************************************************************************/

#ifndef XSPI_L_H /* prevent circular inclusions */
#define XSPI_L_H /* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/

#include "xbasic_types.h"
#include "xio.h"

/************************** Constant Definitions *****************************/

/*
 * Offset from the device base address (IPIF) to the IP registers.
 */
#define XSP_REGISTER_OFFSET      0x60

/*
 * Register offsets for the SPI. Each register except the CR & SSR is 8 bits,
 * so add 3 to the word-offset to get the LSB (in a big-endian system).
 */
#define XSP_CR_OFFSET   (XSP_REGISTER_OFFSET + 0x2)      /* 16-bit Control */
#define XSP_SR_OFFSET   (XSP_REGISTER_OFFSET + 0x4 + 3)  /* Status */
#define XSP_DTR_OFFSET  (XSP_REGISTER_OFFSET + 0x8 + 3)  /* Data transmit */
#define XSP_DRR_OFFSET  (XSP_REGISTER_OFFSET + 0xC + 3)  /* Data receive */
#define XSP_SSR_OFFSET  (XSP_REGISTER_OFFSET + 0x10)     /* 32-bit slave select */
#define XSP_TFO_OFFSET  (XSP_REGISTER_OFFSET + 0x14 + 3) /* Transmit FIFO occupancy */
#define XSP_RFO_OFFSET  (XSP_REGISTER_OFFSET + 0x18 + 3) /* Receive FIFO occupancy */

/*
 * SPI Control Register (CR) masks
 */
#define XSP_CR_LOOPBACK_MASK        0x1   /* Local loopback mode */
#define XSP_CR_ENABLE_MASK          0x2   /* System enable */
#define XSP_CR_MASTER_MODE_MASK     0x4   /* Enable master mode */
#define XSP_CR_CLK_POLARITY_MASK    0x8   /* Clock polarity high or low */
#define XSP_CR_CLK_PHASE_MASK      0x10   /* Clock phase 0 or 1 */
#define XSP_CR_TXFIFO_RESET_MASK   0x20   /* Reset transmit FIFO */
#define XSP_CR_RXFIFO_RESET_MASK   0x40   /* Reset receive FIFO */
#define XSP_CR_MANUAL_SS_MASK      0x80   /* Manual slave select assertion */
#define XSP_CR_TRANS_INHIBIT_MASK  0x100  /* Master transaction inhibit */

/*
 * SPI Status Register (SR) masks
 */
#define XSP_SR_RX_EMPTY_MASK        0x1   /* Receive register/FIFO is empty */
#define XSP_SR_RX_FULL_MASK         0x2   /* Receive register/FIFO is full */
#define XSP_SR_TX_EMPTY_MASK        0x4   /* Transmit register/FIFO is empty */
#define XSP_SR_TX_FULL_MASK         0x8   /* Transmit register/FIFO is full */
#define XSP_SR_MODE_FAULT_MASK     0x10   /* Mode fault error */

/*
 * SPI Transmit FIFO Occupancy (TFO) mask. The binary value plus one yields
 * the occupancy.
 */
#define XSP_TFO_MASK        0x1F

/*
 * SPI Receive FIFO Occupancy (RFO) mask. The binary value plus one yields
 * the occupancy.
 */
#define XSP_RFO_MASK        0x1F


/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/


/*****************************************************************************
*
* Low-level driver macros.  The list below provides signatures to help the
* user use the macros.
*
* void XSpi_mSetControlReg(Xuint32 BaseAddress, Xuint16 Mask)
* Xuint16 XSpi_mGetControlReg(Xuint32 BaseAddress)
* Xuint8 XSpi_mGetStatusReg(Xuint32 BaseAddress)
*
* void XSpi_mSetSlaveSelectReg(Xuint32 BaseAddress, Xuint32 Mask)
* Xuint32 XSpi_mGetSlaveSelectReg(Xuint32 BaseAddress)
*
* void XSpi_mEnable(Xuint32 BaseAddress)
* void XSpi_mDisable(Xuint32 BaseAddress)
*
* void XSpi_mSendByte(Xuint32 BaseAddress, Xuint8 Data);
* Xuint8 XSpi_mRecvByte(Xuint32 BaseAddress);
*
*****************************************************************************/

/****************************************************************************/
/**
*
* Set the contents of the control register. Use the XSP_CR_* constants defined
* above to create the bit-mask to be written to the register.
*
* @param    BaseAddress is the base address of the device
* @param    Mask is the 16-bit value to write to the control register
*
* @return   None.
*
* @note     None.
*
*****************************************************************************/
#define XSpi_mSetControlReg(BaseAddress, Mask) \
                    XIo_Out16((BaseAddress) + XSP_CR_OFFSET, (Mask))


/****************************************************************************/
/**
*
* Get the contents of the control register. Use the XSP_CR_* constants defined
* above to interpret the bit-mask returned.
*
* @param    BaseAddress is the  base address of the device
*
* @return   A 16-bit value representing the contents of the control register.
*
* @note     None.
*
*****************************************************************************/
#define XSpi_mGetControlReg(BaseAddress) \
                    XIo_In16((BaseAddress) + XSP_CR_OFFSET)


/****************************************************************************/
/**
*
* Get the contents of the status register. Use the XSP_SR_* constants defined
* above to interpret the bit-mask returned.
*
* @param    BaseAddress is the  base address of the device
*
* @return   An 8-bit value representing the contents of the status register.
*
* @note     None.
*
*****************************************************************************/
#define XSpi_mGetStatusReg(BaseAddress) \
                    XIo_In8((BaseAddress) + XSP_SR_OFFSET)


/****************************************************************************/
/**
*
* Set the contents of the slave select register. Each bit in the mask
* corresponds to a slave select line. Only one slave should be selected at
* any one time.
*
* @param    BaseAddress is the  base address of the device
* @param    Mask is the 32-bit value to write to the slave select register
*
* @return   None.
*
* @note     None.
*
*****************************************************************************/
#define XSpi_mSetSlaveSelectReg(BaseAddress, Mask) \
                    XIo_Out32((BaseAddress) + XSP_SSR_OFFSET, (Mask))


/****************************************************************************/
/**
*
* Get the contents of the slave select register. Each bit in the mask
* corresponds to a slave select line. Only one slave should be selected at
* any one time.
*
* @param    BaseAddress is the  base address of the device
*
* @return   The 32-bit value in the slave select register
*
* @note     None.
*
*****************************************************************************/
#define XSpi_mGetSlaveSelectReg(BaseAddress) \
                    XIo_In32((BaseAddress) + XSP_SSR_OFFSET)

/****************************************************************************/
/**
*
* Enable the device and uninhibit master transactions. Preserves the current
* contents of the control register.
*
* @param    BaseAddress is the  base address of the device
*
* @return   None.
*
* @note     None.
*
*****************************************************************************/
#define XSpi_mEnable(BaseAddress) \
{ \
    Xuint16 Control; \
    Control = XSpi_mGetControlReg((BaseAddress)); \
    Control |= XSP_CR_ENABLE_MASK; \
    Control &= ~XSP_CR_TRANS_INHIBIT_MASK; \
    XSpi_mSetControlReg((BaseAddress), Control); \
}

/****************************************************************************/
/**
*
* Disable the device. Preserves the current contents of the control register.
*
* @param    BaseAddress is the  base address of the device
*
* @return   None.
*
* @note     None.
*
*****************************************************************************/
#define XSpi_mDisable(BaseAddress) \
             XSpi_mSetControlReg((BaseAddress), \
                     XSpi_mGetControlReg((BaseAddress)) & ~XSP_CR_ENABLE_MASK)


/****************************************************************************/
/**
*
* Send one byte to the currently selected slave. The byte that is received
* from the slave is saved in the receive FIFO/register.
*
* @param    BaseAddress is the  base address of the device
*
* @return   None.
*
* @note     None.
*
*****************************************************************************/
#define XSpi_mSendByte(BaseAddress, Data) \
                XIo_Out8((BaseAddress) + XSP_DTR_OFFSET, (Data))


/****************************************************************************/
/**
*
* Receive one byte from the device's receive FIFO/register. It is assumed
* that the byte is already available.
*
* @param    BaseAddress is the  base address of the device
*
* @return   The byte retrieved from the receive FIFO/register.
*
* @note     None.
*
*****************************************************************************/
#define XSpi_mRecvByte(BaseAddress) \
                XIo_In8((BaseAddress) + XSP_DRR_OFFSET)

/************************** Function Prototypes ******************************/

/************************** Variable Definitions *****************************/

#ifdef __cplusplus
}
#endif

#endif            /* end of protection macro */

