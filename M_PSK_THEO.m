%AWGN channel

clc;
clear all;
close all;
snr_db = 0:1:40;
M = 4;
snr_lin = 10.^(snr_db/10);
vl = sqrt(2*snr_lin*sin((pi/M)^2));
vl1 = (M-1)*qfunc(vl);
semilogy(snr_db, vl1)

% for p1 = 1:length(snr_db)
%     ps4(p1) = (M-1)*qfunc(sqrt(2*snr_lin(p1)*sin((p1/M)^2)));
% end