#import "../syth_template.typ": conf, block_colors, note_block

// Material added from the official syllabus is intentionally shown in dark purple.
#let added_purple = rgb("#5B2C83")
#let added(body) = {
  set text(fill: added_purple)
  body
}
#show: conf.with(
  title: [
    EDP - Partial Differential Equations\
    (Equations aux Dérivées Partielles)
  ],
  course: "LELEC1103",
  authors: (
     (name: "Victor Carballes", affiliation: "UCLouvain"),
   ),
  abstract: [
  This document contains the first part of the course LELEC1103 - EDP and Complex Analysis, focusing on the practical aspect (exams and exercises). This part covers how to solve partial differential equations (PDEs) using methods such as the characteristic method in both 1D and 2D, as well as the separation of variables method. We will see PDEs from 1st and 2nd order, and both linear and non-linear equations. The main focus will be on linear PDEs of 2nd order, which can be classified into three types: elliptic, parabolic and hyperbolic. The synthesis also includes the principal canonical forms, systems of first-order PDEs, mixed-character problems, eigenfunction/orthogonality tools, diffusion, Helmholtz problems and circular-domain/Bessel methods used in the syllabus. \ #box(move(dy: 0.4em, [ Source code here : #text(fill: color.aqua.darken(20%))[#link("https://github.com/vctrcc/personal-typst-archive")]]))
  ],
)

= Types of PDEs (EDPs)
== Definitions
For a given PDE of linear form (2nd order, 2 variables): :

#align(center,
  $A (partial^2 u)/(partial x^2) + B (partial^2 u)/(partial x partial y) + C (partial^2 u)/(partial y^2) + D (partial u)/(partial x) + E (partial u)/(partial y) + G u = F\
  "With" A, B, C, D, E, F, G ", being at most as functions of x and y"$
)
Its solution can be written as the sum of the *homogeneous solution* $u_h$ (solution of the associated homogeneous equation where $F = 0$) and a *particular solution* $u_p$ (any specific solution of the complete equation). The homogeneous part is then chosen so that the total solution satisfies the boundary and initial conditions :
#align(center, $u(x, y) = u_h (x, y) + u_p (x, y)$)

A PDE is considered *quasi-linear* if it is linear in its highest order derivatives, even if it may be non-linear in lower order terms or the function itself (coefficients A, B, C may depend on x, y, u, and lower derivatives). Stability refers to the behavior of solutions under small perturbations of initial or boundary conditions.

Quasi-linear PDE example (2nd order, homogeneous): $((partial u)/(partial y))^2 (partial^2 u)/(partial x^2) + ((partial u)/(partial x))^2 (partial^2 u)/(partial y^2) = 0$

#note_block(block_colors.note)[ Some quasi-linear PDEs can be written in _*conservation form*_ (or _*divergence form*_):\
   $partial_t u + nabla dot F(u) = 0$. The solution of a PDE is a function satisfying the equation, not an integral. A PDE is said to be _*well-posed*_ (in the sense of Hadamard) if: (1) a solution exists, (2) the solution is unique, and (3) the solution depends continuously on the initial/boundary data.]

Definition of some important terms related to PDEs:
#table(
  columns: (auto, 1fr),
  stroke: none,
  column-gutter: 1em,
  [*order n PDE*], [The order n of a PDE is the highest order of partial derivative appearing in the equation, e.g. $(partial^n u)/(partial x^n)$.],
  [*linearity*], [A PDE is linear if it can be written in the form $L(u) = F$, where $L$ is a linear operator and $F$ is a given function. Otherwise, it is non-linear.],
  [*homogeneity*], [For a linear PDE $L(u)=F$, the equation is homogeneous if $F = 0$. Otherwise, it is non-homogeneous if $F != 0$.],
  [*stability*], [A PDE is stable if small changes in the initial or boundary conditions lead to small changes in the solution. Otherwise, it is unstable.],
)
== Classification of second-order linear PDEs
For a partial second-order linear PDE of two variables, we can write it in the form :
$ A (partial^2 u)/(partial x^2) + B (partial^2 u)/(partial x partial y) + C (partial^2 u)/(partial y^2) = F $
We can now look at both homogenous characteristic solutions for *each axis* :
$  cases(
  A ((dif y)/(dif x))^2 - B (dif y)/(dif x) + C = 0,
  A - B (dif x)/(dif y) + C ((dif x)/(dif y))^2 = 0
) stretch(->)^"Discriminants" cases(
  (dif y)/(dif x) : Delta = B^2 - 4 A C,
  (dif x)/(dif y) : Delta = B^2 - 4 A C
) stretch(->)^"Solutions" cases(
  (dif y)/(dif x) = (B plus.minus sqrt(Delta))/(2 A),
  (dif x)/(dif y) = (B plus.minus sqrt(Delta))/(2 C)
) $
#note_block(block_colors.note)[
  The explicit slope formulas assume the denominator is non-zero. If $A=0$ or $C=0$, use the characteristic differential equation directly, or use the reciprocal slope that does not divide by zero.
]

#added[
#note_block(block_colors.note)[
  *Coefficient convention:* In this course, the second-order principal part is written
  $ A (partial^2 u)/(partial x^2) + B (partial^2 u)/(partial x partial y) + C (partial^2 u)/(partial y^2) $
  so its symmetric quadratic-form matrix is
  $ M = mat(delim: "(", A, B/2; B/2, C) $
  The off-diagonal entries are $B/2$ because the two symmetric cross terms add up to $B$.

  Some books instead write the mixed derivative as $2 B (partial^2 u)/(partial x partial y)$. With that convention the matrix contains $B$ directly off-diagonal and the discriminant is often written $B^2-A C$. It is the *same classification*, only a different coefficient convention. In this document, always use the course convention $Delta=B^2-4 A C$.
]
]

#let c_hyp = rgb("#d9f0ff"); #let c_hyp_sec = c_hyp.lighten(40%)
#let c_ell = rgb("#e5ffbe"); #let c_ell_sec = c_ell.lighten(40%)
#let c_par = rgb("#ffd9d9"); #let c_par_sec = c_par.lighten(40%)
#let c_mix = rgb("#f2f2f2"); #let c_mix_sec = c_mix.lighten(40%)

We can classify it based on the discriminant *$Delta = B^2 - 4 A C$* :
#align(center)[
  #grid(
    columns: (auto, auto, 1fr, auto),
    //column-gutter: 1.5em,
    //row-gutter: 0.5em,
    stroke: 1pt + white,
    inset: (x: 0.5em, y: 0.3em),
    align: left,
    grid.cell(fill: c_hyp)[*$Delta > 0$*], grid.cell(fill: c_hyp)[*Hyperbolic*], grid.cell(fill: c_hyp)[e.g., 1D wave equation], grid.cell(fill: c_hyp)[Characteristic, Var. Sep.],
    grid.cell(fill: c_par)[*$Delta = 0$*], grid.cell(fill: c_par)[*Parabolic*], grid.cell(fill: c_par)[e.g., heat equation, diffusion equation], grid.cell(fill: c_par)[Var. Sep.],
    grid.cell(fill: c_ell)[*$Delta < 0$*], grid.cell(fill: c_ell)[*Elliptic*], grid.cell(fill: c_ell)[e.g., Laplace's equation, Poisson's equation], grid.cell(fill: c_ell)[Var. Sep.],
  )
]

== List of common PDEs
Some common PDEs encountered in various fields include:
  $ A (partial^2 u)/(partial x^2) + B (partial^2 u)/(partial x partial y) + C (partial^2 u)/(partial y^2) + D (partial u)/(partial x) + E (partial u)/(partial y) + G u + F = 0 $
