function y = MyPeriod0000(X,Y)
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
numFeatures = 8;
numResponses = 1;
numHiddenUnits = 200;

% layers = [ ...
%     sequenceInputLayer(numFeatures)
%     lstmLayer(numHiddenUnits,'OutputMode','Sequence')
%     fullyConnectedLayer(numResponses)
%     regressionLayer];

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(50)
    dropoutLayer(0.2)
    fullyConnectedLayer(numResponses)
    regressionLayer];
% 指定训练选项
% options = trainingOptions('adam', ...
%     'MaxEpochs',250, ...
%     'GradientThreshold',1, ...
%     'InitialLearnRate',0.005, ...
%     'LearnRateSchedule','piecewise', ...
%     'LearnRateDropPeriod',125, ...
%     'LearnRateDropFactor',0.2, ...
%     'Verbose',0);

maxEpochs = 10;
miniBatchSize = 5;

options = trainingOptions('adam', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'InitialLearnRate',0.005, ...
    'GradientThreshold',1, ...
    'Shuffle','never', ...
    'Verbose',0);
% 训练 LSTM 网络
myXTrain = cell(60,1);
for i = 1:60
    myXTrain{i,1}=XTrain(i,:)';
end
% XTrain = num2cell(XTrain);
% YTrain = num2cell(YTrain);
% net = trainNetwork(XTrain',YTrain',layers,options);%维度x样本
net = trainNetwork(myXTrain,YTrain,layers,options);%维度x样本
% 测试 LSTM 网络
XTest = (XTest-mu)./sig;
myYTest = cell(12,1);
for i = 1:12
    myXTest{i,1}=XTest(i,:)';
end
% XTest = XTest';
% numTimeStepsTest = numel(XTest(1,:));
% for i = 1:numTimeStepsTest
%     [net,YPred(:,i)] = predictAndUpdateState(net,XTest(:,i),'ExecutionEnvironment','cpu');
% end
YPred= predict(net,myXTest);
% YPred= sig1.*YPred + mu1;
y=YPred';