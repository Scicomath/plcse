	DIMENSION x1(9),y1(9),x2(9),y2(9),x3(9),y3(9)
       DIMENSION x4(9),y4(9),x(9),y(9)	
	DOUBLE PRECISION x1,y1,x2,y2,x3,y3,x4,y4
       DOUBLE PRECISION x,y

       open(1,file='eB_p22_130_bb.dat',status='old')
       open(2,file='eB_s22_130_bb.dat',status='old')
       open(3,file='eB_130_bb.dat',status='unknown')

      do ii=1,9
          read(1,*) x2(ii),y2(ii)
         read(2,*) x4(ii),y4(ii)
	  x(ii)=x2(ii)
         y(ii)=8.0*y2(ii)+4.0*y4(ii)
          write(3,*) x(ii),y(ii)
       enddo

       
	RETURN
	END


*****************************************************************************
*****************************************************************************

