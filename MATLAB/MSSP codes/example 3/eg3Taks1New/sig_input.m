C1=2.2; f1=1.80;theta1=pi/6;Xi1=0.02;
C2=2.6; f2=3.20;theta2=3*pi/8;Xi2=0.04;
C3=1.4; f3=3.00;theta3=-pi/4;Xi3=0.01;
C4=1.0; f4=2.20;theta4=pi/2;Xi4=0.00;

sig1=C1.*cos(2*pi*f1.*t+theta1).*exp(-Xi1.*t);
sig2=C2.*cos(2*pi*f2.*t+theta2).*exp(-Xi2.*t);
sig3=C3.*cos(2*pi*f3.*t+theta3).*exp(-Xi3.*t);
sig4=C4.*cos(2*pi*f4.*t+theta4).*exp(-Xi4.*t);
x=sig1+sig2+sig3+sig4;

if flag==1
    sig=x;
elseif flag==2
        dlmwrite('signal.txt', x, 'precision', 5);
        load signal.txt;
        sig=signal;
elseif flag~=1 & flag~=2
        error('Input Error, Please Try Again')
end 