clear all;
clc;

[x,y] = meshgrid(-2:0.05:2,-2:0.05:2);

 r = sqrt(x.^2 + y.^2); 
 z = cos(10.*r).*exp(-r);
 
 surf(x,y,z);
 shading interp;
 
 %surf(x,y,z,'EdgeColor','none');
 
 % ====================================================
 
 % format the solid into a 3D array
 numberOfSlices = 100;
 Xcoordinates = x(1,:);
 Ycoordinates = y(:,1)';
 Zcoordinates = linspace(-2, 2, numberOfSlices);
 
 magnitudeAtTheCoordinates = zeros(length(Xcoordinates), length(Ycoordinates), numberOfSlices);
 for k=1:length(Zcoordinates)
    for i=1:length(Xcoordinates)
        for j=1:length(Ycoordinates)        
            
            %% spherical emcompassing
%             locationByPolar = sqrt((Xcoordinates(i))^2 + (Ycoordinates(j))^2 + (Zcoordinates(k))^2);
%             magnitudeAtTheCoordinates(i,j,k) = cos(10*locationByPolar)*exp(-locationByPolar);            
                        
            
             
            %% carnation                  
%             locationByPolar = sqrt((Xcoordinates(i))^2 + (Ycoordinates(j))^2) + Zcoordinates(k);            
%             magnitudeAtTheCoordinates(i,j,k) = cos(10*locationByPolar)*exp(-locationByPolar); 
                                    
            % spring structure                   
            locationByPolar = sqrt((Xcoordinates(i))^2 + (Ycoordinates(j))^2) + sin(50*Zcoordinates(k));            
            magnitudeAtTheCoordinates(i,j,k) = cos(10*locationByPolar)*exp(-locationByPolar/100); 
            

            %locationByPolar = (sqrt(((Xcoordinates(i)/5)^2 *(Ycoordinates(j)/10)^2 *(Zcoordinates(k)/3)^2))) * sign(Xcoordinates(i))* sign(Ycoordinates(j))* sign(Zcoordinates(k));
            %magnitudeAtTheCoordinates(i,j,k) = cos(10*locationByPolar)*exp(-locationByPolar);    

        end
    end
        createTIF_file(magnitudeAtTheCoordinates(:,:,k), k);
 end
 
 %fileToSaveTo = 'ripple3D.mat';
 %fileToSaveTo = 'sphericalStructure.mat';
 %save(fileToSaveTo, 'magnitudeAtTheCoordinates');
 
 
 % dope the image with noise
 for i=1:numberOfSlices    
    image3DWithNoise(:,:,i) = imnoise(magnitudeAtTheCoordinates(:,:,i),'gaussian',0, 1.5);
 end
  fileToSaveTo = 'springStructureNoisy.mat';
 save(fileToSaveTo, 'image3DWithNoise');