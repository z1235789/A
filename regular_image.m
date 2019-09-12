clear all;
clc;
close all;

n = 640;
m = 480;
max = 1;
min = 0;
mean = (max+min)/2;

Bild = zeros(m,n);    %a black image
imwrite(Bild,strcat('a\','black','.jpg'),'jpg');

% figure;    

tic;
for i = 11:12
    for j = 11:12
        Bild(i,j) = max;
        
        %display can be hid
        %imshow(Bild);
        %hold on
        %title('Original image');
        
        %Dilate the spot in the Bild using the disk method and save it
        Bild_test = disk(Bild);    %Bild_test is X
        imwrite(Bild_test,strcat('Test\',num2str(i),'_',num2str(j),'_X','.jpg'),'jpg');
        
        
        Bild_SLM = ones(m,n);
        Image_SLM = capture(Bild_SLM,i,j);
        
%         X_Y = imshowpair(Bild_test,Image_SLM,'Montage');
%         saveas(gcf,strcat('Pair\',num2str(i),'_',num2str(j),'_X_Y','.jpg'));
        Image_pair = [Image_SLM;Bild_test];
        imwrite(Image_pair,strcat('Pair\',num2str(i),'_',num2str(j),'_X_Y','.jpg'),'jpg');

        Bild = zeros(m,n);
    end
end
        
toc;


function Bild_test = disk(Bild)
stru_size = 20;
se = strel('disk',stru_size);
Bild_test = imdilate(Bild,se);
end

function Image_SLM = capture(Bild_SLM,i,j)
vid = videoinput('winvideo',1,'YUY2_640x480');
set(vid,'ReturnedColorSpace','Grayscale'); 
set(vid,'TriggerRepeat',Inf);
set(vid,'FramesPerTrigger',10);
vid.FrameGrabInterval = 1;
% src = getselectedsource(vid);


while 1     
    pause(0.05);    %make the video stable
    [frame,metadata] = getsnapshot(vid);    %frame is the displayed image，metadata is a strut，records absolute time

%     display can be hid
%     figure;
%     imshow(frame);
%     title('Image');

    imwrite(frame,strcat('Label\',num2str(i),'_',num2str(j),'_Y','.jpg'),'jpg'); 
    Bild_SLM = frame;
    break;
end

Image_SLM = Bild_SLM;

end

%% this function is redundant
function Image_pair = pair(Bild_test,Image_SLM)
Image_pair = [Bild_test,Image_SLM];
end
