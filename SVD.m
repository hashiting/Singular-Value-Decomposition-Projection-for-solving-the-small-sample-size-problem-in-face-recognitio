function [ P ] = SVD(train_feature,d )
%SVD½µÎ¬£¬»ñÈ¡¾ØÕóP
[U,S,V] = svd(double(train_feature));
S = S(1:d,1:d);
U = U(:,1:d);
V = V(:,1:d);
P = inv(S)*U';
end

