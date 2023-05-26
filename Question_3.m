fs = 240;              %Sampling rate  and use fs = 4 for last four digit of my roll no.
Ts = 1/(fs);           %Sampling period
td = 0:Ts:0.1-Ts;
tc = 0:1e-4:0.1-1e-4;

%Signal
x = sin(2*pi*20*td)+ 0.5*cos(2*pi*60*td);

%Spectrum
S3_shift = fftshift(fft(x));
n = length(x);
fshift = (-n/2:n/2-1)*(fs/n);

%Plot
figure(1);
subplot(2,1,1)
plot(fshift, abs(S3_shift));
title("Magnitude Spectrum of the Signal sin(40 \pi t)+ 0.5 cos(120 \pi t)");
xlabel('\omega');
ylabel('|H(\omega)|');

figure(1);
subplot(2,1,2)
plot(fshift, angle(S3_shift));
title("Phase Spectrum of the Signal sin(40 \pi t)+ 0.5 cos(120 \pi t)");
xlabel('\omega');
ylabel('<H(\omega)');

%Plotting original signal
xc = sin(2*pi*20*tc)+ 0.5*cos(2*pi*60*tc);
figure(2);
subplot(2,1,1);
plot(tc,xc);
title("Original signal");
xlabel("t");


%Plotting sampled signal
figure(2);
subplot(2,1,2);
stem(td,x)
title("Sampled signal")
xlabel("t")

%Reconstruction
xu = [ x ; zeros(size(x))];
xu = xu(:).'; % upsampled version of x 

h_zoh = [1 1];
h_foh = [1 2 1]/2;

y_zoh = conv(xu, h_zoh); % zero-order hold
y_foh = conv(xu, h_foh); % delayed first order hold

xr = zeros(size(tc)); %initialization
sinc_train = zeros(N,length(tc)); %initialization
for n = 0:N-1
   %unless we define our sinc with a value in zero it will introduce NaN which
   %lead to a small error
   sinc_train(n+1,:) = sin(pi*(tc-n*Ts)/Ts)./(pi*(tc-n*Ts)/Ts); %sinc train
   %sinc_train(n+1,:) = sinc((tc-n*Ts)/Ts); %sinc train
   current_sinc=xd(n+1)*sinc_train(n+1,:); %a sinc scaled by the sample value
   xr = xr + current_sinc; %generation of the reconstructed signal summing the sinc scaled
end

%Displaying
t_zoh = linspace(0,0.1-Ts,length(y_zoh));
figure(3);
subplot(3,1,1)
plot(t_zoh,y_zoh,'b','linewidth',1)
title("Reconstruction using Zero-order hold");
xlabel("t")

t_foh = linspace(0,0.1-Ts,length(y_foh));
figure(3);
subplot(3,1,2);
plot(t_foh,y_foh,'r','linewidth',1)
title("Reconstruction using First-order hold");
xlabel("t")

figure(3);
subplot(3,1,3);
tr = linspace(0,0.1,length(xr));
plot(tr,xr);
title("Reconstruction using sinc")
xlabel("t")





