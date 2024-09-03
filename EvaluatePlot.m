function Results = EvaluatePlot(Data,name,Folder)%#1 
% X = Data.InputsDeNormal;%#1
Y = Data.TargetsDeNormal;%#1
Yhat = Data.ANFISOutputsDeNormal;%#1 
Errors = Y-Data.ANFISOutputs; 
% Mean Squared Error
MSE = mean((Yhat - Y).^2); 
% Root Mean Squared Error
RMSE = (mean((Yhat - Y).^2))^0.5; 
% Relative Squared Error
RSE = sum((Yhat - Y).^2)/sum((ones(size(Y))*mean(Y) - Y).^2); 
% Mean Absolute Error
MAE = mean(abs(Yhat - Y)); 
% R² score, the coefficient of determination
R2 = 1 - RSE; 
% Explained variance score%#1
EVS = 1 - std(Yhat - Y)/std(Y);%#1 
% Curve Fitting Plot%#1
Plot_Curve_Fit(Y,Yhat,[name ' Curve Fitting Plot']);%#1
savefig([Folder '\'  [name ' Curve Fitting Plot']]);%#1 
% Errors Plot%#1
Plot_Errors(Errors,[name ' Errors Plot'],MSE,RMSE)%#1
savefig([Folder '\' [name ' Errors Plot' ]]);%#1 
% Errors Histogram Plot%#1
Plot_Error_Hist(Errors,[name ' Errors Histogram Plot'],MSE,MAE,RSE,EVS)%#1
savefig([Folder '\' [name ' Errors Histogram Plot' ]]);%#1 
% Regression Plot%#1
figure, plotregression(Y,Yhat,'Regression');%#1
xlabel(['Observed Targets of ' name],'FontSize',12,'FontWeight','bold');%#1
ylabel(['Predicted Targets of ' name],'FontSize',12,'FontWeight','bold');%#1
title(['\fontsize{15}\bf',{[name ' Regression Plot'],...%#1
['R^2 = ' num2str(R2) ' , RMSE = ' num2str(RMSE)]}]);%#1 
savefig([Folder '\' [name ' Regression Plot' ]]);%#1 
s1 = ['R2 = ' num2str(R2)];%#1
s2 = ['MSE = ' num2str(MSE)];%#1
s3 = ['RMSE = ' num2str(RMSE)];%#1
s4 = ['MAE = ' num2str(MAE)];%#1
s5 = ['RSE = ' num2str(RSE)];%#1
s6 = ['EVS = ' num2str(EVS)];%#1 
% fid = fopen(['Results\' [name '_Results.txt']],'wt');%#1
fid = fopen([Folder '\' [name '_Results.txt']],'wt');%#1
fprintf(fid, [s1 '\n' s2 '\n' s3 '\n' s4 '\n' s5 '\n' s6]);%#1
fclose(fid);%#1 
% Store Results%#1
Results.Name = [name,' Data'];%#1
Results.R2 = R2;%#1
Results.MSE = MSE;%#1
Results.RMSE = RMSE;%#1
Results.MAE = MAE;%#1
Results.RSE = RSE;%#1
Results.EVS = EVS;%#1
Results.Errors = Errors;%#1
% Results.X = X;%#1
Results.Y = Y;%#1
Results.Yhat = Yhat;%#1
disp(Results);%#1
end%#1
