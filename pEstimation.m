clc;clear;close all;
%
load LSTMTrenddata YPred_trend; Trend_LSTM = YPred_trend;
%
load LSTMPerioddata YPred_period y_trend y_period; Period_LSTM = YPred_period;
%
Total_LSTM= Trend_LSTM + Period_LSTM;
data_ZG118 = y_trend + y_period;
YPred_upper = Total_LSTM+13.92;
YPred_lower = Total_LSTM-13.92;
%
figure;
% plot(1:60,y_trend(1:60,1))
% hold on;
plot(61:72,[Total_LSTM;data_ZG118(61:72,1)';YPred_upper;YPred_lower])
xlabel('Time /month')
ylabel('Cumulative displacement /mm')
legend('LSTM','Actual','Predicted upper bound','Predicted lower bound')
set(gca,'XTickLabel',{'2011-12','2012-02','2012-04','2012-06','2012-08','2012-10','2012-12'},'XTickLabelRotation',45);
set(gca,'Fontname','Times New Roman');
set (gcf,'unit','centimeters','Position',[4,5,14.63,10])
%% º∆À„LSTM
rmse_Total_LSTM = sqrt(mean((Total_LSTM'-data_ZG118(61:72,1)).^2));
rmse=[rmse_Total_LSTM]
%% º∆À„R
actual=data_ZG118(61:72,1)';
% R_trend_LSTM = sum(((actual-mean(actual)).*(Trend_LSTM-mean(Trend_LSTM))))/((sqrt(sum((actual-mean(actual)).^2)))*(sqrt(sum((Trend_LSTM-mean(Trend_LSTM)).^2))))
% corrcoef(Trend_LSTM,actual)
% corrcoef(Trend_SVM,actual)
% corrcoef(Trend_Elman,actual)
mae_Total_LSTM = mean(abs(Total_LSTM-actual));
mae=[mae_Total_LSTM]










