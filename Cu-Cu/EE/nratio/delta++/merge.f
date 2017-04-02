	DIMENSION x1(10001),y1(10001),x2(10001),y2(10001)
        DIMENSION x3(10001),y3(10001),x6(10001),y6(10001)
	DIMENSION x4(10001),y4(10001),x5(10001),y5(10001)
        DIMENSION x(10001),y(10001),xx(10001),yy(10001)
	 DIMENSION xxx(10001),yyy(10001)	
	DOUBLE PRECISION x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6
       DOUBLE PRECISION x,y,xx,yy,xxx,yyy

       open(1,file='delta-b4fm_lambda0.3R-CMS1.dat',status='old')
       open(2,file='delta-b4fm_lambda0.3R-CMS2.dat',status='old')
       open(3,file='delta-b4fm_lambda0.3R-CMS.dat',status='unknown')
       open(11,file='delta-b4fm_lambda0.2R-CMS1.dat',status='old')
       open(22,file='delta-b4fm_lambda0.2R-CMS2.dat',status='old')
       open(33,file='delta-b4fm_lambda0.2R-CMS.dat',status='unknown')
       open(111,file='delta-b4fm_lambda0.1R-CMS1.dat',status='old')
       open(222,file='delta-b4fm_lambda0.1R-CMS2.dat',status='old')
       open(333,file='delta-b4fm_lambda0.1R-CMS.dat',status='unknown')

      do ii=1,10001
          read(1,*) x1(ii),y1(ii)
         read(2,*) x2(ii),y2(ii)
	  x(ii)=x2(ii)
         y(ii)=y1(ii)+y2(ii)
          write(3,*) x(ii),y(ii)

          read(11,*) x3(ii),y3(ii)
          read(22,*) x4(ii),y4(ii)
	  xx(ii)=x3(ii)
          yy(ii)=y3(ii)+y4(ii)
          write(33,*) xx(ii),yy(ii)

          read(111,*) x5(ii),y5(ii)
          read(222,*) x6(ii),y6(ii)
	  xxx(ii)=x5(ii)
          yyy(ii)=y5(ii)+y6(ii)
          write(333,*) xxx(ii),yyy(ii) 



      enddo

       
	RETURN
	END


*****************************************************************************
*****************************************************************************

