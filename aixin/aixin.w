\documentclass{cweb}
\usepackage{geometry}
\usepackage{amsmath,amssymb}
\usepackage{mathtools}
\usepackage{physics}
\usepackage{graphicx}

\geometry{a4paper,centering,scale=0.8}

\bibliographystyle{plain}

\begin{document}

\title{A Program to Calculate Chiral Charge Separation in Heavy-Ion Collisions}
\author{Ai Xin}

\maketitle

@* Introduction.

This is a program to calculate Chiral Charge Separation in Heavy-Ion Collisions.
Here is an overview of the structure of the program:
@c
@<Header files to include@>@/
@<Function prototype@>@/
@<Global variables@>@/
@<Function: square and cube@>@/
@<Function: number density of nuclei@>@/
@<Function: rapidity distribution of ``participants''@>@/
@<Function: ``participants'' integrand function@>@/
@<Function: ``spectators'' integrand function@>@/
@<Function: calculate magetic field@>@/
@<Function: convert collision energy to rapidity@>@/
@<Function: $\xi_\pm$ function@>@/
@<Function: $\langle \Delta_\pm^2 \rangle$ integrand function@>@/
@<Function: $\langle \Delta_+ \Delta_- \rangle$ integrand function@>@/
@<Function: calculate chiral separation effects@>@/
@<The main program@>@/

@ This program obviously need include the standard I/O library. It also need GSL math library and the standard math library. Finally, we need Cuba library to do integration.
@<Header files...@>=
#include <stdio.h>
#include <stdlib.h>
#include <gsl/gsl_math.h>
#include <math.h>
#include <string.h>
#include <cuba.h>

@ Now we define function prototype.
@<Function prototype@>=
double Sq(double num);
double Pow3(double num);
double rhoFun(double xp, double yp, double zp);
double f(double Y);
static int eB_Part_Int(const int *ndim, const double xx[], const int *ncomp, double ff[], void *userdata);
static int eB_Spec_Int(const int *ndim, const double xx[], const int *ncomp, double ff[], void *userdata);
int eB(double *eBy, double *totalerror, const int verbose);
double xifun(double xp, double yp, char sign);
static int delta_pp_Int(const int *ndim, const double xx[], const int *ncomp, double ff[], void *userdata);
static int delta_pm_Int(const int *ndim, const double xx[], const int *ncomp, double ff[], void *userdata);
int csefun(double *app, double *apm, double *delta_pp, double *delta_pm);
int main(int argc, char **argv);
double sqrtStoY(double sqrtS);


@ To speed up the calculation processes, we define inline function of square and cube.
@<Function: square and cube@>=
double Sq(double num) {
  return num*num;
}
double Pow3(double num) {
  return num*num*num;
}

@ For convenience, we define some global variables.
@<Global variables@>=
static const double alpha_EM = 1.0 / 137.0;
static const double hbarc = 197.32696;

static double R; // radius of the nucleus
static double b; // impact parameter
static double d; // geometry distribution factor of the nucleus
static double n0; // central number density of the nucleus
static double Y0; // initial rapidity
static double t; // time
static double t0;
static double eBy0;
static double x, y, z; // field point coordinates
static double Z;
static double a;
static char flag; // '+' or '-', denote left or right nucleus
static double lambda; // screening length
static double Np, Nm;
@#
static int nvec = 1;
static double epsrel;
static double epsabs;
static int flags;
static int seed;
static int pmineval;
static int pmaxeval;
static int smineval;
static int smaxeval;
static int mineval;
static int maxeval;
static int nstart;  // [V]the number of integrand evaluations per iteration to start with. demo's value is 1000
static int nincrease; // [V]the increase in the number of integrand evaluations per iteration. demo's value is 500
static int nbatch; // [V]the batch size for sampling. demo's value is 1000
static int gridno; // [V]the slot in the internal grid table. demo's value is 0
  
static int nnew; // [S]the number of new integrand evaluations in each subdivision. demo's value is 1000
static int nmin; // [S]the minimum number of samples a former pass must contribute
            // to a subregion to be considered in that region’s compound integral value. demo's value is 2.
static double flatness; // [S]the parameter p in Eq. (1). demo's value is 25.

