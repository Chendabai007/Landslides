function [y0,y] = MyTrend_LSTM(X,Y)
dataTrain = X(1,1:60);
XTest = Y(1,60:71);
% 标准化数据
mu = mean(dataTrain);
sig = std(dataTrain);
dataTrainStandardized = (dataTrain - mu) / sig;
% 准备预测变量和响应
XTrain = dataTrainStandardized(1:end-1);
YTrain = dataTrainStandardized(2:end);
% 定义 LSTM 网络架构
numFeatures = 1;
numResponses = 1;
numHiddenUnits = 200;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    fullyConnectedLayer(numResponses)
    regressionLayer];
% 指定训练选项
options = trainingOptions('adam', ...
    'MaxEpochs',250, ...
    'GradientThreshold',1, ...
    'InitialLearnRate',0.005, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',125, ...
    'LearnRateDropFactor',0.2, ...
    'Verbose',0);
% 训练 LSTM 网络
net = trainNetwork(XTrain,YTrain,layers,options);
net = predictAndUpdateState(net,XTrain);

y0=predict(net,XTrain);
y0= sig*y0 + mu;
y0=[y0,X(60)];


net = resetState(net);
net = predictAndUpdateState(net,XTrain);
% 预测将来时间步
% [net,YPred] = predictAndUpdateState(net,YTrain(end));
% numTimeStepsTest = 10;
% for i = 2:numTimeStepsTest
%     [net,YPred(:,i)] = predictAndUpdateState(net,YPred(:,i-1),'ExecutionEnvironment','cpu');
% end
% % 使用先前计算的参数对预测去标准化。
% YPred = sig*YPred + mu;
% y=YPred;
XTest = (XTest-mu)/sig;
numTimeStepsTest = numel(XTest);
for i = 1:numTimeStepsTest
    [net,YPred(:,i)] = predictAndUpdateState(net,XTest(:,i),'ExecutionEnvironment','cpu');
end
YPred = sig*YPred + mu;
y=YPred;
% y0=ones(1,60);

