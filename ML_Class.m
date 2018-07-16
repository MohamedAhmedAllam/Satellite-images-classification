%maximum likelihood classification
function [New_I,Area] = ML_Class(I,Cov,Mean)
[m,n,p] = size(I);
New_I = zeros(m,n,3);
G = zeros(4,1);
Area = zeros(4,1);
for t = 1:m
    for o = 1:n
        X = double(reshape(I(t,o,:),1,p,1));
        for h = 1:length(Mean)
        G(h) = -log(det(Cov(:,:,h)))-(X-Mean(h,:))*((Cov(:,:,h))\transpose((X-Mean(h,:))));    %calculating MLC function
        end
        [~,Index] = max(G);
        switch Index
            case 1
                New_I(t,o,:) = [0 1 0];    %coloring pixels
                Area(1) = Area(1)+1;     %incrementing area
            case 2
                New_I(t,o,:) = [0 0 1];
                Area(2) = Area(2)+1;
            case 3
                New_I(t,o,:) = [1 1 0];
                Area(3) = Area(3)+1;
            case 4
                New_I(t,o,:) = [1 0 0];
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