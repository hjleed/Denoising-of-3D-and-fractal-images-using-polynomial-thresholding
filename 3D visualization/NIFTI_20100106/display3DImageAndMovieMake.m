function display3DImageAndMovieMake (filename)
% example: filename = 'mangosample_colin1.1 (2).nii'

%fileToLoadFrom = 'brain3D_denoisedImage.mat';
%fileToLoadFrom = 'brain3D_contaminatedImage.mat';
%fileToLoadFrom = 'brain3D_compressed.mat';
fileToLoadFrom = filename;

image3D = load(fileToLoadFrom);
%image3D = image3D.denoisedImage;      % obtain the object from the struct
%image3D = image3D.image3DWithNoise;      % obtain the object from the struct
%image3D = image3D.image3Dcompressed;       % obtain the object from the struct
image3D = image3D.rec3d;

% figure,imshow(log(1+0.0001*double(image3D(:,:,35))));        % display slice-wise

[rowSize columnSize numberOfSlices] = size(image3D);
transparencyLevel = 0.2; % 0.2;
stepSizeAlongTheZaxis = 0.01;
delayInSecs = 2;    % for display each slice

figure
colormap('gray'); % set the color
%colormap('bone'); % set the color
%colormap('jet'); % set the color
%colormap('copper'); % set the color
hold on;

for i=1:numberOfSlices    
    % slicedImage = image3D(:,:,i);   % obtain a slice
    slicedImage = log(1+0.000001*(image3D(:,:,i)));
    %slicedImage = log(1+0.0001*(image3D(:,:,i)));
    
    surface('XData',[0 1;0 1],...
        'YData',[0 0;1 1],...
        'ZData',i*[stepSizeAlongTheZaxis stepSizeAlongTheZaxis; stepSizeAlongTheZaxis stepSizeAlongTheZaxis],...
        'CData', double(slicedImage),...
        'EdgeColor', 'none','FaceColor','texturemap');
        %'FaceColor','texturemap');        
    
        alpha(transparencyLevel);     % This will make transparent
        
    movieFrames(i)=getframe;       % record the frame

    %alpha(transparencyLevel);     % This will make transparent
    pause(delayInSecs);
end
view(3);


%{
phandles = contourslice(image3D,[],[],[1:numberOfSlices ],1);
view(3); axis tight
set(phandles,'LineWidth',2)
%}  
    

%movie(movieFrames);     % play the movie
%movie2avi(movieFrames, 'deNoisedBrainScan.avi');
%movie2avi(movieFrames, 'noisyBrainScan.avi');
%movie2avi(movieFrames, 'compressedBrainScan.avi');

end

