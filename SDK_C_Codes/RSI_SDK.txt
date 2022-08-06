/*
 * RSI.c
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
         int Close_prices[200] = {1269640 ,		
1269710,
1270850,
1270710,
1270240,
1269550,
1269400,
1268910,
1268120,
1268680,
1268570,
1268050,
1267940,
1267630,
1267170,
1266930,
1268270,
1268550,
1268980,
1269730,
1269370,
1269990,
1269870,
1270440,
1270010,
1270020,
1270610,
1271850,
1272730,
1272520,
1272360,
1271850,
1272320,
1273170,
1274850,
1274520,
1273680,
1274070,
1272550,
1274980,
1273530,
1270560,
1269560,
1269000,
1269680,
1270390,
1270250,
1269320,
1268430,
1268910,
1268790,
1267800,
1267300,
1266750,
1266860,
1266550,
1267160,
1267470,
1266330,
1266590,
1266070,
1265740,
1265000,
1265390,
1264620,
1264320,
1263300,
1263530,
1263500,
1263680,
1263950,
1263710,
1264020,
1263570,
1262930,
1261810,
1261320,
1261090,
1262000,
1263060,
1262810,
1264250,
1263250,
1264300,
1263240,
1263120,
1264040,
1268190,
1269520,
1268010,
1269410,
1269460,
1268390,
1267760,
1268260,
1269140,
1269240,
1271200,
1271140,
1270610,
1269920,
1269600,
1269410,
1269110,
1269410,
1271260,
1269760,
1270370,
1269960,
1270460,
1269230,
1271840,
1273020,
1272610,
1271380,
1270730,
1270670,
1270050,
1269590,
1269950,
1270310,
1270020,
1269110,
1270140,
1269270,
1270700,
1270580,
1270060,
1270470,
1270500,
1268540,
1268460,
1269370,
1268630,
1267890,
1268340,
1270150,
1272070,
1270630,
1269920,
1270280,
1267840,
1267760,
1267810,
1267880,
1268130,
1267320,
1269840,
1271040,
1271150,
1270220,
1269530,
1269250,
1268790,
1266100,
1265420,
1263790,
1263610,
1261130,
1260710,
1261160,
1260870,
1259550,
1260800,
1261830,
1262140,
1262150,
1261490,
1261200,
1260080,
1259520,
1259210,
1260750,
1260770,
1260230,
1260240,
1260630,
1263800,
1264200,
1263550,
1263050,
1262850,
1262600,
1262480,
1262840,
1261580,
1260650,
1259570,
1260150,
1260210,
1261950,
1261750,
1261060,
1261140,
1260750,
1258680,
1259140,
1259670,
1258620,
1258820},gain[200]={0},loss[200]={0},difference[200]={0},Average_gain[200],Average_loss[200],RS[200],RSI[200],buy[200]={0},sell [200]={0};



    int i = 0, sum_gain = 0,sum_loss = 0;
 
                                            // file close

    // for (i = 0; i<200; i++)
    //    {printf("%d\n", Close_prices[0]);}
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    for (int i = 1; i<200; i++)                  
   { 
    difference[i] = Close_prices[i]- Close_prices[i-1];
    if (difference[i] > 0)
        {gain[i] = difference[i];
        loss[i] = 0;}
    
    else if (difference[i] < 0)
        {gain[i] = 0;
        loss[i] = abs(difference[i]);}
    else 
        {gain[i]=0;
        loss[i]=0;}
       
   }

    ////////////////////////////////////////////////////////////////////////////////////////////////////
 for (int i = 0; i<199; i++)                    
{   sum_gain = sum_gain + gain[i];
	sum_loss = sum_loss + loss[i];
	if (i==14)
    {
	Average_gain[i] = sum_gain/14;
	Average_loss[i] = sum_loss/14;
    RS [i] =  (Average_gain[i]*100)/Average_loss[i];
    RSI[i] = (100-(10000/(100+RS[i])));}
	else if (i>14)
    {Average_gain[i] = (((Average_gain[i-1])*13)+gain[i])/14;
	Average_loss[i] = ((Average_loss[i-1]*13)+loss[i])/14;
    RS [i] =((((Average_gain[i]*100))/(Average_loss[i])));
    RSI[i] = (100-(10000/(100+RS[i])));}
    else
       {RSI[i]=0;
       RS [i]=0;
       Average_loss[i]=0;
       Average_gain[i]=0;}

 }
 for (i = 0; i<199; i++) 
 {  if (RSI[i-1]>= 30 && RSI[i] <30 ) 
       {buy[i]= RSI[i];
        sell[i]=0;
        printf("%d Buy.\n", buy[i]);}
    else if ((RSI[i-1] <= 70 && RSI[i] >70 )  )
       {sell[i] = RSI[i];
        buy[i]=0;
        printf("%d Sell.\n", sell[i]);
        }
    else
          { buy[i]=0;
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