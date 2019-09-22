clear;
clc;
close all;

figure();

Image = imread('R_s_00001.jpg');
% Image = 255-Image;    %Reverse the gray image
subplot(2,2,1);
imshow(Image);

t = 5;
min = 100;
max = 1000;
min_1 = 100;
max_1 = 1000;

m = min+(max-min).*(rand(t,1));
n = min_1+(max_1-min_1).*(rand(t,1));

Mat = [round(m),round(n)];
Bild_part = zeros(1080,1080);

for t = 1:t
    for a = 1:16
        for b = 1:16
            Bild_part((a+round(n(t))),(b+round(m(t)))) = Image(a,b);
        end
    end
end

% There are two ways to show the image in grayscale,colormap() & mat2gray()
subplot(2,2,3)
colormap(gray(256))
imshow(Bild_part,[0,255]);


Bild_part = mat2gray(Bild_part);
subplot(2,2,4);
imshow(Bild_part);
