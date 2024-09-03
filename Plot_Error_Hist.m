function Plot_Error_Hist(Errors,Name,MSE,MAE,RSE,EVS)%#1 
    % Errors Histogram Plot %#1
    figure;%#1
    histfit(Errors,50);%#1
    xlabel('Error Range','FontSize',22,'FontWeight','bold')%#1
    ylabel('Sample Number','FontSize',22,'FontWeight','bold')%#1
    title(['\fontsize{20}\bf',{Name,['MSE = ' num2str(MSE) ' , MAE = ' num2str(MAE) ' , RSE = ' num2str(RSE) ' , EVS = ' num2str(EVS) ]}])%#1 
end%#1
