load chirp
y0=y;
noise =0.5*randn(size(y));
Fs = 8192;

yw = y0 + noise;


NumFFT = 4096;
F = linspace(-Fs/2,Fs/2,NumFFT);


% Windows Visualization Tool to view Chebyshev window in time and frequency domain
% w=chebwin(35,30);
% wvtool(w);




% ΑΣΚΗΣΗ 2 --> α)

b1 = fir1(34,0.48,'high',chebwin(35,30));

% frequency response of highpass filter b1 using freqz()
freqz(b1,1,512);  


% Plot the frequency response in dB using fft()
figure
plot(F, 20*log(abs(fftshift(fft(b1,NumFFT)))));
title('Filter frequency response-fir1 (dB)')



yf1 = filtfilt(b1,1,yw);


% representation of signals y0,yw,yf in the frequency domain
figure
subplot(131);plot(F, abs(fftshift(fft(y0,NumFFT))))
subplot(132);plot(F, abs(fftshift(fft(yw,NumFFT))))
subplot(133);plot(F, abs(fftshift(fft(yf1,NumFFT))))


% listening to each of the above signals
% sound(y, Fs)
% sound(yw, Fs)
% sound(yf1, Fs)




% ΑΣΚΗΣΗ 2 --> β)

b2 = firls(34, [0, 0.48, 0.5, 1], [0 0 1 1]);
yf2 = filtfilt(b2,1,yw);

% Plot the frequency response
figure
plot(F, 20*log(abs(fftshift(fft(b2,NumFFT)))));
title('Filter frequency response-firls (dB)')
grid on

% listening to the signals
% sound(y, Fs)
% sound(yw, Fs)
% sound(yf2, Fs)



% ΑΣΚΗΣΗ 2 --> γ)

b3 = firpm(34, [0, 0.48, 0.5, 1], [0 0 1 1]);
yf3 = filtfilt(b3,1,yw);

% Plot the frequency response
figure
plot(F, 20*log(abs(fftshift(fft(b3,NumFFT)))));
title('Filter frequency response-firpm (dB)')
grid on

% listening to the signals
% sound(y, Fs)
% sound(yw, Fs)
% sound(yf3, Fs)





%%

% ΑΣΚΗΣΗ 2 --> δ)


% Απεικόνιση πρώτων και τελευταίων 100 δειγμάτων
start_idx = 1;
end_idx = 100;

% Αποθορυβοποίηση των σημάτων
yf1 = filtfilt(b1, 1, yw);
yf2 = filtfilt(b2, 1, yw);
yf3 = filtfilt(b3, 1, yw);

% Αποθορυβοποιημένα σήματα πρώτων και τελευταίων 100 δειγμάτων
yf1_first_last = [yf1(start_idx:end_idx), yf1(end-99:end)];
yf2_first_last = [yf2(start_idx:end_idx), yf2(end-99:end)];
yf3_first_last = [yf3(start_idx:end_idx), yf3(end-99:end)];
yo_first_last = [y0(start_idx:end_idx), y0(end-99:end)];

% Χρόνος για τον άξονα x
t = (0:length(yf1)-1) / Fs;

% Απεικόνιση των σημάτων
figure;
subplot(4, 1, 1);
plot(t(start_idx:end_idx), yf1(start_idx:end_idx));
title('First 100 Samples of yf1(n)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 1, 2);
plot(t(end-99:end), yf1(end-99:end));
title('Last 100 Samples of yf1(n)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 1, 3);
plot(t(start_idx:end_idx), yo_first_last(start_idx:end_idx));
title('First 100 Samples of yo(n)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 1, 4);
plot(t(end-99:end), yo_first_last(end-99:end));
title('Last 100 Samples of yo(n)');
xlabel('Time (s)');
ylabel('Amplitude');



%%

% ΑΣΚΗΣΗ 2 --> ε)


% Υπολογισμός MSE για κάθε σήμα
mse1 = mean((y0 - yf1).^2);
mse2 = mean((y0 - yf2).^2);
mse3 = mean((y0 - yf3).^2);

% Εκτύπωση MSE
disp(['MSE for yf1: ', num2str(mse1)]);
disp(['MSE for yf2: ', num2str(mse2)]);
disp(['MSE for yf3: ', num2str(mse3)]);
