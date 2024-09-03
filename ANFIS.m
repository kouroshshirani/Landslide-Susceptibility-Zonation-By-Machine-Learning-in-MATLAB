clc;%#1
clear;%#1
close all;%#1
if isfolder('Results')==0%#1
    mkdir('Results');%#1
end%#1
%% 1 - Importing Data-set%#1 
Data = xlsread('DATA.xlsx',1);%#1
Nan=isnan(Data);%#1
Data(Nan==1)=0;%#1
Inputs = Data(:,1:13);%#1
Targets = Data(:,14);%#1
[nSamples,nFeature] = size(Inputs);%#1 
TargetsNum = size(Targets,2);%#1
%% 2 - Normalizing the Data-set%#1 
Prompt={'First of Normalization Interval','End of Normalization Interval'};%#1
        Title='Normalization';%#1
        DefaultValues={'0.1','0.9'};%#1
PARAMS=inputdlg(Prompt,Title,1,DefaultValues);%#1
        a=str2num(PARAMS{1}); %#ok;%#1
        b=str2num(PARAMS{2}); %#ok;%#1
% pause(0.1);%#1
MinInputs = min(Inputs);%#1
MaxInputs = max(Inputs);%#1
MinTargets = min(Targets);%#1
MaxTargets = max(Targets);%#1
InputsNormal = Inputs;%#1
TargetsNormal = Targets;%#1 
for ii = 1:nFeature%#1
    InputsNormal(:,ii) = Normalize_Fcn(Inputs(:,ii),MinInputs(ii),MaxInputs(ii),a,b);%#1
end%#1
for ii = 1:TargetsNum%#1
    TargetsNormal(:,ii) = Normalize_Fcn(Targets(:,ii),MinTargets(ii),MaxTargets(ii),a,b);%#1
end%#1
Option{1}='YES';%#1
Option{2}='NO';%#1
ANSWER=questdlg('Do you want to use Normalized Inputs?',...%#1
                'Normalization',...%#1
                Option{1},Option{2},Option{1});%#1
% pause(0.1);%#1
switch ANSWER%#1
    case Option{1}%#1
        Inputs = InputsNormal;%#1
        Targets = TargetsNormal;%#1
    case Option{2}%#1
        Inputs = Data(:,1:13);%#1
        Targets = Data(:,14);%#1         
end%#1
%% 3 - Selecting Train and Test Data-set%#1
TrPercent = 70;%#1
TrNum = round(nSamples * TrPercent / 100);%#1
R = randperm(nSamples);%#1
trIndex = R(1 : TrNum);%#1
tsIndex = R(1+TrNum : end);%#1
TrainData.Inputs = Inputs(trIndex,:);%#1
TrainData.Targets = Targets(trIndex,:);%#1
TrainData.nFeature = nFeature;%#1
TestData.Inputs = Inputs(tsIndex,:);%#1
TestData.Targets = Targets(tsIndex,:);%#1
%% 4 - Generate Basic FIS%#1 
fis = CreateInitialFIS(TrainData,10);%#1
%% 5 - Tarin Using ANFIS Method%#1
fis = TrainUsingANFIS(fis,TrainData);%#1
%% 6 - Test ANFIS%#1
TrainData.ANFISOutputs = evalfis(TrainData.Inputs,fis);  % Train Outputs of ANFIS%#1
TestData.ANFISOutputs  = evalfis(TestData.Inputs,fis);   % Test Outputs of ANFIS%#1
%% 7 - DeNormalizing the Data-set%#1
Option{1}='YES';%#1
Option{2}='NO';%#1 
ANSWER=questdlg('Do you want to DeNormalized Data-Sets?',...%#1
                'DeNormalization',...%#1
                Option{1},Option{2},Option{1});%#1
pause(0.01);%#1
switch ANSWER%#1
case Option{1}%#1
        % Input Data DeNormalizing%#1
        MinInputsNormal = min(InputsNormal);%#1
        MaxInputsNormal = max(InputsNormal);%#1
        InputsDeNormal = InputsNormal;%#1
        for ii = 1:nFeature%#1
            InputsDeNormal(:,ii) = DeNormalize_Fcn(InputsNormal(:,ii),MinInputsNormal(ii),MaxInputsNormal(ii),MinInputs(ii),MaxInputs(ii));%#1
        end%#1
