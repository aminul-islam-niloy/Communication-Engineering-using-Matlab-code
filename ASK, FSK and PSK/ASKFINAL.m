close all;
clear all;
clc;
%bits=input("Enter bits: ");
bits = [1 0 1 1 0 1 0 1 ];
bitrate = 1;
fs = 1000;

T = length(bits) * bitrate;
t = 0:1/fs:T-(1/fs);

for i = 1:length(bits)
  if bits(i) == 0
    x((i-1)*fs*bitrate+1:i*fs*bitrate) = zeros(1, fs*bitrate);
  else
    x((i-1)*fs*bitrate+1:i*fs*bitrate) = ones(1, fs*bitrate);
  end
end

subplot(3,1,1);
plot(t, x, 'linewidth', 2);
axis([0,length(bits),-2,2]);
xlabel('Time','fontweight','bold','fontsize',15);
ylabel('Amplitude','fontweight','bold','fontsize',15);
title('input signal','fontweight','bold','fontsize',15);
grid on;

a = 5;
f = 7;
modulation = a * sin ( 2* pi * f * t);
subplot(3,1,2);
plot(t, modulation);
title("Carrier signal");


% Modulation
in = 1; #Bitstream in

for i = 1:length(t)
    if bits(in) == 0
        modulation(i) = 0;
    endif
    if t(i)*bitrate >= in
        in = in+1;
    endif
endfor

subplot(3,1,3);
plot(t, modulation, "LineWidth", 1);
grid on;

title("ASK");


%demodulation

in = 1;

for i = 1:length(modulation)
    if modulation(i) != 0
        demodultaion(in) = 1;
    else
        demodultaion(in) = 0;
    endif
    if t(i)*bitrate >= in
        in = in+1;
    endif
endfor

disp(demodultaion);


