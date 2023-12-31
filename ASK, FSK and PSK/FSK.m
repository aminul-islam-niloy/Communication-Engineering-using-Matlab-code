close all;
clear all;
clc;

bits = [1 1 0 1 0 1 0 1];
bit_dur = 1;
fs = 1000;

T = length(bits) * bit_dur;
t = 0:1/fs:T-(1/fs);

for i = 1:length(bits)
  if bits(i) == 0
    x((i-1)*fs*bit_dur+1:i*fs*bit_dur) = zeros(1, fs*bit_dur);
  else
    x((i-1)*fs*bit_dur+1:i*fs*bit_dur) = ones(1, fs*bit_dur);
  end
end

subplot(3,1,1);
plot(t, x, 'linewidth', 2);
axis([0,length(bits),-2,2]);
xlabel('Time','fontweight','bold','fontsize',15);
ylabel('Amplitude','fontweight','bold','fontsize',15);
title('input signal','fontweight','bold','fontsize',15);
title("Input Signal");

a = 7;
fc = 3;

modulation = a * sin ( 2* pi * fc * t);
subplot(3,1,2);
plot(t, modulation);
title("Carrier signal");

% modulation
zero_sig = a * sin(2 * pi * 1 * t(1:length(t)/length(bits)));
for i = 1:length(bits)
  if bits(i) == 0
    modulation((i-1)*fs*bit_dur+1:i*fs*bit_dur) = zero_sig;
  end
end

subplot(3,1,3);
plot(t, modulation);
title("FSK");


%disp(demodultaion);

