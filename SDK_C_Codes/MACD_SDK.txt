/*
 * MACD.c
 *
 *  Created on: Jun 10, 2022
 *      Author: Azaz
 */

/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xtime_l.h"
#include <unistd.h>     // for sleep()

int main(void)
{

init_platform();
float cost_time;
    XTime gbl_time_before_test;
    XTime gbl_time_after_test;

    XTime_GetTime(&gbl_time_before_test);
    {
        
    int Close_prices[200] = {126964,
        		126970,
        		127085,
        		127071,
        		127024,
        		126955,
        		126940,
        		126891,
        		126811,
        		126868,
        		126857,
        		126804,
        		126794,
        		126763,
        		126716,
        		126692,
        		126827,
        		126855,
        		126898,
        		126973,
        		126937,
        		126999,
        		126987,
        		127044,
        		127001,
        		127001,
        		127061,
        		127184,
        		127272,
        		127252,
        		127236,
        		127184,
        		127231,
        		127316,
        		127485,
        		127452,
        		127367,
        		127407,
        		127255,
        		127498,
        		127353,
        		127055,
        		126956,
        		126899,
        		126967,
        		127038,
        		127025,
        		126932,
        		126843,
        		126891,
        		126879,
        		126780,
        		126730,
        		126675,
        		126686,
        		126655,
        		126716,
        		126747,
        		126633,
        		126659,
        		126607,
        		126574,
        		126499,
        		126539,
        		126462,
        		126432,
        		126330,
        		126353,
        		126350,
        		126367,
        		126394,
        		126371,
        		126401,
        		126357,
        		126293,
        		126181,
        		126132,
        		126109,
        		126200,
        		126306,
        		126281,
        		126425,
        		126325,
        		126430,
        		126323,
        		126312,
        		126404,
        		126819,
        		126952,
        		126801,
        		126941,
        		126946,
        		126838,
        		126776,
        		126826,
        		126914,
        		126923,
        		127120,
        		127114,
        		127061,
        		126992,
        		126960,
        		126941,
        		126911,
        		126941,
        		127126,
        		126976,
        		127037,
        		126996,
        		127045,
        		126923,
        		127184,
        		127302,
        		127261,
        		127138,
        		127072,
        		127067,
        		127004,
        		126959,
        		126994,
        		127031,
        		127001,
        		126911,
        		127014,
        		126926,
        		127070,
        		127058,
        		127006,
        		127047,
        		127050,
        		126854,
        		126845,
        		126937,
        		126862,
        		126789,
        		126834,
        		127014,
        		127207,
        		127062,
        		126992,
        		127028,
        		126784,
        		126776,
        		126781,
        		126787,
        		126813,
        		126732,
        		126984,
        		127104,
        		127115,
        		127021,
        		126953,
        		126925,
        		126879,
        		126610,
        		126542,
        		126379,
        		126360,
        		126113,
        		126071,
        		126116,
        		126087,
        		125955,
        		126079,
        		126183,
        		126214,
        		126215,
        		126149,
        		126120,
        		126008,
        		125952,
        		125921,
        		126075,
        		126077,
        		126023,
        		126024,
        		126062,
        		126380,
        		126420,
        		126355,
        		126305,
        		126285,
        		126260,
        		126248,
        		126284,
        		126157,
        		126065,
        		125957,
        		126015,
        		126021,
        		126194,
        		126174,
        		126106,
        		126114,
        		126075,
        		125868,
        		125913,
        		125967,
        		125862,
        		125882},EMA12[200],EMA26[200],MACD_SIGNAL[200],MACD[200],buy[200],sell [200];
        int i = 0, Sum=0,position_sell = 1,position_buy = 1;
        float K1=0.1538461538,K2=0.0740740741,K3=0.2;
                                                // file close
        printf("Close_Prices");
        for (i = 0; i<200; i++)
           {printf("%d\n", Close_prices[i]);}
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        for (i = 0; i<200; i++)                                   //EMA12
        {Sum=Close_prices[i]+Sum;
            if (i==11)
                    {EMA12[i]=Sum/12; }
            else if (i>11)
                    {EMA12[i]= ((Close_prices[i]*K1)+(EMA12[i-1]*(1-K1))); }
            else
                {EMA12[i]=0;}
         }
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        Sum=0;
        for (i = 0; i<200; i++)                                    //EMA26
        {Sum=Close_prices[i]+Sum;
            if (i==25)
                    {EMA26[i]=Sum/26;}
            else if (i>25)
                    {EMA26[i]= ((Close_prices[i]*K2)+(EMA26[i-1]*(1-K2)));}
            else
                 {EMA26[i]=0;}
       }
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        for (i = 0; i<200; i++)                                        //MACD
        {
            if (i>24)
              {MACD[i] = EMA12[i]-EMA26[i]+250;}
            else
              {MACD[i]=0;}
        }
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        Sum=0;
        for (i = 0; i<200; i++)                                    //MACD_SIGNAL
        {Sum=MACD[i]+Sum;
            if (i==33)
                    {MACD_SIGNAL[i]=Sum/9; }
            else if (i>33)
                    {MACD_SIGNAL[i]= ((MACD[i]*K3)+(MACD_SIGNAL[i-1]*(1-K3))); }
            else
                {MACD_SIGNAL[i]=0;}
        }
        ////////////////////////////////////////////////////////////////////////////////////////////////////
       for (i = 33; i<200; i++)                                         //Decisions
            {if (MACD[i]> MACD_SIGNAL[i] & position_buy == 1)
                {buy[i]= MACD[i];
                sell[i]=0;
                position_sell = 1;
                position_buy = 0;
                printf("%d Buy.\n", buy[i]);}
            else if (MACD[i]< MACD_SIGNAL[i] & position_sell == 1)
                {sell[i] = MACD[i];
                buy[i]=0;
                position_sell = 0;
                position_buy = 1;
                printf("%d Sell.\n", sell[i]);}
            else
               {buy[i]=0;
               sell[i]=0;
               printf("%d\n", 0);}

            }
    }
    XTime_GetTime(&gbl_time_after_test);
    cost_time = (float) (gbl_time_after_test - gbl_time_before_test)/(COUNTS_PER_SECOND);
    printf("Test time = %.4f secs\r\n", cost_time);

    return 0;
    cleanup_platform();
    return 0;
}