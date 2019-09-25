% function Te_sample = Te_sample()
Te_sample = zeros(100,100);
I = imread('sample.jpg');
figure();
subplot(2,2,1);
imshow(I);

for a = 1:25
    for b = 1:25
        Te_sample(38+a,38+b) = I(a,b);
    end
end

subplot(2,2,2);
Te_sample = mat2gray(Te_sample);
imshow(Te_sample);
imwrite(Te_sample,'Te_sample.jpg','jpg');

subplot(2,2,3);
[Re_sample,gray] = gray2ind(Te_sample,16);
imshow(Re_sample,gray);

% end
