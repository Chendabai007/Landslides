clc;clear;close all;
load LSTMPerioddata YPred_period; Period_LSTM = YPred_period;
load SVMPerioddata YPred_period; Period_SVM = YPred_period;
load ElmanPerioddata YPred_period y_period; Period_Elman = YPred_period;
figure;
% plot(1:60,y_trend(1:60,1))
% hold on;
plot(61:72,[Period_LSTM;Period_SVM;Period_Elman;y_period(61:72,1)'])
xlabel('Time /month')
ylabel('Periodic displacement /mm')
legend('LSTM','SVM','Elman','Actual')
set(gca,'XTickLabel',{'2011-12','2012-02','2012-04','2012-06','2012-08','2012-10','2012-12'},'XTickLabelRotation',45);
set(gca,'Fontname','Times New Roman');
set (gcf,'unit','centimeters','Position',[4,5,14.63,10])
%% º∆À„LSTM
rmse_period_LSTM = sqrt(mean((Period_LSTM'-y_period(61:72,1)).^2));
rmse_period_SVM = sqrt(mean((Period_SVM'-y_period(61:72,1)).^2));
rmse_period_Elman = sqrt(mean((Period_Elman'-y_period(61:72,1)).^2));
rmse=[rmse_period_LSTM,rmse_period_SVM,rmse_period_Elman]
%% º∆À„R
actual=y_period(61:72,1)';
% R_trend_LSTM = sum(((actual-mean(actual)).*(Trend_LSTM-mean(Trend_LSTM))))/((sqrt(sum((actual-mean(actual)).^2)))*(sqrt(sum((Trend_LSTM-mean(Trend_LSTM)).^2))))
% corrcoef(Trend_LSTM,actual)
% corrcoef(Trend_SVM,actual)
% corrcoef(Trend_Elman,actual)
mae_period_LSTM = mean(abs(Period_LSTM-actual));
mae_period_SVM = mean(abs(Period_SVM-actual));
mae_period_Elman = mean(abs(Period_Elman-actual));
mae=[mae_period_LSTM,mae_period_SVM,mae_period_Elman]










