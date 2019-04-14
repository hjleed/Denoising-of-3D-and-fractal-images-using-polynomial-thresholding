function rec3d = idwt3(c000,c001,c010,c011,c100,c101,c110,c111,name)

% perform inverse 1D wavelet transform "into the slice"
for m=1:size(c000,1)
    for n=1:size(c000,2)
       cA(m,n,:)= idwt(c000(m,n,:),c001(m,n,:),name);
       cH(m,n,:)= idwt(c010(m,n,:),c011(m,n,:),name);
       cV(m,n,:)= idwt(c100(m,n,:),c101(m,n,:),name);
       cD(m,n,:)= idwt(c110(m,n,:),c111(m,n,:),name);
    end

end

% perform inverse 2D wavelet transform slice-wise
for k=1:size(cA,3)
    rec3d(:,:,k)=idwt2(cA(:,:,k),cH(:,:,k),cV(:,:,k),cD(:,:,k),name);
end