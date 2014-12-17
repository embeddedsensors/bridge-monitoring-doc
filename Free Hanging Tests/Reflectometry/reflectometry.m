clear all; close all; clc
load reflection_test/1.1mhz_free.mat

plot(t,Data)

[q, r] = deconv(Data(:,1), Data(:,2));

plot(t,r)