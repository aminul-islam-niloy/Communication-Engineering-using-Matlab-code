clear all;
close all;
clc;


%Bipolar with 8 Zeros Substitution (B8Zs) is commonly used in North America.
% • In this technique, eight consecutive zero-level voltages are replaced
% by the sequence 000VB0VB. • The V in the sequence denotes violation; this is a nonzero voltage that breaks an AMI rule of encoding (opposite polarity from the previous).

%bits = input('prompt');
bits = [1 0 0 0 0 0 0 0 0 1];
bitrate = 1;
n = 1000;
T = length(bits)/bitrate;
N = n*length(bits);
dt = T/N;
t = 0:dt:T-dt;
x = zeros(1,length(t));

counter = 0;
lastbit = 1;

%encoding
for i=1:length(bits)
  if bits(i)==0
    counter = counter + 1;
    if counter==8
      x((i-1-7)*n+1:(i-7)*n) = 0;
      x((i-1-6)*n+1:(i-6)*n) = 0;
      x((i-1-5)*n+1:(i-5)*n) = 0;

      x((i-1-4)*n+1:(i-4)*n) = lastbit;
      x((i-1-3)*n+1:(i-3)*n) = -lastbit;

      lastbit = -lastbit;

      x((i-1-2)*n+1:(i-2)*n) = 0;

      x((i-1-1)*n+1:(i-1)*n) = lastbit;
      x((i-1)*n+1:i*n) = -lastbit;

      lastbit = -lastbit;
      counter = 0;
    end
  else
    counter = 0;
    x((i-1)*n+1:i*n) = -lastbit;
    lastbit = -lastbit;
  end
end

plot(t, x, 'Linewidth', 3);
axis([0, length(bits), -2, 2]);
title('B8ZS Encoding', 'fontweight', 'bold', 'fontsize', 20);
xlabel('Time', 'fontweight', 'bold', 'fontsize', 20);
ylabel('Amplitude', 'fontweight', 'bold', 'fontsize', 20);
disp('B8ZS Encoding:');
grid on;

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
lastbit = 1;
for i = 1:length(t)
  if t(i)>counter
    counter = counter + 1;
    if x(i)==lastbit
      result(counter:counter+4) = 0;
      counter = counter + 4;
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

disp('B8ZS Decoding:');
disp(result);


