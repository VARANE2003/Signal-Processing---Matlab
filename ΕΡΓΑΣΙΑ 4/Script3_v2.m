clear; clc; close all

load eye.mat

% first image
figure;
imshow(I(:,:,1))

% mean image 
approx = mean(I,3);
figure
imshow(approx); 

% noise added to each image
noise = I - repmat(approx,[1,1,size(I,3)]);

%calculate the noise statistics
mean_noise = mean(noise(:)); 
std_noise = std(noise(:));

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

