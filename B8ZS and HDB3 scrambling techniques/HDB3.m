clear all;
close all;
clc;

%bits = input('prompt');
bits = [1 0 0 0 0 0 0 0 0 0 0];
bitrate = 1;
n = 1000;
T = length(bits)/bitrate;
N = n*length(bits);
dt = T/N;
t = 0:dt:T-dt;
x = zeros(1,length(t));
counter = 0;
lastbit = 1;
pulse = 0;

%encoding
for i=1:length(bits)
  if bits(i)==0
    counter = counter + 1;
    if counter==4
      if(mod(pulse, 2)==0)
        x((i-1-3)*n+1:(i-3)*n) = -lastbit;
        lastbit = -lastbit;
        x((i-1-2)*n+1:(i-2)*n) = 0;
        x((i-1-1)*n+1:(i-1)*n) = 0;
        x((i-1)*n+1:i*n) = lastbit;
        counter = 0;
        pulse = 0;
      else
        x((i-1-3)*n+1:(i-3)*n) = 0;
        x((i-1-2)*n+1:(i-2)*n) = 0;
        x((i-1-1)*n+1:(i-1)*n) = 0;
        x((i-1)*n+1:i*n) = lastbit;
        counter = 0;
        pulse = 0;
      end
    end
  else
    counter = 0;
    x((i-1)*n+1:i*n) = -lastbit;
    lastbit = -lastbit;
    pulse = pulse + 1;
  end
end

plot(t, x, 'Linewidth', 3);
axis([0, length(bits)-1, -2, 2]);
grid on;

title('HDB3 Encoding', 'fontweight', 'bold', 'fontsize', 20);
xlabel('Time', 'fontweight', 'bold', 'fontsize', 20);
ylabel('Amplitude', 'fontweight', 'bold', 'fontsize', 20);
disp('HDB3 Encoding:');

counter = 0;
lastbit = 1;

% For data bits
ax1 = gca;
ax2 = axes('Position', get(ax1, 'Position'), 'Color', 'none');
set(ax2, 'XAxisLocation', 'top');
set(ax2, 'XLim', get(ax1, 'XLim'));
set(ax2, 'YLim', [-2, 2]);
set(ax2, 'XTick', [bitrate/2:bitrate:T]);
set(ax2, 'YTick', []);
set(ax2, 'XTickLabel', bits, 'fontweight', 'bold', 'fontsize', 18);

% digital decoding..
for i = 1:length(t)
  if t(i)>counter
    counter = counter + 1;
    if x(i)==lastbit
      result(counter-3:counter) = 0;
    else
      if(x(i)==0)
        result(counter) = 0;
      else
        result(counter) = 1;
        lastbit = -lastbit;
      end
    end
  end
end

disp('HDB3 Decoding:');
disp(result);
