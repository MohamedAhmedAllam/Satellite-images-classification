%Atmospheric correction
%Run after gemoetric correction
clear all; clc;
%Load images and equalize matrices
for i1 = 1:4
    str1 = strcat('B',num2str(i1),'_2003.tif');
    str2 = strcat('B',num2str(i1+1),'_2015.tif');
    I_03(:,:,i1) = double(imread(str1));
    I_15(:,:,i1) = double(imread(str2));
end
I_03 = I_03(1899-1892:1899,1:1129,:);
%Reflectance 
%2015
Ref_fac_15 = 2*10^-5;      %2015 reflectance multiplication factor
Ref_add_15 = -0.1;            %2015 reflectance add factor
Sun_angle_15 = 62.96264381;    %Sun angle
I_15 = Ref_fac_15*I_15+Ref_add_15;      %DN to Reflectance 
I_15 = I_15/sin(Sun_angle_15);   %Relfectance with sun angle
%2003
Rad_max = [293.7;300.9;234.4;241.1];    %maximum radiance of 4 bands
Rad_min = [-6.2;-6.4;-5;-5.1];                  %minimum radiance of 4 bands
Qcal_max = 255;                                       %maximum pixel value
Qcal_min = 1;                                            %minimum pixel value
D_sun = 0.9920831;                                 %earth-to-sun distance
E_sun = [1970;1842;1547;1044];             
Sun_angle_03 = 63.38852846;                 %2015 sun angle
for i2 = 1:4
    I_03(:,:,i2) = (Rad_max(i2)-Rad_min(i2))/(Qcal_max-Qcal_min)*(I_03(:,:,i2)-Qcal_min)+Rad_min(i2);    %DN to Radiance
    I_03(:,:,i2) = pi*I_03(:,:,i2)*(D_sun)^2/((E_sun(i2)*sin(Sun_angle_03)));                       %radiance to Reflectance
end
%%
I_03 = mat2gray(I_03);    %Convert to display
I_15 = mat2gray(I_15);
[m n p] = size(I_03);
 for cnt = 1:p
I_03(:,:,cnt) = histeq(I_03(:,:,cnt),imhist(I_15(:,:,cnt)));     %histogram matching
 end
figure , imshow(I_03(:,:,[4 3 2]));
figure , imshow(I_15(:,:,[4 3 2]));