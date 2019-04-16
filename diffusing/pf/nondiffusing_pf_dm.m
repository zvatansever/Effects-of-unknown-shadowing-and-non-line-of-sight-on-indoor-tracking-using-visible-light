clc;clear all;close all;
tic
print_figures=0;
MCruns=10;

%%
N_PART=500;
load curvy_decimeters X X1
dt=0.01;

SIGMA_W=.5;
r=[1.50E-12 4.50E-13 1.50E-13 4.50E-14 1.50E-14 4.50E-15 1.50E-15 4.50E-16];

%%
load diffusing
power=cat(3,abs(P_floor1),abs(P_floor2),abs(P_floor3),abs(P_floor4));
fingerprint_map=cat(3,abs(P_floor1),real(P_floor2),abs(P_floor3),abs(P_floor4));
[mean_rmse_pf1,rmse_pf1,CI1]=...
particle_filt_v2(fingerprint_map, power, X, X1, r(5), N_PART, SIGMA_W, dt, print_figures,MCruns);
%%
load diffusing
power=cat(3,0.9*abs(P_floor1),abs(P_floor2),abs(P_floor3),abs(P_floor4));
fingerprint_map=cat(3,abs(P_floor1),real(P_floor2),abs(P_floor3),abs(P_floor4));
[mean_rmse_pf2,rmse_pf2,CI2]=...
particle_filt_v2(fingerprint_map, power, X, X1, r(5), N_PART, SIGMA_W, dt, print_figures,MCruns);
%%
load diffusing
power=cat(3,0.8*abs(P_floor1),abs(P_floor2),abs(P_floor3),abs(P_floor4));
fingerprint_map=cat(3,abs(P_floor1),real(P_floor2),abs(P_floor3),abs(P_floor4));
[mean_rmse_pf3,rmse_pf3,CI3]=...
particle_filt_v2(fingerprint_map, power, X, X1, r(5), N_PART, SIGMA_W, dt, print_figures,MCruns);
%%
load diffusing
power=cat(3,0.7*abs(P_floor1),abs(P_floor2),abs(P_floor3),abs(P_floor4));
fingerprint_map=cat(3,abs(P_floor1),real(P_floor2),abs(P_floor3),abs(P_floor4));
[mean_rmse_pf4,rmse_pf4,CI4]=...
particle_filt_v2(fingerprint_map, power, X, X1, r(5), N_PART, SIGMA_W, dt, print_figures,MCruns);
%%
load diffusing
power=cat(3,0.6*abs(P_floor1),abs(P_floor2),abs(P_floor3),abs(P_floor4));
fingerprint_map=cat(3,abs(P_floor1),real(P_floor2),abs(P_floor3),abs(P_floor4));
[mean_rmse_pf5,rmse_pf5,CI5]=...
particle_filt_v2(fingerprint_map, power, X, X1, r(5), N_PART, SIGMA_W, dt, print_figures,MCruns);
%%
load diffusing
power=cat(3,0.55*abs(P_floor1),abs(P_floor2),abs(P_floor3),abs(P_floor4));
fingerprint_map=cat(3,abs(P_floor1),real(P_floor2),abs(P_floor3),abs(P_floor4));
[mean_rmse_pf6,rmse_pf6,CI6]=...
particle_filt_v2(fingerprint_map, power, X, X1, r(5), N_PART, SIGMA_W, dt, print_figures,MCruns);

%non_diff_Mean_pf=[non_dif_X_mean1_dm_part non_dif_X_mean2_dm_part non_dif_X_mean3_dm_part non_dif_X_mean4_dm_part...
 %   non_dif_X_mean5_dm_part non_dif_X_mean6_dm_part non_dif_X_mean7_dm_part non_dif_X_mean8_dm_part];
diff_Mean_pf_loss=[mean_rmse_pf1 mean_rmse_pf2 mean_rmse_pf3 mean_rmse_pf4...
    mean_rmse_pf5 mean_rmse_pf6];
diff_CI_pf_los_db=[CI1; CI2; CI3; CI4; CI5; CI6];

figure
set(gca,'fontsize',14)
hold on
SNR=[0 1 2 3 4 5];

plot(SNR,diff_Mean_pf_loss,'-+',...
    'linewidth',2,'Markersize',10)
title('Nondiffusing,PF, LOS')
xlabel('dB loss')
ylabel('RMSE (dm)')
legend(' RMSE')

save diffusing_lamp_decimeters_particle_filt_db_loss ...
     diff_Mean_pf_loss diff_CI_pf_los_db
toc