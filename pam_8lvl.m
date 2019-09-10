%mem clear func
clc;
clear;
clear all;
warning off;
%8lvl PAM
%MOD index
M = 8;
for i=1:M
    a(i) = 2*i-1-M;
end
%disp(a);
%bit sequence
n = randi(1, 12);
disp(n);
%unipolar coding
for j = 1:length(n)
    if n(j) == 1
        y(j) = 1;
    else 
        y(j) = 0;
    end
end
%disp(y);
%pulse shaping
pam8 = [];
for k = 1:3:length(n)-1
    if n(k) == 0 && n(k+1) == 0 && n(k+2) == 0
        pam = a(1);
    elseif n(k) == 0 && n(k+1) == 0 && n(k+2) == 1
        pam = a(2);
    elseif n(k) == 0 && n(k+1) == 1 && n(k+2) == 0
        pam = a(3);
    elseif n(k) == 0 && n(k+1) == 1 && n(k+2) == 1 
        pam = a(4);
    elseif n(k) == 1 && n(k+1) == 0 && n(k+2) == 0
        pam = a(5);
    elseif n(k) == 1 && n(k+1) == 0 && n(k+2) == 1
        pam = a(6);
    elseif n(k) == 1 && n(k+1) == 1 && n(k+2) == 0
        pam = a(7);
    else
        pam = a(8);
    end
    pam8 = [pam8 pam];
end
disp(pam8);
%pulse shaping
i = 1;
l = 3;
t = 0:0.01:length(n);
for jj=1:length(t)
    if t(jj) <= l
        y(jj) = pam8(i);
    else
        y(jj) = pam8(i);
        l = l+3;
        i = i+1;
    end
end
plot(t, y);
axis([0 length(n) -20 20]);