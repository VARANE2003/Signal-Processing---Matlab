close all;clear;clc;

N = 29;
fc = 0.2;  % ωc=0.4*pi

hc1 = fir1(N-1,fc,'low');
hc2 = fir1(N-1,fc,'high');



% Impulse Response of highpass fir filter hc1
figure
stem(hc1);
title('Filter Impulse Response');
grid on

% Impulse Response of highpass fir filter hc2
figure
stem(hc2);
title('Filter Impulse Response');
grid on



% Frequency Response of highpass fir filter hc1 using freqz()
figure
freqz(hc1,1,512);
title('Filter Frequency Response');
grid on

% Frequency Response of highpass fir filter hc2 using freqz()
figure
freqz(hc1,1,512);
title('Filter Frequency Response');
grid on



%%

NumFFT = 4096;
Freqs = linspace(-pi,pi,NumFFT);

figure
plot(Freqs, abs(fftshift(fft(hc1,NumFFT))));
title('Filter frequency response')
grid on

figure
plot(Freqs, 20*log10(abs(fftshift(fft(hc1,NumFFT)))));
title('Filter frequency response (dB)')
grid on

figure
plot(Freqs, angle(fft(hc1,NumFFT)));
title('Filter frequency response (dB)')
grid on


% ΑΣΚΗΣΗ 1 --> γράφος μέτρου απόκρισης συχνότητας για FIR highpass filter
% shifted frequency response of highpass fir filter hc2
figure
plot(Freqs, 20*log10(abs(fftshift(fft(hc2,NumFFT)))));
title('Filter frequency response (dB)')
grid on


%%

% ΑΣΚΗΣΗ 1 --> β) γράφοι μέτρου απόκρισης συχνότητας για FIR highpass και lowpass φίλτρα
% χρήση της firls()

h_low = firls(N-1,[0, 0.1, 0.35, 1] , [1 1 0 0]);
h_high = firls(N-1,[0, 0.1, 0.35, 1] , [0 0 1 1]);

figure
plot(Freqs, 20*log(abs(fftshift(fft(h_low,NumFFT)))));
title('Filter frequency response (dB)')
grid on

hold on
plot(Freqs, 20*log10(abs(fftshift(fft(h_high,NumFFT)))));
title('Filter frequency response (dB)')
grid on

%%

% ΑΣΚΗΣΗ 1 --> γ) γράφοι μέτρου απόκρισης συχνότητας για FIR highpass και lowpass φίλτρα
% χρήση της firpm()

h_low = firpm(N-1,[0, 0.1, 0.35, 1] , [1 1 0 0]);
h_high = firpm(N-1,[0, 0.1, 0.35, 1] , [0 0 1 1]);

figure
plot(Freqs, 20*log(abs(fftshift(fft(h_low,NumFFT)))));
title('Filter frequency response (dB)')
grid on

hold on
plot(Freqs, 20*log10(abs(fftshift(fft(h_high,NumFFT)))));
title('Filter frequency response (dB)')
grid on