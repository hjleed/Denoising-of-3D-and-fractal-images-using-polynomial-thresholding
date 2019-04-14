function subkoch(xl,xr,yl,yr,level,r)
%Zeichne eine Linie auf der niedrigsten Level der Rekursion
if (level<2)
    
    % randomize the color
colorPalette = ['y', 'm', 'c', 'r', 'g', 'b', 'w', 'k'];
upperCombo = length(colorPalette);
lowerCombo = 1;
selectCombo = round(rand(1,1)*(upperCombo-lowerCombo)+1);
chosenColor = colorPalette(selectCombo);    
    
    % plot([xl(1) xr(1)],[-yl(1) -yr(1)],'b-')
    plot([xl(1) xr(1)],[-yl(1) -yr(1)], strcat(chosenColor, '-'))
return
end

%Verzweige in niedrigere Stufen
level=level-1;
%Linker Zweig
xl(level)=xl(level+1);
yl(level)=yl(level+1);
xr(level)=1/3*xr(level+1)+2/3*xl(level+1);
yr(level)=1/3*yr(level+1)+2/3*yl(level+1);
subkoch(xl,xr,yl,yr,level,r);
%Mittlerer linker Zweig
xl(level)=xr(level);
yl(level)=yr(level);
xr(level)=.5*xr(level+1)+.5*xl(level+1)-r*(yl(level+1)-yr(level+1));
yr(level)=.5*yr(level+1)+.5*yl(level+1)+r*(xl(level+1)-xr(level+1));
subkoch(xl,xr,yl,yr,level,r);
%Mittlerer rechter Zweig
xl(level)=xr(level);
yl(level)=yr(level);
xr(level)=2/3*xr(level+1)+1/3*xl(level+1);
yr(level)=2/3*yr(level+1)+1/3*yl(level+1);
subkoch(xl,xr,yl,yr,level,r);
%Rechter Zweig
xl(level)=xr(level);
yl(level)=yr(level);
xr(level)=xr(level+1);
yr(level)=yr(level+1);
subkoch(xl,xr,yl,yr,level,r);
level=level+1;

return;
