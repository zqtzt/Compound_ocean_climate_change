%%%%%% Monte-Carlo ToE for T+S+DO (triple emergence) in epipelagic zone
%%%% calculate the global percentage of triple emergence as a function of year with 95% CI

clear
clc
load ./Input_data/singal_noise_upper20010002000.mat signal_200
signal_200(1:360,[1:20,159:180])=NaN; %mask polar regions
load ./Input_data/global_grid_area.mat global_area

%%%% load individual CIDs ToE data with ensemble members
load ./Input_data/T_ToE_data_upper200.mat ToE_warming_upper200 ToE_cooling_upper200 lat lon
load ./Input_data/S_ToE_data_upper200.mat ToE_freshening_upper200 ToE_salinification_upper200 lat lon
load ./Input_data/DO_ToE_data_upper200.mat ToE_deoxygenation_upper200 ToE_oxygenation_upper200 lat lon

T_box=[1:30];  %30 samples (i.e., 30 red balls for temperature)
S_box=[1:40]; %40 samples (i.e., 40 white balls for salinity)
DO_box=[1:30]; %30 samples (i.e. 30 blue balls for oxygen)
rng(123); %random seed
m_n_k_order=zeros(3,70000,'int8');
for times=1:70000
    %  random 'pick' one ball from each box, and then combine together
    T_sample = T_box(randi(30));  
    S_sample = S_box(randi(40));
    DO_sample = DO_box(randi(30));
    m_n_k_order(:,times)=[T_sample,S_sample,DO_sample];  % generate 70,000 times pick sequences
end

ToE_overlap_T_S_DO_upper200=zeros(70000,360,180,'int16');
T_S_DO_ToE_percentage_upper200=single(zeros(70000,2022));
parfor times=1:70000
    times
    m=m_n_k_order(1,times);  %for temperature
    n=m_n_k_order(2,times);  %for salinity
    k=m_n_k_order(3,times);  %for oxygen
    
    ToE_warming_single=squeeze(ToE_warming_upper200(m,:,:));
    ToE_cooling_single=squeeze(ToE_cooling_upper200(m,:,:));
    
    index=isnan(ToE_warming_single);
    ToE_temperature_single=ToE_warming_single;
    ToE_temperature_single(index)=ToE_cooling_single(index);
    
    ToE_salinification_single=squeeze(ToE_salinification_upper200(n,:,:));
    ToE_freshening_single=squeeze(ToE_freshening_upper200(n,:,:));
    
    index=isnan(ToE_salinification_single);
    ToE_salinity_single=ToE_salinification_single;
    ToE_salinity_single(index)=ToE_freshening_single(index);
    
    ToE_oxygenation_single=squeeze(ToE_oxygenation_upper200(k,:,:));
    ToE_deoxygenation_single=squeeze(ToE_deoxygenation_upper200(k,:,:));
    
    index=isnan(ToE_oxygenation_single);
    ToE_oxygen_single=ToE_oxygenation_single;
    ToE_oxygen_single(index)=ToE_deoxygenation_single(index);
    
    %%%%%%check if there are 'overlap' grids, and find the triple ToE in these grids
    is_overlap_T_S_DO=~isnan(ToE_temperature_single) .* ~isnan(ToE_salinity_single) .* ~isnan(ToE_oxygen_single);
    for i=1:360
        for j=1:180
            if(is_overlap_T_S_DO(i,j))
                ToE_overlap_T_S_DO_upper200(times,i,j)=nanmax([ToE_temperature_single(i,j),ToE_salinity_single(i,j),ToE_oxygen_single(i,j)]);
            end
        end
    end
end

%%%%%% calculate the global percentage of triple emergence
area_copy=global_area;
area_copy(isnan(signal_200))=NaN;
total_area=sum(sum(area_copy,'omitnan'),'omitnan');
for m=1:70000
    overlap_data=squeeze(ToE_overlap_T_S_DO_upper200(m,:,:));
    overlap_data=single(overlap_data);
    overlap_data(overlap_data==0)=NaN;
    for year=1960:2021
        %%%T+S
        index=overlap_data==year;
        area_copy1=area_copy;
        area_copy1(~index)=NaN;
        ToE_overlap_area=sum(sum(area_copy1,'omitnan'),'omitnan');
        T_S_DO_ToE_percentage_upper200(m,year)=ToE_overlap_area/total_area;
    end
end
T_S_DO_ToE_percentage_upper200=cumsum(T_S_DO_ToE_percentage_upper200,2); 
T_S_DO_ToE_percentage_upper200(T_S_DO_ToE_percentage_upper200==0)=NaN;

% 95% confidence interval and median
T_S_DO_ToE_percentage_upper200_975=prctile(T_S_DO_ToE_percentage_upper200,97.5,1);
T_S_DO_ToE_percentage_upper200_25=prctile(T_S_DO_ToE_percentage_upper200,2.5,1);
T_S_DO_ToE_percentage_upper200_median=nanmedian(T_S_DO_ToE_percentage_upper200,1);

save ./Output_data/percentage_year_T_S_DO_overlap_upper200.mat T_S_DO_ToE_percentage_upper200 *975 *25 *median lat lon

%% create figure
figure()
hold on
plot(1960:2021,T_S_DO_ToE_percentage_upper200(:,1960:2021)*100,'--','LineWidth',0.8,'HandleVisibility','off')
plot(1960:2021,T_S_DO_ToE_percentage_upper200_975(:,1960:2021)*100,'--','LineWidth',2.5,'Color','black')
plot(1960:2021,T_S_DO_ToE_percentage_upper200_25(:,1960:2021)*100,'--','LineWidth',2.5,'Color','black','HandleVisibility','off')
plot(1960:2021,T_S_DO_ToE_percentage_upper200_median(:,1960:2021)*100,'-','LineWidth',2.5,'Color','black')
xlim([1960 2021])
xlabel('Year')
ylabel('Ocean area (%)')
legend('Median','95% CI')
plot_setting(1)
% saveas(gcf,'./T_S_DO_ToE_percentage_upper200.png')