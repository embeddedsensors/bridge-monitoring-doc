function [CondNumber,freq_Hz,damping,Amp,theta_complex]=Prony_willow(N_term,sig,dt,N_comp)
%Prony_willow: This function aims at finding the information of the signal
%by Prony's method.

%--------inputs--------------------
% N_term: Number of terms in the signal
% sig: the goal signal
% dt: sampling rate
%N_comp: Number of components in the signal

% Programmed by Wenlong Yang 01/14/2012

sig_analyzed=sig(1:end-1);% sig_analyzed contains all the data which are analyzed.
y1=sig(N_term+1:end);
row_A=length(y1);
A_sig=block_hankel(sig_analyzed,row_A,N_term,1,1); % block-hankel matrix A of equation Y(K)*b=y(K+1)
CondNumber=cond(A_sig); % condition number of Hankel matrix
 
if row_A<N_term
    error('More data points are needed!')
end

if row_A==N_term
    beta=-inv(A_sig)*y1;
else if row_A>N_term
        beta=-inv(A_sig'*A_sig)*A_sig'*y1;
    end
end

beta=flipud(beta);
beta=[1;beta];        
A_companion=compan(beta);% A_companion is the companion matrix
Z=roots(beta); % finding the values of Z
lambda=log(Z)/dt; % lambda for continuous signal

y2=sig(1:end);
mm=1;
for m=1:length(y2)
    ZZ(mm,:)=Z.^(m-1); % ZZ is the matrix containing powers of Z
    mm=mm+1;
end

if length(y2)<N_term
    error('More data points are needed!')
end
if length(y2)==N_term
    gamma=inv(ZZ)*y2;
else if length(y2)>N_term
        gamma=inv(ZZ'*ZZ)*ZZ'*y2;
    end
end

%----------------------------pick just one form every conjugate pair of lambda----------------------% 
index1_complex=1;index1_real=1;lambda_complex=[];lambda_real=[];
if  abs(abs(lambda(1))-abs(lambda(2)))<1e-10                
    lambda_complex(1)=lambda(1);
    index1_complex=index1_complex+1;
elseif  abs(abs(lambda(1))-abs(lambda(2)))>1e-10                          
        lambda_real(1)=lambda(1);
        index1_real=index1_real+1;
end
for m=2:length(lambda)-1
    if abs(abs(lambda(m))-abs(lambda(m-1)))>1e-10 & abs(abs(lambda(m))-abs(lambda(m+1)))<1e-10
        lambda_complex(index1_complex)=lambda(m);
        index1_complex=index1_complex+1;
    elseif abs(abs(lambda(m))-abs(lambda(m-1)))>1e-10 & abs(abs(lambda(m))-abs(lambda(m+1)))>1e-10
            lambda_real(index1_real)=lambda(m);
            index1_real=index1_real+1;
    end
end
if abs(abs(lambda(end))-abs(lambda(end-1)))>1e-10
    lambda_real(index1_real)=lambda(end);
end
lambda=[lambda_real lambda_complex];


%----------------------------pick just one from every conjugate pair of gamma----------------------% 
index2_complex=1;index2_real=1;gamma_complex=[];gamma_real=[];
if  abs(abs(gamma(1))-abs(gamma(2)))<1e-10                 
    gamma_complex(1)=gamma(1);
    index2_complex=index2_complex+1;
elseif  abs(abs(gamma(1))-abs(gamma(2)))>1e-10                           
        gamma_real(1)=gamma(1);
        index2_real=index2_real+1;
end
for m=2:length(gamma)-1
    if abs(abs(gamma(m))-abs(gamma(m-1)))>1e-10 & abs(abs(gamma(m))-abs(gamma(m+1)))<1e-10
        gamma_complex(index2_complex)=gamma(m);
        index2_complex=index2_complex+1;
    elseif abs(abs(gamma(m))-abs(gamma(m-1)))>1e-10 & abs(abs(gamma(m))-abs(gamma(m+1)))>1e-10
            gamma_real(index2_real)=gamma(m);
            index2_real=index2_real+1;
    end
end
if abs(abs(gamma(end))-abs(gamma(end-1)))>1e-10
    gamma_real(index2_real)=gamma(end);
end
gamma=[gamma_real gamma_complex];

%-----find the information of the signal components----%
Amp_real=abs(gamma_real);
Amp_complex=abs(gamma_complex);
Amp_term=[Amp_real Amp_complex];% amplitude for every term
Amp=[Amp_real 2*Amp_complex];
damping_real=real(lambda_real);
damping_complex=real(lambda_complex);
damping=[damping_real damping_complex];
freq_Hz_real=imag(lambda_real)/2/pi;
freq_Hz_complex=imag(lambda_complex)/2/pi;
freq_Hz=[freq_Hz_real freq_Hz_complex]; % frequency is Hz
theta_complex=atan2(imag(gamma_complex),real(gamma_complex));

if length(freq_Hz)>N_comp
    freq_Hz=freq_Hz(1:N_comp);
elseif length(freq_Hz)<N_comp
    temp=ones(1,N_comp-length(freq_Hz))*NaN;
    freq_Hz=[freq_Hz temp];
end
if length(damping)>N_comp
    damping=damping(1:N_comp);
elseif length(damping)<N_comp
    temp=ones(1,N_comp-length(damping))*NaN;
    damping=[damping temp];
end
if length(Amp)>N_comp
    Amp=Amp(1:N_comp);
elseif length(Amp)<N_comp
    temp=ones(1,N_comp-length(Amp))*NaN;
    Amp=[Amp temp];
end
if length(theta_complex)>N_comp
    theta_complex=theta_complex(1:N_comp);
elseif length(theta_complex)<N_comp
    temp=ones(1,N_comp-length(theta_complex))*NaN;
    theta_complex=[theta_complex temp];
end
