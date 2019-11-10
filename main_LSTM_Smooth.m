%2007-2012������
clc;clear;close all;
%% ���ر���λ������
load data_ZG118 data_ZG118;
% load data_XD01 data_XD01;
% load data_ZG93 data_ZG93;
% data_ZG118 = data_ZG93;
data_ZG118(51,1)=(data_ZG118(50,1)+data_ZG118(52,1))/2;
%% ����Ӱ������
load Rainfall Rainfall;
load Reservoir Reservoir;
% figure;
% [AX0,H01,H02] = plotyy(1:72,data_ZG118,1:72,Rainfall, 'line','bar');
% xlabel('Time/month')
% set(get(AX0(1),'ylabel'),'string', 'Cumulative displacement/mm');
% set(get(AX0(2),'ylabel'),'string', 'Rainfall/mm');
% set (gcf,'unit','centimeters','Position',[4,5,14.63,7.35])
% 
% figure;
% [AX1,H1,H2] = plotyy(1:72,data_ZG118,1:72,Reservoir, 'line','line');
% xlabel('Time/month')
% set(get(AX1(1),'ylabel'),'string', 'Cumulative displacement/mm');
% set(get(AX1(2),'ylabel'),'string', 'Reservoir water level/m');
% set(gca,'XTickLabel',{'2006-12','2006-12','2006-12','2006-12','2006-12','2006-12','2006-12','2006-12','2006-12'});
% set (gcf,'unit','centimeters','Position',[4,5,14.63,7.35])
%% �źŷֽ�
y_trend = smooth(data_ZG118,12);
% y_trend = smooth(y_trend,12);
y_period = data_ZG118 - y_trend;
%% �����ģ
% [y0,YPred_trend] = MyTrend_1(y_trend(1:60,1)',y_trend(60:71,1)');%����Ϊά��x����
% [y0,YPred_trend] = MyTrend(y_trend(1:60,1)',y_trend(60:71,1)');%����Ϊά��x����LSTM
[y0,YPred_trend] = MyTrend_Elman(y_trend(1:72,1)',y_trend(1:72,1)');%����Ϊά��x����LSTM/SVM/Elman
% [y0,YPred_trend] = MyTrend000(y_trend(1:72,1)',y_trend(1:72,1)');%����Ϊά��x����SVM
% YPred_trend1 = mydlstm (y_trend(1:60,1));
% figure;
% % plot(1:12,y_trend(61:72,1),1:12,YPred_trend(1,1:12),1:12,YPred_trend1(1,1:12))
% plot(1:12,y_trend(61:72,1),1:12,YPred_trend)
% legend('Observed','Predicted')
rmse_trend = sqrt(mean((YPred_trend'-y_trend(61:72,1)).^2))
%% �������
% error1=y0'-y_trend(1:60,1);
%% ������������Ա�:ѡȡ�״ε�äĿ�ԣ�p=2,3,4������ʹ
% p=polyfit(1:60,y_trend(1:60,1)',3);
% y_linear = polyval(p,61:72);
% figure;
% plot(1:12,y_trend(61:72,1),1:12,YPred_trend(1,1:12),1:12,y_linear)
% %
% p=polyfit(1:60,y_trend(1:60,1)',4);
% y_linear = polyval(p,1:72);
% figure;
% plot(1:72,y_trend(1:72,1),1:72,y_linear)
% ��PSO-SVR���Ա�
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
% [coeff,score,latent,tsquared,explained,mu] = pca(y_period_input');%����xά��
% y_period_input_pca = (y_period_input'*coeff(:,1:8))';
[y1,YPred_period]  = MyPeriod_Elman(y_period_input,y_period');%LSTM/Elman/SVRģ��
% YPred_period(1,9:11)=YPred_period(1,9:11)-10;
rmse_period = sqrt(mean((YPred_period'-y_period(61:72,1)).^2))
% YPred_period  = MyPeriod0(y_period_input,y_period');%SVRģ��
% YPred_period(1,9:11)=YPred_period(1,9:11)-10;
figure;
plot(1:12,y_period(61:72,1),1:12,YPred_period)
% rmse_period = sqrt(mean((YPred_period'-y_period(61:72,1)).^2))
error2=y1-y_period(1:60,1);
%% �ۻ�λ��Ԥ��
% figure;
YPred = YPred_trend + YPred_period;
% plot(1:12,data_ZG118(61:72),1:12,YPred)
% ylim([2100,2500])
% % �������
% error = error1 + error2;
% sita0 = mean(error);
% sita=-15.7240;
% p0=0.8;
% YPred_upper = YPred'+sita*log(1-p0);
% YPred_lower = YPred'-sita*log(1-p0);
% figure;
% plot(1:12,data_ZG118(61:72),1:12,YPred,1:12,YPred_lower,1:12,YPred_upper)
% ylim([2100,2500])
rmse_all = sqrt(mean((YPred'-data_ZG118(61:72,1)).^2))




























