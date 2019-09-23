%%%%%%%%%%%%%%%%%                                        %%%%%%%%%%%%%%
% 参数的设定可以通过一个UI来进行调节
% 这个函数中可调节的值有
% t（spot的个数）
% start_x（图象显示位置：x）,start_y（图像显示位置：y）
% col（图象显示大小：列）,raw（图像显示大小：行）
% 
%%%%%%%%%%%%%%%%%                                        %%%%%%%%%%%%%%


function Random_spots = Random_spots(Bild,i,j,n,m,centre_x,centre_y)

Image = imread('sample.jpg');
Image = 255 - Image;    % Reverse the gray image
% sz = size(Image);
[l,w] = size(Image);
t = 3;

min_m = l+1;
max_m = 50;
min_n = l+1;
max_n = 50;
Random_m = min_m + (max_m - min_m).*(rand(t,1));
Random_n = min_n + (max_n - min_n).*(rand(t,1));
Mat = [Random_m,Random_n];

start_x = 1000;
start_y = 1000;
col = 1080;
raw = 768;

Bild_test = zeros(m,n);
Bild_test = Bild;  % Black image
for t = 1:t
    for a = 1:l
        for b = 1:w
            raw = (j-50)+a+round(Random_m(t));
            col = (i-50)+b+round(Random_n(t));
            Bild_test((raw),(col)) = Image(a,b);
%             Bild_test((i-50+round(Random_n(t))),(j-50+round(Random_m(t)))) = Image(a,b);
        end        
    end
%     Bild_test = mat2gray(Bild_test);
%     imshow(Bild_test);
    colormap(gray(256));
    imshow(Bild_test,[0,255]);
    set(gcf,'Position',[start_x start_y col raw]);
    imwrite(Bild_test,strcat('Test\',num2str(i),'_',num2str(j),'_',num2str(t),'_X','.jpg'),'jpg');
    
    capture(Bild_test,i,j,m,n,centre_x,centre_y,a,b,t);
end

% colormap(gray(256));
% imshow(Bild_test,[0,255]);
% set(gcf,'Position',[start_x start_y col raw])

Random_spots = Bild_test;
end
