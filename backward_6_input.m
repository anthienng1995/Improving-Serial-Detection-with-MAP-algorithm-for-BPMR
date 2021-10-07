function [ output ] = backward_6_input( d )
b(:,1) = [1 ones(1,35)*0.01];
for jj = 2:size(d,2) + 1
    for ct = 1:36
        b(ct,jj) = 0;
        for ct1 = 1:6
            b(ct,jj) = b(ct,jj) + b(mod((ct-1)*6+ct1-1,36)+1,jj-1)*d(ct,size(d,2) - jj + 2,ct1);
        end
    end
    s = sum(b(:,jj));
    b(:,jj) = b(:,jj) / s;
end

output = b(:,end:-1:1);