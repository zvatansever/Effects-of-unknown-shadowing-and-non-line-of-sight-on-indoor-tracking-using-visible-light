clc;clear all;close all;
set(0,'DefaultFigureWindowStyle','normal')

load('diffusing_lamp_decimeters_ekf_los_db.mat','dif_mean_ekf_los','dif_ci_los')
load('diffusing_lamp_decimeters_ekf_los_nlos_db.mat', 'dif_mean_ekf_los_nlos_db', 'dif_ci_los_nlos_db')
load('diffusing_lamp_decimeters_particle_filt_db_loss.mat','diff_Mean_pf_loss', 'diff_CI_pf_los_db')
load('diffusing_lamp_decimeters_particle_filt_db_loss_nlos.mat','diff_Mean_pf_loss_nlos_db', 'diff_CI_pf_los_nlos_db')


%%
SNR=[0 1 2 3 4 5];

figure
% hold on
semilogy(SNR,dif_mean_ekf_los,'-x',SNR,dif_mean_ekf_los_nlos_db,'-s',...
        SNR,diff_Mean_pf_loss,'-*',SNR,diff_Mean_pf_loss_nlos_db,'-+',...
         'linewidth',3,'markersize',14)
% semilogy(SNR,dif_mean_ekf_los_nlos_db,'-s','linewidth',3,'markersize',14)
% semilogy(SNR,diff_Mean_pf_loss,'-*','linewidth',3,'markersize',14)
% semilogy(SNR,diff_Mean_pf_loss_nlos_db,'-+','linewidth',3,'markersize',14)
xlabel('Loss due to unknown error (dB)')
ylabel('RMSE (dm)')
legend('Diffusing, EKF, LOS','Diffusing, EKF, LOS and NLOS',...
    'Diffusing, PF, LOS','Diffusing, PF, LOS and NLOS','location','best')
grid on
 set(gca,'fontsize',20)

 %% Nondiffusing lamp
%%
load('nondiffusing_lamp_decimeters_ekf_los_db.mat','nondif_mean_ekf_los','non_dif_ci')
load('nondiffusing_lamp_decimeters_ekf_los_nlos_db.mat','nondif_mean_ekf_los_nlos','non_dif_ci_nlos')
load('nondiffusing_lamp_decimeters_particle_filt_db_loss.mat','non_diff_pf_loss_db','non_diff_CI_pf_los_db')
load('nondiffusing_lamp_decimeters_particle_filt_db_loss_nlos.mat','diff_Mean_pf_round_loss_nlos_db','diff_CI_pf_los_db')

%%
SNR=[0 1 2 3 4 5];

figure
% hold on
semilogy(SNR,nondif_mean_ekf_los,'-x',SNR,nondif_mean_ekf_los_nlos,'-s',...
        SNR,non_diff_pf_loss_db,'-*',SNR,diff_Mean_pf_round_loss_nlos_db,'-+',...
         'linewidth',3,'markersize',14)
% semilogy(SNR,dif_mean_ekf_los_nlos_db,'-s','linewidth',3,'markersize',14)
% semilogy(SNR,diff_Mean_pf_loss,'-*','linewidth',3,'markersize',14)
% semilogy(SNR,diff_Mean_pf_loss_nlos_db,'-+','linewidth',3,'markersize',14)
xlabel('Loss due to unknown error (dB)')
ylabel('RMSE (dm)')
legend('Nondiffusing, EKF, LOS','Nondiffusing, EKF, LOS and NLOS',...
    'Nondiffusing, PF, LOS','Nondiffusing, PF, LOS and NLOS','location','best')
grid on
 set(gca,'fontsize',20)