	DIMENSION x1(10001),y1(10001),x2(10001),y2(10001)
        DIMENSION x4(10001),y4(10001),x(10001),y(10001),x3(10001)
	DIMENSION xx(10001),yy(10001),y3(10001)	
	DOUBLE PRECISION x1,y1,x2,y2,x3,y3,x4,y4
        DOUBLE PRECISION x,y,xx,yy

       open(1,file='eB_p22_b4fm_CMS.dat',status='old')
       open(2,file='eB_s22_b4fm_CMS.dat',status='old')
       open(3,file='eB_b4fm_CMS.dat',status='unknown')

       open(11,file='eB_p22_b8fm_CMS.dat',status='old')
       open(22,file='eB_s22_b8fm_CMS.dat',status='old')
       open(33,file='eB_b8fm_CMS.dat',status='unknown')

      do ii=1,10001
          read(1,*) x1(ii),y1(ii)
         read(2,*) x2(ii),y2(ii)
	  x(ii)=x2(ii)
         y(ii)=8.0*y1(ii)+4.0*y2(ii)
          write(3,*) x(ii),y(ii)

          read(11,*) x3(ii),y3(ii)
          read(22,*) x4(ii),y4(ii)
	  xx(ii)=x3(ii)
          yy(ii)=8.0*y3(ii)+4.0*y4(ii)
          write(33,*) xx(ii),yy(ii)
       enddo

       
	RETURN
	END


*****************************************************************************
*****************************************************************************

