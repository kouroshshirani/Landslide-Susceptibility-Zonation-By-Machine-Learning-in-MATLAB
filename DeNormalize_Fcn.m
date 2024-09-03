function X = DeNormalize_Fcn(xN,MinX,MaxX,a,b)%1
    X = (xN - MinX) / (MaxX - MinX) * (b-a) + a; %2   
end %3
