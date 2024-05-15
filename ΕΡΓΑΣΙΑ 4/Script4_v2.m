clear
close all
clc

n=0:1000;
phi = rand(1)*2*pi;
s = sin(0.25*n+phi);

w = randn(1,length(n));
v = filter(1,[1,-0.6],w); 
x = s + w;

%find the autocorrelation
v1 = v(1:end-1);
v2 = v(2:end);

V = [v2;v1];
Rvv = V*V'/length(v1);

%find the crosscorrelation
rwv = zeros(2,1);
rwv(1) = sum(v(2:end) .* w(2:end));
rwv(2) = sum(v(1:end-1) .* w(2:end));

% Normalize rsx
rwv = rwv / (length(v) - 1);

% Wiener filter coefficients
hW = Rvv\rwv;
% hW = [    ]

%apply to colored noise to make it white again 
w_hat = filter(hW,1,v);

norm(w-w_hat) %to minimize

x_hat = x-w_hat;

subplot(131);plot(s);title('original');
subplot(132);plot(x);title('Noisy');
subplot(133);plot(x_hat);title('Filtered');