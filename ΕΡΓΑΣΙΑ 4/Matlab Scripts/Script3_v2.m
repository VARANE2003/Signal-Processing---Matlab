clear; clc; close all

load eye.mat

%% ΕΡΩΤΗΜΑΤΑ α),β)


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



%% ΕΡΩΤΗΜΑ γ)

% creation of noise
even_noise = rand(size(approx));      
noisy_approx = approx + even_noise;

% noise distribution
figure;
histogram(even_noise(:),100);

% noisy image display
figure;
subplot(1,2,1); imshow(approx); title('Original Image');
subplot(1,2,2); imshow(noisy_approx); title('Noisy Image');


% check the central limit theorem from noisy_approx
% each pixel is a random variable
mean_noisy_approx = mean(noisy_approx(:));
std_noisy_approx = std(noisy_approx(:));

% normalize noisy_approx to get N(0,1)
normalized_noisy_approx = (noisy_approx - mean_noisy_approx)/std_noisy_approx;

figure; 
histogram(normalized_noisy_approx(:),100);

