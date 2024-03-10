%%%%%% calculate the signal (G(t)) and noise of the global average
clear
clc
load('T_global_avg_baseline1960_1979.mat')

depth_std=[1,5,10,20,30,40,50,60,70,80,90,100,120,140,160,180,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,2000];

%%%%%%%%
xt=linspace(1960,2021,745);
xt(end)=[];
for k=1:41
    T_global_level_smooth(:,k)=smooth(xt,T_global_level(:,k),25*12,'lowess',2);
end

global_T_signal_level=NaN(41,1);
global_T_noise_level=NaN(41,1);
for k=1:41
    %%% sinal
    avg_2022=nanmean(T_global_level_smooth((2021-1960)*12+1:(2022-1960)*12,k));
    global_T_signal_level(k)=avg_2022;
    %%% noise
    global_T_noise_level(k)=nanstd(T_global_level(:,k)-T_global_level_smooth(:,k));
end

save global_SN_level.mat global_T_signal_level global_T_noise_level depth_std T_global_level T_global_level_smooth T_global_upper200 T_global_upper2000 T_global_upper200_1000 xt

%% upper200
%%%%%%%%%%calculate SNR (signal to noise ratio)
xt=linspace(1960,2022,745);
xt(end)=[];
T_global_upper200_smooth=smooth(xt,T_global_upper200,25*12,'lowess',2);  %global_SC_monthly_smooth

%%% signal
avg_2021=nanmean(T_global_upper200_smooth((2021-1960)*12+1:(2022-1960)*12));
global_T_signal=avg_2021;

%%% noise
global_T_noise=nanstd(T_global_upper200-T_global_upper200_smooth);
global_T_noise(2)=2*global_T_noise(1);

%%% SNR
signal_noise=global_T_signal./global_T_noise;

% plot 0-200m time series with noise 
noise=global_T_noise;
signal=global_T_signal;
xt=linspace(1960,2022,745);
xt(end)=[];
yt=T_global_upper200;
yt_smooth=T_global_upper200_smooth;

figure()
plot_signal_noise(noise,signal,xt,yt,yt_smooth);
txt=['Global temperature (upper200m)'];
title(txt)
ylabel('Temperature Anomaly (^oC)')
xlim([1960 2022])
filename=['./pics/global_SN_average/global_SN_upper200m.png'];
saveas(gcf,filename)

%% upper2000
xt=linspace(1960,2021,745);
xt(end)=[];
T_global_upper2000_smooth=smooth(xt,T_global_upper2000,25*12,'lowess',2);  %global_SC_monthly_smooth

%%% �ź�
avg_2021=nanmean(T_global_upper2000_smooth((2021-1960)*12+1:(2022-1960)*12));
global_T_signal=avg_2021;

%%% ����
global_T_noise=nanstd(T_global_upper2000-T_global_upper2000_smooth);
global_T_noise(2)=2*global_T_noise(1);

%%% �����
signal_noise=global_T_signal./global_T_noise;

% ��ȫ��upper200ʱ�����к�����
noise=global_T_noise;
signal=global_T_signal;
xt=linspace(1960,2022,745);
xt(end)=[];
yt=T_global_upper2000;
yt_smooth=T_global_upper2000_smooth;

figure()
plot_signal_noise(noise,signal,xt,yt,yt_smooth);
txt=['Global temperature (upper2000m)'];
title(txt)
ylabel('Temperature Anomaly (^oC)')
xlim([1960 2022])
filename=['./pics/global_SN_average/global_SN_upper2000m.png'];
saveas(gcf,filename)


%% 200-1000
xt=linspace(1960,2021,745);
xt(end)=[];
T_global_upper200_1000_smooth=smooth(xt,T_global_upper200_1000,25*12,'lowess',2);  %global_SC_monthly_smooth

%%% �ź�
avg_2021=nanmean(T_global_upper200_1000_smooth((2021-1960)*12+1:(2022-1960)*12));
global_T_signal=avg_2021;

%%% ����
global_T_noise=nanstd(T_global_upper200_1000-T_global_upper200_1000_smooth);
global_T_noise(2)=2*global_T_noise(1);

%%% �����
signal_noise=global_T_signal./global_T_noise;

% ��ȫ��upper200ʱ�����к�����
noise=global_T_noise;
signal=global_T_signal;
xt=linspace(1960,2022,745);
xt(end)=[];
yt=T_global_upper2000;
yt_smooth=T_global_upper2000_smooth;

figure()
plot_signal_noise(noise,signal,xt,yt,yt_smooth);
txt=['Global temperature (200-1000m)'];
title(txt)
ylabel('Temperature Anomaly (^oC)')
xlim([1960 2022])
filename=['./pics/global_SN_average/global_SN_upper200_1000m.png'];
saveas(gcf,filename)


%%
%%%%%%%%%%%% ���ʱ������
clear
clc
load global_SN_level.mat

for k=1:41
    noise=[global_T_noise_level(k),2*global_T_noise_level(k)];
    signal=global_T_signal_level(k);
    yt=T_global_level(:,k);
    yt_smooth=T_global_level_smooth(:,k);
    
    figure()
plot_signal_noise(noise,signal,xt,yt,yt_smooth);
txt=['Global temperature (',num2str(depth_std(k)),'m)'];
title(txt)
ylabel('Temperature Anomaly (^oC)')
filename=['./pics/global_SN_average/global_SN_',num2str(depth_std(k)),'m.png'];
saveas(gcf,filename)
end

%����ÿһ���ToEʱ��
ToE_warming_level=NaN(41,1);
for k=1:41
    k
    global_level_anomaly_monthly_smooth=squeeze(T_global_level_smooth(:,k));
    
    signal_div_noise_2021=global_T_signal_level(k)./global_T_noise_level(k);
    if(abs(signal_div_noise_2021)<1 || isnan(signal_div_noise_2021))
        %��2021�궼��û�ó�����ֱ��pass
        %             'here'
        continue
    end
    for year=2021:-1:1960  %���𣬴��ҿ�ʼ��
        avg_signal=nanmean(global_level_anomaly_monthly_smooth((year-1960)*12+1:(year+1-1960)*12));
        local_noise=global_T_noise_level(k);
        %������Щ�ǿ϶�����S/N>=1��
        signal_div_noise=avg_signal./local_noise;
        if(signal_div_noise<1 && signal_div_noise>=0)
            ToE_warming_level(k)=year+1;
            break
        end
    end
    
end


figure()
plot(ToE_warming_level,depth_std)
reverse_yaxis()