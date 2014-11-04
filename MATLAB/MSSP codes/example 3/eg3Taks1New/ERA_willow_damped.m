function [CondNumH0,CondNumYY,freq_Hz,damping,Amp,theta_complex]=ERA_willow_damped(alpha,sig,N,Ni,No,dt,N_comp)
%--------------------------------------------------------%
%This program is the main program to calculate the value of A, B, and C
%using the ERA method.
%
% input:
%    
%    sig: signals (Nt x Ns)  Nt:number of time steps; Ns=number of signals,
%    Ns=  No*Ni
%    No: number of output
%    Ni: number of input 
%    The first No column of sig should be associated with one exitation
%    alpha: number of block rows
%    beta: number of block colums
%
% output:
%
%    The estimated value of A, B, C
%    Ref: Juang's book chapter 5; SSI paper: "reference-based stochastic
%    subspace identification for output-only modal analysis" ().
%
%----------------------------------------------------------%
% Lastest updated on 03/20/2012 by Wenlong Yang

beta=N+1-alpha;
bh=block_hankel(sig,alpha,beta,No,Ni);% generate the block hankel matrix
H_0=bh(:,1:end-Ni);  % eliminate the last block column
H_1=bh(:,Ni+1:end);  % eliminate the first block column

[rowp,colp]=find(isnan(H_0));
% Find the row and column index of the rows and columns which have NaN in
% H(0)
[rowq,colq]=find(isnan(H_1));
% Find the row and column index of the rows and columns which have NaN in
% H(1)
row=[rowp;rowq];
col=[colp;colq];

rowsig=find(isnan(sig));
% Find the row index of the rows which have NaN in sig

%只删除含有NaN的列%
H_0=OnDeleteMatrix(H_0,[],col);
H_1=OnDeleteMatrix(H_1,[],col);
sig=OnDeleteMatrix(sig,rowsig,[]);
% Calculate the new H(0), H(1) and sig after deleting the rows and columns which
% contain NaN

[u0,s0,v0]=svd(H_0);% SVD of H(0)
sigma0=diag(s0);% singular values of the original Hankel matrix
ss1=size(sigma0,1);%ss1 is the number of singular values

%%---------------- the normalized singular values-----------------%%
for i=1:ss1
   normalize1(i)=sigma0(i)/max(sigma0);
end
size(normalize1);

%%--------rank estimation of the original Hankel matrix---------%%
% figure
% semilogy(1:ss1,normalize1(1:ss1),'r-+','linewidth',2)
% hold on
% grid on
% xlabel('Index of singular values','FontSize',14)
% ylabel('Normalized singular values','FontSize',14)
% grid on
% xlim([0 100])

%%------- model order determination --------------%%
%r_H0=input('model order=  ')% this is the model order you set.
r_H0=8;
[u1,s1,v1]=svds(H_0,r_H0);   %ERA
CondNumH0=s1(1,1)/s1(r_H0,r_H0);


%%-------calculate A, B and C---------------------%%
A=inv(s1).^(1/2)*u1'*H_1*v1*inv(s1).^(1/2);
B=s1.^(1/2)*v1';
B=B(:,[1:Ni]);
C=u1*s1.^(1/2);
C=C([1:No],:);

%%-------calculate lamda ----------%%
[VV,lamda] = eig(A);
lamda_c=diag(lamda);
lamda_c=log(lamda_c)/dt;
lambda=lamda_c;


% %-----------filtering the noise from the signal once-----------%
% H_2=u1*s1*v1';
% H_2=flipdim(H_2,1);
% qq=1;
% for pp=-alpha+1:beta-1
%     sig_filter(qq)=mean(diag(H_2,pp));
%     qq=qq+1;
% end
% sig=sig_filter';
% w3=sig; % w3 is the filtered signal

%--------calculate gamma------------%
for m=1:length(sig)
    YY(m,:)=exp((m-1)*dt.*lamda_c);% YY is the coefficient matrix
end
CondNumYY=cond(YY); % condition number of YY

if length(sig)<r_H0
    error('More data points are needed!')
end
if length(sig)==r_H0
    gamma=inv(YY)*sig;
