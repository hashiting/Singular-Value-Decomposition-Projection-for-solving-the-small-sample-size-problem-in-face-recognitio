clear all
close all
load('FERET_80x80.mat')%�������ݼ�

rows=80;%80*80��ͼƬ
cols=80;
class=200;%��ĸ���
num=7;

%ѵ����������Ŀ����Ϊ���������Ե������趨Ϊ�ĸ�
train_feature = double(fea([1:7:1394 3:7:1396 7:7:1400],:)');
train_tag = gnd(:,[1:7:1394 3:7:1396 7:7:1400]);
test_feature = double(fea([2:7:1395 4:7:1397 5:7:1398 6:7:1399],:)');
test_tag = gnd(:,[2:7:1395 4:7:1397 5:7:1398 6:7:1399]);

for d=50:20:190%ӳ�䵽��ά��
    tic
    P=SVD(train_feature,d);%��SVD���н�ά
    train_hat=P*train_feature;%
    test_hat=P*test_feature;%test_hat = P*test
    train_norm=normc(train_hat);%��λ�����׷���
    test_norm=normc(test_hat);
    accuracy=Get_eff_accuracy(train_norm,class,train_tag,test_norm,test_tag);
    toc
    fprintf('����ά������%d\n',d);
    fprintf('��ȷ��Ϊ��%3.2f%%\n\n',accuracy*100);
end

