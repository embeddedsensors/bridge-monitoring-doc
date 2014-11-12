n = linspace(1,100,100); % Enter in desired modes
youngs = 200e+9;
density = 7800;
L = 6.096; %20 ft length of steel cable
r = 0.00635; %thickness in meters

frn = modefreq(L,r,n,youngs,density)
figure(1)
plot(frn,n)
