#import "../../templates/template_syth_gen1.typ": conf, block_colors, note_block, todo_block, def_block
#show: conf.with(
  title: [
    EDP - Complex Analysis
  ],
  course: "LELEC1103",
  authors: (
     (name: "Victor Carballes", affiliation: "UCLouvain"),
   ),
  abstract: [
    This document covers the essential concepts of complex analysis, including complex numbers, functions, differentiation, integration, series, residues, and conformal mappings. It aims to provide a solid foundation for understanding the behavior of complex functions and their applications in various fields of science and engineering. \ #box(move(dy: 0.4em, [ Source code here : #text(fill: color.aqua.darken(20%))[#link("https://github.com/vctrcc/personal-typst-archive")]]))
  ],
)
// ==============================================================================================
// Introduction
// ==============================================================================================
= Introduction
== Complex Numbers
=== Representations
#block(inset: 1em)[
  #grid(
    columns: (1fr, 1.5fr, 1fr),
    gutter: 0.9em,
    align: horizon,
    // Header
    [#text(weight: "bold")[Form]],
    [#text(weight: "bold")[Expression]],
    [#text(weight: "bold")[Parameters]],
    // Cartesian (Rectangular)
    [Cartesian / Rectangular],
    [$z = a + b dot i $],
    [$a = r cos(theta)$, $b = r sin(theta)$],
    // Polar
    [Polar / Trigonometric],
    [$z = r (cos(theta) + i sin(theta)) = r "cis"(theta) $],
    [$r = |z| $(Modulus)\ $theta = arg(z) $(Argument)],
    // Exponential (Euler's)
    [Exponential (Euler)],
    [$z = r e^(i theta) $],
    [$r = |z| $, $theta = arg(z) $]
  )
]

=== Basic Properties
#block(inset: 1em)[
  #grid(
    columns: (1fr, 2fr),
    gutter: 0.9em,
    align: horizon,
    [#text(weight: "bold")[Property Name]], [#text(weight: "bold")[Expression / Definition]],
    // Modulus
    [Modulus (Magnitude)],
    [$|z| = sqrt(a^2 + b^2)$],
    // Complex Conjugate
    [Complex Conjugate],
    [$overline(z) = a - b dot i = r e^(-i theta) = z^*$],
    // Conjugate Properties
    [Conjugate Modulus],
    [$|overline(z)| = |z|$],
    [Conjugate Addition],
    [$overline(z_1 plus.minus z_2) = overline(z_1) plus.minus overline(z_2) $],
    [Conjugate Multiplication],
    [$overline(z_1 z_2) = overline(z_1) overline(z_2) $],
    [Scalar Conversion],
    [$overline(z)*z=|$z$|^2$],
    // Addition / Subtraction
    [Addition / Subtraction],
    [$z_1 plus.minus z_2 = (a_1 plus.minus a_2) + (b_1 plus.minus b_2) dot i $],
    // Multiplication
    [Multiplication (Cartesian)],
    [$z_1 z_2 = (a_1 a_2 - b_1 b_2) + (a_1 b_2 + a_2 b_1) dot i $],
    // Multiplication (Polar)
    [Multiplication (Polar)],
    [$z_1 z_2 = r_1 r_2 e^(i (theta_1 + theta_2)) $],
    // Division (Polar)
    [Division (Polar)],
    [$z_1/z_2 = r_1/r_2 e^(i (theta_1 - theta_2)) $($z_2 != 0$)],
    // De Moivre's Theorem
    [De Moivre's Theorem],
    [$z^n = r^n e^(i n theta) = r^n (cos(n theta) + i sin(n theta)) $],
    // Triangular Inequality
    [Triangular Inequality],
    [$|z_1 plus.minus z_2| <= |z_1| + |z_2| $],
  )
]

== Complex Functions
We define a complex function as a mapping from one set of complex numbers to another. Formally, for a subset $A subset CC$, a complex function $f$ is defined as :
$ f : A --> CC $
Where $CC$ is the set of complex numbers. A complex function can be expressed in terms of its real and imaginary components as :
$ f(z) = u(a, b) + i v(a, b) $
Where $u(a, b)$ and $v(a, b)$ are real-valued functions representing the real and imaginary parts of $f(z)$ respectively, with $z = a + b dot i $. We can also get the vector representation :
$ F(a,b) = (u(a,b),v(a,b)) = (Re(f(a+i b)), Im(f(a+i b))) $

== Limits
=== Sense of a limit (Remark 1.1)
The definition of a limit at $z_0$ only has meaning if points of the domain can approach $z_0$. In other words, $z_0$ must be an accumulation point of the domain $A$. If there exists $delta>0$ such that :
$ A inter B_*(z_0,delta) = emptyset $
then there are no points of $A$ arbitrarily close to $z_0$, and the limit $lim_(z->z_0) f(z)$ cannot be tested.
#def_block([
  *Interpretation:* The important condition is *not* that $z_0$ belongs to the domain. A limit can perfectly well be taken at a point outside the domain, for example at a removed point or at a boundary point. What matters is that there are points of the domain arbitrarily close to $z_0$.
])
The points $z_0$ for which :
$ forall delta >0 : A inter B_*(z_0, delta) != emptyset $
are called *accumulation points* of the set $A$.
Points that which are not accumulation points of $A$ are called *isolated points* of the set $A$.
#note_block(block_colors.note)[
  In complex analysis, we will often encounter *isolated zeros* of holomorphic functions (isolated points of the set ${z : f(z) = 0}$) and *isolated singularities* (isolated points where the function is not analytic but is analytic in a punctured neighbourhood). Both play an important role in the theory of residues.
]
=== Interior points (Definition 1.1)
A point $z_0$ is called an interior point of a set $S subset CC$ if there exists a radius $delta > 0$ such that the open disk B(z_0, delta) is entirely contained within the set $S$. Formally :
$ B(z_0, delta) = { z in CC : |z - z_0| < delta } subset S $
#def_block([*Interpretation:* Interior points are those that are not on the edge of a set. They have a "buffer zone" around them that still lies within the set.])

=== Omnidirectional limit in a set (Proposition 1.1)
Let $f : A -> CC$, from subset $A subset CC$. If a interior point $z_0 in A$ exists, and the limit $lim_(z -> z_0) f(z)$ exists, then for any value $w in CC_0$ :
$ lim_(delta->0, delta^+ in RR) f(z_0 + delta w) = lim_(z -> z_0) f(z) $
#def_block([*Interpretation:* This proposition states that if the limit of a function exists at an interior point of its domain, then approaching that point from any fixed direction in the complex plane will yield the same limit. This is crucial for understanding why a complex limit has to agree in every direction.])
#note_block(block_colors.note)[
  This proposition is the big difference between real analysis and complex analysis. In real analysis, limits are typically approached from two directions (left and right). However, in complex analysis, limits must be considered from all possible directions in the complex plane, making the concept of continuity and differentiability more stringent.
]
== Differentiability
=== Derivability (Definition 1.2)
A function $f:A->CC$ in a subset $A subset CC$ is deriveable in the complex sense at an interior point $z in A$ if the following limit exists :
$ f'(z) = lim_(w -> z) (f(w) - f(z))/(w - z) = lim_(Delta->0) (f(z+Delta) - f(z))/Delta $
Where $Delta in CC$ and $Delta != 0$. The value $f'(z)$ is called the complex derivative of $f$ at the point $z$.
#def_block([*Interpretation:* Complex differentiability is a stronger condition than real differentiability. It requires the function to behave consistently in all directions in the complex plane, leading to powerful results and properties unique to complex analysis.])

== Conditions of differentiability
=== Diferentiability Conditions development
Take function $f: CC -> CC$, and convert it into 2 real functions $u, v : RR^2 -> RR$ such as :
$ f(z) = u(x, y) + i v(x, y) <-> cases(
  u : RR^2 -> RR : (x, y) -> Re(f(x + i y)),
  v : RR^2 -> RR : (x, y) -> Im(f(x + i y)),
) $
Where $z = x + i y$. We can now express the complex derivative in function of $u$ and $v$ :
#block()
#grid(
  columns: (1fr, 1fr),
  gutter: 0.9em,
  align: horizon,
  inset: 0.5em,
  [
    $f'(z) = lim_(delta->0,delta in RR) (f(z + delta*1) - f(z))/(delta*1)$
  ],
  [
    $f'(z) = lim_(delta->0,delta in RR) (f(z + delta*i) - f(z))/(delta*i)$
  ],
  [
    $= lim_(delta->0,delta in RR) (f(x + delta + i*y) - f(x + i y))/(delta*1)$
  ],
  [
    $= lim_(delta->0,delta in RR) (f(x + i*(y + delta)) - f(x + i y))/(delta*i)$
  ],
  [
    $= lim_(delta->0,delta in RR) (u(x + delta, y) - u(x, y) + i (v(x + delta, y) - v(x, y)))/(delta*1)$
  ],
  [
    $= lim_(delta->0,delta in RR) (u(x, y + delta) - u(x, y) + i (v(x, y + delta) - v(x, y)))/(delta*i)$
  ],
  [
    $= lim_(delta->0,delta in RR) (u(x + delta, y) - u(x, y))/(delta*1) + i lim_(delta->0,delta in RR) (v(x + delta, y) - v(x, y))/(delta*1)$
  ],
  [
    $= (1/i) lim_(delta->0,delta in RR) (u(x, y + delta) - u(x, y))/(delta*1) + i (1/i) lim_(delta->0,delta in RR) (v(x, y + delta) - v(x, y))/(delta*1)$
  ],
  [
    $= (partial u/partial x)(x, y) + i (partial v/partial x)(x, y)$
  ],
  [
    $= -i (partial u)/(partial y)(x, y) + (partial v)/(partial y)(x, y)$
  ],
)
#block()
This leads to the Cauchy-Riemann conditions for differentiability :
$ cases(
  (partial u)/(partial x)(x, y) = (partial v)/(partial y)(x, y),
  (partial u)/(partial y)(x, y) = - (partial v)/(partial x)(x, y),
) <--> cases(
  u_x (x, y) = v_y (x, y),
  u_y (x, y) = - v_x (x, y),
) $
#note_block(block_colors.note)[
  Under certain hypothesis, the Cauchy-Riemann conditions are not only necessary but also sufficient for complex differentiability. Specifically, if the partial derivatives of $u$ and $v$ exist and are continuous in a neighborhood of a point, and they satisfy the Cauchy-Riemann equations at that point, then the function is complex differentiable at that point.
]

=== Cauchy-Riemann Conditions (Proposition 1.2)
Take open non-empty subset $A subset CC$, and function $f:A->CC$, such as $f$ is separable into 2 real functions in subset $A$, $u, v : RR^2 -> RR$ of form $f(x+i y) = u(x, y) + i v(x, y)$ for all $z in A$ :
#block(inset: 1em, [
- If $f$ is complex differentiable on $A$, then $u, v$ satisfy the Cauchy-Riemann conditions on $A$.
- If $u$ and $v$ accept continuous partial derivatives on $A$ that satisfy the Cauchy-Riemann conditions on $A$, then $f$ is complex differentiable on $A$.])

#def_block(
  [*Interpretation:* The Cauchy-Riemann conditions provide a bridge between the real and imaginary parts of a complex function. They ensure that the function behaves consistently in all directions in the complex plane, which is essential for complex differentiability. This proposition highlights the deep connection between the geometry of the complex plane and the analytic properties of complex functions.]
)

#note_block(block_colors.note)[
  The subset $A subset CC$ must be open for Proposition 1.2 to hold (i.e., for every point in $A$, there exists a neighborhood around that point that is entirely contained within $A$). This openness condition ensures that we can approach any point in $A$ from all directions in the complex plane, which is essential for the validity of the Cauchy-Riemann conditions and the differentiability of the function.
]

=== Differentiability of Cauchy-Riemann Conditions (Proposition 1.3)
Take open non-empty subset $A subset CC$, with function $f:A->CC$ defined as :
$ F(x, y) :=(Re(f(x+i y)), Im(f(x+i y))) $

For all $(x, y) in RR^2$ such that $x+i y in A$. The function $f$ is complex differentiable on $A$ *if and only if* the $F$ is differentiable on $(x, y):=(Re(z), Im(z))$, and satisfies the Cauchy-Riemann conditions on $A$.

#def_block([*Interpretation:* This proposition establishes a direct equivalence between the complex differentiability of a function and the real differentiability of its associated vector function, provided the Cauchy-Riemann conditions are satisfied. It emphasizes that complex differentiability is not just about the behavior of the function in the complex plane, but also about how its real and imaginary components interact and change with respect to each other in the real plane.])

#note_block(block_colors.extra)[
We can also express the complex derivative using the Jacobian matrix of the associated real vector function $F(x,y) = (u(x,y), v(x,y))$. If $f$ is holomorphic, the complex derivative $f'(z)$ corresponds to the matrix-vector product:
$ vec(Re(f'(z)), Im(f'(z))) = J_F (x, y) dot vec(1, 0) = mat(
  u_x, u_y;
  v_x, v_y;
) dot vec(1, 0) $
Alternatively, the Cauchy-Riemann equations imply that the Jacobian matrix has a specific structure (rotation-dilation matrix):
$ J_F(x,y) = mat(u_x, -v_x; v_x, u_x) $
which corresponds to multiplication by the complex number $f'(z) = u_x + i v_x$.
]
=== Linear Operations on Complex Differentiability (Theorem 1.1)
This theorem states that the usual algebraic operations (addition, subtraction, multiplication, division, polynomials, rationals, ...) follow the same differentiation rules in complex analysis as in real analysis. If $f, g : A -> CC$ are complex differentiable functions on a subset $A subset CC$, and $c in CC$ is a constant, then the following operations yield complex differentiable functions on $A$ :
#block(inset: 1em, [
- Addition: $h(z) = f(z) + g(z)$
- Subtraction: $h(z) = f(z) - g(z)$
- Multiplication by a constant: $h(z) = c dot f(z)$
- Multiplication: $h(z) = f(z) dot g(z)$
- Division (if $g(z) != 0$ for all $z in A$): $h(z) = f(z) / g(z)$
- Composition: $h(z) = f(g(z))$ (if $g(A) subset A$)
])

=== Holomorphism Definition (Definition 1.3)
In a non empty open subset $A subset CC$. A function is *Holomorphic* on $A$ if it is *differentiable at all points* of $A$. And *$"Hol"(A)$* is the set of holomorphic functions on $A$.

When $A$ is not defined, we will be considering all holomorphic functions on the complex plane $CC$.

We note the set of *continuous functions on $A$ as $C(A)$*.

#note_block(block_colors.note)[
  Holomorphic functions are the complex analogs of real differentiable functions, but with much stronger properties. They are *infinitely differentiable* and can be represented by convergent *power series within their radius of convergence*. This makes them a central object of study in complex analysis, with applications in various fields such as fluid dynamics, electromagnetism, and quantum mechanics.
]

// ==============================================================================================
// Power Series
// ==============================================================================================
= Power Series
== Definitions and convergence
=== Power Series Definition (Definition 2.1)
A power series centered at $z_0 in CC$ is an infinite series of the form :
$ sum_(n=0)^infinity a_n (z - z_0)^n $
Where $a_n in CC$ are the coefficients of the series, and $z$ is a complex variable. The point $z_0$ is called the center of the series.
#note_block(block_colors.note)[
  Some of their properties are very suprising, and so, limits and convergences should not be given numbers directly.
]