#let sm(x) = [#h(-0.1em) #text(size: 7pt)[$#x$]]
#let wdqp = 1em
#align(center)[#block(width: 110%)[
#table(
  columns: (7em, auto, 14em, wdqp, wdqp, wdqp, wdqp, wdqp, wdqp, wdqp),
  stroke: 1pt + white,
  inset: (x: 0.6em , y: 0.7em),
  align: horizon,
  [*Type*], [*Name*], [*Equation*], sm("A"), sm("B"), sm("C"), sm("D"), sm("E"), sm("F"), sm("G"),

  table.cell(rowspan: 5, fill: c_hyp, align: center + horizon)[*Hyperbolic*\ #place(dy: 10pt)[#align(center, text(size: 8pt)[Characteristics,\ Variable Separation])]],
  table.cell(fill: c_hyp)[Wave equation (Onde)],
  table.cell(fill: c_hyp)[$(partial^2 u)/(partial t^2) = c^2 nabla^2 u$],
  table.cell(fill: c_hyp)[/], table.cell(fill: c_hyp)[/], table.cell(fill: c_hyp)[/], table.cell(fill: c_hyp)[/], table.cell(fill: c_hyp)[/], table.cell(fill: c_hyp)[/], table.cell(fill: c_hyp)[/],

  table.cell(fill: c_hyp_sec)[1D Wave equation],
  table.cell(fill: c_hyp_sec)[$-c^2 (partial^2 u)/(partial x^2) + (partial^2 u)/(partial t^2) = 0$],
  table.cell(fill: c_hyp_sec)[#sm($-c^2$)], table.cell(fill: c_hyp_sec)[#sm(0)], table.cell(fill: c_hyp_sec)[#sm(1)], table.cell(fill: c_hyp_sec)[#sm(0)], table.cell(fill: c_hyp_sec)[#sm(0)], table.cell(fill: c_hyp_sec)[#sm(0)], table.cell(fill: c_hyp_sec)[#sm(0)],

  table.cell(fill: c_hyp_sec)[2D Wave equation],
  table.cell(fill: c_hyp_sec)[$nabla^2 u - 1/c^2 u_(t t)= 0$],
  table.cell(fill: c_hyp_sec)[/], table.cell(fill: c_hyp_sec)[/], table.cell(fill: c_hyp_sec)[/], table.cell(fill: c_hyp_sec)[/], table.cell(fill: c_hyp_sec)[/], table.cell(fill: c_hyp_sec)[/], table.cell(fill: c_hyp_sec)[/],

  table.cell(fill: c_hyp)[Transport equation (conservative)],
  table.cell(fill: c_hyp)[$(partial u)/(partial t) + underbrace((partial (c u))/(partial x),c (partial u)/(partial x) + u (partial c)/(partial x)) = 0$],
  table.cell(fill: c_hyp)[#sm(0)], table.cell(fill: c_hyp)[#sm(0)], table.cell(fill: c_hyp)[#sm(0)], table.cell(fill: c_hyp)[#sm($c$)], table.cell(fill: c_hyp)[#sm(1)], table.cell(fill: c_hyp)[#sm(0)], table.cell(fill: c_hyp)[#sm($c_x$)],

  table.cell(fill: c_hyp_sec)[Transport equation (classical)],
  table.cell(fill: c_hyp_sec)[$(partial u)/(partial t) + c (partial u)/(partial x) = 0$],
  table.cell(fill: c_hyp_sec)[#sm(0)], table.cell(fill: c_hyp_sec)[#sm(0)], table.cell(fill: c_hyp_sec)[#sm(0)], table.cell(fill: c_hyp_sec)[#sm($c$)], table.cell(fill: c_hyp_sec)[#sm(1)], table.cell(fill: c_hyp_sec)[#sm(0)], table.cell(fill: c_hyp_sec)[#sm(0)],
  table.cell(rowspan: 5, fill: c_ell, align: center + horizon)[*Elliptic*\ #place(dy: 10pt)[#align(center, text(size: 8pt)[Variable Separation])]],
  table.cell(fill: c_ell)[Laplace's equation],
  table.cell(fill: c_ell)[$nabla^2 u = 0$],
  table.cell(fill: c_ell)[/], table.cell(fill: c_ell)[/], table.cell(fill: c_ell)[/], table.cell(fill: c_ell)[/], table.cell(fill: c_ell)[/], table.cell(fill: c_ell)[/], table.cell(fill: c_ell)[/],

  table.cell(fill: c_ell_sec)[2D Laplace's equation],
  table.cell(fill: c_ell_sec)[$(partial^2 u)/(partial x^2) + (partial^2 u)/(partial y^2) = 0$],
  table.cell(fill: c_ell_sec)[#sm(1)], table.cell(fill: c_ell_sec)[#sm(0)], table.cell(fill: c_ell_sec)[#sm(1)], table.cell(fill: c_ell_sec)[#sm(0)], table.cell(fill: c_ell_sec)[#sm(0)], table.cell(fill: c_ell_sec)[#sm(0)], table.cell(fill: c_ell_sec)[#sm(0)],

  table.cell(fill: c_ell)[Poisson's equation],
  table.cell(fill: c_ell)[$nabla^2 u = f(x,y)$],
  table.cell(fill: c_ell)[/], table.cell(fill: c_ell)[/], table.cell(fill: c_ell)[/], table.cell(fill: c_ell)[/], table.cell(fill: c_ell)[/], table.cell(fill: c_ell)[/], table.cell(fill: c_ell)[/],

  table.cell(fill: c_ell_sec)[2D Poisson's equation],
  table.cell(fill: c_ell_sec)[$(partial^2 u)/(partial x^2) + (partial^2 u)/(partial y^2) = f(x,y)$],
  table.cell(fill: c_ell_sec)[#sm(1)], table.cell(fill: c_ell_sec)[#sm(0)], table.cell(fill: c_ell_sec)[#sm(1)], table.cell(fill: c_ell_sec)[#sm(0)], table.cell(fill: c_ell_sec)[#sm(0)], table.cell(fill: c_ell_sec)[#sm($-f$)], table.cell(fill: c_ell_sec)[#sm(0)],

  table.cell(fill: c_ell)[Helmholtz equation],
  table.cell(fill: c_ell)[$nabla^2 u + lambda u = 0$],
  table.cell(fill: c_ell)[#sm(1)], table.cell(fill: c_ell)[#sm(0)], table.cell(fill: c_ell)[#sm(1)], table.cell(fill: c_ell)[#sm(0)], table.cell(fill: c_ell)[#sm(0)], table.cell(fill: c_ell)[#sm(0)], table.cell(fill: c_ell)[#sm($lambda$)],

  table.cell(rowspan: 4, fill: c_par, align: center + horizon)[*Parabolic*\ #place(dy: 10pt)[#align(center, text(size: 8pt)[Variable Separation])]],
  table.cell(fill: c_par)[Heat equation (Chaleur)],
  table.cell(fill: c_par)[$(partial u)/(partial t) = alpha nabla^2 u$],
  table.cell(fill: c_par)[/], table.cell(fill: c_par)[/], table.cell(fill: c_par)[/], table.cell(fill: c_par)[/], table.cell(fill: c_par)[/], table.cell(fill: c_par)[/], table.cell(fill: c_par)[/],

  table.cell(fill: c_par_sec)[1D Heat equation],
  table.cell(fill: c_par_sec)[$alpha (partial^2 u)/(partial x^2) - (partial u)/(partial t) = 0$],
  table.cell(fill: c_par_sec)[#sm($alpha$)], table.cell(fill: c_par_sec)[#sm(0)], table.cell(fill: c_par_sec)[#sm(0)], table.cell(fill: c_par_sec)[#sm(0)], table.cell(fill: c_par_sec)[#sm(-1)], table.cell(fill: c_par_sec)[#sm(0)], table.cell(fill: c_par_sec)[#sm(0)],

  table.cell(fill: c_par_sec)[2D Heat equation],
  table.cell(fill: c_par_sec)[$(partial u)/(partial t) = alpha ((partial^2 u)/(partial x^2) + (partial^2 u)/(partial y^2))$],
  table.cell(fill: c_par_sec)[/], table.cell(fill: c_par_sec)[/], table.cell(fill: c_par_sec)[/], table.cell(fill: c_par_sec)[/], table.cell(fill: c_par_sec)[/], table.cell(fill: c_par_sec)[/], table.cell(fill: c_par_sec)[/],

  table.cell(fill: c_par)[Diffusion equation],
  table.cell(fill: c_par)[$(partial u)/(partial t) = partial/(partial x)(alpha (partial u)/(partial x))$],
  table.cell(fill: c_par)[#sm($alpha$)], table.cell(fill: c_par)[#sm(0)], table.cell(fill: c_par)[#sm(0)], table.cell(fill: c_par)[#sm($alpha_x$)], table.cell(fill: c_par)[#sm(-1)], table.cell(fill: c_par)[#sm(0)], table.cell(fill: c_par)[#sm(0)],

  table.cell(fill: c_mix)[*Nonlinear*],
  table.cell(fill: c_mix)[Viscous Burgers' equation\ (nonlinear transport + diffusion)],
  table.cell(fill: c_mix)[$(partial u)/(partial t) + u (partial u)/(partial x) = nu (partial^2 u)/(partial x^2)$],
  table.cell(fill: c_mix)[#sm($-nu$)], table.cell(fill: c_mix)[#sm(0)], table.cell(fill: c_mix)[#sm(0)], table.cell(fill: c_mix)[#sm($u$)], table.cell(fill: c_mix)[#sm(1)], table.cell(fill: c_mix)[#sm(0)], table.cell(fill: c_mix)[#sm(0)],
)]]

#note_block(block_colors.note)[
  The discriminant $B^2-4A C$ is a classification for *second-order PDEs*. The transport equation shown in the table is first order, so this discriminant does not apply to it. It is nevertheless called hyperbolic in the first-order sense because information propagates along real characteristic curves. Its classical and conservative forms may also lead to different amplitude equations along the same characteristic flow.
]

#note_block(block_colors.note)[
Some of these equations can be extended to spherical and cylindrical coordinate systems (e.g., Laplace's equation, Helmholtz equation). Since the PDEs studied here are mainly scalar, the useful expression is the scalar Laplacian :
- *Cylindrical coordinates* : $x = r cos(theta)$, $"   "y = r sin(theta)$, $z = z$
  #block()
  $ nabla^2 u(r, theta, z) = (1/r) partial/(partial r) (r (partial u)/(partial r)) + (1/r^2) (partial^2 u)/(partial theta^2) + (partial^2 u)/(partial z^2) $
- *Spherical coordinates* : $x = r sin(theta) cos(phi)$, $"   "y = r sin(theta) sin(phi)$, $"   "z = r cos(theta)$
  #block()
  $ nabla^2 u(r, theta, phi) = (1/r^2) partial/(partial r) (r^2 (partial u)/(partial r)) + (1/(r^2 sin(theta))) partial/(partial theta) (sin(theta) (partial u)/(partial theta)) + (1/(r^2 sin^2(theta))) (partial^2 u)/(partial phi^2) $
]

#block(breakable: false)[
#note_block(block_colors.warning)[
  For example, in other courses such as LELEC1755, we encounter vector operators like $nabla dot arrow(A)$ (divergence) and $nabla times arrow(A)$ (curl). However, in this EDP course, we primarily work with scalar PDEs and the Laplacian operator $nabla^2$. We will therefore keep the scalar notation here to avoid mixing the scalar Laplacian with vector divergence or vector Laplacians.
]
]

== Types of resolution, and limitations
There are several methods to solve PDEs, each with its own advantages and limitations. We will see two of the most common methods in this course :
=== Method of characteristics
This method's concept is to use a curve in space as a integration path, where we will then study characteristics that emanate from the equation at the points of the curve.
#block()
Formally, we are stepping along a curve $Gamma(x(s), y(s))$ defined by a parameter $s$, and we follow the value $U(s) = u(x(s), y(s))$ along that curve. The solution is then obtained by solving the characteristic ODEs with appropriate initial or boundary conditions. This method is particularly useful for *hyperbolic* PDEs, such as the transport equation. And can be used for non-linear PDEs and second-order hyperbolic problems as well.
$ A (partial u)/(partial x) + B (partial u)/(partial y) = 0 " "-->" " underbrace((dif y)/(dif x) = B/A, "Information\npropagation\ndirection" ) $

#block()
For second-order hyperbolic problems, we obtain two real families of characteristic curves. They are *not generally orthogonal*. A change of variables built from these two families can reduce the principal part of the PDE to a much simpler canonical form.
$ A (partial^2 u)/(partial x^2) + B (partial^2 u)/(partial x partial y) + C (partial^2 u)/(partial y^2) = 0 $
$  cases(
  A ((dif y)/(dif x))^2 - B (dif y)/(dif x) + C = 0,
  A - B (dif x)/(dif y) + C ((dif x)/(dif y))^2 = 0
) stretch(->)^"Discriminant" Delta = B^2 - 4 A C stretch(->)^"Solutions" cases(
  (dif y)/(dif x) = (B plus.minus sqrt(Delta))/(2 A),
  (dif x)/(dif y) = (B plus.minus sqrt(Delta))/(2 C)
) $
#block()
Typical hyperbolic equations:
#grid(
  columns: (0.9fr, 2fr),
  inset: 4pt,
  stroke: 0.1em + gray,
  grid.cell(align: center+horizon)[1D First Order\ Conserv. Transport Equation], [$  (partial u)/(partial t) + (partial (c u))/(partial x) = 0 --> cases((dif x)/(dif t) = c(x), (dif u)/(dif t) = - (partial c)/(partial x) u) $],
  grid.cell(align: center+horizon)[1D Second Order\ Wave Equation],[$  (partial^2 u)/(partial t^2) - c^2(partial^2 u)/(partial x^2) = 0 --> u(x, t) = f(x - c t) + g(x + c t) $],
)

=== Separation of variables
This method involves assuming the solution is a product of functions depending on one variable each. This allows us to separate the PDE into simpler ODEs that can be solved independently.
#block()
Formally, we assume a solution of the form $u(x, y) = X(x) Y(y)$, where $X(x)$ and $Y(y)$ are functions to be determined. By substituting this form into the PDE and separating variables, we can obtain two ODEs for $X(x)$ and $Y(y)$. That depend on a separation constant. The general solution is then obtained by combining the solutions of these ODEs. This method is particularly useful for *elliptic* and *parabolic* PDEs, such as Laplace's equation and the heat equation. However, it is limited to problems with simple geometries and boundary conditions.
#block()
Direct separation is simplest when the boundary conditions associated with the eigenfunction are homogeneous. If several boundary conditions are non-homogeneous, we can often use superposition ($u = u_1 + u_2 + ...$), or first subtract a simple function that homogenises the boundary conditions. If the imposed data are incompatible at a corner, the Fourier representation may then show a Gibbs phenomenon near the discontinuity (rippling).
#block()
The solutions of this method are often expressed as infinite series (e.g., Fourier series) to satisfy boundary conditions. And requires us to use orthogonal base functions (e.g., sine and cosine functions) to represent the solution.
#block()
Typical forms:
#grid(
  columns: (1fr),
  inset: 4pt,
  stroke: 0.1em + gray,
  [$ nabla^2 u(x,y) &= nabla^2 (X(x) Y(y)) = 0 --> X''/X = -Y''/Y= lambda = plus.minus k^2\
 u(x, y) &= X(x) Y(y) = sum_(n=1)^(infinity) tilde(A_n) sin(k_n x) sinh(k_n y) "   (example depending on the BCs)" $],
 [$ nabla^2 u(r,theta) &= nabla^2 (R(r)Theta(theta)) = 0 --> Theta''/Theta = -(r^2 R''+r R')/R = -k^2\
 R(r) &= C (r/a)^k + D (r/a)^(-k), "   " Theta(theta) = A cos(k theta) + B sin(k theta) "   (a: reference radius)" $],
 [$ (partial^2 u)/(partial t^2) &= c^2 ((partial^2 u)/(partial x^2) + (partial^2 u)/(partial y^2)), "   " u=T(t)X(x)Y(y)\
 X''/X &= -l^2, "   " Y''/Y=-p^2, "   " 1/c^2 T''/T = -(l^2+p^2)=-k^2\
 k_(n m)^2 &= l_n^2+p_m^2, "   " u(x,y,t) = sum_(n=1)^(infinity) sum_(m=1)^(infinity) tilde(C_(n m)) sin(l_n x) sin(p_m y) cos(c k_(n m) t) $],
 [
  #align(center)[
    $u_(m n)(r,theta,t) = J_m (k_(m n) r) (A_(m n) cos(m theta)+B_(m n) sin(m theta)) cos(c k_(m n) t)$\
    #text(size: 9pt)[(zero initial velocity example)]
  ]
 ],
 [$ u_"trans"(x,t) = sum_(n=1)^infinity A_n sin(k_n x) e^(-alpha k_n^2 t) "   (homogeneous Dirichlet example)" $],
)

#note_block(block_colors.extra)[
  Other methods exist, such as numerical methods (finite difference, finite element, finite volume), transform methods (Fourier transform, Laplace transform), and Green's functions. These methods are often used for more complex problems or when analytical solutions are not feasible.
]

= Practical resolution of PDEs

PDEs can be solved with dimensional variables. However, in this course it is often useful to *non-dimensionalise* the problem before solving it, especially to simplify constants and check units. For example : $x'=x/L, y'=y/H, t'=c_0 t/L=t/tau$.

== 1st order PDEs and the method of characteristics
The method of characteristics is a powerful technique for solving first-order partial differential equations (PDEs). It involves *transforming the PDE into a set of ordinary differential equations (ODEs)* along curves called characteristics. These characteristics are determined by the coefficients of the PDE and represent the *paths along which information propagates* in the solution.

#figure(
  image("EDP_diagrams/1D_charact.png", width: 50%),
  caption: "Characteristic curves for a hyperbolic PDE in 1D",
)
#block()
Consider a first-order PDE of the form:
$ P (partial u)/(partial x) + Q (partial u)/(partial y) = R $
Where $P$, $Q$, and $R$ are functions of $x$, $y$, and $u$.

Along a characteristic curve $Gamma(s) = (x(s), y(s))$, define $U(s) = u(x(s), y(s))$. By the chain rule :
$ (dif U)/(dif s) = (partial u)/(partial x) (dif x)/(dif s) + (partial u)/(partial y) (dif y)/(dif s) $
We choose the characteristic curve so that :
$ cases(
  (dif x)/(dif s) = P(x,y,U),
  (dif y)/(dif s) = Q(x,y,U),
  (dif U)/(dif s) = R(x,y,U)
) $
The PDE has therefore been transformed into a system of ODEs along the characteristics.

When the denominators are non-zero, we often use the compact notation :
$ (dif x)/P = (dif y)/Q = (dif U)/R $
Which is equivalent to the cross-multiplied relations :
$ cases(
  P dif y = Q dif x,
  P dif U = R dif x,
  Q dif U = R dif y
) $

#note_block(block_colors.warning)[
  In exams, the safest form is to first write the characteristic ODE system $(dif x)/(dif s)=P$, $(dif y)/(dif s)=Q$, $(dif U)/(dif s)=R$. The ratio notation is only a shorthand and has to be used carefully when one of $P,Q,R$ vanishes.
]

Then, use the first relation to solve for $s(x, y), x(s, y) "and" y(x, s)$. This will give you *the equation of the characteristic curves*. In practice, the characteristic slope is :
$ (dif y)/(dif x) = Q/P $
If this ODE is separable, we can integrate it directly. Otherwise, it has to be solved as an ODE.

To draw the graph, one strong recommendation is first to find the slope of the characteristics at a given point $(x_0, y_0)$ using $(dif y)/(dif x) = Q(x_0, y_0)/P(x_0, y_0)$, then draw the tangent line at that point. Repeat this process for several points to get a good representation of the characteristic curves. Keep in mind that when solving in $s(x, y "or" t)$, you can consider certain parameters such as s as "constant" when the characteristic parametrisation allows it.

Then, use the third characteristic ODE to find $U(s)$ along these curves. Equivalently, when the corresponding denominator is non-zero :
$ (dif U)/(dif x) = R/P $
#align(center, "or")
$ (dif U)/(dif y) = R/Q $
After replacing the other variables by the characteristic relations, these become ordinary differential equations in one variable.

#note_block(block_colors.trick)[
  If one of the non-integrated variables finds itself in the ODE for $U$, use the previously found characteristic relation $x(s,y)$ or $y(x,s)$ to substitute it and reduce the equation to one independent variable.
]
Finally, combine the solutions along all characteristics to obtain the general solution of the PDE. This involves eliminating the parameter $s$ to express $u$ as a function of $x$ and $y$. You can check your solution if both of the equations involving R are equal for $u(x, y)$.

#note_block(block_colors.warning)[
  Don't forget to move the terms to their correct side before integrating!
]

#note_block(block_colors.warning)[
    Always replace the $s$ parameter in the final solution for the exam !
]
#note_block(block_colors.note)[
  Sometimes R is not completely defined, and requires you to move some terms around, such as with the *transport equation in conservative form* :
  $ (partial u)/(partial t) + (partial (c u))/(partial x) = S = (partial u)/(partial t) + (c (partial u)/(partial x) + u (partial c)/(partial x)) -> underbrace(c, "P") (partial u)/(partial x) + underbrace(1, "Q") (partial u)/(partial t) = underbrace(S - u (partial c)/(partial x), "R") $
  Where S is a source term depending on x and t.
]

#note_block(block_colors.note)[ The method of characteristics is particularly useful for solving hyperbolic PDEs, such as the *transport equation* and *certain nonlinear equations like Burgers' equation*. It provides a geometric interpretation of the solution and can predict where characteristics intersect and shocks form. Once characteristics cross, the classical smooth solution generally stops existing and the problem has to be continued with weak/entropy solutions.]

#added[
==== Boundary conditions and well-posedness
A Cauchy curve must *not* be tangent to a characteristic. If the data curve were itself characteristic, the variation of $u$ on it would already be imposed by the characteristic compatibility relation, so arbitrary data could not be prescribed there.

For a bounded transport problem, boundary conditions are imposed only where characteristics *enter* the domain. At an outgoing boundary, the solution is already determined by information arriving from the interior and no extra value of $u$ can be imposed.

#note_block(block_colors.trick)[
  At the exam, draw the local characteristic direction first. If the characteristic enters the domain, you need boundary data there. If it leaves the domain, do not impose an additional condition.
]
]

=== Example 1 : The transport equation (APE 2)
Consider the 1D transport equation:
$ underbrace((partial u)/(partial t) + c (partial u)/(partial x), "non-conservative") = S(x,t) "                  "
underbrace((partial u)/(partial t) + (partial (c u))/(partial x), "conservative") = S(x,t) $
Where $c(x)$ is the transport speed, and $S(x,t)$ is a source term (often 0).

The conservative equation satisfies the conservation law (with appropriate decay or boundary-flux conditions) :
$ (partial I)/(partial t) &= partial/(partial t) integral_0^infinity u(x,t) dif x\
&= integral_0^infinity S(x,t) dif x - [c u]_0^infinity $
Thus, if $S=0$ and the boundary flux $c u$ vanishes at both ends, the total quantity $I$ is conserved.

When solving this PDE, we will use the conservative form and consider $c(x)>0$. Expanding the derivative gives :
$ (partial u)/(partial t) + c(x)(partial u)/(partial x) = S(x,t) - u (partial c)/(partial x) $
So that :
$ P=c(x), "   " Q=1, "   " R=S-u (partial c)/(partial x) $

The characteristic ODEs are therefore :
$ cases(
  (dif x)/(dif s) = c(x),
  (dif t)/(dif s) = 1,
  (dif U)/(dif s) = S(x,t) - U (partial c)/(partial x)
) $
Using $t$ as the parameter :
$ (dif x)/(dif t) = c(x) "   "<==>"   " (dif t)/(dif x) = 1/c(x) $
The characteristic curves satisfy :
$ t - t_0 = integral_(x_0)^x 1/c(xi) dif xi $
This relation determines the starting point $x_0$ of the characteristic passing through $(x,t)$.

Along the same characteristic, the amplitude satisfies :
$ (dif U)/(dif t) = S(x(t),t) - (partial c)/(partial x)(x(t)) U $
or, when $c(x) != 0$ :
$ (dif U)/(dif x) = (S - U (partial c)/(partial x))/c(x) $

#note_block(block_colors.note)[
  For the homogeneous conservative equation ($S=0$), there is a particularly simple result. Along a characteristic :
  $ (dif)/(dif t) (c(x(t)) U(t)) = 0 $
  Therefore $c(x)u$ is constant along the characteristic :
  $ c(x) u(x,t) = c(x_0) u_0(x_0) $
  with $x_0$ found from $t = integral_(x_0)^x 1/c(xi) dif xi$.
]

