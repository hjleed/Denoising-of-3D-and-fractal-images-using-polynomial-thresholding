function display3DImage (filename)
% example: filename = 'mangosample_colin1.1 (2).nii'
image3DProfile = load_nii(filename);  % load 3D image
image3D = image3DProfile.img;   % obtain the 3D image file

% figure,imshow(log(1+0.0001*double(image3D(:,:,35))));        % display slice-wise

[rowSize columnSize numberOfSlices] = size(image3D);
transparencyLevel = 0.3;
stepSizeAlongTheZaxis = 0.01;
delayInSecs = 1;    % for display each slice

figure
colormap(gray); % set the color
hold on;

for i=1:numberOfSlices    
    % slicedImage = image3D(:,:,i);   % obtain a slice
    slicedImage = log(1+0.0001*double(image3D(:,:,i)));
    
    surface('XData',[0 1;0 1],...
        'YData',[0 0;1 1],...
        'ZData',i*[stepSizeAlongTheZaxis stepSizeAlongTheZaxis; stepSizeAlongTheZaxis stepSizeAlongTheZaxis],...
        'CData', double(slicedImage),...
        'FaceColor','texturemap');
    
    movieFrames(i)=getframe;       % record the frame

    alpha(transparencyLevel);     % This will make transparent
    pause(delayInSecs);
end
view(3);

movie(movieFrames);     % play the movie
%movie2avi(movieFrames, 'brainScan.avi');

fileToSaveTo = 'brain3D.mat';
save(fileToSaveTo, 'image3D');

end

