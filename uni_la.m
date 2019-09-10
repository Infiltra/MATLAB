clear all
close all

f=1e9;
c=3e8;
l=c/f;
d=l/2;
no_elements=4;

theta=0:pi/180:2*pi;
r=zeros(1,length(theta));

for n=1:no_elements
  dx(n,:)=(n-1)*d*cos(theta);
  r=r+exp(-i*2*pi*(dx(n,:)/l));
end

polar(theta,abs(r),'b')
title ('Gain of a Uniform Linear Array')