% MACD_Calculations
clear          % clear all variables 
close all	   % close all figures 
clc			   % clear the screen 

%% Loading the Stock data 
Data = load('file.csv')*10000;
close_price = round(Data(:,1)); 			% First column is close price
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
			EMA12(i)=(Sum/12);   	% EMA12 = SMA 
	elseif (i>12)
			EMA12(i)= ((close_price(i)*K1)+(EMA12(i-1)*(1-K1)));   % EMA12
    else
        EMA12(i)=0;  % First 12 values equal to 0
    end;
end;

%% Calculating the value of EMA26
Sum=0;
for i = 1:length_file      
    Sum=close_price(i)+Sum;
    if (i==26)
			EMA26(i)=(Sum/26);   	% EMA26 = SMA 
	elseif (i>26)
			EMA26(i)= ((close_price(i)*K2)+(EMA26(i-1)*(1-K2)));   % EMA26
			
    else
        EMA26(i)=0;  % First 25 values equal to 0
    end;
end;

%% Calculating MACD
for i = 26:length_file    
	MACD(i) = EMA12(i)-EMA26(i);
end;
%MACD=MACD+25;
%% Calculating the value of EMA9
Sum=0;
for i = 26:length_file      
    Sum=MACD(i)+Sum;
    if (i==34)
		MACD_SIGNAL(i)=(Sum/9);   	% MACD_SIGNAL = EMA9 of MACD
	elseif (i>34)
		MACD_SIGNAL(i)= ((MACD(i)*K3)+(MACD_SIGNAL(i-1)*(1-K3)));   % MACD_SIGNAL
    else
        MACD_SIGNAL(i)=0;  % Previous 25 values equal to 0 from 1 to 25
    end;
end;

% Plotting the MACD and MACD_SIGNAL 
plot(MACD, 'r','linewidth',2);
hold on;
plot(MACD_SIGNAL, 'g','linewidth',2);
hold off;
grid on;


