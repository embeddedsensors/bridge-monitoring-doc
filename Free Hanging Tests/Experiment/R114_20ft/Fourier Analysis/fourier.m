clc; close all;
load R114_data.mat

fs_accel = 2048;
fs_sound = 44100;
%% Import initial data

% Calculate time domain for accelerometer and plot
accel_length_s = length(Ch1)/fs_accel;
accel_domain = linspace(0,accel_length_s,length(Ch1));
accelCh1 = Ch1(1887:end);
% accelCh1 = Ch2(1887:end);
accel_time = accel_domain(1887:end) - accel_domain(1887);
figure()
plot(accel_time,accelCh1)
title('Accelerometer Waveform vs Time')
ylabel('Longitudinal Acceleration (g)')
xlabel('Time (s)')

% Calculate time domain for sound recorder and plot
i = 77780:304200;
sound = mp_wo_accel;
i = 250000 : 300000;
sound_length_s = length(sound)/fs_sound;
sound_domain = linspace(0,sound_length_s,length(sound));
soundsample = sound(i);
sound_time = sound_domain(i) - sound_domain(i(1));

figure()
plot(sound_time,soundsample)
title('Sound Waveform vs Time')
ylabel('Sound Intensity')
xlabel('Time (s)')

% Frequency content of each sample
figure()
myfft(accelCh1,fs_accel);
title('Fourier Transform of midpoint accelerometer')
figure()
myfft(soundsample,fs_sound);
title('Fourier Transform of midpoint sound sample')

save R114_data.mat