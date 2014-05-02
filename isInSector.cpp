

/*unction answer = isInSector( x_center, y_center, angle_offset, angle, x, y )
%ISINSECTOR returns true if the 2D point (x,y) is in the infinite angular
% sector centered in (x_center, y_center), starting at the angle angle_offset
% and with an aperture of angle

first_line = [sin(angle_offset); -cos(angle_offset); -x_center*sin(angle_offset) + y_center*cos(angle_offset)];
second_line = [sin(angle_offset+angle); -cos(angle_offset+angle); -x_center*sin(angle_offset+angle) + y_center*cos(angle_offset+angle)];
point = [x;y;1];

answer = ((point'*first_line <= 0) && (point'*second_line >= 0));

*/


#include <eigen3/Eigen/Dense>
#include <iostream>
#include <stdio.h>
#include <math.h>

using namespace Eigen;


bool isInSector(float x_center,float y_center,float angle_offset,float angle, float x,float y){

VectorXd first_line(3),second_line(3);
first_line(0)=sin(angle_offset);
first_line(1)=-cos(angle_offset);
first_line(2)=-x_center*sin(angle_offset)+y_center*cos(angle_offset);
second_line(0)=sin(angle_offset+angle);
second_line(1)=-cos(angle_offset+angle);
second_line(2)=-x_center*sin(angle_offset+angle)+y_center*cos(angle_offset+angle);


if((x*first_line(0)+y*first_line(1)+first_line(2)<0)&&(x*second_line(0)+y*second_line(1)+second_line(2)<0))
 return true;
else return false;



}


int main(int n, float *params){

float x_center=params[1];
float y_center=params[2];
float angle_offset=params[3];
float angle=params[4];
float x=params[5];
float y=params[6];

std::cout<<"youpi"<<isInSector( x_center, y_center, angle_offset, angle,  x, y);


return 1;


}