static int key1; // [D]determines sampling in the partitioning phase. demo's value is 47
static int key2; // [D]determines sampling in the final integration phase. demo's value is 1
static int key3; // [D]sets the strategy for the refinement phase. demo's value is 1
static int maxpass; // [D]controls the thoroughness of the partitioning phase. demo's value is 5.
static double border; // [D]the width of the border of the integration region. demo's value is 0.
static double maxchisq; // [D]the maximum χ 2 value a single subregion is allowed to have in the final integration phase. demo's value is 10.
static double mindeviation; // [D]a bound, given as the fraction of the requested error of the entire integral. demo's value is 0.25.
static int ngiven; // [D]the number of points in the xgiven array. demo's 0
static int ldxgiven; // [D]the leading dimension of xgiven, i.e. the offset between one point and the next in memory. demo's value is NDIM
static int nextra; // [D]the maximum number of extra points the peak-finder subroutine will return. demo's value is 0.

static int key; // [C]chooses the basic integration rule. demo's value is 0
  
static char *statefile; 
static void *spin; // the ‘spinning cores’ pointer, demo's value is NULL

@ Let's first consider the magnetic field produced by a point charge. Namely, the magnetic field at position $\vb*{x} = (\vb*{x}_\perp , z)$ caused by a particle with charge $Z$ moving in the positive $z$-direction with rapidity $Y$. At $t = 0$ the particle can be found at position $\vb*{x}'_\perp$. The result is
\begin{equation}
e\vb*{B}(\vb*{x}) = Z \alpha_{\text{EM}} \sinh(Y) \frac{(\vb*{x}'_\perp - \vb*{x}_\perp) \times \vb*{e}_z}{[(\vb*{x}'_\perp - \vb*{x}_\perp)^2 + (t\sinh Y - z \cosh Y)^2]^{3/2}}.
\end{equation}

For heavy-ion collisions, we set the nuclei completely collided at $t = 0$, where their center is at point $(\pm\vb*{b}/2,0)$ as in figure \ref{fig01}. We can then split the total magnetic field in the following way
\begin{equation}
\vb*{B} = \vb*{B}_s^+ + \vb*{B}_s^- + \vb*{B}_p^+ + \vb*{B}_p^-.
\end{equation}
where $\vb*{B}_s^\pm$ and $\vb*{B}_p^\pm$ are the contributions of the ``spectators'' and ``participants''. To calculate it, we need the phase configuration of the charged particles, namely it's position distribution and rapidity distribution.

\begin{figure}
\centering 
\includegraphics[scale=1]{fig1}\\
\caption{Cross section of peripheral collision, where the shadow part denotes ``participants'' and the other part denotes ``spectators''. The left nucleus moves along the positive $z$ direction, while the right nucleus moves along the negative $z$ direction. The $z$ direction is outwardly perpendicular to the paper.}\label{fig01}
\end{figure}

@ When a nucleus stays at rest, its nucleus number density distribution can be discribed by Woods-Saxon distribution
\begin{equation}
n_A(r) = \frac{n_0}{1 + \exp(\frac{r-R}{d})}.
\end{equation}
This distribution must be modified due to the Lorentz contraction of the nuclei, so we have
\begin{equation}
\rho_\pm (\vb*{x}') = \frac{\gamma n_0}{1 + \exp(\frac{\sqrt{(x'\pm b/2)^2 + y'^2 + (\gamma z')^2} - R}{d})}.
\end{equation}
where the subscript $+(-)$ denotes the left(right) nucleus moving along the positive(negative) $z$ direction, $\gamma$ is the Lorentz contraction factor. Here we define a function to calculate the number density of the nuclei.

@<Function: number density of nuclei@>=
double rhoFun(double xp, double yp, double zp) {
  // |xp|, |yp|, |zp|: source point coordinates
  // return: number density at (|xp|, |yp|, |zp|)

  double rho;
  double len;
  double gamma;
  double sign = 1.0;
  gamma = cosh(Y0);
  
  if (flag == '+') {
    sign = 1.0; // left nucleus
  } else if (flag == '-') {
    sign = -1.0; // right nucleus
  } else {
    printf("[rhoFun]error: nucleus type(flag) should be '+' or '-'\n");
  }

  len = sqrt(Sq(xp + sign*b/2.0) + Sq(yp) + Sq(gamma*zp));
  rho = gamma * n0 / ( 1.0 + exp((len-R)/d) ); // times gamma for density is increased
  
  return rho;
}


@ Now, we consider the rapidity distribution. For ``spectators'', we assume that they do not effected by the collision, so they just move with rapidity $Y_0$. For ``participants'', their rapidity distribution is
\begin{equation}
f(Y) = \frac{a}{2\sinh(aY_0)}\exp(aY),\qquad -Y_0 \leq Y \leq Y_0.
\end{equation}
@<Function: rapidity distribution of ``participants''@>=
double f(double Y) {
  return (a*exp(a*Y)) / (2*sinh(a*Y0));
}


