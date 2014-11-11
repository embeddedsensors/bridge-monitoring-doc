function [freq_Hz,damping,Amp,theta]=ERA_hu(sig,dt,alpha,r_H0,orm)
%--------------------------------------------------------------------------
%
%  function [freq_Hz,damping,Amp,theta]=ERA_hu(sig,dt,alpha,r_H0)
%
%  Decompose a signal using Prony plus State-Space model method (ERA)
%
% input:
%    
%    sig: a column or row vector for the signal to be decomposed
%    dt : time interval
%    alpha: the number of rows employed in the Hankel matrices
%    r_H0: model rank (for the truncated singular value decomposition)
%    orm : option for removing mean
%
% output:
%
%    freq_Hz: estimated frequency in Hz
%    damping: estimated damping factor (negative is for decay)
%    Amp: estimated amplitude (at initial time)
%    theta: estimated phase angle (radian)
%
%    Ref: Decomposing signals into real/complex exponential components
%    using state-space models. Hu, Yang, Li, 2012 @ Proceedings of Royal
%    Society London A
%
%    modified by James Hu, 8/3/2012;     Wenlong Yang 6/1/2012;
%--------------------------------------------------------------------------
if orm==1
    sig=sig-mean(sig); disp('remove mean option')
end
[nr,nc]=size(sig);
if nr<nc
    sig=sig';                           % make sure sig is a column vector
end
%
Ni=1;No=1;                              % for SISO
beta=length(sig)+1-alpha;               % number of columns 
bh=block_hankel(sig,alpha,beta,No,Ni);  % generate block hankel matrix
H_0=bh(:,1:end-Ni);                     % eliminate the last block column
H_1=bh(:,Ni+1:end);                     % eliminate the first block column

%
% eigensystem realization technique
%
%     [U,S,V] = SVD(X) produces a diagonal matrix S, of the same 
%     dimension as X and with nonnegative diagonal elements in
%     decreasing order, and unitary matrices U and V so that
%     X = U*S*V'.
%
%     SVDS(A,K) computes the K largest singular values of A.
%
[U0,S0,V0]=svds(H_0,r_H0);      
A=inv(S0).^(1/2)*U0'*H_1*V0*inv(S0).^(1/2); % state matrix
%
%   estimate lamda 
%
[VV,lamda] = eig(A);
lamda_c=diag(lamda);
lamda_c=log(lamda_c)/dt;
lambda=lamda_c;
%
%  use SVD for LS on solving gamma 
%
for m=1:length(sig)
    YY(m,:)=exp((m-1)*dt.*lamda_c);   % coefficient matrix
end
[uYY,sYY,vYY]=svd(YY,0);              % sYY a square matrix
gamma=vYY*inv(sYY)*uYY'*sig;     
%
%  compute frequency, damping, amplitude and phase angle
%
[freq_Hz,damping,Amp,theta]=lg2fdap(lambda,gamma);
end


function [freq_Hz,damping,amp,theta]=lg2fdap(lambda,gamma)
%--------------------------------------------------------------------------
%  converting lambda-gamma to frequency-damping-amplitude-phase
%
%  lambda:  real or complex conjugate pairs
%  gamma: real or complex conjugate pairs
%
%  freq_Hz = frequency in Hz
%  damping = damping factor
%  amp = amplitude
%  theta = phase angle (radian)
%
%   James Hu,  8/2/2012
%--------------------------------------------------------------------------
re_lambda=real(lambda);
im_lambda=imag(lambda);
re_gamma=real(gamma);
im_gamma=imag(gamma);
%
%
[IM_lambda,I] = sort(im_lambda);  % sort based on frequency (from negative)
RE_lambda=re_lambda(I);
IM_gamma=im_gamma(I);
RE_gamma=re_gamma(I);
%
n=min(find(IM_lambda>=0)); % find first non-negative frequency
nm1=n-1;
IM_lambda(1:nm1)=[];  % eliminate redundent complex conjagate
RE_lambda(1:nm1)=[];
IM_gamma(1:nm1)=[];
RE_gamma(1:nm1)=[];
%
freq_Hz=IM_lambda/(2*pi);
damping=RE_lambda;
amp=abs(RE_gamma+i*IM_gamma);
theta=angle(RE_gamma+i*IM_gamma);
%
% double amplitude for complex lambda (with non-zero frequency)
%
nc=length(freq_Hz);
for k=1:nc
    if freq_Hz(k) > 1e-10
        amp(k)=2*amp(k);
    end
end
end
