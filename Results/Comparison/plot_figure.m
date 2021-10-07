figure
semilogy(results_serial_detection_with_MAP_TMR_15_dB(2,:),results_serial_detection_with_MAP_TMR_15_dB(1,:),'rd-','Linewidth',1);
hold on
semilogy(ber_concate_detect_soft_h_v_TMR_15(2,:),ber_concate_detect_soft_h_v_TMR_15(1,:),'gd-','Linewidth',1);
semilogy(ber_concate_asymmetric_detect_hard_h_v_TMR_15dB(2,:),ber_concate_asymmetric_detect_hard_h_v_TMR_15dB(1,:),'bd-','Linewidth',1);
% semilogy(Parallel_ISI_estimator_with_average_output(2,:),Parallel_ISI_estimator_with_average_output(1,:),'kd-','Linewidth',1);
% semilogy(resutls_parallel_detection_mis_0(2,:),resutls_parallel_detection_mis_0(1,:),'md-','Linewidth',1);
% semilogy(results_serial_detection_mis_0(2,:),results_serial_detection_mis_0(1,:),'cd-','Linewidth',1);
%semilogy(xdata{1,1},ydata{3,1},'rd-','Linewidth',1);
%semilogy(xdata{1,1},ydata{1,1},'gd-','Linewidth',1);
%semilogy(xdata{1,1},ydata{2,1},'rd-','Linewidth',1);   

axis([10 30 2*10^-7 10^0]);
grid on
legend('Proposed model','Serial detection with soft output [6]','Serial detection with hard output [5]')
ylabel('BER');
xlabel('SNR');