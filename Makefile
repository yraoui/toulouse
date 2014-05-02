CPP=g++
CFLAGS=`pkg-config --cflags opencv`
LIBS=`pkg-config --libs opencv`
LDLIBS=-lm  

all:prog

prog : fichier1.o fichier2.o fichier3.o
	$(CPP) $(CFLAGS) $(LIBS) -o prog fichier1.o fichier2.o fichier3.o $(LDLIBS)

fichier1.o : Fusion1.cpp
	$(CPP) $(CFLAGS) $(LIBS) -c robot.cpp

fichier2.o : robot.cpp 
	$(CPP) $(CFLAGS) $(LIBS) -c robot.cpp 

fichier3.o : monocularv.cpp 
	$(CPP) $(CFLAGS) -c $(LIBS) monocularv.cpp 

clean :    rm  -f prog *.o core


