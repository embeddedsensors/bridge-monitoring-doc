
% this file generate the harmonic signal to be tested
dt=0.05;
N=1024;
t=0*dt:dt:(N-1)*dt;
t=t';

C1=1.6; f1=2.00;theta1=pi/4;
C2=2.0; f2=2.02;theta2=-pi/8;
C3=3.0; f3=2.04;theta3=-3*pi/4;
C4=1.4; f4=2.40;theta4=pi/2;
C5=3.6; f5=3.00;theta5=pi/8;

sig1=C1.*cos(2*pi*f1.*t+theta1);
sig2=C2.*cos(2*pi*f2.*t+theta2);
sig3=C3.*cos(2*pi*f3.*t+theta3);
sig4=C4.*cos(2*pi*f4.*t+theta4);
sig5=C5.*cos(2*pi*f5.*t+theta5);

sig=sig1+sig2+sig3+sig4+sig5;

figure
plot(t,sig)
grid on
xlim([0*N (N-1)*dt])
xlabel('Time (s)')
ylabel('Signal')