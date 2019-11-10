function y = MyPeriod00000(X,Y)
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
    lstmLayer(numHiddenUnits,'OutputMode','sequence')
    fullyConnectedLayer(50)
    dropoutLayer(0.5)
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

maxEpochs = 60;
miniBatchSize = 20;

options = trainingOptions('adam', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'InitialLearnRate',0.01, ...
    'GradientThreshold',1, ...
    'Shuffle','never', ...
    'Verbose',0);
% 训练 LSTM 网络
myXTrain = cell(1,1);
myYTrain = cell(1,1);
myXTrain{1,1} = XTrain';
myYTrain{1,1} = YTrain';
% XTrain = num2cell(XTrain);
% YTrain = num2cell(YTrain);
% net = trainNetwork(XTrain',YTrain',layers,options);%维度x样本
net = trainNetwork(myXTrain,myYTrain,layers,options);%维度x样本
% 测试 LSTM 网络
XTest = (XTest-mu)./sig;
myYTest = cell(1,1);
myXTest{1,1}=XTest';
% XTest = XTest';
% numTimeStepsTest = numel(XTest(1,:));
% for i = 1:numTimeStepsTest
%     [net,YPred(:,i)] = predictAndUpdateState(net,XTest(:,i),'ExecutionEnvironment','cpu');
% end
YPred= predict(net,myXTest);
% YPred= sig1.*YPred + mu1;
y=cell2mat(YPred);