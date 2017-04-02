	DIMENSION x1(201),y1(201),x2(201),y2(201),x3(201),y3(201)
       DIMENSION x4(201),y4(201),x(201),y(201)
	DIMENSION x5(201),y5(201),x6(201),y6(201),x7(201),y7(201)
       DIMENSION x8(201),y8(201),x9(201),y9(201)		
	DOUBLE PRECISION x1,y1,x2,y2,x3,y3,x4,y4
	DOUBLE PRECISION x5,y5,x6,y6,x7,y7,x8,y8,x201,y201
       DOUBLE PRECISION x,y

       open(11,file='delta+-_2760_lambda0.1R.dat',status='old')
       open(22,file='delta+-_2760_lambda0.2R.dat',status='old')
       open(33,file='delta+-_2760_lambda0.3R.dat',status='old')

       open(111,file='delta-2760_lambda0.1R.dat',status='old')
       open(222,file='delta-2760_lambda0.2R.dat',status='old')
       open(333,file='delta-2760_lambda0.3R.dat',status='old')

       open(1,file='ratio_2760_lambda0.1R.dat',status='unknown')
       open(2,file='ratio_2760_lambda0.2R.dat',status='unknown')
       open(3,file='ratio_2760_lambda0.3R.dat',status='unknown')

      do ii=1,201
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

