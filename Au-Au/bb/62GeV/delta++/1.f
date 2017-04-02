        EXTERNAL FS,F
	DIMENSION JS(3),X(3),bbx(9),eby(9)
	DOUBLE PRECISION F,S,X,TAU,ELAB,Xmass,ELAB2,ELAB1
        DOUBLE PRECISION y0,RR,bb,Emin,Emax,CMS
	DOUBLE PRECISION yy,tau1,tau2,lambda,bbx,eby
	DOUBLE PRECISION S1,S2,S3,S4,S5,S6,S7,S8,S9
	DATA JS/4,4,4/
       open(112,file='delta-624_lambda0.3R-bb1.dat',status='unknown')
        open(111,file='eB_624_bb.dat',status='old') 
	N=3
	RR=7.0 
	  lambda=0.3*RR	
	Xmass=0.939
	  ELAB=31.2
	  y0=yy(ELAB)
	TAU1=2.0*RR*exp(-y0) 
	tau=tau1

	do ii=1,9
	  read(111,*) bbx(ii),eby(ii)
	enddo


	  bb=bbx(1)
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S1=(eby(1)/(197.5*197.5))**2*S
	   WRITE(112,*) bb,S1

	  bb=bbx(2)
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S2=(eby(2)/(197.5*197.5))**2*S
	   WRITE(112,*) bb,S2

	  bb=bbx(3)
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S3=(eby(3)/(197.5*197.5))**2*S
	   WRITE(112,*) bb,S3

	  bb=bbx(4)
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S4=(eby(4)/(197.5*197.5))**2*S
	   WRITE(112,*) bb,S4

	  bb=bbx(5)
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S5=(eby(5)/(197.5*197.5))**2*S
	   WRITE(112,*) bb,S5

	  bb=bbx(6)
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S6=(eby(1)/(197.5*197.5))**2*S
	   WRITE(112,*) bb,S6

	  bb=bbx(7)
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S7=(eby(7)/(197.5*197.5))**2*S
	   WRITE(112,*) bb,S7

	  bb=bbx(8)
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S8=(eby(8)/(197.5*197.5))**2*S
	   WRITE(112,*) bb,S8

	  bb=bbx(9)
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S9=(eby(9)/(197.5*197.5))**2*S
	   WRITE(112,*) bb,S9

	close(0)
	return
	END

**************************************************************************
**************************************************************************

	SUBROUTINE FS(J,N,X,DN,UP,RR,bb,y0)
	DIMENSION X(N)
	DOUBLE PRECISION X,DN,UP,Q,RR,bb,y0
	IF (J.EQ.1) THEN
	  DN=-RR+bb/2.0
	  UP=0.0
	ELSE IF (J.EQ.2) THEN
	  DN=-SQRT(RR**2-(X(1)-0.5*bb)*(X(1)-0.5*bb))
	  UP=SQRT(RR**2-(X(1)-0.5*bb)*(X(1)-0.5*bb))
	ELSE IF (J.EQ.3) THEN
	  DN=2.0*7.0*exp(-y0)
	  UP=15.0
	END IF
	RETURN
	END

	function F(n,x,TAU,y0,RR,bb,lambda)
	dimension x(n)

	double precision f,x,y0,TAU,RR,bb,lambda
	double precision aksi,ataui,atau,exp11,exp22

	ataui=tau
        exp11=exp(-2.0*(1.0/lambda)*abs(sqrt(RR*RR-(x(1)
     *      -0.5*bb)**2)-x(2)))
	exp22=exp(-2.0*(1.0/lambda)*abs(sqrt(RR*RR-(x(1)
     *      -0.5*bb)**2)+x(2)))
        
 
	aksi=exp11+exp22	
 
        atau=(ataui/x(3))*ataui*exp((-1.0/27.0)*
     *       (x(3)*x(3)-ataui*ataui))

         f=2.0*(25.0/81.0)*aksi*atau
	
	RETURN
	END

	function yy(ELAB)
	double precision yy,Xmass,ELAB,ELAB1,ELAB2
	Xmass=0.938
	ELAB1=ELAB+sqrt(ELAB*ELAB-Xmass*Xmass)  
        ELAB2=ELAB-sqrt(ELAB*ELAB-Xmass*Xmass)
        yy=0.5*log(ELAB1/ELAB2)
        return
	end

*****************************************************************************
*****************************************************************************

	SUBROUTINE FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
	DIMENSION JS(N),X(N)
	DIMENSION T(5),C(5),D(2,11),CC(11),IS(2,11)
	DOUBLE PRECISION X,F,S,T,C,D,CC,DN,UP,P,TAU
        DOUBLE PRECISION y0,RR,bb,lambda
	DATA T/-0.9061798459,-0.5384693101,0.0,
     *         0.5384693101,0.9061798459/
	DATA C/0.2369268851,0.4786286705,0.5688888889,
     *         0.4786286705,0.2369268851/
	M=1
	D(1,N+1)=1.0
	D(2,N+1)=1.0
10	DO 20 J=M,N
	  CALL FS(J,N,X,DN,UP,RR,bb,y0)
	  D(1,J)=0.5*(UP-DN)/JS(J)
	  CC(J)=D(1,J)+DN
	  X(J)=D(1,J)*T(1)+CC(J)
	  D(2,J)=0.0
	  IS(1,J)=1
	  IS(2,J)=1
20	CONTINUE

	J=N
30	K=IS(1,J)
	IF (J.EQ.N) THEN
	  P=F(N,X,TAU,y0,RR,bb,lambda)
	ELSE
	  P=1.0
	END IF
	D(2,J)=D(2,J+1)*D(1,J+1)*P*C(K)+D(2,J)
	IS(1,J)=IS(1,J)+1
	IF (IS(1,J).GT.5) THEN
	  IF (IS(2,J).GE.JS(J)) THEN
	    J=J-1
	    IF (J.EQ.0) THEN
	      S=D(2,1)*D(1,1)
	      RETURN
	    END IF
	    GOTO 30
	  END IF
	  IS(2,J)=IS(2,J)+1
	  CC(J)=CC(J)+D(1,J)*2.0
	  IS(1,J)=1
	END IF
	K=IS(1,J)
	X(J)=D(1,J)*T(K)+CC(J)
	IF (J.EQ.N) GOTO 30
	M=J+1
	GOTO 10
	END

