%%%%%%%% Using MonteCarlo method to determine the significant compound emergences at 95% CI
% Here: epipelagic zone (0-200m), determine significant triple emergence regions (95% confidence)
% following the methods shown in Extend Data Fig.11
clear
clc

% load the result from N02_1_ToE_overlap_spatial_flag_surface2001000.m
load ./Output_data/ToE_overlap_analysis_field_triple_emergence_flag_upper200.mat ToE_emergence_flag
%load the individual CID emergence map with ensemble members
load ./Input_data/T_ToE_data_upper200.mat ToE_warming_upper200 ToE_cooling_upper200 lat lon
load ./Input_data/S_ToE_data_upper200.mat ToE_freshening_upper200 ToE_salinification_upper200
load ./Input_data/DO_ToE_data_upper200.mat ToE_deoxygenation_upper200 ToE_oxygenation_upper200

%% Significant triple emergence determination: warming+salinification+deoxygenation
ToE_overlap_warming_salin_deoxygenation=zeros(70000,360,180,'int16');
T_box=[1:30];  %30 balls for temperature
S_box=[1:40]; %40 balls for salinity
DO_box=[1:30]; %30 balls for dissolved oxygen
rng(123);
m_n_k_order=zeros(3,70000,'int8');
for times=1:70000
    %  random 'pick' one ball from each box, and then combine together
    T_sample = T_box(randi(30));
    S_sample = S_box(randi(40));
    DO_sample = DO_box(randi(30));
    m_n_k_order(:,times)=[T_sample,S_sample,DO_sample];
end

parfor times=1:70000
    times
    m=m_n_k_order(1,times);  %for temperature
    n=m_n_k_order(2,times);  %for salinity
    p=m_n_k_order(3,times);  %for oxygen
    
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
    
    ToE_deoxygenation_single=squeeze(ToE_deoxygenation_upper200(p,:,:));
    ToE_oxygenation_single=squeeze(ToE_oxygenation_upper200(p,:,:));
    
    index=isnan(ToE_oxygenation_single);
    ToE_oxygen_single=ToE_oxygenation_single;
    ToE_oxygen_single(index)=ToE_deoxygenation_single(index);
    
    %%%%%%check overlap exist?
    is_overlap_warming_salnification_deoxygenation=~isnan(ToE_warming_single) .* ~isnan(ToE_deoxygenation_single) .* ~isnan(ToE_salinification_single);
    is_overlap_T_S_DO=~isnan(ToE_temperature_single) | ~isnan(ToE_salinity_single) | ~isnan(ToE_oxygen_single);
    is_other_direction=is_overlap_T_S_DO==1 & is_overlap_warming_salnification_deoxygenation==0;
    
    %%%%%%check the direction: warming+salinification+deoxygenation, determine the triple ToE
    for i=1:360
        for j=1:180
            if(is_overlap_warming_salnification_deoxygenation(i,j))
                ToE_overlap_warming_salin_deoxygenation(times,i,j)=nanmax([ToE_warming_single(i,j),ToE_deoxygenation_single(i,j),ToE_salinification_single(i,j)]);
            elseif(is_other_direction(i,j))
                %                         'here'
                ToE_overlap_warming_salin_deoxygenation(times,i,j)=999; %999= other directions
            end
        end
    end
    
end

ToE_warming_salinification_deoxygenation_significant_flag=NaN(360,180);
data_999=NaN(360,180);
for i=1:360
    for j=1:180
        %Here follow the method shown in Extended Data Fig.11 in the manuscript
        if(ToE_emergence_flag(i,j)==7) %7:warming+deoxygenation+salinification
            member_data=squeeze(ToE_overlap_warming_salin_deoxygenation(:,i,j));
            member_data=single(member_data);
            member_data(member_data==0)=NaN;
            data_999(i,j)=sum(member_data==999);
            if(sum(~isnan(member_data) & member_data~=999)/(length(member_data))>=0.5)  %有一半的数据认为是warming+salinification
                % discard other directions
                member_data(member_data==999)=[];
                if(sum(~isnan(member_data))/length(member_data)>=0.95)
                    % significant double emergence before 2022 at 95% CI
                    ToE_warming_salinification_deoxygenation_significant_flag(i,j)=1;
                else
                     % insignificant double emergence before 2022 at 95% CI
                    ToE_warming_salinification_deoxygenation_significant_flag(i,j)=0;
                end
            else
                ToE_warming_salinification_deoxygenation_significant_flag(i,j)=0;
            end
        end
    end
