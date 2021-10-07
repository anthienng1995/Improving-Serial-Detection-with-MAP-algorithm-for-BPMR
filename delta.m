function [ output ] = delta( x, g, snr )
Lc = 10^(snr/10);
for i = 1:length(x)
    %Branches for the input -1
    gam(1,i,1) = exp(-Lc*(x(i)-(-g(1)-g(2)-g(3)))^2);
    gam(2,i,1) = exp(-Lc*(x(i)-(-g(1)+g(2)-g(3)))^2);
    gam(3,i,1) = exp(-Lc*(x(i)-(+g(1)-g(2)-g(3)))^2);
    gam(4,i,1) = exp(-Lc*(x(i)-(+g(1)+g(2)-g(3)))^2);
    %Branches for the input 1
    gam(1,i,2) = exp(-Lc*(x(i)-(-g(1)-g(2)+g(3)))^2);
    gam(2,i,2) = exp(-Lc*(x(i)-(-g(1)+g(2)+g(3)))^2);
    gam(3,i,2) = exp(-Lc*(x(i)-(+g(1)-g(2)+g(3)))^2);
    gam(4,i,2) = exp(-Lc*(x(i)-(+g(1)+g(2)+g(3)))^2);
end
output = gam;

