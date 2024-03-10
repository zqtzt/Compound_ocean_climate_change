%%%%%%%%%% calculate the column weighted average
function [avg_temp]=depth_avg_grid(temp,depth_std,depth_start_order,depth_max_order)

%%%% temp: 1D temperature column data; depth_std: standard depth levels
%%%% depth_max_order£ºThe sequence number of the selected maximum level in depth_std (e.g., the upper700 depth average, you can calculate this value with ¡®find (depth_std==700)'
total_volume=0;

depth_std=depth_std(depth_start_order:depth_max_order);
temp=temp(depth_start_order:depth_max_order);


try
    levels=length(depth_std);
    total_depth=depth_std(levels);
catch
    avg_temp=NaN;
    return
end

for k=1:levels %depth_max_order
    if(k==1)
        volume=temp(k)*depth_std(1);   %The first level
    else
        volume=temp(k)*(abs(depth_std(k)-depth_std(k-1)));  %the other levels
    end
    total_volume=total_volume+volume;
end
% total_depth
avg_temp=total_volume./total_depth;  % average
end