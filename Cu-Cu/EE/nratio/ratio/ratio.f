	DIMENSION x1(10001),y1(10001),x2(10001),y2(10001)
       DIMENSION x4(10001),y4(10001),x(10001),y(10001)
        DIMENSION x3(10001),y3(10001),x7(10001),y7(10001)
	DIMENSION x5(10001),y5(10001),x6(10001),y6(10001)
       DIMENSION x8(10001),y8(10001),x9(10001),y9(10001)		
	DOUBLE PRECISION x1,y1,x2,y2,x3,y3,x4,y4
	DOUBLE PRECISION x5,y5,x6,y6,x7,y7,x8,y8,x10001,y10001
       DOUBLE PRECISION x,y

       open(11,file='delta+-_b4fm_lambda0.1R-CMS.dat',status='old')
       open(22,file='delta+-_b4fm_lambda0.2R-CMS.dat',status='old')
       open(33,file='delta+-_b4fm_lambda0.3R-CMS.dat',status='old')

       open(111,file='delta-b4fm_lambda0.1R-CMS.dat',status='old')
       open(222,file='delta-b4fm_lambda0.2R-CMS.dat',status='old')
       open(333,file='delta-b4fm_lambda0.3R-CMS.dat',status='old')

       open(1,file='ratio_b4fm_lambda0.1R-CMS.dat',status='unknown')
       open(2,file='ratio_b4fm_lambda0.2R-CMS.dat',status='unknown')
       open(3,file='ratio_b4fm_lambda0.3R-CMS.dat',status='unknown')

      do ii=1,10001
          read(111,*) x1(ii),y1(ii)
         read(222,*) x2(ii),y2(ii)
         read(333,*) x3(ii),y3(ii)
         read(11,*) x4(ii),y4(ii)
         read(22,*) x5(ii),y5(ii)
         read(33,*) x6(ii),y6(ii)
          x7(ii)=x1(ii)
	  y7(ii)=abs(y4(ii))/y1(ii)
	  y8(ii)=abs(y5(ii))/y2(ii)
	  y9(ii)=abs(y6(ii))/y3(ii)

          write(1,*) x7(ii),y7(ii)
          write(2,*) x7(ii),y8(ii)
          write(3,*) x7(ii),y9(ii)
       enddo

       
	RETURN
	END


*****************************************************************************
*****************************************************************************