If a source term is present, the same idea gives :
$ c(x(t))U(t) = c(x_0)U(0) + integral_0^t c(x(tau)) S(x(tau),tau) dif tau $

If no source term is given in the problem, then $S=0$.

Finally, replace the characteristic starting parameter $x_0$ (or $s$) to express $u$ only as a function of $x$ and $t$.

#block()#block()
In the special case of constant speed $c_0$ and the classical transport equation $u_t+c_0u_x=0$, a moving observer following the characteristic sees a constant value :
$ "Moving observer" : x_p(t) = x_0 + c_0 t "   "-->"   " x_p(0)=x_0 $
$ "Solution for observer" : u_p(t) = u(x_p(t),t) = u_0(x_0) $
Equivalently, the field solution is $u(x,t)=u_0(x-c_0t)$.

#note_block(block_colors.trick)[
  Don't forget to do some old exams ! They often have the exercises in REVERSE, that means that from the solution, you need to get back the parameters of the PDE (P, Q, R, c(x), S(x,t), initial conditions, etc...).
]

=== Example 2 : Non-linear non conservative transport equation
Non linear non conservative transport equations are when the propagation speed $c(u)$ depends on $u$ :
$ (partial u)/(partial t) + c(u) (partial u)/(partial x) = 0 $
Along a smooth characteristic :
$ cases((dif x)/(dif t)=c(U), (dif U)/(dif t)=0) $
So $U$ is constant on each characteristic, and each characteristic is a straight line whose speed depends on its initial value.

#added[
For the initial condition $u(s,0)=f(s)$, the value $u=f(s)$ stays constant on the characteristic leaving $s$, and therefore :
$ x=s+c(f(s))t $
The characteristic network now depends on the initial condition itself. This creates two important zones :
- *Expansion zone* : neighbouring characteristics separate, and the solution stays regular.
- *Compression zone* : neighbouring characteristics approach and can intersect after a finite time. The classical single-valued solution then develops a discontinuity (shock).

For the Burgers equation, $c(u)=u$ :
$ (partial u)/(partial t)+u(partial u)/(partial x)=0 stretch(<=>) (partial u)/(partial t)+partial/(partial x)(u^2/2)=0 $
The characteristics are especially simple :
$ u(x,t)=f(s), "   " x=s+f(s)t $
Equivalently, the solution before the first crossing can be written implicitly as :
$ u(x,t)=f(x-u(x,t)t) $

*Shock formation :* two neighbouring characteristics leaving $s$ and $s+dif s$ first intersect when :
$ 1+f'(s)t=0 stretch(=>) t=-1/f'(s) $
Hence the first shock appears at :
$ t_* = min_(f'(s)<0) (-1/f'(s)) = -1/(min_s f'(s)) $
when the minimum derivative is negative.

Once a shock exists, let $u_g$ and $u_d$ denote the values immediately to the left and right of the discontinuity. For Burgers, the discontinuity position $x_c(t)$ moves with :
$ (dif x_c)/(dif t) = (u_g+u_d)/2 $
This is the mean of the characteristic speeds on the two sides. The total integral of $u$ remains conserved (for a periodic domain or suitable decay at infinity), while the quadratic quantity decreases across the shock :
$ (dif)/(dif t) integral u^2/2 dif x = -(u_g-u_d)^3/12 < 0 $
So the smooth Burgers problem is reversible before shock formation, but the discontinuous solution dissipates this quadratic energy afterwards.

#note_block(block_colors.trick)[
  On an exam, the quickest way to detect a future shock is usually to draw the characteristic slopes $dif x/dif t=f(s)$ and look for a compression region. The analytical check is $1+f'(s)t=0$.
]
]

== 2nd order PDEs
For second-order PDEs, we will focus on linear equations of the form:
$ A (partial^2 Phi)/(partial x^2) + B (partial^2 Phi)/(partial x partial y) + C (partial^2 Phi)/(partial y^2) = R $
Where $A$, $B$, and $C$ are constants, and $R$ is a function of $x$ and $y$. The classification of these equations into elliptic, parabolic, and hyperbolic types is based on the discriminant $Delta = B^2 - 4 A C$.
- If $Delta > 0$, the equation is *hyperbolic* (e.g., wave equation).
- If $Delta = 0$, the equation is *parabolic* (e.g., heat equation, diffusion equation).
- If $Delta < 0$, the equation is *elliptic* (e.g., Laplace's equation, Poisson's equation).

=== Solving for Hyperbolic equations ($B^2 - 4 A C > 0$)
We have access to 2 methods of solving them, one will be harder than the other, but will give a more general solution.

==== Hyperbolic equations - Method 1 : 2D characteristic method
Let's start from the general linear second-order PDE:
$ A (partial^2 Phi)/(partial x^2) + B (partial^2 Phi)/(partial x partial y) + C (partial^2 Phi)/(partial y^2) = R(x, y) $
Where $A$, $B$, and $C$ are constants, and $R$ is a function of $x$ and $y$.
The classification depends on the discriminant $Delta = B^2 - 4 A C$:
- $Delta > 0$: *Hyperbolic* (e.g. Wave equation). Two real characteristic families.
- $Delta = 0$: *Parabolic* (e.g. Heat equation). One real characteristic family.
- $Delta < 0$: *Elliptic* (e.g. Laplace equation). No real characteristics.

#note_block(block_colors.warning)[
  *Important*: Do not confuse the coefficients $A, B, C$ of the PDE with the coefficients of the specific quadratic form of a conic section geometry, although they are related by nature (Hyperbola vs Hyperbolic PDE). The classification relies strictly on $B^2 - 4 A C$ from the coefficients of the second derivatives.
]

For the hyperbolic case ($Delta > 0$), we can factorize the operator to find the characteristic curves. The PDE can be written in operator form:
$ A (partial_x - r_1 partial_y) (partial_x - r_2 partial_y) Phi = R $
where $r_1$ and $r_2$ are the roots of the characteristic polynomial (assuming $A != 0$):
$ A r^2 + B r + C = 0 \ r_"1,2" = (-B plus.minus sqrt(B^2 - 4 A C))/(2A) $
If $A=0$, we can swap the roles of $x$ and $y$, or work directly with the characteristic quadratic.

The characteristic curves correspond to the directions along which the PDE reduces to an ODE. For the operators $(partial_x - r partial_y)$, the characteristic lines satisfy:
$ (dif y)/(dif x) = -r "  "-->"  " cases(
  y + r_1 x = c_1,
  y + r_2 x = c_2
) $
#note_block(block_colors.note)[
  *Note*: There is a sign convention difference in some texts. Here, we define $r$ as the roots of $A r^2 + B r + C = 0$, which leads to characteristic lines with slope $-r$.
]

#figure(
  image("EDP_diagrams/2D_charact.png", width: 50%),
  caption: "Characteristic curves for a hyperbolic PDE in 2D",
)<fig:2D_charact>
#block()

From here, we can solve to find both of the characteristic solutions on each curve $Gamma(x(s), y(s))$#footnote([Parametric curve along which initial conditions and boundary conditions are applied to solve the PDE]) from the homogenous part as pictured on @fig:2D_charact.

From here, we can do a variable change with the characteristic slopes:
$ cases(xi = y + r_1 x, eta = y + r_2 x) --> cases(x = (xi - eta)/(r_1 - r_2), y = (-r_2 xi + r_1 eta)/(r_1 - r_2)) $
These variables satisfy :
$ cases(
  ((partial)/(partial x) - r_1 partial/(partial y)) xi = 0,
  ((partial)/(partial x) - r_2 partial/(partial y)) eta = 0
) $
Choose $xi$ and $eta$ so that each one is constant along one characteristic family.

