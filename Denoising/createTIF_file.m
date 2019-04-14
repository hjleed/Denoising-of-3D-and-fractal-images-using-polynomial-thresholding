function createTIF_file( image2D, sliceIndex, folderPath )
%CREATETIF_FILE 

        % save each slice as tif
            if (sliceIndex < 10)
                numberIndexOfFile = strcat('00', num2str(sliceIndex));
            elseif ((sliceIndex >= 10) && (sliceIndex < 100) )
                numberIndexOfFile = strcat('0', num2str(sliceIndex));
            else
                numberIndexOfFile = num2str(sliceIndex);
            end   
                
        %filename = strcat('./images2/image', numberIndexOfFile,'.tif');
        %filename = strcat('./springStructureNoisyImages/image', numberIndexOfFile,'.tif');
        filename = strcat(folderPath, 'image', numberIndexOfFile,'.tif');
        imwrite(image2D, filename,'tif');  % create the image tifs
end