=== Geometric Bound (Hypothesis 2.1)
There exists real numbers $t in ]0,1[$ such that $C>0$ and $rho>0$ exist for any $n in NN$ :
$ |a_n| rho^n <= C t^n $
#def_block([*Interpretation:* This hypothesis provides a condition on the coefficients of a power series that ensures the series converges within a certain radius. It essentially states that the coefficients must not grow too quickly, allowing the series to behave well within the disk of convergence defined by $rho$.])

=== Radius of Convergence (Proposition 2.1)
Under hypothesis 2.1, for any complex $z$ in the ball centered at zero, of radius $rho$ ($z in B(0, rho)$), the series converges *absolutely* :
$ sum_(n>=0) |a_n z^n| < infinity $
Then, the summation function is well defined on $B(0, rho)$ :
$ S(z) = sum_(n>=0) a_n z^n $
#def_block([*Interpretation:* The radius of convergence defines the boundary within which a power series converges to a well-defined function. Inside this radius, the series behaves nicely, allowing us to use it for analysis and computation. Outside this radius, the series may diverge, leading to undefined or infinite values.])
*Proof* : Take $z in B(0, rho)$, and apply hypothesis 2.1 :
$ sum_(n>=0) |a_n z^n| <= sum_(n>=0) C t^n = C underbrace(sum_(n>=0) t^n) = C 1/(1 - t) < infinity $
Where the last equality comes from the geometric series formula, and converges absolutely, which implies pointwise convergence.

=== Continuity of Power Series (Proposition 2.2)
Under hypothesis 2.1, the polynomials $s_k$ defined as :
$ s_k (z) = sum_(n=0)^k a_n z^n $
Converge uniformly to $S$ on any closed disk $B[0, r]$ with $r < rho$. Thus, the summation function $S$ is continuous on $B(0, rho)$.

#def_block([*Interpretation:* This proposition states that within the radius of convergence, the partial sums of the power series converge uniformly to the function defined by the series. This uniform convergence ensures that the function is continuous, allowing us to manipulate and analyze it using standard techniques from calculus.])

== Derivative of a Power Series
We describe the derivative of a power series as the following series :
$ S'(z) = sum_(n>=1) n a_n z^(n-1) = sum_(n>=0) (n+1) a_(n+1) z^n $
Where $S(z) = sum_(n>=0) a_n z^n$, that we want to prove converges absolutely and uniformly.
#note_block(block_colors.note)[
  Do note that the index of the sum has changed !
]

=== Convergence of the derivative (Proposition 2.3)
From $S'(z) =sum_(n>=0) (n+1) a_(n+1) z^n $. If $S(z)$ satisfies hypothesis 2.1 for a certain $rho$, then $S'(z)$ also satisfies hypothesis 2.1 for the same value $rho$ (*But maybe different $C$ and $t$*).
#def_block([*Interpretation:* This proposition shows that differentiating the series does not reduce the radii $rho$ for which hypothesis 2.1 can be satisfied. In consequence, once the exact radius of convergence is defined, the derivative has the same radius of convergence as the original power series.])
*Proof* :
Take $r in ]0, rho[$, and $z in B(0, r)$. From hypothesis 2.1 on $S$, we obtain that for any $n in NN$ :
$ (n+1)|a_(n+1)|rho^n = (n+1)/rho |a_(n+1)| rho^(n+1) <= (n+1)/rho C t^(n+1) = (C t)/rho (n+1) t^n $

Let us take $t' in ]t, 1[$. We have :
$ (n+1)|a_(n+1)|rho^n <= (C t)/rho (n+1) (t/t')^n (t')^n $

Since $t / t' < 1$, we can easily verify that $lim_(n->infinity) (n+1) (t/t')^n = 0$, and therefore there exists a uniform bound $C'$ on $(n+1) (t/t')^n$.

#note_block(block_colors.note)[
  Alternatively, we can see that the sequence is bounded by observing that the ratio between two successive terms is less than 1 when $1/n$ becomes smaller than $(t'/t) - 1$.
]

We then obtain that for any $n$ :
$ (n+1)|a_(n+1)|rho^n <= (C C' t)/rho (t')^n $

Thus, $S'$ satisfies hypotesis 2.1 with $rho$, $t'$ and $(C C' t)/rho$.

#def_block([*Interpretation:* This result implies that $S'$ is well-defined and continuous on $B(0, rho)$, but we do not yet know if it is actually the derivative of $S$. This is the subject of the next result.])

=== Complex Derivative of Power Series (Proposition 2.4)
If $S(z)$ satisfies hypothesis 2.1, then $S$ is complex differentiable on $B(0, rho)$, and its complex derivative is given by the term-by-term derivative of the series :
$ S'(z) = sum_(n>=1) n a_n z^(n-1) $
#def_block([*Interpretation:* This proposition confirms that we can differentiate power series term-by-term within their radius of convergence. This property is crucial for using power series in complex analysis, as it allows us to manipulate and analyze complex functions represented by power series with ease.])

=== Convergence and Holomorphism of Power Series (Corollary 2.1)
If a series $sum_(n>=0) a_n z^n$ satisfies hypothesis 2.1, then :
- It convergence absolutely and uniformly towards a function $S(z)$ on the ball $B(0, rho)$.
- This function is holomorphic on $B(0, rho)$.
- All its derivatives are continuous.
#def_block([*Interpretation:* This corollary summarizes the key properties of power series that satisfy the given hypothesis. It highlights that such series not only converge to a well-defined function within their radius of convergence but also that this function is holomorphic and has continuous derivatives. This makes power series a powerful tool for constructing and analyzing holomorphic functions in complex analysis.])

== Radius of Convergence
=== Convergence radius (Definition 2.2)
The radius of convergence of a power series $sum_(n>=0) a_n (z - z_0)^n$ is the non-negative real number $R$ defined from the set :
$ G_s := {rho >=0 : exists C > 0 : |a_n| rho^n <= C forall n in NN} $
$ R = sup G_s $
If the set $G_s$ is not bounded above, we set $R = infinity$, with the convention $B(z_0, infinity)=CC$.
#def_block([*Interpretation:* The radius of convergence defines the boundary within which a power series converges to a well-defined function. Inside this radius, the series behaves nicely, allowing us to use it for analysis and computation. Outside this radius, the series may diverge, leading to undefined or infinite values.])
#note_block(block_colors.note)[
  It is the supremum of the set of bounding radii for which the series converges.
]

=== Upper bound on the radius of convergence (Lemma 2.1)
For any $rho<R$, with $R$ the radius of convergence, we can find a parameter $t in ]0,1[$ and a constant $C>0$ such that hypothesis 2.1 is satisfied.
#def_block([*Interpretation:* This lemma provides a practical way to verify the convergence of a power series within its radius of convergence. It states that for any *radius smaller than the radius of convergence*, we can find parameters that satisfy the convergence hypothesis, ensuring that the series behaves well within that region.])

=== Exact value of the radius of convergence (Theorem 2.1)
For a power series $sum_(n>=0) a_n (z - z_0)^n$, and $R$ its radius of convergence, we have :
- A function $S(z)$ defined on $B(z_0,R)$ such as :
$ S(z) = sum_(n>=0) a_n (z - z_0)^n $
  The convergence is uniform on every closed disk $B[z_0,rho]$ with $rho<R$.
- $S(z)$ is *continuous* and infinitely *differentiable* on $B(z_0, R)$ (holomorphic).
- Its derivatives are given by the term-by-term differentiation of the series.

=== Non-convergence outside the radius (Proposition 2.5)
If $rho > R$, with $R$ the radius of convergence of the power series $sum_(n>=0) a_n (z - z_0)^n$, then the series diverges for every point $z$ such as $|z - z_0| = rho$.

*Proof* : By contradiction, suppose that the series converges for one point $z$ such as $|z-z_0|=rho$. Then its terms converge to zero, and in particular the sequence $a_n(z-z_0)^n$ is bounded. Thus, there exists $C>0$ such that :
$ |a_n| rho^n = |a_n (z-z_0)^n| <= C " " forall n in NN $
This means that $rho in G_s$, and therefore $rho <= sup G_s = R$, contradicting $rho>R$.

== Calculating the Radius of Convergence
=== Equivalences to the radius of convergence (Proposition 2.6)
If these quantities exist, they are equal to $R^(-1)$:
$ R^(-1) &= lim_(n->infinity) | a_(n+1)/a_n| \ R^(-1) &= lim_(n->infinity) (sup_(m>=n) |a_m|^(1/m))  ("Cauchy-Hadamard") $
#def_block([*Interpretation:* This proposition provides two practical methods for calculating the radius of convergence of a power series. The first method uses the ratio of successive coefficients, while the second method employs the root test. Both methods yield the same result for the radius of convergence, allowing us to determine the region where the power series converges effectively.])

#note_block(block_colors.note)[
  Cauchy-Hadamard formula is particularly useful when the coefficients of the power series have a complex structure, making direct computation of the radius of convergence challenging. By examining the growth rate of the coefficients, we can determine the radius of convergence without needing to analyze the entire series directly.
]

#note_block(block_colors.trick)[
  *Limit properties* :
  - L'Hôspital's Rule : for an indeterminate form $0/0$ or $infinity/infinity$, and under the usual differentiability hypotheses, $lim_(x->infinity) f(x)/g(x) = lim_(x->infinity) f'(x)/g'(x)$, provided the latter limit exists.
  - Power Rule : if $lim_(x->infinity) f(x)=L$, then for a fixed integer $n$, $lim_(x->infinity) f(x)^n = L^n$
  - Dominance Rule : for a fixed $n>1$ and $x->infinity$, the growth order is eventually $1<x<x^n<n^x<x^x$
]

== Analytical Functions
=== Analytical Function Definition (Definition 2.3)
A function $f:A->CC$ defined on an open subset $A subset CC$ is called *analytical* on $A$ if for every point $z_0 in A$, there exists a power series centered at $z_0$ of radius of convergence $R>0$ such as :
$ f(z) = sum_(n>=0) a_n (z - z_0)^n "    "(forall z in B(z_0, r) subset A, r in ]0,R]) $
It is then called *the power series expansion of $f$ at $z_0$*.
#def_block([*Interpretation:* Analytical functions are those that can be locally represented by power series. This property allows us to study and manipulate these functions using the tools of power series, making them a central object of study in complex analysis. Analytical functions exhibit a high degree of regularity and smoothness, making them particularly amenable to various mathematical techniques.])
#note_block(block_colors.note)[
  In complex analysis, the concepts of *holomorphic* and *analytical* functions *are equivalent*. A function is holomorphic if it is *complex differentiable at every point in its domain*, and it is analytical if it can be *represented by a convergent power series around every point in its domain*. This equivalence is a fundamental result in complex analysis, highlighting the deep connection between differentiability and power series representation in the complex plane.
]

=== Infinitely Differentiable (Corollary 2.2)
If a function $f:A->CC$ is analytical on an open subset $A subset CC$, then it is infinitely differentiable on $A$ (holomorphic), and all its derivatives are also analytical on $A$. And more specifically, the coefficients of the power series expansion of $f$ at $z_0 in A$ are given by :
$ a_n = (f^((n)) (z_0))/(n!) $
Thus :
$ f(z) = sum_(n>=0) a_n (z - z_0)^n $
With $f^((n))$ denoting the $n$-th derivative of $f$ at $z_0$.
#def_block([*Interpretation:* This corollary emphasizes the strong relationship between analytical functions and their differentiability properties. It states that analytical functions are not only infinitely differentiable but also that their derivatives can be expressed in terms of the coefficients of their power series expansions. This property is crucial for understanding the behavior of analytical functions and for performing various operations on them, such as differentiation and integration.])

== Isolated Zeros Principle
=== Isolated Zero Definition (Definition 2.4)
In a subset $D subset CC$, a point $z_0 in D$ is called an *isolated zero* of a function $f:D->CC$ if there exists a radius $delta>0$ such as :
$ B(z_0, delta) inter {z in D : f(z) = 0} = {z_0} $
Meaning, the ball contains no other zeros of $f$ except at $z_0$.

=== Isolated Zeros of Analytical Functions (Lemma 2.2)
Let $f : A -> CC$ be an analytical function such that $f(z_0) = 0$ for some $z_0 in A$. There exists $r > 0$ such that either:
- $f$ is identically zero on $B(z_0, r)$, or
- $f(z) = (z - z_0)^k g(z)$ for all $z in B(z_0, r)$, for some $k > 0$ and a holomorphic (and thus continuous) function $g$ defined on $B(z_0, r)$ such that $g(z_0) != 0$.

In the second case, $z_0$ is an isolated zero.
#def_block([*Interpretation:* This lemma provides a fundamental characterization of zeros for analytical functions. Either the function vanishes on an entire neighborhood (and by analytic continuation, on the whole connected component), or the zero has a finite order $k$ and is isolated. The integer $k$ is called the *multiplicity* or *order* of the zero at $z_0$.])

*Proof* :\
For simplicity, we will consider the case where $z_0 = 0$. Since $f$ is analytical at $0$, it can be expressed as a power series :

$ f(z) = sum_(n>=0) a_n z^n $

Let us take $r<R$ such that $z in B(0, r) subset.eq A$ where $f(z)$ is defined with $z in A$.\
If all coefficients $a_n$ are null ($=0$), then $f(z)=0 forall z in B(0, r)$.\
Else, let us take the smallest integer $k$ such that $a_k != 0$. We can then rewrite $f(z)$ as :

$ f(z) = sum_(n>=k) a_n z^n = z^k sum_(n>=0) a_(n+k) z^n = z^k g(z) $

Where $g(z) = sum_(n>=0) a_(n+k) z^n$ is also analytical on $B(0, r)$ converging on $R$, and $g(0) = a_k != 0$. By continuity of $g$, there exists $delta>0$ such that for all $z in B(0, delta)$, $g(z) != 0$. Thus, the only zero of $f$ in $B(0, delta)$ is at $z=0$, making it an isolated zero.

#note_block(block_colors.note)[
  The discovery of this proof may seem surprising, as the final result is quite strong without clearly seeing where a strong hypothesis was used. The key lies in the ability to factorize $f$ as the product of $z^k$ and a function *continuous and non-zero at zero* — which may seem trivial based on series expansion, but is not true in general.\

  Consider the real function $f(x) = x^2$ if $x >= 0$ and $f(x) = 0$ if $x < 0$. Crucially, this function admits a series expansion at every point except $0$. An even more surprising example is $f(x) = e^(-1\/|x|)$ if $x != 0$ and $f(0) = 0$. This function is infinitely differentiable on $RR$, including at $0$, but has no series expansion at $0$, and cannot be written as $z^k$ times a continuous non-zero function. All its derivatives are zero at $0$, but the function is not identically zero around zero. Similarly, $g(x) = e^(-1\/x)$ if $x > 0$ and $0$ otherwise is infinitely differentiable on $RR$ but has no series expansion at $0$.\

  In the first and third real examples, $0$ is *not* an isolated zero. In the second example $f(x)=e^(-1\/|x|)$, $0$ is isolated, but it is a zero of infinite order: all derivatives vanish at $0$ although the function is not identically zero around it. Both behaviours highlight why complex analyticity is such a powerful condition.
]

#note_block(block_colors.extra)[
  To state the general result, we need to introduce a notion of *connectedness*, representing that the function is defined on a set consisting of "a single piece". Indeed, if the function were defined on two disjoint subsets $A_1, A_2$, it could be null on $A_1$ and non-null on $A_2$. We use *path-connectedness*, which requires that any point $z_1$ can be joined to any point $z_2$ via a continuous path that stays within $A$. To simplify certain arguments, we sometimes require the path to be *polygonal* (a finite set of segments).
]

