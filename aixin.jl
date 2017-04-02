using Cuba
function plcse()
  function yy(elab)
    xmass = 0.938
    pz = sqrt(elab^2 - xmass^2)
    elab1 = elab + pz
    elab2 = elab - pz
    y = 0.5*log(elab1/elab2)
  end

  xmass = 0.939 # 核子质量
  RR = 7.0 # 原子核半径
  elab = 100.0 # 实验室参考系能量
  y0 = yy(elab)

  taui = 2.0*RR*exp(-y0)

  bbx = [
    2.2100000476837158
    4.0300002098083496
    5.6999998092651367
    7.3699998855590820
    8.7299995422363281
    9.8999996185302734
    11.000000000000000
    11.899999618530273
    12.800000190734863
    ]
  eBy = [
    36940.289903832505
    36573.692399249128
    37561.331741181588
    38895.795223215689
    39816.479957720650
    40310.620350383186
    40461.625702866484
    40376.267619991959
    40173.872660196146
    ];

  bb = bbx[1]

  lambda = 0.3 * RR

  function fun(x, f)
    Imin = [-RR+bb/2.0,0,taui];
    Imax = [0.0, 0, 15.0];
    xp = Imin[1] + (Imax[1] - Imin[1])*x[1];
    Imin[2] = -sqrt(RR^2 - (xp-0.5*bb)^2);
    Imax[2] = sqrt(RR^2 - (xp-0.5*bb)^2);
    yp = Imin[2] + (Imax[2] - Imin[2])*x[2];
    tau = Imin[3] + (Imax[3] - Imin[3])*x[3];

    exp11 = exp(-1.0/lambda*abs(sqrt(RR^2-(xp-0.5*bb)^2)-yp));
    exp22 = exp(-1.0/lambda*abs(sqrt(RR^2-(xp-0.5*bb)^2)+yp));

    aksi = exp11 * exp22;
    atau = (taui/tau)*taui*exp((-1.0/27.0)*(tau^2-taui^2));
    jacobian = 1.0;
    for i = 1:3
      jacobian = jacobian * (Imax[i]-Imin[i]);
    end

    f[1] = jacobian * -4.0*(25.0/81.0)*aksi*atau;

  end

  result = cuhre(fun, 3, 1, abstol=1e-10, reltol=1e-8)

  S = (eBy[1]/(197.5)^2)^2*result[1][1]
  println(result[1][1], " +- ",  result[2][1])
  println("Results of Cuba:", S)

end
