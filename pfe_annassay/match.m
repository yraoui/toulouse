% num = match(image1, image2)
%
% This function reads two images, finds their SIFT features, and
%   displays lines connecting the matched keypoints.  A match is accepted
%   only if its distance is less than distRatio times the distance to the
%   second closest match.
% It returns the number of matches displayed.
%
% Example: match('scene.pgm','book.pgm');

function match = match(im1,im2,vect1,vect2)
save vect2.mat vect2
% Find srft (scale and rotation feature transform) keypoints for each image

des1=vect1(:,27:end);
des2=vect2(:,27:end);
loc1=vect1(:,1:26);
loc2=vect2(:,1:26);

distRatio = 7;   

% For each descriptor in the first image, select its match to second image.
des2t = des2';                          % Precompute matrix transpose
for i = 1 : size(des1,1)
   dotprods = des1(i,:) * des2t;        % Computes vector of dot products
   [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results

   % Check if nearest neighbor has angle less than distRatio times 2nd.
   if (vals(1) < distRatio * vals(2))
      match(i) = indx(1);
   else
      match(i) = 0;
   end
end
% 
% % Create a new image showing the two images side by side.
% im3 = appendimages(im1,im2);
% 
% % Show a figure with lines joining the accepted matches.
% figure('Position', [100 100 size(im3,2) size(im3,1)]);
% colormap('gray');
% imagesc(im3);
% hold on;
% cols1 = size(im1,2);
% for i = 1: size(des1,1)
%   if (match(i) > 0)
%     line([loc1(i,2) loc2(match(i),2)+cols1], ...
%          [loc1(i,1) loc2(match(i),1)], 'Color', 'c');
%   end
% end
% hold off;
% num = sum(match > 0);
% fprintf('Found %d matches.\n', num);
% 
% 
% 
% 
