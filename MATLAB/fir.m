clc; close all;
fir_filter = designed_filter();

f1 = 2e6; f2 = 30e6; % test signals frequencies
f3 = 45e6; % noise signal frequency
fs = 100e6; % sampling frequency
fc = 10e6;  % cutoff frequency

t = 0:1/fs:2e-6;

% first signal
signal_1 = sin(2*pi*f1*t);
figure;
subplot(4,1,1);
plot(t,signal_1);
title("Signal 1 at 2MHz");

filtered_signal_1 = filter(fir_filter,signal_1);

subplot(4,1,2);
plot(t,filtered_signal_1);
title("Signal 1 after filter");

% second signal
signal_2 = sin(2*pi*f2*t);
subplot(4,1,3);
plot(t,signal_2);
title("Signal 2 at 30MHz");

filtered_signal_2 = filter(fir_filter,signal_2);

subplot(4,1,4);
plot(t,filtered_signal_2);
title("Signal 2 after filter");

noise = sin(2*pi*f2*t) + sin(2*pi*f3*t); 
composed_signal = signal_1 + noise;

filtered_signal = filter(fir_filter,composed_signal);

figure
subplot(2,1,1);
plot(t,composed_signal);
title("Composed signal (Signal_1 + Noise)");

subplot(2,1,2);
plot(t,filtered_signal);
title("Composed signal after filter");
