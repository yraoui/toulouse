%models

path=dir('calteck/*.jpg');
c=cell(100);
pos=cell(100);
for i=1:2
    pathh=strcat('calteck/',path(i).name);
    c{i}=imread(pathh);
pos{i}=program(c{i});

end
  req1='INSERT INTO  features(v,x,y,scale,a1,a2,a3,a4) VALUES (1,';
for i=1:1
   p=pos{i};

for j=1:600
requete=strcat(req1,num2str(p(j,1)),',',num2str(p(j,2)),',',num2str(p(j,3)),',',num2str(p(j,4)),',',num2str(p(j,5)),',',num2str(p(j,6)),',',num2str(p(j,7)),')');
conn = database('images','','');
requete;
curs = exec(conn, requete);
ans=fetch(curs);
end
end

