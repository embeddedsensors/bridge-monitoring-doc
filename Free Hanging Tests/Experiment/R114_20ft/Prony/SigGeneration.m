% This m-file is used to test how many data points are necessary to get the
% the information of the components. In the example, there are three
% components: two underdamped and one exponential.
% Lastest update on 01/02/2012 by Wenlong Yang

% Input to set the data points.
B1=1.2;
f1=0.30;
theta1=-pi./4;
xi1=-0.04;
B2=0.8;
f2=0.20;
theta2=pi./8;
xi2=-0.03;
R3=0.2;
r3=0.003;
dt_1=0.01;
t_1=0:dt_1:14000*dt_1;
Comp1=B1.*exp(xi1.*t_1).*cos(2*pi*f1.*t_1+theta1);
Comp2=B2.*exp(xi2.*t_1).*cos(2*pi*f2.*t_1+theta2);
Comp3=R3.*exp(r3.*t_1);
x1=Comp1+Comp2+Comp3;
figure
plot(t_1,x1)
hold on
plot(t_1,Comp1,t_1,Comp2,t_1,Comp3)
grid on
xlabel('Time (s)')
ylabel('Signal')
ylim([-2 3])

dt=0.5;
t=0:dt:9*dt;
t=t';
x=B1.*exp(xi1.*t).*cos(2*pi*f1.*t+theta1)+B2.*exp(xi2.*t).*cos(2*pi*f2.*t+theta2)+R3.*exp(r3.*t);
sig=x;
figure
plot(t,sig,'ro',t_1,x1,'--')
axis([-0.02 5 -3 4])
xlabel('Time (s)')
ylabel('Signal')
legend('Sampled data points','Continuous signal')