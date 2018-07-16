%Image cropping code
clear all; clc;
I=imread('LE71770392003123ASN00_B4.tif');
I_g=mat2gray(I);
[x,y]=size(I);
lat_1=29.34941;     % lower latitude
lat_2=31.25914;     % upper latitude
long_1=29.06685;  % left longitude
long_2=31.61036;  %Right longitude
lat_req_1=30.2;      %Governorate lower latitude
lat_req_2= 30.7;     %Governorate upper latitude
long_req_1= 30.8;   %Governorate left longitude
long_req_2=31.16;  %Governorate right longitude
%scaling
x_min=x-round(x*(lat_req_2-lat_1)/(lat_2-lat_1));   
x_max=x-round(x*(lat_req_1-lat_1)/(lat_2-lat_1));
y_min=round(y*(long_req_1-long_1)/(long_2-long_1));
y_max=round(y*(long_req_2-long_1)/(long_2-long_1));
for i = 1:5
    C = sprintf('LE71770392003123ASN00_B%d.tif',i);
    Im = imread(C);
    I_rot_result_1=imcrop(Im,[y_min , x_min ,y_max-y_min , x_max-x_min]);   %crop image
    S = sprintf('B%d_2003.tif',i);
    imwrite(I_rot_result_1,S);
end