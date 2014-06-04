

x0=pos1(2,1); y0=pos1(2,2);
points=linspace(0,2*pi,100);   
%T=[sin(angle) cos(angle); -cos(angle) sin(angle)];
ell=(0.1*[cos(points)' sin(points)']')';
ell(:,1)=ell(:,1)+pos1(1);
ell(:,2)=ell(:,2)+pos1(2);

h=plot(ell(:,1),ell(:,2),'LineWidth',1.5);
%plot(ell(:,1),ell(:,2))