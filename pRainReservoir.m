clc;clear;close all;
%% 加载变形位移数据
load data_ZG118 data_ZG118;
data_ZG118(51,1)=(data_ZG118(50,1)+data_ZG118(52,1))/2;
%% 加载影响因子
load Rainfall Rainfall;
load Reservoir Reservoir;
figure;
[AX0,H01,H02] = plotyy(1:72,data_ZG118,1:72,Rainfall, 'line','bar');
xlabel('Time/month')
set(get(AX0(1),'ylabel'),'string', 'Cumulative displacement/mm');
set(get(AX0(2),'ylabel'),'string', 'Rainfall/mm','Fontname','Times New Roman');
set(gca,'Fontname','Times New Roman');
set(gca,'XTickLabel',{'2006-12','2007-10','2008-08','2009-06','2010-04','2011-02','2011-12','2012-10','2013-08'},'XTickLabelRotation',45);
set(gca,'Fontname','Times New Roman');
set (gcf,'unit','centimeters','Position',[4,5,14.63,7.35])


figure;
[AX1,H1,H2] = plotyy(1:72,data_ZG118,1:72,Reservoir, 'line','line');
xlabel('Time/month')
set(get(AX1(1),'ylabel'),'string', 'Cumulative displacement/mm');
set(get(AX1(2),'ylabel'),'string', 'Reservoir water level/m');
set(gca,'XTickLabel',{'2006-12','2007-10','2008-08','2009-06','2010-04','2011-02','2011-12','2012-10','2013-08'},'XTickLabelRotation',45);
set(gca,'Fontname','Times New Roman');
set (gcf,'unit','centimeters','Position',[4,5,14.63,7.35])