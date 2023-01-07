clc;
clear ;
close all;
[voice,Fs] = audioread('Recording.mp3');
disp("Original Voice")
sound(voice,Fs)
disp("5 sec pause")
pause(5)
order = 2;
size = 2;
N = Fs;

subplot(4,1,1);
plot(voice);
title('voice')
noise=rand(length(voice),2);
primary  =  voice + noise;
disp("Corrupted Voice")
sound(primary,Fs)
disp("5 sec pause")
pause(5)
subplot(4,1,2)
plot(primary)
title('voice + noise')
ref = noise+.25*rand;
subplot(4,1,3)
plot(ref)
title('referance (noisy noise)')
 mu=0.009;
 n=length(primary);
 delayed=zeros(1,order);
 adap=zeros(1,order);
 cancelled=zeros(1,n);
 
 for i = 1:N 
    delayed(1)=ref(i);
     y=delayed*adap';
     cancelled(i)=primary(i)-y;
     adap = adap + 2*mu*cancelled(i) .* delayed;
     delayed(2:order)=delayed(1:order-1);
    
end

 
 subplot(4,1,4);
 plot(cancelled);
 title('adaptive output hopefully it is close to voice')
 disp("Recovered Voice")
sound(cancelled,Fs)