%Initial conditions
R = 1;
C = 100*10^-6;
L = 10*10^-3; %Use 4*10^-3 for L = 4 mH
w = logspace(0,4,1000);

%Part (a)
%Frequency response
Hc = 1./(1+R*C*j*w+L*C*(j*w).^2);
Hr = (R*C*j*w./(1+R*C*j*w+L*C*(j*w).^2));
Hl =((L*C*(j*w).^2)./(1+R*C*j*w+L*C*(j*w).^2));

%Display
figure(1)
subplot(3,1,1)
plot(w,abs(Hc))
grid on
title('|Hc(j\omega)| L = 10 mH')
xlabel('\omega')
ylabel('|Hc(j\omega|')

figure(1)
subplot(3,1,2)
plot(w,abs(Hr))
grid on
title('|Hr(j\omega)| L = 10 mH')
xlabel('\omega')
ylabel('|Hr(j\omega|')

figure(1)
subplot(3,1,3)
plot(w,abs(Hl))
grid on
title('|Hl(j\omega)| L = 10 mH')
xlabel('\omega')
ylabel('|Hl(j\omega|')

figure(2)
subplot(3,1,1)
plot(w,angle(Hc));
grid on
title('<Hc(j\omega)  L = 10 mH')
xlabel('\omega')
ylabel('<Hc(j\omega)')

figure(2)
subplot(3,1,2)
plot(w,angle(Hr));
grid on
title('<Hr(j\omega) L = 10 mH')
xlabel('\omega');
ylabel('<Hr(j\omega)');

figure(2)
subplot(3,1,3)
plot(w,angle(Hl));
grid on;
title('<Hl(j\omega) L = 10 mH');
xlabel('\omega');
ylabel('<Hl(j\omega)');

%Part (b)
t=linspace(0,10^-2);
y= zeros(1,length(t));
T=2*pi*10^-3
w_0=2*pi/T;

for k=-99:99
a_k= 2*sin(k*pi/4)*(1i*w_0)/(R*w_0*k*1j+1/C+L*(k*j*w_0)^2);
y=y+(1/(2*pi))*a_k*exp(1j*k*w_0*t);
end 


figure(3);
subplot(2,1,1);
plot(t,abs(y));
title('Magnitude of output spectrum (L = 10 mH)');
xlabel('time(s)');ylabel('abs(output)');
grid on;
subplot(2,1,2);
plot(t,angle(y));
title('Phase of output spectrum (L = 10H)');
xlabel('time(s)');
ylabel('phase(output)'); 
grid on;




