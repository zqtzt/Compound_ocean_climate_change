function plot_setting(islegendShown)
% set(gcf,'Position',[15,312,879,601]);
set(gca,'FontName','Arial');
set(gca,'FontSize',16);
set(gca,'LineWidth',1);
% set (gcf,'Position',[197,304,843,649])
set (gcf,'Position',[488,208.2,764.2,553.8])
grid off
box off
% set(gca, 'Color', 'none'); % 将图形背景设置为透明
if(islegendShown==1)
    set(legend,'FontName','Arial');
    set(legend,'FontWeight','normal');
    set(legend,'FontSize',16);
    set(legend,'Box','Off')
    set(legend,'Location','best')
    % matlab.graphics.illustration.Legend.FontSize=14;
    % matlab.graphics.illustration.Legend.FontWeight='normal';
    % matlab.graphics.illustration.Legend.FontSize='Arial';
    % matlab.graphics.illustration.Legend.Box='Off';
end