function f=myfft(signal,fs)

NFFT= 2^nextpow2(length(signal));
g = fft(signal,NFFT);
f=fs/2*linspace(0,1,NFFT/2+1);
plot(f,abs(g(1:NFFT/2+1)));
end