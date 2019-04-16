function [mean_rmse,CI]= ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r1,MCruns)
randn('seed',9999); % seed for noise

% UE trajectory
x_dir=X1(1,:);
y_dir=X1(2,:);


%% Offline Measurements map
finger1=fingerprint_map(:,:,1);
finger2=fingerprint_map(:,:,2);
finger3=fingerprint_map(:,:,3);
finger4=fingerprint_map(:,:,4);

%% Online measurement map
New1=power(:,:,1);
New2=power(:,:,2);
New3=power(:,:,3);
New4=power(:,:,4);

%% Online measurements
%Measurement 1
for j=1:length(y_dir)
    Newer1(1,j)=abs(New1(x_dir(j),y_dir(j)));
end

%Measurement 2
for j=1:length(y_dir)
    Newer2(1,j)=abs(New2(x_dir(j),y_dir(j)));
end

%Measurement 3
for j=1:length(y_dir)
    Newer3(1,j)=abs(New3(x_dir(j),y_dir(j)));
end
%Measurement 4
for j=1:length(y_dir)
    Newer4(1,j)=abs(New4(x_dir(j),y_dir(j)));
end

%% Step 1
for MC=1:MCruns
    N = length(Newer1);%no. of samples in simulation
    %state transition matrix [4x4]
    F = [0 0 1 0;
        0 0 0 1;
        0 0 0 0;
        0 0 0 0];
    [A,Q] = lti_disc(F,[],diag([qx qx 0 0]),dt); % Discretization for state transition matrix A and noise matrix Q
    %% Step 2: Initialize state and covariance
    P=[ x_dir(1) 0 0 0; %Initial covariance [4x4]
        0 y_dir(1) 0 0;
        0 0 X1(3,1) 0;
        0 0 0 X1(4,1)];
    
    R=[r1 0 0 0; 0 r1 0 0; 0 0 r1 0; 0 0 0 r1]; %feed VAR to kalman filter
    w=chol(R)*randn(4,length(Newer1));% measurement noise [4x50]
    yt=[Newer1; Newer2; Newer3; Newer4]+w; % measurements from 4 Leds [4x50]
    yt(yt<0)=0;
    %% Initialize and run EKF for comparison
    xe = zeros(4,N); % allocate memory
    xe(:,1) = X1(:,1); % initial state for ekf
    
    for k=2:N
        % Prediction Step
        x_m =A*xe(:,k-1); %  Predicted state (state transition matrix times posterior state) [4x1]
        F= A*P*A';
        P_m =F + Q; % predicted covariance update part [4x4]
        if x_m(1)<1.5
            x_m(1)=2;
        end
        
        if x_m(2)<1.5
            x_m(2)=2;
        end
        if x_m(1)>=length(power)-.5
            x_m(1)=length(power)-1;
        end
        
        if x_m(2)>=length(power)-.5
            x_m(2)=length(power)-1;
        end
        
        x_m1=round(x_m); % We are looking a discrete floor so need to find the discrete index [4x1]
        %% Numerical Jacobian Part
        % y_m is the observations obtained using the predicted positions [4x1]
        y_m = [abs(finger1(x_m1(1),x_m1(2)));
            abs(finger2(x_m1(1),x_m1(2)));
            abs(finger3(x_m1(1),x_m1(2)));
            abs(finger4(x_m1(1),x_m1(2)))];
        %               YY_m=[YY_m y_m];
        
        %%x-1
        yxplus1 = [abs(finger1(x_m1(1)+1,x_m1(2)));
            abs(finger2(x_m1(1)+1,x_m1(2)));
            abs(finger3(x_m1(1)+1,x_m1(2)));
            abs(finger4(x_m1(1)+1,x_m1(2)))];
        
        yyplus1 = [abs(finger1(x_m1(1),x_m1(2)+1));
            abs(finger2(x_m1(1),x_m1(2)+1));
            abs(finger3(x_m1(1),x_m1(2)+1));
            abs(finger4(x_m1(1),x_m1(2)+1))];
        
        yxminus1 = [abs(finger1(x_m1(1)-1,x_m1(2)));
            abs(finger2(x_m1(1)-1,x_m1(2)));
            abs(finger3(x_m1(1)-1,x_m1(2)));
            abs(finger4(x_m1(1)-1,x_m1(2)))];
        
        yyminus1 = [abs(finger1(x_m1(1),x_m1(2)-1));
            abs(finger2(x_m1(1),x_m1(2)-1));
            abs(finger3(x_m1(1),x_m1(2)-1));
            abs(finger4(x_m1(1),x_m1(2)-1))];
        
        
        % difference formula=predicted observations- the four directional power distribution %[4x1]
        dx1=(yxplus1(1)-yxminus1(1))/2;
        dx2=(yxplus1(2)-yxminus1(2))/2;
        dx3=(yxplus1(3)-yxminus1(3))/2;
        dx4=(yxplus1(4)-yxminus1(4))/2;
        
        
        
        dy1=(yyplus1(1)-yyminus1(1))/2;
        dy2=(yyplus1(2)-yyminus1(2))/2;
        dy3=(yyplus1(3)-yyminus1(3))/2;
        dy4=(yyplus1(4)-yyminus1(4))/2;
        
        %% The jacobian matrix
        H=[[dx1;dx2;dx3;dx4] [dy1;dy2;dy3;dy4] zeros(4,1) zeros(4,1) ]; %[4x4]
        %% Measurement Update
        
        v=yt(:,k)-y_m; % measurement residual (innovation) [4x1]
        HH=H*P_m*H';
        S=HH+R;
        K=P_m*H'/S; % Gain [4x4]
        xe(:,k)=(x_m+K*v); %Updated state estimate [4x1]
        
        P=P_m-K*S*K'; % Updated state covariance [4x4]]
        
        rmse_ekf(MC)=sqrt(mean((X1(1,:)-xe(1,:)).^2+(X1(2,:)-xe(2,:)).^2));
    end
    mean_rmse=mean(rmse_ekf);
    confi_int=rmse_ekf;
    SEM = std(confi_int)/sqrt(length(confi_int));               % Standard Error
    ts = tinv([0.01  0.99],length(confi_int)-1);      % T-Score
    CI = mean(confi_int) + ts*SEM;
end

