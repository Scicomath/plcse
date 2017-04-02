	DIMENSION x1(201),y1(201),x2(201),y2(201),x3(201),y3(201)
	DIMENSION x4(201),y4(201),x5(201),y5(201),x6(201),y6(201)
       DIMENSION x(201),y(201),xx(201),yy(201),xxx(201),yyy(201)	
	DOUBLE PRECISION x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6
       DOUBLE PRECISION x,y,xx,yy,xxx,yyy

       open(1,file='delta-200_lambda0.3R-bb1.dat',status='old')
       open(2,file='delta-200_lambda0.3R-bb2.dat',status='old')
       open(3,file='delta-200_lambda0.3R.dat',status='unknown')
       open(11,file='delta-200_lambda0.2R-bb1.dat',status='old')
       open(22,file='delta-200_lambda0.2R-bb2.dat',status='old')
       open(33,file='delta-200_lambda0.2R.dat',status='unknown')
       open(111,file='delta-200_lambda0.1R-bb1.dat',status='old')
       open(222,file='delta-200_lambda0.1R-bb2.dat',status='old')
       open(333,file='delta-200_lambda0.1R.dat',status='unknown')

      do ii=1,201
          read(1,*) x1(ii),y1(ii)
         read(2,*) x2(ii),y2(ii)
	  x(ii)=x2(ii)/7.0
         y(ii)=y1(ii)+y2(ii)
          write(3,*) x(ii),y(ii)

          read(11,*) x3(ii),y3(ii)
          read(22,*) x4(ii),y4(ii)
	  xx(ii)=x3(ii)/7.0
          yy(ii)=y3(ii)+y4(ii)
          write(33,*) xx(ii),yy(ii)

          read(111,*) x5(ii),y5(ii)
          read(222,*) x6(ii),y6(ii)
	  xxx(ii)=x5(ii)/7.0
          yyy(ii)=y5(ii)+y6(ii)
          write(333,*) xxx(ii),yyy(ii) 



      enddo

       
	RETURN
	END


*****************************************************************************
*****************************************************************************