else if length(sig)>r_H0
        gamma=inv(YY'*YY)*YY'*sig;
    end
end


%----------------------------pick just one from every conjugate pair of lambda----------------------% 
index1_complex=1;index1_real=1;lambda_complex=[];lambda_real=[];
if  abs(abs(lambda(1))-abs(lambda(2)))<1e-15                
    lambda_complex(1)=lambda(1);
    index1_complex=index1_complex+1;
elseif  abs(abs(lambda(1))-abs(lambda(2)))>1e-15                          
        lambda_real(1)=lambda(1);
        index1_real=index1_real+1;
end
for m=2:length(lambda)-1
    if abs(abs(lambda(m))-abs(lambda(m-1)))>1e-15 & abs(abs(lambda(m))-abs(lambda(m+1)))<1e-15
        lambda_complex(index1_complex)=lambda(m);
        index1_complex=index1_complex+1;
    elseif abs(abs(lambda(m))-abs(lambda(m-1)))>1e-15 & abs(abs(lambda(m))-abs(lambda(m+1)))>1e-15
            lambda_real(index1_real)=lambda(m);
            index1_real=index1_real+1;
    end
end
if abs(abs(lambda(end))-abs(lambda(end-1)))>1e-15
    lambda_real(index1_real)=lambda(end);
end
lambda=[lambda_real lambda_complex];


%----------------------------pick just one form every conjugate pair of gamma----------------------% 
index2_complex=1;index2_real=1;gamma_complex=[];gamma_real=[];
if  abs(abs(gamma(1))-abs(gamma(2)))<1e-15                 
    gamma_complex(1)=gamma(1);
    index2_complex=index2_complex+1;
elseif  abs(abs(gamma(1))-abs(gamma(2)))>1e-15                           
        gamma_real(1)=gamma(1);
        index2_real=index2_real+1;
end
for m=2:length(gamma)-1
    if abs(abs(gamma(m))-abs(gamma(m-1)))>1e-15 & abs(abs(gamma(m))-abs(gamma(m+1)))<1e-15
        gamma_complex(index2_complex)=gamma(m);
        index2_complex=index2_complex+1;
    elseif abs(abs(gamma(m))-abs(gamma(m-1)))>1e-15 & abs(abs(gamma(m))-abs(gamma(m+1)))>1e-15
            gamma_real(index2_real)=gamma(m);
            index2_real=index2_real+1;
    end
end
if abs(abs(gamma(end))-abs(gamma(end-1)))>1e-15
    gamma_real(index2_real)=gamma(end);
end
gamma=[gamma_real gamma_complex];

%-----find the information of the signal components----%
Amp_real=abs(gamma_real);
Amp_complex=abs(gamma_complex);
Amp_term=[Amp_real Amp_complex]; % Amplitude for every term
Amp=[Amp_real 2*Amp_complex]; % Amplitude for every component
damping_real=real(lambda_real);
damping_complex=real(lambda_complex);
damping=[damping_real damping_complex];
freq_Hz_real=imag(lambda_real)/2/pi;
freq_Hz_complex=imag(lambda_complex)/2/pi;
freq_Hz=[freq_Hz_real freq_Hz_complex];
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




    




% g1=0;g2=0;lamda_c_real=[];lamda_c_complex=[];
% for p=1:r_H0-1
%     if isreal(lamda_c(p))==0
%         if conj(lamda_c(p))==lamda_c(p+1)
%             g1=g1+1;
%             lamda_c_complex(g1)=lamda_c(p);
%         end
%     elseif isreal(lamda_c(p))==1
%         g2=g2+1;
%         lamda_c_real(g2)=lamda_c(p);
%     end
% end
% if isreal(lamda_c(r_H0))==1
%     g2=g2+1;
%     lamda_c_real(g2)=lamda_c(r_H0);
% end
%     
% nfre_rad_underdamp_esti=abs(lamda_c_complex);
% dampingratio_esti=-real(lamda_c_complex)./nfre_rad_underdamp_esti;
% nfre_damped_rad_underdamp_esti=nfre_rad_underdamp_esti.*sqrt(1-dampingratio_esti.^2);
% R_esti=lamda_c_real;