clc;
clear all;
close all;

data = [0 1 0 1 1 0 1 1];
point = 100;
flag = [1 0 -1 0];  %represents the different signal levels
status = 0;         %ariable stores the current signal level
index = 1;          %variable keeps track of the position in the flag

%If the current element is 1, the status is updated to the value at
%the corresponding index position in the flag array.
%The encoded_signal array is assigned the status value over the
%corresponding range of samples based on the current index.
%The index is updated using mod(index, 4) + 1 to cycle through the
% elements of the flag array.

encoded_signal = zeros(1, length(data) * point);
for i = 1:length(data)
    if data(i) == 1
        status = flag(index);
        encoded_signal((i-1)*point+1:i*point) = status;
        index = mod(index, 4) + 1;
    else
        encoded_signal((i-1)*point+1:i*point) = status;
    end
end

size = 0:1/point:length(data)-1/point;
% time axis based on the number of samples per bit.

plot(size, encoded_signal, 'Linewidth', 3);
axis([0, length(data), -2, 2]);
title('MLT-3 Encoding', 'fontweight', 'bold', 'fontsize', 18);
ylim([-2,2]);
xlabel('Time', 'fontweight', 'bold', 'fontsize', 20);
ylabel('Amplitude', 'fontweight', 'bold', 'fontsize', 20);
disp('MLT-3 Encoding:');
grid on;
disp(encoded_signal);

% For data bits

bitrate = 1;
T = length(data)/bitrate;

ax1 = gca;
ax2 = axes('Position', get(ax1, 'Position'), 'Color', 'none');
set(ax2, 'XAxisLocation', 'top');
set(ax2, 'XLim', get(ax1, 'XLim'));
set(ax2, 'YLim', [-2, 2]);
set(ax2, 'XTick', [bitrate/2:bitrate:T]);
set(ax2, 'YTick', []);
set(ax2, 'XTickLabel', data, 'fontweight', 'bold', 'fontsize', 18);

% Decoded Signal

status = 0;
decoded_signal = zeros(1, length(data));
for i = 1:length(data)
    if encoded_signal(i*point) == status
        decoded_signal(i) = 0;    % status same -> 0
    else
        decoded_signal(i) = 1;    % status change -> 1
        status = encoded_signal(i*point);
    end
end
disp('MLT-3 Decoding:');
disp(decoded_signal);



