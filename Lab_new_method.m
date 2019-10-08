function centroid_x_y = centroid_x_y()    % The first function to run,returning the center value of the beam-spot
% vid = videoinput('winvideo',2);    % Use the camera's default value
vid = videoinput('winvideo',2,'RGB16_1280x1024');
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
centre = zeros(nspots,2);
centre(1,:) = cent(1).Centroid; 

centroid_x_y = [centre(1,1),centre(1,2)];
%centroid_x_y = [centre(1),centre(2)];    % centroid_x_y is a 1*1 matrix,it's the return of this function

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all;
clear;
clc;
close all;

n = 1920; % Resolution of monitor 1080*768
m = 1080;
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

for i = 1:1:10
    j = 1;
    Random_spots(Bild,i,j,n,m,centre_x,centre_y);
    Bild = zeros(m,n);
end
        
toc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%                                        %%%%%%%%%%%%%%
function Random_spots = Random_spots(Bild,i,j,n,m,centre_x,centre_y)

Image = imread('sample.jpg');
Image = 255 - Image;    % Reverse the gray image
% sz = size(Image);
[l,w] = size(Image);
t = 6001;

min_m = l+1;    
max_m = 1080-(l+1);    
min_n = l+1;
max_n = 1920-(l+1);    %Prevent data overflow range
Random_m = min_m + (max_m - min_m).*(rand(t,1));    
Random_n = min_n + (max_n - min_n).*(rand(t,1));    %Generate random numbers for coordinates
Mat = [Random_m,Random_n];    %Just to see all generated random values

% start_x = 1300;
% start_y = 200;
% col = 1000;
% raw = 760;

Bild_test = zeros(m,n);
Bild_test = Bild;  % Black image
for t = 1:1:t
    for a = 1:l
        for b = 1:w
%             raw = (j-50)+a+round(Random_m(t));
%             col = (i-50)+b+round(Random_n(t));
            raw = a+round(Random_m(t));    %This is the raw coordinate.
            col = b+round(Random_n(t));    %This is the col coordinate.
            pos = [raw,col];
            Bild_test((raw),(col)) = Image(a,b);
