clear;clc;close all

%% ΕΡΩΤΗΜΑ β)

% Parameters
K = 1000;
n = [-2000:4000]';

% Generating random amplitudes
A = rand(1,K) - 1/2;

% Generating the signal
x = A .* ((n > 0) - (n - 100 > 0));

% Plotting the signal
figure; plot(n,x);



% Calculate the stochastic mean at each time step
stochastic_mean = mean(x, 2);

% Plotting the stochastic mean
figure;
plot(n, stochastic_mean);
title('Stochastic Mean of the Process');
xlabel('Time (n)');
ylabel('Stochastic Mean');


% Plotting the stochastic mean as an image
figure; imagesc(n,n,stochastic_mean); colorbar;



%% ΕΡΩΤΗΜΑ γ)

% Computing the autocorrelation matrix
Acor = x*x'/K;

% Calculate the mean autocorrelation at each time step
mean_autocorr = mean(Acor, 2);


% Plotting the mean autocorrelation
figure;
plot(n, mean_autocorr);
title('Mean Autocorrelation of the Process');
xlabel('Lag');
ylabel('Autocorrelation');


% Plotting the autocorrelation matrix as an image
figure; imagesc(n,n,Acor); colorbar;


%% ΕΡΩΤΗΜΑ ε)

% Computing the spectral density
Sd = 20*log10(fftshift(abs(fft2(Acor))));

% Plotting the spectral density as an image
figure; imagesc(Sd);





%% ΑΣΚΗΣΗ 2 - ΙΔΙΑ ΕΡΩΤΗΜΑΤΑ ΜΕ ΠΡΙΝ ΜΕ ΧΡΗΣΗ ΤΗΣ randn


%% ΕΡΩΤΗΜΑ β)

% Parameters
K = 10000;
n = [-2000:4000]';

% Generating random amplitudes
A = randn(1,K) - 1/2;

% Generating the signal
x = A .* ((n > 0) - (n - 100 > 0));

% Plotting the signal
figure; plot(n,x);



% Calculate the stochastic mean at each time step
stochastic_mean = mean(x, 2);

% Plotting the stochastic mean
figure;
plot(n, stochastic_mean);
title('Stochastic Mean of the Process');
xlabel('Time (n)');
ylabel('Stochastic Mean');


% Plotting the stochastic mean as an image
figure; imagesc(n,n,stochastic_mean); colorbar;



%% ΕΡΩΤΗΜΑ γ)

% Computing the autocorrelation matrix
Acor = x*x'/K;

% Calculate the mean autocorrelation at each time step
mean_autocorr = mean(Acor, 2);


% Plotting the mean autocorrelation
figure;
plot(n, mean_autocorr);
title('Mean Autocorrelation of the Process');
xlabel('Lag');
ylabel('Autocorrelation');


% Plotting the autocorrelation matrix as an image
figure; imagesc(n,n,Acor); colorbar;


%% ΕΡΩΤΗΜΑ ε)

% Computing the spectral density
Sd = 20*log10(fftshift(abs(fft2(Acor))));

% Plotting the spectral density as an image
figure; imagesc(Sd);