=== Path-Connected (Definition 2.5)
A subset $A subset CC$ is called *path-connected* if for any pair of points $z_1, z_2 in A$, there exists a continuous function (path) $gamma: [0, 1] -> A$ such that :
$ gamma(0) = z_1 " and " gamma(1) = z_2 $
#block()
A subset $A subset CC$ is called *polygonally path-connected* if for any pair of points $z_1, z_2 in A$, there exists a finite sequence of points $z_0, z_1, ..., z_n$ in $A$ such that :
- $z_0 = z_1$ and $z_n = z_2$
- For each $i = 0, 1, ..., n-1$, the line segment connecting $z_i$ and $z_(i+1)$ is entirely contained within $A$.
#def_block([*Interpretation:* Path-connectedness ensures that the set is "all in one piece," allowing for *continuous movement* between *any two points within the set*. Polygonal path-connectedness strengthens this by requiring that the paths can be *constructed from straight line segments*, which is often useful in geometric and analytic arguments.])

=== Isolated Zero Principle (Theorem 2.2) // Understand connection
Let $A subset CC$ be a path-connected open subset, and $f:A->CC$ an analytical function. If $f$ is not identically zero on $A$, then all its zeros are isolated in the sense of definition 2.4.
#def_block([*Interpretation:* This theorem states that for an analytical function defined on a path-connected open set, if the function is not identically zero, then any zeros it has must be isolated points. This means that around each zero, there exists a neighborhood where no other zeros exist. This property is crucial for understanding the behavior of analytical functions and their zeros in complex analysis.])
#note_block(block_colors.note)[
  Important to see the connection between Lemma 2.2, to Theorem 2.2.
]

=== Identity Principle (Corollary 2.3)
Take 2 analytical functions $f, g : D -> CC$ defined on a path-connected open subset $D subset.eq CC$. If for all $z$ in a subset of $D$, we have $f(z) = g(z)$, and *there exists an accumulation point of this subset that belongs to $D$*, then $f(z) eq.triple g(z)$ on $D$.
#def_block([*Interpretation:* This corollary states that if two analytical functions agree on a subset of their domain that contains an accumulation point, then they must be identical throughout the entire domain. This highlights the rigidity of analytical functions, where local agreement implies global equality, emphasizing the strong constraints imposed by analyticity.])
*Proof:*\
We apply theorem 2.2 to the function $h(z) = f(z) - g(z)$, which is analytical on $D$. The points where $f(z)=g(z)$ are exactly the zeros of $h$. If $h$ were not identically zero, theorem 2.2 would imply that all its zeros are isolated. But by hypothesis, these zeros have an accumulation point $z_0 in D$. This is a contradiction. Thus, $h$ is identically zero on $D$, and therefore $f(z) eq.triple g(z)$ on $D$.

=== Reformulation of a Isolated Zero (Corollary 2.4)
Take $f$ an analytical function defined on a path-connected open subset $D subset.eq CC$. If there exists a point $z_0 in D$ such as $f(z_0) != 0$, then the zeros of $f$ are isolated.
#def_block([*Interpretation:* This corollary states that if an analytical function *has at least one point in its domain where it is non-zero*, then all of its zeros must be isolated points. This means that *around each zero, there exists a neighborhood where no other zeros exist*. This property is crucial for understanding the behavior of analytical functions and their zeros in complex analysis.])

#block()#block()
#block(
  fill: block_colors.extra,
  outset: 10pt,
  radius: 5pt,
  [

#note_block(block_colors.extra)[
  This block is not that important, but may help for understanding series and functions convergence.
]

== Appendix for Power Series // Not an important section
=== Convergence of Series
==== Convergence of a Series (Definition 2.6)
A series $sum_(n>=0) a_n$ with $a_n in CC$ is said to *converge* if the sequence of its partial sums $S_N = sum_(n=0)^N a_n$ converges to a limit $S$ in $CC$ as $N$ approaches infinity. In this case, we write :
$ sum_(n=0)^infinity a_n = S $

==== Simple Convergence (Definition 2.7)
We say that a series *converges simply* and that its sum is $s^*$, if the the limit $lim_(n -> infinity) s_n = s^*$ exists.

==== Absolute Convergence (Definition 2.8)
A series $sum_(n>=0) a_n$ with $a_n in CC$ is said to *converge absolutely* if the series of the absolute values $sum_(n>=0) |a_n|$ converges. If a series converges absolutely, it also converges simply.
$ sum_(k=0)^n |a_k| <= M $
For some bound $M > 0$ and all $n in NN$. And for any $n$ :
$ sum_(k>=0) |a_k| < infinity $

==== Absolute Convergence Properties (Proposition 2.7)
If a series $sum_(n>=0) a_n$ with $a_n in CC$ converges absolutely, then :
- It converges simply : $s^* = lim_(n -> infinity) s_n$ exists.
- For any permutation of the terms $sigma : NN -> NN$, the series $sum_(n>=0) a_(sigma(n))$ converges absolutely and simply to the same limit $s^*$.
- The series converges unconditionally for any permutation of the terms $sigma : NN -> NN$, $lim_(n->infinity) sum_(k=0)^n a_k = lim_(n->infinity) sum_(k=0)^n a_(sigma(k))$

=== Convergence of Functions
==== Series of Functions (Definition 2.9)
A series of functions $sum_(n>=0) f_n$ defined on a set $A$ with values in $CC$ is said to *converge pointwise* on $A$ if for every point $x in A$, the sequence of partial sums $S_N(x) = sum_(n=0)^N f_n(x)$ converges. We then define its limit as :
$ f(x) = lim_(N->infinity) S_N(x) = lim_(N->infinity) sum_(n=0)^N f_n(x) $

==== Convergence of a Series of Functions (Proposition 2.8)
Take subset $A subset CC$ and a series of continuous functions $f_n : A -> CC$. If the sequence of partial sums $S_N = sum_(n=0)^N f_n$ converges uniformly towards a function $f : A -> CC$ on $A$, then $f$ is continuous on $A$.
])
// ==============================================================================================
// Exponential Function (p 41)
// ==============================================================================================
#block()#block()#block()
#block(
  fill: block_colors.extra,
  outset: 10pt,
  radius: 5pt,
  [

#note_block(block_colors.extra)[
  This block is not that important, but may help for understanding series and functions convergence.
]

= Exponential Function
== Complex Exponential
=== Definition of the Exponential Function (Definition 3.1)
The complex exponential function $exp : CC -> CC$ is defined by the power series :
$ exp(z) = e^z = sum_(n>=0) 1/n! z^n $
We can see from proposition 2.6 that the radius of convergence is infinite, thus the series converges for all $z in CC$.

=== Derivative of the Exponential Function (Proposition 3.1)
The complex exponential function is holomorphic on $CC$, and its complex derivative is given by :
$ exp'(z) = exp(z) $
$ (sum_(n>=0) 1/n! z^n)' = sum_(n>=1) n/n! z^(n-1) = sum_(n>=1) 1/(n-1)! z^(n-1) = sum_(n>=0) 1/n! z^n $

=== Inverse and Unary Points of the Exponential Function (Proposition 3.2)
Let us deriva the expressions $exp(-z) = 1/(exp(z))$ and $exp(0)=1$. From the definition by power series, we directly have $exp(0)=1$. We now consider the function :
$ g(z) = exp(z) exp(-z) $
Its derivative is null everywhere :
$ g'(z) = exp'(z) exp(-z) + exp(z) exp'(-z) = exp(z) exp(-z) - exp(z) exp(-z) = 0 $
Thus, $g$ is constant. Evaluating at $z=0$ gives $g(0)=1$, and therefore :
$ exp(z) exp(-z) = 1 $
In particular, $exp(z) != 0$ for all $z in CC$, and so $exp(-z) = 1/(exp(z))$.

=== Multiplication of the Exponential Function (Proposition 3.3)
For any $z, w in CC$, we have :
$ exp(z + w) = exp(z) exp(w) $
*Proof* : For a fixed $w$, we define the function :
$ h(z) = exp(z + w) exp(-z) $
$ h'(z) = exp(z+w)exp(-z) - exp(z+w)exp(-z) = 0 $
Meaning the function does not depend on $z$. Evaluating at $z=0$ gives $h(z)=h(0)=exp(w)$. Thus :
$ exp(z+w) exp(-z) = exp(w) $
Multiplying by $exp(z)$ gives the result.

=== Unique function with its own derivative (Proposition 3.4)
The complex exponential function is the unique holomorphic function $f:CC->CC$ such that :
- $f'(z) = f(z)$ for all $z in CC$
- $f(0) = 1$

=== Trigonometric Complex Functions (Corrolaire 3.1)
We can define the complex exponential as :
$ exp(x + i y) = exp(x) exp(i y) = exp(x) (cos(y) + i sin(y)) $
This is verified by proposition 3.4.

== Trigonometric and Hyperbolic Functions
=== Definitions of Trigonometric Functions (Definition 3.2)
$ sin(z) =(e^(i z) - e^(- i z))/(2 i) $
$ cos(z) =(e^(i z) + e^(- i z))/2 $

=== Definitions of Hyperbolic Functions (Definition 3.3)
$ sinh(z) =(e^z - e^(-z))/2 $
$ cosh(z) =(e^z + e^(-z))/2 $

])

// ==============================================================================================
// Complex Integration (p 45)
// ==============================================================================================
= Complex Integration
== Definition
=== Definition of a Integrated Path (Definition 4.1)
Let us define a path function $gamma : [a, b] -> CC$ that is continuous and piecewise continuously differentiable. And $f$ a continuous function defined on the image of $gamma$. The *complex integral* of $f$ along the path $gamma$ is defined as :
$ integral_gamma f(z) dif z = integral_a^b f(gamma(t)) gamma'(t) dif t $
We can also expand the definition to a path composed of multiple segments.
$ integral_gamma f = integral_gamma f(z) dif z = sum_(k=1)^n integral_(c_(k-1))^(c_k) f(gamma_k (t)) gamma'_k (t) dif t $
Where $gamma_k : [c_(k-1), c_k] -> CC$ are the segments of the path.
#def_block([*Interpretation:* This definition formalizes the concept of integrating a complex-valued function along a specified path in the complex plane. The integral is computed by parameterizing the path and integrating the function with respect to the parameter. This allows us to evaluate integrals of complex functions over curves, which is fundamental in complex analysis.])

=== Basic Properties of Complex Integrals (Proposition 4.1)
  1. *Linearity* : For any complex numbers $alpha, beta in CC$ and continuous functions $f, g$ defined on the image of $gamma$ :
$ integral_gamma (alpha f(z) + beta g(z)) dif z = alpha integral_gamma f(z) dif z + beta integral_gamma g(z) dif z $
  2. *Borne* : If there exists a constant $M > 0$ such that $|f(z)| <= M$ for all $z$ in the image of $gamma$, then :
$ |integral_gamma f(z) dif z| <= M "length"(gamma) $
  3. *Limit of Integration Path* : From a series of functions $f_k$, and a function $f$, all continuous on the image of $gamma$, if $f_k$ converges uniformly to $f$ on the image of $gamma$, then :
$ lim_(k->infinity) integral_gamma f_k(z) dif z = integral_gamma f(z) dif z $
#def_block([*Interpretation:* These properties establish fundamental characteristics of complex integrals. Linearity allows us to break down integrals of linear combinations of functions. The bound property provides a way to estimate the magnitude of the integral based on the maximum value of the function and the length of the path. The limit property ensures that we can interchange limits and integrals under uniform convergence, which is crucial for analyzing sequences of functions in complex analysis.])

== Integral of a Derivative
=== Integral of a Complex Derivative (Theorem 4.1)
Let $f : A -> CC$ be a continuous function defined on the open subset $A subset CC$, and that is the complex derivative of a function $F : A -> CC$. For any path $Gamma$ contained in $A$ in the sense of definition 4.1, represented by a function $gamma : [a, b] -> A$, we have :
$ integral_Gamma f(z) dif z = F(gamma(b)) - F(gamma(a)) $

Further more, if $Gamma$ is a closed path (i.e., $gamma(a) = gamma(b)$), then :
$ integral_Gamma f(z) dif z = 0 $
#def_block([*Interpretation:* This theorem states that if a function $f$ is the complex derivative of another function $F$, then the integral of $f$ along any path in its domain can be computed using the values of $F$ at the endpoints of the path. This is a direct analogue of the Fundamental Theorem of Calculus in real analysis. Additionally, if the path is closed, the integral evaluates to zero, reflecting the fact that the net change around a closed loop is zero for functions with antiderivatives. This property is fundamental in complex analysis and has important implications for contour integration and Cauchy's integral theorem.])
#note_block(block_colors.note)[
  The concept of open set is crucial here to ensure that the *path remains within the domain of definition* of $f$ and $F$. If the path were to exit the domain, the integral might not be well-defined, and the theorem would not hold. (It is the condition that allows us to use the definition of complex derivative everywhere on the path.)
]

=== Integral around a Singularity (Example 4.5)
We consider the function $f(z) = 1/(z - omega)$, where $omega in CC$. This function is holomorphic on $CC_(backslash {omega})$, and has a singularity at $z = omega$. We will compute the integral of $f$ along a closed circular path $Gamma$ centered at $omega$.
$ integral_(partial B(omega, r)) 1/(z-omega) dif z = 2 pi i $

*Proof* : We parametrize the circle $partial B(omega, r)$ by $gamma(t) = omega + r e^(i t)$ for $t in [0, 2pi]$. Then $gamma'(t) = i r e^(i t)$, and we compute directly:
$ integral_(partial B(omega, r)) 1/(z-omega) dif z = integral_0^(2pi) 1/(r e^(i t)) dot i r e^(i t) dif t = integral_0^(2pi) i dif t = 2 pi i $

#note_block(block_colors.note)[
  This result does not contradict Theorem 4.1. The function $f(z) = 1/(z - omega)$ is indeed holomorphic on $CC_(backslash {omega})$, but its antiderivative $F(z) = log(z - omega)$ is *not single-valued* on any domain that encircles $omega$. The logarithm is a *multivalued function*, and going around the singularity once increases its value by $2 pi i$. Thus, the hypothesis of Theorem 4.1 — that $f$ is the derivative of a *well-defined* function $F$ on the domain containing the path — is not satisfied.
]

#note_block(block_colors.extra)[ *Alternative Proof using Series Expansion*\
We can also prove this result using power series. Consider the expansion:
$ 1/(1 - epsilon) = sum_(n>=0) epsilon^n ", " forall |epsilon| < 1 $

For $|z| > |omega|$, we can write:
$ 1/(z - omega) = 1/z dot 1/(1 - omega/z) = 1/z sum_(n>=0) (omega/z)^n = sum_(n>=0) omega^n / z^(n+1) $

Integrating term by term on the closed path $partial B(0, r)$ with $r > |omega|$:
$ integral_(partial B(0, r)) 1/(z - omega) dif z = sum_(n>=0) omega^n integral_(partial B(0, r)) 1/z^(n+1) dif z $

By Theorem 4.1, for $n >= 1$, the function $1/z^(n+1)$ has an antiderivative $-1/(n z^n)$ which is holomorphic on $CC_(backslash {0})$. Since the path $partial B(0, r)$ is closed and lies entirely in this domain, these integrals vanish:
$ integral_(partial B(0, r)) 1/z^(n+1) dif z = 0 ", " forall n >= 1 $

Only the $n = 0$ term survives, which corresponds to integrating $1/z$:
$ integral_(partial B(0, r)) 1/(z - omega) dif z = integral_(partial B(0, r)) 1/z dif z = 2 pi i $

]
#def_block([*Interpretation:* The function $1/z$ is special: it is holomorphic everywhere except at the origin, yet it has no single-valued antiderivative on any domain encircling the origin. This is the fundamental reason why its integral around a closed loop is non-zero. All other terms $1/z^(n+1)$ for $n >= 1$ do have holomorphic antiderivatives, so their integrals vanish by Theorem 4.1. This example foreshadows the *Residue Theorem*, where the coefficient of $1/(z - omega)$ in a Laurent series (called the *residue*) determines the value of contour integrals.])

#note_block(block_colors.note)[
  This calculation is the prototype of the residue phenomenon: for any Laurent expansion around the singularity
  only the $(z-c)^(-1)$ term survives integration; its coefficient is the residue and determines the integral.
]

