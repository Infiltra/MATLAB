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
for ii = 1:length(x_bit)
    if x_bit == [0,0,0]
        x_sym = lut(1);
    elseif x_bit == [0,0,1]
        x_sym = lut(2);
    elseif x_bit == [0,1,0]
        x_sym = lut(3);
    elseif x_bit == [0,1,1]
        x_sym = lut(4);
    elseif x_bit == [1,0,0]
        x_sym = lut(5);
    elseif x_bit == [1,0,1]
        x_sym = lut(6);
    elseif x_bit == [1,1,0]
        x_sym = lut(7);
    else
        x_sym = lut(8);
    end
end
%antenna select vector
%the x is of size 1xNt
sym_pos = bi2de(x_as, 'left-msb') + 1;
x(sym_pos) = x_sym;
x
