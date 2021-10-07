function [G_out,F_out] = MMSE_GPR(h,snr,way)
A = eye(9);
T = create_T_2D(h);
R = create_R_2D(h,snr);
%% Interference 2 directions horizontal
if way == 1
    E = [1 0 0 0 0 0 0 0 0;
         0 1 0 0 0 0 0 0 0;
         0 0 1 0 0 0 0 0 0;
         0 0 0 0 1 0 0 0 0;
         0 0 0 0 0 0 1 0 0;
         0 0 0 0 0 0 0 1 0;
         0 0 0 0 0 0 0 0 1]';
    c = [0 0 0 1 0 0 0]';
end
% 
% lamda = inv(E'*inv(A - T'*inv(R)*T)*E)*c;
% G = inv(A - T'*inv(R)*T)*E*lamda;

%% Interference 2 directions vertical
if way == 2
    E = [1 0 0 0 0 0 0 0 0;
         0 0 0 1 0 0 0 0 0;
         0 0 1 0 0 0 0 0 0;
         0 0 0 0 1 0 0 0 0;
         0 0 0 0 0 0 1 0 0;
         0 0 0 0 0 1 0 0 0;
         0 0 0 0 0 0 0 0 1]';
    c = [0 0 0 1 0 0 0]';
end

%% Inteference 4 directions
if way == 3 || way == 5
    E = [1 0 0 0 0 0 0 0 0;
         0 0 1 0 0 0 0 0 0;
         0 0 0 0 1 0 0 0 0;
         0 0 0 0 0 0 1 0 0;
         0 0 0 0 0 0 0 0 1]';
    c = [0 0 1 0 0]';
end

%% Inteference 8 directions
if way == 4
    E = [0 0 0 0 1 0 0 0 0]';
    c=1;
end

lamda = inv(E'*inv(A - T'*inv(R)*T)*E)*c;
G = inv(A - T'*inv(R)*T)*E*lamda;
if way == 5
    G(1,1) = G(2,1)*G(4,1);
    G(3,1) = G(1,1);
    G(7,1) = G(4,1)*G(8,1);
    G(9,1) = G(7,1);
end
F = inv(R)*T*G;
G_out = reshape(G,[3 3])';
F_out = reshape(F,[5 5])';
end


