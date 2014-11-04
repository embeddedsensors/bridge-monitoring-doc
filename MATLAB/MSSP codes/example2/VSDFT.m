% This file aims at plotting the results from fft and new method

%--Fourier analysis of the signal----
 n=0:N-1;
 fs=1/dt;
 f=n*fs/N;
 kkk=fft(sig,N);
 mag=abs(kkk)*2/N;

%---plot the comparison---
figure
whatever2=stem(freq_Hz,Amp,'fill','r-');
set(whatever2,'LineWidth',1.0,'marker','^','markersize',4.5)
hold on
whatever1=stem(f(1:N/4),mag(1:N/4));
set(whatever1,'LineWidth',0.8,'marker','o','markersize',4.5)
grid on
xlim([1.5 3.5])
xlabel('Frequency (Hz)')
ylabel('Amplitude')
legend('Proposed Method','DFT',2)