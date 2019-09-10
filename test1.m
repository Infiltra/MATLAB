clc;
clear all;
close all;
snr_db = 0:5:30;
snr_lin = 10.^(snr_db./10);
for  p1 = 1:length(snr_db)
    berr(p1) = (0.5)*(1 - sqrt(snr_lin(p1)./(2 + snr_lin(p1))));
end
%receive antenna
L = 8;
combination = nchoosek(2*L - 1, L);
for p2 = 1:length(snr_db)
    berr1(p2) = ((1/snr_lin(p2))).^L;
end
berr_multiant = combination*berr1*(0.5.^L);
semilogy(snr_db, berr, '-dr', 'LineWidth', 1.5);hold on;
semilogy(snr_db, berr_multiant, '-og', 'LineWidth', 1.5);
grid on;legend('L = 1', 'L = 8');
xlabel('SNR(dB)');ylabel('BER');title('Multi Antenna BER')