== Derivative of integrals and Primitivation
If we can reconstruct a function  $F$ from its derivative $f = F'$, following theorem 4.1, for a certain path. Then, we can attempt to build $F$ from any path. And in particular, we can try to find the simplest path, which is the straight line segment between two points.\

For simplicity, we will consider $A$ a starred open subset of $CC$ with center $z_0 in A$. Meaning that for any $z in A$, the segment $[z_0, z]$ is contained in $A$. (More powerful than path-connectedness.) We then define :

$ F(z) = integral_( [z_0, z] ) f(w) dif w $
#def_block([
  We define a *starred open subset* as a set $A$ of center $z_0$, where for any point $z in A$, the straight segment $[z_0,z]$ is contained within $A$.
])

From this, we only have to prove that $F(z)$ is complex differentiable and that its derivative is $f(z)$.

$ lim_(delta->0) (F(z+delta) - F(z))/delta = lim_(delta->0) 1/delta (integral_( [z_0, z+delta] ) f(w) dif w - integral_( [z_0, z] ) f(w) dif w) $

This expression is *not easy to analyze, as we are comparing two integrals over different paths*. However, if we can express these integral over the path $[z, z+delta]$, we can simplify the expression. This comes back to using certain hypotheses, and *integrating over a triangle formed by the points $z_0, z, z+delta$*. This is the object of Cauchy-Goursat theorem.

=== Cauchy-Goursat Lemma (Lemma 4.1)
Take $A subset CC$ a starred open subset, and $f : A -> CC$ an differentiable function. For any 3 points $z_1, z_2, z_3 in A$, we define the triangle $Delta$ formed by these 3 points, and entirely contained in $A$. Then, the integral of $f$ along the boundary of this triangle is zero :
$ integral_(partial Delta) f(z) dif z = 0 $
#def_block([*Interpretation:* This lemma states that for a differentiable function defined on a starred open subset of the complex plane, the integral of the function around the boundary of any triangle *whose full interior is contained in the domain* is zero. This is a specific case of the more general Cauchy-Goursat theorem. It does *not* mean that every closed contour contained in an arbitrary holomorphy domain has zero integral: for that, the contour must also be deformable to a point inside the domain, or we need a stronger condition such as simple connectedness.])

#note_block(block_colors.note)[
  The triangle must fit entirely in $A subset CC$ for the theorem to hold. This is why we required $A$ to be a *starred* open subset.
]

=== Primitivation of Holomorphic Functions (Theorem 4.2)
Take $A subset CC$ a starred open subset, and $f : A -> CC$ a holomorphic function. Then, the function $F : A -> CC$ defined by :
$ F(z) = integral_( [z_0, z] ) f(w) dif w $
Is a primitive of $f$ on $A$, meaning that $F$ is holomorphic on $A$ and :
$ F'(z) = f(z) ", " forall z in A $

#def_block([*Interpretation:* This theorem states that for a holomorphic function defined on a starred open subset of the complex plane, we can construct a primitive (antiderivative) by integrating the function along straight line segments from a fixed point to any point in the subset. The resulting function $F$ is also holomorphic, and its derivative is equal to the original function $f$. This result is significant because it *guarantees the existence of primitives for holomorphic functions in such domains*, which is a key aspect of complex analysis and has important implications for contour integration and the study of analytic functions.])

*Proof* : We need to show that the limit defining $F'(z)$ exists and equals $f(z)$:
$ F'(z) = lim_(delta -> 0) (F(z + delta) - F(z))/delta = lim_(delta -> 0) 1/delta (integral_([z_0, z+delta]) f(xi) dif xi - integral_([z_0, z]) f(xi) dif xi) $

For $delta$ small enough, the ball $B(z, |delta|) subset A$ (since $A$ is open). Because $A$ is starred, the triangle with vertices $z_0, z, z+delta$ lies entirely in $A$. By Lemma 4.1 (Cauchy-Goursat), the integral around this triangle is zero, so:
$ integral_([z_0, z+delta]) f(xi) dif xi - integral_([z_0, z]) f(xi) dif xi = integral_([z, z+delta]) f(xi) dif xi $

Therefore:
$ F'(z) = lim_(delta -> 0) (integral_([z, z+delta]) f(xi) dif xi)/delta $

Now we decompose $f(xi) = f(z) + (f(xi) - f(z))$:
$ F'(z) = lim_(delta -> 0) (integral_([z, z+delta]) f(z) dif xi)/delta + lim_(delta -> 0) (integral_([z, z+delta]) (f(xi) - f(z)) dif xi)/delta $

The first term simplifies (since $f(z)$ is constant with respect to $xi$):
$ lim_(delta -> 0) (f(z) dot delta)/delta = f(z) $

For the second term, we use the continuity of $f$: for any $epsilon > 0$, there exists $delta_0 > 0$ such that $|f(xi) - f(z)| < epsilon$ for all $xi in B(z, delta_0)$. By Proposition 4.1 (bound property):
$ |integral_([z, z+delta]) (f(xi) - f(z)) dif xi| <= epsilon dot |delta| $

Thus:
$ |(integral_([z, z+delta]) (f(xi) - f(z)) dif xi)/delta| <= epsilon $

Since $epsilon$ is arbitrary, this term tends to zero, and we conclude $F'(z) = f(z)$.

#def_block([*Interpretation:* This proof shows why starred domains are essential: the Cauchy-Goursat lemma allows us to replace the difference of two path integrals by a single integral over a short segment $[z, z+delta]$. The continuity of $f$ then ensures that $f(xi) approx f(z)$ on this short segment, giving us the derivative.])

#note_block(block_colors.note)[#block()
  Since $epsilon$ can be taken as small as we want, the proof is complete.#block()

We now conclude that every differentiable function on a star-shaped open set
has an antiderivative. This antiderivative is differentiable by definition,
so it also has its own antiderivative.#block()

By repeating this argument, we see that *every differentiable function is
indefinitely integrable*. From this, we get the next corollary, and we will
later present a more general form of it.
]

=== Infinite Integrability of Holomorphic Functions (Corollary 4.1)
A holomorphic function $f : A -> CC$ defined on a starred open subset $A subset CC$ is infinitely integrable. Then, the integral of $f$ along any closed path $Gamma$ contained in $A$ is zero. This is particularly true for *any convex* open subset of $CC$ (As it is by definition starred).

#def_block([*Interpretation:* This corollary states that for a holomorphic function defined on a starred open subset of the complex plane, the *integral of the function along any closed path within that subset is zero*. This is a direct consequence of the *existence of primitives for holomorphic functions in such domains*, as established in Theorem 4.2. The result is particularly significant for *convex open subsets, which are always starred*, ensuring that holomorphic functions defined on these sets have this property. This property is fundamental in complex analysis and has important implications for contour integration and the study of analytic functions.])

== Homotopy of Paths
This section is all about generalization and simplification of the integral calculations by using simpler paths.\

The theorem 4.2 used the *stared set hypotesis*, which is sometimes too strong. We also know that *the result is not true for any open set $A$*, as shown by the example 4.5. We will now introduce a more general condition on the paths, called *homotopy*. W will be using Goursat's lemma to prove the results. What is important is the property to be able to re-write the integral into many more simpler integrals. We define $f$ as holomorphic not only at the edges of the triangle, but also inside it. We then can generalise the lemma 4.1 to closed paths that are well defined in the "interior of the path" (which is hard to correctly define).

#note_block(block_colors.extra)[
  Let's begin with a simple picture to understand a big idea. Imagine a #strong[closed curve], which we'll call $gamma$. Think of it as a loop on the ground. Now, place a #strong[string] perfectly along this loop and tie the ends together.#block()

  Now, imagine you start #strong[pulling the loop] from all sides to gather it into a #strong[single point]. As you pull, the string must pass through every point inside the original loop. But what if a #strong[stake] was stuck in the ground inside the loop? The string would get stuck. You couldn't pull it to a single point. This stake represents a point where our function $f$ is #strong[NOT well-behaved].#block()

  #strong[The key idea is this:] For our math to work, the function $f$ must be well-behaved at every single point the string touches during this pulling process. To describe this "pulling process" with math, we use a special tool called a #strong[homotopy].#block()

  A homotopy is a function, written as $Gamma: [0,1] times [0,1] -> A$, that describes the entire pulling process. It's like a movie showing the loop shrinking to a point.
  *   The parameter $t$ tells us #strong[where we are] on the string.
  *   The parameter $s in [0,1]$ tells us #strong[what time it is] in the movie ($s=0$ is the start, $s=1$ is the end).#block()

  For this to be a valid "pulling process," it must follow four simple rules:
  1.  #strong[Starts right:] At the beginning ($s=0$), it must be our original curve, $Gamma(t, 0) = gamma(t)$.
  2.  #strong[Ends right:] At the end ($s=1$), it must be a single point, $Gamma(t, 1) = z_0$.
  3.  #strong[Stays a loop:] It can never come untied. The start and end of the string must always be in the same place, $Gamma(0, s) = Gamma(1, s)$.
  4.  #strong[No jumps:] The pulling must be smooth. The function $Gamma$ must be #strong[continuous].#block()

  If we can find such a homotopy where the string #strong[never leaves] a safe region $A$, we say that the curve $gamma$ is #strong[homotopic to a point] inside $A$.#block()

  #strong[This leads to a powerful result:] The integral of a #strong[holomorphic function] (a very well-behaved function) over a closed curve that is homotopic to a point is #strong[always zero]. We will use this idea to prove even more general results that make complex calculations much simpler.
]

=== Homotopic Paths (Definition 4.2)
In a non empty subset $A subset CC$, we say that a closed path $gamma : [0, 1] -> A$ is *homotopic to a point in $A$* if there exists a continuous function (homotopy) $Gamma : [0, 1] times [0, 1] -> A$ such that :
- $Gamma(t, 0) = gamma(t)$ for all $t in [0, 1]$ (Initial condition)
- $Gamma(t, 1) = z_0$ for all $t in [0, 1]$ and some $z_0 in A$ (Final condition)
- $Gamma(0, s) = Gamma(1, s)$ for all $s in [0, 1]$ (Closed path condition)

#def_block([*Interpretation:* This definition formalizes the concept of a closed path being "shrinkable" to a single point within a given subset of the complex plane. The homotopy $Gamma$ represents a continuous deformation of the path $gamma$ over time, starting from the original path and ending at a single point. The conditions ensure that the path remains closed throughout the deformation and that the entire process stays within the subset $A$. This concept is crucial in complex analysis, particularly in the study of contour integrals and their properties.])

More generally, two closed paths $gamma_0, gamma_1 : [0,1] -> A$ are said to be *homotopic in $A$* if there exists a continuous function $Gamma : [0,1] times [0,1] -> A$ such that $Gamma(t,0)=gamma_0(t)$, $Gamma(t,1)=gamma_1(t)$ and $Gamma(0,s)=Gamma(1,s)$ for all $s in [0,1]$.

=== Heine's Theorem (Theorem 4.3)
A continuous function defined on a compact metric space is uniformly continuous.\

In particular, the homotopies that aim at definition 4.2 are uniformly continuous :
$ forall epsilon > 0, exists delta >0, "such that" |Gamma(t,s)-Gamma(t',s')| <= epsilon "whenever" |(t,s)-(t',s')| <= delta $

#note_block(block_colors.note)[
  Note that any closed path contained in a convex subset of $CC$ is homotopic to a point, as we can always define a homotopy that linearly shrinks the path to a fixed point of the set.
  $ Gamma(t, s) = (1 - s) . gamma(t) + s . z_0 $
]

=== Invariance of the integral under Homotopy (Theorem 4.4) (Generalization 1 of Goursat's lemma)
Take a open non empty subset $A subset CC$ and a holomorphic function $f : A -> CC$. For any two piecewise $C^1$ closed paths $gamma_0, gamma_1 : [0, 1] -> A$ that are homotopic in $A$, we have :
$ integral_(gamma_0) f = integral_(gamma_1) f $
In particular, the integral along a closed path (or contour) homotopic to a point is zero :
$ integral_(gamma) f = 0 $

#def_block([*Interpretation:* This theorem states that the integral of a holomorphic function does not change when the integration path is continuously deformed inside the domain without crossing a point where the function is not holomorphic. In particular, if a closed path can be shrunk to a point while staying inside the domain, its integral is zero. This is why holes and singularities matter: if the path cannot be contracted without crossing one, the integral may be non-zero.])

*Proof* : Omitted for brevity. (p. 56 to 58)

=== Simply Connected Sets (Definition 4.3)
A non empty open subset $A subset CC$ is said to be *simply connected* if it is polygonally connected and every closed path $gamma : [0, 1] -> A$ is homotopic to a point in $A$.

#def_block([*Interpretation:* A simply connected set is a type of domain in the complex plane that is "hole-free." This means that any closed loop within the set can be continuously shrunk to a single point without leaving the set. The requirement for polygonal connectivity ensures that any two points in the set can be connected by a path made up of straight line segments, which is a stronger condition than just being path-connected. Simply connected sets are important in complex analysis because they allow for the application of powerful theorems, such as Cauchy's integral theorem and the existence of primitives for holomorphic functions. These properties make simply connected domains particularly nice to work with when studying complex functions.])

#note_block(block_colors.note)[
  From the string metaphore, a simply connected set is a set where any loop of string can be shrunk to a point without getting caught on any obstacles (holes) in the set.
]

=== Primitivation of Holomorphic Functions on Simply Connected Sets (Theorem 4.5) (Generalization 2 of Goursat's lemma)
Take function $f : A -> CC$ a holomorphic function on the open simply connected subset $A subset.eq CC$. Then, there exists a function $F : A-> CC$ differentiable such as $F'=f$. For any piecewise $C^1$ path contained in $A$ ($gamma subset A$), with both of its ends $z_1, z_2$ also contained in $A$ :
$ integral_(gamma) f(z) dif z = F(z_2) - F(z_1) $
#def_block([*Interpretation:* This theorem states that for a holomorphic function defined on a simply connected open subset of the complex plane, there exists a differentiable function $F$ such that its derivative is equal to the original function $f$. This means that $F$ serves as an antiderivative or primitive of $f$. The integral of $f$ along any path within the subset can be computed using the values of $F$ at the endpoints of the path. This result is significant because it generalizes the concept of primitives to more complex domains, allowing for the evaluation of integrals in a broader context. It also highlights the importance of simply connected domains in complex analysis, as they ensure the existence of such primitives for holomorphic functions. ])
*Proof* : Omitted for brevity. (p. 59 to 60)

== Appendix
These are valid for metric spaces in general, not only for $CC$. (not seen in the course)
=== Compact Set (Lemme 4.2)
A subset $K subset CC$ is *compact* (closed and bounded) and $F subset CC$ is closed. if $K$ and $F$ are disjoint and non empty. Then the distance between $K$ and $F$ is strictly positive :
$ d(K, F) = inf_(z in K, w in F) |z - w| > 0 $
#def_block([*Interpretation:* This lemma states that if you have a compact set $K$ (which is both closed and bounded) and a closed set $F$ in the complex plane, and these two sets do not overlap (are disjoint), then there is a positive minimum distance between any point in $K$ and any point in $F$. In other words, you can always find a small buffer zone between the two sets. This property is important in analysis because it ensures that disjoint sets can be separated by a non-zero distance, which can be useful in various proofs and applications, such as in the study of continuous functions and convergence.])

=== (Lemma 4.3)
Omitted, as pointless (just means that the set is compact if filled with balls of radius r).

// ==============================================================================================
// Representations of Complex Functions (p 65)
// ==============================================================================================
= Representations of Complex Functions
== Analysis and exploration of the question
#todo_block()

== Generalisation of the Primitivation results
This section generalises Goursat's lemma and the primitivation results by allowing one exceptional point where complex differentiability may fail, while keeping continuity at that point.
=== Generalised Goursat's lemma (Lemme 5.1)
Take $A subset CC$ an open subset, a point $c in A$, and a function $f : A -> CC$ *continuous on $A$ and holomorphic on $A_(\\{c})$*. And 3 points $z_1, z_2, z_3 in A$ such that the full triangle $Delta$ formed by these 3 points is entirely contained in $A$. Then, the integral of $f$ along the boundary of this triangle is zero :
$ integral_(partial Delta) f(z) dif z = 0 $
#def_block([*Interpretation:* This lemma extends the original Goursat's lemma by allowing *one exceptional point $c$ where $f$ may fail to be complex differentiable*, as long as $f$ remains *continuous at that point*. The triangle, including its interior, must still remain inside the domain $A$. So this result does not allow a true hole or an isolated singularity inside the triangle: the exceptional point belongs to the domain and the function is still defined and continuous there.])

#note_block(block_colors.warning)[
  The important difference is between an *exceptional differentiability point* and a *hole/singularity*.
  - Here $c in A$ and $f$ is continuous at $c$.
  - If $f$ is not defined at $c$, or becomes unbounded there, the lemma cannot be used directly.

  For example, it cannot be used to conclude that $integral 1/z dif z=0$ around a triangle enclosing $0$, because $1/z$ is not continuous or even defined at $0$.
]

