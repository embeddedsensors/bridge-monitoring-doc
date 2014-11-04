function [bh]=block_hankel(sig,alpha,beta,No,Ni)
%--------------------------------------------------------------------------
%
%  function [bh]=block_hankel(sig,alpha,beta,No,Ni)
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
%    bh = block Hankel matrix
%    Ref: Juang's book chapter 5; SSI paper: "reference-based stochastic
%    subspace identification for output-only modal analysis" ().
%    by  Ping Li    Sept. 16, 2010
%--------------------------------------------------------------------------
bh=zeros(alpha*No,beta*Ni);
for ii=1:alpha
    for jj=1:beta
             s=sig(ii+jj-1,:);    %get a row of sig every time
             ss=reshape(s,No,Ni); %reshape the row, which has been got, 
                                  %into matrix with No*Ni
             bh((ii-1)*No+1:ii*No,(jj-1)*Ni+1:jj*Ni)=ss;%put the reshaped
                                                      %matrix into position
                                                      %in block hankel line
                                                      %by line 
    end
end
