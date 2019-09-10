clc;
clear all;
%intialize SNR
snrdB = 0:0.5:30;
for i1 = 1:length(snrdB)
    snrlin(i1) = 10^(snrdB(i1)/10);
    pe(i1) = qfunc(sqrt(snrlin(i1)));
end
semilogy(snrdB, pe, '-ok', 'MarkerFaceColor', 'r');grid on
title('Simple SNR graph');xlabel('SNR');ylabel('P_e');
