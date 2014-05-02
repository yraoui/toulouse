#include <iostream.h>
#include <string.h>
#include <cv.h>
#include <highgui.h>
#include <math.h>
#include  "sterio_interpretation.cpp"
#include <eigen3/Eigen/Dense>
#include "robot.cpp"
//#include "RFID.h"
#include "Vision.cpp"
#include "Utilities.cpp"
#define pi 3.14


using namespace std;
typedef vector<string> Vec;
typedef vector<Vec> Mat;

void motor(int vitesse,MatrixXd u,int v){
int i;
Robot *r= new Robot(25);
Utilities  utili;
VectorXd motionStep(3),X_next(3);
MatrixXd cloud_partic(100,3);
VectorXd X(3),tag(2),X_pred(3);
for(i=0;i<1;i++){
X(0)=r->xrl.at(i);
X(1)=r->yrl.at(i);
X(2)=r->thetarl.at(i);
motionStep(0)=u(i,0);
motionStep(1)=u(i,1);
motionStep(2)=u(i,2);
X_next=utili.tcomp(X,motionStep);
X_pred=r->prediction(X_next);
cloud_partic=r->cloud_particles(X_pred);
cout<<" Xpred: "<<X_pred;
cout<<endl;

cout<<" cloud_partic: "<<cloud_partic;
}
}

Vision* initialisation(){
Vision *myWork;
IplImage* image_r=cvLoadImage("images.jpg");
IplImage* image_l=cvLoadImage("ResPiro.jpg");
IplImage* image_c=cvLoadImage("ResPiro.jpg");
myWork=new Vision(image_r,image_l,image_c);
return myWork;
}

void macCamera(){
Vision *init=initialisation();

Vision *ptr=new Vision(init->imageLeft,init->imageRight,init->imageCenter);
Mat descriptor; 
Vec v_desc;
Vec x;
int k=0;
int i;
Vec tempom;
IplImage* scene;
ptr=initialisation();
while(k++<2){
scene=ptr->map_simulated();
//cvShowImage("image captured",scene);

descriptor=ptr->clustering();
//ptr->drawFeatures(scene, x,ptr->numberOfFeatures);

}

free(ptr);

free(init);
}



void analog(int port){

switch (port)
{
//case 1: rfid();
case 2: macCamera();
}
}


void rfid(){// to do
}

int main(){

Utilities gu;
int i;
float s1=0.0,s2=0.0,s3=0.0;

Fusion f;
int *xr;
int *yr;
float *thetar;
xr=f.VectXr;
yr=f.VectYr;
thetar=f.VectTheta;

int compt=0;

while(compt<N){
X(0)=xr[compt];
X(1)=yr[compt];
X(2)=thetar[compt];

//f.fuse(X);

}
}



Robot *r= new Robot(25);
MatrixXd cloud_partic(100,3);
VectorXd motionStep(3),X_next(3);
cout<<r->numberOfSteps;
VectorXd Xrobot(r->numberOfSteps),Yrobot(r->numberOfSteps),AngleRobot(r->numberOfSteps);
VectorXd weight(100);
VectorXd X(3),tag(2),X_pred(3);
MatrixXd u(r->numberOfSteps,3);
Utilities  utili;
for(i=0;i<r->numberOfSteps-1;i++){
u(i,0)=r->xrl.at(i+1)- r->xrl.at(i)  ;
u(i,1)=r->yrl.at(i+1)-r->yrl.at(i);
u(i,2)=r->thetarl.at(i+1)-r->thetarl.at(i);
}

int v=2;

analog(2);
return 0;
}





