% Generate a test signal
Fs = 1000; % Sampling frequency (Hz)
t = 0:1/Fs:1-1/Fs; % Time vector (seconds)
f1 = 10; % Frequency of signal 1 (Hz)
f2 = 100; % Frequency of signal 2 (Hz)
x = sin(2*pi*f1*t) + sin(2*pi*f2*t); % Signal with two frequencies

% Compute the FT of the signal
N = length(x); % Number of samples
X = fft(x); % Compute FFT
X_shifted = fftshift(X); % Shift zero frequency to center
f = Fs*(-N/2:N/2-1)/N; % Frequency vector (Hz)

% Plot the unshifted magnitude spectrum of the signal
figure;
plot(abs(X)/N);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of Test Signal (unshifted)');


% Plot the magnitude spectrum of the signal
figure;
plot(f, abs(X_shifted)/N);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of Test Signal (shifted)');


% Plot the phase spectrum of the signal
figure;
plot(f, angle(X));
xlabel('Frequency (Hz)');
ylabel('Phase');
title('Phase Spectrum of Test Signal');






% ΖΗΤΟΥΜΕΝΟ β)



b = [0.5 1 -0.5];  % Numerator coefficients (from the difference equation)
a = 1;             % Denominator coefficients (for FIR filter, typically set to 1)


[H, w] = freqz(b, a, 1024);  % Compute frequency response

% Plot the magnitude of the frequency response
figure;
plot(w/pi, 20*log10(abs(H)));
title('Magnitude Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;

% Plot the phase of the frequency response
figure;
plot(w/pi, angle(H));
title('Phase Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase (radians)');
grid on;



% ΖΗΤΟΥΜΕΝΟ δ)


% Define the input signal x[n]
n = 0:16000;
x = cos(pi * n / 4) - sin(pi * n / 2) + (-1/2).^n;

% Define the impulse response h[n]
h = [1/2, 1, -1/2];

% Perform convolution using conv() function
y = conv(x, h);

% Plot the output signal y[n]
figure;
stem(n, y(1:length(n)));
xlabel('n');
ylabel('y[n]');
title('Output Signal y[n]');




m = 0:99; % Consider only the first 100 samples
x = cos(pi * m / 4) - sin(pi * m / 2) + (-1/2).^m;

% Define the impulse response coefficients
b = [1/2, 1, -1/2];
a = 1;                      % Since it's a FIR filter, denominator coefficients are 1

% Perform filtering using filter() function
z = filter(b, a, x);

% Plot the output signal y[n]
figure;
stem(m, z(1:length(m)));
xlabel('n');
ylabel('y[n]');
title('Output Signal y[n] (Filtered using filter() function, first 100 samples)');






% ΖΗΤΟΥΜΕΝΟ ε.i)
% |DFT{x}|



% Compute the FT of signal x[n]
N = length(x); % Number of samples
X = fft(x); % Compute FFT
X_shifted = fftshift(X); % Shift zero frequency to center
f = Fs*(-N/2:N/2-1)/N; % Frequency vector (Hz)


% Plot the SHIFTED magnitude spectrum of signal x[n]
figure;
plot(f, abs(X_shifted)/N);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of Signal (shifted)');






% ΖΗΤΟΥΜΕΝΟ ε.ii)
% |DFT{y}|


% Compute the FT of signal y[n] = x[n] * h[n]
N = length(y); % Number of samples
Y = fft(y); % Compute FFT
Y_shifted = fftshift(Y); % Shift zero frequency to center
f = Fs*(-N/2:N/2-1)/N; % Frequency vector (Hz)


% Plot the SHIFTED magnitude spectrum of signal y[n] = x[n] * h[n]
figure;
plot(f, abs(Y_shifted)/N);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of Signal (shifted)');





% ΖΗΤΟΥΜΕΝΟ στ)


num_experiments = 10000;    % πλήθος πειραμάτων
min_exponent = 6;           
max_exponent = 15;


exponents = min_exponent:max_exponent;  
lengths_power_2 = 2 .^ exponents;     % Δημιουργία μεγεθών ακολουθίας(δυνάμεις του 2)  
lengths = 2 .^ exponents - 1;         % Δημιουργία μεγεθών ακολουθίας(2^x-1)


% Αποθήκευση χρόνων FFT για κάθε μέγεθος ακολουθίας   
results_FFT_1 = zeros(length(lengths_power_2), 1);  
results_FFT_2 = zeros(length(lengths), 1);  


for i = 1:length(exponents)
    
    % Δημιουργία τυχαίας ακολουθίας
    sequence_length_1 = lengths_power_2(i);
    sequence_1 = rand(sequence_length_1, 1); 

    sequence_length_2 = lengths(i);
    sequence_2 = rand(sequence_length_2, 1);
    


    % Μέτρηση χρόνου για FFT
    tic;
    for j = 1:num_experiments
        fft_result_1 = fft(sequence_1);
    end
    time_FFT_1 = toc;

    tic;
    for j = 1:num_experiments
        fft_result_2 = fft(sequence_2);
    end
    time_FFT_2 = toc;

    
    results_FFT_1(i) = (time_FFT_1 / num_experiments) * 10^6;
    results_FFT_2(i) = (time_FFT_2 / num_experiments) * 10^6;
end

% Εκτύπωση αποτελεσμάτων
disp('Μήκος Ακολουθίας, Χρόνος Εκτέλεσης(μsec)');
format short g;                                % just a command i googled to suppress 
                                               % the scaling factor applied by Matlab 
                                               % due to numbers being too small
disp([lengths_power_2' results_FFT_1]);
disp([lengths' results_FFT_2]);