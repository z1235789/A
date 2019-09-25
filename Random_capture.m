function Image_SLM = capture(Bild_test,i,j,m,n,centre_x,centre_y,a,b,t)
% vid = videoinput('winvideo',1,'YUY2_640x480');
vid = videoinput('winvideo',2,'RGB16_1280x1024');
set(vid,'ReturnedColorSpace','Grayscale'); 
set(vid,'TriggerRepeat',Inf);
set(vid,'FramesPerTrigger',10);
vid.FrameGrabInterval = 1;
% src = getselectedsource(vid);


while 1     
    pause(0.05);    %make the video stable
    [frame,metadata] = getsnapshot(vid);    %frame is the displayed image£¬metadata is a strut£¬records absolute time
    Bild_SLM = imcrop(frame,[centre_x-150, centre_y-150, 300 ,300]);    %the frame should be cut into a certain shape(size)

    imwrite(Bild_SLM,strcat('E:\Data\Label\',num2str(i),'_',num2str(j),'_',num2str(t),'_Y','.jpg'),'jpg'); 

%     display can be hid
%     figure;
%     imshow(frame);
%     title('Image');
    break;
end

Image_SLM = Bild_SLM;

Bild_temp = zeros(m,n);
Bild_temp = im2uint8(Bild_temp);
Bild_temp(m/2-150:m/2+150,n/2-150:n/2+150) = Image_SLM(:,:);
Bild_test = im2uint8(Bild_test);
Image_SLM = Bild_temp;
Image_pair = [Bild_test,Image_SLM];
imwrite(Image_pair,strcat('E:\Data\Pair\',num2str(i),'_',num2str(j),'_',num2str(t),'_X_Y','.jpg'),'jpg');

hold off
end
