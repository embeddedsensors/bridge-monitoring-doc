clc; close all;
load R114_data.mat

fs_accel = 2048;
fs_sound = 44100;
%% Import initial data

% Calculate time domain for accelerometer and plot
accel_length_s = length(Ch1)/fs_accel;
accel_domain = linspace(0,accel_length_s,length(Ch1));
accelCh1 = Ch1(1887:end);
accel_time = accel_domain(1887:end) - accel_domain(1887);
figure()
plot(accel_time,accelCh1)

% Calculate time domain for sound recorder and plot

sound_length_s = length(sound)/fs_sound;
sound_domain = linspace(0,sound_length_s,length(sound));
soundsample = sound(308200:991600);
sound_time = sound_domain(308200:991600) - sound_domain(308200);

figure()
plot(sound_time,soundsample)

% Frequency content of each sample
figure()
myfft(accelCh1,fs_accel);
figure()
myfft(soundsample,fs_sound);

save R114_data.mat