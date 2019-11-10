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
%% ��ͼ
% figure;
% plotyy(1:72,[y_period_input(3,:);y_period_input(1:2,:)],1:72,y_period')
% xlabel('Time /month')
% ylabel('Rainfall /mm')
% legend('Maximum rainfall during current month','Cumulative rainfall during current month','Cumulative rainfall during two-month period','Periodic displacement')
% set(gca,'XTickLabel',{'2006-12','2007-10','2008-08','2009-06','2010-04','2011-02','2011-12','2012-10','2013-08'},'XTickLabelRotation',45);
% set(gca,'Fontname','Times New Roman');
% set (gcf,'unit','centimeters','Position',[4,5,14.63,10])
%%
% figure;
% plotyy(1:72,y_period_input(5:6,:),1:72,y_period')
% xlabel('Time /month')
% ylabel('Rainfall /mm')
% legend('Change in reservoir level during current month','Change in reservoir level during two-month period','Periodic displacement')
% set(gca,'XTickLabel',{'2006-12','2007-10','2008-08','2009-06','2010-04','2011-02','2011-12','2012-10','2013-08'},'XTickLabelRotation',45);
% set(gca,'Fontname','Times New Roman');
% set (gcf,'unit','centimeters','Position',[4,5,14.63,10])
%%
figure;
plotyy(1:72,y_period_input(7:9,:),1:72,y_period')
xlabel('Time /month')
ylabel('Cumulative displacement increment /mm')
legend('Cumulative displacement increment during current month','Cumulative displacement increment during two-month period','Cumulative displacement increment during three-month period','Periodic displacement')
set(gca,'XTickLabel',{'2006-12','2007-10','2008-08','2009-06','2010-04','2011-02','2011-12','2012-10','2013-08'},'XTickLabelRotation',45);
set(gca,'Fontname','Times New Roman');
set (gcf,'unit','centimeters','Position',[4,5,14.63,10])