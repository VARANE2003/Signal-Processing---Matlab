clear;clc;close all
K = 10;
n = [-2000:4000]';
A = rand(1,K) - 1/2;
x = A .* ((n > 0) - (n - 1999 > 0));
Acor = x*x'/K;
Sd = 20*log10(fftshift(abs(fft2(Acor))));
%%
plot(n,x)
figure; imagesc(n,n,Acor)
figure; imagesc(Sd)