#added[
#note_block(block_colors.note)[
  A useful way to understand this change of variables is to define the *directional operator*
  $ D_r := partial_x - r partial_y $
  Its integral curves satisfy $dif y/dif x=-r$, so $D_r$ differentiates *along* that characteristic direction. We are therefore searching for coordinates such that
  $ D_(r_1) xi=0 "   and   " D_(r_2) eta=0 $
  Hence $xi$ is constant while moving along the first characteristic family, and $eta$ is constant while moving along the second one. In other words, $xi$ and $eta$ are simply *labels for the two families of characteristics*. This is why they are the natural coordinates for the hyperbolic PDE.
]
]
#block()

For any smooth function $U(xi, eta)=Phi(x,y)$, the chain rule gives :
$ vec(delim: "[",
  (partial Phi)/(partial x),
  (partial Phi)/(partial y)
) = underbrace(mat(delim: "[",
  r_1, r_2;
  1, 1
), J) vec(delim: "[",
  (partial U)/(partial xi),
  (partial U)/(partial eta)
) $
The determinant is :
$ det J = r_1-r_2 != 0 "   " ("Hyperbolic") $
So :
$ (partial U)/(partial xi) = ((partial Phi)/(partial x) - r_2 (partial Phi)/(partial y))/(r_1-r_2) $
$ (partial U)/(partial eta) = (-(partial Phi)/(partial x) + r_1 (partial Phi)/(partial y))/(r_1-r_2) $

Equivalently, the differential operators become :
$ cases(
  (r_1-r_2) partial/(partial xi) = partial/(partial x) - r_2 partial/(partial y),
  (r_1-r_2) partial/(partial eta) = -partial/(partial x) + r_1 partial/(partial y)
) $

If we take once again the factorised form of the PDE :
$ A((partial)/(partial x) - r_1 partial/(partial y))((partial)/(partial x) - r_2 partial/(partial y)) Phi = R(x,y) $
we obtain :
$ -A(r_1-r_2)^2 (partial^2 U)/(partial xi partial eta) = R((xi-eta)/(r_1-r_2), (-r_2 xi+r_1 eta)/(r_1-r_2)) $
Thus :
$ (partial^2 U)/(partial xi partial eta) = -1/(A(r_1-r_2)^2) R((xi-eta)/(r_1-r_2), (-r_2 xi+r_1 eta)/(r_1-r_2)) $

Now, we just have to integrate once in each variable. A general solution can be written as :
$ U(xi,eta) = -1/(A(r_1-r_2)^2) integral^xi integral^eta R((s-t)/(r_1-r_2), (-r_2 s+r_1 t)/(r_1-r_2)) dif t dif s + F(xi) + G(eta) $
where the arbitrary one-variable functions $F$ and $G$ come from the two integrations.

Homogeneous solution (when $R=0$):
$ U_h(xi,eta) &= F(xi)+G(eta)\
Phi_h(x,y) &= F(y+r_1x)+G(y+r_2x) $

#note_block(block_colors.note)[
  If you have not understood this development, maybe you will understand the one used in Example 1. This part is one of the hardest, so don't hesitate to seek more info on it, and do old exams.
]

===== Solution along characteristics
#added[
There is another way to see the 2D characteristic method, directly from the Cauchy problem. Define :
$ u=(partial Phi)/(partial x), "   " v=(partial Phi)/(partial y) $
so that $partial u/partial y = partial v/partial x$. Along a small displacement $(dif x,dif y)$ :
$ dif u = (partial u)/(partial x) dif x + (partial u)/(partial y) dif y $
$ dif v = (partial v)/(partial x) dif x + (partial v)/(partial y) dif y $
Together with
$ A (partial u)/(partial x) + B (partial u)/(partial y) + C (partial v)/(partial y)=R $
this gives a linear system for the three second derivatives.

The system becomes singular in the characteristic directions. The characteristic equation is :
$ A (dif y)^2 - B dif x dif y + C (dif x)^2 = 0 $
or equivalently (when $dif x != 0$) :
$ A ((dif y)/(dif x))^2-B(dif y)/(dif x)+C=0 $
For a hyperbolic PDE, there are two distinct real directions $(dif x_1,dif y_1)$ and $(dif x_2,dif y_2)$.

Along either characteristic family, solvability of the singular system gives the compatibility relation :
$ A dif u dif y + C dif v dif x = R dif x dif y $
There is one such ODE along each characteristic. Starting from two known points on the Cauchy curve, the two characteristic relations can be integrated until the characteristics meet. Once $u=Phi_x$ and $v=Phi_y$ are known there, recover $Phi$ using :
$ dif Phi = u dif x + v dif y $

#note_block(block_colors.note)[
  This is the general form used in the syllabus. For constant-coefficient problems, the characteristic-coordinate method $(xi,eta)$ developed just above is usually algebraically faster. The two viewpoints are equivalent.
]
]

===== Example 1 : 1D Wave equation (Compact Solution) (APE 3)
Starting from the 1D wave equation, we take a small step ($dif x, dif t$) :
$ (partial^2 Phi)/(partial t^2) - c^2 (partial^2 Phi)/(partial x^2) = 0 $

#added[
#note_block(block_colors.note)[
  *Why is $A=-c^2$ here?* It only comes from the order chosen for the generic PDE. In this section we write the principal part as
  $ A (partial^2 Phi)/(partial x^2) + B (partial^2 Phi)/(partial x partial t) + C (partial^2 Phi)/(partial t^2)=0 $
  Therefore, for
  $ (partial^2 Phi)/(partial t^2)-c^2 (partial^2 Phi)/(partial x^2)=0 $
  we have $A=-c^2$, $B=0$, $C=1$.

  The syllabus often writes the same wave equation multiplied by $-1$,
  $ c^2 (partial^2 Phi)/(partial x^2)-(partial^2 Phi)/(partial t^2)=0 $
  which gives $A=c^2$, $B=0$, $C=-1$. Both forms are equivalent: multiplying the whole PDE by a non-zero constant does not change its solutions, its discriminant sign, or the characteristic directions $dif x/dif t=plus.minus c$.
]
]
$ cases(
  A (partial^2 Phi)/(partial x^2) + B (partial^2 Phi)/(partial x partial t) + C (partial^2 Phi)/(partial t^2) = 0,
  d((partial Phi)/(partial x)) = (partial^2 Phi)/(partial x^2) dif x + (partial^2 Phi)/(partial x partial t) dif t,
  d((partial Phi)/(partial t)) = (partial^2 Phi)/(partial t partial x) dif x + (partial^2 Phi)/(partial t^2) dif t
) --> mat(delim: "(",
  A, B, C;
  dif x, dif t, 0;
  0, dif x, dif t
) vec(
  (partial^2 Phi)/(partial x^2),
  (partial^2 Phi)/(partial x partial t),
  (partial^2 Phi)/(partial t^2)
) = vec(
  0,
  d((partial Phi)/(partial x)),
  d((partial Phi)/(partial t))
) $\

But along characteristic directions, the Cauchy problem degenerates: the second derivatives are not uniquely determined, and the matrix loses its rank. Linear-algebraically, that means the coefficient matrix is singular. Hence we require its determinant to vanish:
$ det mat(delim: "|",
  A, B, C;
  dif x, dif t, 0;
  0, dif x, dif t
) = 0 --> A dif t^2 - B dif t dif x + C dif x^2 = 0 $\

Applying it to the 1D wave equation:
$ cases(A = -c^2, B = 0, C = 1) --> c^2 dif t ^2 = dif x^2 --> cases(
  dif x = - &c dif t " (slope = -c) ",
  dif x =   &c dif t " (slope =  c)") $\

Let's use a Riemann combination to solve this PDE :
$ u := (partial Phi)/(partial x) &"   and   " v := 1/c (partial Phi)/(partial t)\
 R := v + u &"   and   " S := v-u\
 (partial Phi)/(partial x) = u = (R-S)/2 &"   and   " 1/c (partial Phi)/(partial t) = v = (R+S)/2 $\

We can now substitute (or differentiate) this Riemann combination back into the original equation with R and S to get :
$ cases(
  1/c (partial R)/(partial t) - (partial R)/(partial x) = 0 &--> "Transport with left moving characteristic -c",
  1/c (partial S)/(partial t) + (partial S)/(partial x) = 0 &--> "Transport with right moving characteristic c"
  ) $\
We can now follow the *Riemann invariants* along their characteristics :
$ cases(
  c dif t + dif x = 0,
  c dif t - dif x = 0
) -->
cases(
  x + c t = "cst",
  x - c t = "cst"
) -->
cases(
  R(x, t) = R_0(x+c t),
  S(x, t) = S_0(x-c t)
) $
Where $R_0$ and $S_0$ are the initial conditions of R and S at t=0.\
#block()

From here, we can propagate and integrate u or v to find Phi(x, t) :
$ cases(u = 1/2 (R_0(x+c t) - S_0(x-c t)), v = 1/2 (R_0(x+c t) + S_0(x-c t)))
--> cases(
  u = &(partial Phi)/(partial x) = &f'(x - c t) + g'(x + c t),
  v = 1/c &(partial Phi)/(partial t) = -&f'(x - c t) + g'(x + c t)
) $
#math.equation(block:true, block(stroke:0.1em, inset: 0.7em,
 $"d'Alembert's Solution :" Phi(x, t) = f(x - c t) + g(x + c t)$))\

For arbitrary functions f and g on the whole line, determined by the initial conditions. On a bounded interval, the boundary conditions impose additional constraints and may lead to odd/even or periodic extensions :\
$"Given : " Phi(x, 0) = Phi_0(x) " and " (partial Phi)/(partial t)(x, 0) = Psi_0(x)$
$ Phi(x, t) = 1/2 (Phi_0(x - c t) + Phi_0(x + c t)) + 1/(2c) integral_(x - c t)^(x + c t) Psi_0(s) dif s $

===== Example 1 bis : 1D wave equation (APE 3 corrective)
Starting from the 1D wave equation in canonical form:
$ (partial^2 Phi)/(partial t^2) - c^2 (partial^2 Phi)/(partial x^2) = 0 $
The 2 characteristic directions $(dif x, dif t)$ are obtained as real roots of the equation :
$ A dif t ^2 - B dif t dif x + C dif x^2 = 0 --> A ((dif t)/(dif x))^2 - B ((dif t)/(dif x)) + C = 0 $
This gives 2 nets of characteristic curves. With the wave equation being :
$ cases(A=-c^2, B=0, C=1) --> dif x = plus.minus c dif t $
Since $c$ is constant here, the characteristic curves are straight lines with slopes of plus.minus $c$ in the $(x,t)$ plane.

We can now pose :
$ u=(partial Phi)/(partial x) "   and   " v=1/c (partial Phi)/(partial t) $
The wave equation is equivalent to the two transport equations :
$ cases(
  1/c (partial (v+u))/(partial t) - (partial (v+u))/(partial x) = 0,
  1/c (partial (v-u))/(partial t) + (partial (v-u))/(partial x) = 0
) $
Therefore :
$ cases(
  dif(v+u)=0 " along " dif x=-c dif t,
  dif(v-u)=0 " along " dif x=c dif t
) $
and the Riemann invariants are :
$ cases(
  v+u = F(x+c t),
  v-u = G(x-c t)
) $

The Cauchy problem is well posed when the initial curve $Gamma$ is not tangent to either characteristic family. We can now isolate $u$ and $v$ :
$ cases(
  u=1/2(F(x+c t)-G(x-c t)),
  v=1/2(F(x+c t)+G(x-c t))
) $
and integrate back to $Phi$ :
$ cases(
  u=(partial Phi)/(partial x)=f'(x-c t)+g'(x+c t),
  v=1/c (partial Phi)/(partial t)=-f'(x-c t)+g'(x+c t)
) $
#math.equation(block:true, block(stroke:0.1em, inset: 0.7em,
 $"d'Alembert's Solution :" Phi(x,t)=f(x-c t)+g(x+c t)$))
Where $f$ and $g$ are arbitrary functions determined by the initial conditions.

#note_block(block_colors.note)[
  The $2L$ periodicity and odd antisymmetry construction is *not part of the general d'Alembert solution*. It appears for a bounded interval with fixed Dirichlet boundaries when the initial data are extended as an odd $2L$-periodic function. Other boundary conditions lead to different extensions.
]

#text(red)[
We consider here the general case $(partial phi)/(partial t) (s, 0) = g(s)$ and $phi(s, 0) = f(s)$.
We thus calculate $(partial phi)/(partial t)$ :

$ (partial phi)/(partial t) = (partial phi)/(partial xi) (partial xi)/(partial t) + (partial phi)/(partial eta) (partial eta)/(partial t) = c (- f_1'(xi) + f_2'(eta)) $

At $t = 0$, we know that $phi(x, 0) = f(x)$ and $(partial phi)/(partial t) (x, 0) = g(x)$ (since $s = x plus.minus c t$).
We thus obtain a system of 2 equations for $f_1$ and $f_2$ :

$ f_1(x) + f_2(x) = f(x) -> f_1'(x) + f_2'(x) = f'(x) $
$ - f_1'(x) + f_2'(x) = g(x)/c $

We isolate $f_1'(x)$ and $f_2'(x)$ by summing or subtracting these 2 equations :

$ f_1'(x) = 1/2 ( f'(x) - g(x)/c ) $
$ f_2'(x) = 1/2 ( f'(x) + g(x)/c ) $

We find $f_1$ and $f_2$ by integrating these relations from an arbitrary point $x = a$ to $x$ :

