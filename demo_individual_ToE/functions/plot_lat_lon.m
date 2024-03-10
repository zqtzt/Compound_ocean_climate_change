%% These codes should be run with m_map packages (https://www.eoas.ubc.ca/~rich/map.html)
function plot_lat_lon(lon,lat,variable_2D,title_name,interval)
if(nargin<5)
    interval=0.1;
end
variable_2D=squeeze(variable_2D);
[lon1,lat1]=meshgrid(double(lon),double(lat));
figure()
set (gcf,'Position',[488,131.4,987.4,630.6])
if(max(lon) >=177 && max(lon) <= 181)
    m_proj('robinson','lon',[-180 180],'lat',[-90 90]);
else
    m_proj('robinson','lon',[0 360],'lat',[-90 90]);
end

% [~,~]=m_contourf(lon,lat,variable_2D',[nanmin(variable_2D(:)):interval:nanmax(variable_2D(:))],'linestyle','none');

m_pcolor(lon,lat,variable_2D');
hold on
if(max(lon) >=177 && max(lon) <= 181)
    m_line([-180,180],[0,0],'LineWidth',1,'LineStyle','--','Color','black');
else
   m_line([0,360],[0,0],'LineWidth',1,'LineStyle','--','Color','black');
end

if(max(lon) >=177 && max(lon) <= 181)
    m_grid('gridcolor',0.95*[207 207 207]/255,'ytick',[-90:30:90],'xtick',[-180:60:180],...
        'fontsize',16 ,'box','on','color','black', 'linewidth',1.5);
else
    m_grid('gridcolor',0.95*[207 207 207]/255,'ytick',[-90:30:90],'xtick',[0:60:360],...
        'fontsize',16 ,'box','on','color','black', 'linewidth',1.5);
end

m_coast('patch',[192 192 192]/255,'edgecolor',[0.15 0.15 0.15]);  %land
set(gcf,'GraphicsSmoothing','off');
% colorbar
cb=colorbar;
set(cb,'location','SouthOutside')
set(cb,'fontsize',16)
title(title_name,'FontSize',20,'Fontname','Arial','FontWeight','bold')
end
