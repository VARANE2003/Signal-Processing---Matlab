clear; clc; close all

load eye.mat

% display only the first image from the loaded data
figure;
imshow(I(:,:,1))

% calculates the mean of all images along the third dimension and 
% display the mean image
approx = mean(I,3);
figure
imshow(approx); 


% noise added to each image
% calculated by subtracting the mean image (approx) from each image in I
noise = I - repmat(approx,[1,1,size(I,3)]);


%calculate the noise statistics
mean_noise = mean(noise(:))
std_noise = std(noise(:))

% noise distribution
figure;
histogram(noise(:),100);

% check the central limit theorem from approx
% each pixel is a random variable
mean_approx = mean(approx(:));
std_approx = std(approx(:));

% normalize approx to get N(0,1)
normalized_approx = (approx - mean_approx)/std_approx;

figure; 
histogram(normalized_approx(:),100);

