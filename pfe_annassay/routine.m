conn = database('images','','')
curs = exec(conn, 'select * from image_load')
ans=fetch(curs);
cells=ans.data

image_path=cells(:,2);
m=cell(10);
req='C:\birds\egret\';

for i=1:25
    i
    t = strcat(req,image_path{i});
   in=imread(t);
   xmax=0;   ymax=0;
[xmax,ymax,zmax]=size(in);
in=in(1:xmax,1:ymax,1:3);
  m{i}=in;
   
end
pos_cell=cell(10);
for i =1:25
    i
pos_cell{i}=program(m{i});
end

for i =1:25
    
 subplot(5,5,i);   

displayd(pos_cell(i),m(i));
%showellipticfeatures(pos_cell{i},[1 0 0]);
end