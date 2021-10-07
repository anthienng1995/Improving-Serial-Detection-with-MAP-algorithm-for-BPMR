function [output] = serial_detection_with_MAP_algorithm( data, g, snr )
p = g(2,3);
out_detec(1) = -1-2*p;
out_detec(2) = -1;
out_detec(3) = -1+2*p;
out_detec(4) = 1-2*p;
out_detec(5) = 1;
out_detec(6) = 1+2*p;

output_MAP_vertical = {};
for ct = 2:size(data,2) - 1
    output_MAP_vertical(:,ct-1) = num2cell(decoder_MAP_6_input( data(2:end-1,ct)', g, snr ),1)';
end

% temp_output_vertical_detector = [];
% for ct1 = 1:size(output_MAP_vertical,1)
%     for ct2 = 1:size(output_MAP_vertical,2)
%         [val1 idx1] = max(output_MAP_vertical{ct1,ct2});
%         temp_L = output_MAP_vertical{ct1,ct2};
%         temp_L(idx1) = 0;
%         [val2 idx2] = max(temp_L);
%         dis_12 = abs(out_detec(idx1) - out_detec(idx2));
%         if idx1 >= idx2
%             x = log(output_MAP_vertical{ct1,ct2}(idx1)/output_MAP_vertical{ct1,ct2}(idx2));
%         else
%             x = log(output_MAP_vertical{ct1,ct2}(idx2)/output_MAP_vertical{ct1,ct2}(idx1));
%         end
% 
%         rel = (2/(1+exp(-2*x))-1)*0.5*dis_12;
%         temp_output_vertical_detector(ct1,ct2) = (out_detec(idx1) + out_detec(idx2))/2 + rel;
%     end
% end

hard_output = [];
for ct1 = 1:size(output_MAP_vertical,1)
    for ct2 = 1:size(output_MAP_vertical,2)
        [val_temp idx_temp] = max(output_MAP_vertical{ct1,ct2});
        hard_output(ct1,ct2) = out_detec(idx_temp);
    end
end

temp_output_vertical_detector = [];
for ct = 2:size(data,2) - 1
    temp_output_vertical_detector = [temp_output_vertical_detector MAP_soft_output_for_6_value(data(2:end-1,ct)',hard_output(:,ct-1)',g)'];
end
%%
output_horizontal = num2cell(zeros(size(data,1)));
for ct1 = 1 : size(output_horizontal,1)
    for ct2 = 1 : size(output_horizontal,2)
        output_horizontal(ct1,ct2) = num2cell([0;1],1);
    end
end
for ct = 1:size(temp_output_vertical_detector,1)
    L = decoder_MAP( temp_output_vertical_detector(ct,:), g(2,:), snr );
    for ct1 = 1:size(output_MAP_vertical,2) - 2
        temp_numerator(ct1) = sum(output_MAP_vertical{ct,ct1}([2 5 3 6]));
    end
    numerator = temp_numerator.*L(2,:);
    for ct2 = 1:size(output_MAP_vertical,2) - 2
        temp_denominator(ct2) = sum(output_MAP_vertical{ct,ct2}([1 4 2 5]));
    end
    denominator = temp_denominator.*L(1,:);
%     decision = log(numerator./denominator);
%     temp_output_horizontal = (decision >= 0);
    output_horizontal(ct+2,3:end-2) = num2cell([numerator;denominator],1);
end

hard_output = [];
for ct1 = 1:size(output_MAP_vertical,1)
    for ct2 = 1:size(output_MAP_vertical,2)
        temp_prob_vertical = output_MAP_vertical{ct1,ct2};
        temp_prob_vertical(1) = temp_prob_vertical(1)*(output_horizontal{ct1+2,ct2+2}(2)*output_horizontal{ct1+2,ct2+1}(2)*output_horizontal{ct1+2,ct2}(2));
        temp_prob_vertical(2) = temp_prob_vertical(2)*(output_horizontal{ct1+2,ct2+2}(2)*output_horizontal{ct1+2,ct2+1}(2)*output_horizontal{ct1+2,ct2}(1)+output_horizontal{ct1+2,ct2+2}(1)*output_horizontal{ct1+2,ct2+1}(2)*output_horizontal{ct1+2,ct2}(2));
        temp_prob_vertical(3) = temp_prob_vertical(3)*(output_horizontal{ct1+2,ct2+2}(1)*output_horizontal{ct1+2,ct2+1}(2)*output_horizontal{ct1+2,ct2}(1));
        temp_prob_vertical(4) = temp_prob_vertical(4)*(output_horizontal{ct1+2,ct2+2}(2)*output_horizontal{ct1+2,ct2+1}(1)*output_horizontal{ct1+2,ct2}(2));
        temp_prob_vertical(5) = temp_prob_vertical(5)*(output_horizontal{ct1+2,ct2+2}(2)*output_horizontal{ct1+2,ct2+1}(1)*output_horizontal{ct1+2,ct2}(1)+output_horizontal{ct1+2,ct2+2}(1)*output_horizontal{ct1+2,ct2+1}(1)*output_horizontal{ct1+2,ct2}(2));
        temp_prob_vertical(6) = temp_prob_vertical(6)*(output_horizontal{ct1+2,ct2+2}(1)*output_horizontal{ct1+2,ct2+1}(1)*output_horizontal{ct1+2,ct2}(1));
        temp_prob_vertical = temp_prob_vertical/sum(temp_prob_vertical);
        output_MAP_vertical_temp{ct1,ct2} = temp_prob_vertical;
        [val_temp idx_temp] = max(output_MAP_vertical{ct1,ct2});
        hard_output(ct1,ct2) = out_detec(idx_temp);
    end
end

temp_output_vertical_detector = [];
for ct = 2:size(data,2) - 1
    temp_output_vertical_detector = [temp_output_vertical_detector MAP_soft_output_for_6_value(data(2:end-1,ct)',hard_output(:,ct-1)',g)'];
end
%%
% output_horizontal = num2cell(zeros(size(data,1)));
% for ct1 = 1 : size(output_horizontal,1)
%     for ct2 = 1 : size(output_horizontal,2)
%         output_horizontal(ct1,ct2) = num2cell([0;1],1);
%     end
% end
% for ct = 1:size(temp_output_vertical_detector,1)
%     L = decoder_MAP( temp_output_vertical_detector(ct,:), g(2,:), snr );
%     for ct1 = 1:size(output_MAP_vertical,2) - 2
%         temp_numerator(ct1) = sum(output_MAP_vertical{ct,ct1}([2 5 3 6]));
%     end
%     numerator = temp_numerator.*L(2,:);
%     for ct2 = 1:size(output_MAP_vertical,2) - 2
%         temp_denominator(ct2) = sum(output_MAP_vertical{ct,ct2}([1 4 2 5]));
%     end
%     denominator = temp_denominator.*L(1,:);
% %     decision = log(numerator./denominator);
% %     temp_output_horizontal = (decision >= 0);
%     output_horizontal(ct+2,3:end-2) = num2cell([numerator;denominator],1);
% end
% 
% hard_output = [];
% for ct1 = 1:size(output_MAP_vertical,1)
%     for ct2 = 1:size(output_MAP_vertical,2)
%         temp_prob_vertical = output_MAP_vertical{ct1,ct2};
%         temp_prob_vertical(1) = temp_prob_vertical(1)*(output_horizontal{ct1+2,ct2+2}(2)*output_horizontal{ct1+2,ct2+1}(2)*output_horizontal{ct1+2,ct2}(2));
%         temp_prob_vertical(2) = temp_prob_vertical(2)*(output_horizontal{ct1+2,ct2+2}(2)*output_horizontal{ct1+2,ct2+1}(2)*output_horizontal{ct1+2,ct2}(1)+output_horizontal{ct1+2,ct2+2}(1)*output_horizontal{ct1+2,ct2+1}(2)*output_horizontal{ct1+2,ct2}(2));
%         temp_prob_vertical(3) = temp_prob_vertical(3)*(output_horizontal{ct1+2,ct2+2}(1)*output_horizontal{ct1+2,ct2+1}(2)*output_horizontal{ct1+2,ct2}(1));
%         temp_prob_vertical(4) = temp_prob_vertical(4)*(output_horizontal{ct1+2,ct2+2}(2)*output_horizontal{ct1+2,ct2+1}(1)*output_horizontal{ct1+2,ct2}(2));
%         temp_prob_vertical(5) = temp_prob_vertical(5)*(output_horizontal{ct1+2,ct2+2}(2)*output_horizontal{ct1+2,ct2+1}(1)*output_horizontal{ct1+2,ct2}(1)+output_horizontal{ct1+2,ct2+2}(1)*output_horizontal{ct1+2,ct2+1}(1)*output_horizontal{ct1+2,ct2}(2));
%         temp_prob_vertical(6) = temp_prob_vertical(6)*(output_horizontal{ct1+2,ct2+2}(1)*output_horizontal{ct1+2,ct2+1}(1)*output_horizontal{ct1+2,ct2}(1));
%         temp_prob_vertical = temp_prob_vertical/sum(temp_prob_vertical);
%         output_MAP_vertical_temp{ct1,ct2} = temp_prob_vertical;
%         [val_temp idx_temp] = max(output_MAP_vertical{ct1,ct2});
%         hard_output(ct1,ct2) = out_detec(idx_temp);
%     end
% end
% 
% temp_output_vertical_detector = [];
% for ct = 2:size(data,2) - 1
%     temp_output_vertical_detector = [temp_output_vertical_detector MAP_soft_output_for_6_value(data(2:end-1,ct)',hard_output(:,ct-1)',g)'];
% end
%%
% output_horizontal = num2cell(zeros(size(data,1)));
% for ct1 = 1 : size(output_horizontal,1)
%     for ct2 = 1 : size(output_horizontal,2)
%         output_horizontal(ct1,ct2) = num2cell([0;1],1);
%     end
% end
% for ct = 1:size(temp_output_vertical_detector,1)
%     L = decoder_MAP( temp_output_vertical_detector(ct,:), g(2,:), snr );
%     for ct1 = 1:size(output_MAP_vertical,2) - 2
%         temp_numerator(ct1) = sum(output_MAP_vertical{ct,ct1}([2 5 3 6]));
%     end
%     numerator = temp_numerator.*L(2,:);
%     for ct2 = 1:size(output_MAP_vertical,2) - 2
%         temp_denominator(ct2) = sum(output_MAP_vertical{ct,ct2}([1 4 2 5]));
%     end
%     denominator = temp_denominator.*L(1,:);
% %     decision = log(numerator./denominator);
% %     temp_output_horizontal = (decision >= 0);
%     output_horizontal(ct+2,3:end-2) = num2cell([numerator;denominator],1);
% end
% 
% hard_output = [];
% for ct1 = 1:size(output_MAP_vertical,1)
%     for ct2 = 1:size(output_MAP_vertical,2)
%         temp_prob_vertical = output_MAP_vertical{ct1,ct2};
%         temp_prob_vertical(1) = temp_prob_vertical(1)*(output_horizontal{ct1+1,ct2+1}(2)*output_horizontal{ct1+2,ct2+1}(2)*output_horizontal{ct1+3,ct2+1}(2));
%         temp_prob_vertical(2) = temp_prob_vertical(2)*(output_horizontal{ct1+1,ct2+1}(2)*output_horizontal{ct1+2,ct2+1}(2)*output_horizontal{ct1+3,ct2+1}(1)+output_horizontal{ct1+1,ct2+1}(1)*output_horizontal{ct1+2,ct2+1}(2)*output_horizontal{ct1+3,ct2+1}(2));
%         temp_prob_vertical(3) = temp_prob_vertical(3)*(output_horizontal{ct1+1,ct2+1}(1)*output_horizontal{ct1+2,ct2+1}(2)*output_horizontal{ct1+3,ct2+1}(1));
%         temp_prob_vertical(4) = temp_prob_vertical(4)*(output_horizontal{ct1+1,ct2+1}(2)*output_horizontal{ct1+2,ct2+1}(1)*output_horizontal{ct1+3,ct2+1}(2));
%         temp_prob_vertical(5) = temp_prob_vertical(5)*(output_horizontal{ct1+1,ct2+1}(2)*output_horizontal{ct1+2,ct2+1}(1)*output_horizontal{ct1+3,ct2+1}(1)+output_horizontal{ct1+1,ct2+1}(1)*output_horizontal{ct1+2,ct2+1}(1)*output_horizontal{ct1+3,ct2+1}(2));
%         temp_prob_vertical(6) = temp_prob_vertical(6)*(output_horizontal{ct1+1,ct2+1}(1)*output_horizontal{ct1+2,ct2+1}(1)*output_horizontal{ct1+3,ct2+1}(1));
%         temp_prob_vertical = temp_prob_vertical/sum(temp_prob_vertical);
%         output_MAP_vertical_temp{ct1,ct2} = temp_prob_vertical;
%         [val_temp idx_temp] = max(output_MAP_vertical{ct1,ct2});
%         hard_output(ct1,ct2) = out_detec(idx_temp);
%     end
% end
% 
% temp_output_vertical_detector = [];
% for ct = 2:size(data,2) - 1
%     temp_output_vertical_detector = [temp_output_vertical_detector MAP_soft_output_for_6_value(data(2:end-1,ct)',hard_output(:,ct-1)',g)'];
% end
%%
output = [];
for ct = 1:size(temp_output_vertical_detector,1)
    L = decoder_MAP( temp_output_vertical_detector(ct,:), g(2,:), snr );
    for ct1 = 1:size(output_MAP_vertical,2) - 2
        temp_numerator(ct1) = sum(output_MAP_vertical{ct,ct1}([2 5 3 6]));
    end
    numerator = temp_numerator.*L(2,:);
    for ct2 = 1:size(output_MAP_vertical,2) - 2
        temp_denominator(ct2) = sum(output_MAP_vertical{ct,ct2}([1 4 2 5]));
    end
    denominator = temp_denominator.*L(1,:);
    decision = log(numerator./denominator);
    temp_output_horizontal = (decision >= 0);
    output = [output; temp_output_horizontal];
end

end