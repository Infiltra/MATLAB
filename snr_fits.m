%fit for SNR
clc;
clear all;
snr_db = 0:1:40;
snr_lin = 10.^(snr_db/20);
pdf_lin = histfit(snr_lin, 50, 'exponential');
[hh kk] = hist(snr_lin, 50);
phat = fitdist(kk.', 'Exponential');
pdf1 = exppdf(kk, phat.mu);
figure();
plot(kk, pdf1);grid on