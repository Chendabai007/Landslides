function [y0,y] = MyPeriod_Elman(X,Y)
%% 设置训练样本
XTrain = X(:,1:60)';
YTrain = Y(:,1:60)';
XTest = X(:,61:72)';
%% 标准化数据
mu=mean(XTrain);
sig=std(XTrain);
XTrain= (XTrain - mu)./ sig;%样本x维度
% mu1=mean(YTrain);
% sig1=std(YTrain);
% YTrain=(YTrain-mu1)./sig1;
%定义网络框架
%% 创建Elman神经网络
% 包含15个神经元，训练函数为traingdx
net=elmannet(1:2,100,'traingdx');%15
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

y0 = sim(net,XTrain');
y0 = y0';

% 测试 LSTM 网络
XTest = (XTest-mu)./sig;
YPred = sim(net,XTest');
% YPred= predict(net,XTest);
% YPred= sig1.*YPred + mu1;
y=YPred;