@ Now we can deduced the magnetic field produced by ``spectators'':
\begin{equation}
\begin{split}
e\vb*{B}_s^\pm(t,\vb*{x}) &= \pm Z \alpha_{\text{EM}} \sinh Y_0 \int_{V_s^\pm} \dd[3]{\vb*{x}'} \rho_\pm (\vb*{x}') \\
&\times \frac{(\vb*{x}'_\perp - \vb*{x}_\perp)\times \vb*{e}_z}{[(\vb*{x}'_\perp - \vb*{x}_\perp)^2 + ((\frac{z'}{\tanh Y_0} \pm t)\sinh Y_0 - z\cosh Y_0)^2]^{3/2}}.
\end{split}
\end{equation}
The magnetic field produced by ``participants'':
\begin{equation}
\begin{split}
e\vb*{B}_p^\pm(t,\vb*{x}) &= \pm Z \alpha_{\text{EM}} \int_{V_p} \dd[3]{\vb*{x}'} \int_{-Y_0}^{Y_0} \dd{Y} f(Y) \sinh Y \rho_\pm (\vb*{x}') \\
&\times \frac{(\vb*{x}'_\perp - \vb*{x}_\perp)\times \vb*{e}_z}{[(\vb*{x}'_\perp - \vb*{x}_\perp)^2 + ((\frac{z'}{\tanh Y_0} \pm t)\sinh Y - z\cosh Y)^2]^{3/2}}.
\end{split}
\end{equation}
Notice the difference in denominator with point charge magnetic field formula. The reason is that in point charge magnetic field formula, we assume the point charge is at $z=0$ plane when $t=0$, however when two nuclei completely collide not all charge is precisely at $z=0$ plane. So to use the point charge formula, we need to offset time in the formula. For positively move nucleus,
\begin{equation}
\begin{split}
t \sinh Y - z \cosh Y \rightarrow &  \left(t + \frac{z'}{\tanh Y_0}\right) \sinh Y - z \cosh Y_0 \\
& \left(\frac{z'}{\tanh Y_0} + t\right) \sinh Y - z \cosh Y_0
\end{split}
\end{equation}
For negatively move nucleus,
\begin{equation}
\begin{split}
-t \sinh Y - z \cosh Y \rightarrow & -\left(t - \frac{z'}{\tanh Y_0}\right) \sinh Y - z \cosh Y_0 \\
& = \left(\frac{z'}{\tanh Y_0} - t\right) \sinh Y - z \cosh Y_0
\end{split}
\end{equation}

@ To express the integration more explicitly, for  ``participants'' we have
\begin{equation}
\begin{split}
&e\vb*{B}_p^\pm (t, \vb*{x}) = \pm Z \alpha_{\text{EM}} \int_{b/2-R}^{-b/2+R} \dd{x'} \int_{-y_{\text{lim}}(x')}^{y_{\text{lim}}(x')} \dd{y'} \int_{-R/\cosh Y_0}^{R/\cosh Y_0} \dd{z'} \int_{-Y_0}^{Y_0} \dd{Y} f(Y)  \\
&\qquad \sinh Y \rho_\pm(\vb*{x}') \times \frac{(\vb*{x}'_\perp - \vb*{x}_\perp)\times \vb*{e}_z}{[(\vb*{x}'_\perp - \vb*{x}_\perp)^2 + ((\frac{z'}{\tanh Y_0} \pm t)\sinh Y - z\cosh Y)^2]^{3/2}}.
\end{split}
\end{equation}
where $y_{\text{lim}}(x') = \sqrt{R^2 - (^^7c x' ^^7c + b/2)^2}$.

For ``spectators'', it's better to use cylindrical coordinate system.
\begin{equation}
\begin{split}
&e\vb*{B}_s^\pm (t,\vb*{x}) = \pm Z \alpha_{\text{EM}} \sinh Y_0 \int_{\phi_i}^{\phi_f} \dd{\phi'} \int_{x_{\text{in}}(\phi')}^{x_{\text{out}(\phi')}} \dd{x'_\perp} x'_\perp \int_{-R/\cosh Y_0}^{R/\cosh Y_0} \dd{z'} \rho_\pm(\vb*{x}') \\
&\qquad \times \frac{(\vb*{x}'_\perp - \vb*{x}_\perp)\times \vb*{e}_z}{[(\vb*{x}'_\perp - \vb*{x}_\perp)^2 + ((\frac{z'}{\tanh Y_0} \pm t)\sinh Y_0 - z\cosh Y_0)^2]^{3/2}}.
\end{split}
\end{equation}
where $x_{\text{in/out}}(\phi') = \mp \frac{b}{2} ^^7c \cos(\phi') ^^7c + \sqrt{R^2 - \frac{b^2}{4} \sin^2(\phi')}$, and for ``$+$'' mover $\phi_i = \pi/2,\, \phi_f = 3\pi/2$, for ``$-$'' mover $\phi_i = -\pi/2,\, \phi_f = \pi/2$.


@ We use the Cuba library to do the integration. Cuba is a library for multidimensional numerical integration. First, we need to define an integrand function. Before we define the integrand, we must notice that Cuba can only do integration in a unit hypercube, so we must scale the integrand.

@ Let's first define the integrand for ``participants''.
@<Function: ``participants'' integrand function@>=
static int eB_Part_Int(const int *ndim, const double xx[], const int *ncomp,
			   double ff[], void *userdata) {
  // |ndim| is the pointer to the dimension of the integration
  // |xx| is the pointer to the array of integral variable
  // |ncomp| is the pointer to the number of integrand's component
  // |ff| is the pointer to the array of the integrand's function value
  // |userdata| is a pointer to pass some parameters
  struct userdata *ud = (struct userdata *) userdata;
  static double sign;
  static double jacobian;
  static double denominator;
  @#
  static double xp; // integral variable: $x'$
  static double yp; // integral variable: $y'$
  static double zp; // integral variable: $z'$
  static double Y;  // integral variable: $Y$
  @#
  static double Imin[4]; // down limits
  static double Imax[4]; // up limits
  static double gamma; // Lorentz contraction factor
  static double extra;
  @#
  gamma = cosh(Y0); // $\gamma = \cosh(Y_0)$
  extra = 3; // |extra| is used to expand integral limits, because Wood-Saxon distribution is not precisely in the sphere of $R$ 
  @#
  Imin[0] = b/2.0 - R; 
  Imax[0] = -Imin[0];
  // limits of $x'$: $b/2-R \leq x' \leq -b/2+R$
  xp = Imin[0] + (Imax[0] - Imin[0]) * xx[0]; // scale |xx[0]|
  @#
  Imin[1] = - sqrt(Sq(R) - Sq(fabs(xp) + b/2.0)); 
  Imax[1] = -Imin[1];
  // limits of $y'$: $-\sqrt{R^2 - (^^7c x ^^7c + b/2)^2} \leq y' \leq \sqrt{R^2 - (^^7c x' ^^7c + b/2)^2}$
  yp = Imin[1] + (Imax[1] - Imin[1]) * xx[1]; // scale |xx[1]|
  @#
  Imin[2] = -(R+extra)/(gamma); 
  Imax[2] = -Imin[2];
  // limits of $z'$: $-R/\cosh Y_0 \leq z' \leq  R/\cosh Y_0$, note that $\gamma = \cosh(Y_0)$ 
  zp = Imin[2] + (Imax[2] - Imin[2]) * xx[2]; // scale |xx[2]|
  @#
  Imin[3] = -Y0;
  Imax[3] = Y0;
  // limits of $Y$: $-Y_0 \leq Y \leq Y_0$
  Y = Imin[3] + (Imax[3] - Imin[3]) * xx[3]; // scale |xx[3]|
  @#
  if (flag == '+') 
     sign = 1.0; // for ``$+$'' mover
  else
     sign = -1.0; // for ``$-$'' mover
  @#
  // |double temp = (zp/tanh(Y0) + sign * t )*sinh(Y) - z * cosh(Y);|
  double temp = ( sign * t )*sinh(Y) - z * cosh(Y); // Mo Yujun method
  // |temp| is the second term in denominator
  denominator = pow(Sq(xp - x) + Sq(yp - y) +
                    Sq(temp),1.5);
  ff[0] = sign * Sq(hbarc) * Z * alpha_EM * f(Y) * sinh(Y) * rhoFun(xp, yp, zp) * (x - xp) / denominator;
  // calculate the integrand function value, note that |Sq(hbarc)| is $(\hbar c)^2$, this is for unit convertion.
  @#
  jacobian = 1.0;
  for (int i = 0; i < *ndim; i++) {
    jacobian = jacobian * (Imax[i] - Imin[i]);
  }
  ff[0] = jacobian * ff[0];
  // because the integral variable is scaled, so the result must be  multiplied by Jacobian.
  
  return 0;
}

@ Then let's define the integrand for ``spectators''.
@<Function: ``spectators'' integrand function@>=
static int eB_Spec_Int(const int *ndim, const double xx[], const int *ncomp,
			   double ff[], void *userdata) {
  // |ndim| is the pointer to the dimension of the integration
  // |xx| is the pointer to the array of integral variable
  // |ncomp| is the pointer to the number of integrand's component
  // |ff| is the pointer to the array of the integrand's function value
  // |userdata| is a pointer to pass some parameters
  // |struct userdata *ud = (struct userdata *) userdata;|
  
  static double sign;
  static double jacobian;
  static double denominator;
  @#
  static double phip; // integral variable: $\phi'$
  static double xpperp; // integral variable: $x'_\perp$
  static double zp; // integral variable: $z'$
  static double xp;
  static double yp;
  @#
  static double Imin[3]; // down limits
  static double Imax[3]; // up limits
  static double gamma; // Lorentz contraction factor
  static double extra;
  @#
  gamma = cosh(Y0); // $\gamma = \cosh(Y_0)$
  extra = 3; // |extra| is used to expand integral limits, because Wood-Saxon distribution is not precisely in the sphere of $R$
  @#
  if (flag == '+') {
     sign = 1.0; // for ``$+$'' mover
     Imin[0] = M_PI/2.0;
     Imax[0] = 3.0*M_PI/2.0;
     // limits of $\phi'$ for ``$+$'' mover: $\pi/2 \leq \phi' \leq 3\pi/2$
     phip = Imin[0] + (Imax[0] - Imin[0]) * xx[0]; // scale |xx[0]|
  } else {
     sign = -1.0; // for ``$-$'' mover
     Imin[0] = -M_PI/2.0;
     Imax[0] = M_PI/2.0;
     // limits of $\phi'$ for ``$-$'' mover: $-\pi/2 \leq \phi' \leq \pi/2$
     phip = Imin[0] + (Imax[0] - Imin[0]) * xx[0]; // scale |xx[0]|
  }
  @#
  Imin[1] = -b/2.0 * fabs(cos(phip)) + sqrt(Sq(R) - Sq(b)/4.0*Sq(sin(phip)));
  Imax[1] = b/2.0 * fabs(cos(phip)) + sqrt(Sq(R) - Sq(b)/4.0*Sq(sin(phip)));
  // limits of $x'_\perp$: $-\frac{b}{2}cos(\phi') + \sqrt{R^2 - \frac{b^2}{4} \sin^2(\phi')} \leq x'_\perp \leq \frac{b}{2}cos(\phi') + \sqrt{R^2 - \frac{b^2}{4} \sin^2(\phi')}$
  xpperp = Imin[1] + (Imax[1] - Imin[1]) * xx[1]; // scale |xx[1]|
  @#
  Imin[2] = -(R+extra)/(gamma); 
  Imax[2] = -Imin[2];
  // limits of $z'$: $-R/\cosh Y_0 \leq z' \leq  R/\cosh Y_0$, note that $\gamma = \cosh(Y_0)$ 
  zp = Imin[2] + (Imax[2] - Imin[2]) * xx[2]; // scale |xx[2]|
  @#
  xp = xpperp * cos(phip);
  yp = xpperp * sin(phip);
  @#
  // |double temp = (zp/tanh(Y0) + sign * t )*sinh(Y0) - z * cosh(Y0);|
  double temp = ( sign * t )*sinh(Y0) - z * cosh(Y0); // Mo Yujun method
  // |temp| is the second term in denominator
  denominator = pow(Sq(xp - x) + Sq(yp - y) +
                    Sq(temp),1.5);
  ff[0] = sign * Sq(hbarc) * Z * alpha_EM * sinh(Y0) * xpperp * rhoFun(xp, yp, zp) * (x - xp) / denominator;
  // calculate the integrand function value, note that |Sq(hbarc)| is $(\hbar c)^2$, this is for unit convertion.
  
  @#
  jacobian = 1.0;
  for (int i = 0; i < *ndim; i++) {
    jacobian = jacobian * (Imax[i] - Imin[i]);
  }
  ff[0] = jacobian * ff[0];
  // because the integral variable is scaled, so the result must be  multiplied by Jacobian.
  return 0;
}

@ Now we have the integrand, we can use Cuba library to calculate the integration.
@<Function: calculate magetic field@>=
int eB(double *eBy, double *totalerror, const int verbose) {
  int comp, nregions, neval, fail;
  double integral, interror, prob;
  double eBp_plus, eBp_minus, eBs_plus, eBs_minus;
  double constant;

  *totalerror = 0.0;
  // for ``participants''
  flag = '+';
  Vegas(4, 1, eB_Part_Int, NULL, nvec, epsrel, epsabs, flags, seed,
        pmineval, pmaxeval, nstart, nincrease, nbatch, gridno,
        statefile, spin, &neval, &fail, &eBp_plus, &interror, &prob);
  *totalerror += interror;
  flag = '-';
  Vegas(4, 1, eB_Part_Int, NULL, nvec, epsrel, epsabs, flags, seed,
        pmineval, pmaxeval, nstart, nincrease, nbatch, gridno,
        statefile, spin, &neval, &fail, &eBp_minus, &interror, &prob);
  *totalerror += interror;
  
  // for ``spectators''
  flag = '+';
  Vegas(3, 1, eB_Spec_Int, NULL, nvec, epsrel, epsabs, flags, seed,
        smineval, smaxeval, nstart, nincrease, nbatch, gridno,
        statefile, spin, &neval, &fail, &eBs_plus, &interror, &prob);
  *totalerror += interror;
  flag = '-';
  Vegas(3, 1, eB_Spec_Int, NULL, nvec, epsrel, epsabs, flags, seed,
        smineval, smaxeval, nstart, nincrease, nbatch, gridno,
        statefile, spin, &neval, &fail, &eBs_minus, &interror, &prob);
  *totalerror += interror;
  *eBy = eBp_plus + eBp_minus + eBs_plus + eBs_minus;
  // |printf(" eBp_plus = %-8g\n eBp_minus = %-8g\n eBs_plus = %-8g\n eBs_minus = %-8g\n", eBp_plus, eBp_minus, eBs_plus, eBs_minus);|
  return 0;
}

@ According to \cite{Kharzeev2008}, we have
\begin{gather}
\frac{\dd{\langle \Delta_\pm^2 \rangle}}{\dd{\eta}} = 2 \kappa \alpha_S \left[ \sum_f q_f^2 \right]^2 \int_{V_\perp} \dd[2]{x_\perp} [\xi^2_+(x_\perp) + \xi^2_- (x_\perp)] \int_{\tau_i}^{\tau_f} \dd{\tau} \tau [eB(\tau, \eta, x_\perp)]^2 \\
\frac{\dd{\langle \Delta_+ \Delta_- \rangle}}{\dd{\eta}} = -4 \kappa \alpha_S \left[ \sum_f q_f^2 \right]^2 \int_{V_\perp} \dd[2]{x_\perp} \xi_+(x_\perp)\xi_- (x_\perp) \int_{\tau_i}^{\tau_f} \dd{\tau} \tau [eB(\tau, \eta, x_\perp)]^2
\end{gather}
where
\begin{equation}
\xi_\pm (x_\perp) = \exp (-^^7c y_\pm(x) - y ^^7c /  \lambda),
\end{equation}
and
\begin{equation}
y_+(x) = -y_-(x) =
\begin{cases}
\sqrt{R^2 - (x-b/2)^2}, & -R + b/2 \leq x \leq 0, \\
\sqrt{R^2 - (x+b/2)^2}, & 0 \leq x \leq R - b/2.
\end{cases}
\end{equation}
Here the $eB$ is the magnetic field in QGP, not in vaccum. So, we use the method in \cite{Deng2012}, we have
\begin{equation}\label{eq:eBy}
B_y(t,\vb*{0}) = \frac{t_0}{t} e^{-\frac{c_s^2}{2d_x^2}(t^2 - t_0^2)} B_y^0(\vb*{0}).
\end{equation}
In \eqref{eq:eBy}, we set $d_x \sim 3$ and $c_s^2 \sim 1/3$.

@ Here we define the $\xi_\pm$ function.
@<Function: $\xi_\pm$ function@>=
double xifun(double xp, double yp, char sign)
{
  double y_plus, y_minus;
  y_plus = sqrt(Sq(R) - Sq(fabs(xp) + b/2.0));
  y_minus = - y_plus;
  if (sign == '+') {
    return exp(-fabs(y_plus - yp)/lambda);
  } else {
    return exp(-fabs(y_minus - yp)/lambda);
  }
}

@ Now, we define the integrand for $\langle \Delta_\pm^2 \rangle$.
@<Function: $\langle \Delta_\pm^2 \rangle$ integrand function@>=
static int delta_pp_Int(const int *ndim, const double xx[], const int *ncomp, double ff[], void *userdata)
{
  static double jacobian;
  static double xp;
  static double yp;
  static double tau;

  static double Imin[3];
  static double Imax[3];
  static double result;
  static double kappa = 1.0, alpha_s = 1.0, sumqf22 = 25.0/81.0;
  static double xi_plus, xi_minus;
  
  Imin[0] = b/2.0 - R;
  Imax[0] = -Imin[0];
  xp = Imin[0] + (Imax[0] - Imin[0]) * xx[0];
  Imin[1] = -sqrt(Sq(R) - Sq(fabs(xp) + b/2.0));
  Imax[1] = -Imin[1];
  yp = Imin[1] + (Imax[1] - Imin[1]) * xx[1];
  Imin[2] = 2.0 * R * exp(-Y0);
  Imax[2] = 15.0;
  tau = Imin[2] + (Imax[2] - Imin[2]) * xx[2];

  xi_plus = xifun(xp, yp, '+');
  xi_minus = xifun(xp, yp, '-');

  result = 2.0 * kappa * alpha_s * sumqf22 * (Sq(xi_plus) + Sq(xi_minus)) * Sq(t0)/ tau * exp(-1.0/27.0 * (Sq(tau) - Sq(t0)) ) * Sq(eBy0);

  jacobian = 1.0;
  for (int i = 0; i < *ndim; i++) {
    jacobian = jacobian * (Imax[i] - Imin[i]);
  }
  ff[0] = jacobian * result;
  
  return 0;
}

@ Now, we define the integrand for $\langle \Delta_+ \Delta_- \rangle$.
@<Function: $\langle \Delta_+ \Delta_- \rangle$ integrand function@>=
static int delta_pm_Int(const int *ndim, const double xx[], const int *ncomp, double ff[], void *userdata)
{
  static double jacobian;
  static double xp;
  static double yp;
  static double tau;

  static double Imin[3];
  static double Imax[3];
  static double result;
  static double kappa = 1.0, alpha_s = 1.0, sumqf22 = 25.0/81.0;
  static double xi_plus, xi_minus;
  
  Imin[0] = b/2.0 - R;
  Imax[0] = -Imin[0];
  xp = Imin[0] + (Imax[0] - Imin[0]) * xx[0];
  Imin[1] = -sqrt(Sq(R) - Sq(fabs(xp) + b/2.0));
  Imax[1] = -Imin[1];
  yp = Imin[1] + (Imax[1] - Imin[1]) * xx[1];
  Imin[2] = 2.0 * R * exp(-Y0);
  Imax[2] = 15.0;
  tau = Imin[2] + (Imax[2] - Imin[2]) * xx[2];

  xi_plus = xifun(xp, yp, '+');
  xi_minus = xifun(xp, yp, '-');

  result = -4.0 * kappa * alpha_s * sumqf22 * xi_plus * xi_minus * Sq(t0)/ tau * exp(-1.0/27.0 * (Sq(tau) - Sq(t0)) ) * Sq(eBy0);

  jacobian = 1.0;
  for (int i = 0; i < *ndim; i++) {
    jacobian = jacobian * (Imax[i] - Imin[i]);
  }
  ff[0] = jacobian * result;
  
  return 0;
}

@ Now we can calculate $\langle \Delta_\pm^2 \rangle$ and $\langle \Delta_+ \Delta_- \rangle$. And according to \cite{Kharzeev2008}, we have
\begin{equation}
a_{++} = a_{--} = \frac{1}{N_+^2} \frac{\pi^2}{16} \langle \Delta_\pm^2 \rangle, \quad a_{+-} = \frac{1}{N_+ N_-} \frac{\pi^2}{16} \langle \Delta_+ \Delta_- \rangle.
\end{equation}
@<Function: calculate chiral separation effects@>=
int csefun(double *app, double *apm, double *delta_pp, double *delta_pm)
{
  int comp, nregions, neval, fail;
  double integral, interror, prob;

  Vegas(3,1,delta_pp_Int, NULL, nvec, epsrel, epsabs, flags, seed, mineval, maxeval, nstart, nincrease, nbatch, gridno, statefile, spin, &neval, &fail, delta_pp, &interror, &prob);
  Vegas(3,1,delta_pm_Int, NULL, nvec, epsrel, epsabs, flags, seed, mineval, maxeval, nstart, nincrease, nbatch, gridno, statefile, spin, &neval, &fail, delta_pm, &interror, &prob);
  printf("delta_pp = %g delta_pm = %g\n", *delta_pp, *delta_pm);
  *app = 1.0/Sq(Np)*Sq(M_PI)/16.0*(*delta_pp);
  *apm = 1.0/(Np*Nm)*Sq(M_PI)/16.0*(*delta_pm);
  return 0;
}

@ Now, let's define the main function.
@<The main program@>=
int main(int argc, char **argv)
{
  double eBy, totalerror, app, apm, delta_pp, delta_pm;
  double tempb, tempNpm;
  int verbose;
  FILE *fp;
  @#
  nvec = 1;
  epsrel = 0.01;
  epsabs = 0.5;
  flags = 0 | 8;
  seed = 0;
  smineval = 1.5e4;
  smaxeval = 4e6;
  pmineval = 2e4;
  pmaxeval = 1e7;
  mineval = 1e5;
  maxeval = 1e7;
  nstart = 1000;
  nincrease = 500;
  nbatch = 1000;
  gridno = 0;
  statefile = NULL;
  spin = NULL;
  @#
  
  if (argc != 5) {
    printf("Error: must have 4 parameters!\n"
           "Usage: aixin Au/Pb/Cu sqrtS lambda Nfile \n");
    return 0;
  }
  @#
  
  @<Set nuclear parameters@>@/
  Y0 = sqrtStoY(atof(argv[2]));
  lambda = atof(argv[3]) * R;
  fp = fopen(argv[4], "r");
  if (fp == NULL) {
    printf("Error: Can't open %s\n", argv[4]);
    exit(EXIT_FAILURE);
  }
  a=0.5;
  x = 0.0;
  y = 0.0;
  z = 0.0;
  t0 = 2.0 * R * exp(-Y0);
  t = t0;
  printf("# app, apm, abs(apm)/app\n");
  while (fscanf(fp, "%lf%lf", &tempb, &tempNpm) == 2) {
    b = tempb;
    Np = tempNpm/2.0;
    Nm = tempNpm/2.0;
    eB(&eBy, &totalerror, 0);
    eBy0 = eBy/Sq(hbarc);
    csefun(&app, &apm, &delta_pp, &delta_pm);
    printf("%g, %g, %g\n", app, apm, fabs(apm)/app);
  }
  return 0;
}

@ In the main function, we use a function to convert collision energy $\sqrt{S}$ into rapidity $Y$. First, we calculate energy of nucleons in laboratory reference system:
\begin{equation}
E_{\text{lab}} = \frac{\sqrt{S}}{2}.
\end{equation}
Then, the momentum of nucleons is
\begin{equation}
p = \sqrt{E_{\text{lab}}^2 - m^2},
\end{equation}
where $m$ is the mass of nucleon, $m = 0.938272 \,\mathrm{GeV}$. Then, according to the definition of rapidity, we have
\begin{equation}
Y = \frac{1}{2} \ln\frac{E+p}{E-p}.
\end{equation}
@<Function: convert collision energy to rapidity@>=
double sqrtStoY(double sqrtS) {
  double E, p, m, Y;
  m = 0.938272;
  E = sqrtS / 2;
  p = sqrt(Sq(E) - Sq(m));
  Y = 0.5 * log((E+p)/(E-p));
  return Y;
}

@ We also need to set the nuclear distribution parameter. Namely, for woods-saxon distribution
\begin{equation}
n_A(r) = \frac{n_0}{1 + \exp(\frac{r-R}{d})},
\end{equation}
we need to know $n_0,\, R,\, d$.
Actually, what we care about is the charge density distribution. The parameters of nuclear charge density distribution can be obtained from elastic electron scattering. According to the reference \cite{de1974nuclear}, we have
\begin{gather}
R = 6.38\,\mathrm{fm}, d = 0.535\,\mathrm{fm}\quad \text{for}\quad \prescript{197}{}{\mathrm{Au}}\\
R = 6.624\,\mathrm{fm}, d = 0.549\,\mathrm{fm}\quad \text{for}\quad \prescript{208}{}{\mathrm{Pb}}\\
R = 4.214\,\mathrm{fm}, d = 0.586\,\mathrm{fm}\quad \text{for}\quad \prescript{63}{}{\mathrm{Cu}}
\end{gather}
Now, we can set $n_0$ by normalize the distribution:
\begin{equation}
4\pi \int \rho(r) r^2 \dd{r} = 1.
\end{equation}
we have:
\begin{gather}
n_0 = 8.59624 \times 10^{-4} \quad \text{for} \prescript{197}{}{\mathrm{Au}}, \\
n_0 = 7.69244 \times 10^{-4} \quad \text{for} \prescript{208}{}{\mathrm{Pb}}, \\
n_0 = 2.67894 \times 10^{-3} \quad \text{for} \prescript{63}{}{\mathrm{Cu}}.
\end{gather}
@<Set nuclear parameters@>=
if (strcmp(argv[1], "Au") == 0) {
    R = 6.38; 
    d = 0.535;
    n0 = 8.59624e-4;
    Z = 79.0;
  }@+ else if (strcmp(argv[1], "Pb") == 0) {
    R = 6.624;
    d = 0.549;
    n0 = 7.69244e-4;
    Z = 82.0;
  }@+ else if (strcmp(argv[1], "Cu") == 0) {
    R = 4.214;
    d = 0.586;
    n0 = 2.67894e-3;
    Z = 29.0;
  }@+ else {
    printf("Error: the first parameter must be 'Au' or 'Pb' or 'Cu'!\n");
    return 0;
  }
  
@

\bibliography{ref}

@
\end{document}