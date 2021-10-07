function [ output ] = delta_6_input( x, g, snr )
Lc = 10^(snr/10);

codeword =  create_codeword_6_input(g);

for jj = 1:length(x)
    temp_data = x(jj);
    for i = 1:216
        dis(i,jj) = (temp_data - (codeword(i,1)))^2;
    end
    
    for ct = 1:6 % the ct-th symbol
        for ct1 = 1:6:216
            gam((ct1-1)/6+1,jj,ct) = exp(-Lc*dis(ct1+ct-1,jj));
        end    
    end
end

output = gam;