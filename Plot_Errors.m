function Plot_Errors(Errors,Name,MSE,RMSE)%#1 
    % Errors Plot%#1
    figure;%#1
    plot(Errors,'b');%#1
    xlabel('Number of Sample','FontSize',22,'FontWeight','bold')%#1
    ylabel('Errors','FontSize',22,'FontWeight','bold')%#1
    title(['\fontsize{20}\bf',{Name,['MSE = ' num2str(MSE) ' , RMSE = ' num2str(RMSE) ]}])%#1
    xlim([0 size(Errors,1)+5]);%#1
 
end