*Proof* : #block()
If $c$ does not belong to the triangle, this is exactly lemma 4.1. If $c$ belongs to the triangle, we subdivide $Delta$ into smaller triangles around $c$. On every part that avoids $c$, lemma 4.1 applies. The internal edges cancel each other, and the only remaining terms are integrals along small segments surrounding $c$.

Since $f$ is continuous at $c$, it is bounded in a small neighborhood of $c$: there exists $M>0$ such that $|f(z)|<=M$ there. By proposition 4.1, the modulus of every remaining integral is bounded by $M$ times the length of its small segment. When these segments are shrunk towards $c$, their total length tends to zero. Therefore their total integral tends to zero, and we obtain :
$ integral_(partial Delta) f(z) dif z = 0 $

=== Generalisation of Theorem 4.2 (Theorem 5.1)
Take $A subset CC$ a stared open subset with center $z_0 in A$, a point $c in A$, and a function $f : A -> CC$ *continuous on $A$ and holomorphic on $A_(\\{c})$*. Then, the function $F : A -> CC$ defined by :
$ F(z) = integral_( [z_0, z] ) f(w) dif w $
Is a primitive of $f$ on $A$, meaning that $F$ is holomorphic on $A$ and :
$ F'(z) = f(z) ", " forall z in A $

#note_block(block_colors.note)[
  The difference from Theorem 4.2 is that $f$ is allowed to fail to be complex differentiable at *one point $c$*, but it must remain *continuous there*.

  Lemma 5.1 is used because the triangle formed by $z_0$, $z$ and $z+delta$ may contain the exceptional point $c$. Since the function is continuous at $c$, the triangle integral is still zero and the proof of Theorem 4.2 continues to work.
]

== Representation Theorem
=== Caunchy Integral Formula (Theorem 5.2)
Take $A subset CC$ an open subset, and $f : A -> CC$ a holomorphic function. For any closed disk $B[z_0, r] subset A$, and any point $z in B(z_0, r)$, we have :
$ f(z) = 1/(2 pi i) integral_(partial B[z_0, r]) f(w)/(w - z) dif w $

#def_block([
  *Interpretation:*
  Cauchy's integral formula tells us something very simple and very strong:
  if a function is holomorphic on a disk and its boundary, then the value of
  the function at any point inside the disk can be computed from an integral
  over the boundary.
  The formula says: to get $f(z)$, you take an integral of $f(w)$ divided by
  $w - z$ around the boundary circle.

  This idea is important because it *shows that the values of a holomorphic
  function inside a region are completely controlled by its values on the
  boundary*.
])
*Proof* : #block()
Fixing $z$, we define the function $g$ as :
$ g(w) = cases(
  (f(w)-f(z))/(w-z) " " & w != z,
  f'(z) " " & w = z,
) $
For $w != z$, the function $g$ is holomorphic. Moreover, from the definition of the complex derivative :
$ lim_(w->z) (f(w)-f(z))/(w-z) = f'(z) $
Thus, $g$ is continuous at $z$. Since the closed disk $B[z_0,r]$ is contained in the open set $A$, we can choose a slightly larger open disk $B(z_0,R) subset A$ with $R>r$. We can therefore use theorem 5.1 on this larger disk: $g$ is continuous everywhere and holomorphic except possibly at the single point $z$. Hence, its integral along the closed path $partial B[z_0,r]$ is zero :
$ integral_(partial B[z_0, r]) g(w) dif w  = integral_(partial B[z_0, r]) (f(w) -f(z))/(w - z) dif w = 0 $
From here, we isolate the term with $f(z)$ :
$ integral_(partial B[z_0, r]) f(w)/(w - z) dif w - f(z) integral_(partial B[z_0, r]) 1/(w - z) dif w = 0 $
We then use example 4.5 to evaluate the second integral :
$ integral_(partial B[z_0, r]) 1/(w - z) dif w = 2 pi i $
Thus, we get :
$ integral_(partial B[z_0, r]) f(w)/(w - z) dif w = integral_(partial B[z_0, r]) f(z)/(w - z) dif w = f(z) dot 2 pi i $
#note_block(block_colors.note)[
  The key point of this proof is the value assigned to $g$ at $w=z$. The difference quotient tends to $f'(z)$, so $g$ is continuous at the exceptional point and holomorphic everywhere else. Theorem 5.1 then tells us that $g$ still has a primitive on the disk, and therefore its integral around the boundary is zero. This avoids incorrectly treating the punctured disk as if the boundary circle were homotopic to a point inside it.
]

=== Representation Theorem (Theorem 5.3)
Take $A subset CC$ an open subset, and $f : A -> CC$ a holomorphic function with the ball $B[z_0, r] subset A$. Then, for any point $z in B(z_0, r)$, we have the power series representation :
$ f(z) = sum_(n=0)^infinity a_n (z - z_0)^n $
With the coefficients :
$ a_n = 1/(2 pi i) integral_(partial B[z_0, r]) f(w)/((w - z_0)^(n+1)) dif w $
Its convergence is uniform on any closed disk $B[z_0, r']$ with $0 < r' < r$ (convergence radius bigger or equal to $r$).

#note_block(block_colors.note)[
  In consequence, $f$ is analytic on $A$, and infinitely differentiable. with :
  $ f^((k)) (z) = (k!)/(2 pi i) integral_(partial B[z_0, r]) f(w)/((w - z)^(k+1)) dif w $
]
#def_block([*Interpretation:*
This theorem says something very important and very simple:

- Any *holomorphic function* can be written as a *power series*
  (a Taylor series).
- You choose a point inside a disk, and the function becomes a sum of powers
  of $(z - z_0)$.

The *coefficients* of this series come from *Cauchy's integral formula*:
they are integrals over the *boundary* of the disk.

*Why this matters:*
- Holomorphic functions are *infinitely differentiable*.
- Their values *inside* the disk are fully determined by their values on the
  *boundary*.
- This shows a strong link between *local behavior* and *global structure*
  in complex analysis.
])


=== Everything is Holomorphic (Corollary 5.1)
On a open subset $A subset CC$ and a point $z_0 in A$ :
- If $f$ is holomorphic on $A_(\\{z_0})$ and continuous at $z_0$, then $f$ is holomorphic on $A$.
- If $f$ is holomorphic on $A_(\\{z_0})$ and $lim_(z -> z_0) f(z)$ exists, then $f$ extends holomorphically to $A$.
We can now define *removable singularities* as points where the function can be extended holomorphically:
- The function $f : A -> CC$ defined by $tilde(f)(z) = f(z), forall z in A_(\\{z_0})$ and $tilde(f)(z_0) = lim_(z -> z_0) f(z)$ is holomorphic on $A$.

#def_block([*Interpretation:* This corollary states that if a function is holomorphic everywhere in an open subset of the complex plane except at a single point, and *if it is either continuous at that point or has a well-defined limit as it approaches that point*, then the function can be extended to be holomorphic at that point as well. This means that the singularity at that point is "removable," and we can redefine the function at that point to make it holomorphic throughout the entire domain. This result is significant because it shows that certain types of singularities do not fundamentally alter the holomorphic nature of a function, allowing for a more complete understanding of its behavior.])

== Consequences of the Fundamental Theorems
=== Liouville Theorem (Proposition 5.1)
Take $f$ a holomorphic function on $CC$. If $f$ is bounded, meaning that there exists a constant $M > 0$ such that :
$ |f(z)| <= M ", " forall z in CC $
Then, *$f$ is constant*.

#def_block([*Interpretation:* Liouville's theorem states that if a function is holomorphic (complex differentiable) everywhere in the complex plane and is bounded (does not grow beyond a certain fixed value), then the function must be constant. This result is significant because it highlights the restrictive nature of holomorphic functions: they cannot exhibit non-trivial behavior while remaining bounded across the entire complex plane. This theorem has important implications in complex analysis, particularly in understanding the behavior of entire functions and their growth properties.])
*Proof* : #block()
Fix a point $z in CC$. Since $f$ is entire, for every $r>0$ the closed disk $B[z,r]$ is contained in $CC$. By the representation theorem 5.3, we have :
$ f'(z) = 1/(2 pi i) integral_(partial B[z, r]) f(w)/((w - z)^2) dif w $
By taking the modulus and using the bound property of integrals (proposition 4.1), we get :
$ |f'(z)| <= 1/(2 pi) dot (2 pi r) dot M / r^2 = M / r $
Since this is true for any $r > 0$, we take the limit $r -> infinity$ and get $f'(z) = 0$. Thus, $f$ is constant.

=== Fundamental Theorem of Algebra (Theorem 5.4)
Any non constant polynomial $P(z) = a_n z^n + a_(n-1) z^(n-1) + ... + a_1 z + a_0$ with complex coefficients ($a_n != 0$) has *at least one root* in $CC$. We can then write :
$ p(z) = a product_(i=1)^n (z-z_i) $
With $z_1, z_2, ..., z_n$ the roots of $P$ in $CC$ (counted with multiplicity).

#def_block([*Interpretation:* The Fundamental Theorem of Algebra states that every non-constant polynomial with complex coefficients has at least one root in the complex plane. This means that no matter how complicated a non-constant polynomial is, the equation $P(z)=0$ always has at least one solution in the complex plane. The theorem also implies that a polynomial of degree $n$ can be factored into $n$ linear factors, corresponding to its roots, when counted with their multiplicities. This result is fundamental in algebra and complex analysis, as it guarantees the existence of solutions to polynomial equations in the complex number system.])
*Proof* : #block()
The idea of the proof is that if the polynomial had no roots, then its inverse would be a holomorphic bounded function on $bb(C)$, which is impossible by Liouville's theorem :
$ P(z) = a_n z^n + a_(n-1) z^(n-1) + dots + a_0 $
with $n >= 1$ and $a_n != 0$, and assume that $P(z) != 0, forall z in bb(C)$. We define $f(z) = 1 / P(z)$. Since $P(z) != 0$ on $bb(C)$, $f$ is holomorphic on
$bb(C)$. For $|z| -> infinity$  we write
$
P(z)
= z^n (a_n + underbrace(a_(n-1)/z + dots + a_0/z^n, [->" " 0 "as" |z| -> infinity])).
$
Hence there exists $R > 0$ such that for all $|z| >= R$,
$
|P(z)|
&= |z|^n |a_n + o(1)| \
&>= |z|^n (|a_n|) / 2.
$
Therefore, for all $|z| >= R$,
$
|f(z)|
&= 1 / (|P(z)|) \
&<= 2 / (|a_n| |z|^n).
$

On the other hand, $f$ is continuous on the compact (closed and bounded) set ${ z in bb(C) : |z| <= R }$, hence bounded there. Thus $f$ is bounded on $bb(C)$. By Liouville's theorem, $f$ is constant, which implies that $P$ is constant, contradicting $deg(P) >= 1$. Therefore $P$ has at least one root in $bb(C)$.

== Appendix
=== Uniform Convergence (Lemme 5.2)
A sequence of functions $f_n : A -> CC, forall n in NN$, and a function $f : A -> CC$ for a compact set $A subset CC$ such that $f_n$ converges uniformly to $f$ on $A$.

Then, for a function $g : A -> CC$ continuous on $A$, the sequence $g dot f_n$ converges uniformly to $g dot f$ on $A$.

// ==============================================================================================
// Laurent Series and Singularities (p 77)
// ==============================================================================================
= Laurent Series and Singularities
== Introduction
Laurent series are an extension of power series that allow for negative powers of $(z - z_0)$. We will be exploiting them to compute closed integrals around singularities, which is the residue theorem.

The previous chapter showed that holomorphic functions on $B(c, rho)$ can be represented by power series $sum_(n>=0) a_n (z-c)^n$. Howerver, the condition of the series being holomorphic on the whole disk is quite strong. As it does not allow us to represent functions with singularities (points where the function is not defined or not holomorphic). Laurent series come to the rescue by allowing us to represent functions that are holomorphic on an annulus (a ring-shaped region) around a singularity.

=== Open Annulus (Definition 6.1)
An *open annulus* centered at $z_0 in CC$ with inner radius $r_1 >= 0$ and outer radius $r_2 > r_1$ is the set :
$ A(z_0, r_1, r_2) = { z in CC : r_1 < |z - z_0| < r_2 } $

=== Extending the Representation Theorem to the Annulus
We can extend the representation theorem 5.3 to functions holomorphic on an annulus $A(c, r, s)$ (for simplicity, we will center it at 0).#block()

Let $f$ be a holomorphic function on the annulus $A(0, r, s)$, centered at 0. For any radius $tau in (r,s)$ and all $n in ZZ$, we define :
$ a_n = 1/(2 pi i) integral_(partial B(0, tau)) f(w)/(w^(n+1)) dif w $
By theorem 4.4, this coefficient does not depend on the particular circle chosen, as long as its radius remains between $r$ and $s$.

We want to show that $f(z)$ can be represented by the sum of a positive and negative power series :
$ f(z) = sum_(n in ZZ) a_n z^n = sum_(n>=0) a_n z^n + sum_(n>=1) a_(-n) z^(-n) $

Take a point $z in A(0,r,s)$. We choose two radii $sigma$ and $rho$ such that :
$ r < sigma < |z| < rho < s $

For the positive part, we use the outer circle $partial B(0,rho)$. Since $|z/w|<1$, we can use the geometric series :
$ sum_(n>=0) a_n z^n &= 1/(2 pi i) integral_(partial B(0, rho)) f(w)/w sum_(n>=0) (z/w)^n dif w &= 1/(2 pi i) integral_(partial B(0, rho)) f(w)/(w-z) dif w $

For the negative part, we use the inner circle $partial B(0,sigma)$. Since $|w/z|<1$, we get :
$ sum_(n>=1) a_(-n) z^(-n) &= 1/(2 pi i) integral_(partial B(0, sigma)) f(w)/z sum_(n>=0) (w/z)^n dif w &= 1/(2 pi i) integral_(partial B(0, sigma)) f(w)/(z-w) dif w &= -1/(2 pi i) integral_(partial B(0, sigma)) f(w)/(w-z) dif w $

By summing both parts, we get :
$ sum_(n>=0) a_n z^n + sum_(n>=1) a_(-n) z^(-n) = 1/(2 pi i) (integral_(partial B(0, rho)) f(w)/(w-z) dif w - integral_(partial B(0, sigma)) f(w)/(w-z) dif w) $

