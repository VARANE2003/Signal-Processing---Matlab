clear
close all
clc

%% ΕΡΩΤΗΜΑ ζ) -  error of noise approximation by the Wiener filter of length 4


% Signal Generation
n=0:1000;
phi = rand(1)*2*pi;        % random phase uniformly distributed between 0 and 2π
s = sin(0.25*n+phi);      


% White Gaussian Noise Generation
w = randn(1,length(n));
v = filter(1,[1,-0.6],w); 
x = s + w;


v1 = v(1:end-3);
v2 = v(2:end-2);
v3 = v(3:end-1);
v4 = v(4:end);

V = [v4;v3;v2;v1];
Rvv = V*V'/length(v1);  

rwv = zeros(4,1);
rwv(1) = sum(v(4:end) .* w(4:end));
rwv(2) = sum(v(3:end-1) .* w(4:end));
rwv(3) = sum(v(2:end-2) .* w(4:end));
rwv(4) = sum(v(1:end-3) .* w(4:end));

rwv = rwv / (length(v1) - 3);

hW = Rvv\rwv;    

w_hat = filter(hW,1,v);

error4 = norm(w-w_hat)

