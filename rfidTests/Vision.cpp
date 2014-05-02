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

void disparityComputation(){
IplImage *dst;
vector<CvPoint3D32f> pointArray;
double _Q[] = { 1., 0., 0., -3.2554532241821289e+002, 0., 1., 0., -2.4126087760925293e+002, 0., 0., 0., 4.2440051858596559e+002, 0., 0., -2.9937622423123672e-001, 0. }; 
IplImage* Image;
IplImage* Image3D=cvLoadImage("images.jpg");
CvMat *Q;
cvInitMatHeader(Q,4,4,CV_32FC1,_Q);
dst=cvCreateImage(cvSize(500,500),Image3D->depth,Image3D->nChannels);


IplImage* realDisparity=cvCreateImage(cvSize(dst->width,dst->height),CV_32FC1,1);

cvReprojectImageTo3D(realDisparity, Image, Q);
CvPoint3D32f Point;
int y;

CvMat* Image1 = cvCreateMat(cvSize(dst->width,dst->height),IPL_DEPTH_8U,1);   
for(y=0;y<Image1->rows;y++){
float *data=(float*)(Image1->data.ptr+y*Image1->step);

for(int x=0;x<Image1->cols*3;x+=3){

Point.x=data[x];
Point.y=data[x+1];
Point.z=data[x+2];

//pointArray.push_back(Point);
}

}


}




int main(){

IplImage* scene;

disparityComputation();


return 0;
}





