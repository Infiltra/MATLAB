clc;
clear all;
Nt = input('Enter the transmit antenna ');
Na = 1;
M = 4;
lut = pskmod([0:M-1], M);
%avg energy of const
Eavg = sum(abs(lut).^2)/M;
%normalize the lut
N_lut = lut/sqrt(Eavg);
x = zeros(Nt, 1);
%SM symbol
x_i = randi([0,1], log2(M) + log2(Nt), 1);
x_a = x_i(1:Na);
a_i = s_mapping(x_a);
x_s1 = x_i(Na+1:end);
%referred from brijesh kumbhani
x_s = s_mapping(x_s1)-1;
x_q = pskmod(x_s, M)/sqrt(Eavg);
x(a_i) = x_q;