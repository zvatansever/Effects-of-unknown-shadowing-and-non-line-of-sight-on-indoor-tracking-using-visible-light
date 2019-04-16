clc;clear all;close all;
set(0,'DefaultFigureWindowStyle','normal')

load('diffusing_lamp_decimeters_ekf_los_db.mat','dif_mean_ekf_los','dif_ci_los')
load('diffusing_lamp_decimeters_ekf_los_nlos_db.mat', 'dif_mean_ekf_los_nlos_db', 'dif_ci_los_nlos_db')
load('diffusing_lamp_decimeters_particle_filt_db_loss.mat','diff_Mean_pf_loss', 'diff_CI_pf_los_db')
load('diffusing_lamp_decimeters_particle_filt_db_loss_nlos.mat','diff_Mean_pf_loss_nlos_db', 'diff_CI_pf_los_nlos_db')
%% Diffusing lamp
%% ekf los  dif
dif_ci_ekf_los_low=dif_ci_los(:,1)';
dif_ci_ekf_los_high=dif_ci_los(:,2)';
dif_ci_ekf_los_low=dif_mean_ekf_los-dif_ci_ekf_los_low;
dif_ci_ekf_los_high=dif_ci_ekf_los_high-dif_mean_ekf_los;

%% ekf los and nlos  dif
dif_ci_ekf_los_nlos_low=dif_ci_los_nlos_db(:,1)';
dif_ci_ekf_los_nlos_high=dif_ci_los_nlos_db(:,2)';
dif_ci_ekf_los_nlos_low=dif_mean_ekf_los_nlos_db-dif_ci_ekf_los_nlos_low;
dif_ci_ekf_los_nlos_high=dif_ci_ekf_los_nlos_high-dif_mean_ekf_los_nlos_db;

%% pf los  dif
dif_ci_pf_los_low=diff_CI_pf_los_db(:,1)';
dif_ci_pf_los_high=diff_CI_pf_los_db(:,2)';
dif_ci_pf_los_low=diff_Mean_pf_loss-dif_ci_pf_los_low;
dif_ci_pf_los_high=dif_ci_pf_los_high-diff_Mean_pf_loss;

%% pf los nlos  dif
dif_ci_pf_los_nlos_low=diff_CI_pf_los_nlos_db(:,1)';
dif_ci_pf_los_nlos_high=diff_CI_pf_los_nlos_db(:,2)';
dif_ci_pf_los_nlos_low=diff_Mean_pf_loss_nlos_db-dif_ci_pf_los_nlos_low;
dif_ci_pf_los_nlos_high=dif_ci_pf_los_nlos_high-diff_Mean_pf_loss_nlos_db;

%%
SNR=[0 1 2 3 4 5];

figure
set(gca,'fontsize',18)
hold on
errorbar(SNR,dif_mean_ekf_los,dif_ci_ekf_los_low,dif_ci_ekf_los_high,'--','linewidth',3,'markersize',14)
errorbar(SNR,dif_mean_ekf_los_nlos_db,dif_ci_ekf_los_nlos_low,dif_ci_ekf_los_nlos_high,'-.','linewidth',3,'markersize',14)
errorbar(SNR,diff_Mean_pf_loss,dif_ci_pf_los_low,dif_ci_pf_los_high,'-','linewidth',3,'markersize',14)
errorbar(SNR,diff_Mean_pf_loss_nlos_db,dif_ci_pf_los_nlos_low,dif_ci_pf_los_nlos_high,':','linewidth',3,'markersize',14)
xlabel('Loss due to unknown error (dB)')
ylabel('RMSE (dm)')
legend('Diffusing, EKF, LOS','Diffusing, EKF, LOS and NLOS',...
    'Diffusing, PF, LOS','Diffusing, PF, LOS and NLOS','location','northwest')
% %%
% figure
% set(gca,'fontsize',18)
% hold on
% plot(SNR,dif_mean_ekf_los,'-+',...
%     SNR,dif_mean_ekf_los_nlos_db,'-p',...
%     SNR,diff_Mean_pf_loss,'-h',...
%     SNR,diff_Mean_pf_loss_nlos_db,'-s',...
%           'linewidth',1.5,'markersize',10)
% 
%   
% legend('Diffusing, EKF, LOS','Diffusing, EKF, LOS and NLOS',...
%     'Diffusing, PF, LOS','Diffusing, PF, LOS and NLOS')
% xlabel('Loss due to unknown error (dB)')
% ylabel('RMSE (dm)')
% title('Diffusing EKF')