$ integral_a^x f_1'(x') dif x' = 1/2 ( integral_a^x f'(x') dif x' - integral_a^x g(x')/c dif x' ) $
$ f_1(x) - f_1(a) = 1/2 ( f(x) - f(a) - integral_a^x g(x')/c dif x' ) $

Similarly we find for $f_2$ :

$ integral_a^x f_2'(x') dif x' = 1/2 ( integral_a^x f'(x') dif x' + integral_a^x g(x')/c dif x' ) $
$ f_2(x) - f_2(a) = 1/2 ( f(x) - f(a) + integral_a^x g(x')/c dif x' ) $

Finally the general solution is written as :

$ phi(xi, eta) = f_1(xi) + f_2(eta) $
$ phi(x, t) = f_1(x - c t) + f_2(x + c t) $
$ = 1/2 ( f(x - c t) + f(x + c t) ) - 1/(2c) integral_a^(x - c t) g(x') dif x' + 1/(2c) integral_a^(x + c t) g(x') dif x' $
$ = 1/2 ( f(x - c t) + f(x + c t) ) + 1/(2c) integral_(x - c t)^(x + c t) g(x') dif x' $

The constants cancel out since $f(a) = f_1(a) + f_2(a)$.
]
===== Example 2 : 1D wave equation with c(x)
#added[
The syllabus considers the variable-speed wave equation in the special conservative form :
$ partial/(partial x) (c(x) partial/(partial x)(c(x) Phi)) - (partial^2 Phi)/(partial t^2)=0 $
It can be factorised in two first-order steps :
$ partial/(partial x)(c Phi)+(partial Phi)/(partial t)=psi $
$ partial/(partial x)(c psi)-(partial psi)/(partial t)=0 $

A very useful formulation is obtained by defining :
$ u=partial/(partial x)(c Phi), "   " v=(partial Phi)/(partial t) $
Then :
$ cases( partial/(partial x)(c u)-(partial v)/(partial t)=0,
         partial/(partial x)(c v)-(partial u)/(partial t)=0 ) $
Multiplying by $c(x)$ and defining $p=c u$ and $q=c v$ gives the simpler system :
$ cases( c (partial p)/(partial x)-(partial q)/(partial t)=0,
         c (partial q)/(partial x)-(partial p)/(partial t)=0 ) $
which can be written :
$ (partial)/(partial t) vec(p,q)+mat(0,-c; -c,0) (partial)/(partial x) vec(p,q)=0 $
The eigenvalues of the matrix are $+c(x)$ and $-c(x)$, so the two characteristic families satisfy :
$ (dif x)/(dif t)=plus.minus c(x) $
They are no longer necessarily straight lines. Along them, the Riemann combinations are conserved :
$ p-q = "constant along" " " (dif x)/(dif t)=c(x) $
$ p+q = "constant along" " " (dif x)/(dif t)=-c(x) $

#note_block(block_colors.trick)[
  Compared with the constant-$c$ wave equation, the idea is the same: diagonalise into two waves travelling in opposite characteristic directions. The main difference is that the characteristic curves now bend according to $dif x/dif t=plus.minus c(x)$.
]
]

==== Variable Separation (general method)
===== Base technique in Cartesian coordinates
#note_block(block_colors.note)[
  Variable separation is not specific to hyperbolic PDEs. The first example below is a *Laplace-type elliptic equation*. It is kept here because the exam technique (separation constant, eigenfunctions and orthogonality) is reused for several PDE types.
]
Starting from the homogeneous 2nd order PDE (Laplace), with $B=0$ and here $A>0$, $C>0$, we will use a different basis of resolution :
$ L(Phi) = A (partial^2 Phi)/(partial x^2) + C (partial^2 Phi)/(partial y^2) = 0 "   " ("Laplace when" A=C=1) $
#grid(columns: (1fr, 5fr), align: left, [],[$
  stretch(arrow.b, size:#300%)
  Phi(x, y) = X(x) Y(y)
$])
$ A (partial^2 X(x))/(partial x^2)Y(y) + C X(x)(partial^2 Y(y))/(partial y^2) = 0 $
$ A X''(x)Y(y) + C X(x)Y''(y) = 0 $
$ A (X''(x))/X(x) + C (Y''(y))/Y(y) = 0 $
$ A (X''(x))/X(x) = - C (Y''(y))/Y(y) = lambda = plus.minus k^2 $
#note_block(block_colors.note)[
  The separation constant $lambda$ can be positive, negative or zero. We write the non-zero cases as $lambda=plus.minus k^2$ with $k>0$, depending on the boundary conditions and the nature of the problem. The choice of sign will affect the form of the solutions for $X(x)$ and $Y(y)$. We will often choose the sign that gives us the next steps more easily (meaning we obtain trigonometric functions which allow us to use orthogonality). It is chosen by looking at which of the boundary conditions are homogeneous (0) or not.
  $ Z''(z) &= k^2 Z(z) --> Z(z) = C_1 e^(k z) + C_2 e^(-k z) stretch(=)^"Equivalent" D_1 cosh(k z) + D_2 sinh(k z)\
  Z''(z) &= -k^2 Z(z) --> Z(z) = C_1 e^(i k z) + C_2 e^(-i k z) stretch(=)^"Equivalent" D_1 cos(k z) + D_2 sin(k z) $
  We will generally use the trigonometric form, as it is easier to apply boundary conditions on it.
  And we will choose the sign of $k^2$ to have the trigonometric form for the variable with the pair of homogeneous boundary conditions. (so that when we apply the LC's, we can easily find the admissible values of k).\
  The values of $k$ become discrete only after the boundary conditions create an eigenvalue problem. We will then denote them as $k_n$.
]
#note_block(block_colors.trick)[
  Do not automatically discard the case $lambda=0$. It gives linear/constant solutions and can be non-trivial depending on the boundary conditions. In some standard rectangle problems with homogeneous Dirichlet conditions, this mode happens to vanish.
]
#grid(
  columns: (1fr, 1fr),
  align: center,
  stroke: (x, y) => if y == 0 {(bottom: 0.7pt)} else { if x!=0 {(left: 0.7pt)} else { none }},
  inset: 1em,
  [$lambda=k^2$], [$lambda=-k^2$],
  [$X''(x) = (k^2)/A X(x)$], [$X''(x) = -(k^2)/A X(x)$],
  [$X(x) = C_1 cosh(sqrt(k^2/A) x) + C_2 sinh(sqrt(k^2/A) x)$], [$X(x) = C_1 cos(sqrt(k^2/A) x) + C_2 sin(sqrt(k^2/A) x)$],
  [#text(blue)[Apply 1 boundary condition on X\ (remove $C_1$ or $C_2$)]], [Apply 2 boundary conditions on X\ (remove $C_1$ or $C_2$ and get $k_n$)],
  [$Y''(y) = -(k^2)/C Y(y)$], [$Y''(y) = (k^2)/C Y(y)$],
  [$Y(y) = D_1 cos(sqrt(k^2/C) y) + D_2 sin(sqrt(k^2/C) y)$], [$Y(y) = D_1 cosh(sqrt(k^2/C) y) + D_2 sinh(sqrt(k^2/C) y)$],
  [Apply 2 boundary conditions on Y\ (remove $D_1$ or $D_2$ and get $k_n$)], [#text(blue)[Apply 1 boundary condition on Y\ (remove $D_1$ or $D_2$)]],
  [$Phi(x, y) = sum_(n)^infinity X_n (x) Y_n (y)$], [$Phi(x, y) = sum_(n)^infinity X_n (x) Y_n (y)$],
  [(We will use an example from now on)], [(We will use an example from now on)],
  [#text(size:10pt)[$Phi(x, y) = sum_(n)^infinity underbrace(C_n D_n, tilde(C_n)) sinh(sqrt(k_n^2/A) x) sin(sqrt(k_n^2/C) y)$]], [#text(size:10pt)[$Phi(x, y) = sum_(n)^infinity underbrace(C_n D_n, tilde(C_n)) sin(sqrt(k_n^2/A) x) sinh(sqrt(k_n^2/C) y)$]],
)

#note_block(block_colors.note)[
  In the standard rectangle examples shown here, the homogeneous Dirichlet pair produces the sine eigenfunctions. The admissible values are $sqrt(k_n^2/C)=n pi/H$ when the sine variable is $y$, or $sqrt(k_n^2/A)=n pi/L$ when the sine variable is $x$. This is why the corresponding sine modes have norm $H/2$ or $L/2$.
  For a generic eigenfunction $Z_n$ :
  $ <Z_m,Z_n> = integral Z_m(s) Z_n(s) dif s = 0 " if " m != n $
]

*Case 1 - non-homogeneous boundary condition at $x=L$:*
$ Phi(L,y) = sum_n^infinity underbrace(tilde(C_n)sinh(sqrt(k_n^2/A)L), E_n) sin(sqrt(k_n^2/C)y) $

By orthogonality:
$ underbrace(integral_0^H E_n (sin(sqrt(k_n^2/C)s))^2 dif s, E_n H/2)
  = integral_0^H f(s) sin(sqrt(k_n^2/C)s) dif s $
and therefore:
$ E_n = 2/H integral_0^H f(s) sin(sqrt(k_n^2/C)s) dif s $
$ tilde(C_n) =
  (2/H integral_0^H f(s) sin(sqrt(k_n^2/C)s) dif s)
  /sinh(sqrt(k_n^2/A)L) $

We can now get the full solution:
$ Phi(x,y) = sum_n^infinity
  (2/H integral_0^H f(s) sin(sqrt(k_n^2/C)s) dif s)
  /sinh(sqrt(k_n^2/A)L)
  sinh(sqrt(k_n^2/A)x) sin(sqrt(k_n^2/C)y) $

*Case 2 - non-homogeneous boundary condition at $y=H$:*
$ Phi(x,H) = sum_n^infinity underbrace(tilde(C_n)sinh(sqrt(k_n^2/C)H), F_n) sin(sqrt(k_n^2/A)x) $

By orthogonality:
$ underbrace(integral_0^L F_n (sin(sqrt(k_n^2/A)s))^2 dif s, F_n L/2)
  = integral_0^L g(s) sin(sqrt(k_n^2/A)s) dif s $
and therefore:
$ F_n = 2/L integral_0^L g(s) sin(sqrt(k_n^2/A)s) dif s $
$ tilde(C_n) =
  (2/L integral_0^L g(s) sin(sqrt(k_n^2/A)s) dif s)
  /sinh(sqrt(k_n^2/C)H) $

We can now get the full solution:
$ Phi(x,y) = sum_n^infinity
  (2/L integral_0^L g(s) sin(sqrt(k_n^2/A)s) dif s)
  /sinh(sqrt(k_n^2/C)H)
  sin(sqrt(k_n^2/A)x) sinh(sqrt(k_n^2/C)y) $

#note_block(block_colors.warning)[
  At the exam, you have to ABSOLUTELY write the full solution without any integrals! All exams have integral helping hints, and they are a key to know if you are going in the right direction. Also, check your units. If you have non-dimensionalised the problem, every argument of a sine, cosine, exponential or hyperbolic function must be dimensionless!
]

#added[
===== Eigenfunctions, self-adjoint operators and orthogonality
The separation method works because the homogeneous boundary conditions create an *eigenvalue problem*. In the simplest case :
$ L(X_n)+k_n^2 X_n=0 $
with homogeneous Dirichlet, Neumann or Robin conditions.

If the differential operator together with its homogeneous boundary conditions is *self-adjoint*, then the main practical consequences are :
- the eigenvalues $k_n^2$ are real;
- eigenfunctions associated with distinct eigenvalues are orthogonal;
- the eigenfunctions form the basis used to expand the non-homogeneous boundary/initial data.

For the standard operator $L=d^2/(dif x^2)$ on $[0,L]$ :
#table(
  columns: (1.2fr, 0.8fr, 1fr, 1.5fr),
  stroke: 0.5pt + gray,
  inset: 5pt,
  [*Homogeneous BCs*], [*$k_n$*], [*$X_n(x)$*], [*Expansion coefficient*],
  [$X(0)=X(L)=0$], [$n pi/L$, $n>=1$], [$sin(n pi x/L)$], [$A_n=2/L integral_0^L f(x)sin(n pi x/L) dif x$],
  [$X'(0)=X'(L)=0$], [$n pi/L$, $n>=0$], [$cos(n pi x/L)$], [$A_0=1/L integral_0^L f(x)dif x$; $A_n=2/L integral_0^L f(x)cos(n pi x/L) dif x$],
  [Periodic on $[-L,L]$], [$n pi/L$], [$cos(n pi x/L)$ and $sin(n pi x/L)$], [standard Fourier sine/cosine coefficients],
)

#note_block(block_colors.note)[
  Robin conditions are also homogeneous eigenvalue conditions, but the admissible $k_n$ are usually roots of a transcendental equation rather than simple multiples of $pi/L$. Example from the syllabus: $Y'(0)=0$ and $-kappa Y'(H)=h Y(H)$ give $k=(h/kappa)cot(k H)$. Once the roots $k_n$ are found, the eigenfunctions are still orthogonal because the problem is self-adjoint.
]
]

===== Multiple non-homogeneous conditions (superposition principle)
For a *linear PDE*, in the case that there are multiple non-homogeneous boundary conditions, you can use the superposition principle to add the solutions of each non-homogeneous boundary condition.
$ Phi_"tot" = Phi_1 + Phi_2 + ... $

// Add graphical example

