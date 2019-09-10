clc;
clear all;
%transmit antennas here
Nt = 4;
L = 8;
%get the spectral efficiency
m_all = log2(Nt*L);
%enter the modulation order
M = 8;
%look up table for the symbols
lut = pskmod([0:M-1], M);
scatterplot(lut);
%empty transmit vector
x = zeros(1, Nt);
%random bits gen
%get to parallel imm.
x_i = randi([0 1], m_all, 1).';
%sub vector the x_i
%antenna select
x_as = [x_i(1) x_i(2)];
%symbol bitvector
x_bit = [x_i(3) x_i(4) x_i(5)];
%symbol mapping
x_sym1 = bi2de(x_bit, 'left-msb');
x_sym = lut(x_sym1);
%the x is of size 1xNt
sym_pos = bi2de(x_as, 'left-msb') + 1;
x(sym_pos) = x_sym;
x
