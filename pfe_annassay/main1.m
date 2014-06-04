function scene=query(input)

p=program(input);

db=taining_views();

[dbxmax dbymax]=size(db);

for k=1:4

     for j=1:dbxmax
         l=[p(k,j,1) p(k,j,2) p(k,j,3) p(k,j,4) p(k,j,5) p(k,j,6) p(k,j,7)];
         d=db(j,:);
         x=[d' l'];
         y = pdist(x,'mahal');
         
     end
end