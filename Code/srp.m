%Median filter
clear all;
pic = imread('1.png');
size(pic);
picd=double(pic);
pic2=picd(:,:,1);
pic3=mat2gray(pic2);
pic4=pic3;
size(pic4);
x1=imnoise(pic4,'salt & Pepper',0.3);
subplot(2,2,1);
imshow(x1);
title('MRI Scan with salt & pepper noise')
size(x1);
pause;

filteredpic = medfilt2(x1,[3,3]);
subplot(2,2,2);
imshow(filteredpic);
title('MRI Scan after processing through median filter')

% <--------------------------------------------------- Adaptive median filter --------------------------------------------------->
pic = imread('2.png');
size(pic);
picd=double(pic);
pause;
pic2=picd(:,:,1);
pic3=mat2gray(pic2);
pic4=pic3;
size(pic4);

x1=imnoise(pic4,'salt & Pepper',0.3);
subplot(2,2,3);
imshow(x1);
title('MRI Scan with salt & pepper noise')
size(x1);
pause;

%adaptive median filtered pic

smax = 7;
g = x1;
[m n] = size(g);

%initial setup
f=g;
f(:) = 0;

%begin filtering

for k=3:2:smax

zmin = ordfilt2(g,1,ones(k,k),'symmetric');
zmax = ordfilt2(g,k*k,ones(k,k),'symmetric');
zmed = medfilt2(g,[k,k],'symmetric');

processusinglevelb = (zmed>zmin) & (zmax>zmed);

zb = (g>zmin) & (zmax>g);
outputzxy = processusinglevelb & zb;
outputzmed = processusinglevelb & ~zb;
f(outputzxy) = g(outputzxy);
f(outputzmed) = zmed(outputzmed);
end
subplot(2,2,4);
filteredpic = f;
imshow(filteredpic);
title('MRI Scan after processing through adaptive median filter')