/*1:*/
#line 23 "./aixin.w"

/*2:*/
#line 41 "./aixin.w"

#include <stdio.h> 
#include <stdlib.h> 
#include <gsl/gsl_math.h> 
#include <math.h> 
#include <string.h> 
#include <cuba.h> 

/*:2*/
#line 24 "./aixin.w"

/*3:*/
#line 50 "./aixin.w"

double Sq(double num);
double Pow3(double num);
double rhoFun(double xp,double yp,double zp);
double f(double Y);
static int eB_Part_Int(const int*ndim,const double xx[],const int*ncomp,double ff[],void*userdata);
static int eB_Spec_Int(const int*ndim,const double xx[],const int*ncomp,double ff[],void*userdata);
int eB(double*eBy,double*totalerror,const int verbose);
double xifun(double xp,double yp,char sign);
static int delta_pp_Int(const int*ndim,const double xx[],const int*ncomp,double ff[],void*userdata);
static int delta_pm_Int(const int*ndim,const double xx[],const int*ncomp,double ff[],void*userdata);
int csefun(double*app,double*apm,double*delta_pp,double*delta_pm);
int main(int argc,char**argv);
double sqrtStoY(double sqrtS);


/*:3*/
#line 25 "./aixin.w"

/*5:*/
#line 76 "./aixin.w"

static const double alpha_EM= 1.0/137.0;
static const double hbarc= 197.32696;

static double R;
static double b;
static double d;
static double n0;
static double Y0;
static double t;
static double t0;
static double eBy0;
static double x,y,z;
static double Z;
static double a;
static char flag;
static double lambda;
static double Np,Nm;

static int nvec= 1;
static double epsrel;
static double epsabs;
static int flags;
static int seed;
static int pmineval;
static int pmaxeval;
static int smineval;
static int smaxeval;
static int mineval;
static int maxeval;
static int nstart;
static int nincrease;
static int nbatch;
static int gridno;

static int nnew;
static int nmin;

static double flatness;

static int key1;
static int key2;
static int key3;
static int maxpass;
static double border;
static double maxchisq;
static double mindeviation;
static int ngiven;
static int ldxgiven;
static int nextra;

static int key;

static char*statefile;
static void*spin;

/*:5*/
#line 26 "./aixin.w"

/*4:*/
#line 67 "./aixin.w"

double Sq(double num){
return num*num;
}
double Pow3(double num){
return num*num*num;
}

/*:4*/
#line 27 "./aixin.w"

/*7:*/
#line 159 "./aixin.w"

double rhoFun(double xp,double yp,double zp){



double rho;
double len;
double gamma;
double sign= 1.0;
gamma= cosh(Y0);

if(flag=='+'){
sign= 1.0;
}else if(flag=='-'){
sign= -1.0;
}else{
printf("[rhoFun]error: nucleus type(flag) should be '+' or '-'\n");
}

len= sqrt(Sq(xp+sign*b/2.0)+Sq(yp)+Sq(gamma*zp));
rho= gamma*n0/(1.0+exp((len-R)/d));

return rho;
}


/*:7*/
#line 28 "./aixin.w"

/*8:*/
#line 189 "./aixin.w"

double f(double Y){
return(a*exp(a*Y))/(2*sinh(a*Y0));
}


/*:8*/
#line 29 "./aixin.w"

/*12:*/
#line 246 "./aixin.w"

