n = linspace(1,10,10); % Enter in desired modes
youngs = 200e+9;
density = 7800;
L = 6.096; %20 ft length of steel cable
r = 0.00635; %thickness in meters

frn = modefreq(L,r,n,youngs,density)
figure()
plot(frn(1:8),n(1:8),'--r')
hold on
plot(data,n(1:8),'o')
title('Theoretical Vs. Experimental Frequencies')
xlabel('Frequency (Hz)')
ylabel('Mode (n)')

