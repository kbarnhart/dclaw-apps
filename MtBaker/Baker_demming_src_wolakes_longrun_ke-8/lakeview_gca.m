	

camtarg=[5.61e5,5.1792e6,370]+[0,500,0];
r = 2200.0;
rang = deg2rad*(180.0+10);
campos =camtarg + [r*cos(rang),r*sin(rang),r*sin(15*deg2rad)];
camang = [35];



set(gca, ...
     'CameraPosition' , campos , ...
     'CameraPositionMode' , 'manual', ...
     'CameraTarget' , camtarg , ...
     'CameraTargetMode' , 'manual', ...
     'CameraUpVector' , [0 0 1], ...
 	 'CameraUpVectorMode' , 'auto', ...
 	 'CameraViewAngle' , camang, ...
 	 'CameraViewAngleMode' , 'manual', ...
     'DataAspectRatio' , [1 1 1], ...
     'OuterPosition' , [0 0 1 1], ...
     'PlotBoxAspectRatio' , [1 1 1], ...
     'PlotBoxAspectRatioMode' , 'manual', ...
     'Projection' , 'perspective', ...
     'Position' , [0.13 0.11 0.775 0.815])%, ...

xs = camtarg(1);
ys = camtarg(2)+500;
zs = camtarg(3)+400;
hours = floor(t/3600.);
minutes = floor((t-3600*hours)/60.);
seconds = t-3600*hours - 60*minutes;
secondsstr=sprintf('%0.0f',seconds + 100);
hoursstr = sprintf('%0.0f', hours + 100);
minutesstr = sprintf('%0.0f',minutes + 100);
tstr = ['t = ',hoursstr(2:end),':',minutesstr(2:end),':',secondsstr(2:end)];
%tstr = ['t = ',num2str(t-0*10), ' s'];
text(xs,ys,zs,tstr,'fontsize',26);
axis off;