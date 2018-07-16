%general code run this after atmospheric_correction.m
%NDVI & EVI
[I03N,A03N] = NDVI(I_03);      %NDVI 2003
[I15N,A15N] = NDVI(I_15);      %NDVI 2015
[I03E,A03E] = EVI(I_03);           %EVI 2003
[I15E,A15E] = EVI(I_15);           %EVI 2015
figure('name','I03N') , imshow(I03N);
figure('name','I15N') , imshow(I15N);
figure('name','I03E') , imshow(I03E);
figure('name','I15E') , imshow(I15E);
disp(A15N-A03N);
disp(A15E-A03E);
%%
%Taking Samples
[m,n,p] = size(I_03);
I_show = I_03(:,:,[4 3 2]);
Training = zeros(m,n,4);
figure ('name' , 'Choose regions') , 
for s = 1:4
Training(:,:,s) = roipoly(I_show);  %Vegetation,Water,Desert,Urban,Roads
end
%%
%creating classes from sampled regions
for i = 1:p
        K = I_03(:,:,i);
        V(:,i) = K(Training(:,:,1) == 1);
        W(:,i) = K(Training(:,:,2) == 1);
        D(:,i) = K(Training(:,:,3) == 1);
        U(:,i) = K(Training(:,:,4) == 1);
end
%ML_Classification
%Mean
Mean(1,:) = mean(V);
Mean(2,:) = mean(W);
Mean(3,:) = mean(D);
Mean(4,:) = mean(U);
%Covariance
Cov(:,:,1) = cov(V);
Cov(:,:,2) = cov(W);
Cov(:,:,3) = cov(D);
Cov(:,:,4) = cov(U);
[I03M,A03M] = ML_Class(I_03,Cov,Mean);
[I15M,A15M] = ML_Class(I_15,Cov,Mean);
figure('name','I03M') , imshow(I03M);
figure('name','I15M') , imshow(I15M);
disp(A15M(1)-A03M(1));
%% 
%Knn classification
[I03K,A03K] = Knn_Class(I_03,V,W,D,U);
[I15K,A15K] = Knn_Class(I_15,V,W,D,U);
figure('name','I03K') , imshow(I03K);
figure('name','I15K') , imshow(I15K);
disp(A15K(1)-A03K(1));