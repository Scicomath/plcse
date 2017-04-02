	EXTERNAL FS,F
	DIMENSION JS(4),X(4)
	DOUBLE PRECISION F,S,X,TAU,ELAB,Xmass,ELAB2,ELAB1
        DOUBLE PRECISION y0,b0,RR,bb,bmin,bmax,AA1,Emin,Emax,CMS
	DOUBLE PRECISION tau1,tau2,yy
	DATA JS/4,4,4,4/
        open(11,file='eB_p22_200_bb.dat',status='unknown')
	N=4
	Xmass=0.939
	bmin=0.0
	bmax=14.0
	RR=7.0 
	  ELAB=100.0
	  y0=yy(ELAB)
	TAU1=2.0*RR*exp(-y0) 
	tau=tau1


	do ii=0,200
	  bb=bmin+((bmax-bmin)/200.)*float(ii)
	  CALL FGAUS(N,JS,X,FS,F,S,TAU,y0,RR,bb)
	  WRITE(11,*) bb,S
	enddo

	close(0)
	return
	END


*****************************************************************************
*****************************************************************************

	SUBROUTINE FS(J,N,X,DN,UP,y0,RR,bb)
	DIMENSION X(N)
	DOUBLE PRECISION X,DN,UP,Q,RR,bb,y0
	IF (J.EQ.1) THEN
	  DN=-y0
	  UP=y0
	ELSE IF (J.EQ.2) THEN
	  DN=0.0
	  UP=(RR-bb/2.0)
	ELSE IF (J.EQ.3) THEN
	  DN=0.0
	  UP=SQRT(RR*RR-(X(2)+0.5*bb)*(X(2)+0.5*bb))
	ELSE IF (J.EQ.4) THEN
	  DN=-RR
	  UP=RR
	END IF
	RETURN
	END


	function F(n,x,TAU,y0,RR,bb)
	dimension x(n)
	double precision f,x,alpha,y0,TAU,RR,bb,fy
	double precision rho_po,rho_ne,xn_r,Z,ff1,a
	integer theta_po,theta_ne

	Z=79.00000
	alpha=0.007299273
	pi=3.14159265
	a=0.5
	
	aa1=2.0*(RR*RR-(x(2)+0.5*bb)**2-x(3)**2)**(0.5)
	xn_r=1.0+exp((sqrt((x(2)+0.5*bb)*(x(2)+0.5*bb)
     *         +x(3)*x(3)+x(4)*x(4))-RR)/0.54)
	rho_po=0.17/(157.0*xn_r)

	fy=a/(2.0*sinh(a*y0))*exp(a*x(1))
	ff1=(x(2)*x(2)+x(3)*x(3)+tau*tau*sinh(x(1))*sinh(x(1)))**(1.5)
	f=197.5*197.5*Z*alpha*fy*sinh(x(1))*rho_po*x(2)/ff1

	RETURN
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
	DOUBLE PRECISION X,F,S,T,C,D,CC,DN,UP,P,TAU,y0
         DOUBLE PRECISION RR,bb
	DATA T/-0.9061798459,-0.5384693101,0.0,
     *         0.5384693101,0.9061798459/
	DATA C/0.2369268851,0.4786286705,0.5688888889,
     *         0.4786286705,0.2369268851/
	M=1
	D(1,N+1)=1.0
	D(2,N+1)=1.0
10	DO 20 J=M,N
	  CALL FS(J,N,X,DN,UP,y0,RR,bb)
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

