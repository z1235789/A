%% 
clear all;
clc;
close all;

x_res = 1080;
y_res = 768;

Bild_black = zeros(x_res,y_res);
Bild_white = ones(x_res,y_res);
Bild_random = rand(x_res,y_res,1);

figure;
subplot(3,1,1);
imshow(Bild_black);
title('Black signal');

subplot(3,1,2);
imshow(Bild_white);
title('White signal')

subplot(3,1,3);
imshow(Bild_random);
title('Random signal')
