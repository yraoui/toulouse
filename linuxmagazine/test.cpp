#include<vector>
#include<iostream>


using namespace std;
namespace monespace{

int factoriell(int n){
int fa=1;

while(n-->0)

fa=fa*n;

return fa;
}



}
using namespace monespace;
int main(){
factoriell(2);
vector<int> tbl1(3);

tbl1[0]=10;
tbl1[1]=5;
tbl1[2]=3;
tbl1[3]=1;
//for(unsigned i=0;i<tbl1.size();i++)
//cout<<tbl1[i]<<endl;

vector<int>::iterator it;

vector<int> tbl3(tbl1.begin()+1,tbl1.begin()+3);


for(auto x:tbl3)
cout<<x<<endl;


for(it=tbl3.begin();it!=tbl3.end();++it)
cout<<*it;

return 0;
}
