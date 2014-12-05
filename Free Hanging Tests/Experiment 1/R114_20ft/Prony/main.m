% This is the main file

% close all
clc

dt=1/44100;
alpha=1024/2;r_H0=7;orm=0;
[freq_Hz,damping,Amp,theta]=ERA_hu(soundsample(1:12000),dt,alpha,r_H0,orm)