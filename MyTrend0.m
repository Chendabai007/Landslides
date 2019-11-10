function [y0,y] = MyTrend0(X,Y)
% 标准化数据
%% 设置训练样本
XTrain = X(:,1:60)';
YTrain = Y(:,1:60)';
XTest = X(:,61:72)';
%% 标准化数据
mu=mean(XTrain);
sig=std(XTrain);
XTrain= (XTrain - mu)./ sig;%样本x维度
%定义网络框架
numFeatures = 1;
numResponses = 1;
numHiddenUnits = 200;

% layers = [ ...
%     sequenceInputLayer(numFeatures)
%     lstmLayer(numHiddenUnits)
%     fullyConnectedLayer(numResponses)
%     regressionLayer];
layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits,'OutputMode','sequence')
    dropoutLayer(0.2)
    fullyConnectedLayer(numResponses)
    regressionLayer];
% 指定训练选项
maxEpochs = 10;
miniBatchSize = 5;
% 
options = trainingOptions('adam', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'InitialLearnRate',0.005, ...
    'GradientThreshold',1, ...
    'Shuffle','never', ...
    'Verbose',0);
% options = trainingOptions('adam', ...
%     'MaxEpochs',250, ...
%     'GradientThreshold',1, ...
%     'InitialLearnRate',0.005, ...
%     'LearnRateSchedule','piecewise', ...
%     'LearnRateDropPeriod',125, ...
%     'LearnRateDropFactor',0.2, ...
%     'Verbose',0);
% 训练 LSTM 网络

myXTrain = cell(60,1);
myYTrain = cell(60,1);
for i = 1:60
    myXTrain{i,1}=XTrain(i,:)';
    myYTrain{i,1}=YTrain(i,:)';
end

net = trainNetwork(myXTrain',myYTrain',layers,options);%维度x样本

y0 = predict(net,myXTrain');
net = resetState(net);

% 测试 LSTM 网络
XTest = (XTest-mu)./sig;

myXTest = cell(12,1);
for i = 1:12
    myXTest{i,1}=XTest(i,:)';
end

numTimeStepsTest = numel(XTest(1,:));
for i = 1:numTimeStepsTest
    [net,YPred(:,i)] = predictAndUpdateState(net,myXTest(:,i),'ExecutionEnvironment','cpu');
end
% YPred= predict(net,XTest);
% YPred= sig1.*YPred + mu1;
y=YPred;
y=cell2mat(YPred)';
