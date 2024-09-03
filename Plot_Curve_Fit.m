function Plot_Curve_Fit(Targets,Outputs,Name)%#1    
    figure;%#1    
    plot(Targets,'bo-','linewidth',1.2,'Markerfacecolor','b')%#1
    ax = gca;%#1
    ax.FontSize = 12;%#1
    ax.TickDir = 'in';%#1
    ax.TickLength = [0.02 0.02];%#1
    grid minor%#1
    ax.MinorGridLineStyle = '-' ;%#1
    ax.XGrid = 'off';%#1
    ax.YGrid = 'off';%#1
    ax.GridColorMode ='manual';%#1
    ax.GridColor = [0 0 0];%#1
    ax.GridAlpha = 0.75;%#1
    hold on%#1
    plot(Outputs,'rs-','linewidth',1.2,'Markerfacecolor','r')%#1
    title(['\fontsize{24}\bf' num2str(Name)]);%#1
    xlabel('Number of Sample','FontSize',22,'FontWeight','bold')%#1
    ylabel('Targets and Outputs','FontSize',22,'FontWeight','bold')%#1
    set(findobj(gcf,'type','axes'),'FontWeight','Bold', 'LineWidth', 0.9)%#1
    hold off%#1
    legend({'Targets','Outputs'},'FontSize',18,'FontWeight','bold')%#1 
end%#1