#note_block(block_colors.note)[
  Metaphorically, we have managed to punch away a hole into the original integrated circular domain, to form an annulus integration.
]
#note_block(block_colors.note)[
  The positive part is controlled by the *outer radius* $s$, while the negative part is controlled by the *inner radius* $r$. This is why a Laurent series naturally converges on an annulus instead of only on a disk.
]

From here, we have to *prove that this is equal* to $f(z)$. The first step is to combine the two integrals into one closed path $gamma$: the outer circle is traversed counterclockwise, the inner circle clockwise, and the two are connected by paths $lambda$ and $overline(lambda)$ that cancel each other.

#figure(
  image(
    "AC_diagrams/homotopic anulus gama.png",
    width: 25%,
  ),
  caption: [Homotopic path to a circle arround $z$. The integral along the path $gamma$ is equal to the integral along the differences of the two circles.]
)#block()

$ integral_(gamma) f(w)/(w-z) dif w = integral_(partial B(0,rho)) f(w)/(w-z) dif w - integral_(partial B(0,sigma)) f(w)/(w-z) dif w $

The function $f(w)/(w-z)$ is holomorphic on the annulus except at $w=z$. The path $gamma$ can be homotoped inside $A(0,r,s)_(\\{z})$ to a small positively oriented circle $partial B(z,epsilon)$ around $z$. By theorem 4.4, we get :
$ integral_(gamma) f(w)/(w-z) dif w = integral_(partial B(z,epsilon)) f(w)/(w-z) dif w = 2 pi i f(z) $

#figure(
  image(
    "AC_diagrams/homotopic anulus to small circle.png",
    width: 25%,
  ),
  caption: [Homotopic path to a small circle arround $z$. The integral along the path $gamma$ is equal to the integral along the small circle of radius $epsilon$.]
)#block()

Thus :
$ f(z) = sum_(n in ZZ) a_n z^n = sum_(n>=0) a_n z^n + sum_(n>=1) a_(-n) z^(-n) $

#def_block([
  This proof extends the theory of power series to *Laurent series* by permitting *negative powers*, thereby allowing analytic representations on annular domains. The important geometry is the choice $r < sigma < |z| < rho < s$: the outer circle produces the positive powers, while the inner circle produces the negative powers. Combining the two circles gives the positively oriented boundary of an annulus, which can then be deformed to a small circle around $z$. This establishes the Laurent representation throughout the annular region.
])

#note_block(block_colors.trick)[
  The concept of this proof, is that you can integrate on a annular domain on any of its points, by homotoping the boundary of the annulus to a small circle around the point. Its a bit like Goursat's lemma but for annulus instead of triangles. The path around the annulus is a combination of two circles in opposite directions, connected by paths that cancel each other out.
]

== Result on Laurent Series
=== Laurent Series Representation Theorem (Theorem 6.1)
Take a holomorphic function $f : A(c,r,s) -> CC$. Then, there exists one unique sequence of complex numbers $(a_n)_(n in ZZ)$ such as :
$ f(z) = sum_(n in ZZ) a_n (z - c)^n = sum_(n>=0) a_n (z - c)^n + sum_(n>=1) a_(-n) (z - c)^(-n) $
For any $z in A(c, r, s)$, with :
$ a_n = 1/(2 pi i) integral_(partial B(c, rho)) f(w)/((w - c)^(n+1)) dif w $
For any $rho in (r, s)$, and the convergence of these series is uniform on any compact set $A subset A(c, r, s)$.

#note_block(block_colors.note)[
  While the formula for $a_n$ is explicit, we often won't compute them directly. And, instead, we will often use only the therm $a_(-1)$ (the residue) in applications like the residue theorem to simplify calculations.
]

== Residue and Indices
In this section, we will use Laurent Series to simplify the resolution of integrals on closed contours. By taking advantage that the integral of all terms of the series are zero, except for the residue term $a_(-1)$ (the coefficient of the $(z - c)^{-1}$ term). #block()

Let us take the previous situation :

A function $f : A(c,r,s) -> CC$ holomorphic, integrated on the closed contour $gamma$ (enclosed in the support of $A(c,r,s)$). By the Laurent series representation theorem 6.1, we can write :
$ f(z) = sum_(n>=0) a_n (z - c)^n + sum_(n>=1) a_(-n) (z - c)^(-n) $
Since the convergence of both series is uniform on the compact set $A subset A(c,r,s)$ which is the support of $gamma$ (points of A that are on $gamma$). We can then use proposition 4.1 ro rewrite :
$ integral_(gamma) f = lim_(N->infinity) (sum_(k=0)^N a_k integral_gamma (z-c)^k dif z) + lim_(N->infinity) (sum_(k=1)^N a_(-k) integral_gamma (z-c)^(-k) dif z) = 0 + a_(-1) integral_gamma 1/(z-c) dif z $
The first term is zero because every $(z-c)^k$ with $k>=0$ has a primitive, and in the second term only $k=1$ survives, corresponding to the exponent $-1$. This allows us to *decouple the impact of the function*, represented by $a_(-1)$, from the impact of the path $integral_gamma 1/(z-c) dif z$.

#note_block(block_colors.note)[
  For a Laurent series $f(z)= sum_(n in ZZ) a_n (z-c)^n$ on an annulus,
  every power $(z-c)^n$ with $n != -1$ has a primitive off $c$ and therefore integrates to zero on any closed curve avoiding $c$.
  Thus only $a_(-1)$ contributes; this coefficient is called the residue: $"Res"(f,c)=a_(-1)$.
]

=== Residue Definition (Definition 6.2)
From a holomorphic function $f : A(c,r,s) -> CC$ on an annulus, the *residue* of $f$ at point $c$ is *written $"Res"(f, c)$* and defined as the coefficient $a_(-1)$ of the Laurent series expansion of $f$ around $c$. This one is well defined, as $a_(-1)$ is unique by theorem 6.1.

#def_block([
  The residue is the coefficient that measures the local contribution of the point $c$ to contour integrals. It is defined for any Laurent expansion around $c$, whether the singularity is removable, a pole, or essential. A removable singularity has residue $0$, while poles and essential singularities may have a non-zero residue.
])

=== Index Definition (Definition 6.3)
From a closed path $gamma : [a, b] -> CC$ and a point $c in CC$ excluded from the support of $gamma$ (not in the image/path of $gamma$), the *index* of $gamma$ around $c$ is *written $"Ind"(gamma, c)$* and defined as :
$ "Ind"(gamma, c) = 1/(2 pi i) integral_(gamma) 1/(z - c) dif z $
This index counts how many times the path $gamma$ winds around the point $c$, with orientation :
- $arrow.cw$ : negative index
- $arrow.ccw$ : positive index

#def_block([
  The index measures the winding of a closed path around a point in the complex plane. It quantifies how many times the path encircles the point, taking into account the direction of traversal (clockwise or counterclockwise). A positive index indicates counterclockwise winding, while a negative index indicates clockwise winding. This concept is crucial in complex analysis, particularly in the context of contour integrals and the residue theorem, as it helps determine the contribution of singularities enclosed by the path to the value of the integral.
])

=== Integrating along any closed path (Proposition 6.1)
Take a function $f : A(c,r,s) -> CC$ holomorphic on an annulus, and a closed path $gamma$ whose support is contained in $A(c,r,s)$. Then, the integral of $f$ along $gamma$ is given by :
$ integral_(gamma) f(z) dif z = 2 pi i dot "Ind"(gamma, c) dot "Res"(f, c) $
This result is also acceptable for $r=0$ and $s=infinity$

#def_block([
  This proposition establishes a powerful connection between the integral of a holomorphic function around a closed contour and two key concepts: the residue of the function at a singularity and the winding number (index) of the contour around that singularity. Specifically, it states that the integral of the function can be computed as the product of $2 \pi i$, the index of the contour around the point $c$, and the residue of the function at $c$. This result is significant because it allows for the evaluation of complex integrals by simply determining these two quantities, rather than performing potentially complicated integrations directly. The proposition is a cornerstone of complex analysis, particularly in the context of evaluating integrals using residues, and it highlights the deep interplay between local properties of functions (residues) and global properties of paths (indices).
])
*Proof* : #block()
The case $r = 0$ and $s = infinity$ can be handled without additional technical difficulty.

Since the function $gamma$ is continuous on the compact interval $[0, 1]$, the quantity $|gamma(t) - c|$ attains both a minimum and a maximum. In particular, $gamma$ stays at a positive distance from $c$, so its image is contained in an annulus centered at $c$.

As a consequence, we may always reduce the situation to an annulus whose inner and outer radii are fixed and finite. This justifies taking $r = 0$ and $s = infinity$ as the punctured-plane limiting case.

#note_block(block_colors.note)[
  The interest of this result lies in applications to complex integration. To make it effective, we need two tools:
  - the residue of a function,
  - and the index (or winding number) of a point with respect to a curve.

  While residues admit explicit formulas, the index is more geometric in nature. It is usually easy to compute in practice, but harder to define formally.

  A key observation is that any curve gamma that does not pass through c can be continuously deformed, without crossing c, into a curve lying on a circle centered at c. Such a deformation does not change the index.

  Therefore, when computing the index, it is enough to understand curves that lie on circles. The next exercise is designed to build intuition for this simpler case.
]

== Residue Theorem
=== Sum of Function w/o Residue (Corollaire 6.1)
Take a function $f : A(c,r,s) -> CC$ holomorphic on an annulus. Then, $f= F + G$ for two holomorphic functions :
- $F : B(c,s) -> CC$ holomorphic on the ball of radius $s$.
- $G : (CC \ B[c,r]) -> CC$ holomorphic outside the closed ball of radius $r$.
More over :
- $ "Res"(G, c) = "Res"(f, c) $
- $ "Res"(F, c) = 0 $

#def_block([
  This corollary states that any holomorphic function defined on an annulus can be *decomposed into two separate holomorphic functions*: the positive-power part $F$, which extends holomorphically throughout the disk of outer radius $s$, and the negative-power part $G$, which extends holomorphically outside the inner disk of radius $r$. The residue of the original Laurent series is entirely contained in the negative-power part $G$, while the positive-power part $F$ has residue zero.
])

=== Decomposition Around Multiple Singularities (Lemme 6.1)
Take an open simply connected set $A subset CC$, a function $f$ holomorphic on $A_(\\{c_1,c_2,...,c_n})$, and a piecewise $C^1$ closed path $gamma$ whose support is contained in $A_(\\{c_1,c_2,...,c_n})$.

Around every singularity $c_i$, choose a sufficiently small positively oriented circle $Gamma_i$ contained in $A$, with all these circles disjoint and avoiding $gamma$. Then, the integral along $gamma$ can be reduced to the integrals along these small circles :
$ integral_gamma f(z) dif z = sum_(i=1)^n "Ind"(gamma,c_i) integral_(Gamma_i) f(z) dif z $

#def_block([
  This lemma is the multiple-singularity version of the annulus picture used before. We cut the domain with connection paths so that the region between $gamma$ and the small circles contains no singularity. The integrals along the two sides of every connection path cancel each other, while a circle around $c_i$ appears as many times, and with the orientation, given by $"Ind"(gamma,c_i)$.

  Thus, the global closed-path integral is decomposed into local integrals around each singularity. Singularities with index zero do not contribute.
])

*Proof* : #block()
Choose the circles $Gamma_i$ small enough so that they are disjoint and remain inside $A$. We connect them to the path by cuts that avoid the singularities. After these cuts, the region can be subdivided into pieces on which $f$ is holomorphic. By Goursat's theorem, the integral around the boundary of every such piece is zero.#block()

When we sum all these boundary integrals, every internal connection path appears twice in opposite directions and cancels. What remains is the original path $gamma$ together with the small circles $Gamma_i$. The number and orientation with which each circle remains is exactly the index of $gamma$ around $c_i$. Therefore :
$ integral_gamma f(z) dif z = sum_(i=1)^n "Ind"(gamma,c_i) integral_(Gamma_i) f(z) dif z $

=== Residue Theorem (Theorem 6.2)
Take open simply connected set $A subset CC$, a function $f$ holomorphic on $A_(\\{c_1, c_2, ..., c_n})$, and a closed path $gamma$ whose support is contained in $A_(\\{c_1, c_2, ..., c_n})$. Then, the integral of $f$ along $gamma$ is given by :
$ integral_(gamma) f(z) dif z = 2 pi i sum_(i=1)^n "Ind"(gamma, c_i) dot "Res"(f, c_i) $
#def_block([
  The Residue Theorem is a powerful result in complex analysis that relates the integral of a holomorphic function around a closed contour to the sum of residues at its singularities within the contour. Specifically, it states that if you have a function that is holomorphic on an open simply connected set except for a finite number of isolated singularities, then the integral of that function along a closed path can be computed as $2 \pi i$ times the sum of the products of the winding numbers (indices) of the path around each singularity and the residues of the function at those singularities. This theorem is particularly useful for evaluating complex integrals, as it allows one to bypass direct integration by instead focusing on the local behavior of the function at its singular points.
])
*Proof* : #block()
By lemma 6.1, we can reduce the integral to sufficiently small positively oriented circles $Gamma_i$ around the singularities :
$ integral_gamma f(z) dif z = sum_(i=1)^n "Ind"(gamma,c_i) integral_(Gamma_i) f(z) dif z $
On each small circle $Gamma_i$, the function is holomorphic on an annulus centered at $c_i$. By proposition 6.1, and since $"Ind"(Gamma_i,c_i)=1$ :
$ integral_(Gamma_i) f(z) dif z = 2 pi i dot "Res"(f,c_i) $
Thus, we get the final result :
$ integral_gamma f(z) dif z = 2 pi i sum_(i=1)^n "Ind"(gamma, c_i) dot "Res"(f, c_i) $



== Singularities
In complex analysis, most functions are well-defined except at a discrete collection of points called *isolated singularities*. These points usually arise as the *zeros of a denominator* when dividing holomorphic functions. Their behavior is governed by the *Principle of Isolated Zeros*, which ensures that analytic zeros do not "clump" together.

#block()
*Key Concepts:*

- *Lemma 2.2*: If a function has a zero at $z_0$, it is either *identically zero* in that area or the zero is *isolated*, allowing the function to be factored as $(z - z_0)^k g(z)$ where $g(z_0) != 0$.
- *Guaranteed Space*: Because $g$ is continuous, it remains non-zero in a small neighborhood, making $z_0$ the *only zero* in that immediate vicinity.
- *Singularity Analysis*: Since zeros are isolated, the resulting singularities are also *discrete points*, giving us enough "room" to perform a local analysis.
#block()#block()

- *Laurent Series*: On an annulus around these points, we use a unique expansion of *positive and negative powers* to capture the "singular" behavior.
- *The Residue*: The coefficient of the $(z-c)^(-1)$ term measures the singularity's local contribution and is the core of the *Residue Theorem*.
- *Rigid Structure*: Unlike real smooth functions, which may have non-isolated zeros or zeros of infinite order (for example $e^(-1/|x|)$ at $0$), complex analytical functions maintain a *strict algebraic structure* that allows for reliable classification into *removable, pole, or essential* types.


=== Isolated Singularities (Definition 6.4)
On a open subset $A subset CC$, a point $c in A$ is an *isolated singularity* of a function $f : A_(\\{c}) -> CC$ if $f$ is holomorphic on a punctured neighborhood of $c$, meaning that there exists a real $rho>0$ such that $B_*(c, rho) subset A$ and $f$ is holomorphic on $B_*(c,rho)$.

