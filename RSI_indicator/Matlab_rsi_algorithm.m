clear all
close all
clc

Data = load ('file.csv')*1000000;                     % Loading the Data
Data_1 = load ('file.csv');
Data_2 = load ('Hardware.csv');

Data = fix(Data(:,1));	% First column is close price 
length_file = length(Data);                   % Length of File

length_file1 = length(Data_2);                   % Length of File
% Arrays for gain,loss and difference variables
difference=[];                                 
gain = [];
loss = [];

for i= 2:length_file                 % Loop to calculate gain and loss
    difference(i) = Data(i)- Data(i-1);
    if difference(i) > 0
        gain(i) = difference(i);
        loss(i) = 0;
    
    elseif difference(i) < 0
        gain(i) = 0;
        loss(i) = abs(difference(i));
    else 
        gain(i)=0;
        loss(i)=0;
    end;
end;

Average_gain = [];
Average_loss = [];
sum_gain = 0;
sum_loss = 0;
RS = [];
RSI = [];

for i= 1:length_file                     
	sum_gain = sum_gain + gain(i);
	sum_loss = sum_loss + loss(i);
	if (i==15)
        SUM_GAIN=sum_gain
        SUM_LOSS=sum_loss
	Average_gain(i) = fix(sum_gain/14);
	Average_loss(i) = fix(sum_loss/14);
    RS (i) = fix(((Average_gain(i)*100)/Average_loss(i)));
    RSI(i) = (100-fix(10000/(100+RS(i))));

	elseif (i>15)
        
    Average_gain(i) = fix((((Average_gain(i-1))*13)+gain(i))/14);
	Average_loss(i) = fix(((Average_loss(i-1)*13)+loss(i))/14);
    RS (i) =fix((((Average_gain(i)*100)+1)/(Average_loss(i)+1)));
    RSI(i) = (100-fix(10000/(100+RS(i))));

	end;
end;


Average_gain_1 = [];
Average_loss_1 = [];
sum_gain_1 = 0;
sum_loss_1 = 0;
RS_1 = [];
RSI_1= [];
difference_1=[];                                 
gain_1 = [];
loss_1 = [];

for i= 2:length_file                 % Loop to calculate gain and loss
    difference_1(i) = Data_1(i)- Data_1(i-1);
    if difference(i) > 0
        gain_1(i) = difference_1(i);
        loss_1(i) = 0;
    
    elseif difference_1(i) < 0
        gain_1(i) = 0;
        loss_1(i) = abs(difference_1(i));
    else 
        gain_1(i)=0;
        loss_1(i)=0;
    end;
end;
for i= 1:length_file                     
	sum_gain_1 = sum_gain_1 + gain_1(i);
	sum_loss_1 = sum_loss_1 + loss_1(i);
	if (i==15)
	Average_gain_1(i) = (sum_gain_1/14);
	Average_loss_1(i) = (sum_loss_1/14);
    RS_1 (i) =Average_gain_1(i)/Average_loss_1(i);
    RSI_1(i) = 100-(100/(1+RS_1(i)));

	elseif (i>15)
    Average_gain_1(i) = ((((Average_gain_1(i-1))*13)+gain_1(i))/14);
	Average_loss_1(i) = (((Average_loss_1(i-1)*13)+loss_1(i))/14);
    RS_1 (i) =Average_gain_1(i)/Average_loss_1(i);
    RSI_1(i) = 100-(100/(1+RS_1(i)));

	end;
end;


buy = [];
sell = [];

for i = 16 : length_file
   if (RSI(i-1)>= 30 && RSI(i) <30 ) 
       buy(i)= RSI(i);
   elseif ((RSI(i-1) <= 70 && RSI(i) >70 )  )
       sell(i) = RSI(i);
 end;
 end;
 buy1= [];
sell1 = [];
for i = 16 : length_file1
   if (Data_2(i-1)>= 30 && Data_2(i) <30 ) 
       buy1(i)= Data_2(i);
   elseif ((Data_2(i-1) <= 70 && Data_2(i) >70 )  )
       sell1(i) = Data_2(i);

   end;
end;
 buy2= [];
sell2 = [];
for i = 16 : length_file
   if (Data_1(i-1)>= 30 && Data_1(i) <30 ) 
       buy2(i)= Data_1(i);
   elseif ((Data_1(i-1) <= 70 && Data_1(i) >70 )  )
       sell2(i) = Data_1(i);
 end;
end;
       


plot(RSI,'r')
hold on;
plot(RSI_1)
hold on;
plot(Data_2,'g')
hold on;
plot (buy,'o');
hold on;
plot (sell, '*');
hold on;
plot (buy1,'o','MarkerEdgeColor','red');
hold on;
plot (sell1,'*','MarkerEdgeColor','red');
hold on;
plot (buy2,'o','MarkerEdgeColor','red');
hold on;
plot (sell2,'*','MarkerEdgeColor','red');
legend('Matlab','Python','Hardware','buy','Sell')
