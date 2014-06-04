in=cell(10,10);
for i=1:10
        in=cell(pos(i),i)
end
req=pos(q);
for i=1:10
    d(i)=imdist(req,in);
end
