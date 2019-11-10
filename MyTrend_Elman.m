function [y0,y] = MyTrend_Elman(X,Y)
%% 设置训练样本
XTrain = X(:,1:59)';
YTrain = Y(:,2:60)';
XTest = X(:,60:71)';
%% 标准化数据
mu=mean(XTrain);
sig=std(XTrain);
XTrain= (XTrain - mu)./ sig;%样本x维度
YTrain= (YTrain - mu)./ sig;%样本x维度
%定义网络框架
%% 创建Elman神经网络
% 包含15个神经元，训练函数为traingdx
net=elmannet(1:2,15,'traingdx');
% 设置显示级别
net.trainParam.show=1;
% 最大迭代次数为2000次
net.trainParam.epochs=2000;
% 误差容限，达到此误差就可以停止训练
net.trainParam.goal=0.00001;
% 最多验证失败次数
net.trainParam.max_fail=5;
% 对网络进行初始化
net=init(net);
%% 网络训练
[net,~] = train(net,XTrain',YTrain');

XTrain1 = [XTrain;X(1,60)'];
y0 = sim(net,XTrain1');
y0= sig.*y0 + mu;
y0 = y0';

% 测试 LSTM 网络
XTest = (XTest-mu)./sig;
YPred = sim(net,XTest');
% YPred= predict(net,XTest);
% YPred= sig1.*YPred + mu1;
YPred= sig.*YPred + mu;
y=YPred;