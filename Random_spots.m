clear;
clc;
close all;

% figure();

Image = imread('R_s_00001.jpg');
% Image = 255-Image;    %Reverse the gray image
% subplot(2,2,1);
% imshow(Image);

t = 5;    % create five spots
min_m = 50;
max_m = 1000;
min_n = 50;
max_n = 700;

m = min_m+(max_m-min_m).*(rand(t,1));
n = min_n+(max_n-min_n).*(rand(t,1));

Mat_m_n = [round(m),round(n)];   % Can not be used

Bild_part = zeros(768,1080);
for t = 1:t
    for a = 1:16
        for b = 1:16
            Bild_part((a+round(n(t))),(b+round(m(t)))) = Image(a,b);
        end
    end    
    colormap(gray(256));
    imshow(Bild_part,[0,255]);
    set(gcf,'Position',[1 1 1080 768]);
    pause(0.01);
    
end

% There are two ways to show the image in grayscale,colormap() & mat2gray()
% subplot(2,2,3)
% colormap(gray(256))
% imshow(Bild_part,[0,255]);
% 
% 
% Bild_part = mat2gray(Bild_part);
% subplot(2,2,4);
% imshow(Bild_part);