#note_block(block_colors.note)[
  Abusing the language, we will often say that $c$ is a isolated singularity of $f$. Though, it is more accurate to say that $c$ is an isolated singularity on the domain of definition of $f$.
  #block()
  Also, we will often just call them singularities, as isolated singularities are the only kind of singularities we will study.
]
#note_block(block_colors.note)[
  More precisely, in the notation above, $A$ is an ambient open set containing $c$, while the actual domain of $f$ is $A_(\\{c})$. Thus, $c$ is the missing point of the domain of $f$, but there exists a small punctured ball around $c$ on which $f$ is holomorphic.
]
By definition 6.1, for any isolated singularity $c$ of $f$, there exists an annulus $A(c, r, s) subset A$ on which $f$ is well defined. Thus, by theorem 6.1, we can write the Laurent series expansion of $f$ around $c$ :
$ f(z) = sum_(k>=0) a_k (z - c)^k + sum_(k>=1)  a_(-k) (z - c)^(-k) $

#note_block(block_colors.note)[
  We classify the singularities by the number of non-null negative power terms in the Laurent series expansion around the singularity.
]

#def_block([
  *Interpretation:* An isolated singularity is a point $c$ in the complex plane where a holomorphic function $f$ is not defined or fails to be holomorphic, but where the function remains holomorphic in a punctured neighborhood around $c$. This local structure is crucial because it allows for a Laurent series expansion around $c$, capturing both the regular behavior (positive powers) and the singular behavior (negative powers) of the function. The classification of isolated singularities—whether removable, poles, or essential—is determined by the Laurent series coefficients, particularly the number and magnitude of negative power terms. This classification has profound implications for contour integration via the Residue Theorem, where only the residue (the coefficient of $(z-c)^(-1)$) contributes to the integral around the singularity. Unlike real analysis, where functions can have pathological behavior at isolated points, the rigidity of complex analyticity ensures that isolated singularities exhibit predictable, algebraic structures that can be systematically studied and exploited.
])

=== Apparent Singularities
==== Apparent Singularity (Definition 6.5)
A singularity $c$ of a funciton $f$ is an *apparent singularity* (or removable singularity) if the Laurent series expansion of $f$ around $c$ has no negative power terms, i.e. :
$ f(z) = sum_(k>=0) a_k (z - c)^k $

#def_block([
  *Interpretation:* Apparent singularities are points that have been removed of the domain, but could have been defined as holomorphic. They often involve having a simplification of poles and zeros at $c$.
])

=== Apparent Isolated Singularity (Proposition 6.2)
If $c$ is an isolated singularity of a function $f : A_(\\{c}) -> CC$, but the point $c$ also classifies as an apparent singularity, then the residue is null :
$ "Res"(f, c)=0 $

#def_block([
  *Interpretation:*
  If $c$ is a removable singularity of $f$, then there are no negative power terms in the Laurent expansion around $c$, so $"Res"(f, c) = 0$. This means $f$ can be extended holomorphically to $c$, and the integral of $f$ around any sufficiently small closed contour surrounding only $c$ vanishes.
])

=== Holomorphic Extension at an Apparent Isolated Singularity (Proposition 6.3)
Take $c$ a *isolated singularity* of a function $f : A_(\\{c}) -> CC$ holomorphic. Then, $c$ is an *apparent singularity* of $f$ if and only if the limit $lim_(z->c) f(z)$ exists and is finite. More over, $f$ can be extended holomorphically at $c$ by defining :
$ tilde(f) : A -> CC, " "tilde(f)(z) = f(z) " " forall z in A_(\\{c}) $
$ tilde(f)(c) = lim_(z->c) f(z) " is holomorphic" $

#def_block([
  *Interpretation:*
  This theorem establishes a precise criterion for identifying removable singularities in complex analysis. It states that an isolated singularity $c$ of a holomorphic function $f$ can be classified as a removable singularity if and only if the limit of $f(z)$ as $z$ approaches $c$ exists and is finite. This means that if the function approaches a well-defined value near the singularity, we can "fill in" the singularity by defining the function at that point to be this limit value. The extended function, denoted as $tilde(f)$, remains holomorphic on the entire domain, including at the point $c$. This result is significant because it allows for the extension of holomorphic functions across points where they were initially undefined, thereby preserving their analytic properties and enabling further analysis and application of complex function theory.
])
*Proof:*#block()
Using the same reasoning as Corollaire 5.1, if we suppose that $lim_(z->c) f(z)$ exists. Then, we can extend the continuity of $tilde(f)$ to $c$ using construction.

By Corollaire 5.1, this continuous extension is holomorphic at $c$. It is therefore analytic, and accepts a power series expansion around $c$ that converges to $tilde(f)$ on any ball $B(c, rho) subset A$ (representation theorem 5.3), and so to $f(z)=tilde(f)(z)$ on $B(c, rho)_(\\{c})$. This means that this is also a Laurent series expansion of $f$ around $c$, with no negative power terms. Thus, $c$ is an apparent singularity of $f$.

Inversly, if we suppose that $c$ is an apparent singularity of $f$. Then, by definition 6.5, the Laurent series expansion of $f$ around $c$ has no negative power terms (it becomes a power series). And as so, the limit $lim_(z->c) f(z) = a_0$ exists by continuity and is finite on $c$.

#note_block(block_colors.extra)[
  As proving the existance of the limit is hard, we will see next a few propositions that will help us identify apparent singularities more easily.
]

=== Conditions for Apparent Singularities (Proposition 6.4)
The following conditions are equivalent, and each one is necessary and sufficient to prove that an isolated singularity $c$ of a holomorphic function $f : A_(\\{c}) -> CC$ is an apparent singularity :
- $f$ is bounded in a punctured neighborhood of $c$.
- $lim_(z->c) (z-c) f(z) = 0$

#def_block([
  *Interpretation:*
  This proposition provides two practical criteria for identifying removable singularities. The first one is the standard boundedness criterion. The second one says that $f$ grows more slowly than $1/(z-c)$ near $c$. Notice that the condition is on *$(z-c)f(z)$*, not on $f(z)$ itself: a removable singularity may have a non-zero limit, for example $f(z)=1$ on a punctured disk.
])
*Proof:* #block()
We show the implications (a) $->$ (b) $->$ "$c$ is an apparent singularity" $->$ (a).

*(a) $->$ (b):*
Assume there exist $r>0$ and $M>0$ such that $|f(z)| <= M$ for all $z in B_*(c,r)$. Then for all such $z$,
$ |(z-c) f(z)| <= M |z-c|. $
Hence,
$ lim_(z->c) |(z-c) f(z)| <= M lim_(z->c) |z-c| = 0, $
so $lim_(z->c) (z-c) f(z) = 0$.

*(b) $->$ apparent singularity:*
Define $g(z) = (z-c) f(z)$ on $B_*(c,r)$. By (b), $lim_(z->c) g(z) = 0$, so by Proposition 6.3, $g$ extends holomorphically to $c$ by setting $g(c)=0$. Therefore, $g$ admits a Taylor expansion around $c$:
$ g(z) = sum_(k>=0) a_k (z-c)^k, " with " a_0 = g(c) = 0. $
For $z != c$,
$ f(z) = g(z)/(z-c) = sum_(k>=1) a_k (z-c)^(k-1) = sum_(m>=0) a_(m+1) (z-c)^m. $
This is a power series (no negative powers), so $c$ is an apparent (removable) singularity of $f$.

*apparent singularity $->$ (a):*
If $c$ is apparent, then $f$ extends holomorphically (hence continuously) to $c$ (Proposition 6.3). Thus $f$ is continuous on a small closed disk $B[c,r]$, hence bounded there, and in particular bounded on the punctured disk $B_*(c,r)$.

== Poles
=== Pole (Definition 6.6)
A singularity $c$ of a function $f$ is a *pole of order $m$* ($m in NN$, $m>0$) if the Laurent series expansion of $f$ around $c$ has a finite number of negative power terms, i.e. :
$ f(z) = sum_(k>=0) a_k (z - c)^k + sum_(k=1)^m  a_(-k) (z - c)^(-k) $

Meaning that $a_(-m) != 0$ and $a_(-k) = 0 forall k > m$.

#def_block([
  *Interpretation:*
  A pole of order $m$ at a singularity $c$ indicates that the function $f$ exhibits a specific type of singular behavior characterized by a finite number of negative power terms in its Laurent series expansion around $c$. This means that as $z$ approaches $c$, the function diverges to infinity in a controlled manner, with the leading term being $(z-c)^{-m}$. Poles are significant in complex analysis because they represent isolated singularities where the function's behavior is well-understood and can be analyzed using tools like the Residue Theorem. The order of the pole provides insight into the severity of the singularity, with higher-order poles indicating more pronounced divergence.
])
#note_block(block_colors.note)[
  While we could re-prove a lot of the apparent singularity results for poles, we will instead describe the following lemma to re-use them.
]

=== Pole Characterization (Lemme 6.2)
A isolated singularity $c$ of a function $f : A_(\\{c}) -> CC$ is a *pole of order $m$* if and only if $c$ is an apparent singularity for the function $g(z) = (z - c)^m f(z)$ but not $h(z) = (z -c)^(m-1) f(z)$
#def_block([
  *Interpretation:*
  This lemma provides a characterization of poles in terms of removable singularities. It states that an isolated singularity $c$ of a function $f$ is a pole of order $m$ if and only if the function $g(z) = (z - c)^m f(z)$ has a removable singularity at $c$, while the function $h(z) = (z - c)^{m-1} f(z)$ does not. This means that by multiplying $f$ by $(z - c)^m$, we can "cancel out" the pole and obtain a function that can be extended holomorphically to $c$. However, multiplying by $(z - c)^{m-1}$ is insufficient to remove the singularity, indicating that the pole has order exactly $m$. This characterization is useful for identifying and analyzing poles in complex functions.
])
*Proof:* #block()
Let the Laurent expansion of $f$ around $c$ be :
$ f(z) = sum_(k in ZZ) a_k (z-c)^k $
Then :
$ g(z) = (z-c)^m f(z) = sum_(k in ZZ) a_k (z-c)^(k+m) $
The function $g$ has no negative power terms if and only if :
$ a_k = 0 " " forall k < -m $
So $g$ is removable exactly when the pole order of $f$ is at most $m$.

Now :
$ h(z) = (z-c)^(m-1) f(z) $
contains the term $a_(-m)(z-c)^(-1)$. Thus, once all coefficients below $a_(-m)$ vanish, $h$ is not removable if and only if $a_(-m) != 0$. This is exactly the condition that $f$ has a pole of order $m$.

=== Conditions for Poles (Proposition 6.5)
A isolated singularity $c$ of a holomorphic function $f$ is a *pole of order exactly $m$* if and only if :
- $lim_(z->c) (z-c)^m f(z) = L$, with $L$ finite and non-zero.

The following conditions are weaker, and are equivalent to saying that $c$ is a pole of order *at most $m$* (or an apparent singularity) :
- $(z-c)^m f(z)$ is bounded in a punctured neighborhood of $c$.
- $lim_(z->c) (z-c)^(m+1) f(z) = 0$

#def_block([
  *Interpretation:*
  The non-zero finite limit of $(z-c)^m f(z)$ identifies the *exact* order of the pole. If we only know that $(z-c)^m f(z)$ is bounded, or that $(z-c)^(m+1)f(z)$ tends to zero, then we only know that multiplication by $(z-c)^m$ removes all negative powers. The actual pole may therefore have a smaller order, or the singularity may already be removable.
])

=== Holomorphic condition for Poles (Corollaire 6.2)
A singularity $c$ of a function $f : A_(\\{c}) -> CC$ holomorphic, and $m>0$ :
- If $lim_(z->c) (z-c)^m f(z)$ exists, is finite and is non-null, then $c$ is a pole of order exactly *$m$*.
- If $lim_(z->c) (z-c)^m f(z) = 0$, then $c$ is a pole of order at most *$m-1$* (or an *apparent singularity* if $m=1$).
#note_block(block_colors.trick)[
  This is pretty much what was said in proposition 6.5, but it is useful to have it written this way. :3
]

=== Calculating the Residue Using Poles (Exercice 6.2)
Decompose a function $f$ as $f(z)=(g(z))/(h(z))$, with $g$ and $h$ holomorphic on an open set $A subset CC$. If $h(c)=0$, $h'(c) != 0$ and $g(c) != 0$, then $h$ has a simple zero at $c$, so $f$ has a simple pole at $c$, and :
$ "Res"(f, c) = (g(c))/(h'(c)) $
#def_block([
  *Interpretation:*
  Here $h(c)=0$ and $h'(c) != 0$, so $h$ has a *simple zero* at $c$. Hence $f=g/h$
  has a *simple pole* at $c$, and the residue is the coefficient of $(z-c)^(-1)$
  in the Laurent expansion. For a simple pole, it is also given by
  $"Res"(f,c)=lim_(z->c) (z-c) f(z)$.
])

*Proof:* #block()
Since $h$ is holomorphic and $h(c)=0$, we can write (by the definition of the derivative)
$ h(z) = h(c) + (z-c) h'(c) + o(z-c) = (z-c)(h'(c) + o(1)). $
Define
$ phi(z) = cases(
  h(z)/(z-c)" " & z != c,
  h'(c) " "& z = c.
) $
Then $phi$ is holomorphic in a neighborhood of $c$ and $phi(c)=h'(c) != 0$.
Hence, for $z != c$ close to $c$,
$ f(z) = g(z)/h(z) = g(z)/((z-c) phi(z)). $
So $f$ has a simple pole at $c$, and
$ "Res"(f,c) = lim_(z->c) (z-c) f(z)
= lim_(z->c) g(z)/phi(z)
= g(c)/phi(c)
= g(c)/h'(c). $

=== Residue Calculation Generalization (Proposition 6.6)
If $c$ is a pole of order $m$ of a function $f : A_(\\{c}) -> CC$ holomorphic, then the residue of $f$ at $c$ is given by :
$ "Res"(f, c) = 1/((m-1)!) lim_(z->c) (f(z) (z-c)^m)^((m-1)) $
#note_block(block_colors.note)[
  The exponent notation $((m-1))$ denotes the $(m-1)^("th")$ derivative with respect to $z$.
]
#def_block([
  *Interpretation:*
  This proposition provides a formula for calculating the residue of a function at a pole of order $m$. It states that if $c$ is a pole of order $m$ for a holomorphic function $f$, then the residue at that pole can be computed by taking the limit as $z$ approaches $c$ of the $(m-1)$-th derivative of the product of $f(z)$ and $(z-c)^m$, divided by $(m-1)!$. This formula is particularly useful because it allows for the direct computation of residues at higher-order poles without needing to explicitly find the Laurent series expansion. The residue is a crucial quantity in complex analysis, especially in the context of contour integration and the application of the Residue Theorem.
])
*Proof:* #block()
#todo_block()

=== Solving for the Residue at a Pole (Example 6.2)
We will consider the case of $f(z)=z/(sin z)^2$. And we will consider $c=k pi forall k != 0 in ZZ $.
Using the variable change $w = z - k pi$. We can rewrite the limit :
$ lim_(z-> k pi ) (z - k pi) z/(sin z )^2 = lim_(w -> 0) (w (w + k pi))/(sin(w + k pi))^2 = k pi lim_(w->0) w/(sin(w))^2  = infinity $
As it does not exist, we will move to the second order :
$ lim_(z-> k pi ) ((z - k pi)^2 z)/(sin z )^2 = lim_(w -> 0) (w^2 (w + k pi))/(sin(w + k pi))^2 = k pi lim_(w->0) w^2/(sin(w))^2  = k pi $
Thus, the residue at $c=k pi$ is :
$ "Res"(f, k pi) = lim_(z->0) (f(z+k pi)z^2)'/(1!) = lim_(z->0) ( (z^2(z+k pi))/(sin(z)^2))' = 1 $
#note_block(block_colors.note)[
  While the calculation of the pole 2 is harder, it is much easier to do than the integral calculation.
]

