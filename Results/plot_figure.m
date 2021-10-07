figure
semilogy(results_serial_detection_with_MAP_10_TMR(2,:),results_serial_detection_with_MAP_10_TMR(1,:),'rd-','Linewidth',1);
hold on
semilogy(ber_concate_asymmetric_GPR_TMR_10(2,:),ber_concate_asymmetric_GPR_TMR_10(1,:),'gd-','Linewidth',1);
semilogy(simBer_serial_soft_output(2,:),simBer_serial_soft_output(1,:),'bd-','Linewidth',1);
% semilogy(Parallel_ISI_estimator_with_average_output(2,:),Parallel_ISI_estimator_with_average_output(1,:),'kd-','Linewidth',1);
% semilogy(resutls_parallel_detection_mis_0(2,:),resutls_parallel_detection_mis_0(1,:),'md-','Linewidth',1);
% semilogy(results_serial_detection_mis_0(2,:),results_serial_detection_mis_0(1,:),'cd-','Linewidth',1);
%semilogy(xdata{1,1},ydata{3,1},'rd-','Linewidth',1);
%semilogy(xdata{1,1},ydata{1,1},'gd-','Linewidth',1);
%semilogy(xdata{1,1},ydata{2,1},'rd-','Linewidth',1);   

axis([10 18 2*10^-7 10^0]);
grid on
legend('8-way GPR target','Serial target')
ylabel('BER');
xlabel('SNR');