/*
 * Aroon.c
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
        init_platform();
    int Low_prices[200] = {135616 ,
135635 ,
135624 ,
135612 ,
135610 ,
135606 ,
135583 ,
135571 ,
135533 ,
135513 ,
135514 ,
135534 ,
135554 ,
135574 ,
135594 ,
135615 ,
135632 ,
135566 ,
135503 ,
135495 ,
135494 ,
135484 ,
135476 ,
135495 ,
135540 ,
135584 ,
135585 ,
135596 ,
135607 ,
135621 ,
135591 ,
135581 ,
135565 ,
135550 ,
135568 ,
135583 ,
135583 ,
135593 ,
135590 ,
135585 ,
135593 ,
135591 ,
135592 ,
135553 ,
135554 ,
135562 ,
135555 ,
135541 ,
135565 ,
135592 ,
135617 ,
135634 ,
135626 ,
135643 ,
135647 ,
135663 ,
135655 ,
135639 ,
135648 ,
135638 ,
135659 ,
135675 ,
135683 ,
135683 ,
135692 ,
135759 ,
135755 ,
135766 ,
135768 ,
135782 ,
135779 ,
135765 ,
135761 ,
135754 ,
135762 ,
135754 ,
135734 ,
135733 ,
135683 ,
135681 ,
135674 ,
135646 ,
135640 ,
135659 ,
135666 ,
135654 ,
135702 ,
135676 ,
135674 ,
135696 ,
135596 ,
135611 ,
135605 ,
135616 ,
135629 ,
135635 ,
135620 ,
135638 ,
135705 ,
135655 ,
135626 ,
135603 ,
135619 ,
135624 ,
135588 ,
135566 ,
135584 ,
135589 ,
135631 ,
135606 ,
135649 ,
135794 ,
135853 ,
135857 ,
135913 ,
135955 ,
135936 ,
135934 ,
135956 ,
135992 ,
135973 ,
135907 ,
135917 ,
135922 ,
135946 ,
135913 ,
135926 ,
135928 ,
135926 ,
135916 ,
135899 ,
135875 ,
135865 ,
135845 ,
135823 ,
135804 ,
135840 ,
135816 ,
135808 ,
135808 ,
135819 ,
135767 ,
135780 ,
135686 ,
135659 ,
135667 ,
135640 ,
135645 ,
135665 ,
135719 ,
135577 ,
135574 ,
135613 ,
135578 ,
135587 ,
135595 ,
135609 ,
135588 ,
135571 ,
135540 ,
135534 ,
135536 ,
135579 ,
135526 ,
135447 ,
135527 ,
135537 ,
135551 ,
135562 ,
135550 ,
135461 ,
135448 ,
135518 ,
135514 ,
135540 ,
135557 ,
135634 ,
135627 ,
135560 ,
135515 ,
135398 ,
135339 ,
135322 ,
135290 ,
135299 ,
135313 ,
135315 ,
135361 ,
135359 ,
135318 ,
135391 ,
135456 ,
135421 ,
135341 ,
135238 ,
135250 ,
135260 ,
135239 ,
135279 		
},High_prices[200] = {135668 ,
135669 ,
135636 ,
135635 ,
135620 ,
135618 ,
135614 ,
135586 ,
135573 ,
135544 ,
135535 ,
135571 ,
135586 ,
135609 ,
135622 ,
135644 ,
135648 ,
135644 ,
135573 ,
135527 ,
135520 ,
135506 ,
135505 ,
135545 ,
135647 ,
135639 ,
135625 ,
135616 ,
135641 ,
135642 ,
135631 ,
135612 ,
135591 ,
135575 ,
135602 ,
135609 ,
135612 ,
135642 ,
135658 ,
135626 ,
135634 ,
135617 ,
135623 ,
135602 ,
135574 ,
135598 ,
135572 ,
135573 ,
135603 ,
135623 ,
135643 ,
135654 ,
135647 ,
135656 ,
135666 ,
135675 ,
135678 ,
135666 ,
135678 ,
135676 ,
135675 ,
135693 ,
135692 ,
135693 ,
135765 ,
135766 ,
135773 ,
135787 ,
135784 ,
135819 ,
135810 ,
135798 ,
135784 ,
135776 ,
135791 ,
135792 ,
135769 ,
135780 ,
135761 ,
135706 ,
135695 ,
135701 ,
135665 ,
135684 ,
135721 ,
135741 ,
135773 ,
135724 ,
135753 ,
135741 ,
135718 ,
135658 ,
135653 ,
135666 ,
135662 ,
135670 ,
135670 ,
135739 ,
135787 ,
135710 ,
135687 ,
135655 ,
135686 ,
135715 ,
135647 ,
135652 ,
135645 ,
135668 ,
135669 ,
135648 ,
135844 ,
135898 ,
135890 ,
135965 ,
135986 ,
135981 ,
135994 ,
136005 ,
135998 ,
136071 ,
136009 ,
136003 ,
135962 ,
135965 ,
135985 ,
135967 ,
135969 ,
135965 ,
135956 ,
135948 ,
135946 ,
135919 ,
135907 ,
135877 ,
135861 ,
135857 ,
135870 ,
135865 ,
135848 ,
135850 ,
135889 ,
135825 ,
135819 ,
135784 ,
135716 ,
135696 ,
135689 ,
135715 ,
135718 ,
135748 ,
135728 ,
135627 ,
135656 ,
135628 ,
135638 ,
135635 ,
135643 ,
135644 ,
135606 ,
135610 ,
135571 ,
135618 ,
135659 ,
135612 ,
135598 ,
135615 ,
135604 ,
135592 ,
135639 ,
135633 ,
135554 ,
135533 ,
135573 ,
135561 ,
135597 ,
135658 ,
135676 ,
135699 ,
135655 ,
135607 ,
135571 ,
135452 ,
135368 ,
135397 ,
135351 ,
135376 ,
135388 ,
135400 ,
135420 ,
135397 ,
135507 ,
135510 ,
135529 ,
135436 ,
135372 ,
135320 ,
135325 ,
135307 ,
135393 	
},gain[200]={0},loss[200]={0},difference[200]={0},Average_gain[200],Average_loss[200],period[200]={0},period1[200],aroon_up[200]={0},aroon_down[200]={0},buy[200]={0},sell [200]={0};



    int i = 0, Count=0,Count1=0,Frame_size=14,Previous_High,Previous_Low;
 
    for (int i = 0; i<185; i++)        
      {Previous_High =High_prices[i];
      for (int j = i+1; j<=i+Frame_size; j++) 
           {if  ((High_prices[j]) > Previous_High) 
                {Previous_High=High_prices[j];
                Count=0;}
            else
                {Count=Count+1;}
            
            if (j == i+Frame_size)
             {period[j]=Count;
             aroon_up[j]= ((14-period[j])*100)/14;
             Count=0;
            }    
      }
   }
    for (int i = 0; i<185; i++)        
      {Previous_Low =Low_prices[i];
      for (int j = i+1; j<=i+Frame_size; j++) 
           {if  ((Low_prices[j]) < Previous_Low) 
                {Previous_Low=Low_prices[j];
                Count1=0;}
            else
                {Count1=Count1+1;}
            
            if (j == i+Frame_size)
             {period1[j]=Count1;
             aroon_down[j]= ((14-period1[j])*100)/14;
             Count1=0;
             }    
      }
   }


for (int i = 0; i<185; i++) 
   {if (aroon_up[i]> aroon_down[i]     && aroon_up[i-1]<= aroon_down[i-1] ) 
       {buy[i]= aroon_up[i];
       printf("%d Buy.\n", buy[i]);}
   else if (aroon_up[i]< aroon_down[i] && aroon_up[i-1]>= aroon_down[i-1] )
      { sell[i] = aroon_down[i];
        printf("%d Sell.\n", sell[i]);}
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