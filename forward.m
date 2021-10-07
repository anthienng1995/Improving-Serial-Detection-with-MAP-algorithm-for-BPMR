function [ output ] = forward( delta,a0 )
a(:,1) = a0;
for i = 2: size(delta,2) + 1
    a(1,i) = a(1,i-1)*delta(1,i-1,1) + a(3,i-1)*delta(3,i-1,1);
    a(2,i) = a(1,i-1)*delta(1,i-1,2) + a(3,i-1)*delta(3,i-1,2);
    a(3,i) = a(2,i-1)*delta(2,i-1,1) + a(4,i-1)*delta(4,i-1,1);
    a(4,i) = a(2,i-1)*delta(2,i-1,2) + a(4,i-1)*delta(4,i-1,2);
    s = sum(a(:,i));
    a(:,i) = a(:,i) / s;
end

output = a;

