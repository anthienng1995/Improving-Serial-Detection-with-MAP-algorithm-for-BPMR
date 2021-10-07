function [output] = decoder_MAP_6_input( x, g, snr )
p = g(2,3);
out_detec(1) = -1-2*p;
out_detec(2) = -1;
out_detec(3) = -1+2*p;
out_detec(4) = 1-2*p;
out_detec(5) = 1;
out_detec(6) = 1+2*p;

d = delta_6_input(x, g, snr);
a = forward_6_input(d);
b = backward_6_input(d);
L = LLR_6_input( d,a,b );

output = L(:,1:end-1);
% for ct = 1:size(L,2)-1
%     [val1 idx1] = max(L(:,ct));
%     temp_L = L(:,ct);
%     temp_L(idx1) = 0;
%     [val2 idx2] = max(temp_L);
%     dis_12 = abs(out_detec(idx1) - out_detec(idx2));
%     if idx1 >= idx2
%         x = log(L(idx1,ct)/L(idx2,ct));
%     else
%         x = log(L(idx2,ct)/L(idx1,ct));
%     end
%     
% %     if abs(x) < 0.9
% %         x = -x;
% %     end
%     rel = (2/(1+exp(-2*x))-1)*0.5*dis_12;
% %     output(1,ct) = (out_detec(idx1) + out_detec(idx2))/2 + rel;
%     output(1,ct) = out_detec(idx1);
end

