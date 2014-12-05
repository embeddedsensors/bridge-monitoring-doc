clc; close all;
% load R114_data.mat

fs_sound = fs;
%  note, higher frequencies deminish when tested 
%  from the far end point and when using rubber. 
% 424 Hz still fully developed. 
% Calculate time domain for contact mic and plot
i = 1.28e5:4.837e5;
sound = data- mean(data);
sound_length_s = length(sound)/fs_sound;
sound_domain = linspace(0,sound_length_s,length(sound));
soundsample = sound(i);
sound_time = sound_domain(i) - sound_domain(i(1));

figure()
set(gca,'fontsize', 18);
plot(sound_time,soundsample)
title('Sound Waveform vs Time')
ylabel('Sound Intensity')
xlabel('Time (s)')

% Frequency content of each sample
figure()
set(gca,'fontsize', 18);
myfft(soundsample,fs_sound);
title('FFT of transverse rubber strike recorded from the midpoint')
xlabel('Frequency')
ylabel('Response')
% axis([0 8000 0 30000])

save R114_data.mat