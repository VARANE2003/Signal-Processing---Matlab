clear
close all
clc

% Signal Generation
n=0:1000;
phi = rand(1)*2*pi;        % random phase uniformly distributed between 0 and 2π
s = sin(0.25*n+phi);      


% White Gaussian Noise Generation
w = randn(1,length(n));
v = filter(1,[1,-0.6],w); 
x = s + w;

% White Noise statistics
mean_v = mean(v)
var_v = var(v)




% Computing the spectral density of Colored Noise
Sd = 20*log10(fftshift(abs(fft2(v))));

% Displaying it as an image
figure; imagesc(Sd); colorbar;

% White Noise distribution
figure;
histogram(w(:),100); title('White Noise');

% Colored Noise distribution
figure;
histogram(v(:),100); title('Colored Noise');







%%
%{% Autocorrelation of the White Noise --> not wanted in the exercise

w1 = w(1:end-1);
w2 = w(2:end);
W = [w2;w1];
Rww = W*W'/length(w1);

%}
%%





% Autocorrelation of the Colored Noise 
% v1 and v2 are shifted versions of the colored noise v.
% V is a matrix with v2 as the first row and v1 as the second row.
v1 = v(1:end-1);
v2 = v(2:end);

V = [v2;v1];
Rvv = V*V'/length(v1);    % autocorrelation matrix of v




% Cross-Correlation between Colored Noise and White Noise
rwv = zeros(2,1);
rwv(1) = sum(v(2:end) .* w(2:end));
rwv(2) = sum(v(1:end-1) .* w(2:end));

% Normalize rsx
rwv = rwv / (length(v) - 1);



% Wiener filter coefficients (solving the linear system Rvv*h=rwv)
hW = Rvv\rwv;    


% apply to Colored Noise to make it white again 
w_hat = filter(hW,1,v);


% error of noise approximation by the Wiener filter
norm(w-w_hat)   


% Noise Removal
x_hat = x-w_hat;

figure;
subplot(131);plot(s);title('original');
subplot(132);plot(x);title('Noisy');
subplot(133);plot(x_hat);title('Filtered');



%% ΕΡΩΤΗΜΑ δ)

mean_s = mean(s);
figure; 
imagesc(mean_s); colorbar; title('Mean of s(n)');


crosscor_s = xcorr(s, 'coeff');
figure; 
imagesc(crosscor_s / length(s)); colorbar; title('Autocorrelation of s(n)');


%% ΕΡΩΤΗΜΑ στ)








