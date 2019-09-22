clear all;
clc;
close all;

figure()
R = imread('Ring_1.jpg');
subplot(2,2,1);
imshow(R);
R_s = imresize(R,0.02,'nearest');
subplot(2,2,2);
imshow(R_s);
imwrite(R_s,'R_s_00001.jpg')
