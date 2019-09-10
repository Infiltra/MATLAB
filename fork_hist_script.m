clc;
clear all;
close all;
L = 16;
Nt = L;
Nr = L;
th_l = rand(1,L);
phi_l = rand(1,L);

M = 4;
lut = pskmod([0:M-1], M);

xx1 = zeros(Nt, M);
xx1(1:4) = lut(1);xx1(17:20) = lut(2);xx1(33:36) = lut(3);xx1(49:52) = lut(4);
%xx1(65:68) = lut(5);xx1(81:84) = lut(6);xx1(97:100) = lut(7);xx1(113:116) = lut(8);
% %line 2
xx2 = zeros(Nt, M);
xx2(5:8) = lut(1);xx2(21:24) = lut(2);xx2(37:40) = lut(3);xx2(53:56) = lut(4);
% xx2(69:72) = lut(5);xx2(85:88) = lut(6);xx2(101:104) = lut(7);xx2(117:120) = lut(8);
% %line 3
xx3 = zeros(Nt, M);
xx3(9:12) = lut(1);xx3(25:28) = lut(2);xx3(41:44) = lut(3);xx3(57:60) = lut(4);
% xx3(73:76) = lut(5);xx3(89:92) = lut(6);xx3(105:108) = lut(7);xx3(121:125) = lut(8);
% %line 4
xx4 = zeros(Nt, M);
xx4(13:16) = lut(1);xx4(29:32) = lut(2);xx4(45:48) = lut(3);xx4(61:64) = lut(4);


lambda = 3e8./60e9;
pos_tx = [0.0006    0.0031    0.0031    0.0006    0.0003    0.0016    0.0016    0.0003   -0.0003   -0.0016   -0.0016   -0.0003 -0.0006   -0.0031   -0.0031   -0.0006;
       0         0         0         0    0.0005    0.0027    0.0027    0.0005    0.0005    0.0027    0.0027    0.0005 0.0000    0.0000    0.0000    0.0000;
       -0.0034   -0.0016    0.0016    0.0034   -0.0034   -0.0016    0.0016    0.0034   -0.0034   -0.0016    0.0016    0.0034  -0.0034   -0.0016    0.0016    0.0034];
pos_rx = [-0.0006   -0.0031   -0.0031   -0.0006   -0.0003   -0.0016   -0.0016   -0.0003    0.0003    0.0016    0.0016    0.0003 0.0006    0.0031    0.0031    0.0006;
         -0.0000   -0.0000   -0.0000   -0.0000   -0.0005   -0.0027   -0.0027   -0.0005   -0.0005   -0.0027   -0.0027   -0.0005  0         0         0         0;
         -0.0034   -0.0016    0.0016    0.0034   -0.0034   -0.0016    0.0016    0.0034   -0.0034   -0.0016    0.0016    0.0034 -0.0034   -0.0016    0.0016    0.0034];
for ip = 1:30000
    Vr = [];
    Vt = [];
    alpha_l = (sqrt(0.5))*(randn(L, 1) + 1i*(randn(L, 1)));
    for ll = 1:L
        k = (-(2*pi)./lambda)*[sin(th_l(ll))*cos(phi_l(ll)); sin(th_l(ll))*sin(phi_l(ll)); cos(th_l(ll))];
        vr = exp(-1i*k.'*pos_rx);
        vt = exp(-1i*k.'*pos_tx);
        Vr = [Vr vr.'];
        Vt = [Vt vt.'];
    end
    H = Vr*diag(alpha_l)*Vt';
    X = [0;0;0;0; 1+1i*1;1+1i*1;1+1i*1;1+1i*1;0;0;0;0;0;0;0;0];
    n = (sqrt(0.5))*(randn(L, 1) + 1i*(randn(L, 1)));
    Y = H*X + n;
    arg(ip) = min([norm(Y-H*xx1,2)^2 norm(Y-H*xx2,2)^2 norm(Y-H*xx3,2)^2 norm(Y-H*xx4,2)^2]);
 
end
close all, histfit(arg,100,'gamma');hold on;
[phat pci] = gamfit(arg);
%input data?
%pdf = gampdf( , phat(1), phat(2));
[hh kk] = hist(arg, 100);
pdf = gampdf(kk, floor(phat(1)), phat(2));
figure();
plot(kk, pdf);hold on;
alp = (2*L)/Nt;
bet = (((Nt*Nr)*(2*L))/L) + (L^3);
pdf1 = gampdf(kk, alp, bet);
plot(kk, pdf1);grid on;
legend('From est', 'From man');