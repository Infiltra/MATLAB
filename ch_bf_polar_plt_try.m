%get 2d beamformng
clc;
clear all;
%array phase profile
theta_t = -pi/2:pi/2;
theta_r = -pi/2:pi/2;
%transmit and receive antenna
Nt = input('Enter the number of transmit antenna ');
Nr = input('Enter the number of receive antenna ');
nt = 1:1:Nt;%antenna element profile
nr = 1:1:Nr;
%wavelength
f_c = input('Enter the frequency in GHz ');
c = 3e8;
lambda_wav = c/f_c;
d = lambda_wav;
%N element ULA
%form 2d phase profile as a function of angular direction for the elements
%transmit profile
for i1 = 1:length(nt)
    for i2 = 1:length(theta_t)
    a_t1(i1, i2) = exp(-j*2*pi*nt(i1)*(d*sin(theta_t(i2)/lambda_wav)));
    a_t = a_t1.';
    end
end
figure();
for i5 = 1:length(nt)
    polarplot(theta_t, a_t1(i5, :));
 end
%receive profile
for i3 = 1:length(nr)
    for i4 = 1:length(theta_r)
        a_r1(i3, i4) = exp(-j*2*pi*nr(i3)*(d*sin(theta_t(i4)/lambda_wav)));
        a_r = a_r1.';
    end
end