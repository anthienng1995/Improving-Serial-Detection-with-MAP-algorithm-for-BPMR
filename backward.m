function [ output ] = backward( d,b0 )
b(:,1) =b0;
for i = 2:size(d,2) + 1
    b(1,i) = b(1,i-1)*d(1,size(d,2) - i + 2,1)+b(2,i-1)*d(1,size(d,2) - i + 2,2);
    b(2,i) = b(3,i-1)*d(2,size(d,2) - i + 2,1)+b(4,i-1)*d(2,size(d,2) - i + 2,2);
    b(3,i) = b(1,i-1)*d(3,size(d,2) - i + 2,1)+b(2,i-1)*d(3,size(d,2) - i + 2,2);
    b(4,i) = b(3,i-1)*d(4,size(d,2) - i + 2,1)+b(4,i-1)*d(4,size(d,2) - i + 2,2);
    s = sum(b(:,i));
    b(:,i) = b(:,i) / s;
end
output = b(:,end:-1:1);