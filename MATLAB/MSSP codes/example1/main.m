% This is the main file

clear all
close all
clc

SigGeneration;

alpha=5;r_H0=5;orm=0;
[freq_Hz,damping,Amp,theta]=ERA_hu(sig,dt,alpha,r_H0,orm)