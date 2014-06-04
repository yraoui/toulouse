%ce programme calcul les points d'interet d'une image en couleur en se
%basant sur le detecteur harris Affine de cordelia schmid et un programme
%qui permet de faire la detection des points et l'adaptation de la forme
 
 
%la représentation dans l'espace Gaussian

function  [pos, pos_avecdetail]=program(in)

[e,el,ell]=RGB2E(in);
f=e;
kparam=0.04;
sxl2=4;
sxi2=2*sxl2;
pointtype=1;

L=mydiscgaussfft(extend2(f,4,4),sxl2);
Lx=crop2(filter2(dxmask,L,'same'),4,4)*sxl2^(1/2);
Ly=crop2(filter2(dymask,L,'same'),4,4)*sxl2^(1/2);

Lxm2=Lx.*Lx;
Lym2=Ly.*Ly;
Lxmy=Lx.*Ly;
 
Lxm2smooth=mydiscgaussfft(Lxm2,sxi2);
Lym2smooth=mydiscgaussfft(Lym2,sxi2);
Lxmysmooth=mydiscgaussfft(Lxmy,sxi2);
 
if pointtype==1 % det(H) points
  Lxx=crop2(filter2(dxxmask,L,'same'),4,4)*sxl2;
  Lxy=crop2(filter2(dxymask,L,'same'),4,4)*sxl2;
  Lyy=crop2(filter2(dyymask,L,'same'),4,4)*sxl2;
  cimg=abs(Lxx.*Lyy-Lxy.^2);
end
 
 
 
 
[ysize, xsize]=size(f);
[position,value,z]=locmax8(cimg);
 


 [sv,si]=sort(-value);
  sv=sv(1:200,:);
   si=si(1:200,:);
  pxall=position(:,2);
  pyall=position(:,1);
  npoints=length(si)
 px=pxall(si(1:min(npoints,length(si))));
 py=pyall(si(1:min(npoints,length(si))));
 ind=sub2ind([ysize xsize],py,px);
   
   
 c11=Lxm2smooth(ind);
  c12=Lxmysmooth(ind);
  c22=Lym2smooth(ind);
 
pos1=[px py];

f=el;
kparam=0.04;
sxl2=4;
sxi2=2*sxl2;
pointtype=1;

L=mydiscgaussfft(extend2(f,4,4),sxl2);
Lx=crop2(filter2(dxmask,L,'same'),4,4)*sxl2^(1/2);
Ly=crop2(filter2(dymask,L,'same'),4,4)*sxl2^(1/2);
Lxm2=Lx.*Lx;
Lym2=Ly.*Ly;
Lxmy=Lx.*Ly;
 
Lxm2smooth=mydiscgaussfft(Lxm2,sxi2);
Lym2smooth=mydiscgaussfft(Lym2,sxi2);
Lxmysmooth=mydiscgaussfft(Lxmy,sxi2);
 
if pointtype==1 % harris points  
  detC=(Lxm2smooth.*Lym2smooth)-(Lxmysmooth.^2);
  trace2C=(Lxm2smooth+Lym2smooth).^2;
    %kparam=0.04;
  cimg=detC-kparam*trace2C;
end
 
 
% if pointtype==3 % det(H) points
%   Lxx=crop2(filter2(dxxmask,L,'same'),4,4)*sxl2;
%   Lxy=crop2(filter2(dxymask,L,'same'),4,4)*sxl2;
%   Lyy=crop2(filter2(dyymask,L,'same'),4,4)*sxl2;
%   cimg=abs(Lxx.*Lyy-Lxy.^2);
% end
 
 
 
 
[ysize, xsize]=size(f);
[position,value,z]=locmax8(cimg);
 
 [sv,si]=sort(-value);
  sv=sv(1:200,:);
   si=si(1:200,:);
  pxall=position(:,2);
  pyall=position(:,1);
  npoints=length(si)
 px=pxall(si(1:min(npoints,length(si))));
  py=pyall(si(1:min(npoints,length(si))));
   ind=sub2ind([ysize xsize],py,px);
   
   
  c11=Lxm2smooth(ind);
  c12=Lxmysmooth(ind);
  c22=Lym2smooth(ind);
 
  pos2=[px py];
  
  
%
f=ell;
kparam=0.04;
sxl2=4;
sxi2=2*sxl2;
pointtype=1;

L=mydiscgaussfft(extend2(f,4,4),sxl2);
Lx=crop2(filter2(dxmask,L,'same'),4,4)*sxl2^(1/2);
Ly=crop2(filter2(dymask,L,'same'),4,4)*sxl2^(1/2);
Lxm2=Lx.*Lx;
Lym2=Ly.*Ly;
Lxmy=Lx.*Ly;
 
Lxm2smooth=mydiscgaussfft(Lxm2,sxi2);
Lym2smooth=mydiscgaussfft(Lym2,sxi2);
Lxmysmooth=mydiscgaussfft(Lxmy,sxi2);
 
if pointtype==1 % harris points  
  detC=(Lxm2smooth.*Lym2smooth)-(Lxmysmooth.^2);
  trace2C=(Lxm2smooth+Lym2smooth).^2;
    %kparam=0.04;
  cimg=detC-kparam*trace2C;
end
 
 
% if pointtype==3 % det(H) points
%   Lxx=crop2(filter2(dxxmask,L,'same'),4,4)*sxl2;
%   Lxy=crop2(filter2(dxymask,L,'same'),4,4)*sxl2;
%   Lyy=crop2(filter2(dyymask,L,'same'),4,4)*sxl2;
%   cimg=abs(Lxx.*Lyy-Lxy.^2);
% end
 
[ysize, xsize]=size(f);
[position,value,z]=locmax8(cimg);
 
  [sv,si]=sort(-value);
  sv=sv(1:200,:);
  si=si(1:200,:);
  pxall=position(:,2);
  pyall=position(:,1);
  npoints=length(si)
  px=pxall(si(1:min(npoints,length(si))));
  py=pyall(si(1:min(npoints,length(si))));
  ind=sub2ind([ysize xsize],py,px);
   
   
 c11=Lxm2smooth(ind);
 c12=Lxmysmooth(ind);
 c22=Lym2smooth(ind);
 
  pos3=[px py];
 
  
 pos=[pos1,pos2,pos3];




  pos_avecdetail=[px py sxl2*ones(size(px)) c11 c12 c12 c22];


























	
