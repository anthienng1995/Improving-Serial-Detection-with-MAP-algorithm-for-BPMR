function [output] = create_codeword_6_input(h)
output = [];
r = h(2,3);%h(2,3)
p1 = h(1,2);
p2 = h(3,2);
input(1) = -1-2*r;
input(2) = -1;
input(3) = -1+2*r;
input(4) = 1-2*r;
input(5) = 1;
input(6) = 1+2*r;
for ct1 = 1:6
    for ct2 = 1:6
        for ct3 = 1:6
            mask = [input(ct3) input(ct2) input(ct1)];
            output = [output; sum(sum(mask.*[p1 1 p2]))];
        end
    end
end
end

