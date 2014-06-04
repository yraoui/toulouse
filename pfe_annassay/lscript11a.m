
%
% affine adaptation of interest points
%

if 0 % initialisation
  img=double(imread('d:/images/faces000/subject01_happy_a.tif'));
  img=sum(double(imread('d:/images/eth80/car1-068-180.tif')),3)/3;
  
  f0=img;
  %f0=img(150:200,120:170);
  [ysize,xsize]=size(f0);
  showgrey(f0)

  nptsmax=200;
  sx2arr=[2 4 8 16];
  kparam=0.04;
  pointtype=3;
end

if 1 % detect interest points at given scales
  posinit=[];
  valinit=[];
  for i=1:length(sx2arr)
    sxl2=sx2arr(i); sxi2=2*sxl2;
    disp(sprintf('sigma^2=%1.2f',sxl2));
    [pos,val,cimg,L]=intpointdet(f0,kparam,sxl2,sxi2,pointtype,nptsmax);
    posinit=[posinit; pos];
    valinit=[valinit; val];
  end

  if 1 % show results
    figure(gcf)
    clf, showgrey(f0)
    showellipticfeatures(posinit);
    pause(0.1)
  end
end