static int eB_Part_Int(const int*ndim,const double xx[],const int*ncomp,
double ff[],void*userdata){





struct userdata*ud= (struct userdata*)userdata;
static double sign;
static double jacobian;
static double denominator;

static double xp;
static double yp;
static double zp;
static double Y;

static double Imin[4];
static double Imax[4];
static double gamma;
static double extra;

gamma= cosh(Y0);
extra= 3;

Imin[0]= b/2.0-R;
Imax[0]= -Imin[0];

xp= Imin[0]+(Imax[0]-Imin[0])*xx[0];

Imin[1]= -sqrt(Sq(R)-Sq(fabs(xp)+b/2.0));
Imax[1]= -Imin[1];

yp= Imin[1]+(Imax[1]-Imin[1])*xx[1];

Imin[2]= -(R+extra)/(gamma);
Imax[2]= -Imin[2];

zp= Imin[2]+(Imax[2]-Imin[2])*xx[2];

Imin[3]= -Y0;
Imax[3]= Y0;

Y= Imin[3]+(Imax[3]-Imin[3])*xx[3];

if(flag=='+')
sign= 1.0;
else
sign= -1.0;


double temp= (sign*t)*sinh(Y)-z*cosh(Y);

denominator= pow(Sq(xp-x)+Sq(yp-y)+
Sq(temp),1.5);
ff[0]= sign*Sq(hbarc)*Z*alpha_EM*f(Y)*sinh(Y)*rhoFun(xp,yp,zp)*(x-xp)/denominator;


jacobian= 1.0;
for(int i= 0;i<*ndim;i++){
jacobian= jacobian*(Imax[i]-Imin[i]);
}
ff[0]= jacobian*ff[0];


return 0;
}

/*:12*/
#line 30 "./aixin.w"

/*13:*/
#line 316 "./aixin.w"

static int eB_Spec_Int(const int*ndim,const double xx[],const int*ncomp,
double ff[],void*userdata){







static double sign;
static double jacobian;
static double denominator;

static double phip;
static double xpperp;
static double zp;
static double xp;
static double yp;

static double Imin[3];
static double Imax[3];
static double gamma;
static double extra;

gamma= cosh(Y0);
extra= 3;

if(flag=='+'){
sign= 1.0;
Imin[0]= M_PI/2.0;
Imax[0]= 3.0*M_PI/2.0;

phip= Imin[0]+(Imax[0]-Imin[0])*xx[0];
}else{
sign= -1.0;
Imin[0]= -M_PI/2.0;
Imax[0]= M_PI/2.0;

phip= Imin[0]+(Imax[0]-Imin[0])*xx[0];
}

Imin[1]= -b/2.0*fabs(cos(phip))+sqrt(Sq(R)-Sq(b)/4.0*Sq(sin(phip)));
Imax[1]= b/2.0*fabs(cos(phip))+sqrt(Sq(R)-Sq(b)/4.0*Sq(sin(phip)));

xpperp= Imin[1]+(Imax[1]-Imin[1])*xx[1];

Imin[2]= -(R+extra)/(gamma);
Imax[2]= -Imin[2];

zp= Imin[2]+(Imax[2]-Imin[2])*xx[2];

xp= xpperp*cos(phip);
yp= xpperp*sin(phip);


double temp= (sign*t)*sinh(Y0)-z*cosh(Y0);

denominator= pow(Sq(xp-x)+Sq(yp-y)+
Sq(temp),1.5);
ff[0]= sign*Sq(hbarc)*Z*alpha_EM*sinh(Y0)*xpperp*rhoFun(xp,yp,zp)*(x-xp)/denominator;



jacobian= 1.0;
for(int i= 0;i<*ndim;i++){
jacobian= jacobian*(Imax[i]-Imin[i]);
}
ff[0]= jacobian*ff[0];

return 0;
}

/*:13*/
#line 31 "./aixin.w"

/*14:*/
#line 390 "./aixin.w"

int eB(double*eBy,double*totalerror,const int verbose){
int comp,nregions,neval,fail;
double integral,interror,prob;
double eBp_plus,eBp_minus,eBs_plus,eBs_minus;
double constant;

*totalerror= 0.0;

flag= '+';
Vegas(4,1,eB_Part_Int,NULL,nvec,epsrel,epsabs,flags,seed,
pmineval,pmaxeval,nstart,nincrease,nbatch,gridno,
statefile,spin,&neval,&fail,&eBp_plus,&interror,&prob);
*totalerror+= interror;
flag= '-';
Vegas(4,1,eB_Part_Int,NULL,nvec,epsrel,epsabs,flags,seed,
pmineval,pmaxeval,nstart,nincrease,nbatch,gridno,
statefile,spin,&neval,&fail,&eBp_minus,&interror,&prob);
*totalerror+= interror;


flag= '+';
Vegas(3,1,eB_Spec_Int,NULL,nvec,epsrel,epsabs,flags,seed,
smineval,smaxeval,nstart,nincrease,nbatch,gridno,
statefile,spin,&neval,&fail,&eBs_plus,&interror,&prob);
*totalerror+= interror;
flag= '-';
Vegas(3,1,eB_Spec_Int,NULL,nvec,epsrel,epsabs,flags,seed,
smineval,smaxeval,nstart,nincrease,nbatch,gridno,
statefile,spin,&neval,&fail,&eBs_minus,&interror,&prob);
*totalerror+= interror;
*eBy= eBp_plus+eBp_minus+eBs_plus+eBs_minus;

return 0;
}

