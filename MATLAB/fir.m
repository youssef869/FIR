clc; close all;
fir_filter = designed_filter();

f1 = 1e3; f2 = 3.4e3; f3 = 15e3; % test signals frequencies
fn1 = 18e3; fn2 = 21e3; % noise frequencies
fs = 44.1e3;  % Sampling Frequency
fc   = 3.4e3;      % Cutoff Frequency

t = 0:1/fs:10e-3;


% first signal
signal_1 = sin(2*pi*f1*t);
figure;
subplot(6,1,1);
plot(t,signal_1);
title("Signal 1 at 2kHz");

filtered_signal_1 = filter(fir_filter,signal_1);

subplot(6,1,2);
plot(t,filtered_signal_1);
title("Signal 1 after filter");

% second signal
signal_2 = sin(2*pi*f2*t);
subplot(6,1,3);
plot(t,signal_2);
title("Signal 2 at 3.4kHz");

filtered_signal_2 = filter(fir_filter,signal_2);

subplot(6,1,4);
plot(t,filtered_signal_2);
title("Signal 2 after filter");

% third signal
signal_3 = sin(2*pi*f3*t);
subplot(6,1,5);
plot(t,signal_3);
title("Signal 3 at 8kHz");

filtered_signal_3 = filter(fir_filter,signal_3);

subplot(6,1,6);
plot(t,filtered_signal_3);
title("Signal 3 after filter");

%noise part
noise = sin(2*pi/fn1*t) + sin(2*pi*fn2*t);

noisy_signal = signal_1 + noise;

filtered_signal = filter(fir_filter,noisy_signal);

figure;

subplot(3,1,1);
plot(t,signal_1);
title("Original signal");

subplot(3,1,2);
plot(t,noisy_signal);
title("Noisy signal");


subplot(3,1,3);
plot(t,filtered_signal);
title("Filtered signal");