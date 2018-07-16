%Enhanced vegetation index function
function[New_I,Area] = EVI(I)
[m,n,~] = size(I);
EVI = zeros(m,n);
New_I = zeros(m,n,3);
Area = 0;
for i = 1:m
    for j = 1:n
        EVI(i,j) = 2.5*(I(i,j,4)-I(i,j,3))/(I(i,j,4)+6*I(i,j,3)-7.5*I(i,j,1)+1);    %EVI calculation from reflectance values
        if  (EVI(i,j)>0.42)
            New_I(i,j,:) = [0 1 0];   %coloring pixels
            Area = Area+1;
        elseif (EVI(i,j)>0.1)
            New_I(i,j,:) = [1 1 1];
        elseif (EVI(i,j) >0)
            New_I(i,j,:) = [0 0 0];
        else
            New_I(i,j,:) = [0 0 1];   
        end
    end
end
Area = 30*30*Area/1000000;