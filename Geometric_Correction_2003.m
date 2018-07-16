%first code to run 
%%input image
%%I=imread('LC81770392014145LGN00_sr_cloud.tif');
%%input lat and long of the image
%%
long_1=29.24;
long_2=31.34;
lat_1=29.15;
lat_2=31.63;
%%input lat and long of the required region
long_req_1=30.4889;
long_req_2=30.5315;
lat_req_1=30.0542;
lat_req_2=30.8811;
%%
%%calculating angle of rotation for geometric correction
I_g=mat2gray(I);
[a,b]=size(I_g);
i=1;
j=1;
while i<=a
    while j<=b
        if I_g(i,j)~=0
            coor_1=[i j];
            i=a+1;
            j=b+1;
        end
        j=j+1;
    end
    j=1;
    i=i+1;
end
i=1;
j=1;
while i<=b
    while j<=a
        if I_g(j,i)~=0
            coor_2=[j i];
            i=b+1;
            j=a+1;
        end
        j=j+1;
    end
    j=1;
    i=i+1;
end
angle_r=atan((coor_2(2)-coor_1(2))/(coor_2(1)-coor_1(1)));
angle_d=angle_r*(180/pi);

%%rotatin image
counter_i=1;
counter_j=1;
for i = drange(1:a)
    for j = drange(1:b)
        i_p(counter_i)=round(i*cos(angle_r)-j*sin(angle_r));
        i_p_old(counter_i)=i;
        j_p(counter_j)=round(i*sin(angle_r)+j*cos(angle_r));
        j_p_old(counter_j)=j;
        counter_i=counter_i+1;
        counter_j=counter_j+1;
    end
end

%%transion the image from negative region to postive region
[const_i,m]=min(i_p);
[const_j,n]=min(j_p);
if const_i<0
    i_p=i_p-const_i+1;
end
if const_j<0
    j_p=j_p-const_j+1;
end

%%get the geomtrically corrected image
I_rot = zeros(a,b);
[a,b]=size(I_g);
for i = drange(1:a*b)
    if i_p(i)<=a && j_p(i)<=b
        I_rot(i_p_old(i),j_p_old(i))=I_g(i_p(i),j_p(i));
    else
        I_rot(i_p_old(i),j_p_old(i))=0;
    end
end
imshow(I_rot);
%%
%%delete the blank pixels of the image
[x,y]=size(I_rot);
%%%for blank cells in the reight
count_i=x;
count_j=round(y/2);
while I_rot(round(x/2),count_j)~=0
    count_j=count_j+1;
end
y_max=count_j;
%%%for blank cells in the left
count_i=x;
count_j=round(y/2);
while I_rot(round(x/2),count_j)~=0 && count_j>1
    count_j=count_j-1;
end
y_min=count_j;
%%%for blank cells in the down
count_i=round(x/2);
count_j=y;
while I_rot(count_i,round(y/2))~=0
    count_i=count_i+1;
end
x_max=count_i;
%%%for blank cells in the up
count_i=round(x/2);
count_j=y;
while I_rot(count_i,round(y/2))~=0 && count_i>1
    count_i=count_i-1;
end
x_min=count_i;
%%%image without blank cells
I_rot_d=imcrop(I_rot,[1 , x_min ,y_max-1 , x_max-x_min]);
figure,imshow(I_rot_d);
%%
lat_1=29.34941;
lat_2=31.25914;
long_1=29.14430;
long_2=31.58237;
%%input lat and long of the required region
lat_req_1=30.209235;
lat_req_2= 30.701697;
long_req_1= 30.850983;
long_req_2=31.142120;


%%modifiy lat and long of the corrected image
new_lat_1=lat_1*cos(-angle_r)+long_1*sin(-angle_r);
new_lat_2=lat_2*cos(-angle_r)+long_2*sin(-angle_r);
new_long_1=long_1*cos(-angle_r)+lat_1*sin(-angle_r);
new_long_2=long_2*cos(-angle_r)+lat_2*sin(-angle_r);
new_lat_req_1=lat_req_1*cos(-angle_r)+long_req_1*sin(-angle_r);
new_lat_req_2=lat_req_2*cos(-angle_r)+long_req_2*sin(-angle_r);
new_long_req_1=long_req_1*cos(-angle_r)+lat_req_1*sin(-angle_r);
new_long_req_2=long_req_2*cos(-angle_r)+lat_req_2*sin(-angle_r);

new_x=x*cos(-angle_r)+y*sin(-angle_r);
new_y=x*sin(-angle_r)+y*cos(-angle_r);
x_ratio=new_x/(new_lat_2-new_lat_1);
y_ratio=new_y/(new_long_2-new_long_1);
[k,r]=size(I_rot_d);
lat_cropped=(x-k)/x_ratio;
long_cropped=(y-r)/y_ratio;

new_lat_1=new_lat_1;%%+(lat_cropped/2);
new_lat_2=new_lat_2-(lat_cropped);
new_long_1=new_long_1;%%+(long_cropped/2);
new_long_2=new_long_2-(long_cropped);


%%cropping the region of interest
y_min=round((new_lat_req_1-new_lat_1)*y_ratio);
y_max=round((new_lat_req_2-new_lat_1)*y_ratio);
x_min=new_x-round((new_long_req_2-new_long_1)*x_ratio);
x_max=new_x-round((new_long_req_1-new_long_1)*x_ratio);
%%
I_rot_result_1=imcrop(I_rot_d,[y_min , x_min ,y_max-y_min , x_max-x_min]);
figure,imshow(I_rot_result_1);



