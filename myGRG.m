clc;clear;close all;
load data_ZG118 data_ZG118;
data_ZG118(51,1)=(data_ZG118(50,1)+data_ZG118(52,1))/2;
load Rainfall Rainfall;
load Reservoir Reservoir;
%% 信号分解
y_trend = smooth(data_ZG118,12);
y_trend = smooth(y_trend,12);
y_period = data_ZG118 - y_trend;
%% 周期项预测
% 获取周期项影响因子
% a1:当月降雨量；a2:前两月降雨量；a3:当月最大降雨量;b1:库水位高程；b2:当月库水位变化；b3:双月库水位变化；
% c1:当月位移增量；c2:前两月位移增量；c3:前三月位移增量.
a1 = Rainfall;
a2(1)=a1(1)*4/3;
for i = 2:numel(Rainfall)
    a2(i) = a1(i-1) + a1(i);
end
load Rainfallmax a3;
b1 = Reservoir;
b2(1) = 0;
for i = 2:numel(Reservoir)
    b2(i) = b1(i)-b1(i-1);
end
b3(1) = 0;
b3(2) = 0;
for i = 3:numel(Reservoir)
    b3(i) = b1(i)-b1(i-2);
end
c0 = data_ZG118;
c1(1)=0;
for i = 2:numel(data_ZG118)
   c1(i) = c0(i)-c0(i-1);%当月位移增量
end
c2(1)=0;c2(2)=0;
for i = 3:numel(data_ZG118)
   c2(i) = c0(i)-c0(i-2);%双月位移增量
end
c3(1)=0;c3(2)=0;c3(3)=0;
for i = 4:numel(data_ZG118)
   c3(i) = c0(i)-c0(i-3);%双月位移增量
end
y_period_input = [a1';a2;a3';b1';b2;b3;c1;c2;c3];
% x = data_ZG118';
% y = y_period_input';
% com_xy = greyrelation(x,y)
%% 
%在归一化之前要注意因素变化产生的是正影响还是负影响
y=[data_ZG118';y_period_input];%每一行为一项指标，每一列为一年的所有指标
[m,n]=size(y);
y1=mean(y');%对每一项指标求均值
y1=y1';%转置为一列
for i=1:m
    for j=1:n
        y2(i,j)=y(i,j)/y1(i);
    end
end   %均值化变换
for i=2:m
    for j=1:n
        y3(i-1,j)=abs(y2(i,j)-y2((i-1) ,j));
    end
end   %差序列,其中元素均大于0小于1
a=1;b=0;
for i=1:m-1
       for j=1:n
            if(y3(i,j)<=a) 
                a=y3(i,j);%a为最小值
                elseif(y3(i,j)>=b) 
                    b=y3(i,j);%b为最大值
            end
        end
end
for i=1:m-1
    for j=1:n
            y4(i,j)=(a+0.5*b)/(y3(i,j)+0.5*b);
    end
end
y5=sum(y4')/(n-1)
%% 说明输入一个矩阵，给出其第一行和下面每一行的关联性