/*:14*/
#line 32 "./aixin.w"

/*21:*/
#line 633 "./aixin.w"

double sqrtStoY(double sqrtS){
double E,p,m,Y;
m= 0.938272;
E= sqrtS/2;
p= sqrt(Sq(E)-Sq(m));
Y= 0.5*log((E+p)/(E-p));
return Y;
}

/*:21*/
#line 33 "./aixin.w"

/*16:*/
#line 450 "./aixin.w"

double xifun(double xp,double yp,char sign)
{
double y_plus,y_minus;
y_plus= sqrt(Sq(R)-Sq(fabs(xp)+b/2.0));
y_minus= -y_plus;
if(sign=='+'){
return exp(-fabs(y_plus-yp)/lambda);
}else{
return exp(-fabs(y_minus-yp)/lambda);
}
}

/*:16*/
#line 34 "./aixin.w"

/*17:*/
#line 464 "./aixin.w"

static int delta_pp_Int(const int*ndim,const double xx[],const int*ncomp,double ff[],void*userdata)
{
static double jacobian;
static double xp;
static double yp;
static double tau;

static double Imin[3];
static double Imax[3];
static double result;
static double kappa= 1.0,alpha_s= 1.0,sumqf22= 25.0/81.0;
static double xi_plus,xi_minus;

Imin[0]= b/2.0-R;
Imax[0]= -Imin[0];
xp= Imin[0]+(Imax[0]-Imin[0])*xx[0];
Imin[1]= -sqrt(Sq(R)-Sq(fabs(xp)+b/2.0));
Imax[1]= -Imin[1];
yp= Imin[1]+(Imax[1]-Imin[1])*xx[1];
Imin[2]= 2.0*R*exp(-Y0);
Imax[2]= 15.0;
tau= Imin[2]+(Imax[2]-Imin[2])*xx[2];

xi_plus= xifun(xp,yp,'+');
xi_minus= xifun(xp,yp,'-');

result= 2.0*kappa*alpha_s*sumqf22*(Sq(xi_plus)+Sq(xi_minus))*Sq(t0)/tau*exp(-1.0/27.0*(Sq(tau)-Sq(t0)))*Sq(eBy0);

jacobian= 1.0;
for(int i= 0;i<*ndim;i++){
jacobian= jacobian*(Imax[i]-Imin[i]);
}
ff[0]= jacobian*result;

return 0;
}

/*:17*/
#line 35 "./aixin.w"

/*18:*/
#line 503 "./aixin.w"

static int delta_pm_Int(const int*ndim,const double xx[],const int*ncomp,double ff[],void*userdata)
{
static double jacobian;
static double xp;
static double yp;
static double tau;

static double Imin[3];
static double Imax[3];
static double result;
static double kappa= 1.0,alpha_s= 1.0,sumqf22= 25.0/81.0;
static double xi_plus,xi_minus;

Imin[0]= b/2.0-R;
Imax[0]= -Imin[0];
xp= Imin[0]+(Imax[0]-Imin[0])*xx[0];
Imin[1]= -sqrt(Sq(R)-Sq(fabs(xp)+b/2.0));
Imax[1]= -Imin[1];
yp= Imin[1]+(Imax[1]-Imin[1])*xx[1];
Imin[2]= 2.0*R*exp(-Y0);
Imax[2]= 15.0;
tau= Imin[2]+(Imax[2]-Imin[2])*xx[2];

xi_plus= xifun(xp,yp,'+');
xi_minus= xifun(xp,yp,'-');

result= -4.0*kappa*alpha_s*sumqf22*xi_plus*xi_minus*Sq(t0)/tau*exp(-1.0/27.0*(Sq(tau)-Sq(t0)))*Sq(eBy0);

jacobian= 1.0;
for(int i= 0;i<*ndim;i++){
jacobian= jacobian*(Imax[i]-Imin[i]);
}
ff[0]= jacobian*result;

return 0;
}

