	DIMENSION x1(9),y1(9),x2(9),y2(9),x3(9),y3(9)
       DIMENSION x4(9),y4(9),x(9),y(9)	
	DOUBLE PRECISION x1,y1,x2,y2,x3,y3,x4,y4
       DOUBLE PRECISION x,y

       open(1,file='delta+-_130_lambda0.3R.dat',status='old')
       open(2,file='N+-.dat',status='old')
       open(3,file='a+-_130_lambda0.3R.dat',status='unknown')

      do ii=1,9
          read(1,*) x1(ii),y1(ii)
         read(2,*) x2(ii),y2(ii)
	  x(ii)=x2(ii)
         y(ii)=y1(ii)/(y2(ii)*y2(ii))
          write(3,*) x(ii),y(ii)
       enddo

       
	RETURN
	END


*****************************************************************************
*****************************************************************************

