
	EXTERNAL FS,F
	DIMENSION JS(2),X(2)
	DOUBLE PRECISION F,S,X,TAU
	DATA JS/4,4/
	N=2
	
	open(1,file='eB_s22_64GeV_4fm.dat')
	DO I=1,60
	   TAU=0.05*I
	   CALL FGAUS(N,JS,X,FS,F,S,TAU)
	   WRITE(1,*) TAU,S
	ENDDO
	END

**************************************************************************
**************************************************************************

	SUBROUTINE FS(J,N,X,DN,UP)
	DIMENSION X(N)
	DOUBLE PRECISION X,DN,UP,Q
	IF (J.EQ.1) THEN
	  DN=4.37
	  UP=8.37
	ELSE IF (J.EQ.2) THEN
	  DN=0.0
	  UP=SQRT(6.37**2-(X(1)-2.0)**2)
	END IF
	RETURN
	END

	function f(n,x,TAU)
	dimension x(n)
	double precision f,x,alpha,y0,TAU
	double precision rho_po,rho_ne,n_r
	integer Z,theta_po,theta_ne

	Z=79
	alpha=0.007299273
	pi=3.14159265
	b0=4.0
	y0=4.19
	R=6.37
	
	aa1=2.0*(R**2-(x(1)-0.5*b0)**2-x(2)**2)**(0.5)
	n_r=0.17/(157.0*(1+exp((((x(1)-b0/2)**2+x(2)**2)**0.5-R)/0.54)))
	rho_po=n_r*AA1

	ff1=(x(1)**2+x(2)**2+tau**2*(sinh(y0))**2)**(1.5)
	f=197.3**2*Z*alpha*sinh(y0)*rho_po*x(1)/ff1

	RETURN
	END

*****************************************************************************
*****************************************************************************

	SUBROUTINE FGAUS(N,JS,X,FS,F,S,TAU)
	DIMENSION JS(N),X(N)
	DIMENSION T(5),C(5),D(2,11),CC(11),IS(2,11)
	DOUBLE PRECISION X,F,S,T,C,D,CC,DN,UP,P,TAU
	DATA T/-0.9061798459,-0.5384693101,0.0,
     *         0.5384693101,0.9061798459/
	DATA C/0.2369268851,0.4786286705,0.5688888889,
     *         0.4786286705,0.2369268851/
	M=1
	D(1,N+1)=1.0
	D(2,N+1)=1.0
10	DO 20 J=M,N
	  CALL FS(J,N,X,DN,UP)
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
	  P=F(N,X,TAU)
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

