function [accuracy]=Get_eff_accuracy(train_feature,classnum,train_tag,test_feature,test_tag)
test_size=size(test_feature,2);
train_size=size(train_feature,2);
t=zeros(1,test_size);
for i=1:test_size
    xp = SolveHomotopy_CBM_std(train_feature, test_feature(:,i),'lambda', 0.01);%获取稀疏表示系数
    for j=1:classnum
        b=zeros(train_size,1);
        position=(j==train_tag);
        b(position)=xp(position);
        r(j)=norm(test_feature(:,i)-train_feature*b);
    end
    [~,index]=min(r);%分类
    t(i)=index;
end
accuracy=sum(t==test_tag)/test_size;