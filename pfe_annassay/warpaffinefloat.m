function fwarp=warpaffinefloat(f,Sigma,x0,y0)

%
% fwarp=warpaffinefloat(f,Sigma,x0,y0)
%
%   Warps the original image f with the center at (x0,y0)
%   according to the affine 2x2 transformation matrix Sigma.
%   The size of the original image is preserved.
%

[ysz,xsz]=size(f);
[X,Y]=meshgrid(1:xsz,1:ysz);
X=X-x0;
Y=Y-y0;

%[v,d,v]=svd(Sigma);
%pts=(transpose(v)*sqrtm(d))*[transpose(X(:)); transpose(Y(:))];
pts=sqrtm(Sigma)*[transpose(X(:)); transpose(Y(:))];
X=pts(1,:)+x0;
Y=pts(2,:)+y0;

Xfloor=floor(X); Xplus=X-Xfloor;
Yfloor=floor(Y); Yplus=Y-Yfloor;

clear X Y
W{1}=abs((1-Xplus).*(1-Yplus)); X{1}=Xfloor;   Y{1}=Yfloor;
W{2}=abs(  (Xplus).*(1-Yplus)); X{2}=Xfloor+1; Y{2}=Yfloor;
W{3}=abs((1-Xplus).*  (Yplus)); X{3}=Xfloor;   Y{3}=Yfloor+1;
W{4}=abs(  (Xplus).*  (Yplus)); X{4}=Xfloor+1; Y{4}=Yfloor+1;

fwarp=zeros(size(f(:)));

for i=1:4
  X{i}(find(X{i}(:)<1))=1; X{i}(find(X{i}(:)>xsz))=xsz;
  Y{i}(find(Y{i}(:)<1))=1; Y{i}(find(Y{i}(:)>ysz))=ysz;
  
  ind=sub2ind([ysz xsz],Y{i}(:),X{i}(:));
  fwarp=fwarp+f(ind).*(W{i}(:));
  
end

fwarp=reshape(fwarp,[ysz xsz]);
