%Plotting rectangular pulse
t = -0.5:1/100:0.5;
u1 = [zeros(1,250),ones(1,751)];
u2 = [zeros(1,751),ones(1,250)];
u = u1 - u2;

%Displaying rectangular pulse train
Ts = 1e-6;  
t = -0.001:Ts:0.001-Ts;
modf=1000;                                %Modulation frequency
m = sin(modf*2*pi*t);                     %Message Signal
fT = 1e4;                                 %Pulse Repetition  Frequency
periodT = 1/fT;                        %Pulse Time Period
pulseDur = 1e-5;                          %Pulse Duration
sampPerPulse = floor(pulseDur/Ts);
sampPerT = floor(periodT/Ts);
num = floor(length(m) / sampPerT);
r=[];
for i=1:num
    r = [r ones(1,sampPerPulse) zeros(1,sampPerT-sampPerPulse)];
end

figure (1);
subplot(3,1,1)
plot(t,m)
grid on
title("Message Signal m(t)")

figure (1);
subplot(3,1,2);
plot(t,r)
grid on
title("Rectangular Pulse train c(t)")

figure (1)
subplot(3,1,3);
plot(t,r.*m)
grid on
title("Modulated Wave m(t)*c(t)")

n = length(r.*m);
MS = fftshift(fft(r.*m));
figure(2);
subplot(2,1,1);
plot((-n/2:n/2-1)*fT/n,abs(MS));
title("The Magnitude of Spectrum of Modulated Signal")
grid on
figure(2);
subplot(2,1,2);
plot((-n/2:n/2-1)*fT/n,angle(MS));
title("The Phase of Spectrum of Modulated Signal")
grid on
