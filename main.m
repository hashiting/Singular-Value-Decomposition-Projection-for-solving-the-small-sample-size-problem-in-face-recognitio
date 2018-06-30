clear all
close all
load('FERET_80x80.mat')%加载数据集

rows=80;%80*80的图片
cols=80;
class=200;%类的个数
num=7;

%训练的样本数目设置为两个，测试的样本设定为四个
train_feature = double(fea([1:7:1394 3:7:1396 7:7:1400],:)');
train_tag = gnd(:,[1:7:1394 3:7:1396 7:7:1400]);
test_feature = double(fea([2:7:1395 4:7:1397 5:7:1398 6:7:1399],:)');
test_tag = gnd(:,[2:7:1395 4:7:1397 5:7:1398 6:7:1399]);

for d=50:20:190%映射到的维度
    tic
    P=SVD(train_feature,d);%用SVD进行降维
    train_hat=P*train_feature;%
    test_hat=P*test_feature;%test_hat = P*test
    train_norm=normc(train_hat);%单位化二阶范数
    test_norm=normc(test_hat);
    accuracy=Get_eff_accuracy(train_norm,class,train_tag,test_norm,test_tag);
    toc
    fprintf('减少维数到：%d\n',d);
    fprintf('正确率为：%3.2f%%\n\n',accuracy*100);
end

