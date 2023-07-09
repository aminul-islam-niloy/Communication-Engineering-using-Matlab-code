clear all;
close all;
clc;

%bits = input('Enter bit sequence: ');
bits = [0 1 0 0 1 0 1 0];
bitrate = 1;
n = 1000;
T = length(bits)/bitrate;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;

% NRZ-I Encoding
x = zeros(1, length(t));
prev_bit = 1;  % Initialize previous bit with 1
for i = 1:length(bits)
    if bits(i) == 1
        x((i-1)*n+1:i*n) = -prev_bit;
        prev_bit = -prev_bit;  % Invert the polarity for consecutive 1s
    else
        x((i-1)*n+1:i*n) = prev_bit;
    end
end

% Plotting the encoded signal
plot(t, x, 'Linewidth', 3);
axis([0, length(bits), -2, 2]);
title('POLAR NRZ-I', 'fontweight', 'bold', 'fontsize', 20);
xlabel('Time', 'fontweight', 'bold', 'fontsize', 20);
ylabel('Amplitude', 'fontweight', 'bold', 'fontsize', 20);
disp('NRZ-I Encoding:');
grid on;
disp(x);

% For data bits
ax1 = gca;
ax2 = axes('Position', get(ax1, 'Position'), 'Color', 'none');
set(ax2, 'XAxisLocation', 'top');
set(ax2, 'XLim', get(ax1, 'XLim'));
set(ax2, 'YLim', [-2, 2]);
set(ax2, 'XTick', [bitrate/2:bitrate:T]);
set(ax2, 'YTick', []);
set(ax2, 'XTickLabel', bits, 'fontweight', 'bold', 'fontsize', 18);

% Decoding
counter = 0;
decoded_bits = zeros(1, length(bits));
prev_polarity = 1;  % Initialize previous polarity with 1
for i = 1:length(t)
    if t(i) > counter
        counter = counter + 1;
        if x(i) == prev_polarity
            decoded_bits(counter) = 0;
        else
            decoded_bits(counter) = 1;
            prev_polarity = -prev_polarity;  % Invert the polarity for consecutive 1s
        end
    end
end

disp('NRZ-I Decoding:');
disp(decoded_bits);

