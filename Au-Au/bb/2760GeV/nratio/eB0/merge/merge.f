	DIMENSION x1(201),y1(201),x2(201),y2(201)
       DIMENSION x4(201),y4(201),x(201),y(201),x3(201),y3(201)	
	DOUBLE PRECISION x1,y1,x2,y2,x3,y3,x4,y4
       DOUBLE PRECISION x,y

       open(1,file='eB_p22_2760_bb.dat',status='old')
       open(2,file='eB_s22_2760_bb.dat',status='old')
       open(3,file='eB_2760_bb.dat',status='unknown')

      do ii=1,201
          read(1,*) x2(ii),y2(ii)
         read(2,*) x4(ii),y4(ii)
	  x(ii)=x2(ii)/8.0
         y(ii)=8.0*y2(ii)+4.0*y4(ii)
          write(3,*) x(ii),y(ii)
       enddo

       
	RETURN
	END


*****************************************************************************
*****************************************************************************

