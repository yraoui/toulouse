
p1=p1';
p2=p2';
l=zeros(7,600,600);
for j=1:600
for i=1:600
    l(:,i,j)=mahal(p1(:,j),p2(:,i));
end
end

