function x = s_mapping(y);
l = length(y);
de = 0;
for k = 1:l
    de = de + y(end-k+1)*2^(k-1);
end
x = de + 1;