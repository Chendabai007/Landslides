clc;clear;close all;
%
load LSTMTrenddata_OMA YPred_trend; Trend_LSTM = YPred_trend;
load SVMTrenddata YPred_trend; Trend_SVM = YPred_trend;
load ElmanTrenddata YPred_trend y_trend; Trend_Elman = YPred_trend;
%
load LSTMPerioddata_OMA YPred_period; Period_LSTM = YPred_period;
load SVMPerioddata YPred_period; Period_SVM = YPred_period;
load ElmanPerioddata YPred_period y_period; Period_Elman = YPred_period;
%
Total_LSTM= Trend_LSTM + Period_LSTM;
Total_SVM= Trend_SVM + Period_SVM;
Total_Elman= Trend_Elman + Period_Elman;
data_ZG118 = y_trend + y_period;
%
figure;
% plot(1:60,y_trend(1:60,1))
% hold on;
plot(61:72,[Total_LSTM;Total_SVM;Total_Elman;data_ZG118(61:72,1)'])
xlabel('Time /month')
ylabel('Cumulative displacement /mm')
legend('LSTM','SVM','Elman','Actual')
set(gca,'XTickLabel',{'2011-12','2012-02','2012-04','2012-06','2012-08','2012-10','2012-12'},'XTickLabelRotation',45);
set(gca,'Fontname','Times New Roman');
set (gcf,'unit','centimeters','Position',[4,5,14.63,10])
%% º∆À„LSTM
rmse_Total_LSTM = sqrt(mean((Total_LSTM'-data_ZG118(61:72,1)).^2));
rmse_Total_SVM = sqrt(mean((Total_SVM'-data_ZG118(61:72,1)).^2));
rmse_Total_Elman = sqrt(mean((Total_Elman'-data_ZG118(61:72,1)).^2));
rmse=[rmse_Total_LSTM,rmse_Total_SVM,rmse_Total_Elman]
%% º∆À„R
actual=data_ZG118(61:72,1)';
% R_trend_LSTM = sum(((actual-mean(actual)).*(Trend_LSTM-mean(Trend_LSTM))))/((sqrt(sum((actual-mean(actual)).^2)))*(sqrt(sum((Trend_LSTM-mean(Trend_LSTM)).^2))))
% corrcoef(Trend_LSTM,actual)
% corrcoef(Trend_SVM,actual)
% corrcoef(Trend_Elman,actual)
mae_Total_LSTM = mean(abs(Total_LSTM-actual));
mae_Total_SVM = mean(abs(Total_SVM-actual));
mae_Total_Elman = mean(abs(Total_Elman-actual));
mae=[mae_Total_LSTM,mae_Total_SVM,mae_Total_Elman]










