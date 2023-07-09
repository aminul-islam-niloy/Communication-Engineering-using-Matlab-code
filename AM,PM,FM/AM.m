clc;
clear all;
close all;

Ac=2; %carrier amplitude
fc=0.5; %carrier frequency
Am=.5; %message signal amplitude
fm=.05; %message signal frequency
Fs=100; %sampling rate/frequency

sampleTime=1/Fs;
ka=1;%Amplitude Sensitivity
T=50;
t=0:sampleTime:T;%defining the time range & disseminating it into samples
ct=Ac*cos(2*pi*fc*t); %defining the carrier signal wave
mt=Am*cos(2*pi*fm*t); %defining the message signal
AM=ct.*(1+ka*mt); %Amplitude Modulated wave, according to the standard definition
figure(1);

subplot(3,1,1);%plotting the message signal wave
plot(mt);
ylabel('Message signal');


subplot(3,1,2); %plotting the carrier signal wave
plot(ct);
ylabel('carrier');

subplot(3,1,3); %plotting the amplitude modulated wave
plot(AM);
ylabel('AM signal');
