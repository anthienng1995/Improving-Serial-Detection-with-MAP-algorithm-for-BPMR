clear all
clc
% load('ber_concate_asymmetric_GPR_TMR_10.mat')

N = 2000;
Pages = 1;
snr = [10:16];
TMR = [10:5:30];
% ht = create_h_BPMR(3,0)
nErr = zeros(1,length(TMR));

for ct = 1:length(TMR)
    ht = create_h_BPMR(3,TMR(ct))
    for ii = 1:Pages
        ip = round(rand(N));
        mod = -1*ones(N+4);
        mod(3:end-2,3:end-2) = ip*2-1;

        chanOut = conv2(mod,flipud(fliplr(ht)),'same');
        n = randn(size(chanOut,1),size(chanOut,2));
        y = chanOut + 10^(-15/20)*n;
        
        if ii == 1
            [G,F] = MMSE_GPR(ht,15,5)
        end
        y_mmse = conv2(y,fliplr(flipud(F)),'same');
        y_reff = conv2(mod,fliplr(flipud(G(:,:))),'same');
        Error_mmse = sum(sum((y_mmse - y_reff).^2))/(N*N)

        ip_Hat = serial_detection_with_MAP_algorithm( y_mmse, G, snr(ct) );

        nErr(1,ct) = nErr(1,ct) + sum(sum(abs(ip_Hat - ip)))
    end
end

simBer = nErr/(N*N*Pages);
figure
semilogy(TMR,simBer(1,:),'rd-','Linewidth',1);
hold on
% semilogy(ber_concate_asymmetric_GPR_TMR_10(2,:),ber_concate_asymmetric_GPR_TMR_10(1,:),'gd-','Linewidth',1);
axis([10 30 2*10^-7 10^-1]);
grid on
legend('Our Proposed');
xlabel('TMR');
ylabel('Bit Error Rate');