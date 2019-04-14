%folderToLoadFrom = './OriginalPurkinje_portion/'
%folderToLoadFrom = './Brain/'

%cd(folderToLoadFrom);                   % go to folder
listOfJpegs = dir('*.tif');

listOfNumberOfJpegs = length(listOfJpegs);  % slices

image3D = [];
for i=1:listOfNumberOfJpegs 
      image2D = imread(listOfJpegs(i).name);
      image3D(:,:,i) = image2D;
end

cd('..');                               % return to operating folder

%matFileToWriteTo = 'OriginalPurkinjeNoisy3D.mat';
matFileToWriteTo = 'imagNewBrainDenoised.mat';
save(matFileToWriteTo, 'image3D');
