clc;clear;close all;
load data_ZG118 data_ZG118;
data_ZG118(51,1)=(data_ZG118(50,1)+data_ZG118(52,1))/2;
load Rainfall Rainfall;
load Reservoir Reservoir;
%% �źŷֽ�
y_trend = smooth(data_ZG118,12);
y_trend = smooth(y_trend,12);
y_period = data_ZG118 - y_trend;
%% ������Ԥ��
% ��ȡ������Ӱ������
% a1:���½�������a2:ǰ���½�������a3:�����������;b1:��ˮλ�̣߳�b2:���¿�ˮλ�仯��b3:˫�¿�ˮλ�仯��
% c1:����λ��������c2:ǰ����λ��������c3:ǰ����λ������.
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
   c1(i) = c0(i)-c0(i-1);%����λ������
end
c2(1)=0;c2(2)=0;
for i = 3:numel(data_ZG118)
   c2(i) = c0(i)-c0(i-2);%˫��λ������
end
c3(1)=0;c3(2)=0;c3(3)=0;
for i = 4:numel(data_ZG118)
   c3(i) = c0(i)-c0(i-3);%˫��λ������
end
y_period_input = [a1';a2;a3';b1';b2;b3;c1;c2;c3];
% x = data_ZG118';
% y = y_period_input';
% com_xy = greyrelation(x,y)
%% 
%�ڹ�һ��֮ǰҪע�����ر仯����������Ӱ�컹�Ǹ�Ӱ��
y=[data_ZG118';y_period_input];%ÿһ��Ϊһ��ָ�꣬ÿһ��Ϊһ�������ָ��
[m,n]=size(y);
y1=mean(y');%��ÿһ��ָ�����ֵ
y1=y1';%ת��Ϊһ��
for i=1:m
    for j=1:n
        y2(i,j)=y(i,j)/y1(i);
    end
end   %��ֵ���任
for i=2:m
    for j=1:n
        y3(i-1,j)=abs(y2(i,j)-y2((i-1) ,j));
    end
end   %������,����Ԫ�ؾ�����0С��1
a=1;b=0;
for i=1:m-1
       for j=1:n
            if(y3(i,j)<=a) 
                a=y3(i,j);%aΪ��Сֵ
                elseif(y3(i,j)>=b) 
                    b=y3(i,j);%bΪ���ֵ
            end
        end
end
for i=1:m-1
    for j=1:n
            y4(i,j)=(a+0.5*b)/(y3(i,j)+0.5*b);
    end
end
y5=sum(y4')/(n-1)
%% ˵������һ�����󣬸������һ�к�����ÿһ�еĹ�����