
	EXTERNAL FS,F
	DIMENSION JS(3),X(3)
	DOUBLE PRECISION F,S,X,TAU,ELAB,Xmass,ELAB2,ELAB1
       DOUBLE PRECISION y0,b0,RR,bb,bmax,AA1,Emin,Emax,CMS
	DOUBLE PRECISION AA2,RR1,RR2,yy,tau1,tau2
	DATA JS/4,4,4/
        open(11,file='eB_s22_2760_bb.dat',status='unknown')

	N=3
	Xmass=0.939
	AA1=196.966569
        AA2=207.2
        RR1=1.2*AA1**(0.33333333)
	RR2=1.2*AA2**(0.33333333)

	  ELAB=1380.0
	  y0=yy(ELAB)
	TAU1=2.0*RR1*exp(-y0) 
	tau=tau1
	RR=8.0
 	  bb=2.32
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb)
	   WRITE(11,*) bb,S
	  bb=4.46 
         CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb)
	   WRITE(11,*) bb,S
	    bb=6.30
	    CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb)
	   WRITE(11,*) bb,S
	    bb=8.02
	    CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb)
	   WRITE(11,*) bb,S
	    bb=9.43
	    CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb)
	   WRITE(11,*) bb,S
	    bb=10.65
	    CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb)
	   WRITE(11,*) bb,S
	   bb=11.74
	    CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb)
	   WRITE(11,*) bb,S
	    bb=12.73
	    CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb)
	   WRITE(11,*) bb,S
	    bb=13.66
	    CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb)
	   WRITE(11,*) bb,S
	close(0)

	return
	END

**************************************************************************
**************************************************************************
	SUBROUTINE FS(J,N,X,DN,UP,RR,bb)
	DIMENSION X(N)
	DOUBLE PRECISION X,DN,UP,Q,RR,bb
	IF (J.EQ.1) THEN
	  DN=RR-bb/2.0
	  UP=RR+bb/2.0
	ELSE IF (J.EQ.2) THEN
	  DN=0.0
	  UP=SQRT(RR**2-(X(1)-0.5*bb)*(X(1)-0.5*bb))
	ELSE IF (J.EQ.3) THEN
	  DN=-RR
	  UP=RR
	END IF
	RETURN
	END

	function F(n,x,TAU,y0,RR,bb)
	dimension x(n)
	double precision f,x,alpha,y0,TAU,RR,bb
	double precision rho_po,rho_ne,xn_r,Z,ff1
	integer theta_po,theta_ne

	Z=82.00000
	alpha=0.007299273
	pi=3.14159265

	aa1=2.0*(RR**2-(x(1)-0.5*bb)**2-x(2)**2)**(0.5)
	xn_r=1+exp((((x(1)-0.5*bb)*(x(1)-0.5*bb)+
     *       x(2)*x(2)+x(3)*x(3))**0.5-RR)/0.54)
	rho_po=0.17/(157.0*xn_r)
*	write(*,*) 'y0, Rr, bb ===============================',y0,RR,bb
	ff1=(x(1)*x(1)+x(2)*x(2)+tau*tau*sinh(y0)*sinh(y0))**(1.5)
	F=197.5*197.5*Z*alpha*sinh(y0)*rho_po*x(1)/ff1

*	write(*,*) 'xn_r,rho_po,ff1,F',xn_r,rho_po,ff1,F

	return
	END

	function yy(ELAB)
	double precision yy,xmass,ELAB,ELAB1,ELAB2
	xmass=0.938
	ELAB1=ELAB+sqrt(ELAB*ELAB-Xmass*Xmass)  
       ELAB2=ELAB-sqrt(ELAB*ELAB-Xmass*Xmass)
       yy=0.5*log(ELAB1/ELAB2)
       return
	end


*****************************************************************************
*****************************************************************************
	SUBROUTINE FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb)
	DIMENSION JS(N),X(N)
	DIMENSION T(5),C(5),D(2,11),CC(11),IS(2,11)
	DOUBLE PRECISION X,F,S,T,C,D,CC,DN,UP,P,TAU
	DOUBLE PRECISION y0,RR,bb
	DATA T/-0.9061798459,-0.5384693101,0.0,
     *         0.5384693101,0.9061798459/
	DATA C/0.2369268851,0.4786286705,0.5688888889,
     *         0.4786286705,0.2369268851/
	M=1
	D(1,N+1)=1.0
	D(2,N+1)=1.0
10	DO 20 J=M,N
	  CALL FS(J,N,X,DN,UP,RR,bb)
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
	  P=F(N,X,TAU,y0,RR,bb)
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




