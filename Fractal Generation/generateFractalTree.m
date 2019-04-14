function generateFractalTree()
%GENERATEFRACTALTREE 

% m. file to generate Fractal
% Kurtis Sampson
% Concept:
% Martix A contains the line segement to plot
% Each initeration the line segements are read from S F to S1 F1
% then the transformation performed, which perduces more line segements
% which is stuffed back to S F. S F will grow at a rate of the number of transforms.
%clear plot
clf
d=sin(pi/4);
e=cos(pi/4)
% Define transforms
a1=[.5 0;0 .5]
b1=[0 0;0 0]
% creates the rotation
a2=[.5*d -.5*e;
    .5*e .5*d]
b2=[0 0;0 10]
a3=[.5*d .5*e;
    -.5*e .5*d]
b3=[0 0;0 10]
a4=[.5 0;0 0.5]
b4=[0 0;0 5]
%S=[0 0]
%F=[0 10]

S1=[]
F1=[]
%Plot starting line
line([S(1) F(1)],[S(2) F(2)],'Color','r')
%dummy=input('any key to continue')

levels = 6;

for n=1:levels
%Move to working matrix
S1=S;F1=F;
temp=[]
%First transform
%Replicate offset
temp=ones(size(S,1),2)*b1';

%Calculate start
S=a1*S1'+temp';
S=S';
%Calculate end
F=a1*F1'+temp';
F=F';
% Next transform
%Replicate offset
temp=ones(size(S,1),2)*b2';
%Calculate start
S2=a2*S1'+temp';
S2=S2';
%Calculate end
F2=a2*F1'+temp';
F2=F2';
% Next transform
%Replicate offset
temp=ones(size(S,1),2)*b3';
%Calculate start
S3=a3*S1'+temp';
S3=S3';
%Calculate end
F3=a3*F1'+temp';
F3=F3';
% Next transform
%Replicate offset
temp=ones(size(S,1),2)*b4';
%Calculate start
S4=a4*S1'+temp';
S4=S4';
%Calculate end
F4=a4*F1'+temp';
F4=F4';
%Add back to matrix
S=[S;S2;S3;S4];
F=[F;F2;F3;F4];

colorPalette = ['y', 'm', 'c', 'r', 'g', 'b', 'w', 'k'];

% color the branch
for i=1:size(S,1)
    line([S(i,1) F(i,1)],[S(i,2) F(i,2)],'Color', colorPalette(mod(i, length(colorPalette))+1) );
    
    %{
    if (mod(i,4) == 0)
        line([S(i,1) F(i,1)],[S(i,2) F(i,2)],'Color','g');
    elseif (mod(i,4) == 1)
        line([S(i,1) F(i,1)],[S(i,2) F(i,2)],'Color','b');    
    elseif (mod(i,4) == 3)
        line([S(i,1) F(i,1)],[S(i,2) F(i,2)],'Color','r');
    else 
        ; % NOP
    end
    %}
end
%dummy=input('k')

%clf
end


end

