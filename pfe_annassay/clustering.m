%function db=taining_views()

path=dir('imagesHjpg/*.jpg');
cc=cell(400);
%pos=cell(400);


for i=1:28
    pathh=strcat('imagesHjpg/',path(i).name);
    cc{i}=imread(pathh);
%pos{i}=program(c{i});
end
3
  req1='INSERT INTO  features(v,x,y,scale,a1,a2,a3,a4) VALUES (';
for i=1:28
   p(i,:,:)=pos{i};
end
conn = database('images','','');
 
for i=1:28
for j=1:370
requete=strcat(req1,num2str(i),',',num2str(p(i,j,1)),',',num2str(p(i,j,2)),',',num2str(p(i,j,3)),',',num2str(p(i,j,4)),',',num2str(p(i,j,5)),',',num2str(p(i,j,6)),',',num2str(p(i,j,7)),')');
curs = exec(conn, requete);
ans=fetch(curs);
end
end
4

im_names = { ...
   ['nutshell0003']; ...  % Model of Java book
   ['phone0003']; ...     % Model of coreless phone
   ['phone0007']; ...
   ['nutshell0007']; ...
   ['phone0018']; ...
   ['nutshell0008']; ...
   ['phone0005']; ...
   ['nutshell0009']; ...   
   ['phone0017']; ...   
   ['nutshell0012']; ...
   ['phone0016']; ...  % Does not find compute correct affine transform for this image
   ['nutshell0004']; ...
   ['nutshell0010']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
   ['nutshell0011']; ...
};

datab = empty_descriptor_database;

num_obj = 1;
n = length(im_names);
obj_im = cell(1,n);
obj_mask = cell(1,n);
obj_pos = cell(1,n);
obj_scale = cell(1,n);
obj_orient = cell(1,n);
obj_desc = cell(1,n);

for k = 1:num_obj
   fprintf( 2, 'Adding keypoints for image %s to database.\n', im_names{k} );   
datab = add_descriptors_to_database( obj_im{k}, obj_pos{k}, obj_scale{k}, obj_orient{k}, obj_desc{k}, datab  );
end

requ='select * from features where v=';
i=1;
for i=1:9
% conn = database('images','','');
% requete=strcat(requ,num2str(i));
% curs_db = exec(conn, requete);
% ans_req2=fetch(curs_db);
% ans_req2=ans_req2.data;
% db=cell2mat(ans_req2);
% db=db(:,3:9);
%table=db;
pos2=[p(:,1) p(:,2)];
scale2=p(:,3) ;
orient2=[p(:,4) p(:,5) p(:,6) p(:,7)];
[datab,handle] = add_descriptors_to_database(c{i},  pos2, scale2, orient2, table, datab);
end

%
i=1;
databh.index=datab.index;
databh.im=datab.im;
databh.num_im=datab.num_im;
j=1;
h=cell(20);
pp=p(1:200,:);
for i=0:400:6770
  %  for j=1:200
        databh.pos=datab.pos(1+i:400+i,:);
        databh.scale=datab.scale(1+i:400+i,:);
        databh.orient=datab.orient(1+i:400+i,:);
        databh.desc=datab.desc(1+i:400+i,:);
        [im_idx trans theta rho idx nn_idx wght] = hough( databh, posq, scaleq, orientq, p(1:400,:),1.5 );

        matches = length(im_idx)
        aff = cell(1,matches);
        c_pos = cell(1,matches);
        nn_pos = cell(1,matches);
        outliers = cell(1,matches);
        h{j}= [im_idx trans theta rho idx nn_idx wght];
        j=j+1;  
  % Robustly fit an affine tranformation to the largest peak of the hough tranformation
% fprintf( 2, 'Fitting affine transform to largest peak of hough transform...\n' );
% [max_val k] = max(wght);
% c_pos = posq(idx{k},:);
% c_desc = pp(idx{k},:);
% c_wght = scaleq(idx{k}).^-2;
% nn_pos = datab.posdb(nn_idx{k},:);                   
% [aff outliers] = fit_robust_affine_transform( c_pos', nn_pos', c_wght', 0.75 );
% 
% % Display the computed transformation and the actual tranformation
% fprintf( 2, 'Computed affine transformation from rotated image to original image:\n' );
% disp(aff);
% fprintf( 2, 'Actual transformation from rotated image to original image:\n' );
% %disp(A);
% %fprintf( 2, 'Press any key to continue...\n\n' );
% pause;             
end
  c=  results(databh, posq, scaleq, orientq, pp,im_idx, trans, theta, rho, idx, nn_idx, wght,im_names,input);
% %     