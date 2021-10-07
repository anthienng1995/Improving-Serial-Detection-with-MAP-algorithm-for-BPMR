function [ output ] = LLR( d,a,b )
for i = 1:size(d,2)
    numerator = a(1,i)*d(1,i,2)*b(2,i+1)+a(2,i)*d(2,i,2)*b(4,i+1)+a(3,i)*d(3,i,2)*b(2,i+1)+a(4,i)*d(4,i,2)*b(4,i+1);
    denominator = a(1,i)*d(1,i,1)*b(1,i+1)+a(2,i)*d(2,i,1)*b(3,i+1)+a(3,i)*d(3,i,1)*b(1,i+1)+a(4,i)*d(4,i,1)*b(3,i+1);
    L(1,i) = denominator;
    L(2,i) = numerator;
end

output = L(:,1:end-2);