function ha_color(path)
in=imread(path);
pos=program(in);
% for i=1:800
%         
%    in(pos(i,2),pos(i,1))=1000;
%      
% 
%    
%  end

 imshow(in);
showellipticfeatures(pos,[1 0 0]);
