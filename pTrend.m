clc;clear;close all;
load LSTMTrenddata YPred_trend; Trend_LSTM = YPred_trend;
load SVMTrenddata YPred_trend; Trend_SVM = YPred_trend;
load ElmanTrenddata YPred_trend y_trend; Trend_Elman = YPred_trend;
figure;
% plot(1:60,y_trend(1:60,1))
% hold on;
plot(61:72,[Trend_LSTM;Trend_SVM;Trend_Elman;y_trend(61:72,1)'])
xlabel('Time /month')
ylabel('Trend displacement /mm')
legend('LSTM','SVM','Elman','Actual')
set(gca,'XTickLabel',{'2011-12','2012-02','2012-04','2012-06','2012-08','2012-10','2012-12'},'XTickLabelRotation',45);
set(gca,'Fontname','Times New Roman');
set (gcf,'unit','centimeters','Position',[4,5,14.63,10])
%% º∆À„LSTM
rmse_trend_LSTM = sqrt(mean((Trend_LSTM'-y_trend(61:72,1)).^2))
rmse_trend_SVM = sqrt(mean((Trend_SVM'-y_trend(61:72,1)).^2))
rmse_trend_Elman = sqrt(mean((Trend_Elman'-y_trend(61:72,1)).^2))
%% º∆À„R
actual=y_trend(61:72,1)';
% R_trend_LSTM = sum(((actual-mean(actual)).*(Trend_LSTM-mean(Trend_LSTM))))/((sqrt(sum((actual-mean(actual)).^2)))*(sqrt(sum((Trend_LSTM-mean(Trend_LSTM)).^2))))
% corrcoef(Trend_LSTM,actual)
% corrcoef(Trend_SVM,actual)
% corrcoef(Trend_Elman,actual)
mae_trend_LSTM = mean(abs(Trend_LSTM-actual))
mae_trend_SVM = mean(abs(Trend_SVM-actual))
mae_trend_Elman = mean(abs(Trend_Elman-actual))










