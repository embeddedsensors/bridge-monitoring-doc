% This is the main file

% Created on 02/29/2012 By Wenlong Yang

clc
close all
clear all

N=1024;
N_comp=4;
T_Nyquist=1/2/3.2;

pp=1;
for dt=0.01:0.01:0.15;
    t=0:dt:(N-1)*dt;
    t=t';
    DT(pp)=dt;
    flag=1; % 1 without truncation, 2 with 5 digits
    flag2=0;
    sig_input; 
    [CondNumH0(pp),freq_Hz(pp,:),damping(pp,:),Amp(pp,:),theta_complex(pp,:)]=Prony_willow(8,sig,dt,4);
    pp=pp+1;
end
damping=-damping;
save eg3Task1Prony;

figure
semilogy(DT,CondNumH0,'*')
xlabel('Sampling interval \Deltat (s)')
ylabel('Condition number of \bf{\it{Y}}')
grid on

figure
index=0:0.001:10;
fre_true=[f1*ones(1,length(index));f2*ones(1,length(index));f3*ones(1,length(index));f4*ones(1,length(index))];
Damping_true=[Xi1*ones(1,length(index));Xi2*ones(1,length(index));Xi3*ones(1,length(index));Xi4*ones(1,length(index))];
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
legend('Ture','Estimated')
grid on
subplot(1,2,2)
plot(index,(Damping_true(1,:))','r')
hold on
plot(DT,damping,'bo','MarkerSize',2.5)
hold on
plot(index,(Damping_true(2:4,:))','r')
xlim([0 0.16])
ylim([-0.1 0.15])
xlabel('Sampling interval \Deltat (s)')
ylabel('Damping factor')
legend('True','Estimated')
grid on


% figure
% fre_true=[f1*ones(1,N);f2*ones(1,N);f3*ones(1,N);f4*ones(1,N)];
% index=0:0.001:0.001*(N-1);
% plot(index,fre_true','r');
% hold on
% plot(DT,freq_Hz,'b*')
% xlabel('Sampling interval \Deltat (s)')
% ylabel('Target and estimated frequency')
% legend('Target frequency','Estimated frequency')
% grid on
% 
% figure
% Damping_true=[Xi1*ones(1,N);Xi2*ones(1,N);Xi3*ones(1,N);Xi4*ones(1,N)];
% index=0:0.001:0.001*(N-1);
% plot(index,Damping_true','r')
% hold on
% plot(DT,damping,'b*')
% xlabel('Sampling interval \Deltat (s)')
% ylabel('Target and estimated damping factor')
% legend('Target damping factor','Estimated damping factor')
% grid on

% figure
% Amp_true=[C1*ones(1,N);C2*ones(1,N);C3*ones(1,N);C4*ones(1,N)];
% index=0:0.001:0.001*(N-1);
% plot(index,Amp_true','r')
% hold on
% plot(DT,Amp,'b*')
% xlabel('Sampling interval \Deltat (s)')
% ylabel('Target and estimated amplitude')
% legend('Target amplitude','Estimated amplitude')
% grid on
% 
% figure
% theta_true=[theta1*ones(1,N);theta2*ones(1,N);theta3*ones(1,N);theta4*ones(1,N)];
% index=0:0.001:0.001*(N-1);
% plot(index,theta_true','r')
% hold on
% plot(DT,theta_complex,'b*')
% xlabel('Sampling interval \Deltat (s)')
% ylabel('Target and estimated phase angle')
% legend('Target phase angle','Estimated phase angle')
% grid on