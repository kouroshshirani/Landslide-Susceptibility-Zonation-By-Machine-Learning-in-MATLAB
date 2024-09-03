function fis=CreateInitialFIS(Data,nCluster)%#1
if ~exist('nCluster','var')%#1
        nCluster='auto';%#1
    end%#1 
    x=Data.Inputs;%#1
    t=Data.Targets;%#1
    fcm_U=2;%#1
    fcm_MaxIter=100;%#1
    fcm_MinImp=1e-5;%#1
    fcm_Display=false;%#1
    fcm_options=[fcm_U fcm_MaxIter fcm_MinImp fcm_Display];%#1
    fis=genfis3(x,t,'sugeno',nCluster,fcm_options);%#1 
end

