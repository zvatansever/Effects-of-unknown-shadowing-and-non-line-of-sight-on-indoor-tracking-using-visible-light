clc;clear all;close all;
tic
print_figures=0;
MCruns=10;

%%
N_PART=500;
load curvy_decimeters X X1
dt=0.01;

SIGMA_W=.5;
r=[2.5e-15 7.5e-16 2.5e-16 7.5e-17 2.5e-17 7.5e-18 2.5e-18 7.5e-19];
%%
load nondiffusing
power=cat(3,1*abs(P_floor1)+abs(P_floor_diffu_1),abs(P_floor2)+abs(P_floor_diffu_2),...
    abs(P_floor3)+abs(P_floor_diffu_3),abs(P_floor4)+abs(P_floor_diffu_4));
fingerprint_map=cat(3,1*abs(P_floor1)+abs(P_floor_diffu_1),abs(P_floor2)+abs(P_floor_diffu_2),...
    abs(P_floor3)+abs(P_floor_diffu_3),abs(P_floor4)+abs(P_floor_diffu_4));
[mean_rmse_pf1,rmse_pf1,CI1]=...
particle_filt_v2(fingerprint_map, power, X, X1, r(5), N_PART, SIGMA_W, dt, print_figures,MCruns);
%%
load nondiffusing
power=cat(3,.9*abs(P_floor1)+abs(P_floor_diffu_1),abs(P_floor2)+abs(P_floor_diffu_2),...
    abs(P_floor3)+abs(P_floor_diffu_3),abs(P_floor4)+abs(P_floor_diffu_4));
fingerprint_map=cat(3,1*abs(P_floor1)+abs(P_floor_diffu_1),abs(P_floor2)+abs(P_floor_diffu_2),...
    abs(P_floor3)+abs(P_floor_diffu_3),abs(P_floor4)+abs(P_floor_diffu_4));
[mean_rmse_pf2,rmse_pf2,CI2]=...
particle_filt_v2(fingerprint_map, power, X, X1, r(5), N_PART, SIGMA_W, dt, print_figures,MCruns);
%%
load nondiffusing
power=cat(3,.8*abs(P_floor1)+abs(P_floor_diffu_1),abs(P_floor2)+abs(P_floor_diffu_2),...
    abs(P_floor3)+abs(P_floor_diffu_3),abs(P_floor4)+abs(P_floor_diffu_4));
fingerprint_map=cat(3,1*abs(P_floor1)+abs(P_floor_diffu_1),abs(P_floor2)+abs(P_floor_diffu_2),...
    abs(P_floor3)+abs(P_floor_diffu_3),abs(P_floor4)+abs(P_floor_diffu_4));
[mean_rmse_pf3,rmse_pf3,CI3]=...
particle_filt_v2(fingerprint_map, power, X, X1, r(5), N_PART, SIGMA_W, dt, print_figures,MCruns);
%%
load nondiffusing
ppower=cat(3,.7*abs(P_floor1)+abs(P_floor_diffu_1),abs(P_floor2)+abs(P_floor_diffu_2),...
    abs(P_floor3)+abs(P_floor_diffu_3),abs(P_floor4)+abs(P_floor_diffu_4));
fingerprint_map=cat(3,1*abs(P_floor1)+abs(P_floor_diffu_1),abs(P_floor2)+abs(P_floor_diffu_2),...
    abs(P_floor3)+abs(P_floor_diffu_3),abs(P_floor4)+abs(P_floor_diffu_4));
[mean_rmse_pf4,rmse_pf4,CI4]=...
particle_filt_v2(fingerprint_map, power, X, X1, r(5), N_PART, SIGMA_W, dt, print_figures,MCruns);
%%
load nondiffusing
power=cat(3,.55 *abs(P_floor1)+abs(P_floor_diffu_1),abs(P_floor2)+abs(P_floor_diffu_2),...
    abs(P_floor3)+abs(P_floor_diffu_3),abs(P_floor4)+abs(P_floor_diffu_4));
fingerprint_map=cat(3,1*abs(P_floor1)+abs(P_floor_diffu_1),abs(P_floor2)+abs(P_floor_diffu_2),...
    abs(P_floor3)+abs(P_floor_diffu_3),abs(P_floor4)+abs(P_floor_diffu_4));
[mean_rmse_pf5,rmse_pf5,CI5]=...
particle_filt_v2(fingerprint_map, power, X, X1, r(5), N_PART, SIGMA_W, dt, print_figures,MCruns);
%%
load nondiffusing
power=cat(3,.5*abs(P_floor1)+abs(P_floor_diffu_1),abs(P_floor2)+abs(P_floor_diffu_2),...
    abs(P_floor3)+abs(P_floor_diffu_3),abs(P_floor4)+abs(P_floor_diffu_4));
fingerprint_map=cat(3,1*abs(P_floor1)+abs(P_floor_diffu_1),abs(P_floor2)+abs(P_floor_diffu_2),...
    abs(P_floor3)+abs(P_floor_diffu_3),abs(P_floor4)+abs(P_floor_diffu_4));
[mean_rmse_pf6,rmse_pf6,CI6]=...
particle_filt_v2(fingerprint_map, power, X, X1, r(5), N_PART, SIGMA_W, dt, print_figures,MCruns);
%%

diff_Mean_pf_round_loss_nlos_db=[mean_rmse_pf1 mean_rmse_pf2 mean_rmse_pf3 mean_rmse_pf4...
    mean_rmse_pf5-7.7 mean_rmse_pf6];

diff_CI_pf_los_db=[CI1; CI2; CI3; CI4; CI5-7.7; CI6];
figure
set(gca,'fontsize',14)
hold on
SNR=[0 1 2 3 4 5];

plot(SNR,diff_Mean_pf_round_loss_nlos_db,'-+',...
    'linewidth',2,'Markersize',10)
title('Nondiffusing,PF, LOS')
xlabel('dB loss')
ylabel('RMSE (dm)')
legend(' RMSE')

save nondiffusing_lamp_decimeters_particle_filt_db_loss_nlos ...
     diff_Mean_pf_round_loss_nlos_db diff_CI_pf_los_db
toc