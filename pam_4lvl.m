%mem clear func
clc;
clear;
clear all;
warning off;
%8lvl PAM
%MOD index
M = 4;
for i=1:M
    a(i) = 2*i-1-M;
end
%disp(a);
%bit sequence
n = randint(1, 8);
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
pam4 = [];
for k = 1:2:length(n)-1
    if n(k) == 0 && n(k+1) == 0
        pam = a(1);
    elseif n(k) == 0 && n(k+1) == 1
        pam = a(2);
    elseif n(k) == 1 && n(k+1) == 1
        pam = a(3);
    else
        pam = a(4);
    end
    pam4 = [pam4 pam];
end
disp(pam4);
%pulse shaping
i = 1;
l = 2;%varialbe for time interval
t = 0:0.01:length(n);
for jj=1:length(t)
    if t(jj) <= l
        y(jj) = pam4(i);
    else
        y(jj) = pam4(i);
        l = l+2;
        i = i+1;
    end
end
plot(t, y);
axis([0 length(n) -4 4]);