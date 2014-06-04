c=cell(10);
c{1}=imread('c2.jpg');
[pos1,pos_d]=program(c{1});
c{2}=imread('./imgs/img2.jpg');
pos2=program(c{2});
%distance=mahal(pos1,pos2);
