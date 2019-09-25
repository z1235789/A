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
