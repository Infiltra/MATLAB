clc;
clear all;
%transmit antenna count
Nt = 4;
%the input bit stream is divided into vectors each with L.Nt bits each
L = 2;
m_all = log2(Nt*L);
%modulation order
M = 2;
%give the look up table(is it necessary?)
lut = pskmod([0:M-1], M);
%scatter does not work, we can use the same thing in the receiver side too
%scatterplot(lut);
%generate the bits
bits_t1 = randi([0 1], m_all, 1);
%third bit corresponds to the data that is being sent
%map the 3rd bit to the lut constellation graph
bit_extn_lth = 1:1:m_all;
%transpost to parallel
bits_t = bits_t1.';
for ii = 1:length(bit_extn_lth)
    if bits_t(ii) == 0 && bits_t(ii+1) == 0 && bits_t(ii+2) == 0
        x_vec_t = [0 0 lut(1)];
    elseif bits_t(ii) == 0 && bits_t(ii+1) == 0 && bits_t(ii+2) == 1
        x_vec_t = [0 0 lut(2)];
    elseif bits_t(ii) == 0 && bits_t(ii+1) == 1 && bits_t(ii+2) == 0
        x_vec_t = [0 1 lut(1)];
    elseif bits_t(ii) == 0 && bits_t(ii+1) == 1 && bits_t(ii+2) == 1
        x_vec_t = [0 1 lut(2)];
    elseif bits_t(ii) == 1 && bits_t(ii+1) == 0 && bits_t(ii+2) == 0
        x_vec_t = [1 0 lut(1)];
    elseif bits_t(ii) == 1 && bits_t(ii+1) == 0 && bits_t(ii+2) == 1
        x_vec_t = [1 0 lut(2)];
    elseif bits_t(ii) == 1 && bits_t(ii+1) == 1 && bits_t(ii+2) == 0
        x_vec_t = [1 1 lut(1)];
    else bits_t(ii) == 1 && bits_t(ii+1) == 1 && bits_t(ii+2) == 1
        x_vec_t = [1 1 lut(2)];
    end
end