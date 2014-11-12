function [f] = modefreq(L,r,n,Y,d)
% L = Length of cable (meter)
% r = thickness of cable
% n = Mode
% T = Tension (Newton)
% rhoL = Mass per unit length (kg/meter)

% f_1 = 1.028.*(r./(L.^2)).*(sqrt(Y./d));
% f = 0.441.*((n+0.5).^2) .* f_1;
c = sqrt(Y/d);
f = (n./2) * ( c / L);
