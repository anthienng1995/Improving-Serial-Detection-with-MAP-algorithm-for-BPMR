function [ output ] = LLR_6_input( d,a,b )
for jj = 1:size(d,2)-1
    for ct = 1:6
        symbol(ct,jj) = 0;
        for ct1 = 1:36
            symbol(ct,jj) = symbol(ct,jj) + a(ct1,jj)*d(ct1,jj,ct)*b(mod(6*(ct1-1),36)+ct,jj+1);
        end
    end
end

output = symbol;