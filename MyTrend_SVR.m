function [y0,y] = MyTrend_SVR(X,Y)
%% ����ѵ������
XTrain = X(:,1:59)';
YTrain = Y(:,2:60)';
XTest = X(:,60:71)';
%% ��׼������
mu=mean(XTrain);
sig=std(XTrain);
XTrain= (XTrain - mu)./ sig;%����xά��
YTrain= (YTrain - mu)./ sig;%����xά��
% mu1=mean(YTrain);
% sig1=std(YTrain);
% YTrain=(YTrain-mu1)./sig1;
%����������
% md1=fitrsvm(XTrain,YTrain);
md1=fitrsvm(XTrain,YTrain,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'));
% ���� LSTM ����
XTest = (XTest-mu)./sig;
% XTest = XTest';
% numTimeStepsTest = numel(XTest(1,:));
% for i = 1:numTimeStepsTest
%     [net,YPred(:,i)] = predictAndUpdateState(net,XTest(:,i),'ExecutionEnvironment','cpu');
% end
% YPred= predict(net,XTest);
XTrain1 = [XTrain;X(1,60)'];
y0 = predict(md1,XTrain1);
y0= sig.*y0 + mu;
y0=y0';
YPred = predict(md1,XTest);
YPred= sig.*YPred + mu;
y=YPred';