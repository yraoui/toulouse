
features=pos2;
posq=[features(1:400,1) features(1:400,2)];
scaleq=[features(1:400,3) features(1:400,4) features(1:400,5)];
orientq=[features(1:400,5) features(1:400,6) features(1:400,7) features(1:400,8) features(1:400,9) features(1:400,10) features(1:400,11) features(1:400,12) features(1:400,13) features(1:400,14) features(1:400,15) features(1:400,16)];
1

path=dir('imagesHjpg/*.jpg');
c=cell(400);
% pos=cell(400);


for i=1:28
    pathh=strcat('imagesHjpg/',path(i).name);
    c{i}=imread(pathh);
%posdb{i}=program(c{i});
end
3
posdb1=posdb';
posdb1=cell(400,400);
for i=1:28
   p(:,:,i)=posdb{i};
end

im_names = { ...
   ['obj1']; ...  % Model of Java book
   ['obj2']; ...     % Model of coreless phone
   ['obj3']; ...
   ['obj4']; ...
   ['obj5']; ...
   ['obj6']; ...
   ['obj7']; ...
   ['obj8']; ...   
   ['obj9']; ...   
   ['obj10']; ...
   ['obj11']; ...  % Does not find compute correct affine transform for this image
   ['obj12']; ...
   ['obj13']; ...
   ['obj14']; ...
   ['obj15']; ...
   ['obj16']; ...
   ['obj17']; ...
   ['obj18']; ...
   ['obj19']; ...
   ['obj20']; ...
   ['obj21']; ...
   ['obj22']; ...
   ['obj23']; ...
   ['obj24']; ...
   ['obj25']; ...
   ['obj26']; ...
   ['obj27']; ...
   ['obj28']; ...
   ['obj29']; ...
   ['obj30']; ...
   ['obj31']; ...
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

for i=1:28
% conn = database('images','','');
% requete=strcat(requ,num2str(i));
% curs_db = exec(conn, requete);
% ans_req2=fetch(curs_db);
% ans_req2=ans_req2.data;
% db=cell2mat(ans_req2);
% db=db(:,3:9);
% table=db;
%p=posdb{i};
table=[p(:,1) p(:,2) p(:,3) p(:,4) p(:,5) p(:,6) p(:,7) p(:,8) p(:,9) p(:,10) p(:,11) p(:,12) p(:,13) p(:,14) p(:,15) p(:,16)];
posd=[table(:,1) table(:,2)];
scale2=[table(:,3) table(:,4) table(:,5)];
orient2=[table(:,5) table(:,6) table(:,7) table(:,8) table(:,9) table(:,10) table(:,11) table(:,12) table(:,13) table(:,14) table(:,15) table(:,16)];
[datab,handle] = add_descriptors_to_database(c{i},  posd, scale2, orient2, table, datab);
end


i=1;
databh.index=datab.index;
databh.im=datab.im;
databh.num_im=datab.num_im;
j=1;
h=cell(20);
im_idxx=cell(100);
transs=cell(100);
thetaa=cell(100);
rhoo=cell(100);
idxx=cell(100);
nn_idxx=cell(100);
wghtt=cell(100); 
pp=p(:,1:400);
posdb=posdb1';
i=1;

for i=0:400:16000
        databh.posdb=datab.pos(1+i:400+i,:);
        databh.scale=datab.scale(1+i:400+i,:);
        databh.orient=datab.orient(1+i:400+i,:);
        databh.desc=datab.desc(1+i:400+i,:);
        [im_idx trans theta rho idx nn_idx wght] = hough1( datab, posq, scaleq, orientq,table(1:400,1:16),1.5 );
       im_idx
        matches(j) = length(im_idx);
        aff = cell(1,matches);
        c_pos = cell(1,matches);
        nn_pos = cell(1,matches);
        outliers = cell(1,matches);
        im_idxx{j}=im_idx;
       transs{j}=trans;
       thetaa{j}=theta;
       rhoo{j}=rho;
       idxx{j}=idx;
       nn_idxx{j}=nn_idx;
       wghtt{j}=wght;   
       j=j+1;  
%   % Robustly fit an affine tranformation to the largest peak of the hough tranformation
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

[xmax ymax]=max(matches);

c=results(databh, posq, scaleq, orientq, table(1:400,1:16),im_idxx{ymax}, transs{ymax}, thetaa{ymax}, rhoo{ymax}, idxx{ymax}, nn_idxx{ymax}, wghtt{ymax},im_names,input)

c=  results(datab, posq, scaleq, orientq, features,im_idx, trans, theta, rho, idx, nn_idx, wght,im_names,input);

% db=training_views();
2
% [dbxmax dbymax]=size(db);

% for k=1:4
%      for j=1:200
%          l=[p(j,1) p(j,2) p(j,3) p(j,4) p(j,5) p(j,6) p(j,7)];
%          d=db(j,:);
%          x=[d' l'];
%          y(j)=mean(pdist(x,'mahal'));
%      end
% end
