clc;
clear all;

numberOfSlices = 12;
a=ones(128,128, numberOfSlices);
czr=zeros(size(a));
czi=czr;
c1=dftmtx(128);    
cr=real(c1);
ci=imag(c1);
%figure,imshow(cr);
%figure,imshow(ci);

for k=1:numberOfSlices
   if(mod(k,2)==0)
           czr(:,:,k)=cr';
           czi(:,:,k)=ci.';
   else
       czr(:,:,k)=cr.';
       czi(:,:,k)=ci';
   end
end

for k=1:numberOfSlices
   for i=1:128
       for j=1:128
               czr(i,j,:)=real(fft(czr(i,j,:)));
               czi(i,j,:)=real(fft(czi(i,j,:)));
       end
   end
    % create the stacks/ slices into gif
    createTIF_file( czr(:,:,k), k );
end


fileToSaveTo = 'fft3D_real.mat';
save(fileToSaveTo, 'czr');

fileToSaveTo = 'fft3D_imaginary.mat';
save(fileToSaveTo, 'czi');
    
