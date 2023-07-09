clc; clear all; close all;

t0 = 0 : 0.01 : 1;

A1 = 10;

f1 = 4;
f2 = 8;
f3 = 16;



%Original signal
y0 = A1 * sin(2 * pi * f1 * t0);
subplot(2,2,1);
plot(t0, y0);
xlabel('time');
ylabel('y');
title('Composite Signal ');

% sampling of the original signal at nyquist rate

fs = 16;    %nyquist rate fs = 2*fm
ts = 1/fs;  %nyquist interval 1 / fs
t1 = 0:ts:1;
y1 = A1 * sin(2 * pi * f1 * t1);
subplot(2,2,2);
hold on;
plot(t0, y0, t1, y1);
xlabel('t');
ylabel('y');
title('sampling at nyquist rate ')

