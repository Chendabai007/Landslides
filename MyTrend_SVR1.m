function [y0,y] = MyTrend_SVR1(X,Y)
%% 设置训练样本
for i=1:57
    XTrain(i,1) = X(:,i);
    XTrain(i,2) = X(:,i+1);
    XTrain(i,3) = X(:,i+2);
end
YTrain = Y(:,4:60)';
for i=1:12
    XTest(i,1) = X(:,i+57);
    XTest(i,2) = X(:,i+58);
    XTest(i,3) = X(:,i+59);
end
XTrain0 = X(:,1:59)';
% YTrain0 = Y(:,2:60)';
% XTest0 = X(:,60:71)';
%% 标准化数据
mu=mean(XTrain0);
sig=std(XTrain0);
XTrain= (XTrain - mu)./ sig;%样本x维度
YTrain= (YTrain - mu)./ sig;%样本x维度
% mu1=mean(YTrain);
% sig1=std(YTrain);
% YTrain=(YTrain-mu1)./sig1;
%定义网络框架
md1=fitrsvm(XTrain,YTrain);
% 测试 LSTM 网络
XTest = (XTest-mu)./sig;
% XTest = XTest';
% numTimeStepsTest = numel(XTest(1,:));
% for i = 1:numTimeStepsTest
%     [net,YPred(:,i)] = predictAndUpdateState(net,XTest(:,i),'ExecutionEnvironment','cpu');
% end
% YPred= predict(net,XTest);
% XTrain1 = [XTrain;X(1,60)'];
%  XTrain1 = XTrain;
% y0 = predict(md1,XTrain1);
% y0= sig.*y0 + mu;
% y0=y0';
YPred = predict(md1,XTest);
YPred= sig.*YPred + mu;
y=YPred';
y0=0;