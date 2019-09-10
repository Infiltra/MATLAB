%development of H
clc;
clear all;
%transmit and receive antenna number
Nt = input('enter the transmit antenna count ');
Nr = input('enter the receive antenna count ');
L = input('enter the scatter ');
%build complex gain coeff alpha
alpha_l = randn(1, L) + i*randn(1, L);

