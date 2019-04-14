%function denoisedImage3D = denoise3D( image3D )
%DENOISE3D 
clc;
clear all;

fileToLoadFrom = 'real.mat';
image3D = load(fileToLoadFrom);
image3D = image3D.czrx;      % obtain the object from the struct

[rowSize columnSize numberOfSlices] = size(image3D);

image3DWithNoise = zeros(rowSize, columnSize, numberOfSlices);

% contamination the 3D image slice-wise
for i=1:numberOfSlices    
    image3DWithNoise(:,:,i) = imnoise(image3D(:,:,i),'gaussian',0,0.01);
end

% display slice-wise
% figure,imshow(log(1+0.0001*double(image3D(:,:,35))));  
selectedSlice = 35;
%figure,imshow(image3D(:,:, selectedSlice));       
%figure,imshow(image3DWithNoise(:,:, selectedSlice));       

fileToSaveTo = 'real_contaminatedImage.mat';
save(fileToSaveTo, 'image3DWithNoise');

% =========================================
n=1;    % levels of decomposition
numberOfCoefficients = 5;
levelOfThreshold = 1.2;
initialApproxThreshold =1.2;

portionOfAllSlices = 10;
denoisedImage = zeros(rowSize, columnSize, portionOfAllSlices);

image3DWithNoise_Portion = zeros(rowSize, columnSize, portionOfAllSlices);
image3D_Portion = zeros(rowSize, columnSize, portionOfAllSlices);

image3D_Portion = image3D;
image3DWithNoise_Portion = image3DWithNoise;

%for i=1:numberOfSlices
% extra portion of the 3D
%disp('Extraction In Process ... ');
% for i=60:60+portionOfAllSlices
%     %{
%   denoising(i, n, image3DWithNoise, image3D, ...
%                 numberOfCoefficients, levelOfThreshold, ...
%                 magnifyingScaleFactor, initialApproxThreshold, denoisedImage);
%     %}
%     
%     image3DWithNoise_Portion(:,:,i-59) = image3DWithNoise(:,:,i);
%     image3D_Portion(:,:,i-59) = image3D(:,:,i);    
% end
% disp('Extraction  END');

% ============================ [ commence denoising ] ============================ 
waveletType = 'haar';
arr3d = image3D_Portion;
arr3dn=image3DWithNoise_Portion;
arr3dx=arr3d;
arr3dnx=arr3dn;
% wavelet forward
[c000,c001,c010,c011,c100,c101,c110,c111] = dwt3(arr3dx, waveletType);
[cn000,cn001,cn010,cn011,cn100,cn101,cn110,cn111] = dwt3(arr3dnx, waveletType);


% [START:   denoise portion]
    % magnify the low frequency components
    
    a=c000;
    a_opt=polyopt(c000,cn000,numberOfCoefficients);
    [dna, prepa] = polyth(c000, initialApproxThreshold, a_opt);
     
    c001_opt=polyopt(c001,cn001,numberOfCoefficients);
    [dnc001 , prepc001] = polyth(cn001, levelOfThreshold, a_opt);
    
    a_opt=polyopt(cn001,c001,numberOfCoefficients);
    [dnc001, prepc001] = polyth(cn001, levelOfThreshold, a_opt);
     
    a_opt=polyopt(c010,cn010,numberOfCoefficients);
    [dnc010 , prepc010] = polyth(cn010, levelOfThreshold, a_opt);
  
    a_opt=polyopt(c011,cn011,numberOfCoefficients);
    [dnc011 , prepc011] = polyth(cn011, levelOfThreshold, a_opt);
  
    a_opt=polyopt(c100,cn100,numberOfCoefficients);
    [dnc100 , prepc100] = polyth(cn100, levelOfThreshold, a_opt);
  
    a_opt=polyopt(c101,cn101,numberOfCoefficients);
    [dnc101 , prepc101] = polyth(cn101, levelOfThreshold, a_opt);
  
    a_opt=polyopt(c110,cn110,numberOfCoefficients);
    [dnc110 , prepc110] = polyth(cn110, levelOfThreshold, a_opt);
  
    a_opt=polyopt(c111,cn111,numberOfCoefficients);
    [dnc111 , prepc111] = polyth(cn111, levelOfThreshold, a_opt);
  
    
    dnAm=(reshape(dna,size(a,1),size(a,2),size(a,3)));
    dnc001m=(reshape(dnc001,size(a,1),size(a,2),size(a,3)));   
    dnc010m=(reshape(dnc010,size(a,1),size(a,2),size(a,3)));   
    dnc011m=(reshape(dnc011,size(a,1),size(a,2),size(a,3)));   
    dnc100m=(reshape(dnc100,size(a,1),size(a,2),size(a,3)));   
    dnc101m=(reshape(dnc101,size(a,1),size(a,2),size(a,3)));   
    dnc110m=(reshape(dnc110,size(a,1),size(a,2),size(a,3)));   
    dnc111m=(reshape(dnc111,size(a,1),size(a,2),size(a,3)));   
 
    %{
    dnAm=(exp(dnAm)-1)*1000;
    dnc001m=(exp(dnc001m)-1)*1000; 
    dnc010m=(exp(dnc010m)-1)*1000; 
    dnc011m=(exp(dnc011m)-1)*1000; 
    dnc100m=(exp(dnc100m)-1)*1000; 
    dnc101m=(exp(dnc101m)-1)*1000; 
    dnc110m=(exp(dnc110m)-1)*1000; 
    dnc111m=(exp(dnc111m)-1)*1000; 
    %}
% [END:   denoise portion]

% wavelet inverse
%recImage3D = idwt3(c000,c001,c010,c011,c100,c101,c110,c111, waveletType);
%recDenoisedImage3D = idwt3(cn000,cn001,cn010,cn011,cn100,cn101,cn110,cn111, waveletType);
rec3dx=idwt3(dnAm,dnc001m,dnc010m,dnc011m,dnc100m,dnc101m,dnc110m,dnc111m,waveletType);
disp('Denoising END');

%fileToSaveTo = 'brain3D_PortionDenoisedImage.mat';
%save(fileToSaveTo, 'recDenoisedImage3D'); % reconstructed

%fileToSaveTo = 'brain3D_PortionOriginalDenoisedImage.mat';
%save(fileToSaveTo, 'recImage3D'); % original

% disp('Displaying each reconstructed slice.');
% for i=1:portionOfAllSlices
%     figure,
%     imshow(1.3*log(1+0.0000005*abs(rec3dx(:,:,i)))); 
% end

mkdir('./DenoisedImages1/');

for i=1:numberOfSlices
     %createTIF_file( 1.3*log(double(1+0.0000009*abs(image3D(:,:,i)))), i );
     image2D = 3.75*log(1+0.09*abs(rec3dx(:,:,i)));
     createTIF_file( image2D, i, './DenoisedImages1/');
end

%end

