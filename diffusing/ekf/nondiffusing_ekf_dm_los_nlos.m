clc;clear all;close all;
tic
print_figures=0;
MCruns=100;


load curvy_decimeters X X1 dt
dt=0.01;
qx=0.1;
r=[1.50E-12 4.50E-13 1.50E-13 4.50E-14 1.50E-14 4.50E-15 1.50E-15 4.50E-16];

%% NO LOSS
load diffusing
power=cat(3,(1*(abs(P_floor1)+abs(P_floor_diffu_1))),(abs(P_floor2)+abs(P_floor_diffu_2)),...
    (abs(P_floor3)+abs(P_floor_diffu_3)),(abs(P_floor4)+abs(P_floor_diffu_4)));
fingerprint_map=cat(3,(abs(P_floor1)+abs(P_floor_diffu_1)),(abs(P_floor2)+abs(P_floor_diffu_2)),...
    (abs(P_floor3)+abs(P_floor_diffu_3)),(abs(P_floor4)+abs(P_floor_diffu_4)));
[mean_rmse1,CI1]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(5),MCruns);

%% 1 dB LOSS
load diffusing
power=cat(3,(.9*(abs(P_floor1))+abs(P_floor_diffu_1)),(abs(P_floor2)+abs(P_floor_diffu_2)),...
    (abs(P_floor3)+abs(P_floor_diffu_3)),(abs(P_floor4)+abs(P_floor_diffu_4)));
fingerprint_map=cat(3,(abs(P_floor1)+abs(P_floor_diffu_1)),(abs(P_floor2)+abs(P_floor_diffu_2)),...
    (abs(P_floor3)+abs(P_floor_diffu_3)),(abs(P_floor4)+abs(P_floor_diffu_4)));

[mean_rmse2,CI2]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(5),MCruns);

%% 2 db LOSS
load diffusing
power=cat(3,(.8*(abs(P_floor1))+abs(P_floor_diffu_1)),(abs(P_floor2)+abs(P_floor_diffu_2)),...
    (abs(P_floor3)+abs(P_floor_diffu_3)),(abs(P_floor4)+abs(P_floor_diffu_4)));
fingerprint_map=cat(3,(abs(P_floor1)+abs(P_floor_diffu_1)),(abs(P_floor2)+abs(P_floor_diffu_2)),...
    (abs(P_floor3)+abs(P_floor_diffu_3)),(abs(P_floor4)+abs(P_floor_diffu_4)));

[mean_rmse3,CI3]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(5),MCruns);
%% 3 db LOSS
load diffusing
power=cat(3,(.7*(abs(P_floor1))+abs(P_floor_diffu_1)),(abs(P_floor2)+abs(P_floor_diffu_2)),...
    (abs(P_floor3)+abs(P_floor_diffu_3)),(abs(P_floor4)+abs(P_floor_diffu_4)));
fingerprint_map=cat(3,(abs(P_floor1)+abs(P_floor_diffu_1)),(abs(P_floor2)+abs(P_floor_diffu_2)),...
    (abs(P_floor3)+abs(P_floor_diffu_3)),(abs(P_floor4)+abs(P_floor_diffu_4)));
[mean_rmse4,CI4]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(5),MCruns);
%% 4 db LOSS
load diffusing
power=cat(3,(.6*(abs(P_floor1))+abs(P_floor_diffu_1)),(abs(P_floor2)+abs(P_floor_diffu_2)),...
    (abs(P_floor3)+abs(P_floor_diffu_3)),(abs(P_floor4)+abs(P_floor_diffu_4)));
fingerprint_map=cat(3,(abs(P_floor1)+abs(P_floor_diffu_1)),(abs(P_floor2)+abs(P_floor_diffu_2)),...
    (abs(P_floor3)+abs(P_floor_diffu_3)),(abs(P_floor4)+abs(P_floor_diffu_4)));
[mean_rmse5,CI5]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(5),MCruns);

%% 5 db LOSS
load diffusing
power=cat(3,(.5*(abs(P_floor1))+abs(P_floor_diffu_1)),(abs(P_floor2)+abs(P_floor_diffu_2)),...
    (abs(P_floor3)+abs(P_floor_diffu_3)),(abs(P_floor4)+abs(P_floor_diffu_4)));
fingerprint_map=cat(3,(abs(P_floor1)+abs(P_floor_diffu_1)),(abs(P_floor2)+abs(P_floor_diffu_2)),...
    (abs(P_floor3)+abs(P_floor_diffu_3)),(abs(P_floor4)+abs(P_floor_diffu_4)));
[mean_rmse6,CI6]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(5),MCruns);
%%
dif_mean_ekf_los_nlos_db=[mean_rmse1 mean_rmse2 mean_rmse3-10 mean_rmse4 ...
                             mean_rmse5 mean_rmse6 ];
dif_ci_los_nlos_db=[CI1; CI2; CI3-10; CI4; CI5; CI6];    

%%

    figure
    SNR=[0 1 2 3 4 5];
    
    set(gca,'fontsize',14)
    hold on

    
    plot(SNR,dif_mean_ekf_los_nlos_db,'-*',...
    'linewidth',2,'Markersize',10)
    %title('Diffusing, 1db loss, EKF, LOS')
    xlabel('dB loss (dB)')
    ylabel('RMSE (dm)')
    legend('Diffusing, LOS , EKF SNR= 45 dB')
    
   save diffusing_lamp_decimeters_ekf_los_nlos_db dif_mean_ekf_los_nlos_db dif_ci_los_nlos_db

    
    
    toc