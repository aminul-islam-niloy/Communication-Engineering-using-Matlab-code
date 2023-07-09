clc; #Clear command line
clear all; #Clear variables
close all; #Clear figures

bits = [1 0 1 1 0 0 1]; #Bitstream

#... Modulation

bitrate = 1; #Number of bits per second

sampling_rate = 100;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;
time = 0:sampling_time:end_time;

 fs= 1000;
bit_dur =1;
T = length(bits) * bit_dur;
t = 0:1/fs:T-(1/fs);

for i = 1:length(bits)
  if bits(i) == 0
    x((i-1)*fs*bit_dur+1:i*fs*bit_dur) = ones(1, fs*bit_dur).*-3;
  else
    x((i-1)*fs*bit_dur+1:i*fs*bit_dur) = ones(1, fs*bit_dur).*3;
  end
  end

subplot(3,1,1);
plot(t, x, 'linewidth', 2);
ylim([-5, 5]);
title("Input Signal");

signal_one = 3*sin(2*pi*4*time);
modulation = 3*sin(2*pi*2*time);
fc = 3;

subplot(3,1,2);
signal = 3 * sin ( 2* pi * fc * t);
subplot(3,1,2);
plot(t, signal);
title("Carrier signal");

in = 1; #Bitstream index

for i = 1:length(time)
    if bits(in) == 1
        modulation(i) = signal_one(i);
    endif
    if time(i)*bitrate >= in
        in = in+1;
    endif
endfor
subplot(3,1,3);
plot(time, modulation, "LineWidth", 1);
axis([0 end_time -5 5]);
title("FSK  Signal");
grid on;

#Demodulation

in = 1;

for i = 1:length(modulation)
    demodultaion(in) = 1;
    if modulation(i) != signal_one(i)
        demodultaion(in) = 0;
    endif
    if time(i)*bitrate >= in
        in = in+1;
    endif
endfor

disp(demodultaion);

