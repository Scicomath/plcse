        EXTERNAL FS,F
	DIMENSION JS(3),X(3),eex(10001),eey(10001)
	DOUBLE PRECISION F,S,X,TAU,ELAB,Xmass,ELAB2,ELAB1
        DOUBLE PRECISION y0,RR,bb,Emin,Emax,CMS
	DOUBLE PRECISION yy,tau1,tau2,lambda,eex,eey
	DOUBLE PRECISION S1,S2,S3,S4,S5,S6,S7,S8,S9
	DATA JS/4,4,4/
      open(11,file='eB_b4fm_CMS.dat',status='old') 
        open(22,file='eB_b8fm_CMS.dat',status='old')
        open(111,file='delta-b4fm_lambda0.1R-CMS1.dat',
     *      status='unknown')
          open(112,file='delta-b4fm_lambda0.2R-CMS1.dat',
     *      status='unknown')
        open(113,file='delta-b4fm_lambda0.3R-CMS1.dat',
     *      status='unknown')

       open(221,file='delta-b8fm_lambda0.1R-CMS1.dat',
     *      status='unknown')
          open(222,file='delta-b8fm_lambda0.2R-CMS1.dat',
     *      status='unknown')
        open(223,file='delta-b8fm_lambda0.3R-CMS1.dat',
     *      status='unknown')
 
	N=3
	Xmass=0.939
	RR=8.0 

	  bb=4.0
	 do ii=1,10001
	  read(11,*) eex(ii),eey(ii)
          CMS=eex(ii)
	  ELAB=CMS/2.0
	  y0=yy(ELAB)
	  tau=2.0*RR*exp(-y0)
	  lambda=0.1*RR
          CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S1=(eey(ii)/(197.5*197.5))**2*S
	   WRITE(111,*) CMS,S1

	  lambda=0.2*RR
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S2=(eey(ii)/(197.5*197.5))**2*S
	   WRITE(112,*) CMS,S2

	  lambda=0.3*RR
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S3=(eey(ii)/(197.5*197.5))**2*S
	   WRITE(113,*) CMS,S3
	  enddo

	  bb=8.0
	do ii=1,10001
	  read(22,*) eex(ii),eey(ii)
          CMS=eex(ii)
	  ELAB=CMS/2.0
	  y0=yy(ELAB)
	  tau=2.0*RR*exp(-y0)
	  lambda=0.1*RR
          CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S4=(eey(ii)/(197.5*197.5))**2*S
	   WRITE(221,*) CMS,S4

	  lambda=0.2*RR
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S5=(eey(ii)/(197.5*197.5))**2*S
	   WRITE(222,*) CMS,S5

	  lambda=0.3*RR
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb,lambda)
           S6=(eey(ii)/(197.5*197.5))**2*S
	   WRITE(223,*) CMS,S6
	  enddo


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
	  DN=2.0*8.0*exp(-y0)
	  UP=16.0
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

         f=10.0*2.0*(25.0/81.0)*aksi*atau
	
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
	  CALL FS(J,N,X,DN,UP,RR,bb,lambda)
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

