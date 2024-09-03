function xN = Normalize_Fcn(x,MinX,MaxX,a,b)%#1
% xN = (x - MinX) / (MaxX - MinX);%#2
xN = (x - MinX) / (MaxX - MinX) * (b-a) + a;%#3
end%#4
