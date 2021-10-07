function [T2D_output] = create_T_2D(h)
%Create equalizer size of 5x5
A = create_T_1D(h(1,:));
B = create_T_1D(h(2,:));
C = create_T_1D(h(3,:));
temp = [zeros(5,6) A B C zeros(5,6)];
T = [];
for ct = 1:5
    T = [T; temp(:,13-3*(ct-1):end-3*(ct-1))];
end
T2D_output = T;
end