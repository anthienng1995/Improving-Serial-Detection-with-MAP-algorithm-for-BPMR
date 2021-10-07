function [T1D_output] = create_T_1D(h)
T1D_output = [h(3) 0    0;
              h(2) h(3) 0; 
              h(1) h(2) h(3);
              0    h(1) h(2);
              0    0    h(1)];
end