===== Polar coordinates
We can also use the variable separation method in polar coordinates, with the Laplacian in polar coordinates :
$ nabla^2 u = 0 = (partial^2 u)/(partial r^2) + (1/r)(partial u)/(partial r) + (1/r^2)(partial^2 u)/(partial theta^2) $
$ nabla^2 (R(r)Theta(theta)) = 0 = (r^2 R''+r R')/R + Theta''/Theta = 0 $
$ Theta''/Theta = - (r^2 R''+r R')/R = lambda = cases(-k^2, +k^2, 0 -> "zero mode") $

Let us follow the different cases :
#grid(
  columns: (1fr, 1fr, 1fr),
  align: center,
  stroke: (x, y) => if y == 0 {(bottom: 0.7pt)} else { if x!=0 {(left: 0.7pt)} else { none }},
  inset: 0.8em,
  [$lambda=-k^2$], [$lambda=k^2$], [$lambda=0$],
  [$Theta''(theta) = -k^2 Theta(theta)$], [$Theta''(theta) = k^2 Theta(theta)$], [$Theta''(theta) = 0$],
  [$Theta(theta) = A cos(k theta) + B sin(k theta)$], [$Theta(theta) = A cosh(k theta) + B sinh(k theta)$], [$Theta_0 (theta) = A_0 + B_0 theta$],
  [#text(color.luma(150))[Apply boundary conditions]], [#text(color.luma(150))[Apply boundary conditions]], [#text(color.luma(150))[Apply boundary conditions (periodicity)]],
  [$r^2 R'' + r R' - k^2 R = 0$], [$r^2 R'' + r R' + k^2 R = 0$], [$r R'' + R' = 0$],
  [#text(size:9.5pt)[$R_n (r) = C_n (r/a)^k_n + D_n (r/a)^(-k_n)$]], [#text(size:9.5pt)[$R_n (r) &= C_n (r/a)^(i k_n) + D_n (r/a)^(-i k_n)\ R_n (r) &= C_n cos(k_n ln(r/a))\ &+ D_n sin(k_n ln(r/a)) $]], [$R(r) = C + D ln(r)$],
  [#text(color.luma(150))[Apply boundary conditions\ (regularity constraint)]], [#text(color.luma(150))[Apply domain/boundary constraints]], [#text(color.luma(150))[Apply boundary conditions\ (regularity constraint)]],
  [#text(size: 10pt)[$u(r, theta) = sum_n^infinity (R_n (r) Theta_n (theta))$]],  [#text(size: 10pt)[$u(r, theta) = sum_n^infinity (R_n (r) Theta_n (theta))$]], [#text(size: 10pt)[$u(r, theta) = R_0 (r) Theta_0 (theta)$]],
  [#text(size: 6.5pt)[$u(r,theta)=sum_n^infinity (C_n(r/a)^k_n+D_n(r/a)^(-k_n))(A_n cos(k_n theta)+B_n sin(k_n theta))$]],
  [#text(size: 6.5pt)[$u(r,theta)=sum_n^infinity (E_n cos(k_n ln(r/a))+F_n sin(k_n ln(r/a)))(A_n cosh(k_n theta)+B_n sinh(k_n theta))$]],
  [#text(size: 8pt)[$u(r, theta) = (C + D ln(r))(A_0 + B_0 theta)$]],
  [#text(color.orange)[Now follow the same steps as in cartesian coordinates] ], [#text(color.orange)[Now follow the same steps as in cartesian coordinates] ], [#text(color.orange)[Now follow the same steps as in cartesian coordinates] ],
)
#block()
#note_block(block_colors.note)[
  On a full circular domain, periodicity in $theta$ forces the usual angular eigenvalues $lambda=-n^2$ (plus the zero mode). The case $lambda=+k^2$ gives hyperbolic functions in $theta$ and cannot satisfy full $2pi$ periodicity except for the trivial solution. It can still appear on wedges or other non-periodic angular domains. Its radial solutions oscillate as functions of $ln(r)$, so they are not regular at $r=0$ and are mainly useful when the origin is excluded (for example, an annulus).
]

#block()
#text(size:14pt)[*Special Case 1 - Not enough homogenous boundary conditions :*]
#block()

We now have the overall appearance of all solutions. Now, let us go into the details about the boundary conditions and the regularity conditions.
#figure(
  image("EDP_diagrams/EDP_polar_u_regulier.svg", width: 80%),
  caption: "Polar representation of a half disk with regularity condition at r=0",
)<fig:polar_regularity>#block()

Since in @fig:polar_regularity, *we don't have 2 homogeneous boundary conditions*, we will have to separate the problem into two parts, and use the superposition principle to add the two solutions.

We will be considering a homogenous solution with $lambda = 0$ (first part), and a non-homogeneous solution with $lambda = -k^2$ (second part) as we can see in @fig:power_separation.

#figure(
  image("EDP_diagrams/EDP_polar_power_separation.svg", width: 80%),
  caption: "Polar representation of a half disk with power separation",
)<fig:power_separation>#block()

$ u(r, theta) = underbrace(u_0 (r, theta), "Sol" lambda=0) + underbrace(u_g (r, theta), "Sol" lambda=-k^2) $
$ u_g (r, theta) = u (r, theta) - u_0 (r, theta) $

#grid(
  columns: (1fr, 1fr),
  align: center,
  stroke: (x, y) => if y == 0 {(bottom: 0.7pt)} else { if x!=0 {(left: 0.7pt)} else { none }},
  inset: 1em,
  [$lambda=0$], [$lambda=-k^2$],
  [$Theta''=0$], [$Theta''=-k^2 Theta$],
  [$Theta_0 (theta) = A_0 + B_0 theta$], [$Theta_n (theta) = A_n cos(k_n theta) + B_n sin(k_n theta)$],
  [$"Cond": cases(Theta_0 (0) = 0 --> A_0 = 0, (partial Theta_0)/(partial theta) (pi) = U_0/pi " (Not yet, non homogeneous)")$], [$"Cond": cases(Theta_n (0) = 0 --> A_n = 0, (partial Theta_n)/(partial theta) (pi) = 0 --> k_n = (2n +1) 1/2)$],
  [$Theta_0 (theta) = B_0 theta$], [$Theta_n (theta) = B_n sin(k_n theta)$],
  [$r R_0'' + R_0' = 0$], [$r^2 R_n'' + r R_n' - k_n^2 R_n = 0$],
  [$R_0 (r)=C_0 ln(r/a) + D_0$], [$R_n (r)=C_n (r/a)^(k_n) + D_n (r/a)^(-k_n)$],
  [$"Cond": cases("u regular in r=0" --> C_0 = 0 " (Boundedness)", u_0 (a, theta)=U_0 theta/pi " (Not yet, non homogeneous)")$],[$"Cond": cases("u regular in r=0" --> D_n = 0 " (Boundedness)", u_g(a,theta)=g(theta)-U_0 theta/pi " (Not yet, non homogeneous)")$],
  [$R_0 (r) = D_0$], [$R_n (r) = C_n (r/a)^(k_n)$],
  [$u_0 (r, theta) = tilde(B_0) theta$], [$u_g (r, theta) = sum_n^infinity tilde(C_n) (r/a)^(k_n) sin(k_n theta)$],
  [$"Cond": cases((partial u_0)/(partial theta) (r, pi) = U_0/pi = tilde(B_0))$], [],
  [$u_0 (r, theta) = (U_0/pi) theta$],
  [],
)
$ u(r, theta) = u_0 (r, theta) + u_g (r, theta) = U_0 theta/pi + sum_n^infinity tilde(C_n) (r/a)^(k_n) sin(k_n theta) $
Now, we can apply the non-homogeneous boundary condition to find $tilde(C_n)$ :
$ u_g(a, theta) = g(theta) - U_0 theta/pi = sum_n^infinity tilde(C_n) sin(k_n theta) $
From the orthogonality of the sine functions, we can write :
$ underbrace(integral_0^pi tilde(C_m) sin^2 (k_m theta) dif theta, tilde(C_m) pi/2) = integral_0^pi (g(theta) - U_0 theta/pi) sin(k_m theta) dif theta $
$ tilde(C_m) = 2/pi integral_0^pi (g(theta) - U_0 theta/pi) sin(k_m theta) dif theta $
$ u(r, theta) = U_0 theta/pi + sum_m^infinity tilde(C_m) (r/a)^(k_m) sin(k_m theta) $

#note_block(block_colors.trick)[
  The teacher will tell you during the exam if you have to go through mode 0 ($lambda=0$) or not.
]

#block()
#text(size:14pt)[*Special Case 2 - non-homogeneous condition on theta instead of r ($g(r)$) :*]#block()

For a non-periodic angular domain (for example a wedge or annular sector), the branch $lambda=k^2$ can be useful for a non-homogeneous condition imposed at a fixed value of $theta$. This is not automatic: the sign of $lambda$ is still determined by the homogeneous boundary conditions of the separated problem. For this branch :
$ "Equations": cases(Theta'' = k^2 Theta, r^2 R'' + r R' + k^2 R = 0) $
With the solutions #footnote($x^(i k)=e^(i k ln(x)) --> (r/a)^(i k) = e^(i k ln(r/a))$) :
$ R_n (r) &= C_n (r/a)^(i k_n) + D_n (r/a)^(-i k_n)\ &= E_n cos(k_n ln(r/a)) + F_n sin(k_n ln(r/a))\
 Theta_n (theta) &= A_n cosh(k_n theta) + B_n sinh(k_n theta) $
#note_block(block_colors.warning)[
  These $cos(k ln r)$ / $sin(k ln r)$ radial modes do not have a limit at $r=0$. Therefore this branch cannot represent a regular solution on a disk containing the origin. It is appropriate only when the domain/boundary conditions exclude $r=0$, such as an annulus or a truncated wedge.
]


===== 2D wave equation and the double $lambda$ method
#added[
For a 2D membrane, the wave equation is :
$ (partial^2 u)/(partial t^2)=c^2((partial^2 u)/(partial x^2)+(partial^2 u)/(partial y^2)) $
The method uses *two successive separations*. First separate time from space :
$ u(x,y,t)=T(t) Phi(x,y) $
$ T''/(c^2 T)=(nabla^2 Phi)/Phi=-k^2 $
This gives :
$ T''+c^2 k^2 T=0 stretch(=>) T=A cos(c k t)+B sin(c k t) $
and the spatial *Helmholtz problem* :
$ nabla^2 Phi+k^2 Phi=0 $

For a rectangular membrane $0<x<L$, $0<y<H$ fixed on all four edges, separate again :
$ Phi(x,y)=X(x)Y(y) $
Choose the second separation constant so that the homogeneous Dirichlet conditions give trigonometric eigenfunctions :
$ X_n(x)=sin(n pi x/L), "   " Y_m(y)=sin(m pi y/H) $
with :
$ k_(n m)^2=(n pi/L)^2+(m pi/H)^2 $
The modal frequencies are therefore :
$ omega_(n m)=c sqrt((n pi/L)^2+(m pi/H)^2) $

The full solution is :
$ u(x,y,t)=sum_(n=1)^infinity sum_(m=1)^infinity sin(n pi x/L) sin(m pi y/H) (A_(n m) cos(omega_(n m)t)+B_(n m) sin(omega_(n m)t)) $
The initial displacement $u_0(x,y)=u(x,y,0)$ gives :
$ A_(n m)=4/(L H) integral_0^L integral_0^H u_0(x,y) sin(n pi x/L) sin(m pi y/H) dif y dif x $
If the initial velocity is $v_0(x,y)=(partial u)/(partial t)(x,y,0)$ :
$ B_(n m)=4/(L H omega_(n m)) integral_0^L integral_0^H v_0(x,y) sin(n pi x/L) sin(m pi y/H) dif y dif x $
In particular, if the initial velocity is zero, all $B_(n m)=0$.

#note_block(block_colors.trick)[
  This is the "double $lambda$" idea: the first eigenvalue $k^2$ separates time from the 2D spatial problem; the second separation inside Helmholtz splits $k^2$ into the two spatial contributions $(n pi/L)^2$ and $(m pi/H)^2$.
]
]

=== Solving for Parabolic equations ($B^2 - 4 A C = 0$)
#added[
The reference parabolic PDE of the syllabus is the *diffusion equation* :
$ partial/(partial x)(alpha (partial u)/(partial x))-(partial u)/(partial t)=0, "   " alpha>0 $
For constant $alpha$ :
$ (partial u)/(partial t)=alpha (partial^2 u)/(partial x^2) $
If we classify it as a second-order PDE in $(x,t)$, then $A=alpha$, $B=C=0$, so $B^2-4A C=0$. The characteristic equation gives the double direction $dif t=0$. These are degenerate pseudo-characteristics: they do *not* provide a useful characteristic method.

A parabolic problem is instead posed with :
- one *initial condition* $u(x,0)=f(x)$ because the equation is first order in time;
- one boundary condition at each spatial boundary (Dirichlet, Neumann or Robin) because it is second order in space.

*Physical origin - Heat equation :* If $rho$ is the density, $c_p$ the specific heat, $K_0$ the thermal conductivity and $Q$ a volumetric heat source, conservation of thermal energy gives :
$ rho c_p (partial u)/(partial t) = -nabla dot arrow(phi)+Q $
With Fourier's law $arrow(phi)=-K_0 nabla u$ :
$ rho c_p (partial u)/(partial t)=nabla dot (K_0 nabla u)+Q $
For constant properties :
$ (partial u)/(partial t)=alpha nabla^2u+Q/(rho c_p), "   " alpha=K_0/(rho c_p) $
The 3 classic boundary conditions are :
- *Dirichlet* : $u=u_D$;
- *Neumann* : $-K_0 nabla u dot arrow(n)=q_N$;
- *Robin* : $-K_0 nabla u dot arrow(n)=h(u-u_infinity)$.
At stationary state, $(partial u)/(partial t)=0$, so the heat equation becomes a Poisson equation; without a source it becomes Laplace's equation.

For a periodic domain or an unbounded domain with vanishing flux at infinity, diffusion conserves the total integral :
$ (dif)/(dif t) integral_a^b u dif x = [alpha u_x]_a^b = 0 $
while the quadratic quantity decreases :
$ (dif)/(dif t) integral_a^b u^2/2 dif x = - integral_a^b alpha (u_x)^2 dif x <= 0 $
This explains the smoothing effect of diffusion. High-wave-number Fourier modes decay as $e^(-alpha k_n^2 t)$, so small spatial details disappear especially fast. The reverse problem (anti-diffusion) would amplify these modes as $e^(+alpha k_n^2 t)$ and is therefore unstable / ill-posed.

#note_block(block_colors.note)[
  The detailed finite-domain separation, steady + transient split, semi-infinite error-function solution and Green convolution are developed later in the dedicated diffusion sections.
]
]

=== Solving for Elliptic equations ($B^2 - 4 A C < 0$)
#added[
For elliptic PDEs the characteristic roots are complex, so there are *no real characteristic curves*. The problem has to be solved globally on the whole domain $Omega$: every point is coupled to the boundary data.

The fundamental examples are :
$ "Laplace" : nabla^2 u=0 $
$ "Poisson" : nabla^2 u=F $
$ "Helmholtz" : nabla^2 u+k^2u=0 $
On a bounded domain, one prescribes boundary data everywhere on $partial Omega$: Dirichlet ($u$), Neumann ($(partial u)/(partial n)$), or Robin (a linear combination).

For the generalized Poisson equation
$ nabla dot (A nabla u)=F $
the divergence theorem gives the global compatibility relation :
$ integral_Omega F dif Omega = integral_(partial Omega) A (partial u)/(partial n) dif l $
This condition is especially important for a pure Neumann problem.

*Useful properties of Laplace solutions :*
- *Mean-value theorem*: the value at the centre of any disk contained in the domain equals the average of $u$ on the circle (and also the average over the disk).
- *Maximum / minimum principle*: a non-constant harmonic function reaches its maximum and minimum on the boundary, not in the interior.
- *Uniqueness*: a Laplace problem with prescribed Dirichlet data has at most one solution. The difference of two possible solutions is harmonic and zero on the boundary, so the maximum/minimum principle forces it to be zero everywhere.

#note_block(block_colors.extra)[
  In an infinite 2D domain, the Green function of $nabla^2 u=F$ is $G(r)=1/(2pi) ln(r/L)$ (the arbitrary length $L$ only changes an additive constant). In 3D, the corresponding Green function is $G(r)=-1/(4pi r)$.
]
]