%             Bild_test((i-50+round(Random_n(t))),(j-50+round(Random_m(t)))) = Image(a,b);
        end        
    end
    if mod(t-1,1000) == 0    %mod(a,b),in this work,number b can change the rate of save picture
        Bild_test = mat2gray(Bild_test);   % Change the data to grayscale(0,1) 
        imshow(Bild_test);
    %     colormap(gray(256));
    %     imshow(Bild_test,[0,255]);    %This way can display the sample,but loss lots of information
    %     set(gcf,'Position',[start_x start_y col raw]);
        set(gcf,'Position',[1300,200,1000,760]);

        hold on
        imwrite(Bild_test,strcat('E:\Data\Test\',num2str(i),'_',num2str(j),'_',num2str(t),'_X','.jpg'),'jpg');

        Random_capture(Bild_test,i,j,m,n,centre_x,centre_y,a,b,t);
        hold off

        [Bild_test,gray] = gray2ind(Bild_test,255); % Revers the matrix to ind(0,255)
    end
end

% colormap(gray(256));
% imshow(Bild_test,[0,255]);
% set(gcf,'Position',[start_x start_y col raw])

Random_spots = Bild_test;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Image_SLM = capture(Bild_test,i,j,m,n,centre_x,centre_y,a,b,t)
% vid = videoinput('winvideo',1,'YUY2_640x480');
vid = videoinput('winvideo',2,'RGB16_1280x1024');
set(vid,'ReturnedColorSpace','Grayscale'); 
set(vid,'TriggerRepeat',Inf);
set(vid,'FramesPerTrigger',10);
vid.FrameGrabInterval = 1;
% src = getselectedsource(vid);

half_crop_range = 250;
while 1     
    pause(0.05);    %make the video stable
    [frame,metadata] = getsnapshot(vid);    %frame is the displayed image£¬metadata is a strut£¬records absolute time
%     Bild_SLM = imcrop(frame,[centre_x-half_crop_range, centre_y-half_crop_range, 2*half_crop_range ,2*half_crop_range]);    %the frame should be cut into a certain shape(size)
    Bild_SLM = frame;
    imwrite(frame,strcat('E:\Data\Label\',num2str(i),'_',num2str(j),'_',num2str(t),'_Y','.jpg'),'jpg');     %the label's resolution is 1280*1024 

%     display can be hid
%     figure;
%     imshow(frame);
%     title('Image');
    break;
end

Image_SLM = Bild_SLM;    

Bild_temp = zeros(m,n);
Bild_temp = im2uint8(Bild_temp);
Bild_temp(m/2-511:m/2+512,n/2-639:n/2+640) = Image_SLM(:,:);
Bild_test = im2uint8(Bild_test);
Image_SLM = Bild_temp;
Image_pair = [Bild_test,Image_SLM];
imwrite(Image_pair,strcat('E:\Data\Pair\',num2str(i),'_',num2str(j),'_',num2str(t),'_X_Y','.jpg'),'jpg');

hold off
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
clc;
close all

% x_res = 1920; % Aufl?ung des SLM eingeben
% y_res = 1080;
x_res = 500; % Aufl?ung des SLM eingeben
y_res = 500;
[X,Y] = meshgrid(1:1:x_res, 1:1:y_res);
[X2,Y2] = meshgrid(-x_res/2:1:x_res/2-1, -y_res/2:1:y_res/2-1);

% Spot 1:
shift_x1 = 0; % Auslenkung in x-Richtung, max. Sichtbereich auf CMOS: x = 
shift_y1 = 0; % Auslenkung in y-Richtung, max. Sichtbereich auf CMOS: y = 
shift_z1 = 0.0001; % Verschiebung in z-Richtung (Positiv: verk?zter Fokus, Negativ: verl?gerter Fokus); Achtung: ?derung sehr gro?!

phi1 = mod(1/100 * (2*pi*shift_x1*X + 2*pi*shift_y1*Y)+shift_z1*(X2.^2+Y2.^2),2*pi);

% Spot 2:
shift_x2 = 0;
shift_y2 = 0;
shift_z2 = 0;

phi2 = mod(1/100 * (2*pi*shift_x2*X + 2*pi*shift_y2*Y)+shift_z2*(X2.^2+Y2.^2),2*pi);

% F? den erhalt der 0ten-Ordung: Spot mit x/y/z=0 (ergibt bei der Superposition +1)

%Random Image:
phi_random = rand([1080 1920]);
maxv=max(max(phi_random));
minv=min(min(phi_random));
max_soll=2*pi; %Nach SLM Gamma Curve: max 166
min_soll=0;
As=((phi_random-minv)/(maxv-minv)*(max_soll-min_soll))+min_soll;

% Superposition der einzelnen Spots:
superpos = exp(1i.*phi1) + exp(1i*phi2);% + exp(1i.*As); 
% Ermittlung der Phase:
phi_sp = angle(superpos); % phi_superposition

%Graustufenbild
maxv=max(max(phi_sp));
minv=min(min(phi_sp));
max_soll=255; %Nach SLM Gamma Curve
min_soll=0;
phi_sp_gv=uint8(((phi_sp-minv)/(maxv-minv)*(max_soll-min_soll))+min_soll); %grey value

% Phasenfunktion anzeigen auf dem SLM (2. Bildschirm):
figure()
% set(gcf,'outerposition', [1913         113        1936     1118]); % Verschiebung auf den Bildschirm des SLM
% set(gca,'Position', [0 0 1 1]);
set(gca,'Visible', 'Off');
set(gcf,'menubar','none');
imshow(phi_sp_gv);
imwrite(phi_sp_gv,'ring.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R = imread('ring.jpg');

figure()

subplot(2,2,1);
imshow(R);
title('Ring');
R_s = imresize(R,0.05,'nearest');
subplot(2,2,2);
imshow(R_s);
title('Sample');
imwrite(R_s,'Sample.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
