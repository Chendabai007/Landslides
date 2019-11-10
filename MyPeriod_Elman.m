function [y0,y] = MyPeriod_Elman(X,Y)
%% ����ѵ������
XTrain = X(:,1:60)';
YTrain = Y(:,1:60)';
XTest = X(:,61:72)';
%% ��׼������
mu=mean(XTrain);
sig=std(XTrain);
XTrain= (XTrain - mu)./ sig;%����xά��
% mu1=mean(YTrain);
% sig1=std(YTrain);
% YTrain=(YTrain-mu1)./sig1;
%����������
%% ����Elman������
% ����15����Ԫ��ѵ������Ϊtraingdx
net=elmannet(1:2,100,'traingdx');%15
% ������ʾ����
net.trainParam.show=1;
% ����������Ϊ2000��
net.trainParam.epochs=2000;
% ������ޣ��ﵽ�����Ϳ���ֹͣѵ��
net.trainParam.goal=0.00001;
% �����֤ʧ�ܴ���
net.trainParam.max_fail=5;
% ��������г�ʼ��
net=init(net);
%% ����ѵ��
[net,~] = train(net,XTrain',YTrain');

y0 = sim(net,XTrain');
y0 = y0';

% ���� LSTM ����
XTest = (XTest-mu)./sig;
YPred = sim(net,XTest');
% YPred= predict(net,XTest);
% YPred= sig1.*YPred + mu1;
y=YPred;