#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void)
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



    return 0;
}