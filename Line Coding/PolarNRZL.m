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
t = 0:dt:T-dt;

%NRZ L
x = zeros(1,length(t));
for i=1:length(bits)
  if bits(i) == 1
    x((i-1)*n+1:i*(n)) = -1;
  else x((i-1)*n+1:i*(n)) = 1;
  end
end

plot(t, x, 'Linewidth', 3);
axis([0,length(bits),-2,2]);
title('POLAR NRZ-L','fontweight','bold','fontsize',20);
xlabel('Time','fontweight','bold','fontsize',20);
ylabel('Amplitude','fontweight','bold','fontsize',20);
disp('NRZ-L Encoding:');
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


%decoding
counter = 0;
for i = 1 : length(t)
  if t(i)> counter
    counter = counter + 1;
    if x(i) < 0
        result(counter) = 1;
    else
        result(counter) = 0;
    end
  end
end


disp('NRZ-L Decoding:');
disp(result);
