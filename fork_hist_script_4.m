clc;
clear all;
close all;
L = 4;
Nt = L;
Nr = L;
th_l = rand(1,L);
phi_l = rand(1,L);

M = 4;
lut = pskmod([0:M-1], M);

xx1 = zeros(Nt, M);
xx1(1) = lut(1);xx1(5) = lut(2);xx1(9) = lut(3);xx1(13) = lut(4);
%xx1(65:68) = lut(5);xx1(81:84) = lut(6);xx1(97:100) = lut(7);xx1(113:116) = lut(8);
% %line 2
xx2 = zeros(Nt, M);
xx2(2) = lut(1);xx2(6) = lut(2);xx2(10) = lut(3);xx2(14) = lut(4);
% xx2(69:72) = lut(5);xx2(85:88) = lut(6);xx2(101:104) = lut(7);xx2(117:120) = lut(8);
% %line 3
xx3 = zeros(Nt, M);
xx3(3) = lut(1);xx3(7) = lut(2);xx3(11) = lut(3);xx3(15) = lut(4);
% xx3(73:76) = lut(5);xx3(89:92) = lut(6);xx3(105:108) = lut(7);xx3(121:125) = lut(8);
% %line 4
xx4 = zeros(Nt, M);
xx4(4) = lut(1);xx4(8) = lut(2);xx4(12) = lut(3);xx4(16) = lut(4);


lambda = 3e8./60e9;
pos_tx =  [0.0174    0.0174   -0.0174   -0.0174; 0         0    0.0000    0.0000;-0.0985    0.0985   -0.0985    0.0985];
pos_rx = [-0.0174   -0.0174    0.0174    0.0174;-0.0000   -0.0000         0         0;-0.0985    0.0985   -0.0985    0.0985];
for ip = 1:10000
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
    X = [0;0;1+1i*1;1+1i*1];
    n = (sqrt(0.5))*(randn(L, 1) + 1i*(randn(L, 1)));
    Y = H*X + n;
    arg(ip) = min([norm(Y-H*xx1,2)^2 norm(Y-H*xx2,2)^2 norm(Y-H*xx3,2)^2 norm(Y-H*xx4,2)^2]);
 
end
close all, histfit(arg,100,'gamma');
[phat pci] = gamfit(arg);
[hh kk] = hist(arg, 100);
pdf = gampdf(kk, phat(1), phat(2));
figure();
plot(kk, pdf);hold on;
alp = (2*L)/Nt;
bet = (Nt*Nr) + (L*5);
pdf1 = gampdf(kk, alp, bet);
plot(kk, pdf1);grid on;
legend('From est', 'From man');