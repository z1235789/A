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
centre_x_y = centroid();
centre_x = centre_x(1);
centre_y = centre_y(2);

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
%         set(gcf,'outerposition', [1913         113        1936     1118]); % Shift to the screen of the SLM
        set(gca,'Position',[1300,240,1000,760]);    % Display the test bild in fix position(in 2nd screen)
        hold on    % The test bild should remain on the SLM

        imwrite(Bild_test,strcat('Test\',num2str(i),'_',num2str(j),'_X','.jpg'),'jpg');
        
        Bild_SLM = ones(m,n);
        Image_SLM = capture(Bild_SLM,i,j);    % Get the Bild from the SLM,then crop it
        
%         X_Y = imshowpair(Bild_test,Image_SLM,'Montage');    % There are two ways to connect the two Bild
%         saveas(gcf,strcat('Pair\',num2str(i),'_',num2str(j),'_X_Y','.jpg'));

        Bild_test = im2uint8(Bild_test);
        Image_pair = [Bild_test;Image_SLM];
        imwrite(Image_pair,strcat('Pair\',num2str(i),'_',num2str(j),'_X_Y','.jpg'),'jpg');

        Bild = zeros(m,n);
    end
end
        
toc;


%% f1
function centroid_x_y =centroid()    % The first function to run,returning the center calue of the spot
vid = videoinput('winvideo',2);    % Use the camera's default value
set(vid,'ReturnedColorSpace','Grayscale');     % Use the grayscale
set(vid,'TriggerRepeat',Inf);
set(vid,'FramesPerTrigger',10);
vid.FrameGrabInterval = 1;
% src = getselectedsource(vid);

frame = getsnapshot(vid);    % Frame is uint8
BW = im2bw(frame);    % This is a command be used in Matlab2015,in 2019 we use function imbinaize().
BW = bwconncomp(BW,8);
cent = regionprops(BW,'Centroid');
nspots = length(cent);
centre = zeros(nspots,1);
centre(1,:) = cent(1).Centroid; 

centroid_x_y = [centre(1),centre(2)];    % centroid_x_y is a 1*1 matrix,it's the return of this function

end


%% f2
function Bild_test = disk(Bild)
stru_size = 20;
se = strel('disk',stru_size);
Bild_test = imdilate(Bild,se);
end


%% f3
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
    Bild_SLM = crop(frame,centre_x,centre_y);    %the frame should be cut into a certain shape(size)

%     display can be hid
%     figure;
%     imshow(frame);
%     title('Image');

    imwrite(Bild_SLM,strcat('Label\',num2str(i),'_',num2str(j),'_Y','.jpg'),'jpg'); 
    break;
end

Image_SLM = Bild_SLM;

end


%%  f4
function Bild_SLM=crop(frame,centre_x,centre_y)
setsize = 200;
Bild_SLM = imcrop(frame,[centre_x-setsize/2, centre_y-setsize/2, setsize, setsize]);

end


%% this function is redundant
function Image_pair = pair(Bild_test,Image_SLM)
Image_pair = [Bild_test,Image_SLM];
end
