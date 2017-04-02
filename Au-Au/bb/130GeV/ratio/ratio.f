	DIMENSION x1(9),y1(9),x2(9),y2(9),x3(9),y3(9)
       DIMENSION x4(9),y4(9),x(9),y(9)
	DIMENSION x5(9),y5(9),x6(9),y6(9),x7(9),y7(9)
       DIMENSION x8(9),y8(9),x9(9),y9(9)		
	DOUBLE PRECISION x1,y1,x2,y2,x3,y3,x4,y4
	DOUBLE PRECISION x5,y5,x6,y6,x7,y7,x8,y8,x9,y9
       DOUBLE PRECISION x,y

       open(11,file='a+-_130_lambda0.1R.dat',status='old')
       open(22,file='a+-_130_lambda0.2R.dat',status='old')
       open(33,file='a+-_130_lambda0.3R.dat',status='old')

       open(111,file='a++_130_lambda0.1R.dat',status='old')
       open(222,file='a++_130_lambda0.2R.dat',status='old')
       open(333,file='a++_130_lambda0.3R.dat',status='old')

       open(1,file='ratio_130_lambda0.1R.dat',status='unknown')
       open(2,file='ratio_130_lambda0.2R.dat',status='unknown')
       open(3,file='ratio_130_lambda0.3R.dat',status='unknown')

      do ii=1,9
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

