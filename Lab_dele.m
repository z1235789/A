% clear all;
clear;
clc;
close all;

n = 1080;
m = 768;
% n = 1920;
% m = 1080;
max = 1;
min = 0;
mean = (max+min)/2;

Bild = zeros(m,n);    % Create a black image as figure
imwrite(Bild,strcat('a\','black','.jpg'),'jpg');

% Find the centre of the Beam image,then it will be cropped
centre_x_y = centre_x_y();
centre_x = centre_x_y(1);
centre_y = centre_x_y(2);

figure;    

tic;
for i =  300:25:768    %Row
    for j = 500:25:1080      %Col
        Bild_test = bild(Bild,i,j,max,min,mean); 

 %{
%         Bild(i,j) = max;
%         gap = 40;
%         Bild(i+3*gap,j+3*gap) = max;
%         Bild(i+3*gap,j+7*gap) = max;
%         Bild(i+5*gap,j+5*gap) = max;
%         Bild(i+7*gap,j+3*gap) = max;
%         Bild(i+7*gap,j+7*gap) = max;
%         Bild(i+9*gap,j+3*gap) = max;
%         Bild(i+9*gap,j+7*gap) = max;
%         Bild(i+5*gap,j+11*gap) = max;
%         Bild(i+7*gap,j+9*gap) = max;
%         Bild(i+7*gap,j+11*gap) = max;
%         Bild(i+3*gap,j+9*gap) = max;
%         Bild(i+3*gap,j+13*gap) = max;
%         Bild(i+5*gap,j+15*gap) = max;
%         Bild(i+7*gap,j+15*gap) = max;
%         Bild(i+7*gap,j+13*gap) = max;
        
%         Bild(i+3*gap,j+13*gap) = max;
%         Bild(i+3*gap,j+17*gap) = max;
%         Bild(i+5*gap,j+15*gap) = max;
%         Bild(i+7*gap,j+13*gap) = max;
%         Bild(i+7*gap,j+17*gap) = max;
%         Bild(i+13*gap,j+3*gap) = max;
%         Bild(i+13*gap,j+7*gap) = max;
%         Bild(i+15*gap,j+5*gap) = max;
%         Bild(i+17*gap,j+3*gap) = max;
%         Bild(i+17*gap,j+7*gap) = max;
%         Bild(i+13*gap,j+13*gap) = max;
%         Bild(i+13*gap,j+17*gap) = max;
%         Bild(i+15*gap,j+15*gap) = max;
%         Bild(i+17*gap,j+13*gap) = max;
%         Bild(i+17*gap,j+17*gap) = max;
%}    
        %display can be hid
        %imshow(Bild);
        %hold on
        %title('Original image');
        
        %Dilate the spot in the Bild using the disk method and save it
%         Bild_test = disk(Bild);    %Bild_test is X
        imshow(Bild_test);
        title('xy');
%         set(gcf,'outerposition', [1913         113        1936     1118]); % Verschiebung auf den Bildschirm des SLM
%         set(gcf,'Position',[1300,240,1000,760]);
%         set(gcf,'outerposition', [1281         370        1000     760]);
        set(gcf,'Position',[1300,200,1000,760]);
%         set(gcf,'Position',[1300,200,1000,760]);
        hold on
        
%         imwrite(Bild_test,strcat('Test\',num2str(i),'_',num2str(j),'_X','.jpg'),'jpg');
        imwrite(Bild_test,strcat('E:\Data\Test\',num2str(i),'_',num2str(j),'_X','.jpg'),'jpg');        
        
        Bild_SLM = ones(m,n);
        Image_SLM = capture_image(Bild_SLM,i,j,centre_x,centre_y);
        hold off
        
%         figure(2);
%         X_Y = imshowpair(Bild_test,Image_SLM,'Montage');
%         title('Image pair');
%         saveas(gcf,strcat('Pair\',num2str(i),'_',num2str(j),'_X_Y_Z','.jpg'));
%         close (figure(2));

%         Bild_test = im2uint8(Bild_test);
%         Image_pair = [Bild_test,Image_SLM];
%         imwrite(Image_pair,strcat('Pair\',num2str(i),'_',num2str(j),'_X_Y','.jpg'),'jpg');

        Bild_temp = zeros(m,n);
        Bild_temp = im2uint8(Bild_temp);
        Bild_temp(m/2-150:m/2+150,n/2-150:n/2+150) = Image_SLM(:,:);
        Bild_test = im2uint8(Bild_test);
        Image_SLM = Bild_temp;
        Image_pair = [Bild_test,Image_SLM];
%         imwrite(Image_pair,strcat('Pair\',num2str(i),'_',num2str(j),'_X_Y','.jpg'),'jpg');
        imwrite(Image_pair,strcat('E:\Data\Pair\',num2str(i),'_',num2str(j),'_X_Y','.jpg'),'jpg');

        Bild = zeros(m,n);
    end
end
        
toc;