=== Canonical form of a 2nd order PDE
#added[
Take the constant-coefficient equation :
$ A Phi_(x x)+B Phi_(x y)+C Phi_(y y)=R $
The goal is to make a linear change of variables that removes the mixed derivative and exposes the PDE type. Assume first $A!=0$ and define :
$ b=B/A, "   " c=C/A, "   " r=R/A $

#table(
  columns: (0.8fr, 1.2fr, 1.3fr),
  stroke: 0.5pt + gray,
  inset: 6pt,
  [*Type*], [*Canonical principal part*], [*One convenient change of variables*],
  [Hyperbolic $b^2-4c>0$], [$Phi_(X X)-Phi_(Y Y)=r$], [$X=x$, $Y=(y-(b x)/2)/sqrt(b^2/4-c)$],
  [Elliptic $b^2-4c<0$], [$Phi_(X X)+Phi_(Y Y)=r$], [$X=x$, $Y=(y-(b x)/2)/sqrt(c-b^2/4)$],
  [Parabolic $b^2-4c=0$], [$Phi_(X X)=r$], [$X=x$, $Y=y-(b x)/2$],
)

For the hyperbolic case, an equally important canonical form is obtained directly from the two characteristic coordinates :
$ Phi_(xi eta)=tilde(r) $
This is the form used earlier to obtain $Phi_h=F(xi)+G(eta)$.

Special cases :
- If $A=0$ in a hyperbolic equation, then $B!=0$. After division by $B$, an appropriate linear change gives the mixed canonical form $Phi_(X Y)=r$.
- If $A=0$ in the parabolic case, then necessarily $B=0$ and $C!=0$, so the principal part is already proportional to $Phi_(y y)$.

#note_block(block_colors.trick)[
  The discriminant tells you *which* canonical form to target. The characteristic slopes tell you the most natural coordinates in the hyperbolic case.
]
]

=== Systems of 1st order PDEs
#added[
A system for two unknowns $u(x,y)$ and $v(x,y)$ can be written :
$ cases(
  M_1 u_x+N_1 u_y+P_1 v_x+Q_1 v_y=R_1,
  M_2 u_x+N_2 u_y+P_2 v_x+Q_2 v_y=R_2
) $
Together with the variations $dif u=u_x dif x+u_y dif y$ and $dif v=v_x dif x+v_y dif y$, this gives a $4 times 4$ Cauchy system. The characteristic directions are the directions where its determinant vanishes. They satisfy :
$ A (dif y)^2-B dif x dif y+C(dif x)^2=0 $
with :
$ A=M_1P_2-M_2P_1 $
$ B=(P_2N_1-P_1N_2)+(Q_2M_1-Q_1M_2) $
$ C=N_1Q_2-N_2Q_1 $
The same discriminant classification applies : $B^2-4A C>0$ hyperbolic, $=0$ parabolic, $<0$ elliptic.

For time-dependent systems, the most practical form is often :
$ (partial)/(partial t) bold(U)+bold(A) (partial)/(partial x) bold(U)=bold(S) $
The eigenvalues of the matrix $bold(A)$ are the characteristic speeds. For the constant-$c$ wave equation, with suitable first-order variables,
$ bold(A)=mat(0,-c; -c,0) $
has eigenvalues $+c$ and $-c$, and its eigen-combinations are the two Riemann invariants.

===== Equivalence between a 2nd order PDE and a 1st order system
For
$ A Phi_(x x)+B Phi_(x y)+C Phi_(y y)=R $
define :
$ u=Phi_x, "   " v=Phi_y $
Then the same equation can be written as the two first-order PDEs :
$ cases(
 A u_x+B/2 (u_y+v_x)+C v_y=R,
 u_y-v_x=0
) $
The second relation is simply the compatibility $Phi_(x y)=Phi_(y x)$. Applying the characteristic determinant to this first-order system gives again :
$ A(dif y)^2-B dif x dif y+C(dif x)^2=0 $
So the first-order-system classification and the second-order discriminant classification are the same thing written in two forms.
]

== Mixed type PDEs
#added[
The syllabus also uses the idea of a *mixed physical character*: one PDE can contain mechanisms associated with different PDE families even though its mathematical classification is fixed by its highest-order terms.

*Transport + diffusion* :
$ (partial u)/(partial t)+c(partial u)/(partial x)=alpha (partial^2 u)/(partial x^2) $
For $alpha>0$ this is mathematically *parabolic*, so there is no characteristic method for the full equation. Physically, however, the solution is both transported and smoothed by diffusion. It is posed with an initial condition, like the pure diffusion problem.

*Viscous Burgers* :
$ (partial u)/(partial t)+u(partial u)/(partial x)=alpha (partial^2 u)/(partial x^2) $
The nonlinear transport term creates compression, but any $alpha>0$ regularises the solution and prevents the discontinuous shock of the inviscid Burgers equation. On a periodic/unbounded domain the total integral is conserved, while :
$ (dif)/(dif t) integral u^2/2 dif x=-alpha integral (u_x)^2 dif x < 0 $

*Telegrapher equation* :
$ v_(x x)-L C v_(t t)=(R C+L G)v_t+R G v $
Its second-order principal part is hyperbolic, while the lower-order terms introduce damping / diffusion-like behaviour.
]

== Solving in reverse (classic *Exam* question)
#added[
Some exam questions give you a solution, a family of characteristics or a modal expression and ask you to reconstruct the PDE / parameters. The safest method is to work backwards from the structure rather than guess.

#note_block(block_colors.trick)[
  *Reverse checklist :*
  + Differentiate the proposed solution and write all derivatives that could appear in the PDE.
  + Eliminate the arbitrary function(s) to obtain a relation between the derivatives. That relation is the PDE.
  + If the solution contains an invariant $s(x,t)$ (for example $x-c t$), draw $s="constant"$: these are the characteristic curves.
  + Recover initial data by setting $t=0$ and boundary data by setting the appropriate spatial coordinate to its boundary value.
  + For a conservative transport equation, check whether the invariant is $u$ or $c u$ along the characteristics.
  + For separated series, read the boundary conditions from the basis: $sin(n pi x/L)$ suggests homogeneous Dirichlet; $cos(n pi x/L)$ suggests homogeneous Neumann; Bessel roots $J_m(k_(m n)a)=0$ suggest a fixed circular boundary.
  + Finally check dimensions: arguments of $sin$, $cos$, $exp$, $sinh$, $J_m$, etc. must be dimensionless.
]

Typical recognitions :
$ u=f(x-c t) stretch(=>) u_t+c u_x=0 $
$ Phi=f(x-c t)+g(x+c t) stretch(=>) Phi_(t t)-c^2 Phi_(x x)=0 $
$ u_n(x,t)=sin(k_n x)e^(-alpha k_n^2t) stretch(=>) u_t=alpha u_(x x) $

The key is that the arbitrary function is your friend: because $f$, $g$, ... are arbitrary, their derivatives must cancel identically in the reconstructed PDE.
]

== Solved Exercises (Part 7, p103 of the syllabus)
#added[
The solved-exercise part of the syllabus mainly combines the techniques already developed above. Rather than duplicating every correction, here is the practical map of what each family is training :

#table(
  columns: (1.2fr, 2.2fr),
  stroke: 0.5pt + gray,
  inset: 5pt,
  [*Exercise family*], [*Main technique to remember*],
  [Laplace in annulus / exterior disk], [Polar separation; keep both $r^n$ and $r^(-n)$ when the origin is excluded; impose boundedness / behaviour at infinity.],
  [Laplace in cylinder / cube], [Successive separation constants; choose the coordinate system that matches the geometry; use orthogonality.],
  [Finite thermal diffusion], [Split steady + transient; homogenise the boundary conditions; expand the initial transient on eigenmodes $e^(-alpha k_n^2t)$.],
  [Anti-diffusion], [Reverse sign gives $e^(+alpha k_n^2t)$: high-frequency errors explode, so the backward problem is ill-posed.],
  [Infinite / semi-infinite diffusion], [Green kernel and error-function solutions; compare penetration depth with the finite-domain size.],
  [Damped vibrations], [Spatial eigenmodes stay the same; the time ODE changes and each mode is damped.],
  [Rectangular membrane], [Double separation / Helmholtz; frequencies $omega_(n m)=c sqrt((n pi/L)^2+(m pi/H)^2)$.],
  [Circular / annular membrane], [Bessel functions; regularity decides whether $Y_m$ is allowed; boundary conditions quantise the Bessel roots.],
  [Non-homogeneous PDE / boundary data], [Particular solution or superposition first, then solve homogeneous eigenvalue problems.],
  [Method of characteristics], [Find the characteristic network, propagate the invariant/amplitude, then eliminate the parameter $s$.],
)

#note_block(block_colors.note)[
  The detailed diffusion, circular-wave and Bessel calculations are kept in the next sections because they are especially recurrent in exercises.
]
]

=== 1D Diffusion Equation and links to Green (TP8)
We define the 1D diffusion equation as :
$ (partial u)/(partial t) = alpha (partial^2 u)/(partial x^2) $
For time-independent boundary conditions, it is often useful to split the solution into 2 problems, one in steady regime and another in transition :
$ u(x,t) = u_"reg"(x) + u_"trans"(x,t) $
where $u_"reg"$ is a steady solution and $u_"trans"$ contains the decaying transient modes.

For the transient part, we use the variable separation technique :
$ u_"trans"(x,t)=X(x)T(t) --> X''/X=1/alpha T'/T=lambda $


When we talk about diffusion in 1D, we are often talking about heat. So a heat graph is often helpful to visualize the problem.
#grid(
  columns: (1fr, 1fr),
  align: top,
  inset: 1em,
  [#figure(
  image("EDP_diagrams/Diffusion Curves.svg", width: 85%),
  caption: "1D Diffusion equation - Heat representation (dirichlet conditions)",
)<fig:1D_diffusion>#block()],
  [#figure(
  image("EDP_diagrams/Diffusion Curves neuman.svg", width: 85%),
  caption: "1D Diffusion equation - Heat representation (neumann conditions)",
)])

#added[
#note_block(block_colors.note)[
  *How to read these graphs:* at $t=0$, the transient part contains the difference between the initial profile and the final steady profile. Each non-zero diffusion mode then decays like $e^(-alpha k_n^2 t)$, so
  $ u_"trans"(x,t) -> 0 " as " t -> infinity $
  and the full solution approaches $u_"reg"(x)$.

  With fixed endpoint temperatures (*Dirichlet* conditions), the steady 1D profile is linear when there is no source. With zero heat flux at both ends (*homogeneous Neumann* conditions), the final profile is spatially constant; because the total integral is conserved, this constant is the initial spatial mean temperature.
]
]

