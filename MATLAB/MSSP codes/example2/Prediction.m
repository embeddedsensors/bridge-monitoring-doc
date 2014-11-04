% This matlab aims at predicting the wave data and showing the difference
% between FFT and the new method.
figure

t=800*dt:0.05*dt:1200*dt;
t1=800*dt:0.05*dt:1023*dt;
t2=1024*dt:0.05*dt:1200*dt;

C1=1.6; f1=2.00;theta1=pi/4;
C2=2.0; f2=2.02;theta2=-pi/8;
C3=3.0; f3=2.04;theta3=-3*pi/4;
C4=1.4; f4=2.40;theta4=pi/2;
C5=3.6; f5=3.00;theta5=pi/8;
Comp1=C1.*cos(2*pi*f1.*t+theta1);
Comp2=C2.*cos(2*pi*f2.*t+theta2);
Comp3=C3.*cos(2*pi*f3.*t+theta3);
Comp4=C4.*cos(2*pi*f4.*t+theta4);
Comp5=C5.*cos(2*pi*f5.*t+theta5);
sig_2=Comp1+Comp2+Comp3+Comp4+Comp5;% New method's prediction

Comp1=C1.*cos(2*pi*f1.*t1+theta1);
Comp2=C2.*cos(2*pi*f2.*t1+theta2);
Comp3=C3.*cos(2*pi*f3.*t1+theta3);
Comp4=C4.*cos(2*pi*f4.*t1+theta4);
Comp5=C5.*cos(2*pi*f5.*t1+theta5);
Predict_fft_1=Comp1+Comp2+Comp3+Comp4+Comp5;

t2_2=(1024-1024)*dt:0.05*dt:(1200-1024)*dt;
Comp1=C1.*cos(2*pi*f1.*t2_2+theta1);
Comp2=C2.*cos(2*pi*f2.*t2_2+theta2);
Comp3=C3.*cos(2*pi*f3.*t2_2+theta3);
Comp4=C4.*cos(2*pi*f4.*t2_2+theta4);
Comp5=C5.*cos(2*pi*f5.*t2_2+theta5);
Predict_fft_2=Comp1+Comp2+Comp3+Comp4+Comp5;

plot(t,sig_2,'b','linewidth',1.8,'MarkerSize',2.2)
hold on
plot(t1,Predict_fft_1,'k--','linewidth',1.5)
hold on
plot(t2,Predict_fft_2,'k--','linewidth',1.5)
legend('Proposed Method','DFT',2)
%title('Prediction and comparison of wave elevation')
xlabel('Time(s)')
ylabel('Signal')
grid on
xlim([49 54])
ylim([-10 10])