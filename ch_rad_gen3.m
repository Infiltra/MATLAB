clc;
clear all;
%develop H
Nt = 4;
Nr = 4;
nt = 0:Nt-1;
nr = 0:Nr-1;
%arbitary value of scatter
L = 8;
%give the AoA and AoD azimuths
phi_l_T = 0+(2*pi)*rand(1, L);
phi_l_R = 0+(2*pi)*rand(1, L);
%get freq, wavlth and distance between ULA
freq_mm = 30e9;
c = 3e8;
lambda_wav = c/freq_mm;
d = lambda_wav;
%transmit and receive array consts
mainT_const = 1/sqrt(Nt);
mainR_const = 1/sqrt(Nr);
for i1 = 1:L
    for i2 = 1:length(nt)
        a_T(i2, i1) = mainT_const.*exp((1i*(nt(i2)*2*pi*d*sin(deg2rad(phi_l_T(i1))))/(lambda_wav)));
    end
end
for i3 = 1:L
    for i4 = 1:length(nr)
        a_R(i4, i3) = mainR_const.*exp((1i*nr(i4)*2*pi*d*sin(deg2rad(phi_l_R(i3)))/(lambda_wav)));
    end
end
%complex path gain
alpha_l = (1/sqrt(2))*(randn(L, 1) + 1i*randn(L, 1));
z1 = sqrt((Nt*Nr)/L)*alpha_l.';
z = diag(z1);
%simplified channel model
H = a_R*z*a_T';
%modelling of conventional system
rr = inv(H*ctranspose(H));
rr1 = trace(rr);
beta_c = sqrt(Nr/rr1);
%precoding matrix
P_C = beta_c.*ctranspose(H)*(rr1);

