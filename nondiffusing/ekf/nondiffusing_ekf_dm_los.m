clc;clear all;close all;
tic
print_figures=0;
MCruns=100;


load curvy_decimeters X X1 dt
dt=0.01;
qx=0.1;
r=[2.5e-15 7.5e-16 2.5e-16 7.5e-17 2.5e-17 7.5e-18 2.5e-18 7.5e-19];

%% NO LOSS
load nondiffusing
power=cat(3,abs(P_floor1),abs(P_floor2),...
    abs(P_floor3),abs(P_floor4));
fingerprint_map=cat(3,abs(P_floor1),abs(P_floor2),...
    abs(P_floor3),abs(P_floor4));

[mean_rmse1,CI1]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(5),MCruns);


%% 1 dB LOSS
load nondiffusing
power=cat(3,0.9*abs(P_floor1),abs(P_floor2),...
    abs(P_floor3),abs(P_floor4));
fingerprint_map=cat(3,abs(P_floor1),abs(P_floor2),...
    abs(P_floor3),abs(P_floor4));

[mean_rmse2,CI2]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(5),MCruns);

%% 2 db LOSS
load nondiffusing
power=cat(3,0.8*abs(P_floor1),abs(P_floor2),...
    abs(P_floor3),abs(P_floor4));
fingerprint_map=cat(3,abs(P_floor1),abs(P_floor2),...
    abs(P_floor3),abs(P_floor4));

[mean_rmse3,CI3]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(5),MCruns);

%% 3 db LOSS
load nondiffusing
power=cat(3,0.7*abs(P_floor1),abs(P_floor2),...
    abs(P_floor3),abs(P_floor4));
fingerprint_map=cat(3,abs(P_floor1),abs(P_floor2),...
    abs(P_floor3),abs(P_floor4));

[mean_rmse4,CI4]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(5),MCruns);

%% 4 db LOSS
load nondiffusing
power=cat(3,0.6*abs(P_floor1),abs(P_floor2),...
    abs(P_floor3),abs(P_floor4));
fingerprint_map=cat(3,abs(P_floor1),abs(P_floor2),...
    abs(P_floor3),abs(P_floor4));

[mean_rmse5,CI5]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(5),MCruns);

%% 5 db LOSS
load nondiffusing
power=cat(3,0.5*abs(P_floor1),abs(P_floor2),...
    abs(P_floor3),abs(P_floor4));
fingerprint_map=cat(3,abs(P_floor1),abs(P_floor2),...
    abs(P_floor3),abs(P_floor4));

[mean_rmse6,CI6]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(5),MCruns);

%%
nondif_mean_ekf_los=[mean_rmse1 mean_rmse2 mean_rmse3 mean_rmse4...
                     mean_rmse5 mean_rmse6];
non_dif_ci=[CI1; CI2; CI3; CI4; CI5; CI6];
%%

    figure
    SNR=[0 1 2 3 4 5];
    
    set(gca,'fontsize',14)
    hold on

    
    plot(SNR,nondif_mean_ekf_los,'-*',...
    'linewidth',2,'Markersize',10)
    %title('Nondiffusing, 1db loss, EKF, LOS')
    xlabel('dB loss (dB)')
    ylabel('RMSE (dm)')
    legend('Nondiffusing, LOS , EKF SNR= 45 dB')
    
   save nondiffusing_lamp_decimeters_ekf_los_db nondif_mean_ekf_los non_dif_ci

    
    
    toc