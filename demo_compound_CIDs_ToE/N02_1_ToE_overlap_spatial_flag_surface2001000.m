%%%%%% check the triple emergence (T&S&DO) grid with the analysis(median) field data
clear
clc

load ./Input_data/singal_noise_upper20010002000.mat signal_200_1000 signal_200

%% 0-200

%%%% load the ToE of analysis field for each CID
load ./Input_data/T_ToE_data_upper20010002000_analysis_field.mat ToE_warming_upper200 ToE_cooling_upper200 lat lon
load ./Input_data/S_ToE_data_upper20010002000_analysis_field.mat ToE_salting_upper200 ToE_freshing_upper200
load ./Input_data/DO_ToE_data_upper200_analysis_field.mat ToE_deoxygenation_median ToE_oxygenation_median
ToE_deoxygenation_upper200=ToE_deoxygenation_median;
ToE_oxygenation_upper200=ToE_oxygenation_median;
clear ToE_deoxygenation_median ToE_oxygenation_median

%%%% check the triple emergence grid with the analysis(median) field data
isOverlap_warming_salin_deoxygen = (~isnan(ToE_warming_upper200) & ~isnan(ToE_salting_upper200) & ~isnan(ToE_deoxygenation_upper200));
isOverlap_warming_fresh_deoxygen = (~isnan(ToE_warming_upper200) & ~isnan(ToE_freshing_upper200) & ~isnan(ToE_deoxygenation_upper200));
TOE_overlap_warming_salin_deoxygen=NaN(360,180);
TOE_overlap_warming_fresh_deoxygen=NaN(360,180);
for i = 1:360
    for j = 1:180
        if isOverlap_warming_salin_deoxygen(i,j)
            TOE_overlap_warming_salin_deoxygen(i,j) = nanmax([ToE_warming_upper200(i,j), ToE_salting_upper200(i,j), ToE_deoxygenation_upper200(i,j)]);
        end
        if isOverlap_warming_fresh_deoxygen(i,j)
            TOE_overlap_warming_fresh_deoxygen(i,j) = nanmax([ToE_warming_upper200(i,j), ToE_freshing_upper200(i,j), ToE_deoxygenation_upper200(i,j)]);
        end
    end
end

% plot_lat_lon(lon,lat,TOE_overlap_warming_salin_deoxygen,'TOE_overlap_warming_salin_deoxygen')

% save the flag
ToE_emergence_flag=zeros(360,180);  %0=no emergence
ToE_emergence_flag(isOverlap_warming_fresh_deoxygen)=6;  %6=triple emergence of warminng&freshening&deoxygenation
ToE_emergence_flag(isOverlap_warming_salin_deoxygen)=7;  %7=triple emergence of warming&salinization&deoyxgenation
save ./Output_data/ToE_overlap_analysis_field_triple_emergence_flag_upper200.mat ToE_emergence_flag TOE_overlap* lat lon
