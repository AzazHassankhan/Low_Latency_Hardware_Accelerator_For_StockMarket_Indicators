% MACD_Calculations
clear          % clear all variables 
close all	   % close all figures 
clc			   % clear the screen 

%% Loading the Stock Data_orignal 
Data_orignal = load('file.csv')*100000;
Data_Vivado = load('MACD_data.csv');

close_price = fix(Data_orignal(:,1));	% First column is close price 
column_l = (Data_Vivado(:,1));	
column_2 = (Data_Vivado(:,2));	

length_file = length(close_price);  % find the length of close_price

N1=12; K1=2/(N1+1);   % Use for EMA12
N2=26; K2=2/(N2+1);   % Use for EMA26
N3=9; K3=2/(N3+1);	  % Use for EMA9

EMA12=[];            % Creating Array for EMA12
EMA26=[];	   		 % Creating Array for EMA26
MACD_SIGNAL=[]; 	 % Creating Array for MACD_SIGNAL
MACD=[];		  	 % Creating Array for MACD

%% Calculating the value of EMA12
% EMA = Closing price x multiplier + EMA (previous day) x (1-multiplier)
Sum=0;
for i = 1:length_file      
    Sum=close_price(i)+Sum;
    if (i==12)
		EMA12(i)= fix(Sum/12);   	% EMA12 = SMA 
	elseif (i>12)
		EMA12(i) = ((close_price(i)*2)+(EMA12(i-1)*(11)));   % EMA12
        EMA12(i) = fix(EMA12(i)/13);
    else
        EMA12(i)=0;  % First 12 values equal to 0
    end;
end;

%% Calculating the value of EMA26
Sum=0;
for i = 1:length_file      
    Sum=close_price(i)+Sum;
    if (i==26)
		EMA26(i)= fix(Sum/26);   	% EMA26 = SMA 
	elseif (i>26)
		EMA26(i)= ((close_price(i)*2)+(EMA26(i-1)*(25)));   % EMA26
        EMA26(i) = fix(EMA26(i)/27);
    else
        EMA26(i)=0;  % First 25 values equal to 0
    end;
end;

%% Calculating MACD
for i = 26:length_file    
	MACD(i) = EMA12(i)-EMA26(i);
end;
%% Adding DC Offset to MACD
    MACD = MACD +250;
%% Calculating the value of EMA9
Sum=0;
for i = 26:length_file      
    Sum=MACD(i)+Sum;
    if (i==34)
		MACD_SIGNAL(i)= fix(Sum/9);   	% MACD_SIGNAL = EMA9 of MACD
	elseif (i>34)
		MACD_SIGNAL(i)= ((MACD(i)*2)+(MACD_SIGNAL(i-1)*(8)));   % MACD_SIGNAL
        MACD_SIGNAL(i) = fix(MACD_SIGNAL(i)/10);
    else
        MACD_SIGNAL(i)=0;  % Previous 25 values equal to 0 from 1 to 25
    end;
end;

position_buy = 1;
position_sell = 1;
buy = [];
sell = [];

for i = 34 : length_file
   if ((MACD(i)> MACD_SIGNAL(i)) && position_buy == 1)
       buy(i)= MACD(i);
       position_sell = 1;
       position_buy = 0;
   elseif ((MACD(i)< MACD_SIGNAL(i)) && position_sell == 1)
       sell(i) = MACD(i);
       position_sell = 0;
       position_buy = 1;
   end;
end;

% plot (buy,'o');
% hold on;
% plot (sell, '*');

% Plotting the MACD and MACD_SIGNAL 
plot(MACD, 'r');
hold on;
plot(MACD_SIGNAL, 'b');
plot(column_l, 'r');
plot(column_2, 'b');
hold off;
grid on;




