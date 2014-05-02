#include <iostream>
#include <vector.h>
#include <cv.h>
#include <fstream>
#include <highgui.h>
#include <iostream>
#include <string>

using namespace std;
 
IplImage* map_simulated(){
CvCapture* capture=cvCaptureFromCAM(CV_CAP_ANY);
if(!capture){
fprintf(stderr,"Erreur de capture");
getchar();
return NULL;
}
}



int main(){

IplImage* scene;

scene=map_simulated();


return 0;
}





