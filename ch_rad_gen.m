%development of H
clc;clear all;
%transmit and receive antennas count
Nt = 4;
% input('enter the transmit antennas ');
nt = 1:1:Nt;
Nr = 4;
nr = 1:1:Nr;
%define some arbitary value of scatter
l = 4;
L = 1:1:l;
%generate complex gain coeff
alpha_l = (1/sqrt(2))*(randn (l)) + 1i*randn(l);%could have made a mistake here
%define constants
c = 3e8;
freq_mm = 60*10^9;
lambda_wav = c/freq_mm;%wavelength
%finding azimuth of transmit and receive antennas
%needed necessary constant d
d = lambda_wav;
%declare the frequencies
%transmit antenna
%the phi's are redundant uless used in the beamforms
phi_l_T = 1:(360/length(L)):360;
phi_l_R = 1:(360/length(L)):360;
%get the main manifold beamform vectors
%transmit manifold
mainT_const = 1/sqrt(Nt);
%construct the beamforms
for i = 1:1:Nt
    for i2 = 1:length(L)
    aT_phi_T1(i2) = (exp((j*2*pi*nt(i)*d*sind(phi_l_T(i2)))/lambda_wav));
    aT_phi_T = mainT_const.*transpose(aT_phi_T1);
    end
end
%receive manifold
mainR_const = 1/sqrt(Nr);
for i1 = 1:length(L)
    for i3 = 1:length(nr)
    aR_phi_R1(i1) = (exp((j*2*pi*nr(i3)*d*sind(phi_l_R(i1)))/lambda_wav));
    aR_phi_R = mainR_const.*transpose(aR_phi_R1);
    end
end
%construct simplified channel matrix
z1 = (((sqrt((Nt*Nr)/l))*transpose(alpha_l)));
%z = diag(z1);
%get H
%H = AR .* z .*(AT)';

