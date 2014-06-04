req=pos{1};
for i=1:100
    c(i)=cov(cell2mat(req),cell2mat(pos{i}));
end