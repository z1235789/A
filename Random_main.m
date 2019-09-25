% clear all;
% clear;
% clc;
close all;

n = 1080; % Resolution of monitor 1080*768
m = 768;
max = 1;
min = 0;
mean = (max+min)/2;

Bild = zeros(m,n);    %a black image
imwrite(Bild,strcat('E:\Data\a\','black','.jpg'),'jpg');

% Centroid determinate
centre_x_y = Random_centroid_x_y();
centre_x = centre_x_y(1);
centre_y = centre_x_y(2);

% main function
tic;

for i = 50:50:1050
    for j = 50:50:700   %50-700ÐÐ£¬50--1000ÁÐ
        Random_spots(Bild,i,j,n,m,centre_x,centre_y);
            
        Bild = zeros(m,n);
    end
end
        
toc;



