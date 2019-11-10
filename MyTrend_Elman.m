function [y0,y] = MyTrend_Elman(X,Y)
%% ����ѵ������
XTrain = X(:,1:59)';
YTrain = Y(:,2:60)';
XTest = X(:,60:71)';
%% ��׼������
mu=mean(XTrain);
sig=std(XTrain);
XTrain= (XTrain - mu)./ sig;%����xά��
YTrain= (YTrain - mu)./ sig;%����xά��
%����������
%% ����Elman������
% ����15����Ԫ��ѵ������Ϊtraingdx
net=elmannet(1:2,15,'traingdx');
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

XTrain1 = [XTrain;X(1,60)'];
y0 = sim(net,XTrain1');
y0= sig.*y0 + mu;
y0 = y0';

% ���� LSTM ����
XTest = (XTest-mu)./sig;
YPred = sim(net,XTest');
% YPred= predict(net,XTest);
% YPred= sig1.*YPred + mu1;
YPred= sig.*YPred + mu;
y=YPred;