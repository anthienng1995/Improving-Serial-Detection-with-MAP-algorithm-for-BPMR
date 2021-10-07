function [output] = MAP_soft_output_for_6_value(received,data,h)
    p = h(2,3);%h(2,3)
    hard_output = data;
    mod = (-1-2*p)*ones(1,length(hard_output)+4);
    mod(1,3:end-2) = hard_output;
    temp_data = conv(mod,h(:,2)','same');
    noise = received - temp_data(2:end-1);
    output = hard_output + noise(2:end-1);
end
