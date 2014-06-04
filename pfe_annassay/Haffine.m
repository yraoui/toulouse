f=imread('image.jpg');  
[ysize,xsize]=size(f);
[e,el,ell]=RGB2E(f);
f=e;
iter=0;
possel=pos_d;
posinit(4)=1;
posinit(5)=0;
posinit(6)=0;
posinit(7)=1;
pointtype=1;
sx=2*sxl2;
while ~((  (~(iter==0)))

  iter=iter+1;

px=possel(1,1);
py=possel(1,2);
sxl2=possel(1,3);
c11=possel(1,4);
c12=possel(1,5);
c21=possel(1,6);
c22=possel(1,7);


Sigma=inv([c11 c12; c21 c22]);
Sigma=Sigma/sqrt(det(Sigma));
[v,d]=eig(Sigma);

Sigmanew=inv([possel(4) possel(5); possel(6) possel(7)]);
Sigmacorrinv=inv(Sigmanew)*inv(Sigma);
Q=max(abs(diag(d)))/min(abs(diag(d)));
brx=max(9,round(4*sqrt(sxl2)));
fcut=f(max(1,py-brx):min(ysize,py+brx),...
max(1,px-brx):min(xsize,px+brx));
cy=min(brx+1,py);
cx=min(brx+1,px);

   fcut=warpaffinefloat(fcut,Sigma,cx,cy);
   brx=max(9,round(4*sqrt(sxl2)));
   fcut=fcut(max(1,cy-brx):min(size(fcut,1),cy+brx),...
   max(1,cx-brx):min(size(fcut,2),cx+brx),:);
   cy=min(brx+1,cy);
   cx=min(brx+1,cx);
                             
    msz=(size(dxmask,1)-1)/2;
  L=mydiscgaussfft(fcut,sx);
  Lext=extend2(L,msz,msz);
  Lcut=Lext(cy:cy+2*msz,cx:cx+2*msz);
  
  
  
    prodmsize=prod(size(dxmask));
    Lxxval=sum(Lcut(:).*reshape(dxxmask,[prodmsize,1]));
    Lyyval=sum(Lcut(:).*reshape(dyymask,[prodmsize,1]));
    Lxxxxval=sum(Lcut(:).*reshape(dxxxxmask,[prodmsize,1]));
    Lxxyyval=sum(Lcut(:).*reshape(dxxyymask,[prodmsize,1]));
    Lyyyyval=sum(Lcut(:).*reshape(dyyyymask,[prodmsize,1]));
  
    % normalized Laplacian and its derivative w.r.t. scale
    lapval=(Lxxval+Lyyval)*sx;
    %lapsxval=sx*(Lxxval+Lyyval)+(sx^2/2)*(Lxxxxval+Lyyyyval+2*Lxxyyval);
    lapsxval=(Lxxval+Lyyval)+(sx/2)*(Lxxxxval+Lyyyyval+2*Lxxyyval);
    
       kparam=0.01;
    sxi2=2*sxl2;
    [pos,val]=intpointdet(fcut,kparam,sxl2,sxi2,pointtype,100);
 
    
    
    
           poscorr=(sqrtm(Sigma))*[transpose(pos(:,1)-cx); transpose(pos(:,2)-cy)];
         pos(:,1)=round(transpose(poscorr(1,:))+cx);
         pos(:,2)=round(transpose(poscorr(2,:))+cy);
  
        
        
        
         possel(4)=Sigmacorrinv(1,1);
	  possel(5)=Sigmacorrinv(1,2);
	  possel(6)=Sigmacorrinv(2,1);
	  possel(7)=Sigmacorrinv(2,2);
end