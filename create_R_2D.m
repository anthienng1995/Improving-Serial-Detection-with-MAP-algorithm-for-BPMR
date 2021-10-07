function [R2D_output] = create_R_2D(h,snr)
ht = zeros(5);
ht(2:end-1,2:end-1) = h;
HH = conv2(fliplr(flipud(ht)),ht);
ct1 = 1;
for i = 5:-1:1
    for j = 5:-1:1
        ct2 = 1;
        for ii = i:i+4
            for jj = j:j+4
                hM(ct1,ct2) = HH(ii,jj);
                ct2 = ct2 + 1;
            end
        end
        ct1 = ct1 + 1;
    end
end
R2D_output = hM + 10^(-snr/10)*eye(25);