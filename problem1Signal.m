% Analog Signal
A = 5;
f = 2;
t = 0:0.01:2;
xt = A*sin(2*pi*f*t);

subplot(3,1,1);
plot(t,xt);
xlabel('Time(t)');
ylabel('Amplitude');
title('Analog Signal');


% Digital
fs = 6*f;
Ts = 1/fs;
n = 0:Ts:fs*Ts;
xn = A*sin(2*pi*f*n);

subplot(3,1,2);
stem(n,xn);
xlabel('Time(n)');
ylabel('Amplitude');
title('Digital Signal: x(n) = A*sin(2*pi*f*n)');


% Composite
A1 = 4;
A2 = 5;
A3 = 2;

f1 = 2;
f2 = 3;
f3 = 1;

x1 = A1*sin(2*pi*f1*t);
x2 = A2*sin(2*pi*f2*t);
x3 = A3*sin(2*pi*f3*t);

xf = x1 + x2 + x3;

subplot(3,1,3);
plot(t, xf);
xlabel('Time(t)');
ylabel('Amplitude');
title('Composite Signal');
grid on;

