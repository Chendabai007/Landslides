function [y0,y] = MyPeriod_SVR(X,Y)
%% ����ѵ������
XTrain = X(:,1:60)';
YTrain = Y(:,1:60)';
XTest = X(:,61:72)';
%% ��׼������
mu=mean(XTrain);
sig=std(XTrain);
XTrain= (XTrain - mu)./ sig;%����xά��
% mu1=mean(YTrain);
% sig1=std(YTrain);
% YTrain=(YTrain-mu1)./sig1;
%����������
% md1=fitrsvm(XTrain,YTrain,'OptimizeHyperparameters','auto',...
%     'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
%     'expected-improvement-plus'));
md1=fitrsvm(XTrain,YTrain);
% ���� LSTM ����
XTest = (XTest-mu)./sig;
% XTest = XTest';
% numTimeStepsTest = numel(XTest(1,:));
% for i = 1:numTimeStepsTest
%     [net,YPred(:,i)] = predictAndUpdateState(net,XTest(:,i),'ExecutionEnvironment','cpu');
% end
% YPred= predict(net,XTest);
y0 = predict(md1,XTrain);
YPred= predict(md1,XTest);
% YPred= sig1.*YPred + mu1;
y=YPred';