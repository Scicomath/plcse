# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

from numpy import genfromtxt
from scipy.optimize import minimize_scalar

# read exp data
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

def adjustfun(expopp, expsame, theorydata):
    opplen = len(expopp)
    samelen = len(expsame)
    def objfun(alpha):
        temp1 = expopp[:,1][:opplen] - theorydata[:,1][:opplen]*alpha
        temp2 = expsame[:,1][:samelen] - theorydata[:,0][:samelen]*alpha
        return sum(temp1**2) + sum(temp2**2)
    res = minimize_scalar(objfun, method='brent')
    print("alpha =", res.x, "MSE =", res.fun)
    return res
print("Au 62GeV lambda/R = 0.1, 0.2, 0.3")
adjustfun(Au62opp, Au62same, Au6201)
adjustfun(Au62opp, Au62same, Au6202)
adjustfun(Au62opp, Au62same, Au6203)
print("Au 200GeV lambda/R = 0.1, 0.2, 0.3")
adjustfun(Au200opp, Au200same, Au20001)
adjustfun(Au200opp, Au200same, Au20002)
adjustfun(Au200opp, Au200same, Au20003)
print("Pb 2760GeV lambda/R = 0.1, 0.2, 0.3")
adjustfun(Pb2760opp, Pb2760same, Pb276001)
adjustfun(Pb2760opp, Pb2760same, Pb276002)
adjustfun(Pb2760opp, Pb2760same, Pb276003)
print("Cu 62GeV lambda/R = 0.1, 0.2, 0.3")
adjustfun(Cu62opp, Cu62same, Cu6201)
adjustfun(Cu62opp, Cu62same, Cu6202)
adjustfun(Cu62opp, Cu62same, Cu6203)
print("Cu 200GeV lambda/R = 0.1, 0.2, 0.3")
adjustfun(Cu200opp, Cu200same, Cu20001)
adjustfun(Cu200opp, Cu200same, Cu20002)
adjustfun(Cu200opp, Cu200same, Cu20003)
