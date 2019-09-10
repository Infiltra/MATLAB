clc;
clear all;
close all;
%gray does not seem to work check it up when time comes by
%OFDM PARAMETERS
ofdm.SymbolSize = input('Symbol Size N ');
ofdm.SymbolNumbers = input('Total number of symbols to be simulated k ');
ofdm.ModType = input('Type of carrier modualtion(M-PSK[1] or M-QAM[2]) ');
ofdm.ModOrder = input('Number of modulation order M ');
ofdm.CyclicPrefix = input('Cyclic prefix input CP ');
ofdm.PhaseOffset = input('Phase offset input in BaseBand ');
ofdm.PreferSymbol = input('Specify binary[1] or gray[2] ');
%Baseband modualtion starts here
%More parameters of ofdm can be added here
%modualtion prefernce symbol
if ofdm.PreferSymbol == 1
    ofdm.PreferSymbol = 'binary';
else
    ofdm.PreferenceSymbol = 'gray';
end
%per subcarrier modulaiton begins here
if ofdm.ModType == 1
    Tx_h_vec = modem.pskmod('M', ofdm.ModOrder, 'PhaseOffset', ofdm.PhaseOffset, 'Symbolorder', ofdm.PreferSymbol);
    Rx_h_vec = modem.pskdemod('M', ofdm.ModOrder, 'PhaseOffset', ofdm.PhaseOffset, 'Symbolorder', ofdm.PreferSymbol);
else
    Tx_h_vec = modem.qammod('M', ofdm.ModOrder, 'PhaseOffset', ofdm.PhaseOffset, 'Symbolorder', ofdm.PreferSymbol);
    Rx_h_vec = modem.qamdemod('M', ofdm.ModOrder, 'PhaseOffset', ofdm.PhaseOffset, 'Symbolorder', ofdm.PreferSymbol);
end
%for a data genrated for the ofdm symbol data has to converted to parallel
%and modualted with subcarrier
ofdm.data = randi([0 ofdm.ModOrder-1], ofdm.SymbolNumbers, ofdm.SymbolSize);
%map ofdm data here
ofdm.map_data = modulate(Tx_h_vec, ofdm.data);
%ofdm serial to parallel conversion
ofdm.parallel = ofdm.map_data.';
%IFFT in passband
ofdm.pass = ifft(ofdm.parallel, ofdm.SymbolSize);
%to parallel
ofdm.serial = ofdm.pass.';
%cyclic prefixing
ofdm.CP1 = ofdm.serial(:,end-ofdm.CyclicPrefix+1:end);
%build with cyclic prefix
ofdm.cp = [ofdm.CP1 ofdm.serial];
%CHANNEL
%AWGN typical channel is considered
%Add noise to the channel
SNRbegin = 0;
SNRIncrement = 2;
SNREnd = 30;
%intialize dummy for CP extraction
c = 0;
%intialize zero vector for SNR noise
r = zeros(size(SNRbegin:SNRIncrement:SNREnd));
%recursive computation for CP extraction and SNR
for snr = SNRbegin:SNRIncrement:SNREnd
    c = c + 1;%Dummy init for count
    %channel noise addition
    ofdm.noise = awgn(ofdm.cp, snr);
    %CP removal
    ofdm.cp_removed = ofdm.noise(:,ofdm.CyclicPrefix+1:ofdm.SymbolSize+ofdm.CyclicPrefix);
    %Serial to parallel
    ofdm.parallel = ofdm.cp_removed.';
    %Democulate Passband
    ofdm.demod = fft(ofdm.parallel, ofdm.SymbolSize);
    %parallel to serial
    ofdm.rxserial = ofdm.demod.';
    %unmap symbols to block
    ofdm.unmap = demodulate(Rx_h_vec, ofdm.rxserial);
    %symbol error rate calculation
    [n, r(c)] = symerr(ofdm.data, ofdm.unmap);
end
snr = SNRbegin:SNRIncrement:SNREnd;
%plot here
semilogy(snr,r,'-ok','linewidth',2,'markerfacecolor','r','markersize',8,'markeredgecolor','b');grid;
title('Symbol error vs SNR');
xlabel('SNR');
ylabel('Symbol Error');
legend('SER N for various values of N')