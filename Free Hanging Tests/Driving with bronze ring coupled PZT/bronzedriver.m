clear; clc; close all
[sounddata, fs1] = wavread('audio_data/singlebar-0-30khz_sweep.wav');
[multbar, fs2] = wavread('audio_data/mult-bars_outerbar-0-30khz_sweep.wav');

sound = multbar;
fs = fs2;
slength = length(sound);
time = slength/fs;
timedomain = linspace(0,time,fs*time+1);
activetimedomain = timedomain(8*fs:end-fs);
activesounddata = sound(8*fs:end-fs);
plot(activetimedomain,activesounddata)

figure()
fft = myfft(activesounddata,fs);

figure()
window = activetimedomain(1:1000:end);
[S,F,T] = spectrogram(activesounddata,window,[],[],44100);
pcolor(T,F,abs(S));shading interp;