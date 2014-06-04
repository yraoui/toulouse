function db=taining_views()
%models

path=dir('46/*.png');
c=cell(400);
pos=cell(400);
for i=1:10
    pathh=strcat('46/',path(i).name);
    c{i}=imread(pathh);
pos{i}=program(c{i});
end

  req1='INSERT INTO  features(v,x,y,scale,a1,a2,a3,a4) VALUES (';
for i=1:4
   p(i,:,:)=pos{i};
end
conn = database('images','','');
 
for i=1:4
for j=1:200
requete=strcat(req1,num2str(i),',',num2str(p(i,j,1)),',',num2str(p(i,j,2)),',',num2str(p(i,j,3)),',',num2str(p(i,j,4)),',',num2str(p(i,j,5)),',',num2str(p(i,j,6)),',',num2str(p(i,j,7)),')');
curs = exec(conn, requete);
ans=fetch(curs);
end
end


conn = database('images','','');
curs_db = exec(conn, 'select * from features');
ans_req2=fetch(curs_db);
ans_req2=ans_req2.data;
db=cell2mat(ans_req2);
db=db(:,3:9);

[dbxmax dbymax]=size(db);
for k=1:4
     for j=1:dbxmax
         l=[p(k,j,1) p(k,j,2) p(k,j,3) p(k,j,4) p(k,j,5) p(k,j,6) p(k,j,7)];
         d=db(j,:);
         x=[d' l'];
         y = pdist(x,'mahal');
         
     end
end

% requete :





% % [a,b]=sort(d);
% % if (a(1)/a(2)<0.8)
% %     correct_match(c)=j;
% % end
% % 
% % 
% %     