*Regime solution* ($lambda=0$) :\
$ alpha X''_0/X = 0 -> X_0 (x)=A_0x + B_0 --> "Apply Boundary Conditions on 0, L" $
$ u_"reg" (x) = A_0 x + B_0 $

*Transition solution* ($lambda!=0$) :\
Since we don't really know how to apply the boundary conditions on $u_"trans"(x, t)$, we will first have to find its relation.
$ u_"trans" (x, t) = u(x, t) - u_"reg" (x) $
We can now find the equivalent conditions. If $u_"reg"$ has been chosen to satisfy the time-independent boundary conditions, then the transient boundary conditions become homogeneous. For homogeneous *Dirichlet* conditions :
$ "CL" : cases(u_"trans"(0,t)=0, u_"trans"(L,t)=0) $
For homogeneous *Neumann* conditions, the corresponding derivatives are zero instead. The initial condition is :
$ "CI" : u_"trans"(x,0)=u(x,0)-u_"reg"(x) $
From here, we can use the variable separation method to find the general solution of the transition part :
$ u_"trans" (x, t) = X(x) T(t) $
$ X''/X = 1/alpha T'/T = lambda $
For the standard diffusion eigenvalue problems with homogeneous boundary conditions, the non-zero modes have $lambda=-k_n^2<0$, so :
$ X_n'' + k_n^2 X_n = 0 "   and   " T_n(t)=C_n e^(-alpha k_n^2 t) $
The positive case $lambda=+k^2$ would produce exponential growth in time and is normally excluded by the physical/boundedness conditions. From here, you can solve like always, using the orthogonality principle.

#note_block(block_colors.note)[
  In the case of the presence of a *source term*, the solution becomes non-trivial :
$ (partial u)/(partial t) = alpha (partial^2 u)/(partial x^2) + S(x,t) $
  A time-independent steady solution $u_"reg"(x)$ exists only when the source and boundary data are compatible with a steady regime. If $S=S(x)$, it satisfies :
$ alpha u_"reg"''(x) + S(x) = 0 $
  so that it can be obtained by integrating $-S(x)/alpha$ twice and then applying the boundary conditions. If $S$ depends on $t$, this simple steady formula cannot be used in general.
]

*Special Case : Semi-infinite domain*\
For a semi-infinite domain $x>=0$ with uniform initial value $u_0$ and a constant surface value $u_s$ imposed at $x=0$, we can use the error function directly :
$ u(x,t) = u_s + (u_0-u_s) "erf"(x/(2 sqrt(alpha t))) = u_0 + (u_s-u_0) "erfc"(x/(2 sqrt(alpha t))) $#footnote($"erfc"(z) = 2/sqrt(pi) integral_z^infinity e^(-s^2) dif s$)
In particular, if $u_0=0$, then $u(x,t)=u_s "erfc"(x/(2 sqrt(alpha t)))$; if $u_s=0$, then $u(x,t)=u_0 "erf"(x/(2 sqrt(alpha t)))$.

The semi-infinite approximation is accurate at *early times*, while the disturbance has not yet reached the far boundary of a finite domain. Since $(u(L,t)-u_0)/(u_s-u_0)="erfc"(L/(2 sqrt(alpha t)))$, a practical 1% penetration criterion at $x=L$ is :

#figure(
  image("EDP_diagrams/Diffusion Curves semi-infinite.svg", width: 35%),
  caption: "1D Diffusion equation - Semi-infinite vs Finite domain",
)<fig:diffusion_semi_infinite_vs_finite>#block()
$ "erfc"(L/(2 sqrt(alpha t))) < 0.01 --> t < L^2/(4 alpha ("erfc"^(-1)(0.01))^2) approx 0.0754 L^2/alpha $

=== Special Diffusion property : Green Convolution
The Green function for the 1D diffusion equation is defined as :
$ G(r, t) = 1/(sqrt(4 pi alpha t)) e^(-r^2/(4 alpha t)) $
With this function, we can find the solution for any initial condition $u(x, 0) = u_0 (x)$ on an infinite domain as :
$ u(x, t) = integral_(-infinity)^infinity u(s,0) G(x-s,t) dif s $
This solution is valid for an infinite domain, and can be used as an approximation for a large enough finite domain (see @fig:diffusion_semi_infinite_vs_finite).
With the idea of finding the $"erf"(z)$ function inside.
#note_block(block_colors.warning)[
  THIS LAST PART IS VERY HARD, please re-do the exercice 8.3 to be sure you understand it !
]

== Wave equation in circular domains
This part is tricky, as it requires the use of Bessel functions. We will only cover it enough for the resolution of exercises, but this is a very deep topic.

Starting from the 2D wave equation in polar coordinates :
$ (partial^2 u)/(partial t^2) = c^2 nabla^2 u = c^2 ((partial^2 u)/(partial r^2) + 1/r (partial u)/(partial r) + 1/r^2 (partial^2 u)/(partial theta^2)) $
Let us separate a first time the variables t and (r, theta) :
$ u(r, theta, t) = Phi(r, theta) T(t) $
$ 1/c^2 T''/T = (nabla^2 Phi)/Phi = lambda $
From this equation, we can find the first *Helmholtz equation* depending on the sign of $lambda$ :
$ nabla^2 Phi + k^2 Phi = 0 " if " lambda = -k^2 $
$ nabla^2 Phi - k^2 Phi = 0 " if " lambda = +k^2 $
We will only consider the first case, as it gives the oscillatory time modes used for the standard wave problem. The second case corresponds to $T''-c^2k^2T=0$ and gives exponential time behaviour.

From here, we separate the variables $r$ and $theta$ :
$ Phi(r,theta)=R(r)Theta(theta) $
Substituting into $nabla^2 Phi+k^2 Phi=0$ gives :
$ (r^2 R'' + r R' + k^2 r^2 R)/R + Theta''/Theta = 0 $
For a full circular domain, periodicity in $theta$ gives :
$ Theta''/Theta = -m^2 "   with   " m=0,1,2,... $
Thus :
$ Theta_m(theta)=A_m cos(m theta)+B_m sin(m theta) $
and the radial equation is :
$ r^2 R'' + r R' + (k^2 r^2-m^2)R=0 $
For $m=0$, the angular solution before applying periodicity is $A_0+B_0 theta$, but periodicity forces $B_0=0$.
This last equation is the *Bessel equation*, and its solutions are the *Bessel functions of the first kind* $J_m (k r)$ and of the *second kind* $Y_m (k r)$ :
$ R(r) = C J_m (k r) + D Y_m (k r) $
$ R_0 (r) = C_0 J_0 (k_0 r) + D_0 Y_0 (k_0 r) $
To avoid singularities at r=0 (keep the solution regular), we will only keep the Bessel functions of the
first kind.
#note_block(block_colors.warning)[
  Be careful, this assumption is only valid for disks ! In the case of annuli, both Bessel functions are valid. As we don't require regularity at r=0 (since its not part of the domain).
]

Now, we can find the solution for T(t) from the first separation :
$ T'' + c^2 k^2 T = 0 $
$ T(t) = E cos(c k t) + F sin(c k t) $
Where, we can often simplify one of the 2 terms using the initial conditions. (for example, if the initial velocity is 0, we have $F=0$, we will continue with this assumption for simplification).
Finally, under the zero-initial-velocity simplification and for a disk with discrete radial eigenvalues, we can write the modal solution as :
$ u(r, theta, t) =& sum_(n=1)^infinity tilde(C_(0 n)) cos(c k_(0 n) t)J_0 (k_(0 n) r)\ &+ sum_(m=1)^infinity sum_(n=1)^infinity cos(c k_(m n) t)J_m (k_(m n) r) (tilde(C_(m n)) cos(m theta) + tilde(D_(m n)) sin(m theta)) $
Where $k_(m n)$ are the radial eigenvalues determined by the boundary conditions. For example, for a circular membrane of radius $a$ with fixed edges, they are the zeros of $J_m$: $J_m(k_(m n)a)=0$. With Neumann-type boundaries, derivatives of the Bessel functions appear instead.

From here, to get the coefficients, we make play of the orthogonality of the Bessel functions and the trigonometric functions. A convenient orthogonal modal basis is :
$ cases(
  Phi_(0 n) (r, theta) = J_0 (k_(0 n) r),
  Phi^c_(m n) (r, theta) = J_m (k_(m n) r) cos(m theta),
  Phi^s_(m n) (r, theta) = J_m (k_(m n) r) sin(m theta)
)$
#note_block(block_colors.warning)[
  Go check the corrective for the exercise 7.2 to see how to find the coefficients using orthogonality !
]

== Bessel functions - Theory
Bessel functions are solutions to the Bessel differential equation :
$ x^2 y'' + x y' + (x^2 - n^2) y = 0 $
Where n is the order of the Bessel function. The two linearly independent solutions to this equation are the Bessel functions of the first kind $J_n (x)$ and of the second kind $Y_n (x)$.

#grid(
  columns: (1fr, 1fr),
  align: center,
  stroke: (x, y) => if y == 0 {(bottom: 0.7pt)} else { if x!=0 {(left: 0.7pt)} else { none }},
  inset: 1em,
  [$J_n (x)$], [$Y_n (x)$],
  [#figure(
  image("EDP_diagrams/BesselJ.png", width: 95%),
  caption: [Bessel functions of the first kind $J_n (x)$ (From wikipedia)],
)<fig:Bessel_Jn>#block()],
  [#figure(
  image("EDP_diagrams/Besselyn.png", width: 95%),
  caption: [Bessel functions of the second kind $Y_n (x)$ (From wikipedia)],
)])
Here are a few properties of Bessel functions that are useful for solving problems :
- Recurrence relations :
$ J_(n-1) (x) + J_(n+1) (x) = (2 n)/x J_n (x) $
$ J_(n-1) (x) - J_(n+1) (x) = 2 J'_n (x) $

and similarly for $Y_n$ :
$ Y_(n-1) (x) + Y_(n+1) (x) = (2 n)/x Y_n (x) $
$ Y_(n-1) (x) - Y_(n+1) (x) = 2 Y'_n (x) $

- Derivative relations :
$ J'_n (x) = (1/2) (J_(n-1) (x) - J_(n+1) (x)) $
$ Y'_n (x) = (1/2) (Y_(n-1) (x) - Y_(n+1) (x)) $

Alternative form :
$ J'_n (x) = J_(n-1) (x) - (n/x) J_n (x) $

- Negative order / parity (for integer $n$) :
$ J_(-n) (x) = (-1)^n J_n (x) $
$ Y_(-n) (x) = (-1)^n Y_n (x) $

in particular :
$ J_(-1) (x) = - J_1 (x) $
$ J_(-2) (x) =   J_2 (x) $

- Integral relation :
$ integral J_0 (z)*z dif z = J_1 (z) * z $
$ integral J_0 (z)z^m dif z = J_1(z) z^m + (m-1)J_0(z)z^(m-1) - (m-1)^2 integral J_0 (z)z^(m-2) dif z $

- Orthogonality :
If $k_(m n)$ and $k_(m p)$ are roots of $J_m$ such that $J_m (k_(m n) a) = 0$ and $J_m (k_(m p) a) = 0$, then
$ integral_0^a r J_m (k_(m n) r) J_m (k_(m p) r) dif r =
  "if" n != p: 0
  "else": (a^2)/2 (J_(m+1) (k_(m n) a))^2 $

- Integral representation (for integer $n$) :
$ J_n (x) = 1/pi integral_0^pi cos(n tau - x sin(tau)) dif tau $

- Series representation :
$ J_n (x) = sum_(k=0)^infinity ((-1)^k) / (k! Gamma(k + n + 1)) (x/2)^(2 k + n) $

For integer $n >= 0$, this becomes
$ J_n (x) = sum_(k=0)^infinity ((-1)^k) / (k! (k + n)!) (x/2)^(2 k + n) $

Special case $n = 0$ :
$ J_0 (x) = sum_(k=0)^infinity ((-1)^k) / ((k!)^2) (x/2)^(2 k) $


#note_block(block_colors.note)[
  Bessel functions have an infinite number of roots. The first few roots for the first orders are :
$ j_(0 1) approx 2.4048" , " j_(0 2) approx 5.5201" , " j_(0 3) approx 8.6537\
j_(1 1) approx 3.8317" , " j_(1 2) approx 7.0156" , " j_(1 3) approx 10.1735\
j_(2 1) approx 5.1356" , " j_(2 2) approx 8.4172" , " j_(2 3) approx 11.6198 $
NB : (Roots checked)
]

#note_block(block_colors.warning)[
  Bessel functions are orthogonal over the interval [0, a] with weight r :
$ integral_0^a r J_m (k_(m n) r) J_m (k_(m p) r) dif r = 0 " if " n != p $
Where $k_(m n)$ and $k_(m p)$ are different roots of the Bessel function of order m.
]

Some examples of disk and annulus modes are shown in the following figures :
#grid(
  columns: (1fr, 1fr),
  align: center,
  inset: 1em,
  [#figure(
  image("EDP_diagrams/annulus_eigenmode_m0_radialidx_2.png", width: 90%),
  caption: "Annulus modes (fixed edges)",
)<fig:disk_modes>#block()],
  [#figure(
  image("EDP_diagrams/disk_eigenmode_m0_radialidx_2.png", width: 90%),
  caption: "Disk modes (fixed edges)",
)])
