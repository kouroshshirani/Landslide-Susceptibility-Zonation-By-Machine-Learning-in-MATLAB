function fis=TrainUsingANFIS(fis,TrainData)%#1 
    x = TrainData.Inputs;%#1
    t = TrainData.Targets;%#1    
    train_Epoch=200;%#1
    train_ErrorGoal=0;%#1
    train_InitialStepSize=0.01;%#1
    train_StepSizeDecrease=0.9;%#1
    train_StepSizeIncrease=1.1;%#1
    TrainOptions=[train_Epoch train_ErrorGoal train_InitialStepSize train_StepSizeDecrease train_StepSizeIncrease];%#1
    display_Info=false;%#1
    display_Error=false;%#1
    display_StepSize=false;%#1
    display_Final=false;%#1
    DisplayOptions=[display_Info display_Error display_StepSize display_Final];%#1 
    OptMethod.Hybrid=1;%#1
    OptMethod.Backpropagation=0;%#1 
    fis=anfis([x,t],fis,TrainOptions,DisplayOptions,[],OptMethod.Hybrid);%#1 
end%#1