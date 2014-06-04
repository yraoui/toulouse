function showellipticfeatures(pos,fcol,flag)

%
% showellipticfeatures(pos,fcol)
%

if nargin<2 fcol=[0 0 1]; end
if nargin<3 flag=0; end

hold on;
for i=1:size(pos,1)
  x0=pos(i,1); y0=pos(i,2);
  % h=drawellipse_cov(1,[x0 y0],flag);

  %set(h,'Color',fcol)
  h=plot(x0,y0,'b+');
  %set(h,'Color',fcol)
  
  
   
  
end

pause(0.1)
