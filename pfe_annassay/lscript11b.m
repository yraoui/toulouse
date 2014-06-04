


if 1 % adapt interest points to scale
  
  posall={};
  valall={};
  posevolall={};

  for i=1:size(posinit,1)
    disp(sprintf('point %d of %d',i,size(posinit,1)))
    [pos,posevol,val]=adaptintpointaffine(f0,posinit(i,:),pointtype,0.25,30,[1 1 1],256);
    posall{i}=pos;
    valall{i}=val;
    posevolall{i}=posevol;
  end

  posallarray=[];
  valallarray=[];
  convflag=zeros(1,length(posall));
  for i=1:length(posall)
    if length(posall{i})>0
      posallarray=[posallarray; posall{i}];
      valallarray=[valallarray; valall{i}];
      convflag(i)=1;
    end
  end
  disp(sprintf('Convergence: %2.1f',100*sum(convflag)/length(convflag)))

  if 1 % show results
    figure(gcf)
    clf, showgrey(f0)
    showellipticfeatures(posallarray);
    pause(0.1)
  end

end

if 0 % examine convergence
  figure(gcf)
  clf, showgrey(f0)
  showellipticfeatures(posinit(find(convflag),:),[1 0 0]);
  showellipticfeatures(posinit(find(~convflag),:),[0 0 1]);
  pause(0.1)
end


