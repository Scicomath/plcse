# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

from numpy import genfromtxt, savetxt
from scipy.optimize import minimize_scalar

# read exp gamma data
Au62opp = genfromtxt('exp data/Au62GeVopp.csv', delimiter=',')
Au62same = genfromtxt('exp data/Au62GeVsame.csv', delimiter=',')
Au200opp = genfromtxt('exp data/STARopp.csv', delimiter=',')
Au200same = genfromtxt('exp data/STARsame.csv', delimiter=',')
Pb2760opp = genfromtxt('exp data/ALICEopp.csv', delimiter=',')
Pb2760same = genfromtxt('exp data/ALICEsame.csv', delimiter=',')
Cu62opp = genfromtxt('exp data/Cu62GeVopp.csv', delimiter=',')
Cu62same = genfromtxt('exp data/Cu62GeVsame.csv', delimiter=',')
Cu200opp = genfromtxt('exp data/Cu200GeVopp.csv', delimiter=',')
Cu200same = genfromtxt('exp data/Cu200GeVsame.csv', delimiter=',')

# read exp delta data
Au200deltasame = genfromtxt('exp data/Au200GeV_delta_same.txt', delimiter=',')
Au200deltaopp = genfromtxt('exp data/Au200GeV_delta_opp.txt', delimiter=',')
Pb2760deltasame = genfromtxt('exp data/Pb2760GeV_delta_same.txt', delimiter=',')
Pb2760deltaopp = genfromtxt('exp data/Pb2760GeV_delta_opp.txt', delimiter=',')

# read exp v2 data
Au200v2 = genfromtxt('v2/RHICv2.txt', delimiter=',', comments='#')
Pb2760v2 = genfromtxt('v2/LHCv2.txt', delimiter=',', comments='#')

# evaluate H
kappa = 1.5
Au200Hsame = (kappa * Au200v2[:,1] * Au200deltasame[1:,1] - Au200same[1:,1])\
    /(1 + kappa*Au200v2[:,1])
Au200Hopp = (kappa * Au200v2[:,1] * Au200deltaopp[1:,1] - Au200opp[1:,1])\
    /(1 + kappa*Au200v2[:,1])
Pb2760Hsame = (kappa * Pb2760v2[:,1] * Pb2760deltasame[:,1] - Pb2760same[:,1])\
    /(1 + kappa*Pb2760v2[:,1])
Pb2760Hopp = (kappa * Pb2760v2[:,1] * Pb2760deltaopp[:,1] - Pb2760opp[:,1])\
    /(1 + kappa*Pb2760v2[:,1])
Au200Hdiff = Au200Hsame - Au200Hopp
Pb2760Hdiff = Pb2760Hsame - Pb2760Hopp

savetxt('Au200Hsame.txt', Au200Hsame)
savetxt('Au200Hopp.txt', Au200Hopp)
savetxt('Pb2760Hsame.txt', Pb2760Hsame)
savetxt('Pb2760Hopp.txt', Pb2760Hopp)

# read theory data
Au6201 = genfromtxt('result/Au62GeV0.1.txt', delimiter=',')
Au6202 = genfromtxt('result/Au62GeV0.2.txt', delimiter=',')
Au6203 = genfromtxt('result/Au62GeV0.3.txt', delimiter=',')
Au20001 = genfromtxt('result/Au200GeV0.1.txt', delimiter=',')
Au20002 = genfromtxt('result/Au200GeV0.2.txt', delimiter=',')
Au20003 = genfromtxt('result/Au200GeV0.3.txt', delimiter=',')
Pb276001 = genfromtxt('result/Pb2760GeV0.1.txt', delimiter=',')
Pb276002 = genfromtxt('result/Pb2760GeV0.2.txt', delimiter=',')
Pb276003 = genfromtxt('result/Pb2760GeV0.3.txt', delimiter=',')
Cu6201 = genfromtxt('result/Cu62GeV0.1.txt', delimiter=',')
Cu6202 = genfromtxt('result/Cu62GeV0.2.txt', delimiter=',')
Cu6203 = genfromtxt('result/Cu62GeV0.3.txt', delimiter=',')
Cu20001 = genfromtxt('result/Cu200GeV0.1.txt', delimiter=',')
Cu20002 = genfromtxt('result/Cu200GeV0.2.txt', delimiter=',')
Cu20003 = genfromtxt('result/Cu200GeV0.3.txt', delimiter=',')

