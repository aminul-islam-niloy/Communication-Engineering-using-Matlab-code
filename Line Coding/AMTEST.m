clear all;
close all;
clc;

carrier_amp = 1;
message_amp = 1;
carrier_frq = 10;
message_frq = 1;

Total_time = 5;
t = 0 : 0.01: Total_time;

message_signal = message_amp * sin(2 * pi * message_frq * t) + message_amp * cos(2 * pi * message_frq/2 * t);
carrier_signal = carrier_amp * sin(2 * pi * carrier_frq * t);

modulated_signal = (carrier_amp + message_signal) .* carrier_signal;


function m = amDemod(s,fc,fs,n)


  % Rectify the modulated signal
  s = abs(s);
  % Set the number of samples on which to do the moving average
  k = round(n*fs/fc);
  % Take the moving average
  m = movmean(s,k);
  % Remove the DC offset
  m = m-mean(m);
endfunction

demodulated_signal = amDemod(modulated_signal, carrier_frq, message_frq, length(t));


subplot(311);
plot(t, carrier_signal);
title('Carrier Signal');

subplot(312);
plot(t, message_signal);
title('Message Signal');
line ([0, Total_time], [0 0], "linestyle", "--", "color", "r");

subplot(313);
plot(t, modulated_signal);
title('Amplitude Modulated Signal');
line ([0, Total_time], [0 0], "linestyle", "--", "color", "r");

%subplot(414);
%plot(t, demodulated_signal);
%title('Amplitude Demodulated Signal');
%line ([0, Total_time], [0 0], "linestyle", "--", "color", "r");