/*:18*/
#line 36 "./aixin.w"

/*19:*/
#line 545 "./aixin.w"

int csefun(double*app,double*apm,double*delta_pp,double*delta_pm)
{
int comp,nregions,neval,fail;
double integral,interror,prob;

Vegas(3,1,delta_pp_Int,NULL,nvec,epsrel,epsabs,flags,seed,mineval,maxeval,nstart,nincrease,nbatch,gridno,statefile,spin,&neval,&fail,delta_pp,&interror,&prob);
Vegas(3,1,delta_pm_Int,NULL,nvec,epsrel,epsabs,flags,seed,mineval,maxeval,nstart,nincrease,nbatch,gridno,statefile,spin,&neval,&fail,delta_pm,&interror,&prob);

*app= 1.0/Sq(Np)*Sq(M_PI)/16.0*(*delta_pp);
*apm= 1.0/(Np*Nm)*Sq(M_PI)/16.0*(*delta_pm);
return 0;
}

/*:19*/
#line 37 "./aixin.w"

/*20:*/
#line 560 "./aixin.w"

int main(int argc,char**argv)
{
double eBy,totalerror,app,apm,delta_pp,delta_pm;
double tempb,tempNpm;
int verbose;
FILE*fp;

nvec= 1;
epsrel= 0.01;
epsabs= 0.5;
flags= 0|8;
seed= 0;
smineval= 1.5e4;
smaxeval= 4e6;
pmineval= 2e4;
pmaxeval= 1e7;
mineval= 1e5;
maxeval= 1e7;
nstart= 1000;
nincrease= 500;
nbatch= 1000;
gridno= 0;
statefile= NULL;
spin= NULL;


if(argc!=5){
printf("Error: must have 4 parameters!\n"
"Usage: aixin Au/Pb/Cu sqrtS lambda Nfile \n");
return 0;
}


/*22:*/
#line 664 "./aixin.w"

if(strcmp(argv[1],"Au")==0){
R= 6.38;
d= 0.535;
n0= 8.59624e-4;
Z= 79.0;
}else if(strcmp(argv[1],"Pb")==0){
R= 6.624;
d= 0.549;
n0= 7.69244e-4;
Z= 82.0;
}else if(strcmp(argv[1],"Cu")==0){
R= 4.214;
d= 0.586;
n0= 2.67894e-3;
Z= 29.0;
}else{
printf("Error: the first parameter must be 'Au' or 'Pb' or 'Cu'!\n");
return 0;
}

/*:22*/
#line 594 "./aixin.w"

Y0= sqrtStoY(atof(argv[2]));
lambda= atof(argv[3])*R;
fp= fopen(argv[4],"r");
if(fp==NULL){
printf("Error: Can't open %s\n",argv[4]);
exit(EXIT_FAILURE);
}
a= 0.5;
x= 0.0;
y= 0.0;
z= 0.0;
t0= 2.0*R*exp(-Y0);
t= t0;
printf("# app, apm, abs(apm)/app\n");
while(fscanf(fp,"%lf%lf",&tempb,&tempNpm)==2){
b= tempb;
Np= tempNpm/2.0;
Nm= tempNpm/2.0;
eB(&eBy,&totalerror,0);
eBy0= eBy/Sq(hbarc);
csefun(&app,&apm,&delta_pp,&delta_pm);
printf("%g, %g, %g\n",app,apm,fabs(apm)/app);
}
return 0;
}

/*:20*/
#line 38 "./aixin.w"


/*:1*/