%% Nondiffusing lamp
%%
load('nondiffusing_lamp_decimeters_ekf_los_db.mat','nondif_mean_ekf_los','non_dif_ci')
load('nondiffusing_lamp_decimeters_ekf_los_nlos_db.mat','nondif_mean_ekf_los_nlos','non_dif_ci_nlos')
load('nondiffusing_lamp_decimeters_particle_filt_db_loss.mat','non_diff_pf_loss_db','non_diff_CI_pf_los_db')
load('nondiffusing_lamp_decimeters_particle_filt_db_loss_nlos.mat','diff_Mean_pf_round_loss_nlos_db','diff_CI_pf_los_db')


%% ekf los non dif
non_dif_ci_ekf_los_low=non_dif_ci(:,1)';
non_dif_ci_ekf_los_high=non_dif_ci(:,2)';
ci_ekf_los_low=nondif_mean_ekf_los-non_dif_ci_ekf_los_low;
ci_ekf_los_high=non_dif_ci_ekf_los_high-nondif_mean_ekf_los;

%% ekf los and nlos non dif
non_dif_ci_ekf_los_nlos_low=non_dif_ci_nlos(:,1)';
non_dif_ci_ekf_los_nlos_high=non_dif_ci_nlos(:,2)';
ci_ekf_los_nlos_low=nondif_mean_ekf_los_nlos-non_dif_ci_ekf_los_nlos_low;
ci_ekf_los_nlos_high=non_dif_ci_ekf_los_nlos_high-nondif_mean_ekf_los_nlos;

%% pf los non dif
non_dif_ci_pf_los_low=non_diff_CI_pf_los_db(:,1)';
non_dif_ci_pf_los_high=non_diff_CI_pf_los_db(:,2)';
ci_pf_los_low=non_diff_pf_loss_db-non_dif_ci_pf_los_low;
ci_pf_los_high=non_dif_ci_pf_los_high-non_diff_pf_loss_db;

%% pf los nlos non dif
non_dif_ci_pf_los_nlos_low=diff_CI_pf_los_db(:,1)';
non_dif_ci_pf_los_nlos_high=diff_CI_pf_los_db(:,2)';
ci_pf_los_nlos_low=diff_Mean_pf_round_loss_nlos_db-non_dif_ci_pf_los_nlos_low;
% ci_pf_los_nlos_low(5)=5;
ci_pf_los_nlos_high=non_dif_ci_pf_los_nlos_high-diff_Mean_pf_round_loss_nlos_db;

% figure
% set(gca,'fontsize',18)
% hold on
% plot(SNR,nondif_mean_ekf_los,'-+',...
%     SNR,nondif_mean_ekf_los_nlos,'-p',...
%     SNR,non_diff_pf_loss_db,'-h',...
%     SNR,diff_Mean_pf_round_loss_nlos_db,'-s',...
%     'linewidth',1.5,'markersize',10)
% legend('Nondiffusing, EKF, LOS','Nondiffusing, EKF, LOS and NLOS',...
%     'Nondiffusing, PF, LOS','Nondiffusing, PF, LOS and NLOS')
% xlabel('Loss due to unknown error (dB)')
% ylabel('RMSE (dm)')
% title('Nondiffusing')

figure
set(gca,'fontsize',18)
hold on
errorbar(SNR,nondif_mean_ekf_los,ci_ekf_los_low,ci_ekf_los_high,'--','linewidth',3,'markersize',14)
errorbar(SNR,nondif_mean_ekf_los_nlos,ci_ekf_los_nlos_low,ci_ekf_los_nlos_high,'-.','linewidth',3,'markersize',14)
errorbar(SNR,non_diff_pf_loss_db,ci_pf_los_low,ci_pf_los_high,'-','linewidth',3,'markersize',14)
errorbar(SNR,diff_Mean_pf_round_loss_nlos_db,ci_pf_los_nlos_low,ci_pf_los_nlos_high,':','linewidth',3,'markersize',14)
xlabel('Loss due to unknown error (dB)')
ylabel('RMSE (dm)')
legend('Nondiffusing, EKF, LOS','Nondiffusing, EKF, LOS and NLOS',...
    'Nondiffusing, PF, LOS','Nondiffusing, PF, LOS and NLOS','location','northwest')