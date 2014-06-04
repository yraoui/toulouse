  % display detected points as ellipses
  figure(gcf), clf
posinit=pos_d;
pointtype=1;
f1=imread('image1.jpg');
  showgrey(f1), hold on
  showellipticfeatures(posinit,[1 0 0]);
  title('initial detection and shape estimate')
  disp('press a key ...')
  pause

  % set up parameters for adaptation
  a1=1; a2=1; a3=1;
  adaptflag=[a1 a2 a3]; % a1: adapt scale; a2: adapt shape; a3: adapt position 
  sxstep=0.25;          % scale-increment factor  
  maxiter=30;           % max. number of interations
  sxmax=256;            % max spatial scale
  displayflag=1         % 1: show adaptation process; 0: resume 

  % adapt points w.r.t. scale, shape and position
  posall={};
  valall={};
  posevolall={};
  for i=1:size(posinit,1)
    disp(sprintf('point %d of %d',i,size(posinit,1)))
    posinit(i,:)
    [pos,posevol,val]=adaptintpointaffine(f1,posinit(i,:),pointtype,sxstep,maxiter,adaptflag,sxmax,displayflag);
    posall{i}=pos;
    valall{i}=val;
    posevolall{i}=posevol;
  end

  % select converged points
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
  disp(sprintf('\nOverall convergence rate: %2.1f%%',100*sum(convflag)/length(convflag)))

  if 1 % show results
    figure(gcf)
    clf, showgrey(f1)
    showellipticfeatures(posallarray);
    title('result of scale and shape adaptation')
    pause(0.1)
  end

  

