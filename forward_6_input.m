function [ output ] = forward_6_input( d )
a(:,1) = [1 0.01*ones(1,35)];
for jj = 2: size(d,2) + 1    
    %General
    for ct2 = 1:6
        for ct = 1:6:36
            a(ct+ct2-1,jj) = 0;
            offset = floor((ct-1)/6) + 1;
            for ct1 = 1:6       
                a(ct+ct2-1,jj) = a(ct+ct2-1,jj) + a(offset + 6*(ct1-1),jj-1)*d(offset + 6*(ct1-1),jj-1,ct2);
            end
        end
    end
    
    s = sum(a(:,jj));
    a(:,jj) = a(:,jj)/s;
end

output = a;