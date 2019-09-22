function centroid_x_y =centroid()    % The first function to run,returning the center value of the beam-spot
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
