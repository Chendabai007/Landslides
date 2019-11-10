clc;clear;close all;
%% 加载变形位移数据
load data_ZG118 data_ZG118;
% load data_XD01 data_XD01;
% load data_ZG93 data_ZG93;
% data_ZG118 = data_ZG93;
data_ZG118(51,1)=(data_ZG118(50,1)+data_ZG118(52,1))/2;
%% 信号分解
y_trend = smooth(data_ZG118,12);
y_trend = smooth(y_trend,12);
y_period = data_ZG118 - y_trend;
figure;
plot([data_ZG118,y_trend,y_period])
legend('Cumulative displacement','Trend displacement','Periodic displacement')
xlabel('Time/month')
ylabel('Displacement/mm')
set(gca,'XTickLabel',{'2006-12','2007-10','2008-08','2009-06','2010-04','2011-02','2011-12','2012-10','2013-08'},'XTickLabelRotation',45);
set(gca,'Fontname','Times New Roman');
% set (gcf,'unit','centimeters','Position',[4,5,14.63,7.35])
set (gcf,'unit','centimeters','Position',[4,5,14.63,10])

