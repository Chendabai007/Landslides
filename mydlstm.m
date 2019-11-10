function YPred = mydlstm (data)
dataTrain = data';
% ��׼������
mu = mean(dataTrain);
sig = std(dataTrain);
dataTrainStandardized = (dataTrain - mu) / sig;
% ׼��Ԥ���������Ӧ
XTrain = dataTrainStandardized(1:end-1);
YTrain = dataTrainStandardized(2:end);
% ���� LSTM ����ܹ�
numFeatures = 1;
numResponses = 1;
numHiddenUnits = 200;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    lstmLayer(numHiddenUnits)
    lstmLayer(numHiddenUnits)
    fullyConnectedLayer(numResponses)
    regressionLayer];
% ָ��ѵ��ѡ��
options = trainingOptions('adam', ...
    'MaxEpochs',250, ...
    'GradientThreshold',1, ...
    'InitialLearnRate',0.005, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',125, ...
    'LearnRateDropFactor',0.2, ...
    'Verbose',0);
% ѵ�� LSTM ����
net = trainNetwork(XTrain,YTrain,layers,options);
% Ԥ�⽫��ʱ�䲽
% 
net = predictAndUpdateState(net,XTrain);
[net,YPred] = predictAndUpdateState(net,YTrain(end));

numTimeStepsTest = 12;
for i = 2:numTimeStepsTest
    [net,YPred(:,i)] = predictAndUpdateState(net,YPred(:,i-1),'ExecutionEnvironment','cpu');
end

% ʹ����ǰ����Ĳ�����Ԥ��ȥ��׼����
YPred = sig*YPred + mu;