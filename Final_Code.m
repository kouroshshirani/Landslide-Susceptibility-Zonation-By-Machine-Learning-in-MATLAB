clc;
clear;
close all;
if isfolder('Results_Final')==0
    mkdir('Results_Final');
end
warning off
 
%% 1 - Loading Trained ANFIS Model
 
load('Results\ANFIS_MATLAB_Output_File.mat');
 
%%  2 - Importing Big Data
 
Final_Inputs = xlsread('BIG_DATA.xlsx',1);

%% 3 - Normalizing the Data-set
 
Prompt={'First of Normalization Interval','End of Normalization Interval'};
        Title='Normalization';
        DefaultValues={'0.1','0.9'};
        
        PARAMS=inputdlg(Prompt,Title,1,DefaultValues);
        
        a=str2num(PARAMS{1}); %#ok; 
        b=str2num(PARAMS{2}); %#ok;
        
% pause(0.1);
 
MinInputs = min(Final_Inputs);
MaxInputs = max(Final_Inputs);
 
InputsNormal = Final_Inputs;
 
for ii = 1:nFeature
    InputsNormal(:,ii) = Normalize_Fcn(Final_Inputs(:,ii),MinInputs(ii),MaxInputs(ii),a,b);
end
 
Option{1}='YES';
Option{2}='NO';
 
ANSWER=questdlg('Do you want to use Normalized Inputs?',...
                'Normalization',...
                Option{1},Option{2},Option{1});
% pause(0.1);
 
switch ANSWER
    
    case Option{1}
        Inputs = InputsNormal;
       
    case Option{2}
        Inputs = Data(:,1:13);          
end
 
%% 4 - Calculating the Land-slide for Final Data-set
 
Final_Outputs = evalfis(Inputs,fis);
 
%% 5 - DeNormalizing the Data-set 
 
Option{1}='YES';
Option{2}='NO';
 
ANSWER=questdlg('Do you want to DeNormalized Data-Sets?',...
                'DeNormalization',...
                Option{1},Option{2},Option{1});
pause(0.01);
 
switch ANSWER
    
    case Option{1}
        
        % Input Data DeNormalizing
        MinInputsNormal = min(InputsNormal);
        MaxInputsNormal = max(InputsNormal);
        InputsDeNormal = InputsNormal;
        for ii = 1:nFeature
            InputsDeNormal(:,ii) = DeNormalize_Fcn(InputsNormal(:,ii),MinInputsNormal(ii),MaxInputsNormal(ii),MinInputs(ii),MaxInputs(ii));
        end
        
        
        % ANFIS Outputs DeNormalizing
        Min_Y_ANFIS = min(Final_Outputs);
        Max_Y_ANFIS = max(Final_Outputs);
        Final_Outputs_DeNormal = Final_Outputs;
        for i = 1:size(Final_Outputs,2)
            Final_Outputs_DeNormal(:,i) = DeNormalize_Fcn(Final_Outputs(:,i),Min_Y_ANFIS(i),Max_Y_ANFIS(i),MinTargets(i),MaxTargets(i));
        end
        
    
    case Option{2}
        
        InputsDeNormal = Final_Inputs;
        Final_Outputs_DeNormal = Final_Outputs;
        
end
 
%% 6 - Export Predicted Outputs
 
Final_Outputs_DeNormal(Final_Outputs_DeNormal>1)=1;
Final_Outputs_DeNormal(Final_Outputs_DeNormal<0)=0;
 
Final_DATA = [InputsDeNormal , Final_Outputs_DeNormal];
 
xlswrite('Final_DATA.xlsx',Final_DATA);
 
save('Results_Final\ANFIS_MATLAB_Output_File.mat');
