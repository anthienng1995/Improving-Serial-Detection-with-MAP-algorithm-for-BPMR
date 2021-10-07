function [outCH] = create_h_BPMR_with_media_noise(SELL, data, fluc, TMRz)
size_x = size(data,1);
size_z = size(data,2);

temp_data = zeros(size_x + floor(SELL/2)*2,size_z + floor(SELL/2)*2);
temp_data((floor(SELL/2) + 1):(end - floor(SELL/2)),(floor(SELL/2) + 1):(end - floor(SELL/2))) = data;

Tx = 14.5; 
Tz = 14.5;

c = 1/ 2.3548;
Wx = 19.4;
Wz = 24.8;

Delta_z_off = (TMRz*Tz) / 100;

x = (fluc/100) * randn(size_x,size_z);
% for ct_x = 1:size_x
%     for ct_z = 1:size_z
%         x(ct_x,ct_z) = x(ct_x,ct_z) + ct_x;
%     end
% end
temp_x = zeros(size_x + floor(SELL/2)*2,size_z + floor(SELL/2)*2);
temp_x((floor(SELL/2) + 1):(end - floor(SELL/2)),(floor(SELL/2) + 1):(end - floor(SELL/2))) = x;
z = (fluc/100) * randn(size_x,size_z);
% for ct_x = 1:size_x
%     for ct_z = 1:size_z
%         z(ct_x,ct_z) = z(ct_x,ct_z) + ct_z;
%     end
% end
temp_z = zeros(size_x + floor(SELL/2)*2,size_z + floor(SELL/2)*2);
temp_z((floor(SELL/2) + 1):(end - floor(SELL/2)),(floor(SELL/2) + 1):(end - floor(SELL/2))) = z;

for ct1 = floor(SELL/2)+1:floor(SELL/2)+size_x
    for ct2 = floor(SELL/2)+1:floor(SELL/2)+size_z
        outCH(ct1 - floor(SELL/2),ct2 - floor(SELL/2)) = 0;
        for ct3 = -floor(SELL/2):floor(SELL/2)
            for ct4 = -floor(SELL/2):floor(SELL/2)
                %outCH(ct1 - floor(SELL/2),ct2 - floor(SELL/2)) = outCH(ct1 - floor(SELL/2),ct2 - floor(SELL/2)) + temp_data(ct1+ct3,ct2+ct4)*double(exp((-1/2)*((((temp_z(ct1,ct2) - temp_z(ct1+ct3,ct2+ct4))*Tx)/(c*Wx))^2+(((temp_x(ct1,ct2)-temp_x(ct1+ct3,ct2+ct4))*Tz-Delta_z_off)/(c*Wz))^2)));
                outCH(ct1 - floor(SELL/2),ct2 - floor(SELL/2)) = outCH(ct1 - floor(SELL/2),ct2 - floor(SELL/2)) + temp_data(ct1+ct3,ct2+ct4)*double(exp((-1/2)*((((ct4 + temp_z(ct1+ct3,ct2+ct4))*Tx)/(c*Wx))^2+(((ct3 + temp_x(ct1+ct3,ct2+ct4))*Tz-Delta_z_off)/(c*Wz))^2)));
            end
        end
    end
end