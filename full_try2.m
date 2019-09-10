%development of H
clc;clear all;
%transmit and receive antennas count
Nt = 4;%changed antenna  size today
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
%spatial modulation code here
%enter the modulatio order
M = 8;
%look up table
lut = pskmod([0:M-1], M);
%scatterplot(lut);
%empty trasmit vector
x = zeros(Nr, 1);
%get the spectral efficiency
m_all = log2(Nr*L);
%generate random bits
x_i = randi([0 1], m_all, 1).';
%sub vector the x_i
x_as = [x_i(1) x_i(2)];
%transmit bit over the receive side
x_bit = [x_i(3) x_i(4) x_i(5)];
%symbol mapping
x_sym1 = bi2de(x_bit, 'left-msb') + 1;
x_sym = lut(x_sym1);
%antenna mapping over symbol pos
sym_pos = bi2de(x_as, 'left-msb') + 1;
x(sym_pos) = x_sym;
x;
%generate receive vector
y1 = H*P_C*x;
%receive vector
y = y1 + n; 
%alternate y
y_alt1  = beta_c.*x;
y_alt = y_alt1 + n;
%shat = real(min (y - (beta_c*x))^2);
xx=[];
%all possible receive symbols from each antenna loaded into look up table
%of the receiver
for kk = 1:length(nr)
    for ll = 1:M
        x_dev = zeros(1, length(nr));
        x_dev(kk) = lut(:, ll);
        xx = [xx;x_dev];
    end
end
%find the minimum in subraction
for ij = 1:size(xx,1)
   temp(ij) = norm(y - (beta_c*(xx(ij,:)).').^2);
end
