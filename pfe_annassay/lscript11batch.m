
%datapath='d:/work/affintpoints/images';
%ipointpath='d:/work/affintpoints/ipoints';

datapath='/home/cvap/laptev/proj/affintpoints/images';
ipointpath='/home/cvap/laptev/proj/affintpoints/ipoints';

imgnames={};
dirnames={};
extnames={};


imgnames{length(imgnames)+1}='car1-068-180';
dirnames{length(dirnames)+1}='.';
extnames{length(extnames)+1}='.png';

imgnames{length(imgnames)+1}='car1-066-153';
dirnames{length(dirnames)+1}='.';
extnames{length(extnames)+1}='.png';

imgnames{length(imgnames)+1}='subject01_happy_a';
dirnames{length(dirnames)+1}='.';
extnames{length(extnames)+1}='.tif';


% set up parameters 
nptsmax=50;
sx2arr=[2 4 8 16];
kparam=0.04;
pointtype=1;

convall=0;

for iii=1:length(imgnames)
  imgname=sprintf('%s/%s/%s%s',datapath,char(dirnames(iii)),...
                               char(imgnames(iii)),char(extnames(iii)))
  f0=il_rgb2gray(double(imread(imgname)));

  if 1 % detect features 
    % detect initial interst points
    lscript11a

    % adapt interest points with respect to shape and scale 
    lscript11b

    % save results
    fname=sprintf('%s/ipoints_%s_ptype%d_scshapeadapt',...
                ipointpath,char(imgnames(iii)),pointtype)
    save(fname,'sx2arr','nptsmax','imgname',...
               'posinit','posall','posevolall','posallarray','valallarray');
  end

  if 0 % show results
    fname=sprintf('%s/ipoints_%s_ptype%d_scshapeadapt',...
                ipointpath,char(imgnames(iii)),pointtype)
    load(fname);

    convflag=zeros(1,length(posall));
    for i=1:length(posall)
      if length(posall{i})>0
        convflag(i)=1;
      end
    end
    conv=sum(convflag)/length(convflag);
    disp(sprintf('Convergence: %2.1f%%',100*conv))
    convall=convall+conv;

    figure(gcf)
    clf, showgrey(f0)
    showellipticfeatures(posallarray);
    pause(0.1)
    pause
  end
end

%convall/length(imgnames)
