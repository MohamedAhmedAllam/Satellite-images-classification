[m,n,p] = size(I_03);
X1 = reshape(I_03,m*n,p); %reshape to a 2d matrix
X2 = reshape(I_15,m*n,p);
X = [X1 X2];
%%
Mean = mean(X);    %get the mean
X = X - repmat(Mean,m*n,1);
Cx = (X'*X)/(m*n-1);             %Covariance
[COEFF , eigenvalues , percenteigen] = pcacov(Cx);       %Principle component analysis
New_I = X*COEFF;           % image after edit
New_I = reshape(New_I, m , n , 2*p);      %Return to 3d and create pca bands
New_I = mat2gray(New_I);
for v = 1:2*p
    figure , imshow(New_I(:,:,v));      
end