Au20001Diff = Au20001[1:8,0] - Au20001[1:8,1]
Au20002Diff = Au20002[1:8,0] - Au20002[1:8,1]
Au20003Diff = Au20003[1:8,0] - Au20003[1:8,1]
Pb276001Diff = Pb276001[:8,0] - Pb276001[:8,1]
Pb276002Diff = Pb276002[:8,0] - Pb276002[:8,1]
Pb276003Diff = Pb276003[:8,0] - Pb276003[:8,1]

def adjustfun(expopp, expsame, theorydata):
    opplen = len(expopp)
    samelen = len(expsame)
    def objfun(alpha):
        temp1 = expopp[:opplen] - theorydata[:,1][:opplen]*alpha
        temp2 = expsame[:samelen] - theorydata[:,0][:samelen]*alpha
        return sum(temp1**2) + sum(temp2**2)
    res = minimize_scalar(objfun, method='brent')
    print("alpha =", res.x, "MSE =", res.fun)
    return res
def adjustfun2(Hdiff, theDiff):
    def objfun(alpha):
        temp = Hdiff - theDiff*alpha
        return sum(temp**2)
    res = minimize_scalar(objfun, method='brent')
    print("alpha =", res.x, "MSE =", res.fun)
    return res

print("Au 62GeV lambda/R = 0.1, 0.2, 0.3")
adjustfun(Au62opp[:,1], Au62same[:,1], Au6201)
adjustfun(Au62opp[:,1], Au62same[:,1], Au6202)
adjustfun(Au62opp[:,1], Au62same[:,1], Au6203)
print("Au 200GeV lambda/R = 0.1, 0.2, 0.3")
adjustfun(Au200opp[:,1], Au200same[:,1], Au20001)
adjustfun(Au200opp[:,1], Au200same[:,1], Au20002)
adjustfun(Au200opp[:,1], Au200same[:,1], Au20003)
print("Pb 2760GeV lambda/R = 0.1, 0.2, 0.3")
adjustfun(Pb2760opp[:,1], Pb2760same[:,1], Pb276001)
adjustfun(Pb2760opp[:,1], Pb2760same[:,1], Pb276002)
adjustfun(Pb2760opp[:,1], Pb2760same[:,1], Pb276003)
print("Cu 62GeV lambda/R = 0.1, 0.2, 0.3")
adjustfun(Cu62opp[:,1], Cu62same[:,1], Cu6201)
adjustfun(Cu62opp[:,1], Cu62same[:,1], Cu6202)
adjustfun(Cu62opp[:,1], Cu62same[:,1], Cu6203)
print("Cu 200GeV lambda/R = 0.1, 0.2, 0.3")
adjustfun(Cu200opp[:,1], Cu200same[:,1], Cu20001)
adjustfun(Cu200opp[:,1], Cu200same[:,1], Cu20002)
adjustfun(Cu200opp[:,1], Cu200same[:,1], Cu20003)

# H result
print("Au 200GeV lambda/R = 0.1, 0.2, 0.3")
adjustfun(Au200Hopp, Au200Hsame, Au20001[1:8,:])
adjustfun(Au200Hopp, Au200Hsame, Au20002[1:8,:])
adjustfun(Au200Hopp, Au200Hsame, Au20003[1:8,:])

print("Pb 2760GeV lambda/R = 0.1, 0.2, 0.3")
adjustfun(Pb2760Hopp, Pb2760Hsame, Pb276001)
adjustfun(Pb2760Hopp, Pb2760Hsame, Pb276002)
adjustfun(Pb2760Hopp, Pb2760Hsame, Pb276003)

# H diff result
print("Au 200GeV lambda/R = 0.1, 0.2, 0.3")
adjustfun2(Au200Hdiff, Au20001Diff)
adjustfun2(Au200Hdiff, Au20002Diff)
adjustfun2(Au200Hdiff, Au20003Diff)

print("Pb 2760GeV lambda/R = 0.1, 0.2, 0.3")
adjustfun2(Pb2760Hdiff, Pb276001Diff)
adjustfun2(Pb2760Hdiff, Pb276002Diff)
adjustfun2(Pb2760Hdiff, Pb276003Diff)