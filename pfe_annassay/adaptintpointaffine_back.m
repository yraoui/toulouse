function [pos,posevol,val]=adaptintpointaffine(f,posinit,pointtype,sxstep,maxiter,adaptflag,sxmax,displayflag)

%
% [pos,posevol,val]=
%     adaptintpointaffine(f,posinit,pointtype,sxstep,maxiter,adaptflag,sxmax,displayflag)
%
%   given an initial point parameters (x,y,sx2,c11,c12,c22) in affine
%   scale-space, iteratively searches for a point in f in the neighbourhood
%   of the initial point that is i) max of an interest point function over (x,y)
%   ii) extrema of a normalised Laplace operator over scales (sx2)
%   and computed in the affine-adapted neighbourhood.
%   The result is reported in pos. The trajectory from posinit
%   to pos is returned in posevol. pos is an empty vector if
%   convergency could not be reached.
%   Optional input parameter sxstep, (=0.25 default) sets the
%   scale increment between iteration steps. maxiter (=20 default)
%   gives the max number of iterations. pointtype defines the type
%   of interest point detector (see intpointdet.m for details).
%   adaptflag = [a1 a2 a3]: a1~=0 => scale adaption
%                           a2~=0 => affine adaption
%                           a3~=0 => x-y position adaption
%               []: (default) adapt over all parameters
%
%   Author: Ivan Laptev, 2003
%           Computational Vision and Active Perception Laboratory (CVAP)
%           Dept. of Numerical Analysis and Computer Science
%           KTH, SE-100 44 Stockholm, Sweden
%           laptev@nada.kth.se
%
%   Ref: "An Affine Invariant Interest Point Detector"
%        Mikolajczyk, K. and Schmid, C. in proc. ECCV 2002
%        LNCS 2350, pp.I:128--142
%

if size(posinit,1)>1
  posinit=transpose(posinit);
end

% default values
if nargin<3 pointtype=1; end
if nargin<4 sxstep=0.25; end
if nargin<5 maxiter=20; end
if nargin<6 adaptflag=[1 1 1]; end
if size(adaptflag)==0 adaptflag=[1 1 1]; end
if nargin<7 sxmax=512; end
if nargin<8 displayflag=0; end

% reset shape parameters
posinit(4)=1;
posinit(5)=0;
posinit(6)=0;
posinit(7)=1;

valsel=0;
possel=posinit;
posprev=possel;
posevol(1,:)=posinit;

scalesteporig=sxstep;
scalestep=scalesteporig;
affexp=0.8;
vold=0;
Qold=0;d
Qsgn=0;

iter=0;
affconvflag=0;
loopconvflag=0;
scaleconvflag=0;
divergenceflag=0;
[ysize,xsize]=size(f);

if displayflag
  subplot(1,2,2), hold off
  showgrey(f)
end


while ~((  (~(iter==0) | (((posprev(1:2)-possel(1:2))*transpose(posprev(1:2)-possel(1:2)))==0))...
         & ~xor(adaptflag(1), scaleconvflag)...
         & ~xor(adaptflag(2), affconvflag))...
        | loopconvflag ...
        | divergenceflag ...
        | (iter>=maxiter))

  iter=iter+1;
  
  % cut out a part of f
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
  Q=max(abs(diag(d)))/min(abs(diag(d)));

  % increase the spatial extent of a window according to the anisotropy
  if adaptflag(2) xszf=Q; else xszf=1; end
  
  brx=max(9,round(xszf*4*sqrt(sxl2)));

  %[px py brx]
  %isreal(Sigma)
  fcut=f(max(1,py-brx):min(ysize,py+brx),...
	 max(1,px-brx):min(xsize,px+brx));
  cy=min(brx+1,py);
  cx=min(brx+1,px);
