%%%% global 3-D weighted average (global 1-degree average)
function ave_variable=global_weight_ave_all_levels(variable_lon_lat_depth,lat,lon,depth_std,begin_order,end_order)

r=6371; % Earth radius (km)
N_S=r*pi/180;   %North-south distance for one grid
W_E=N_S*cos(lat*pi/180);  %west-east distance for one grid depends on latitude

total_volume=0;
total_variable=0;
for k=begin_order:end_order
    %cube
    if(k==1)
        volume_single=N_S*W_E*abs(depth_std(k));
    else
        volume_single=N_S*W_E*abs(depth_std(k)-depth_std(k-1));
    end
    
    volume=meshgrid(volume_single,lon);
    variable1=reshape(variable_lon_lat_depth(:,:,k),length(lon),length(lat)).*volume;
    
    volume(isnan(variable1))=NaN;
    %ÇóºÍ
    total_volume=total_volume+sum(sum(volume,'omitnan'),'omitnan');
    total_variable=total_variable+sum(sum(variable1,'omitnan'),'omitnan');
    
end
ave_variable=total_variable/total_volume;
end