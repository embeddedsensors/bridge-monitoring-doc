% this is the main file

clear all
close all
clc

SigGeneration;

alpha=round(length(sig)/2);r_H0=10;orm=0;
[freq_Hz,damping,Amp,theta]=ERA_hu(sig,dt,alpha,r_H0,orm);
VSDFT;
Prediction;