end
% plot_lat_lon(lon,lat,ToE_warming_salinification_deoxygenation_significant_flag,'s')
clear ToE_overlap_warming_salin_deoxygenation

%% Triple emergence :warming+freshening+deoxygenation
ToE_overlap_warming_freshen_deoxygenation=zeros(70000,360,180,'int16');
parfor times=1:70000
    times
    m=m_n_k_order(1,times);  %for temperature
    n=m_n_k_order(2,times);  %for salinity
    p=m_n_k_order(3,times);  %for oxygen
    
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
    
    ToE_deoxygenation_single=squeeze(ToE_deoxygenation_upper200(p,:,:));
    ToE_oxygenation_single=squeeze(ToE_oxygenation_upper200(p,:,:));
    
    index=isnan(ToE_oxygenation_single);
    ToE_oxygen_single=ToE_oxygenation_single;
    ToE_oxygen_single(index)=ToE_deoxygenation_single(index);
    
    is_overlap_warming_freshening_deoxygenation=~isnan(ToE_warming_single) .* ~isnan(ToE_deoxygenation_single) .* ~isnan(ToE_freshening_single);
    is_overlap_T_S_DO=~isnan(ToE_temperature_single) | ~isnan(ToE_salinity_single) | ~isnan(ToE_oxygen_single);
    is_other_direction=is_overlap_T_S_DO==1 & is_overlap_warming_freshening_deoxygenation==0;
    
    %%%%%%check direction: warming+salinification+deoxygenation
    for i=1:360
        for j=1:180
            if(is_overlap_warming_freshening_deoxygenation(i,j))
                ToE_overlap_warming_freshen_deoxygenation(times,i,j)=nanmax([ToE_warming_single(i,j),ToE_deoxygenation_single(i,j),ToE_freshening_single(i,j)]);
            elseif(is_other_direction(i,j))
                ToE_overlap_warming_freshen_deoxygenation(times,i,j)=999; %999=other emeregence directions
            end
        end
    end
end

ToE_warming_freshen_deoxygenation_significant_flag=NaN(360,180);
data_999=NaN(360,180);
for i=1:360
    for j=1:180
        if(ToE_emergence_flag(i,j)==6) %6:warming+deoxygenation+fresheing
            member_data=squeeze(ToE_overlap_warming_freshen_deoxygenation(:,i,j));
            member_data=single(member_data);
            member_data(member_data==0)=NaN;
            data_999(i,j)=sum(member_data==999);
            if(sum(~isnan(member_data) & member_data~=999)/(length(member_data))>=0.5)  %有一半的数据认为是warming+salinification
                % discard other direction data
                member_data(member_data==999)=[];
                if(sum(~isnan(member_data))/length(member_data)>=0.95)
                    % significant double emergence before 2022 in 95% CI
                    ToE_warming_freshen_deoxygenation_significant_flag(i,j)=1;
                else
                    ToE_warming_freshen_deoxygenation_significant_flag(i,j)=0;
                end
            else
                ToE_warming_freshen_deoxygenation_significant_flag(i,j)=0;
            end
        end
    end
end

save ./Output_data/ToE_triple_significant_flag_upper200.mat lat lon ToE_warming_salinification_deoxygenation_significant_flag ToE_warming_freshen_deoxygenation_significant_flag lat lon