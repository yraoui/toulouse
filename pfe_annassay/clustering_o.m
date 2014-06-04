%models

path=dir('calteck/*.jpg');
c=cell(100);
pos=cell(100);
for i=1:2
    pathh=strcat('calteck/',path(i).name);
    c{i}=imread(pathh);
%featurepointhash(img1)
  %  pos{i}=ha_color(cell2mat(c(i)));
pos{i}=program(c{i});
%  pos{i}=featurepointhash(cell2mat(c(i)));
end
  req1='INSERT INTO  features(v,x,y,scale,a1,a2,a3,a4) VALUES (1,';
for i=1:1
   p=pos{i};

for j=1:600
requete=strcat(req1,num2str(p(j,1)),',',num2str(p(j,2)),',',num2str(p(j,3)),',',num2str(p(j,4)),',',num2str(p(j,5)),',',num2str(p(j,6)),',',num2str(p(j,7)),')');
conn = database('images','','');
requete;
%fastinsert(conn, 'features', colnames, exdata);
%commit(conn);
%INSERT INTO  features(v,x,y,scale,a1,a2,a3,a4) VALUES (1,1,1,1,1,1,1,1)
curs = exec(conn, requete);
ans=fetch(curs);
end
end
% req=pos{1};
% %req=[req(:,1),req(:,2)]
% for i=1:2
%     p=pos{i};
%  d(i)= imagauth(req,p);%,cell2mat(c(1)),cell2mat(c(i)));
%    %  po=[p(:,1),p(:,2)];
%  %   Z(:,i) = mean(mahal(req,po));
% end
% 

