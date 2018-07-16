%Normalised Difference vegetation index function
function[New_I,Area] = NDVI(I)
[m,n,~] = size(I);
NDVI = zeros(m,n);
New_I = zeros(m,n,3);
Area = 0;
for i = 1:m
    for j = 1:n
        NDVI(i,j) = (I(i,j,4)-I(i,j,3))/(I(i,j,4)+I(i,j,3));      %EVI calculation from reflectance values
        if (NDVI(i,j)>0.37)
            New_I(i,j,:) = [0 1 0];      %Grass
            Area =Area+1;
        elseif (NDVI(i,j)>0.1)
            New_I(i,j,:) = [1 1 1];       
        elseif (NDVI(i,j) >0)          
            New_I(i,j,:) = [0 0 0];     
        else 
             New_I(i,j,:) = [0 0 1];       
        end
    end
end
Area = 30*30*Area/1000000;