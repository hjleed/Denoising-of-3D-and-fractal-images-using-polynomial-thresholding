function frac3d=kron3(frac, arr3d)

for i=1:size(arr3d,3)
    frac3d(:,:,i)=kron(arr3d(:,:,i),frac);
end
end