
%
% demo for interest point detection and their scale and shape adaptation
%

if 1 % test on synthetic blob images

  % make an image
  fdelta=ones(128); 
  fdelta(64,64)=0;
  f1=mydiscgaussfft(fdelta,32);
  a=pi/4; rmat=[cos(a) sin(a); -sin(a) cos(a)];
  Sigma=transpose(rmat)*[1 0; 0 6]*rmat;
  Sigma=Sigma/sqrt(det(Sigma));
  f1=warpaffinefloat(f1,Sigma,64,64);
  figure(gcf)
  clf, showgrey(f1);
  hold on

  % set up parameters for point detection
  nptsmax=1;    % max number of detected points (sorted by their strength values)
  kparam=0.04;  % constant for Harris corners
  pointtype=3;  % type of interest points, 1: Harris; 2: Laplace; 3: det(Hessian)
  sxl2=4;       % detection scale (variance)
  sxi2=2*sxl2;  % integration scale


  % detect points
  [posinit,valinit]=intpointdet(f1,kparam,sxl2,sxi2,pointtype,nptsmax);

  % display detected points as ellipses
  figure(gcf), clf
  showgrey(f1), hold on
  showellipticfeatures(posinit,[1 0 0]);
  title('initial detection and shape estimate')
  disp('press a key ...')
  pause

  % set up parameters for adaptation
  a1=1; a2=1; a3=1;
  adaptflag=[a1 a2 a3]; % a1: adapt scale; a2: adapt shape; a3: adapt position 
  sxstep=0.25;          % scale-increment factor  
  maxiter=30;           % max. number of interations
  sxmax=256;            % max spatial scale

  % adapt points w.r.t. scale, shape and position
  posall={};
  valall={};
  posevolall={};
  for i=1:size(posinit,1)
    disp(sprintf('point %d of %d',i,size(posinit,1)))
    [pos,posevol,val]=adaptintpointaffine(f1,posinit(i,:),pointtype,sxstep,maxiter,adaptflag,sxmax,1);
    posall{i}=pos;
    valall{i}=val;
    posevolall{i}=posevol;
  end

end
