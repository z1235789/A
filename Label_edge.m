clc;
clear;
smap = imread('ring.jpg');
% 缩放图片大小，使得图像大小和Figure窗口大小一样
smap = imresize(smap, [320, 640]);
set (gcf,'Position',[0,0,640,320]);  % 前两个定义窗口在屏幕的位置，后两个窗口大小
 
% 使图像自适应填满窗口
imshow(smap,'border','tight','initialmagnification','fit');
 
% 保存
F=getframe(gcf);
imwrite(F.cdata, 'P1_color.jpg');
 
% 关闭生成的窗口
% close;
