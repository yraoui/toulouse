function db=training_views()

path=dir('imagesHjpg/*.jpg');
c=cell(400);
pos=cell(400);
for i=1:28
    pathh=strcat('imagesHjpg/',path(i).name);
    c{i}=imread(pathh);
pos{i}=program(c{i});
end
3
  req1='INSERT INTO  features(v,x,y,scale,a1,a2,a3,a4) VALUES (';
for i=1:28
   p(i,:,:)=pos{i};
end
conn = database('images','','');
 
for i=1:28
for j=1:200
requete=strcat(req1,num2str(i),',',num2str(p(i,j,1)),',',num2str(p(i,j,2)),',',num2str(p(i,j,3)),',',num2str(p(i,j,4)),',',num2str(p(i,j,5)),',',num2str(p(i,j,6)),',',num2str(p(i,j,7)),')');
curs = exec(conn, requete);
ans=fetch(curs);
end
end
4
conn = database('images','','');
curs_db = exec(conn, 'select * from features');
ans_req2=fetch(curs_db);
ans_req2=ans_req2.data;
db=cell2mat(ans_req2);
db=db(:,3:9);



% requete :





% % [a,b]=sort(d);
% % if (a(1)/a(2)<0.8)
% %     correct_match(c)=j;
% % end
% % 
% % 
% %     