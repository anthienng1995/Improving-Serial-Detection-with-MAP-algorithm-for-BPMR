function [h] = create_h_BPMR(SELL,TMRz)
Tx = 14.5; 
Tz = 14.5;

c = 1/ 2.3548;
Wx = 19.4;
Wz = 24.8;

%TMRz = 0;
Delta_z_off = (TMRz*Tz) / 100;
fluctuation = 0;
fluc_x = (fluctuation / 100)*Tx;
fluc_x = fluc_x*randn;
fluc_z = (fluctuation / 100)*Tz;
fluc_z = fluc_z*randn;

h = zeros(3);
for i = -floor(SELL/2) : floor(SELL/2)
    for j = -floor(SELL/2) : floor(SELL/2)
        h(floor(j + SELL / 2) + 1, floor(i + SELL / 2) + 1) = exp((-1/2)*(((j*Tx+fluc_x)/(c*Wx))^2+((i*Tz+fluc_z-Delta_z_off)/(c*Wz))^2));
    end
end
end

