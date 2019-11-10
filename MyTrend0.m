function [y0,y] = MyTrend0(X,Y)
% ��׼������
%% ����ѵ������
XTrain = X(:,1:60)';
YTrain = Y(:,1:60)';
XTest = X(:,61:72)';
%% ��׼������
mu=mean(XTrain);
sig=std(XTrain);
XTrain= (XTrain - mu)./ sig;%����xά��
%����������
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
% ָ��ѵ��ѡ��
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
% ѵ�� LSTM ����

myXTrain = cell(60,1);
myYTrain = cell(60,1);
for i = 1:60
    myXTrain{i,1}=XTrain(i,:)';
    myYTrain{i,1}=YTrain(i,:)';
end

net = trainNetwork(myXTrain',myYTrain',layers,options);%ά��x����

y0 = predict(net,myXTrain');
net = resetState(net);

% ���� LSTM ����
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
