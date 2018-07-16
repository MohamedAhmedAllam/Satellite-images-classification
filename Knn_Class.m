%Knn function function
function [New_I,Area] = Knn_Class(I,V,W,D,U)
[m,n,p] = size(I);
New_I = zeros(m,n,3);
Area = zeros(4,1);
V(:,5) = 1;   %Class numbers
W(:,5) = 2;
D(:,5) = 3;
U(:,5) = 4;
Training_sample = [V;W;D;U];
[LTs,~] = size(Training_sample);
for z = 1:m
    for q = 1:n
        distance = zeros(LTs,1);
        Min_Dist = zeros(3,1);    %pixels with min distance 
        Min_Dist_Class = zeros(3,1);  %class of pixels with min distance
        for v = 1:LTs
            for a = 1:p
                distance(v) = distance(v)+(Training_sample(v,a)-I(z,q,a))^2;    %calculating euclidean distance
            end
            distance(v) = sqrt(distance(v));
        end
        for e = 1:3
            [Min_Dist(e),ind]= min(distance);    %calculating minimum distance
            Min_Dist_Class(e) = Training_sample(ind,5);
            distance(ind) = max(distance);
        end
        switch (mode(Min_Dist_Class))
            case 1
                New_I(z,q,:) = [0 1 0];    %coloring pixels
                Area(1) = Area(1)+1;
            case 2
                New_I(z,q,:) = [0 0 1];
                Area(2) = Area(2)+1;
            case 3
                New_I(z,q,:) = [1 1 0];
                Area(3) = Area(3)+1;
            case 4
                New_I(z,q,:) = [1 0 0];
                Area(4) = Area(4)+1;
        end
    end
end
New_I = mat2gray(New_I);
Area = 30*30*Area/1000000;
% fprintf('Area of Vegetation = %.4f Km^2 \r\n',Area(1));
% fprintf('Area of Water = %.4f Km^2 \r\n',Area(2));
% fprintf('Area of Desert = %.4f Km^2 \r\n',Area(3));
% fprintf('Area of Urban = %.4f Km^2 \r\n',Area(4));