== Essential Singularity
=== Essential Singularity (Definition 6.7)
A singularity $c$ of a function $f$ is an *essential singularity* if the Laurent series expansion of $f$ around $c$ has an infinite number of negative power terms, i.e. :
$ f(z) = sum_(k>=0) a_k (z - c)^k
  + sum_(k>=1)  a_(-k) (z - c)^(-k) $
#def_block([
  *Interpretation:*
  An essential singularity is a type of isolated singularity where the Laurent series expansion of a function around that point contains infinitely many negative power terms. This means that as the variable approaches the singularity, the function exhibits highly variable behavior that cannot be captured by a finite number of negative-power terms. In general, the function does not approach a finite limit or infinity in a uniform way. Essential singularities are significant in complex analysis because they lead to phenomena such as the Great Picard Theorem, which states that in any neighborhood of an essential singularity, a holomorphic function takes on nearly all possible complex values, with at most one exception. This contrasts sharply with poles and removable singularities, which have more controlled and predictable behaviors.
])
#note_block(block_colors.note)[
  An example, is the function :
  $ f(z) = e^(1/z) = sum_(n=0)^infinity (1/n!) (1/z)^n $
  which has an essential singularity at $z=0$ because its Laurent series expansion around $0$ has an infinite number of negative power terms.
]
#note_block(block_colors.note)[
  Essential singularities *do have a residue*: as for every isolated singularity, it is the coefficient $a_(-1)$ of the Laurent series. What we lose is the simple finite-order pole formula, because there are infinitely many negative-power terms.#block()

  The usual way to obtain the residue is therefore to find enough of the Laurent expansion to identify $a_(-1)$. For example, $e^(1/z)$ has residue $1$ at $z=0$.
  ]

== Appendix
=== Shifting a Laurent Series (Lemme 6.3)
If a function $f$ admits a Laurent series expansion around $c$ on an annulus $A(c, r, s)$ :
$ f(z) = sum_(k in ZZ) a_k (z-c)^k $
Then, we can also express :
$ f(z) (z-c)^m &= sum_(k in ZZ) a_k (z-c)^(k+m) &= sum_(k' in ZZ) a_(k'-m) (z-c)^k' &= sum_(k'>=0) a_(k'-m) (z-c)^k' + sum_(k'<=-1) a_(k'-m) (z-c)^k' $
With $k' = k + m$.

// ==============================================================================================
// Multivalued Functions, Logarithms and Roots (p 97 - 108)
// ==============================================================================================
= Multivalued Functions, Logarithms and Roots (Riemann Surfaces and Branch Cuts) // Riemann Surfaces and Branch Cuts
== Introduction
In Chapter 3, we defined the complex exponential function, but not yet its inverse: the logarithm. At first glance, one might expect the logarithm to be an ordinary function
$log : CC_0 -> CC$ (where $CC_0 = CC_(\\ {0})$), inverse of $exp$.

However, a paradox appears immediately. In chapter 4, we observed that the function
$f(z) = 1/z$ cannot be the derivative of a holomorphic function defined on all of $CC_0$ (there is no global primitive on $CC_0$).
Yet, if $log$ were the inverse (in the usual sense) of the exponential, the inverse-derivative rule would formally give:
$ (exp^(-1))'(z)
  = 1 / exp'(exp^(-1)(z))
  = 1 / exp(exp^(-1)(z))
  = 1/z. $

We would then conclude that $log$ is a global primitive of $1/z$ on $CC_0$, which contradicts the previous result. So we must understand what “breaks” in this reasoning.

The resolution comes from the fact that the complex exponential is *periodic*:
$ exp(z + 2 pi i) = exp(z). $
It is therefore not injective on $CC$, and an “inverse” cannot be a well-defined function in the classical sense. In reality, for a given $z in CC_0$, there are infinitely many values of $w$ such that $exp(w)=z$, and these values differ by multiples of $2 pi i$.

Thus, the logarithm is naturally a *multivalued function*. If $theta$ is one chosen argument of $z$, then :
$ log(z) = { w in CC : exp(w)=z } = { ln|z| + i(theta + 2 pi k) : k in ZZ } = ln|z| + i arg(z). $

In this chapter, we study:
- how to choose a *branch* (a single value) of $log$ on suitable domains (typically simply connected and not “winding around” $0$),
- the role of *branch cuts* to avoid discontinuities,
- the link with *Riemann surfaces* (a geometric viewpoint that makes these functions “single-valued”).

#note_block(block_colors.note)[
  A fully rigorous analysis of the underlying topological phenomena (global continuity, branch choices, monodromy) requires more advanced tools. In this course, some arguments will remain intentionally informal, but the essential constructions will be made explicit.
]

== Multivalued Functions
When decomposing complex values into modulus and argument, we saw that the argument is only defined up to addition of $2 pi k$ for $k in ZZ$. This leads to the concept of *multivalued functions*.
$ z= |z| e^(i theta) = |z| e^(i (theta + 2 pi k))" " forall k in ZZ $

=== Multivalued Function (Definition 7.1)
A *complex multivalued function* is where for each element of $CC$ there exists a subset $CC$ (possibly infinite) of values associated with it. This is $f : CC -> 2^CC$

We will call *single-valued function* a functions allowing only one output value for each input value. Here is an fundamental example :
$ arg : CC_(\\ {0}) -> 2^RR : z arrow.bar {theta in RR | e^(i theta) = z/(|z|)} $
Which helps construct both logarithms, and powers.

#def_block([
  *Interpretation:*
  A multivalued function is a function that can take on multiple values for a given input. This is in contrast to a single-valued function, which assigns exactly one output value to each input value. Multivalued functions arise naturally in complex analysis due to the periodic nature of certain functions, such as the complex logarithm and the argument function. For example, the argument function $arg(z)$ is multivalued because it can take on infinitely many values differing by multiples of $2 pi$. This multivaluedness reflects the fact that there are multiple angles (arguments) that correspond to the same point in the complex plane when expressed in polar form. Understanding multivalued functions is crucial for working with complex functions that exhibit branching behavior and for constructing Riemann surfaces.
])

#note_block(block_colors.note)[
  To apply the usual function tools (continuity, differentiability, integration), we often will require the function to be *uniform* on a given domain.
]

=== Determinations (Definition 7.2)
Take $f : U -> 2^CC$ a complex multiform function. A *determination (or branch)* of $f$ on a set $A subset U$ is a uniform function $g : A -> CC$ such that $forall z in A, g(z) in f(z)$.
#block()
To make uniform a function, is to construct one of its determinations. This means by restricting the values that it can take. An example is the argument :
$ arg(z) -> "Arg"(z) = {theta in [0, 2 pi) : e^(i theta) = z/(|z|)} $
Which is a determination of the argument function on $CC_(\\ {0})$. Noted for examples as :
$ "Arg"_([0, 2 pi))(z) $

#def_block([
  *Interpretation:*
  A determination (or branch) of a multiform function is a way to select a single-valued function from the multiple possible values that the multiform function can take at each point in its domain. This is crucial for working with multiform functions in a rigorous manner, as it allows us to apply standard function analysis techniques (like continuity and differentiability) to a specific "slice" of the multiform function. For example, the argument function $arg(z)$ is multivalued because it can take on infinitely many values differing by multiples of $2 pi$. By choosing a determination, such as $"Arg"(z)$ which restricts the argument to the interval $[0, 2 pi)$, we obtain a uniform function that can be analyzed and manipulated like any other single-valued function.
])

#note_block(block_colors.note)[
  A determination is not unique, as we can always add $2 pi k$ to the argument. Thus, there are infinitely many determinations of the argument function.
]

=== Branching Points (Definition 7.3)
Take a complex multiform function $f$ and a point $z_0 in CC$. We say that $z_0$ is a *branching point (or ramification point)* if there exists no radius $r>0$ such that $f$ admits a continuous single-valued determination on the whole punctured neighborhood $B_*(z_0,r)$.

#def_block([
  *Interpretation:*
  A branching point is a point in the complex plane where a multiform function cannot be made uniform (single-valued) on a full punctured neighborhood around that point. This occurs when, as one encircles the branching point, the values of the function "twist" or "branch" in such a way that returning to the starting point changes the chosen value. A classic example is the complex logarithm, which has a branching point at $0$. As one loops around $0$, the argument increases by $2 pi$, leading to a different value of the logarithm. To obtain a continuous determination, we therefore have to cut the domain so that such a loop is no longer possible.
])

== The argument function
=== Properties of the Argument Function (Proposition 7.1)
For $z, w in CC_(\\ {0})$, choose any values $theta in arg(z)$ and $phi in arg(w)$. Then :
- $arg(z w) = theta + phi + 2 pi ZZ$
- $arg(z/w) = theta - phi + 2 pi ZZ$
- $arg(z^n) = n theta + 2 pi ZZ$, with $n in ZZ$

#note_block(block_colors.warning)[
  The important point is that $arg(z)$ is a *set of values*, not one angle. If $theta$ is one particular argument of $z$, then :
  $ arg(z) = theta + 2 pi ZZ $
  A determination $"Arg"_I(z)$ selects the unique value of this set that belongs to the chosen interval $I$.
]

#def_block([
  *Interpretation:*
  The properties of the argument function reflect its multivalued nature in complex analysis. We first choose one representative $theta$ of $arg(z)$ and one representative $phi$ of $arg(w)$. The complete set of possible arguments is then obtained by adding all multiples of $2 pi$. This avoids confusing a single chosen argument with the full multiform set.
])

=== Determination and Branch Cuts of the Argument (Proposition 7.2)
The multiform argument function admits $z_0=0$ as its *unique branching point*. Furthermore, for any semi-open interval $I subset RR$ of length $2 pi$, let $theta_0$ be one of its endpoints. The function :
$ "Arg"_I : CC_(\\ {e^(i theta_0)[0, +infinity)}) -> I $
is a continuous determination of $arg(z)$ on the complex plane cut along the ray of angle $theta_0$. We write the offset branch point as :
$ arg(z - z_0) -> "Unique branching point at z_0" $

== Complex Logarithm
=== Complex Logarithm (Proposition 7.3)
For any $z in CC_(\\ {0})$, choose one value $theta in arg(z)$. The complex logarithm is defined as the multiform function :
$ log(z) &= { w in CC : exp(w) = z } = { ln|z| + i(theta + 2 pi k) : k in ZZ } &= ln |z| + i arg(z) $
Its determination is given by :
$ "Log"_I (z) = ln |z| + i "Arg"_I (z) $
Where $I subset RR$ is a semi-open interval of length $2 pi$.

=== Composition of Sets (Proposition 7.4)
For any $z, w in CC_(\\ {0})$ :
$ log(z w) = log(z) + log(w) $
This relationship is only valid for subsets of values, as we are not considering determinations here. Choosing $theta in arg(z)$ and $phi in arg(w)$ :
$ log(z w) = ln |z w| + i arg(z w) = ln |z w| + i(theta + phi + 2 pi ZZ) $

=== Holomorphic Determinations of the Logarithm (Proposition 7.5)
For any semi-open interval $I subset RR$ of length $2 pi$, let $theta_0$ be one of its endpoints. The function $"Log"_I : CC_(\\ {e^(i theta_0)[0, +infinity)}) -> CC$ is a holomorphic determination of $log(z)$ on this cut plane, with derivative :
$ ("Log"_I)'(z) = 1/z $

== Other Chapters Omitted (simple relations)
More info on page 102 of syllabus.

// ==============================================================================================
// Other stuff
// ==============================================================================================
#pagebreak()
= Additional Ressources

== AI made definitions
// Custom style for the literary block
#let lit(content) = block(
  fill: luma(245),
  stroke: (left: 2pt + eastern),
  inset: (x: 10pt, y: 8pt),
  radius: 2pt,
  width: 100%
)[#text(style: "italic", size: 0.9em, content)]

=== Limits and Continuity

*Definition:* Let $f$ be defined on a punctured neighborhood of $z_0$. The limit of $f(z)$ as $z$ approaches $z_0$ is $L$ if:
$ forall epsilon > 0, exists delta > 0 "s.t." 0 < |z - z_0| < delta -> |f(z) - L| < epsilon $

*Continuity:* A function is continuous at $z_0$ if $lim_(z -> z_0) f(z) = f(z_0)$. This requires the limit to exist and match the function value.

#lit[
  *Literary Interpretation:* Continuity represents a promise of proximity. It ensures that the mapping does not tear the fabric of the complex plane; if two points start their journey indistinguishably close, their destinations will not be strangers.
]

*Validity:* Fundamental for calculus. Continuity is a standard sufficient condition for integration along paths and is also central to many topological arguments in $\CC$.

=== Differentiation (Complex Derivative)

*Definition:* A function $f(z)$ is complex differentiable at $z_0$ if the limit of the difference quotient exists:
$ f'(z_0) = lim_(h -> 0) (f(z_0 + h) - f(z_0)) / h $
*Crucially*, this limit must be unique regardless of the direction from which $h$ approaches $0$ in the complex plane.

#lit[
  *Literary Interpretation:* Unlike real differentiation, which asks for slope, complex differentiation demands structural integrity. It requires the local world to act like a rigid scaling and rotation, forbidding any skewing or squashing of space.
]

*Validity:* This is a much stronger condition than in $\RR$. If a derivative exists, the function satisfies the *Cauchy-Riemann equations*.

=== Holomorphic Functions

*Definition:* A function $f(z)$ is *holomorphic* at $z_0$ if it is complex differentiable in an open neighborhood of $z_0$.
* $f$ is *Analytic if it can be locally represented by a convergent power series: $f(z) = sum_(n=0)^infinity a_n (z - z_0)^n$.

*Key Theorem:* In $\CC$, Holomorphic $"iff"$ Analytic.

#lit[
  *Literary Interpretation:* A holomorphic function is the archetype of determinism. Its smoothness is so absolute that knowing its behavior in the tiniest distinct fragment reveals its destiny everywhere (Identity Theorem). It is a "hologram" where the part contains the whole.
]

*Validity:* Used everywhere in complex analysis. Implies $f$ is infinitely differentiable ($C^infinity$), and integrals over closed loops that are homotopic to a point inside the holomorphy domain are zero (Cauchy-Goursat). In particular, this holds for every closed loop on a simply connected domain.

=== Homomorphism and Isomorphism

*Definition:* Let $(S, +_S, dot_S)$ and $(T, +_T, dot_T)$ be algebraic structures (e.g., rings or fields).
* A *Homomorphism* is a map $phi: S -> T$ preserving structure:
  $ phi(a +_S b) = phi(a) +_T phi(b) " and " phi(a dot_S b) = phi(a) dot_T phi(b) $
* An *Isomorphism* is a bijective homomorphism.

#lit[
  *Literary Interpretation:* A homomorphism is a faithful translation between languages. It changes the words but preserves the grammar and the relationships between concepts. An isomorphism implies the two worlds are essentially identical, just named differently.
]

*Validity:* In Complex Analysis, a closely related notion is a *biholomorphism*: a holomorphic bijection with holomorphic inverse. Automorphisms are biholomorphisms from a domain $D$ to itself, while the conformal equivalence of the unit disk and the upper half-plane is a biholomorphism between two different domains.

=== Path-Connectedness ("Connexe par arcs")

*Definition:* A set $Omega subset CC$ is path-connected if for any pair $z_1, z_2 in Omega$, there exists a continuous function (path) $gamma: [0, 1] -> Omega$ such that:
$ gamma(0) = z_1 " and " gamma(1) = z_2 $

#lit[
  *Literary Interpretation:* To be path-connected is to live in a world without unbridgeable chasms. It is a single continent where a traveler can walk from any hearth to any other without ever leaving home.
]

*Validity:* Essential for integration. Simply connected domains are path-connected and allow global primitives for holomorphic functions. If a region is not path-connected, primitives can still be defined separately on each connected component; two primitives may differ by a different additive constant on each component.
