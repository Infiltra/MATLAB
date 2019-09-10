%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIMPLE UNIFORM LINEAR ARRRAY
% WITH VARIABLE NUMBER OF ELEMENTS
% MATRIX IMPLEMENTATION
% COPYRIGHT RAYMAPS (C) 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

f=1e9;
c=3e8;
l=c/f;
d=l/2;
no_elements=8;

theta=0:pi/180:2*pi;
n=1:no_elements;
n=transpose(n);

A=(n-1)*(i*2*pi*d*cos(theta)/l);
X=exp(-A);
w=ones(1,no_elements);
r=w*X;

polar(theta,abs(r),'r')
title ('Gain of a Uniform Linear Array')