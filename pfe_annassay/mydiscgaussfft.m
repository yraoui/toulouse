function pixels = mydiscgaussfft(inpic, sigma2)

% % DISCGAUSSFFT(pic, sigma2) -- Convolves an image by the
% % (separable) discrete analogue of the Gaussian kernel by
% % performing the convolution in the Fourier domain.
% % The parameter SIGMA2 is the variance of the kernel.
% 
% % Reference: Lindeberg "Scale-space theory in computer vision", Kluwer, 1994.
% 
ext=round(4*sqrt(sigma2));
inpic=extend2(inpic,ext,ext);

%ftransform = fft2(inpic);
ftransform = fft(inpic,[],1);
ftransform = fft(ftransform,[],2);

[xsize ysize] = size(ftransform);
[x y] = meshgrid(0 : xsize-1, 0 : ysize-1);

%pixels = real(ifft2(exp(sigma2 * (cos(2 * pi*(x / xsize)) + cos(2 * pi*(y / ysize)) - 2))' .* ftransform));

pixels = ifft(exp(sigma2 * (cos(2 * pi*(x / xsize)) + cos(2 * pi*(y / ysize)) - 2))' .* ftransform,[],1);
pixels = real(ifft(pixels,[],2));
% % 
% % % pixels=pixels(ext+1:xsize-ext,ext+1:ysize-ext);
% 
% 
% cc=cell(10);
% o=1;
% for o=1:10
% for x=1:20
% for y=1:20
% for n=1:5
% for t=1:2
% for m=1:10
% tt(x,y,n,t,m)=2*(m/2*pi)^((n+2)/2)*exp(t*m)*t/(t^2+abs(x-y)^2)^((n+1)/4)*besselK(1,n)*(m*(t^2+abs(x-y)));
% end
% end
% cc{o}=tt;
% end
% 
% end
% end
% 
% o=o+1;
%  end
%  pixels=conv2(inpic,tt(:,:,1,1,1));
% % imagesc(c),figure(gcf);