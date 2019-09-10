%development of H
clc;clear all;
%transmit and receive antennas count
Nt = 4;
% input('enter the transmit antennas ');
nt = 0:Nt-1;
Nr = 4;
%input('enter the recerive antennas ');
nr = 0:Nr-1;
%define some arbitary value of scatter
L = 8;
%define constants
c = 3e8;
freq_mm = 30e9;
%input('Enter the frequnecy in GHz ');
lambda_wav = c/freq_mm;%wavelength
%finding azimuth of transmit and receive antennas
%needed necessary constant d
d = lambda_wav;
%declare the frequencies
%transmit antenna
%the phi's are redundant uless used in the beamforms
phi_l_T = 0+(2*pi)*rand(1, L);
phi_l_R = 0+(2*pi)*rand(1, L);
%get the main manifold beamform vectors
%transmit and receive ant array
mainT_const = 1/sqrt(Nt);
mainR_const = 1/sqrt(Nr);
for i1 = 1:length(phi_l_T)
    a_T(:,i1) = mainT_const.*exp((1i*(nt-1)*2*pi*d*sin(deg2rad(phi_l_T(i1))))/(lambda_wav));
    a_R(:,i1) = mainR_const.*exp((1i*(nr-1)*2*pi*d*sin(deg2rad(phi_l_T(i1))))/(lambda_wav));
end
%complex path gain
alpha_l = sqrt(1/2)*(randn(L, 1) + 1i*(randn(L, 1)));
z1 = sqrt((Nt*Nr)/L)*alpha_l.';
z = diag(z1);
%simplified channel model
H = a_R*z*a_T';
%noise vector complex gaussian
n = sqrt(1/2)*(randn(Nr, 1) + 1i*randn(Nr, 1));
%scaling factor
ddnr  = trace(inv(H*H'));
beta_c = sqrt(Nr/ddnr);
%form the precoding matrix
P_C = beta_c*H'*(inv(H*H'));
