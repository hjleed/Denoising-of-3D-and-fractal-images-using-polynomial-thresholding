function [c000,c001,c010,c011,c100,c101,c110,c111] = dwt3(arr3d,name)
% DWT forward
%   

% perform 2D wavelet transform slice-wise
for k=1:size(arr3d,3)
    [cA(:,:,k),cH(:,:,k),cV(:,:,k),cD(:,:,k)] = dwt2(arr3d(:,:,k),name);
end

% perform 1D wavelet transform "into the slice"
for m=1:size(cA(:,:,1),1)
    for n=1:size(cA(:,:,1),2)
        [c000(m,n,:),c001(m,n,:)]=dwt(cA(m,n,:),name);
        [c010(m,n,:),c011(m,n,:)]=dwt(cH(m,n,:),name);
        [c100(m,n,:),c101(m,n,:)]=dwt(cV(m,n,:),name);
        [c110(m,n,:),c111(m,n,:)]=dwt(cD(m,n,:),name);
    end
end

