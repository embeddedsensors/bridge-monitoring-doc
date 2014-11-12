clc; close all;
load R114_data.mat

fs_sound = 44100;

% Calculate time domain for contact mic and plot
i = 164000:1097000;
sound = metal_axial_piezo_midpoint;
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
myfft(soundsample,fs_sound);
title('Fourier Transform of midpoint sound sample')
xlabel('Frequency')
ylabel('Response')
axis([0 8000 0 30000])

save R114_data.mat