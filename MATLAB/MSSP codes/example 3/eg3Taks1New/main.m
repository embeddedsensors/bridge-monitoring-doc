% This is the main file
% Created on 02/29/2012 By Wenlong Yang

clc
close all
clear all


N=1024;
N_comp=4;
flag=1; % 1 is without truncation (16 digits); 2 is with truncation (5 digits)

pp=1;
for dt=0.01:0.01:0.15;
    DT(pp)=dt;
    t=0:dt:(N-1)*dt;
    t=t';
    sig_input; 
    alpha=N/2; % the value of alpha
    [CondNumH0(pp),CondNumYY(pp),freq_Hz(pp,:),damping(pp,:),Amp(pp,:),theta_complex(pp,:)]=ERA_willow_damped(alpha,sig,N,1,1,dt,N_comp);
    pp=pp+1;
end
save eg3Task1New1

figure
plot(DT,CondNumH0,'*')
xlabel('Sampling interval \Deltat (s)')
ylabel('Condition number of H(0)')
grid on

figure
index=0:0.001:0.001*(N-1);
fre_true=[f1*ones(1,N);f2*ones(1,N);f3*ones(1,N);f4*ones(1,N)];
Damping_true=[Xi1*ones(1,N);Xi2*ones(1,N);Xi3*ones(1,N);Xi4*ones(1,N)];
subplot(1,2,1)
plot(index,(fre_true(1,:))','r');
hold on
plot(DT,freq_Hz,'bo','MarkerSize',2.5)
hold on
plot(index,(fre_true(2:4,:))','r');
xlim([0 0.16])
ylim([-0.5 8])
xlabel('Sampling interval \Deltat (s)')
ylabel('Frequency (Hz)')
legend('True','Estimated')
grid on
subplot(1,2,2)
plot(index,(Damping_true(1,:))','r')
hold on
plot(DT,-damping,'bo','MarkerSize',2.5)
hold on
plot(index,(Damping_true(2:4,:))','r')
xlim([0 0.16])
ylim([-0.1 0.15])
xlabel('Sampling interval \Deltat (s)')
ylabel('Damping factor')
legend('True','Estimated')
grid on
