close all;clear;clc;

load Noisy

Fs = 44100;

%%
% ΑΣΚΗΣΗ 3 --> α)


%sound(yw, Fs)



%%
% ΑΣΚΗΣΗ 3 --> β)

NumFFT = 4096;
F = linspace(-Fs/2,Fs/2,NumFFT);

% Plot the frequency response in dB using fft()
figure
plot(F, 20*log(abs(fftshift(fft(yw,NumFFT)))));
title('Frequency response of yw (dB)')


%%
% ΑΣΚΗΣΗ 3 --> γ)
% Σχεδιάζουμε ένα φίλτρο για την αφαίρεση του θορύβου με το Filter Designer της MATLAB


% Equiripple Bandstop filter designed using the FIRPM function.

% All frequency values are in Hz.
Fs = 44100;  % Sampling Frequency

Fpass1 = 8000;    % First Passband Frequency
Fstop1 = 8100;    % First Stopband Frequency
Fstop2 = 8200;    % Second Stopband Frequency
Fpass2 = 8300;    % Second Passband Frequency
Dpass1 = 1;       % First Passband Ripple
Dstop  = 0.0001;  % Stopband Attenuation
Dpass2 = 1;       % Second Passband Ripple
dens   = 20;      % Density Factor


% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fpass1 Fstop1 Fstop2 Fpass2]/(Fs/2), [1 0 ...
                          1], [Dpass1 Dstop Dpass2]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});

% Φιλτράρουμε το σήμα με το φίλτρο που δημιουργήσαμε
y_clean = filtfilt(b, 1, yw);

% Filter's frequency response
figure;
freqz(b,1,512);


%%
% ΑΣΚΗΣΗ 3 --> δ)
% Ακούμε το φιλτραρισμένο σήμα
sound(y_clean, Fs);


%%
% ΑΣΚΗΣΗ 3 --> ε)
% Σχεδιάζουμε την κυματομορφή του θορύβου και του αποθορυβοποιημένου σήματος
num_samples = 250;

figure;
t = 0:num_samples-1;
subplot(2,1,1);
plot(t, yw(1:num_samples));
title('Noisy Signal');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, y_clean(1:num_samples));
title('Clean Signal');
xlabel('Samples');
ylabel('Amplitude');