%   
%   if adaptflag(2) % if adapting the shape
%     fcut=warpaffinefloat(fcut,Sigma,cx,cy);
%     brx=max(9,round(4*sqrt(sxl2)));
%     fcut=fcut(max(1,cy-brx):min(size(fcut,1),cy+brx),...
% 	      max(1,cx-brx):min(size(fcut,2),cx+brx),:);
%     cy=min(brx+1,cy);
%     cx=min(brx+1,cx);
%   end



  sx=2*sxl2;
     
  msz=(size(dxmask,1)-1)/2;
  L=mydiscgaussfft(fcut,sx);
  Lext=extend2(L,msz,msz);
  Lcut=Lext(cy:cy+2*msz,cx:cx+2*msz);
 
  % adapt scales
  if adaptflag(1)
    Lxxval=filter2(Lcut,dxxmask,'valid');  
    Lyyval=filter2(Lcut,dyymask,'valid');
    Lxxxxval=filter2(Lcut,dxxxxmask,'valid');
    Lxxyyval=filter2(Lcut,dxxyymask,'valid');
    Lyyyyval=filter2(Lcut,dyyyymask,'valid');
  
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
    
    
    v=sign(lapsxval)*sign(lapval);
    if v*vold<0 % change in the direction of scale optimization
      scalestep=scalestep/2;
    end
    vold=v;

    % check if the new scale is better otherwise reduce the step
    sxl2new=sxl2*2^(scalestep*v); sxi2new=2*sxl2;
    sx=2*sxl2new;
    L=mydiscgaussfft(fcut,sx);
    Lext=extend2(L,msz,msz);
    Lcut=Lext(cy:cy+2*msz,cx:cx+2*msz);
    Lxxval=filter2(Lcut,dxxmask,'valid');
    Lyyval=filter2(Lcut,dyymask,'valid');
    lapvalnew=(Lxxval+Lyyval)*sx;
    if (lapval^2)>(lapvalnew^2)
      scaleconvflag=1;
    else
      % update scales
      sxl2=sxl2*2^(scalestep*v);
      scaleconvflag=0;
      %disp(sprintf('     update scales, no scale converegnce yet'))
    end
  else
    lapval=0;
  end
  
  if sx>sxmax
    divergenceflag=1;
  end
  
  if ~(scaleconvflag & affconvflag)
    
    % re-detect interest points
    kparam=0.01;
    sxi2=2*sxl2;
    [pos,val]=intpointdet(fcut,kparam,sxl2,sxi2,pointtype,100);
    %pos=il_harris(fcut,100,sxl2,sxi2,kparam,0);

    % update position vector
    if size(pos,1)>0 % if any harris point is found  


      %fignum=figure;
      %showgrey(fcut)
      %showellipticfeatures(pos);
      %plot(cx,cy,'o')

      %%showellipticfeatures(pos,[1 0 0]);
      %pause
      %close(fignum)

      % update posiotion w.r.t to the affine warp
      if adaptflag(2)
        poscorr=(sqrtm(Sigma))*[transpose(pos(:,1)-cx); transpose(pos(:,2)-cy)];
        pos(:,1)=round(transpose(poscorr(1,:))+cx);
        pos(:,2)=round(transpose(poscorr(2,:))+cy);
      end
      
      % convert positions to f-coordinates
      pos(:,1:2)=pos(:,1:2)+(ones(size(pos,1),1)*[max(0,px-brx-1) max(0,py-brx-1)]);

      % select the most close point
      dvec=pos(:,1:2)-(ones(size(pos,1),1)*posinit(1:2));
      [dmin, dminind]=min(sum(dvec.*dvec,2));
      pos=pos(dminind,:);
      
    

      posprev=possel;
      %[possel(1:3) pos(1:3)]
      possel=pos;
      % no position update
      if ~adaptflag(3)
        possel(1:2)=posprev(1:2);
      end
      valsel=[val(dminind,:)];
      
      % update the shape matrix
      if adaptflag(2)
        Sigmanew=inv([possel(4) possel(5); possel(6) possel(7)]);

        if sum(isnan(Sigmanew(:))) | sum(isinf(Sigmanew(:)))
          divergenceflag=1;
        else
          Sigmanew=Sigmanew/sqrt(det(Sigmanew));
          [v,d]=eig(Sigmanew);

	  Sigmanew=transpose(v)*(d.^affexp)*v;
          Sigmanew=Sigmanew/sqrt(det(Sigmanew));

          Q=max(abs(diag(d)))/min(abs(diag(d)));
          Sigmacorrinv=inv(Sigmanew)*inv(Sigma);

          %Sigmacorr=Sigmanew*Sigma;
          %Sigmacorrinv=inv(Sigmacorr);
	  possel(4)=Sigmacorrinv(1,1);
	  possel(5)=Sigmacorrinv(1,2);
	  possel(6)=Sigmacorrinv(2,1);
	  possel(7)=Sigmacorrinv(2,2);

 	  Qmin=1.05;
          Sigmanew=Sigmanew/sqrt(det(Sigmanew));
          [v,d]=eig(Sigmanew);
          Q=max(abs(diag(d)))/min(abs(diag(d)));
	  if Qold>0
	    if Qsgn*(Q-Qold)<0 & affexp>0.05
	      affexp=affexp/2;
	    end
	    Qsgn=Q-Qold;
	  end
	  Qold=Q;
	  
	  if Q<Qmin
	    affconvflag=1;
	  else
	    affconvflag=0;
	  end
        end
      end

      posevol(iter+1,:)=possel;
      
    else % if no harris point is found
	divergenceflag=1;
        disp(sprintf('no harris points re-detected'))
    end
  end
  if ~isreal(sqrtm([possel(4) possel(5); possel(6) possel(7)]))
    divergenceflag=1;
    disp(sprintf('Square root of Sigma is complex'))
  end
  
  if possel(2)<1 | possel(1)<1 | possel(2)>ysize | possel(1)>xsize | iter>=maxiter
    divergenceflag=1;
  end
  
%   if ~divergenceflag
%     Sigma=inv([possel(4) possel(5); possel(6) possel(7)]);
%     [v,d]=eig(Sigma);
%     Q=max(abs(diag(d)))/min(abs(diag(d)));
% 
%     disp(sprintf('   iter: %d, x=%d, y=%d, sx=%1.5f, Q=%1.2f, Lapval=%2.1f',...
% 	         iter,possel(1),possel(2),sxl2,Q,lapval))
%   end

  if displayflag
    subplot(1,2,2)
    showellipticfeatures(possel,[1 0 0]);
    axis([max(1,posinit(1)-30) min(xsize,posinit(1)+30) ...
          max(1,posinit(2)-30) min(ysize,posinit(2)+30)])
    title('estimated shape')
    pause(0.1)
  end
end
  

pos=[];
val=[];

% in case of convergence
%if ((posprev-possel)*transpose(posprev-possel))==0 | loopconvflag | ...
%   (scaleconvflag & adaptflag(1)) | (affconvflag & adaptflag(2))

if ~divergenceflag
  pos=possel;
  val=valsel;
  if loopconvflag
    disp('Loop-convergence')
  end
  if adaptflag(1)&scaleconvflag
    disp('Scale convergence')
  end
  if adaptflag(2)&affconvflag
    disp('Shape convergence')
  end
else
  disp('Divergence')
end