% Target Data DeNormalizing%#1
        MinTargetsNormal = min(TargetsNormal);%#1
        MaxTargetsNormal = max(TargetsNormal);%#1
        TargetsDeNormal = TargetsNormal;%#1
        for i = 1:TargetsNum%#1
            TargetsDeNormal(:,i) = DeNormalize_Fcn(TargetsNormal(:,i),MinTargetsNormal(i),MaxTargetsNormal(i),MinTargets(i),MaxTargets(i));%#1
        end%#1
% Train Target Data DeNormalizing%#1
        MinYtr = min(TrainData.Targets);%#1
        MaxYtr = max(TrainData.Targets);%#1
        TrainData.TargetsDeNormal = TrainData.Targets;%#1
        for i = 1:TargetsNum%#1
            TrainData.TargetsDeNormal(:,i) = DeNormalize_Fcn(TrainData.Targets(:,i),MinYtr(i),MaxYtr(i),MinTargets(i),MaxTargets(i));%#1
        end%#1
% TrainData.ANFISOutputs DeNormalizing%#1
        MinYtrANFIS = min(TrainData.ANFISOutputs);%#1
        MaxYtrANFIS = max(TrainData.ANFISOutputs);%#1
        TrainData.ANFISOutputsDeNormal = TrainData.ANFISOutputs;%#1
        for i = 1:size(TrainData.ANFISOutputs,2)%#1
            TrainData.ANFISOutputsDeNormal(:,i) = DeNormalize_Fcn(TrainData.ANFISOutputs(:,i),MinYtrANFIS(i),MaxYtrANFIS(i),MinTargets(i),MaxTargets(i));%#1
        end%#1
% Test Target Data DeNormalizing%#1
        MinYts = min(TestData.Targets);%#1
        MaxYts = max(TestData.Targets);%#1
        TestData.TargetsDeNormal = TestData.Targets;%#1
        for i = 1:TargetsNum%#1
            TestData.TargetsDeNormal(:,i) = DeNormalize_Fcn(TestData.Targets(:,i),MinYts(i),MaxYts(i),MinTargets(i),MaxTargets(i));%#1
        end%#1
% TestData.ANFISOutputs DeNormalizing%#1
        MinYtsANFIS = min(TestData.ANFISOutputs);%#1
        MaxYtsANFIS = max(TestData.ANFISOutputs);%#1
        TestData.ANFISOutputsDeNormal = TestData.ANFISOutputs;%#1
        for i = 1:size(TestData.ANFISOutputs,2)%#1
            TestData.ANFISOutputsDeNormal(:,i) = DeNormalize_Fcn(TestData.ANFISOutputs(:,i),MinYtsANFIS(i),MaxYtsANFIS(i),MinTargets(i),MaxTargets(i));%#1
        end%#1
    case Option{2}%#1
        TrainData.TargetsDeNormal = TrainData.Targets;%#1
        TrainData.ANFISOutputsDeNormal = TrainData.ANFISOutputs;%#1        
        TestData.TargetsDeNormal = TestData.Targets;%#1
        TestData.ANFISOutputsDeNormal = TestData.ANFISOutputs;%#1
end%#1
%% 8 - Assesment%#1
ResultsTrain = EvaluatePlot(TrainData,'Train','Results');%#1
ResultsTest  = EvaluatePlot(TestData,'Test','Results');%#1
%% 9 - Export Predicted Targets%#1 
OUT = zeros(nSamples,1);
OUT(trIndex,1) = TrainData.ANFISOutputsDeNormal;%#1
OUT(tsIndex,1) = TestData.ANFISOutputsDeNormal;%#1
Header = {'Predicted_by_ANFIS'};%#1
xlswrite('DATA.xls',Header,'O1:O1');%#1
xlswrite('DATA.xls',OUT,['O2:O' num2str(nSamples+1)]);%#1
AllData.TargetsDeNormal = Data(:,14);%#1
AllData.ANFISOutputsDeNormal = OUT;%#1
AllData.ANFISOutputs = OUT;%#1
ResultsAll = EvaluatePlot(AllData,'All-Data','Results');%#1
%% 10 - Export the Train & Test Data-set and Save the Results%#1
save('Results\ANFIS_MATLAB_Output_File.mat');%#1
