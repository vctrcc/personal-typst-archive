#import "@preview/showybox:2.0.3": showybox
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/cetz:0.5.2"
#import "@preview/simple-plot:0.8.0"

#let edge-text = [Formulaire made by Victor Carballes the #datetime.today().display("[year]-[month]-[day]") for the course LINGI2348 Information Theory & Coding at UCLouvain.]

#let edge-header-footer = [
  #set text(size: 7pt, fill: rgb("#9e9e9e"))

  #box(width: 100%)[
    #edge-text
    #h(1fr)
    Page #context counter(page).display()
  ]
]

#set page(
  paper: "a4",
  flipped: true,

  margin: 0.5cm,

  columns: 3,

  header: edge-header-footer,
  footer: edge-header-footer,

  // 95% was probably too close to the edge.
  header-ascent: 55%,
  footer-descent: 55%,
)
#set columns(gutter: 0.2cm)

#set text(size: 9pt)
#set block(spacing: 0.5em)

// Global Variables & Commands
#let imp(body) = text(fill: blue.desaturate(10%).darken(10%), weight: "bold", body)
#let def(term) = text(fill: red, weight: "bold", term)
#let strong(txt) = text(weight: "bold")[#txt]

// Lines
#let hline() = line(stroke: 0.2pt + luma(150), length: 100%)

// Diagrams and arrows
#let diagMath(bodyMath) = text(size: 11pt)[#bodyMath]
#let diagBox(body) = h(0.4em) + block(stroke: 0.05em, inset: 0.5em, body) + h(0.4em)

#let fbox(title, body) = showybox(
  title: text(purple.darken(30%))[*#title*],
  frame: (
    border-color: luma(50%),
    title-color: green.lighten(40%).desaturate(60%),
    body-color: white,
    thickness: 0.5pt,
    radius: 2pt,
  ),
  body
)

#let fbbox(title, body) = showybox(
  title: text(purple.darken(30%))[*#title*],
  frame: (
    border-color: luma(50%),
    title-color: green.lighten(40%).desaturate(60%),
    body-color: green.lighten(96%),
    thickness: 0.5pt,
    radius: 2pt,
  ),
  breakable: true,
  body
)

#let tbox(title, body) = showybox(
  title: text(purple.darken(30%))[*#title*],
  frame: (
    border-color: luma(50%),
    title-color: blue.lighten(40%).desaturate(60%),
    body-color: white,
    thickness: 0.5pt,
    radius: 2pt,
  ),
  breakable: true,
  body
)

#let ebox(title, body) = showybox(
  title: [#text(purple.darken(30%))[*#title*] #place(dy: -100%, dx: 91%,text(size: 8pt, red, weight: "extrabold")[(EXAM)])],
  frame: (
    border-color: luma(50%),
    title-color: red.lighten(40%).desaturate(60%),
    body-color: white,
    thickness: 0.5pt,
    radius: 2pt,
  ),
  breakable: true,
  body
)

#let exerbox(title, body) = showybox(
  title: text(purple.darken(30%))[*#title*],
  frame: (
    border-color: luma(50%),
    title-color: blue.lighten(40%).desaturate(60%),
    body-color: blue.lighten(93%),
    thickness: 0.5pt,
    radius: 2pt,
  ),
  breakable: true,
  body
)

#let subdefbox(title, body) = v(0.3em) + move(
  dx: -4pt,
  showybox(
    title: text(red.darken(10%))[*#title*],
    frame: (
      border-color: luma(60%),
      title-color: color.aqua.lighten(40%).desaturate(60%),
      body-color: white,
      thickness: 0.3pt,
      inset: 6pt,
      radius: 2pt,
    ),
    width: 100% + 8pt,
    body
  )
) + v(0.3em)

#place(dx:50em,dy:-1.2em,[Source code here : #text(fill: color.aqua.darken(20%))[#link("https://github.com/vctrcc/personal-typst-archive")]])

= Information Theory & Probability (1.1)

#fbox("Probability Basics")[
  $
    &strong("Expected Value")   &quad& EE[X] = sum_(x) x P(x) \
    &strong("Variance")         &quad& VV[X] = E[X^2] - (E[X])^2 = sigma^2 \
    &strong("Marginalization")  &quad& P(X) = sum_imp(i) P(X,imp(Y_i)) \
    &strong("Independence")     &quad& P(A,B) = P(A)P(B) "iff" A perp B\
    &strong("Bayes Theorem")    &quad& imp(P(A|B) = (P(B|A)P(A)) / P(B))\
    &strong("Conditional Prob") &quad& imp(P(A|B) = P(A , B) / P(B)) \
    &strong("Chain Rule")       &quad& P(A,B) = P(A | B) P(B) = P(B | A) P(A)\
  $
]

#fbox("Shannon Entropy")[
  The #def[Entropy] $H(X)$ measures the uncertainty or average information content:
  $ imp(H(X) = - sum_(x in cal(X)) P(x) log_2 P(x)) $
  - $H(X) >= 0$
  - Max entropy for uniform distribution: $H(X) = log_2 |cal(X)|$
  - Alternative definition : #def[The amount of uncertainty] (#def[Differentiating information gained])
]

#fbox("Mutual Information")[
  #def[Mutual Information] $I(X;Y)$ measures the information that $X$ and $Y$ share:

  #imp($ I(X;Y) &= sum_(x,y) P(x,y) log_2 (P(x,y) / (P(x)P(y))) $)

  $ I(X;Y)
      &= H(X) - H(X|Y)\
      &= H(Y) - H(Y|X)\
      &= H(X,Y) underbrace(- H(X|Y) - H(Y|X),"remove the hulls") \
      &= underbrace(H(X) + H(Y), "gives 2I(X;Y)") - underbrace(H(X,Y), "removes I(X;Y)\nand hulls")
  $


  - #imp[*Chain Rule:*] $I(X; Y, Z) = I(X; Z) + I(X; Y | Z)$
]

#tbox("Big entropy decomposition")[
  $underbrace(H(X_1, ..., X_n),<= n H(X)) = underbrace(H(X_1, ..., imp(X_(n-1))), "Ball of everything else"\ <= (n-1) H(X) ) + underbrace(H(imp(X_n) | X_1, ...,X_(n-1)), <=H(X_n) <= H(X)) $
]


#fbox("Joint & Conditional Entropy")[
  $
    &strong("Joint Entropy")       &quad& H(X,Y) = - sum_x sum_y P(x,y) log_2 P(x,y) \
    &strong("Recurs. Cond. Entr.") &quad& H(Y|X=x) = - sum_y P(y|x) log_2 P(y|x) \
    &strong("Conditional Entropy") &quad& H(Y|X) = - sum_x sum_y P(x,y) log_2 P(y|x) \
    &&& quad quad quad quad= sum_x P(x) underbrace(H(Y|X=x),imp("Recursive Separation")) \
    &strong("Mutual Information")  &quad& I(X;Y) = H(X) - H(X|Y) \
    &&& quad quad quad quad= H(Y) - H(Y|X) \
    &strong("Chain Rule")          &quad& H(X,Y) = H(X) + H(Y|X) \
    &&& quad quad quad quad= H(Y) + H(X|Y)\
    &&& quad quad quad quad= I(X; Y) + underbrace( H(X|Y) + H(Y|X), "sum the hulls")
  $
  #v(0.5em)
  #underline([*Key Properties :*])
  - $H(X|Y) <= H(X)$ (Conditioning reduces entropy)
  - $"Independent" X perp Y -> cases(H(X, Y) = H(X) + H(Y), H(X|Y) = H(X))$
  #align(center,grid(
    columns: (1fr, 1fr),
    image("Images/Entropy-mutual-information-relative-entropy-relation-diagram.svg"),
    image("Images/tri-depdendance.png", width: 70%),
  ))
]

#tbox("Solving for entropy (Urn Balls)")[
  - *With Reset (Independent Draws):* Draws are i.i.d. Independent events have #imp[zero mutual information]: $I(X_i;X_j)=0$ for $i != j$. Conditioning does not reduce entropy: $H(X_i|X_j)=H(X_i)$.
    $ H_R (X_1, X_2, ..., X_k) = sum_(i=1)^k H(X_i) = k H(X) $

  - *Without Reset (Exchangeability):* Draws are dependent, but the process is symmetric in the draw index. Since we don't have access to the bag's updated state, the marginal distribution remains the same as the first draw!
    $ H_"WR" (X_i) = H(X) "for all" i $

    - *Proof for 2nd Draw Marginal (e.g., Red ball, $N = n_R + n_B + n_W$):*\
      $->$ *Symmetry:* Sampling without replacement acts as a uniform random permutation of the balls. Since the process is symmetric in the draw index, the marginal distribution is identical for any draw $i$.
      $ P(X_2=r) &= P(X_1=r)P(X_2=r | X_1=r) \
                 &quad + P(X_1=b)P(X_2=r | X_1=b) \
                 &quad + P(X_1=w)P(X_2=r | X_1=w) \
                 &= n_R/N underbrace((n_R-1)/(N-1), "Second turn") + n_B/N underbrace(n_R/(N-1), "Second turn") + n_W/N underbrace(n_R/(N-1), "Second turn") \
                 &= n_R/(N-1) ((n_R-1 + n_B + n_W)/N) \
                 &= n_R/(N-1) ((N-1)/N) \
                 &= n_R/N = p_R $


  - *Entropy Bound ($H_"WR" <= H_R$):* Because conditioning reduces entropy ($H(X|Y) <= H(X)$), the joint entropy without reset is strictly bounded by the independent case. By the chain rule:
    $ H_"WR" (X_1, ..., X_k) &= H_"WR" (X_1, ..., X_(k-1)) \
                            &quad + underbrace(H_"WR" (X_k | X_1, ..., X_(k-1)), <= H(X_k) = H(X)) \
                            &<= k H(X) $
]

#fbox("Distance of Probabilities")[
  #def[Information Distance] $d(X,Y)$ is a true metric satisfying non-negativity, symmetry, and the triangle inequality:
  $ imp(d(X,Y) &= H(X|Y) + H(Y|X)\ &= H(X,Y) - I(X;Y)) $
  #underline([*Key Properties :*])
  - $d(X,Y) >= 0$ #h(1fr) #text(size: 0.8em)[$underbrace(H(X|Y), >=0) + underbrace(H(Y|X), >=0) >= 0 quad quad$]
  - $d(X,Y) = d(Y,X)$
  - $d(X,Y) = 0$ iff each variable determines the other: $H(X|Y)=H(Y|X)=0$ (identical up to relabeling).
  - $d(X,Y) + d(Y,Z) >= d(X,Z)$
  Meaning : Information that is not equal (the external hulls)
]

#fbox("Kullback-Leibler Divergence")[
  #def[KL Divergence] $D_text("KL")(P || Q)$ measures the difference between two distributions:
  $ imp(D_text("KL")(P || Q) = sum_x P(x) log_2 (P(x) / Q(x))) $
  - $D_text("KL")(P || Q) >= 0$ (Gibbs' inequality)
  - Not symmetric: $D_text("KL")(P || Q) != D_text("KL")(Q || P)$
]

#v(3em)
#tbox("Distance demonstration")[
  #text(size: 0.85em)[
    $
  d(X,Y) + d(Y,Z) &>= d(X,Z)\
                  &= 2H(X,Y) - H(X) - H(Y) + 2H(Y,Z) - H(Y) - H(Z) \
                  &= 2H(X,Y) + 2H(Y,Z) - 2H(Y) - H(X) - H(Z) \ &quad text("since " H(X,Y) + H(Y,Z) - H(Y) >= H(X,Y,Z)) \
                  &>= 2H(X,Y,Z) - H(X) - H(Z) \  &quad text("since " H(X,Y,Z) >= H(X,Z)) \
                  &>= 2H(X,Z) - H(X) - H(Z) \
                  &= d(X,Z) $]
]

= Source Coding & Huffman Codes (1.2)


#fbox("Performance of Source Codes")[
  $
    &strong("Code alphabet size")       &quad& D = |cal(C)| \
    &strong("Codeword length")         &quad& l_i \
    &strong("Mean length / rate")       &quad& macron(L) = R = sum_i p_i l_i \
    &strong("Entropy, base D")         &quad& H_D (X) = - sum_i p_i log_D (p_i) \
    &strong("Entropy, bits")            &quad& H_2 (X) = - sum_i p_i log_2 (p_i) \
    &strong("Efficiency")               &quad& eta = (H_D (X)) / R = (H_D (X)) / macron(L)
  $
  - #def[Units matter:] if the log is base $D$, entropy is in #imp[$D$-ary code symbols/source symbol], not necessarily bits. (Else, D=2)
  - #def[Source coding lower bound:] for any uniquely decodable $D$-ary code,
    $ #imp[$R >= H_D (X)$] $
  - #def[Shannon/Huffman range:] $H_D (X) <= R < H_D (X)+1$ for one-symbol coding; block coding can approach $H_D (X)$.
  - #def[Exact optimum $R=H_D (X)$] only occurs for ideal real lengths or special integer-length distributions.
]
#fbox("Huffman Application (Group Testing)")[
  When trying to isolate a specific event (e.g., finding a single defective item) among candidates with given probabilities $p_i$:

  - *Sequential Testing:* Testing items one by one yields an expected number of trials:
    $ R = sum_i t_i dot p_i $
    where $t_i$ is the number of tests required to isolate the candidate $i$ with probability $p_i$ (follows the linearly increasing $i$).

  - *Group Testing:* Mixing items and testing groups acts exactly like building a Huffman tree. The groups correspond to the branches of the tree.

  - *Optimal Strategy:* The optimal first step is to test the group of items corresponding to the most probable branch at the root of the Huffman tree. This minimizes the expected number of tests $R$, bringing it close to the entropy $H$.
]

#fbox("Code Properties")[
  - #def[Prefix Code]: No code word is a prefix of another. It guarantees *instantaneous decoding* without waiting for future bits. (start)
  - #def[Optimal Code]: A code that achieves the *minimum expected length* (Rate) for a given probability distribution.
  - #def[Huffman Code]: An *optimal prefix* code generated by the Huffman algorithm.
]

#fbox("How to Huffman")[
  1. Start with a list of symbols and their probabilities.
  2. *Combine* the *two least probable* symbols into a *new node*, summing their probabilities.
  3. Repeat until only one node (the root) remains.
  4. Assign binary labels to branches. #imp[The choice 0/1 is arbitrary]; only the codeword lengths matter.
]

#fbbox("KL Divergence & Redundancy")[
  The redundancy of a code is intrinsically linked to the #def[Kullback-Leibler (KL) Divergence] when using a code $C_Q$ optimized for distribution $Q$ on a true distribution $P$:
  $
    &strong("Cross Rate") &quad& R_P (C_Q) = sum_i p_i L_(Q,i) \
    &strong("Redundancy") &quad& R_P (C_Q) - H(P) >= 0 \
  $

  For #imp[ideal real-valued lengths] $l_Q (x)=-log_D Q(x)$:
  $ #imp[$R_P (C_Q)-H_D (P)=D_D (P || Q)$] $

  For integer-length prefix/Huffman codes, KL divergence is only the #imp[model-mismatch part] of the redundancy; rounding/integer-length overhead is added.

  #imp[Conclusion:] For #imp[ideal real-valued lengths], KL divergence equals the mismatch redundancy. For #strong[integer-length prefix/Huffman codes], the total redundancy is the sum of the KL mismatch term #strong[plus] an integer-length rounding overhead.
]


= Source Coding & Quantization (1.3)

#fbox("Rate Distortion Theory")[
  The #def[Rate–Distortion Curve] gives the minimum required #def[rate] $R$ / entropy $H(X)$ to encode a source for a given #def[distortion] $D$.

  #def[Distortion] measures the loss introduced by quantization:
  $ D = E[d(X, hat(X))] $
  Common case:
  $ D = sigma_epsilon^2 = E[(X - hat(X))^2] = sum_i sigma_(epsilon_i) = sum_i integral_(I_i) (x - hat(x_i))^2 p(X) dif x $

  For quantization:
  - $X$: original signal
  - $hat(X)$: quantized/reconstructed signal
  - $epsilon = X - hat(X)$: quantization error
  - $sigma_x^2$: signal variance
  - $sigma_epsilon^2$: error/distortion variance
  - #imp[Relative distortion]: $sigma_epsilon^2 / sigma_x^2$

  Higher rate $R$ means more bits, smaller quantization steps, and lower distortion.
  $arrow.t R =>#h(0.2em) arrow.b D $

  A common high-rate result is #text(size: 8pt)[($R(D)=H(X)$)] :
  $ R=1/2 log_2 (sigma_x^2 / sigma_epsilon^2) $
  $ H(X) = -sum_i tilde(p)_i log_2 (tilde(p)_i)  = 1/2 log_2(phi sigma_x^2 / sigma_epsilon^2) $
  $ tilde(p)_i = integral^((2i+1)q\/2)_((2i-1)q\/2) p(x) dif x $

  - $phi$: constant depending on source distribution, #imp[often $phi = 1$]
  - A point on the curve is usually written:
    $(H(X), sigma_epsilon^2 / sigma_x^2) $

  #align(center)[
    #image("Images/Rate_distortion_curve_course.svg", width: 40%)
  ]
]

#ebox("Quantization Error Analysis (Triangular PDF Example)")[
  *1. Computing the Probability Function*
  For a signal bounded in $[-D/2, D/2]$ with a triangular probability, the area must be 1 #imp[($integral p(x) d x = 1$)], yielding a height $h = 2/D$.
  $ p(x) = cases(
    (1 + x 2/D) 2/D &"if" x < 0,
    (1 - x 2/D) 2/D &"if" x > 0
  ) $

  *2. Error Variance ($sigma_epsilon^2$)*
  Using a quantization step $q = D/3$, we integrate the squared error over each interval:
  $ sigma_(epsilon_k)^2 = integral_((k-1/2)q)^((k+1/2)q) underbrace((x - k q)^2, #imp("error function")) p(x) d x $
  #imp[Check for symmetry when you can !]
  *Separating into 3 intervals* ($[-D/2, -q/2]$, $[-q/2, q/2]$, $[q/2, D/2]$) and summing:
  $ sigma_epsilon^2 = sigma_(epsilon_(-1))^2 + sigma_(epsilon_0)^2 + sigma_(epsilon_1)^2 = D^2/486 + D^2/216 + D^2/486 = (17D^2)/1944 $
  #imp[Represents the variance of each quantization step, proportional to the signal variance.]

  *3. Signal Variance ($sigma_x^2$)*
  $ sigma_x^2 = EE[(X - mu_x)^2] stretch(=)^(mu_x=0) integral_(-D/2)^(D/2) x^2 p(x) d x = D^2/24 $

  *4. Quantization Entropy*
  Finding the #imp[probability of each quantization] bin by integrating $p(x)$ #imp[(area under curve)]:
  $ tilde(p)(-q) &= integral_(-D/2)^(-D/6) p(x) d x = 2/9 \
    tilde(p)(0) &= integral_(-D/6)^(D/6) p(x) d x = 5/9 \
    tilde(p)(q) &= integral_(D/6)^(D/2) p(x) d x = 2/9 $
  $ H = - sum tilde(p)(i) log_2 tilde(p)(i) approx 1.43 " bits" $

  *5. Rate-Distortion Point*
  Comparing the normalized distortion to the entropy:
  $ (H, sigma_epsilon^2/sigma_x^2) = (1.43, 17/81) $
]

#ebox("Quantization Error Analysis (Extra Example)")[
  #text(size: 7pt)[
    *1) Definitions*
    - *#imp[Error Var.]:* MSE of quantization error.
    - *#imp[Signal Var.]:* Signal's variance w.r.t mean.
    - *#imp[Rate]:* Expected info to transmit ($H$).
    - *#imp[Distortion]:* Fidelity loss measured as MSE.

    *2) Point on curve $(H, sigma_epsilon^2 / sigma_x^2)$*

    *1. Probability function* (Total area = 1 $-> h = 3/(4D)$)
    $ p(x) = cases(
      9/(8D^2) (D+x) & x in [-D, -D/3),
      3/(4D) & x in [-D/3, D/3],
      9/(8D^2) (D-x) & x in (D/3, D]
    ) $

    *2. Error variance* \
    To minimize distortion, $q$ is the #imp[centroid]:
    $ q &= (integral_(D/3)^D x p(x) d x) / (1/4) = (5D/36)/(1/4) = 5D/9 \
      sigma_(epsilon_0)^2 &= integral_(-D/3)^(D/3) x^2 3/(4D) d x = D^2/54 \
      sigma_(epsilon_1)^2 &= integral_(D/3)^D (x-q)^2 p(x) d x
      stretch(=)^"Expand" underbrace(D^2/12 - 50D^2/324 + 25D^2/324, "Subst " q " and integrate") = D^2/162 \
      sigma_epsilon^2 &= underbrace(2 sigma_(epsilon_1)^2, "By symmetry") + sigma_(epsilon_0)^2 = D^2/81 + D^2/54 = #imp[$5D^2/162$] $

    *3. Signal variance*
    $ sigma_x^2 &= 2 integral_0^D x^2 p(x) d x stretch(=)^"Piecewise" 2 underbrace((D^2/108 + D^2/24), "Inner + Outer integrals") = #imp[$5D^2/27$] $

    *4. Quantization estimates*
    $ tilde(p)(0) &= integral_(-D/3)^(D/3) p(x) d x = 1/2; quad tilde(p)(plus.minus q) = 1/4 \
      H &= - sum tilde(p)(i) log_2 tilde(p)(i) stretch(=)^"Group" -[2(1/4 log_2(1/4)) + 1/2 log_2(1/2)] \
      &= 1 + 0.5 = #imp[1.5 " bits"] $

    *5. Final point*
    $ (H, sigma_epsilon^2/sigma_x^2) &= (1.5, (5D^2/162) / (5D^2/27)) \
      &= #imp[(1.5, 1/6)] $
  ]
]


#exerbox("Extra Exercises LINGI2348 — Entropy, Huffman, Rate-Distortion")[
  #subdefbox("Useful reminders")[
    - #def[Entropy:] $H(X) = - sum_x p(x) log_2 p(x)$
    - #def[Joint entropy:] $H(X,Y) = - sum_(x,y) p(x,y) log_2 p(x,y)$
    - #def[Conditional entropy:] $H(X|Y) = H(X,Y) - H(Y)$, $H(Y|X) = H(X,Y) - H(X)$
    - #def[Mutual information:] $I(X;Y) = H(X) - H(X|Y) = H(Y) - H(Y|X) = H(X)+H(Y)-H(X,Y)$
    - All logs are in base $2$, so results are in #imp[bits].
  ]

  #hline()

  #underline[*Exercise 1 — Entropy and Mutual Information*] \

  Joint distribution:
  #align(center)[
    #table(
      columns: 5, align: center, stroke: 0.3pt + luma(70%),
      [$P(X,Y)$], [$Y=0$], [$Y=1$], [$Y=2$], [$Y=3$],
      [$X=0$], [$1/12$], [$2/12$], [$0$], [$0$],
      [$X=1$], [$2/12$], [$0$], [$0$], [$1/12$],
      [$X=2$], [$0$], [$0$], [$2/12$], [$1/12$],
      [$X=3$], [$2/12$], [$0$], [$1/12$], [$0$],
    )
  ]

  #underline[*Marginals:*] Rows all sum to $3/12 = 1/4$, so $P_X = (1/4,1/4,1/4,1/4)$. Columns: $P_Y = (5/12, 2/12, 3/12, 2/12)$.

  #underline[*a) Compute $H(X)$ and $H(Y)$*]\
  Since $X$ is uniform over $4$ values: $H(X) = log_2 4 = #imp[2]$.

  $ H(Y) &= - 5/12 log_2(5/12) - 2/12 log_2(2/12) ...\ &- 3/12 log_2(3/12) - 2/12 log_2(2/12) approx #imp[1.888] $

  #text(fill: red.darken(20%), weight: "bold")[Correction: $H(Y)$ cannot be $2.776$ bits, because $Y$ has only $4$ possible values, so $H(Y) <= log_2 4 = 2$.]

  #underline[*b/c) Compute $H(X,Y)$, $H(X|Y)$, $H(Y|X)$*]\
  Four probabilities $= 1/12$, four $= 2/12$:
  $ H(X,Y) &= -4 dot 1/12 log_2(1/12) -4 dot 2/12 log_2(2/12) approx #imp[2.918] \
   H(X|Y) &= H(X,Y) - H(Y) approx 2.918 - 1.888 = #imp[1.030] \
   H(Y|X) &= H(X,Y) - H(X) approx 2.918 - 2 = #imp[0.918] $

  #underline[*d) Compute $I(X;Y)$*]\
  $ I(X;Y) = H(X) + H(Y) - H(X,Y) approx 2 + 1.888 - 2.918 = #imp[0.970] $

  #text(fill: red.darken(20%), weight: "bold")[Correction: if you got around $1.858$, that comes from the wrong value of $H(Y)$ or $H(X|Y)$.]

  #hline()

  #underline[*Exercise 2 — Huffman Coding*] \

  Sentence: $"which witch is which?"$

  #imp[Important:] count the spaces and the question mark too. The sentence has $21$ characters, not $22$.

  Frequencies:
  #align(center)[
    #table(
      columns: 4, align: center, stroke: 0.3pt + luma(70%),
      [Character], [Frequency], [Character], [Frequency],
      [$h$], [$5$], [$i$], [$4$],
      [$w$], [$3$], [$c$], [$3$],
      [$"space"$], [$3$], [$?$], [$1$],
      [$t$], [$1$], [$s$], [$1$],
    )
  ]

  One valid #def[Huffman code]:
  #align(center)[
    #table(
      columns: 4, align: center, stroke: 0.3pt + luma(70%),
      [Character], [Code], [Character], [Code],
      [$i$], [$00$], [$h$], [$01$],
      [$w$], [$100$], [$c$], [$101$],
      [$"space"$], [$110$], [$?$], [$1110$],
      [$t$], [$11110$], [$s$], [$11111$],
    )
  ]

  #text(fill: orange.darken(20%), weight: "bold")[Huffman codes are not unique: another code with the same lengths is also optimal.]

  Total encoded length: $4 dot 2 + 5 dot 2 + 3 dot 3 + 3 dot 3 + 3 dot 3 + 1 dot 4 + 1 dot 5 + 1 dot 5 = #imp[59 " bits"]$\
  Average length: $macron(L) = 59/21 approx 2.81 "bits/symbol"$

  Fixed-length coding for $8$ symbols: $ceil(log_2 8) = 3 " bits/char"$, total $21 dot 3 = 63 " bits"$.
  #imp[Huffman saves $4$ bits on this sentence.]

  Encoded sentence: $10001001010111010000111101010111000111111101000100101011110$

  #hline()

  #underline[*Exercise 3 — Rate-Distortion Performance*] \
  Distribution: symmetric on $[-D, D]$, flat on $[-D/3, D/3]$, linear down to $0$ at $plus.minus D$.
  Quantization step $q = 2D/3$, $3$ intervals: $[-D, -D/3], [-D/3, D/3], [D/3, D]$ with reconstruction values $-2D/3, 0, 2D/3$.

  #underline[*a) Definitions*]
  - #def[$sigma^2$:] source variance $= E[(X-E[X])^2]$; here $E[X]=0$ (symmetric).
  - #def[Distortion measure:] usually squared error $d(x, hat(x)) = (x - hat(x))^2$.
  - #def[Average distortion $bar(d)$:] $bar(d) = E[(X-hat(X))^2]$.
  - #def[Rate $R$:] entropy coding: $R = H(hat(X))$; fixed-length over $M$ levels: $R = log_2 M$.

  #underline[*Quantization probabilities*]\
  Middle rectangle area: $P(hat(X)=0) = 1/2$. By symmetry: $P(hat(X)=-2D/3) = P(hat(X)=2D/3) = 1/4$.
  So $P_(hat(X)) = (1/4, 1/2, 1/4)$.

  #underline[*Rate*] $R = H(1/4, 1/2, 1/4) = -2 dot 1/4 log_2(1/4) - 1/2 log_2(1/2) = #imp[3/2 " bits/sample"]$.
  Fixed-length: $R_"fixed" = log_2 3 approx 1.585 " bits/sample"$.

  #underline[*Average distortion*]\
  Height $h = 3/(4D)$. Middle: $integral_(-D/3)^(D/3) x^2 h dif x = D^2/54$. Each side (reconstruction $2D/3$): $integral_(D/3)^D (x-2D/3)^2 p(x) dif x = D^2/108$.
  Total: $bar(d) = D^2/54 + 2 dot D^2/108 = #imp[$D^2/27$]$.
  Source variance: $sigma^2 = E[X^2] = #imp[$5D^2/27$]$. Hence $bar(d) = D^2/27 = #imp[$sigma^2/5$]$.

  #underline[*b) Rate-Distortion point*]\
  Achievable point: $#imp[$(R, bar(d)) = (3/2, D^2/27)$]$ or $#imp[$(3/2, sigma^2/5)$]$.
  With fixed-length: $#imp[$(log_2 3, D^2/27)$]$.

  #text(fill: orange.darken(20%), weight: "bold")[This is an achievable rate-distortion point from the given quantizer, not necessarily the optimal full rate-distortion function.]

]

/*
#fbox("Self-Information & Binary Entropy")[
  #def[Self-information]: $I(x) = log_2(1/P(x)) = -log_2 P(x)$
  - Rare $->$ high info; certain $->$ $I=0$; independent: $I(x,y)=I(x)+I(y)$
  - Entropy = #imp[expected self-info]: $H(X) = EE[I(X)] = sum_x P(x) log_2(1/P(x))$

  #hline()

  #def[Binary entropy] for $P(1)=p$, $P(0)=1-p$:
  $ H_b (p) = -p log_2 p - (1-p) log_2(1-p) $
  $ H_b (0)=0, quad H_b (1)=0, quad H_b (1/2)=1 $
]

#fbox("Uniquely Decodable Codes & Kraft-McMillan")[
  $x_i -> c_i, l_i = |c_i|$. Hierarchy: #def[Non-singular] $<-$ #def[Uniquely decodable] $<-$ #def[Prefix] ($=>$ instantaneous).

  #hline()

  #def[Kraft-McMillan:] for $D$-ary prefix/uniquely decodable code:
  $ #imp[$sum_i D^(-l_i) <= 1$] $
  Optimal complete prefix tree: $sum_i D^(-l_i) = 1$.
]

#fbox("Shannon Source Coding Theorem")[
  $ H_D (X) = - sum_i p_i log_D p_i, quad R = sum_i p_i l_i >= H_D (X) $

  #def[Shannon construction:] $l_i = ceil(-log_D p_i) arrow.double H_D (X) <= R < H_D (X) + 1$
  #def[Block coding:] encode $n$ symbols $arrow.double H_D (X) <= R_n < H_D (X) + 1/n$, so $R_n -> H_D (X)$.
  #imp[Entropy = minimum avg code symbols per source symbol.]
]

#fbox("Discrete Memoryless Channel (DMC)")[
  A #def[channel] maps input $X$ to output $Y$ probabilistically via transition matrix $P_"channel"$:
  $ P_"channel" = mat(P(y_1|x_1), P(y_2|x_1), dots; P(y_1|x_2), P(y_2|x_2), dots; dots, dots, dots) $

  $ P(x,y) = P(x)P(y|x), quad P(y) = sum_x P(x)P(y|x) $
  $ I(X;Y) = underbrace(H(Y), #place(center)[#text(size: 7.5pt)[output uncert.]]) - underbrace(H(Y|X), #place(center)[#text(size: 7.5pt)[noise]]) = H(X) - H(X|Y) $

  #hline()

  #def[Capacity:] $C = max_(P(x)) I(X;Y)$ — #imp[maximum mutual information] over all input distributions.
  - $H(Y)$: output uncertainty; $H(Y|X)$: noise; $I(X;Y)$: #imp[useful information transmitted].
]

#fbox("Binary Symmetric Channel (BSC)")[
  Binary input/output with error probability $epsilon$:
  $ P(Y|X) = mat(1 - epsilon, epsilon; epsilon, 1 - epsilon) $
  $ P(Y=X) = 1 - epsilon, quad P(Y != X) = epsilon $

  Uniform input $P(X=0)=P(X=1)=1/2$ maximizes:
  $ H(Y)=1, quad H(Y|X)=H_b (epsilon) $
  $ I(X;Y) = 1 - H_b (epsilon) quad => quad #imp[$C = 1 - H_b (epsilon)$] $

  #hline()

  Key cases: $epsilon = 0 => C = 1$; $epsilon = 1/2 => C = 0$
]

#fbox("Continuous Sources & Differential Entropy")[
  For continuous $X$ with density $f_X (x)$:\
  #def[Differential entropy]: $h(X) = - integral f_X (x) log_2 f_X (x) d x$
  - Can be negative; depends on scale: $h(a X) = h(X) + log_2 |a|$

  #hline()

  #def[Gaussian max entropy:] Among all variables with variance $sigma^2$, Gaussian achieves #imp[maximum]:
  $ h(X) <= 1/2 log_2(2 pi e sigma^2) quad "equality iff" X ~ cal(N)(0, sigma^2) $

  #hline()

  Link to quantization: $H(X_q) approx h(X) - log_2 q$ where $q$ is quantization step.
]

#fbox("Transform Coding & Decorrelation")[
  Natural signals have #def[redundancy]: neighboring samples are correlated.
  Transform coder: $y = H x$ with orthonormal $H$ ($H^T H = I$) preserving energy $||y||^2 = ||x||^2$.

  #def[Autocovariance:] $Gamma_x (k) = EE[(x(n)-mu_x)(x(n+k)-mu_x)]$
  #imp[Goal:] $Gamma_y " diagonal"$ — energy concentrated in fewer coefficients.
  - Quantization then spends many bits on important coefficients, few on weak ones.
]

#fbox("Uniform Quantizer: Core Formulas")[
  Interval width $D$, $N$ levels:
  $ q = D/N, quad R = log_2 N, quad epsilon = y - I_q in [-q/2, q/2] $

  Error approximated as uniform: $ sigma_epsilon^2 = q^2/12 $
  For uniform source on $D$: $sigma_y^2 = D^2/12$
  $ sigma_epsilon^2 / sigma_y^2 = (q^2/12)/(D^2/12) = 1/N^2 = 2^(-2R) $
  #imp[Every extra bit $approx$ divides distortion by 4.] $R = 1/2 log_2(overbrace(sigma_y^2, #place(center, dy: -0.6em)[#text(size: 9pt)[signal variance]]) / underbrace(sigma_epsilon^2, #place(center)[#text(size: 9pt)[distortion]]))$
]

#fbox("Quantization + Entropy Coding")[
  Encoder transmits #def[bin index] $I_k$, not real value $y$.
  $ p_i = integral_(B_i) f_Y (y) d y $
  Fixed-length: $R_"fixed" = log_2 N$; Entropy: $R_"entropy" approx H(I) = -sum_i p_i log_2 p_i$
  Since $H(I) <= log_2 N$, #imp[entropy coding reduces rate] when bins are non-uniform.

  #hline()

  Compression chain: $x(n) -> "Transform" -> y_k -> "Quantizer" -> I_k -> "Entropy coding" -> "bits"$
]

#tbox("Variable Rate Coding & Buffer")[
  Encoder produces variable bits: easy regions $->$ few bits, complex $->$ many bits.
  A #def[buffer] smooths the bitstream: $"Encoder" -> "Buffer" -> "Channel"$

  #hline()

  #def[Rate control:] Buffer too full $->$ increase $q$ (fewer bits, more distortion);
  Buffer too empty $->$ decrease $q$ (more bits, less distortion).
  Compromise between #imp[rate $R$] and #imp[distortion $D$].
]

#fbox("LZW: Dictionary Coding")[
  #def[LZW] — #imp[universal lossless compression]. No probabilities needed.
  - Encoder/decoder build same dictionary while reading data.
  - Repeated strings replaced by one dictionary code.
  - Initial dictionary: single symbols $->$ codes $0..255$ (byte-based).
  - New phrases start at code $256$; typical table size $4096$ entries.

  #hline()

  #imp[Compression: a long repeated phrase is represented by one code.]
]

#fbox("LZW Encoding Algorithm")[
  #underline[*Variables:*] $P$ = current phrase, $C$ = next char, $P+C$ = extended phrase.
  #underline[*Algorithm:*]
  1. Initialize dictionary with all single-character strings.
  2. $P <-$ first input character.
  3. Read next char $C$.
  4. If $P+C$ in dictionary: $P <- P+C$.
  5. Else: output code of $P$; add $P+C$ to dictionary; $P <- C$.
  6. Repeat until end; output code of final $P$.

  #hline()

  #imp[Mnemonic:] output longest known phrase, then teach dictionary that phrase + next char.
]

#fbox("LZW Decoding Algorithm")[
  #underline[*Variables:*] $"OLD"$ = previous code, $"NEW"$ = current code, $S$ = decoded string, $C$ = first char of $S$.
  #underline[*Algorithm:*]
  1. Initialize dictionary with all single-character strings.
  2. Read first code $"OLD"$, output its translation.
  3. For each next code $"NEW"$:
     - If $"NEW"$ in dictionary: $S = "translation"("NEW")$
     - If $"NEW"$ not in dictionary: $S = "translation"("OLD") + "first"("translation"("OLD"))$
     - Output $S$; $C <-$ first char of $S$.
     - Add $"translation"("OLD") + C$ to dictionary; $"OLD" <- "NEW"$.

  #hline()

  #imp[Special case:] unknown code = previous phrase + its own first character.
]

#tbox("Multimedia Coding Topics (Exam Reference)")[
  #underline[*Key concepts to know:*]
  - #def[Run-length coding]: encode repeated values by their length.
  - #def[Anti-aliasing]: #imp[sample above $2 times$ max frequency], or low-pass before sampling.
  - #def[Color spaces:] RGB vs YUV/YCbCr; #imp[luminance treated differently] from chrominance.
  - #def[JPEG:] split into $8 times 8$ blocks, DCT, quantize, zig-zag scan, entropy code.
  - #def[DCT:] concentrates image energy into #imp[low-frequency coefficients].
  - #def[Video coding:] I-frames, P-frames, B-frames, motion vectors, residuals, GOP.
  - #def[JPEG 2000:] wavelet-based, #imp[scalable by resolution and quality].

  #hline()

  #imp[Add full section only if part of the exam.]
]
*/
#block(fill: red, "TODO - ADD many things from the CM that are not yet here, and better covering of some of the exercises that are sometimes missing or not very illustrative. Add old exam questions.", inset: 0.4em)



#pagebreak(to: "odd")


= Channel Coding & Information Theory (2.1) // TODO : Check if everything is there, i think i'm missing stuff, or stuff is not well formated

// TODO: CHECK SLIDES

#tbox("Repetition Code")[
  *#text(fill: purple)[Order 3 Repetition:]* $#text(fill: blue)[0] -> 000$ and $#text(fill: blue)[1] -> 111$ #text(fill: green)[(Part of a dictionary)]

  #align(center)[
    $underbrace(0 0 0, #text(fill: blue)[0]) quad underbrace(0 #text(fill: red)[1] 0, #text(fill: red)[0]) quad underbrace(1 1 1, #text(fill: blue)[1]) -> "corrected (66%)" -> "Detected"$
  ]
]

#tbox("Hamming Code")[
  *#text(fill: purple)[(7,4) Hamming:]* $k=4$ information bits, $n=7$ code bits, redundancy $r=n-k=3$.

  The parity-check matrix $H$ has size $3 times 7$. Its columns must be the seven #imp[non-zero] 3-bit vectors:
  $ H = [h_1 h_2 dots h_7], quad h_i in FF_2^3, quad h_i != 000, quad h_i != h_j " for " i != j $

  #underline[*Syndrome rule:*]
  For a received word $y=x+e$:
  $ #imp[$s = H y^T = H e^T$] $
  If there is a single error at position $i$, then $e=e_i$ and:
  $ #imp[$s = H e_i^T = h_i$] $
  So the syndrome is the #imp[column of $H$ corresponding to the error position].

  #text(fill: red.darken(20%), weight: "bold")[Never use a zero column in a Hamming parity-check matrix.]\
  A zero column makes an error in that position invisible: $s=0$.

  #underline[*Example column convention:*]
  $ h_1=001, h_2=010, h_3=011, h_4=100, h_5=101, h_6=110, h_7=111 $
  Under this convention, syndrome $110$ means: error in position $6$.
]



#fbox("Source vs. Channel Coding")[
  - *Source Coding (Compression):* Removes redundancy $-> "Outputs binary sequence " \{0,1\}$.
  - *Channel Coding (Protection):* Adds controlled redundancy $-> "Outputs sequence in channel alphabet " A$.
  - #def[Separation Principle]: Practical & theoretical advantage to treating them as independent blocks.

  #v(0.5em)
  $ underbrace(U,"Compressed source\n Independent bits") -> #h(0.4em) #block(stroke: 0.05em, inset: 0.3em, [Channel\ Coding]) #h(0.4em) stretch(->)^x_underbrace(x in A,  #text(size:13pt)[size K]) #h(0.4em) #block(radius: 3em, stroke: 0.05em, inset: 0.3em, [Channel]) #h(0.4em) stretch(->)^y_underbrace(y in B, #text(size:13pt)[size J]) $

  #v(0.5em)
  #underline[*Clocks & Speeds:*]
  $ &tau_s : text("Time interval between bits of (compressed) source") \
    &tau_c : text("Time interval between letters in channel") $
  #imp[Perfect Source Coding:] #text(size: 12pt)[$tau_s^* / tau_s = H("Source")$] #text(fill: green.darken(20%), size: 6.5pt, weight: "bold")[$->$ Before compression]\
]

#fbox("Block Coding Basics")[
  Binary inputs are grouped into *blocks of fixed size $k$*. The coder maps them to #def[codeword] of length $n$ in alphabet $A = \{a_1, ..., a_K\}$.
  $ n = floor(k tau_s / tau_c) $
  - *Codebook* $cal(C)$: A subset of $A^n$ containing $M$ valid codewords.
  - *Size & Introduce Redundancy:* Not all output codes used
    $ underbrace(M = 2^k, #text(fill: orange)[Used space]) << underbrace(K^n, #text(fill: orange)[Total space $A^n$]) $
  - *Time Constraint:* We don't always need the full bandwidth:
    $ underbrace(k tau_s, "Source time") >= underbrace(n tau_c, "Channel time") $
]

#fbox("Code Rate (R)")[
  The #def[Code Rate] $R$ measures the *information efficiency* (number of binary inputs per transmitted letter, lower is more redundant):
  $ imp(R = (log_2 M) / n = k / n stretch(=)_"integ" tau_c / tau_s) $
  - #imp[Critical Note:] if the channel is used with no slack, $R approx tau_c/tau_s$. With unused channel symbols/buffering, the speed constraint is $R >= tau_c/tau_s$.
  *Constraints:*
  + Channel speed : $R >= tau_c / tau_s$ (Redundancy $arrow.b$)
  + Channel capacity : $R <= C$ (Fit channel)
  #imp($ H(U)/tau_s <= C/tau_c $)
]

#fbox("Performance & Trade-offs")[
  *Goal:* Minimize #def[Decoding Error Probability] $pi$ (occurs if estimate $hat(m) != m$).

  #grid(columns: (1fr, 1fr), gutter: 1em,
    [
      #text(fill: blue, weight: "bold")[Decreasing Rate] $arrow.b R$ \
      - More *redundancy injected* \
      - $arrow.b pi$ (Lower error probability) \
      - Limited by the practical *channel capacity*
    ],
    [
      #text(fill: purple, weight: "bold")[Increasing Length] $arrow.t n$ \
      - *Longer blocks* used \
      - $arrow.b pi$ (Lower error probability) \
      - $arrow.t$ #text(fill: red)[Delay:] Must wait $n tau_c$ \
      - $arrow.t$ #text(fill: red)[Complexity:] $M = 2^(n R)$
    ]
  )
]

#fbox("The Memoryless Channel")[
  Sending an input sequence $X = (x_1, ..., x_n) in A$ yields output $Y = (y_1, ..., y_n) in B$.
  If the channel is #def[memoryless], the probability of the sequence is just the product of individual symbol probabilities:
  $ imp(P(Y|X) = product_(i=1)^n P(y_i | x_i)) $
]

#fbox("Decoding Strategies (MAP vs ML)")[
  *Goal:* Given a received sequence $Y$, which transmitted sequence $X_m$ was most likely?

  - #def[MAP (Maximum A Posteriori):] #imp[Minimizes average error probability]. Requires knowing the *a priori* source probabilities $P(X_m)$.
    #v(-0.5em)
    $ hat(m) &= op("arg max")_m P(X_m|Y) \
      &= op("arg max")_m underbrace(P(X_m) P(Y|X_m), #text(fill: blue.darken(20%))[Numerator of\ Bayes Theorem]) $
    #v(-0.7em)
    $ #text(fill: luma(30%), size: 7pt)[$P(Y)=sum_(m=0)^(M-1) P(X_m)P(Y|X_m)quad$ (is $plus.minus$ constant)] $
  - #def[ML (Maximum Likelihood):] MAP assuming #imp[equiprobable messages] ($P(m) = P(X_m) = 2^(-k)$, making it a constant). Depends *only* on channel characteristics.
    $ hat(m) = op("arg max")_m underbrace(P(Y|X_m), #text(fill: green.darken(20%))[Likelihood of\ channel output]) $
]

#fbox("Decoding Subsets & Error Probability")[
  Decoding is a *deterministic* function that partitions the output space $B^n$ into disjoint decision regions $Y_m$.
  #align(center)[
    #text(fill: purple, weight: "bold")[Intuition: ] #text(fill: luma(30%))["Mark subsets around codewords. If $Y$ isn't too far from $X_m$, recover it!"]
  ]

  $ "If " Y in Y_m => "decode as message " m $

  - *Conditional Error $pi(m)$:* Probability of error *given* $m$ was sent. Happens if the received sequence lands #imp[outside] its designated subset $Y_m$:
    $ pi(m) = sum_(Y in.not Y_m) P(Y|X_m) $
  - *Average Error Probability $pi$:* Total expected error over all possible messages:
    $ imp(pi = sum_(m=0)^(M-1) pi(m)P(X_m)) $
]



#fbox("Hamming Distance & Weight")[
  - #def[Hamming Distance] $d(X, Y)$: number of positions in which two binary $n$-tuples differ.
    $ d(X, Y) = |\{ i in [1,n] : x_i != y_i \}| $

  - It is a true mathematical metric:
    #align(center)[
      #text(size: 8.5pt)[
        $d(x,y) >= 0 quad, quad d(x,y) = d(y,x) quad, quad
        underbrace(d(x,y) <= d(x,z) + d(z,y), #text(fill: green.darken(20%))[Triangle inequality])$
      ]
    ]
  - #def[Error n-tuple] $underline(e)$: indicates exactly which bit positions were flipped by the channel.
    $ Y = X + underline(e) quad (mod 2) $
    $ -> underline(e) = X + Y quad (mod 2) $

  - #def[Hamming Weight] $w(underline(e))$: number of *nonzero bits* in a tuple.
    $ d(X, Y) = w(X + Y) $
]

#fbox("Code Geometry & Correcting Capability")[
  - #def[Minimum Distance] $d(cal(C))$: smallest Hamming distance between two distinct codewords.
    $ d(cal(C)) = min_(X, X' in cal(C), X != X') d(X, X') $

    $->$ Larger $d(cal(C))$ means better separation between codewords and stronger protection against errors.

  - #def[Packing Distance] $t(cal(C))$: maximum number of errors that the code can #imp[always] correct.
    $ t(cal(C)) = floor((d(cal(C)) - 1) / 2 )$

  - #underline[*Geometric meaning:*] Hamming spheres of radius $t(cal(C))$ centered on valid codewords are #imp[disjoint].
    Therefore, if the channel introduces $s <= t(cal(C))$ errors, the received word is guaranteed to remain inside the correct sphere, so decoding is always successful.
]

#fbox("ML Decoding on BSC: Closest Neighbor")[
  For a Binary Symmetric Channel with error probability $p < 1/2$, the likelihood of receiving $Y$ given a candidate codeword $X'$ depends only on the error weight $w(underline(e)')$:
  $ P(Y | X') = p^(w(underline(e)')) (1-p)^(n - w(underline(e)')) $

  Equivalently:
  $ P(Y | X') =
    underbrace(
      (1-p)^n (p / (1-p))^(w(underline(e)')),
      #text(fill: blue.darken(20%))[decreases when $w(underline(e)')$ increases]
    )
  $
  Since $p < 1/2$, smaller error weight means higher likelihood.

  #imp[Conclusion:] ML decoding becomes #def[Minimum Distance Decoding], also called #def[Closest Neighbor Decoding].
  We choose the codeword $hat(X)$ that minimizes the Hamming distance to the received word $Y$:
  $ hat(X) = arg min_(X in cal(C)) d(X, Y) $

  Equivalently:
  $ d(hat(X), Y) <= d(X, Y) quad "for all" X in cal(C) $

  #v(0.5em)
  #text(fill: red, weight: "bold")[⚠️ Important caveats:]
  - #strong("Ambiguity:") the decoded word may not be unique, for example if $Y$ is at the same distance from two codewords.
  - #strong("Beyond guaranteed correction:") if the actual number of errors is $s > t(cal(C))$, decoding may still succeed by chance, but it is no longer guaranteed and may return the wrong codeword.
]

#tbox("Example: Decoding Beyond the Packing Radius")[
  #let ok(body) = text(fill: green.darken(25%), weight: "bold")[#body]
  #let ko(body) = text(fill: red.darken(15%), weight: "bold")[#body]
  #let pick(body) = text(fill: blue.darken(20%), weight: "bold")[#body]
  #let err(body) = text(fill: red, weight: "bold")[#body]
  #let muted(body) = text(fill: luma(40%), size: 0.9em)[#body]

  #grid(
    columns: (1fr, 1fr),
    align: center,
    $ cal(C) = mat(
      "0000000", x_1;
      "1110000", x_2;
      "0011111", x_3;
      "1101111", x_4
    ) $,
    $ D = mat(
      0, pick("3"), 5, 6;
      pick("3"), 0, 6, 5;
      5, 6, 0, pick("3");
      6, 5, pick("3"), 0
    ) $
  )

  #align(center)[
    #imp[$d(cal(C)) = 3$] $quad => quad$ #imp[$t(cal(C)) = floor((3 - 1) / 2) = 1$]
  ]

  #v(0.2em)
  #align(center)[
    #text(size: 8.2pt, fill: luma(40%))[
      *Distances:* $d(y, cal(C)) = (d(y,x_1), d(y,x_2), d(y,x_3), d(y,x_4))$
    ]
  ]
  #v(0.4em)

  #grid(
    columns: (auto, 1fr),
    gutter: 0.6em,

    [#ok[✓]],
    [
      #strong[Correct by chance:]
      $x_3 = 00111#ok[11] -> y = 00111#err[00]$ #muted[(2 errors in pos 6,7)] \
      $d(y, cal(C)) = (3, 4, #pick[2], 5) -> hat(x) = x_3$ #ok[CORRECT]
    ],

    [#ko[✗]],
    [
      #strong[Wrong nearest neighbor:]
      $x_1 = #ok[00]00000 -> y = #err[11]00000$ #muted[(2 errors in pos 1,2)] \
      $d(y, cal(C)) = (2, #pick[1], 7, 4) -> hat(x) = x_2$ #ko[INCORRECT]
    ],
  )

  #v(0.2em)
  #align(center)[
    #text(fill: orange.darken(20%), weight: "bold")[
      $s > t(cal(C))$ means “not guaranteed”, not “impossible”.
    ]
  ]
]

#fbox("Correction Capability & Error Bound")[
  #def[Theorem 3.5]: The packing distance $t(cal(C))$ is the absolute maximum amount of errors the code can correct *with certainty*.
  - #text(fill: green.darken(20%), weight: "bold")[$s <= t(cal(C))$:] Unique closest neighbor guaranteed. Perfect correction.
  - #text(fill: red, weight: "bold")[$s > t(cal(C))$:] Non-disjoint spheres exist. Decoding is generally wrong or undetermined.

  #def[Proposition 3.6 (Error Probability Bound)]: The probability of a decoding error $pi$ is bounded by the probability of an error vector falling *outside* the guaranteed correction sphere:
  $ imp(pi(underline(x)) <= sum_(i=t(cal(C))+1)^n C^i_n p^i (1-p)^(n-i)) $
  - $binom(n, i)$ or $C_n^i$ is the number of $n$-tuples of weight $i$.
  $ C^i_n = binom(n, i) = n!/(i!(n-i)!) $
  #imp[Takeaway:] If the spheres of radius $t(cal(C))$ do not completely cover the space $A^n$, some errors $> t(cal(C))$ might still be decoded correctly by chance. Thus, the actual error probability can be *strictly lower* than this bound!
]

#fbox("Space Covering & Perfect Codes")[ // TODO REWORK
  - #def[Covering Radius] $r(cal(C))$: The minimum radius $r$ such that spheres centered on all codewords will cover the *entire* space $A^n$.
    $ r(cal(C)) = max_(underline(y) in A^n) min_(underline(x) in cal(C)) d(underline(x), underline(y)) $
  - By definition: $t(cal(C)) <= r(cal(C))$

  #v(0.5em)
  #underline[*The Perfect Code:*]
  A code is #def[perfect] if $imp(t(cal(C)) = r(cal(C)))$.
  This means the disjoint spheres of radius $t(cal(C))$ form a complete *partition* of the binary space. There is absolutely #text(fill: red)[zero unfillable space] between the spheres. Every single possible received sequence belongs deterministically to exactly one sphere!
  - *Known Perfect Binary Codes:*
    - Repetition codes ($M=2, n=2m+1, t(cal(C))=m$)
    - Hamming codes ($t(cal(C))=1, n=2^r-1, k=n-r, M=2^k=2^(n-r)$)
    - Golay code ($t(cal(C))=3, n=23, M=2^12$).
]

#fbox("The Hamming Bound (Theorem 3.7)")[
  *Goal:* For a given length $n$ and distance $d(cal(C))$, we want the size $M$ maximally large  to *maximize the information rate* ($R = (log_2 M)/n$).

  The total *volume* (number of points) of $M$ disjoint spheres of radius $t(cal(C))$ cannot exceed the total number of points in the binary space $2^n$:
  $ imp(M sum_(i=0)^(t(cal(C))) C^i_n <= 2^n ) $

  - Provides a strict upper bound on the size of a code $M$ for a desired correcting capability $t(cal(C))$.
  - #strong("Equality Condition:") The formula reaches *strict equality* #imp[if and only if] the code is #def[perfect].
  - It is a volume condition.
]

/*
#fbox("The Big Picture: Core Intuition")[
  Information theory is built on measuring #def[uncertainty] and #def[shared knowledge].
  - #def[Entropy] $H(X)$: How surprised are we by an outcome? Higher entropy = more randomness = more bits needed to describe it.
  - #def[Mutual Information] $I(X;Y)$: How much does knowing $Y$ reduce our uncertainty about $X$?

  #imp[The Golden Rule:] Knowledge never hurts. Conditioning *always* reduces (or maintains) uncertainty:
  $ imp(H(X|Y) <= H(X)) $
]

#tbox("Developing the Conditional Sequence Entropy")[
  Similarly, we often need to know the uncertainty of the output sequence given the input sequence: $H(Y^N | X^N)$.

  Using the same definition and the chain rule of probability:
  $ p(y^N | x^N) = (p(x^N, y^N)) / (p(x^N)) = (product_(i=1)^N p(x_i, y_i)) / (product_(i=1)^N p(x_i)) = product_(i=1)^N p(y_i | x_i) $

  Plugging this memoryless property into the conditional entropy formula yields the same logarithmic breakdown:
  $ H(Y^N | X^N) &= - sum_(x^N, y^N) p(x^N, y^N) log_2(product_(i=1)^N p(y_i | x_i)) \
                 &= sum_(i=1)^N H(Y_i | X_i) $

  #imp[Meaning:] If the channel has no memory, the total noise/error in an $N$-length transmission is simply the sum of the noise from each individual transmission.
]

#fbox("Sequences & The Meaning of N")[
  When dealing with data over time (like sending a file), we don't just send one symbol; we send a sequence.
  - $X^N$ represents a sequence of $N$ random variables: $(X_1, X_2, ..., X_N)$.
  - In channel coding, $N$ represents #def[N consecutive uses] of a communication channel.

  The joint entropy of the entire input-output sequence is defined exactly like a single variable pair, just over the whole sequence space:
  $ H(X^N, Y^N) = - sum_(x^N, y^N) p(x^N, y^N) log_2(p(x^N, y^N)) $

  #imp[The Memoryless Development:]
  The magic happens when the channel is #def[memoryless] (meaning the noise on bit 2 doesn't depend on bit 1). This independence means the probability of the whole sequence is just the product of the individual probabilities:
  $ p(X^N, Y^N) = product_(i=1)^N p(X_i, Y_i) $

  Because of the fundamental property of logarithms ($log_2 (A dot B) = log_2 (A) + log_2 (B)$), the product inside the log splits into a sum. This allows us to pull the sum out:
  $ H(X^N, Y^N) &= - sum_(x^N, y^N) p(x^N, y^N) [sum_(i=1)^N log_2(p(x_i, y_i))] \
                &= sum_(i=1)^N H(X_i, Y_i) $

  #imp[The Theoretical Takeaway:]
  For memoryless channels, the entropy of a sequence of length $N$ is just the sum of the individual entropies. If the symbols are identically distributed (i.i.d.), the total uncertainty simply scales linearly: #imp[$N dot H(X,Y)$].
]

#tbox("Problem 1: The Memoryless Channel")[
  *The Concept:* A #def[Memoryless Channel] means that sending one symbol has absolutely no physical or statistical effect on the next. Each transmission is completely isolated.

  *The Theoretical Takeaway:*
  Because the events are purely independent, the total uncertainty of the outputs (given the inputs) is simply the #imp[sum of their individual uncertainties].

  $ H(Y^N | X^N) = sum_(i=1)^N H(Y_i | X_i) $

  #imp[Meaning:] You cannot use past or future transmissions to predict the current error. The noise acts on each symbol independently.
]

#tbox("Problem 2: The Entropy Inequality")[
  *The Concept:* The uncertainty of two variables combined is #imp[never greater] than the sum of their individual uncertainties.

  $ imp(H(X,Y) <= H(X) + H(Y)) $

  *Why?*
  Because if $X$ and $Y$ have any relationship whatsoever, they share some information ($I(X;Y) > 0$). When you combine them into a joint system, that shared overlap is only counted *once* in the joint entropy $H(X,Y)$.

  *When are they strictly equal?*
  Only when $X$ and $Y$ are #def[completely independent] ($X perp Y$). If they share zero information, their uncertainties simply stack up.
]

#tbox("Problem 3: The Data Processing Inequality")[
  *The Concept:* You #imp[cannot create new information] simply by processing or manipulating data. Information only degrades or stays the same.

  *The Markov Chain ($U -> X -> Y$):*
  This structure means that $Y$ only depends on $U$ *through* the intermediate step $X$. Once you know $X$, going back to look at $U$ gives you absolutely no extra clues about $Y$.

  *The Theoretical Takeaway:*
  $ imp(I(X;Y) >= I(U;Y)) $

  #imp[Meaning:] The information shared between the original source ($U$) and the final output ($Y$) will always be #imp[less than or equal to] the information shared between the intermediate step ($X$) and the final output ($Y$). The chain limits the flow of information.
]
*/

= Channel Coding & Binary Linear Codes (2.2)

#fbox("Linear Coding Basic Structure")[
  $
    &strong("Linear C. Notation")      &quad& (n, k) \
    &strong("Input Message") &quad& underline(u) = [u_1, ..., u_k] quad (#imp[Rank $#h(0.4em) k$]) \
    &strong("Codeword")      &quad& underline(x) = [x_1, ..., x_n] quad (#imp[Length $#h(0.4em) n$]) \
    &strong("Redundancy")    &quad& n - k \
    &strong("Code Rate")     &quad& R = k/n \
    &strong("Code Size")     &quad& M = |cal(C)| = 2^k \
  $
  #def[Systematic Code]: The #imp[first $k$ bits] of the codeword are #imp[exact copies of the message] ($x_i = u_i$). The remaining $n-k$ bits are #imp[parity bits] calculated via linear mod 2 functions of the message bits.
]

#fbox([The Dual Matrices ($H$ and $G$)])[
  #def[Parity Matrix $H$ (Size: $(n-k) times n$)] :\
  Linear system of bin. equations characterizing all valid codewords:
  $ imp(underbrace(H, (n-k) times n) thin underbrace(underline(x)^T, n times 1) = underbrace(underline(0), (n-k) times 1)) $
  *Canonical form:* $H = [underbrace(A, (n-k) times k) | underbrace(I_(n-k), (n-k) times (n-k))]$
  - Must be strictly full rank ($n-k$ unique equations) in binary algebra. Any full rank binary matrix defines a valid code.

  #hline()

  #def[Generating Matrix $G$ (Size: $k times n$)] :\
  Maps the initial message directly to the output codeword:
  $ imp(underline(x) = underbrace(underline(u), 1 times k) underbrace(G, k times n)) $
  *Canonical form:* $G = [underbrace(I_k, k times k) | underbrace(A^T, k times (n-k))]$\
  - *Parity Constraint*
  $ H underline(x)^T = 0 quad<-->quad H G underline(u)^T = 0 $
  - *Duality Rule*
  $ H G^T = 0 quad"and"quad G H^T = 0 $

  #hline()

  #def[Code Definition Equivalences ($cal(C)$ is $(M, n)$ in size)] :
  $ cal(C) = {underline(x) in {0,1}^n : H underline(x)^T = underline(0)} = {underline(u)G : underline(u) in {0,1}^k} $
]

#fbox("Equivalent Matrices (Generalization)")[
  #subdefbox("Prop 4.2 - All parity matrix of a code")[
    #imp[$H' = Q H$], where #imp[$Q$ is a nonsingular $(n-k) times (n-k)$] binary matrix. Defines the exact same code $cal(C)$ and is still full rank.\
  ]

  *Proof:* $H' underline(x)^T = Q H underline(x)^T = Q underline(0) = underline(0)$
  #subdefbox("Prop 4.3 - All generating matrics of a code")[
    $G' = P G$, where #imp[$P$ is a nonsingular $k times k$] binary matrix. Generates the same set of codewords, but creates a #imp[different mapping $u'$] between input $u$ and output $x$.\
  ]

  *Proof:* $underline(x)=underline(u)G "iff" underline(x)=(underline(u)P^(-1))(P G) = underline(u)'G'$

  #text(fill:color.orange.darken(20%))[*Note*: Canonical Codes are a deterministic way to define them.]
]

#fbox("Linear Space Structure")[
  - $0 in cal(C)$
  - If $underline(x) in cal(C)$ and $underline(x)' in cal(C)$, then
    #imp[$underline(x) + underline(x)' in cal(C)$] \
    *(check with parity matrix)*
  - Any linear binary code $(n,k)$ is a #def[linear subspace of dimension $k$]
    of the linear space ${0,1}^n$.
  - It has all the properties of a linear space.
  - $cal(C)$ is the null space defined by the parity equations:
    $ imp(cal(C) = {underline(x) in FF_2^n : H underline(x)^T = underline(0)}) $
    With column-vector convention, this is $cal(C)="Ker"(H)$.
  - $cal(C)$ is the subspace generated by the lines of $G$:
    $ imp(cal(C) = "Im"(G)) $

  #hline()

  *Closure with parity matrix:*
  $
    H underline(x)^T = 0, quad
    H underline(x)'^T = 0
    quad => quad
    H(underline(x) + underline(x)')^T = 0
  $
]

#tbox("Example: (6,3) Linear Systematic Code")[
  Given $k=3$ and $n=6$, we have $L=3$ message bits $[u_1, u_2, u_3]$.
  We define parity constraints for the last $3$ bits ($n-k$) such that:
  $ x_4 &= x_2 + x_3 => x_2 + x_3 + x_4 = 0 \
    x_5 &= x_1 + x_3 => x_1 + x_3 + x_5 = 0 \
    x_6 &= x_1 + x_2 => x_1 + x_2 + x_6 = 0 $

  *Extracting the Parity Matrix $H$* $((n-k) times n = 3 times 6)$:
  $ H = mat(
    0, 1, 1, 1, 0, 0;
    1, 0, 1, 0, 1, 0;
    1, 1, 0, 0, 0, 1
  ) = [underbrace(A, 3 times 3) | underbrace(I_3, 3 times 3)] $

  *Deriving the Generating Matrix $G$* $(k times n = 3 times 6)$:
  By taking $[I_k | A^T]$, we get:
  $ G = mat(
    1, 0, 0, 0, 1, 1;
    0, 1, 0, 1, 0, 1;
    0, 0, 1, 1, 1, 0
  ) = [underbrace(I_3, 3 times 3) | underbrace(A^T, 3 times 3)] $

  *Generating the Codebook $cal(C)$:*
  By taking all $M=2^3=8$ possible inputs for $underline(u)}$ and computing their respective parity bits, we form the complete set of valid codewords (e.g., $u=[011] -> x=[011011]$).
]

#fbox("Minimum Distance Decoding")[
  For BSC (Binary Symmetric Channel), #def[maximum likelihood decoding] is #imp[nearest neighbor decoding].
  For received vector $underline(y)$, find $hat(underline(x))$ such that:
    $
      imp(
        d(hat(underline(x)), underline(y))
        <=
        d(underline(x)', underline(y))
        quad "for all" underline(x)' in cal(C)
      )
    $
  Using the packing distance
    $ imp(t(cal(C)) = floor( (d(cal(C)) - 1) / 2 ))$
    is a lower bound on error correctability, where $d(cal(C))$ is the smallest distance between all codes.

  #subdefbox("Theo. 4.5 - Minimum distance of linear code")[
    The minimum distance of a linear code is equal to the #text(weight: "bold")[minimum weight of nonzero codewords]:
    $
      imp(
        d(cal(C)) =
        min_(underline(x) in cal(C), underline(x) != 0) w(underline(x))
      )
    $
  ]
  *Proof:* For all $underline(x), underline(x)' in cal(C)$:
  $
    d(underline(x), underline(x)')
    =
    w(underline(x) + underline(x)')
    quad "and" quad
    underline(x) + underline(x)' in cal(C)
  $
    #hline()
  *Equivalent characterization:* $d(cal(C))$ is the largest integer $s$ such that #imp[all sets of $s-1$ columns of $H$] are linearly independent.\  #hline()
  *Instinct :*
  A codeword $underline(x)$ has weight $w$ if it is a linear combination of $w$ columns of $H$ that sums to zero ($H underline(x)^T = 0$). Therefore:
  - If any $d-1$ columns are independent, no codeword of weight $w(z) < d$ exists.
  - $d(cal(C))$ is the *smallest* number of columns of $H$ that are #imp[linearly dependent].
]


#fbox("Cosets")[
  Let $cal(C)$ be a linear code $(n,k)$. For any vector $underline(a) in A^n$:
  $
    imp(
      cal(C) + underline(a)
      equiv
      {underline(x) + underline(a) : underline(x) in cal(C)}
    )
  $
  is the #def[coset of $underline(a)$ mod $cal(C)$]. It represents the set of all received vectors $underline(y)$ that would result in the same #imp[syndrome].
  - #def[Coset Leader]: The vector with the #imp[minimum Hamming weight] in a coset. It is the most probable error pattern $underline(e)$ for that coset.

  #hline()
  #underline[*Properties:*]
  #v(0.3em)
  $
    &strong("Self-membership") &quad& underline(a) in cal(C) + underline(a) \
    &strong("Equivalence")     &quad& cases(delim: #none,underline(a) "," underline(b) "in same coset iff" underline(a) - underline(b) in cal(C),
      cases(reverse: #true,underline(a)=underline(x)+a, underline(b)=underline(x')+a) => underline(a)-underline(b)=underline(x)-underline(x')in cal(C)) \
    &strong("Invariance")      &quad& b in cal(C) + a arrow.double cal(C) + a = cal(C) + b \
    &strong("Code Coset")      &quad& a in cal(C) arrow.double cal(C) + a = cal(C) \
    &strong("Cardinality")     &quad& cases(delim: #none,"Contains" |cal(C) + a| = 2^k "vectors", "With" 2^(n-k) " cosets total (no code rep.)") \
    &strong("Space Partition") &quad& cases(delim: #none,A^n = union_i (cal(C) + a_i) ,-> "The cosets of" cal(C) "form a partition of "A^n) \
  $
]

#fbox("Decoding and Cosets")[
  Given #imp[received] vector $underline(y)$, for #imp[all possible] transmitted codewords $underline(x)$, all possible error vectors are:
    $ imp(underline(e) = underline(x) + underline(y) in cal(C) + underline(y)) $
    - #def[Coset of $underline(y)$ mod $cal(C)$] : The set of all vectors $underline(y) + cal(C)$. Since $underline(y) = underline(x) + underline(e)$, this is equivalent to $underline(e) + cal(C)$, representing all possible error vectors that could result in $underline(y)$.\
    - #def[Coset leader] : The vector in a coset with the #imp[minimum Hamming weight]. It represents the most likely error vector under the assumption of a BSC with $p < 1/2$.
    - #def[ML decoding] is equivalent to #imp[choosing the coset leader] as the assumed error vector $hat(underline(e))$, such that $hat(underline(x)) = underline(y) - hat(underline(e))$.
  #hline()
  If we denote by #imp[$underline(a)_1 = 0, underline(a)_2, ..., underline(a)_(2^(n-k))$
    the coset leaders] for all cosets modulo $cal(C)$, the set of all vectors $A^n$
    can be partitioned as:
    $ A^n =
      (cal(C)) union
      (cal(C) + underline(a)_2) union
      ... union
      (cal(C) + underline(a)_(2^(n-k)))
    $
  If $underline(y) in (cal(C) + underline(a)_i)$, the decoded vector is:
    $ imp(hat(underline(x)) = underline(y) - underline(a)_i) $
]

#fbox("Standard Array")[
  #v(0.4em)
  #align(center)[
    $#table(
      columns: (auto),
      align: center,
      inset: 3pt,
      stroke: 0.4pt + luma(60%),

      table.cell(fill: orange.lighten(70%))[$cal(C)$],
      [$cal(C) + underline(a)_2$],
      [$dots.v$],
      [$cal(C) + underline(a)_(2^(n-k))$],
    ) -> #table(
      columns: (auto, auto, auto, auto),
      align: center,
      inset: 3pt,
      stroke: 0.4pt + luma(60%),

      table.cell(fill: orange.lighten(70%))[$underline(x)_1 = 0$],
      table.cell(fill: orange.lighten(70%))[$underline(x)_2$],
      table.cell(fill: orange.lighten(70%))[$...$],
      table.cell(fill: orange.lighten(70%))[$underline(x)_(2^k)$],

      table.cell(fill: aqua.lighten(70%))[$underline(a)_2$],
      [$underline(x)_2 + underline(a)_2$],
      [$...$],
      [$underline(x)_(2^k) + underline(a)_2$],

      table.cell(fill: aqua.lighten(70%))[$dots.v$],
      [$dots.v$],
      [$ $],
      [$dots.v$],

      table.cell(fill: aqua.lighten(70%))[$underline(a)_(2^(n-k))$],
      [$underline(x)_2 + underline(a)_(2^(n-k))$],
      [$...$],
      [$underline(x)_(2^k) + underline(a)_(2^(n-k))$],
    )$

  ]

  #text(fill: orange, weight: "bold")[First line] : codewords $underline(x)_1 = 0, underline(x)_2, ... in cal(C)$\
  #text(fill: aqua, weight: "bold")[First column] : coset #imp[leaders] $underline(a)_1 = 0, underline(a)_2, ... in A^n$\
  Vector in position $(i,j) ->$ Vectors not in code $cal(C)$ :
    $
      imp(underline(x)_j + underline(a)_i)
      quad
      1 <= i <= 2^(n-k),
      quad
      1 <= j <= 2^k
    $
  - Contains all $2^n$ vectors $in A^n$.

  #hline()

  *Decoding process:*
  - #imp[Locate] the received vector $underline(y)$ within the body of the std. array.
  - The chosen error vector $hat(underline(e))$ is the *coset leader* (the first entry of that #imp[row]).
  - The decoded codeword $hat(underline(x))$ is the valid codeword (the first entry of that #imp[column]).
  - Verify that $underline(y) = hat(underline(x)) + hat(underline(e))$.
]

#fbox("Syndrome")[
  *Objective:* find the vector $underline(y)$ in table, or find the coset containing $underline(y)$.

  #subdefbox("Definition - Syndrome")[
    For a linear code $(n,k)$, with parity matrix $H$, the #def[syndrome] of any vector
    $underline(y) in A^n$ is the #imp[column vector] of size $(n-k)$ defined by:
    $
      imp(underline(s) = H underline(y)^T)
    $
    It provides a #imp[signature of the error], indicating which parity equations are not satisfied.
  ]
  #underline([*Properties*]):
  - *Count* : There are $2^(n-k)$ possible syndromes, matching the number of cosets.
  - *Equivalence (Prop. 4.8)* : Two vectors $underline(y), underline(y)'$ share the same syndrome #imp[iff] they belong to the same coset.
  - *Null Syndrome* : The code $cal(C)$ itself corresponds to the coset with a null syndrome:
    $ imp(underline(s) = H underline(x)^T = underline(0)) $
  - *Error Linearity* : Since $underline(y) = underline(x) + underline(e)$, the syndrome depends *only* on the error pattern:
    $ imp(underline(s) = H underline(y)^T = H (underline(x) + underline(e))^T = H underline(e)^T) $
  - *Column Sum* : The syndrome is the #imp[sum of the columns of $H$] at positions where errors occur in $underline(e)$.
  - #def[Covering Radius] : $r(cal(C))$ is the maximum weight among all coset leaders:
    $ imp(r(cal(C)) = max_(underline(y) in A^n) min_(underline(x) in cal(C)) underbrace(w(underline(y) - underline(x)),"Weight of coset leaders")) $

  #hline()
  #underline[*Syndrome Decoding Strategy:*]
  1. *Preprocessing:* Pre-calculate the syndrome for each coset leader $underline(a)_i$:
     $ imp(underline(s)_i = H underline(a)_i^T) $
  2. *Reception:* Compute $underline(s)_y = H underline(y)^T$ for the received vector.
  3. *Identification:* Match $underline(s)_y$ to the corresponding coset leader $underline(a)_i$.
  4. *Correction:* Recover the codeword by subtracting the error pattern:
     $ imp(hat(underline(x)) = underline(y) - underline(a)_i) $

  #hline()
  #text(size: 8pt)[
    *Efficiency:* This method is ideal when redundancy is low ($n-k < k$), as the lookup table size $2^(n-k)$ remains manageable. ML becomes better at higher at lower rates (higher redundancy).
  ]

]

#fbox("Hamming Code")[
  #underline[*Generic Definition:*]
  - *Goal:* For a fixed redundancy $r = n - k$, find a binary linear code able to #imp[correct 1 error] with the largest possible rate $R = k/n = (n-r)/n$ (maximize bit uniqueness)
  - *Constraint:* To correct 1 error, we need $d(cal(C)) >= 3$. For a parity-check matrix $H$, this means that any 2 columns of $H$ must be linearly independent. Over $F_2$, this means all columns must be #imp[distinct and non-zero].
  - *Maximum Length:* Since there are only $2^r - 1$ non-zero binary $r$-tuples, the maximum possible length is #imp[$n = 2^r - 1$].


  #subdefbox([Hamming code $cal(H)_r$])[
    The binary Hamming code of redundancy $r$ has:
    - #strong("Length:") $n = 2^r - 1$
    - #strong("Rank (Dimension):") $k = n - r$
    - #strong("Parity Matrix:") $H$ contains #imp[all $2^r - 1$ non-zero binary vectors] as columns.
  ]

  #underline[*Example*]: $cal(H)_3$ ($n=7, k=4$)\
  The parity-check matrix $H$ ($3 times 7$) consists of all unique 3-bit non-zero columns:
  $ H = mat(
    0, 0, 0, 1, 1, 1, 1;
    0, 1, 1, 0, 0, 1, 1;
    1, 0, 1, 0, 1, 0, 1
  ) $

  #hline()
  #underline([*Properties*]):

  - #def[The Hamming code $cal(H)_r$ is a perfect code.]\
    *Proof:* Each sphere of radius 1 contains $n + 1 = 2^r$ points. Since $d = 3$, these spheres are disjoint. The #imp[total volume] of the $M = 2^k$ spheres is $2^k dot 2^r = 2^(k+r) = 2^n$, so they cover the entire binary space $A^n = {0,1}^n$
  - *Equivalence*: Two codes are #imp[equivalent] if they #imp[differ only by a permutation] of bit order.
  - *Uniqueness*: $cal(H)_r$ is unique; all $(2^r-1, 2^r-r-1)$ codes with $d=3$ are #imp[equivalent] (reordering columns of $H$).\
  #v(0.3em)
  *Note:* Covering radius $rho(cal(C)) = t(cal(C)) = 1$.
]

#fbox("Duality & Dual Codes")[
  #def[Duality] in binary linear codes is based on the #def[scalar product] modulo 2:
  $ underline(x) dot underline(y) = sum_(i=1)^n x_i y_i quad (mod 2) $
  Two vectors are #imp[orthogonal] if their scalar product is zero.

  The #def[Dual Code] $cal(C)^perp$ contains all vectors orthogonal to every codeword in $cal(C)$:
  $ imp(cal(C)^perp = \{ underline(y) in {0,1}^n : underline(x) dot underline(y) = 0 quad forall underline(x) in cal(C) \}) $

  #underline[*Key Properties:*]
  - If $cal(C)$ is $(n, k)$, then $cal(C)^perp$ is an #imp[$(n, n-k)$] linear code.
  - The #imp[Generating Matrix $G$] of $cal(C)$ is a #imp[Parity Matrix $H^perp$] of $cal(C)^perp$
  - The #imp[Parity Matrix $H$] of $cal(C)$ is a #imp[Generating Matrix $G^perp$] of $cal(C)^perp$
  - *Duality Constraint:* $G H^T = 0$ and $H G^T = 0$
    $ cases(reverse: #true, underline(x)=underline(u) G &-> H underline(x)^T = 0,underline(y)=underline(v) H &-> G underline(y)^T = 0) quad underline(x) dot underline(y) = underline(x) underline(y)^T = underline(u) underbrace((G H^T), =0) underline(v)^T = 0 $
  - If $cal(C)^perp$ has dimension $k' = n-k$, then redundancy is $n-k' = k$.
  - #def[Self-Orthogonal]: $cal(C) subset.eq cal(C)^perp$; all codewords mutually orthogonal.
  - #def[Self-Dual Code]: A code where $cal(C) = cal(C)^perp$. This requires $n = 2k$, but $n = 2k$ alone is not sufficient.
]

#fbox("Simplex Code")[
  - #def[Simplex Code $cal(S)_r$] of dimension $r$ is the #imp[dual of Hamming $cal(H)_r$].
  - #strong("Generating Matrix:") $G$ ($r times n$) contains #imp[all $2^r - 1$ unique non-zero binary $r$-tuples] as its columns.
  - #strong("Constant Weight (Prop 4.13):") All non-zero codewords have #imp[identical weight] $w = 2^(r-1)$. Consequently, $d(cal(C)) = 2^(r-1)$.
  - #strong("Plotkin Optimal:") Meets the bound $M <= floor((2d)/(2d - n))$ with equality ($2^r = 2^r$), maximizing distance for a given $n$ and $M$.
]

#fbox("Modification of a Code")[
  Useful for proofs or adjusting rates/protection:
  - #def[Extension]: Add a #imp[global parity control bit] (length $+1$). $tilde(H)$ adds a row of 1s and a column of 0s (except at the new row).
  - #def[Puncture]: #imp[Remove parity bits]. ($R arrow.t, d arrow.b, k arrow.b$).
  #hline()
  - #def[Expurgate]: #imp[Remove codewords] (e.g., remove all odd-weight words).
  - #def[Augment]: #imp[Add codewords] (e.g., add $underline(1)$ to $G$).
  - #def[Lengthen]: #imp[Add info bits] and include them in parity equations.
  - #def[Shorten]: #imp[Remove info bits]; restrict to codewords where those bits were 0. (Remove column from $H$).
]

= Channel Coding & Galois Fields (2.3)

#fbox([Finite Field Construction $"GF"(2^m)=FF_(2^m)$])[
  Given an #def[irreducible polynomial] $pi(x) in F_2[x]$ of degree $m$, the field $F_(2^m)$ is constructed by taking polynomials modulo $pi(x)$, where $alpha$ is a root ($pi(alpha)=0$).

  - #strong("Context") : $F_2[x]$ is the ring of polynomials over $F_2$. $F_(2^m)$ is a #def[Galois field], an extension of $F_2$.
  - #strong("Size / Uniqueness") : #imp[$2^m$ elements], unique #imp[up to isomorphism].
  - #strong("Representation") : Each element $gamma$ is a polynomial of degree $< m$:
    $ gamma = c_0 + c_1 alpha + ... + c_(m-1) alpha^(m-1), quad c_i in \{0,1\} $
    equivalently $gamma = (c_0, c_1, ..., c_(m-1))$.
  - #strong("Addition / Subtraction") : #imp[Bitwise XOR]; in binary fields, subtraction = addition.
  - #strong("Multiplication") : Polynomial multiplication #imp[modulo $pi(x)$], using the identity $pi(alpha)=0$.
  - #def[Irreducible Polynomial]: Cannot be factorized into lower-degree polynomials within $F_2$.
  - #def[Primitive Polynomial]: Irreducible $pi(x)$ whose root $alpha$ has #imp[order $2^m-1$]:
    $ alpha^(2^m-1)=1 quad "and" quad alpha^s != 1 " for " 1 <= s <= 2^m-2 $
    Then $alpha$ is a #def[primitive element] and generates all non-zero field elements.

  #underline([*Examples of Irreducible Polynomials:*])
  #text(size: 8pt,align(center, table(
    columns: 4, align: center, stroke: 0.3pt + luma(70%),
    [$x$], [$x + 1$], [$x^2 + x + 1$], [$x^3 + x + 1$],
    [$x^3 + x^2 + 1$], [$x^4 + x + 1$], [$x^4 + x^3 + 1$], [$x^4 + x^3 + x^2 + x + 1$]
  )))

  #underline([*Properties*]):\
  - Every irreducible polynomial of degree $m$ #imp[divides $x^(2^m)-x$].
  - If $pi(x) != x$, then #imp[$pi(x)$ divides $x^(2^m-1)+1$].
  - For every non-zero $gamma in F_(2^m)$: #imp[$gamma^(2^m-1)=1$].
  - If $alpha$ is primitive:
    $ F_(2^m)^* = \{1, alpha, alpha^2, ..., alpha^(2^m-2)\}, quad alpha^(2^m-1)=1 $
    and #imp[$alpha^i dot alpha^j = alpha^((i+j) mod (2^m-1))$].
]

#tbox([Example: $F_8$ with $pi(x) = x^3 + x + 1$])[
  Here, $alpha^3 + alpha + 1 = 0$, so #imp[$alpha^3 = alpha + 1$].
  - $alpha^4 = alpha(alpha + 1) = alpha^2 + alpha$
  - $alpha^5 = alpha(alpha^2 + alpha) = alpha^3 + alpha^2 = alpha^2 + alpha + 1$
  - $alpha^6 = alpha(alpha^2 + alpha + 1) = alpha^3 + alpha^2 + alpha = alpha^2 + 1$
  - $alpha^7 = alpha(alpha^2 + 1) = alpha^3 + alpha = alpha + 1 + alpha = 1$

  $F_8 = \{0, 1, alpha, alpha^2, alpha^3, alpha^4, alpha^5, alpha^6\}$
]

#fbox("Conjugate Elements")[
  For any $beta in FF_(2^m)$, its #def[conjugates] are the elements obtained by successive squaring:
  $ \{beta, beta^2, beta^4, beta^8, ..., beta^(2^(t-1))\} $
  - *Cyclic property:* The sequence #imp[cycles] because $beta^(2^m) = beta$.
  - *Relation:* $beta$ and $gamma$ are conjugates if $gamma = beta^(2^i)$ for some $0 <= i < m$.
  - *Partition:* $FF_(2^m)$ can be #imp[partitioned] into disjoint #def[conjugacy classes].
  - *Minimal Polynomial:* All conjugates in a set share the same #def[minimal polynomial] (they are roots of the same irreducible polynomial in $FF_2[x]$).
  #v(0.5em)
  *Ex*: $FF_8 = {0} union {1} union {alpha, alpha^2, alpha^4} union {alpha^3, alpha,^6, alpha^5}$
]

#fbox("Minimal Polynomials")[
  #def[Minimal Polynomial] $M_beta (x) in F_2 [x]$ of an element $beta in F_(2^m)$ is the monic polynomial of smallest degree such that $M_beta(beta) = 0$.

  - #strong("Conjugate Property:") If $P(beta)=0$ for $P in F_2 [x]$, then $P(beta^(2^i)) = 0$. $M_beta (x)$ is the zero for #imp[all conjugates] of $beta$.
  - #strong("Construction:") $M_beta (x) = product_(i=0)^(t-1) (x - beta^(2^i))$ where $\{beta, ..., beta^(2^(t-1))\}$ are distinct conjugates.
  - #strong("Properties:") $M_beta (x)$ is always #imp[irreducible] over $F_2$. Two elements share a minimal polynomial #imp[iff] they are conjugates.
  - #strong("Primitive Case:") If $alpha$ is a root of the primitive polynomial $pi(x)$, then $M_alpha (x) = pi(x)$.

  #subdefbox([Theorem 5.3 - Factorization of $x^(2^m)+x$])[
    The polynomial $x^(2^m) + x$ is the product of all #imp[distinct] minimal polynomials:
    $ imp(x^(2^m) + x = product_(beta in F_(2^m)) (x - beta) = product_("distinct" M_beta) M_beta (x)) $
  ]
]

#tbox("Example Minimal Polynomial")[
  *For* $FF_8$:
  $ x^8 + x = x (x + 1) (x^3 + x + 1) (x^3 + x^2 + 1) $
  - $M_0(x) = x$
  - $M_1(x) = x + 1$
  - $M_alpha(x) = x^3 + x + 1 = pi(x) = (x + alpha)(x + alpha^2)(x + alpha^4)$
  - $M_(alpha^3)(x) = x^3 + x^2 + 1 = (x + alpha^3)(x + alpha^5)(x + alpha^6)$

  #underline[*Explanation:*]
  The polynomial $x^8+x$ is the product of all minimal polynomials of the elements in $FF_8$. Since $FF_8$ has 8 elements, we find the polynomials by grouping conjugates:
  - $\{0\}$ yields $M_0(x) = x$
  - $\{1\}$ yields $M_1(x) = x + 1$
  - $\{alpha, alpha^2, alpha^4\}$ share $M_alpha(x)$. Over $F_2$, this is the primitive polynomial $pi(x)$.
  - $\{alpha^3, alpha^6, alpha^5\}$ share $M_(alpha^3)(x)$.
  Note that in $FF_2$, $(x - beta)$ is equivalent to $(x + beta)$.
]

= Channel Coding & Reed-Solomon Codes (2.4)

#fbox("Reed-Solomon Codes: Introduction")[
  *Idea:* Encode a polynomial by evaluating it on several points. This #imp[introduces redundancy].
  //- Used in many applications: CDs, xDSL, DVB, satellite transmission, etc.
  - Able to correct #def[bursts of errors] (higher level redundancy).
  - Often used in #imp[concatenated codes] with #imp[low complexity decoding].
  - Evaluated on #def[large alphabets] $FF_q$ with $q=2^m$

  #diagMath($ underbrace([u_0, ..., u_(k-1)],k) =underbrace(u,u in FF_q) -> #diagBox("R-S") -> underbrace(x,x in FF_q)= underbrace([x_0, ..., x_(n-1)],n) $)
]

#fbox("Polynomial Description of R-S Codes")[
  Let $imp(f(z)) = u_0 + u_1 z + ... + u_(k-1) z^(k-1) in def(FF_q^((k))[z])$ be an input polynomial of degree $k-1$.
  - Choose #imp[$n <= q$ different basis elements] $underline(beta) = (beta_0, ..., beta_(n-1)) in FF_q$
  - Choose #imp[$n$ nonzero normalization factors] $rho_0, ..., rho_(n-1) in FF_q$

  #subdefbox("Reed-Solomon Code")[
    The #def[Reed-Solomon code] $C_(k, underline(beta), underline(rho))$ of rank $k$ is the set of all vectors:
    $ imp(underline(c) = ( rho_0 f(beta_0), rho_1 f(beta_1), ..., rho_(n-1) f(beta_(n-1)) )) in FF_q^n $
    For all polynomials $f(z)$ of degree $k-1 : f(z) in FF_q^((k))[z]$
  ]
  #strong("Generating Matrix") $G$:
  $ G =
    mat(
      1, 1, ..., 1;
      beta_0, beta_1, ..., beta_(n-1);
      dots.v, dots.v, , dots.v;
      beta_0^(k-1), beta_1^(k-1), ..., beta_(n-1)^(k-1)
    )
    mat(
      rho_0, 0, ..., 0;
      0, rho_1, ..., 0;
      dots.v, dots.v, dots.down, dots.v;
      0, 0, ..., rho_(n-1)
    ) $
]
#block(fill: red, "TODO - ADD EXPLANATION ON WHAT n is, and what to do if its too big", inset: 0.4em)

#tbox("Example of R-S Encoding")[
  Code $C_(3, underline(beta), underline(1))$ in $FF_8$ with $alpha^3 = alpha + 1 ->$ Basis $underline(beta) = (1, alpha, alpha^3, alpha^5, alpha^6)$\
  #v(-0.1em)
  $quad #text(size: 12pt, $cases(delim: "|", "Rank" k=3 quad&("maximum degree of" f(z)), "Length" n=5 quad&("from length of basis vector" underline(beta)))$)$\
  Input letters: $quad underline(u) = (alpha, 0, 1) --> f(z) = alpha + z^2 $\

  Linear codeword: $quad #text(size: 12pt, $cases(delim: #none, underline(x) &= (f(beta_0), ..., f(beta_4)),&= (alpha + 1,thin alpha + alpha^4,thin alpha + alpha^6,thin alpha + alpha^3,thin alpha + alpha^5))$)$
]

#fbox("Singleton Bound")[
  #subdefbox("Singleton Bound")[
    For any code $cal(C)$ of length $n$ on alphabet $A$ of size $q >= 2$:
    $ imp(|cal(C)| <= q^(n - d(cal(C)) + 1) quad "or" quad d(cal(C)) <= n - k + 1) $
    _where $k = log_q |cal(C)|$ and $q=|cal(A)|$ is the size of the alphabet._
  ]
  - Codes that achieve this bound are called #def[Maximum Distance Separable Codes (MDSC)]

  - #def[Equality Condition]: Reached #imp[iff] in any selection of $n - d(cal(C)) + 1$ positions, #imp[all possible sub-vectors] over $cal(A)$ appear exactly once in the codebook.

  - #v(-1em)#strong("Proof Intuition"): Partition codewords into #box($overbrace(\[c_"left",n-d(cal(C))+1) | overbrace(c_"right"\],d(cal(C)-1))$) where $|c_"right"|$ is repetitive. All $q^k$ codewords must have unique $c_"left"$ prefixes (otherwise $d < d(cal(C))$), implying $q^k <= q^(n - d(cal(C)) + 1)$
  - *Reed-Solomon codes* achieve this bound because a polynomial of degree $k-1$ has at most $k-1$ roots, ensuring at most $k-1$ zeros and thus $d = n - (k-1) = n - k + 1$
]

#fbox("Maximum Distance Separable Code (MDSC)")[
  A #def[Maximum Distance Separable Code (MDSC)] on finite field $FF_q$ perfectly reaches the Singleton bound: #imp[$d(C) = n - k + 1$] (or $|cal(C)| = q^(n-d(cal(C))+1)$).

  - #strong("Separable Property:") For *all* partitions of codewords into $underline(c) = [underline(c)_"left" | underline(c)_"right"]$ (of sizes $k$ and $n-k$), #imp[all different $k$-tuples appear exactly once]. You can choose any combination of columns, and all possible sets of vectors of length $k$ must appear!
  - #strong("Powerful:") It always gets the best option and gets all possible values of Galois fields.
  - #strong("Length Limitation:") There does #def[NOT exist long MDS codes] for practical $d(cal(C))$. If $2 <= k <= n-2$, then $n <= 2(q-1)$ (restricted by the size of the set). For $n <= q+1$, MDSCs exist for all values of $k in [2, n-2]$.

  #underline[*Linear MDSC Properties*] :
  - #def("Theorem 6.2:") A linear code $(n,k)$ on $FF_q$ is MDS iff all sets of #imp[$n-k$ columns of the parity matrix $H$] are linear. independent.
  - #def("Theorem 6.3:") A linear code $(n,k)$ on $FF_q$ is MDS iff all sets of #imp[$k$ columns of the generating matrix $G$] are linear. independent.\
    #h(1em)#box[$=>$ _Proof: In each set of $k$ positions, all possible $k$-tuples must appear exactly once._]
  - #def("Corollary 6.4:") The dual of an MDSC is an MDSC.
]

#tbox([Example: MDSC on $FF_4$ with $n = 4$ and $k = 2$])[
  $ G = mat(delim: "[",
    1, 0, 1, 1;
    0, 1, alpha, alpha^2
  ) quad H = mat(delim: "[",
    1, alpha, 1, 0;
    1, alpha^2, 0, 1
  ) $
  $ FF_4 = \{0, 1, alpha, alpha^2\}, quad alpha^2 + alpha + 1 = 0 $
]

#fbox("Reed-Solomon Codes as MDSCs")[
  #subdefbox("Theorem 6.5: RS Minimum Distance")[
    The minimum distance of the RS code $C_(k, underline(beta), underline(rho))$ is:
    $ imp(d(C) = n - k + 1) $
    Thus, #imp[RS codes are MDSC].
  ]
  - #strong("Proof Intuition:") The minimum distance is the minimum weight. A zero element at position $i$ means $beta_i$ is a root of the polynomial $f(z)$. A non-zero polynomial of degree $k-1$ has #imp[at most $k-1$ roots] (null elements). Therefore, it has #imp[at minimum $n - (k - 1) != 0$] non-zero elements. So $w(C) >= n - k + 1$, reaching the Singleton bound!
  - #def("RS Code Length:") For RS codes, $n = q - 1$, which satisfies the MDSC existence condition $q - 1 <= q + 1$.
  - #strong("Note:") Choose the polynomial OR the basis first, then derive the other from its roots! (Avoid the roots!).
]
#block(fill: red, "TODO - ADD EXPLANATION on how to actually create a solomon code from the galois field, if its a small galois field, and recompile in one single box the important properites", inset: 0.4em)

#fbox("Duality of Reed-Solomon Codes")[
  The dual code of $C_(k, underline(beta), underline(rho))$ is $C^perp_(k, underline(beta), underline(rho))=underbrace(C_(n-k, underline(beta), underline(lambda)), #place(center)[#v(-0.2em)fliped redundancy and origin])$ with normalization :
  #v(0.5em)
  $ lambda_i = (rho_i product_(j != i) (beta_i - beta_j))^(-1) $
  Parity matrix $H$ of $C_(k, underline(beta), underline(rho))$ is constructed similar to $G$ but with degree up to $n-k-1$ and factors $lambda_i$.
  $ H =
    mat(
      1, 1, ..., 1;
      beta_0, beta_1, ..., beta_(n-1);
      dots.v, dots.v, , dots.v;
      beta_0^(n-k-1), beta_1^(n-k-1), ..., beta_(n-1)^(n-k-1)
    )
    mat(
      lambda_0, 0, ..., 0;
      0, lambda_1, ..., 0;
      dots.v, dots.v, dots.down, dots.v;
      0, 0, ..., lambda_(n-1)
    ) $

  #hline()
  #def[Strict-Sense RS codes]: $n = q - 1$, basis $beta_i = alpha^i$ ($alpha$ primitive), $rho_i = 1$, $lambda_i = alpha^i$
  $ H =
    mat(
      1, alpha, alpha^2, ..., alpha^(n-1);
      1, alpha^2, alpha^4, ..., alpha^(2(n-1));
      dots.v, dots.v, dots.v, , dots.v;
      1, alpha^(n-k), alpha^(2(n-k)), ..., alpha^((n-1)(n-k))
    ) $
]

#fbox("Binary Image of RS Codes")[
  To transmit a binary source using Reed-Solomon codes (defined in $FF_q$), each letter $gamma in FF_q$ is associated with a binary vector $(gamma_1, ..., gamma_m)$ of $m$ bits ($q = 2^m$).
  - *Basis Mapping:* Usually, $(gamma_1, ..., gamma_m)$ are the coordinates of $gamma$ in a basis of $FF_q$, such as $(1, alpha, alpha^2, ..., alpha^(m-1))$.
  - #def[Binary Image] of $C$: The #imp[$(m n, m k)$ binary code] obtained by replacing each field element in the code by its associated binary coordinates.
  - *Note:* The binary image depends strictly on the #imp[choice of basis].

  #diagMath($ underbrace(d,#place(center, text(size: 8pt)[#v(-0.2em)$(011|001|101)$])) stretch(->)^("Bin 2 Galois") underbrace(u,#place(center, text(size: 8pt)[#v(-0.2em)$(alpha+1|1|alpha^2+1)$])) -> diagBox("R-S") -> underbrace(x,#place(center, text(size: 8pt)[#v(-0.2em)$(...)$])) stretch(->)^("Galois 2 Bin") underbrace(l,#place(center, text(size: 8pt)[#v(-0.2em)$(...)$])) $)

  #v(0.4em)
  #def[Burst Error Correction Capability]:
  A long burst of binary errors affects only a few symbols in $FF_(2^m)$.
  E.g., for $FF_16$ ($m=4$), an 8-bit burst $0000 | 0111 | 1010 | 0100 | 0000$ corrupts at most #imp[3 field symbols], easily corrected if $t(C) >= 3$.
]

#tbox("Example - R-S correcting capability")[
  #let r_err(body) = text(fill: red)[#body]

  *Setup for $FF_16$ Example:*
  $ n = 15, quad k = 11, quad beta = (1, alpha, alpha^2, ..., alpha^14), quad rho = (1, 1, ..., 1) $
  $ arrow.r d(cal(C)) = n - k + 1 = 5 quad => quad t(cal(C)) = floor((5-1) / 2) = 2 $

  #hline()
  *1. Standard Error Correction ($FF_{16}$ Level):*
  $ &underline(c) = (alpha^6, alpha^4, 0, alpha^11, 1, alpha, dots) \
    &underline(e) = (#r_err[$alpha^7$], 0, 0, #r_err[$alpha^10$], 0, 0, dots) quad arrow.r w(underline(e)) = 2 \
    &underline(y) = (alpha^10, alpha^4, 0, alpha^14, 1, alpha, dots) $
  #imp[Corrected] because the number of symbol errors matches $t(cal(C))$.

  #hline()
  *2. Binary Image Perspective ($pi(x) = x^4 + x + 1$):*
  $ &underline(c)_"bin" = (0011 | 1100 | 0000 | 0111 | 1000 | 0100 | dots) \
    &underline(e)_"bin" = (#r_err(1101) | 0000 | 0000 | #r_err(1110) | 0000 | 0000 | dots) \
    &underline(y)_"bin" = (1110 | 1100 | 0000 | 1001 | 1000 | 0100 | dots) $
  _There are 6 binary errors, but since they #imp[only corrupt 2 field symbols], they are fully corrected._

  #hline()
  *3. Burst Error Advantage:*
  $ underline(e)_"bin" = (0000 | 00#r_err[$11 | 1101 | 01$]00 | 0000 | dots) quad arrow.r "Length 8 burst" $
  $ arrow.r underline(e) = (0, alpha^6, alpha^7, alpha, 0, dots) $
  Despite many bit flips, only #imp[3 symbols] are corrupted. This would be corrected if $t(cal(C)) >= 3$.
]

#fbox("Burst Error Correction Theorem")[
  #subdefbox("Theorem 6.6 - Burst Correction")[
    Let $cal(C)$ be a code on $FF_q$ with $q = 2^m$ that corrects $t$ errors. The binary image of $cal(C)$ can correct #imp[$floor(t/2)$ disjoint error bursts] of length #imp[$l <= m + 1$].
  ]
  - #strong("Proof Intuition:") An error burst of size $m+1$ can affect at most #imp[2 consecutive symbols] (letters) in $FF_q$. Since the code is guaranteed to correct up to $t$ symbol errors, it can handle $floor(t/2)$ such bursts.
  - #def[Corollary for RS Codes]: Since $t = floor((n-k)/2)$, the binary image of $C_(k, underline(beta), underline(rho))$ on $FF_q$ corrects #imp[$floor((n-k)/4)$] error bursts of length $l <= m+1$.
]

#fbox("Decoding of R-S Codes")[
  Decodes $C_(k, underline(beta), underline(rho))$ on $FF_q$ by correcting up to #imp[$t = floor((n-k)/2)$] symbol errors.
  - #strong[Process:] Compute syndromes $arrow$ solve #def[Key Equation] (#imp[Euclidean Algorithm]) to find error locator $sigma(z)$ and evaluator $w(z)$ $arrow$ extract error roots.
  - Foundation for #def[BCH code] decoding.

  #underline[*Assumptions:*]
  - Redundancy $r = n - k = 2t thick("even") -> t=(n-k)/2$
  - Basis excludes zero ($beta_i != 0 thin forall i arrow.r n <= q - 1$).

  #hline()
  #text(size: 8.5pt)[*Note:* Highly efficient algebraic decoding compared to array lookup.]

]

#fbox("Concatenated Codes")[
  To achieve very low error rates, we combine two codes in a nested structure.
  - #def[Internal Code] $cal(C)_"int"$: Binary code $(n, k)$ (connected through k)
  - #def[External Code] $cal(C)_"ext"$: Code $(N, K)$ over $FF_q$ where $q = 2^k$ (R-S)
  - #imp[Resulting Code:] A binary code of parameters #imp[$(n N, k K)$].

  #hline()
  #underline[*Coding Scheme:*]
  1. Source bits ($k K$) split into $K$ blocks of $k$ bits $->$ translated to #imp[$K$ symbols in $FF_q$].
  2. Encode with $cal(C)_"ext"$ $->$ codeword of #imp[$N$ symbols] $(a_1, ..., a_N) in FF_q^N$.
  3. Translate each $a_i$ back to $k$ bits and encode with $cal(C)_"int"$ $->$ #imp[$N$ binary codewords] of length $n$.
  #v(-0.3em)
  #diagMath($ overbrace([#move($underbrace(...,#place(center)[#v(-0.2em) k])|...|...$)], K) stretch(->)^(underline(u_"bin")->underline(u'_"gal")) overbrace([a_0, ..., a_(K-1)],in FF_q) arrow.br& #move(dy: 1.2em, diagBox("R-S")) \  #move(dy:-0.6em, dx: -0.3em, $underbrace([#move($overbrace(...,#place(center)[#v(-0.4em) n])|...|...|...$)], N) stretch(<-)^(underline(v_"bin")<-underline(v'_"gal")) underbrace([b_0, ..., b_(N-1)], in FF_q) arrow.bl$)&
  $)
  #v(-0.8em)
  4. Final transmission: concatenated binary vector of $n N$ bits.

  #diagMath($ cases(delim: #none, reverse: #true,
    overbrace(u_"bin",(k K)) &stretch(->)^(underline(u)) diagBox(cal(C)_"ext") stretch(->)^(underline(a) "     "),
    underbrace(v_"bin", (n N)) &stretch(<-)^(underline(v)) diagBox(cal(C)_"ext"^(-1)) stretch(<-)^(underline(b) "     ")
  ) #move(dx:-0.6em, dy: -0.2em, block(stroke: (paint: blue, thickness: 1pt, dash: "dashed"), outset: (x:0.6em, y:0.5em), move(dx: 0.4em)[$
    cases(delim: #none, reverse: #true,
      diagBox(cal(C)_"int"^N) &stretch(arrow.br)^(underline(x)),
      diagBox(cal(C)_"int"^(-N)) &stretch(arrow.bl)^(underline(y))
    )
    diagBox("Channel")
  $ #place(dy: 0.8em, center)[#text(fill: blue, size: 8pt)[Equiv. channel with some mistakes\ (Less than true channel)]]]))
  $)
  #v(1.4em)

  #hline()
  #underline[*Decoding Process:*]
  1. #def("Internal Decoder:") #imp[Decodes the $N$ received $n$-bit vectors] independently.
     - Tries to correct random errors from the channel.
     - Failures here often result in #imp[bursts of errors] for the next stage.
  2. #def("External Decoder:") Translates results back to $FF_q$ and decodes.
     - Tries to correct errors from the #def[super-channel] (output of the internal decoder).
     - #imp[RS codes are ideal external codes] because they are powerful and #imp[excel at correcting the symbol errors (bursts)] left by the internal stage.
]

#fbox("Syndrome Calculation")[
  - #strong("Transmitted Codeword:") $underline(c) = (c_0, ..., c_(n-1)) in cal(C)$
  - #strong("Received Vector:") $underline(y) = (y_0, ..., y_(n-1)) = underline(c) + underline(e) quad$ ($underline(e)$ is error vector)
  - #strong("Syndrome Vector:") $underline(s) = (s_0, ..., s_(2t-1))^T$ of size $r = n - k = 2t$, defined by:
    $ imp(underline(s) = H underline(y)^T) $
    with parity matrix $H$ ($2t times n$):
    $ H =
      mat(
        1, 1, ..., 1;
        beta_0, beta_1, ..., beta_(n-1);
        dots.v, dots.v, dots.down, dots.v;
        beta_0^(2t-1), beta_1^(2t-1), ..., beta_(n-1)^(2t-1)
      )
      mat(
        lambda_0, 0, ..., 0;
        0, lambda_1, ..., 0;
        dots.v, dots.v, dots.down, dots.v;
        0, 0, ..., lambda_(n-1)
      ) $
  - #def[Syndrome Polynomial] $s(z)$ of degree $< 2t$:
    $ imp(s(z) = sum_(j=0)^(2t-1) s_j z^j) $

#subdefbox("Algebraic Property of the Syndrome")[
  Since $H underline(c)^T = 0$, the syndrome depends #imp[only on the error vector]:
  $ imp(underline(s) = H underline(e)^T) $
  Each component $s_j$ satisfies:
  $ s_j = sum_(i=0)^(n-1) lambda_i e_i beta_i^j = sum_(i=0)^(n-1) lambda_i y_i beta_i^j $
  By substituting $s_j$ and using the finite geometric series identity:
  $ s(z) = sum_(i=0)^(n-1) lambda_i e_i sum_(j=0)^(2t-1) (beta_i z)^j = sum_(i=0)^(n-1) lambda_i e_i [ (1 - (beta_i z)^(2t)) / (1 - beta_i z) ] $
  Expanding the term inside reveals the relation to the Key Equation:
  $ s(z) &= sum_(i=0)^(n-1) [ (lambda_i e_i) / (1 - beta_i z) ] - z^(2t) sum_(i=0)^(n-1) [ (lambda_i e_i beta_i^(2t)) / (1 - beta_i z) ]\ imp( &= sum_(i=0)^(n-1) lambda_i e_i [ 1 / (1 - beta_i z) - (beta_i z)^(2t) / (1 - beta_i z) ]) $
]
]


#fbox("Position and Values of Errors")[
  - #strong("Goal:") Identify which bit positions were flipped ($L$) and by how much ($e_i$).
  - Corresponding to finding the #def[coset leader] (the error vector with #imp[minimum weight that produces the observed syndrome]).
  - #def[Error Position Set] $L$: The indices where the error vector is non-zero.
    $ L = \{ i in [0, n-1] : e_i != 0 \}, quad |L| = l $

  #subdefbox("Error Polynomials")[
    1. #def[Error localization polynomial] $sigma(z)$: Its roots indicate error positions.
       $ imp(sigma(z) = product_(i in L) (1 - beta_i z)) $
    2. #def[Error evaluation polynomial] $w(z)$: Used to calculate error magnitudes.
       $ imp(w(z) = sum_(i in L) lambda_i e_i (sigma(z))/(1-beta_i z) = sum_(i in L) lambda_i e_i product_(j in L, j != i) (1 - beta_j z)) $
  ]
  #v(0.3em)
  - #strong("Constraints:") $deg sigma(z) = l$, $deg w(z) <= l - 1$, and #imp[$sigma(0) = 1$] (normalization).
]


#fbox("The Key Equation")[
  *Objective:* For a #imp[given syndrome $s(z)$, find the polynomials $sigma(z)$ and $w(z)$] that describe the most likely error pattern.

  - #underline[*Algebraic Relationship:*]
    $ imp(w(z) = sigma(z) s(z) + phi(z) z^(2t)) $
    where $phi(z)$ is an auxiliary polynomial of degree $<= l - 1$.

  - #underline[*Modulo Form:*]
    $ imp(w(z) equiv sigma(z) s(z) quad (mod z^(2t))) $

  #hline()
  #strong("Expanded Form:")
  $ (s_0 + s_1 z + ... + s_(2t-1) z^(2t-1)) (sigma_0 + sigma_1 z + ... + sigma_t z^t) \
    imp(= w_0 + w_1 z + ... + w_(t-1) z^(t-1) + O(z^(2t))) $
]

#fbox("Solving the Key Equation")[
  The syndrome polynomial #imp[$s(z)$] is known. We solve for $sigma(z)$ and $w(z)$ such that:
  + $w(z) = sigma(z) s(z) + z^(2t) phi(z)$
  + $deg sigma(z) <= t$ and $deg w(z) <= t - 1$
  + Normalization: #imp[$sigma(0) = 1$]

  #hline()
  - #strong("Solvability:") There are #imp[$2t$ linear constraints] for #imp[$2t$ unknowns]. We seek the unique solution with the #imp[minimal degree] for $sigma(z)$.

  - #strong("Extended Euclidean Algorithm (GCD Approach):")
    Computes $gcd(z^(2t), s(z))$ to solve $v_i(z) s(z) + u_i(z) z^(2t) = r_i(z)$.
    - #strong("Steps:") Initialize $r_(-1) = z^(2t), r_0 = s(z)$ and $v_(-1) = 0, v_0 = 1$.
    - #strong("Stopping Rule:") Iterate until the first index $j$ such that #imp[$deg(r_j) < t$].
    - #strong("Result:") $w(z) = r_j (z)$ and $sigma(z) = v_j (z)$, normalized so that #imp[$sigma(0) = 1$].
  - #strong("Berlekamp-Massey (Alternative):") An iterative LFSR-based method often preferred in hardware for its efficiency in finding the minimal-degree locator polynomial $sigma(z)$.

  #hline()
  #text(size: 8.5pt)[
    *Complexity:* Much more efficient than exhaustive search, allowing R-S codes to scale to large $n$.
  ]
]

#fbox("Decoding Procedure Summary")[
  1. #strong("Syndrome Computation:") Calculate $s_j$ for $j = 0 dots 2t-1$ using $underline(y)$, forming the syndrome polynomial $s(z)$ of degree $< 2t$.
     $ s_j = sum_(i=0)^(n-1) lambda_i y_i beta_i^j $
  2. #strong("Polynomial Solving:") Apply the #imp[#link("https://en.wikipedia.org/wiki/Euclidean_algorithm",[Euclidean Algorithm])] starting with $(z^(2t), s(z))$ to solve the Key Equation for $sigma(z)$ and $w(z)$.
  3. #strong("Root Finding:") Find the roots of $sigma(z)$ to identify the set of error positions $L$.
     $ (1 - beta_i z) = 0 quad => quad z = beta_i^(-1) $
  4. #strong("Error Correction:") Calculate the error values $e_i$ using #def[#link("https://en.wikipedia.org/wiki/Forney_algorithm", [Forney’s formula])]:
     $ imp(e_i = w(beta_i^(-1)) [ lambda_i product_(k in L, k != i) (1 - beta_k beta_i^(-1)) ]^(-1)) $

  #hline()
  #v(0.2em)
  #text(fill: red.darken(20%), weight: "bold")[⚠️ Decoding Failure:]
  If the algorithm encounters an anomaly (e.g., $sigma(z)$ has roots outside the basis set or $deg sigma > t$), the #imp[correcting capability has been exceeded] (more than $t$ errors occurred).
]


























= Channel Coding & Channel Capacity (2.5)
#fbox("Introduction: Performance over a Noisy Channel")[
  - #strong("Goal:") Transmit information on a noisy channel and find the #imp[best achievable performance].
  - #strong("Current limitations:") For fixed length $n$ and rate $R$, correction capability is limited, and error probability is bounded above zero.
  - #strong("Improving performance:") Decrease rate $R$ (more redundancy, less info per bit) or increase length $n$ (more complexity).
  - #imp[Information Theory Result:] Perfect zero-error transmission is theoretically possible as $n -> infinity$, provided the rate is below a certain threshold (Capacity).

  #v(0.5em)
  #align(center)[
    #diagMath($ underline(u) -> diagBox("Code") stretch(->)^(underline(x)=X) diagBox("Noisy Channel") stretch(->)^(underline(y)=Y) diagBox("Decode") -> underline(v) $)
  ]
  *Objective:* Minimize the error between source message $underline(u)$ and decoded estimate $underline(v)$ by adding redundancy and adapting input probabilities.
]

#fbox("Discrete Memoryless Channel (DMC)")[
  - #strong("Input:") Alphabet $A = {a_1, ..., a_K}$, Sequence $underline(x) = (x_1, ..., x_N)$
  - #strong("Output:") Alphabet $B = {b_1, ..., b_J}$, Sequence $underline(y) = (y_1, ..., y_N)$
  - #strong("Transition Probabilities:") $P(b_j | a_k)$ characterizes the channel.
  - #def[Memoryless Property]: The probability of output sequence depends only on the corresponding inputs independently (indep):
    $ imp(P(underline(y) | underline(x)) = product_(i=1)^N P(y_i | x_i)) $
  #subdefbox("Example: Binary Symmetric Channel (BSC)")[
    #v(0.3em)
    #grid(columns: (4fr, 1fr), gutter: 0.9em,[Alphabets $A = B = {0, 1}$\ Symmetric crossover probability $epsilon$:\
    $P(0|0) &= P(1|1) = q,\ quad P(0|1) &= P(1|0) = epsilon = 1 -q$\ All symbols sent are independent in time.],move(dy: -0.9em, align(center, diagram(cell-size: 1em, $
      0 edge("r", q, "->") edge("dr", epsilon, "->") & 0 \
      1 edge("r", q, "->") edge("ur", epsilon, "->") & 1
    $))))
    #v(-0.7em)
  ]
]

#fbox("Mutual Information")[
  $
    strong("Input Prob:") &quad& Q(a_k) "for" 1 <= k <= K\
    strong("Joint Prob:") &quad& P(a_k, b_j) = Q(a_k) P(b_j | a_k)\
    strong("Marginal Output Prob:") &quad& P(b_j) = sum_(k=1)^K Q(a_k) P(b_j | a_k)
  $

  #hline()
  #def[Information obtained] #imp[on average] on input $X$ by observing output $Y$ (also known as uncertainty learned about $X$ from $Y$):
  $ imp(I(X;Y) &= sum_(k=1)^K sum_(j=1)^J P(a_k, b_j) log_2 ( (P(b_j | a_k)) / P(b_j) )\
    &= E_(X,Y) [log_2 (P(b_j | a_k)) / P(b_j)] \
    &= underbrace(H(X),#place(center, dx: -2em)[Uncertainty on X]) - underbrace(H(X|Y),#place(center, dx: 4em)[Uncertainty on X knowing Y]))
  $
  #v(0.3em)
  $ "Baye's Law :" P(B,A) = cases( P(B|A)P(A), P(A|B)P(B)) $

  #imp[Interpretations:]
  - Uncertainty on $X$ is #imp[decreased on average] by $I(X;Y)$ when observing $Y$: $H(X|Y)=H(X)-I(X;Y)$
  - #def("Venn Diagram Intuition:") $H(X|Y)$ is the uncertainty remaining on $X$ after $Y$ is observed.
]

#fbox("Channel Capacity")[
  The #imp[maximum mutual information] that can be transmitted #imp[per letter], optimized over the input distribution $Q(a_k)$:
  $ imp(C = max_(Q(a_k)) I(X;Y)) $

  - #strong("Capacity-Achieving:") If $I(X;Y) = C$, the distribution $Q$ is said to #imp[achieve the capacity].
  - #strong("Dependency:") The capacity #imp[only depends] on the transition probabilities $P(b_j | a_k)$.
  - #strong("Reliability Intuition:") We want #imp[$H(X|Y) approx 0$] for reliable transmission.
  - #imp("Coding Theorem:") The capacity $C$ is the maximum amount of information that can be transmitted #imp[per letter] with vanishing error.
  - #strong("Theoretical Bound:") The source entropy must be bounded by capacity for reliable communication: #imp[$(H(U))/tau_s <= C/tau_c <=> R < C$].
]

#fbox("Transmission on Memoryless Channel (Theorem 1.1)")[
  For a #def[sequence of $n$ random variables] over a memoryless channel ($n$ repetitions #imp[indepedent in time]):
  - #strong("General Inequality:") Information of sequence is bounded by the sum of individual infos:
    $ imp(I(X^n; Y^n) <= sum_(i=1)^n I(X_i; Y_i)) $
  - #strong("Independent Inputs:") #imp[If inputs are independent], they achieve equality:
    $ I(X^n; Y^n) = sum_(i=1)^n I(X_i; Y_i) $
  - #strong("Capacity Achieving:") If inputs are independent #imp[and achieve capacity] ($I(X_i;Y_i) = C$):
    $ imp(I(X^n; Y^n) = n C) $
  #hline()
  #strong("Proof:")\
  $ I(X^n; Y^n)
    &= underbrace(H(Y^n), #text(size: 7pt)[what we receive]) - underbrace(H(Y^n | X^n), #text(size: 7pt)[input known in advance])
     \ &thin arrow.b#text(size: 8pt, fill: gray.darken(60%))[(Symmetry: $I(X,Y) = H(X)-H(X|Y)$)] \

    H(Y^n | X^n) &= - sum_(underline(x), underline(y)) Q^n (underline(x)) P^n (underline(y)|underline(x)) sum_(i=1)^n log_2 P(y_i | x_i)\

    &= sum_(i=1)^n H(Y_i | X_i)
    \ &thin arrow.b#text(size: 8pt, fill: blue)[(Memoryless: independent channel randomness)] \

    I(X^n; Y^n)  &<= sum_(i=1)^n H(Y_i) - sum_(i=1)^n H(Y_i | X_i) = sum_(i=1)^n I(X_i; Y_i)
    \ &#text(size: 8pt, fill: gray.darken(60%))[(Subadditivity: $H(Y^n) <= sum H(Y_i)$)]
  $
    #text(size: 8pt)[#v(0.3em) If inputs are independent ($Q^n (underline(x)) = product_(i=1)^n Q_i (x_i)$):]
  $
    H(Y^n) = sum_(i=1)^n H(Y_i) quad => quad I(X^n; Y^n) = sum_(i=1)^n I(X_i; Y_i)
  $
  #text(size: 8pt)[If $Q_i$ achieve capacity ($I(X_i; Y_i) = C$):] $I(X^n; Y^n) = n C$


]

#fbox("Coding Theorem: Introduction & Model")[
  #grid(columns: (1.28fr, 1fr), gutter: 0.5em, [
    *Theorems (bits/sec comp):*
    - #def[Coding Theo.]:\ $H(U)/tau_s < C/tau_c arrow.r overline(pi) arrow.r 0" err."$ possible
    #place(dx: 7em, dy: -0.4em, text(size: 8pt)[Coding scheme exists])
    - #def[Neg. Result]:\ $H(U)/tau_s > C/tau_c arrow.r overline(pi) >= gamma > 0$
    #place(dx: 6em, dy: -0.3em, text(size: 8pt)[Can't go lower than gamma])
    #v(0.4em)
    *Model Parameters:*
    - $U^k$ memoryless: $H(U^k) = k H(U)$
    - Periods: $tau_s$ (source), $tau_c$ (channel)
    - Channel uses: $n = ceil(k tau_s / tau_c)$
  ],[
    *Error Metrics:*
    - #strong("Per-letter error") ($l$):
      $ pi_l = sum_(underline(u), underline(v) : u_l != v_l) P(underline(u), underline(v)) $
    - #strong("Average error prob"):
      $ overline(pi) = 1/k sum_(l=1)^k pi_l $
    #v(0.2em)
    *Goal:* Accurate reproduction of $underline(u)$ at receiver ($underline(v)$)
  ])
]


#fbox("Information Inequalities for Error (Lemmas)")[
  #subdefbox("Lemma 1.7 (Fano's Inequality)")[
    Relates #def[error probability] $pi = sum_(u != v) P(u, v)$ to the #imp[equivocation] $H(U|V)$
    #v(-1em)
    $ imp(
      underbrace(pi log_2 (S - 1), #place(center)[#v(0.2em) #text(size: 7.5pt)[Which error?]]) +
      underbrace(cal(H)(pi), #place(center)[#v(0.2em) #text(size: 7.5pt)[If it occurs]])
      >=
      overbrace(H(U|V), #text(size: 7.5pt)[Equivocation])
      = H(U) - I(U;V)
    ) $
    #v(1.5em)
    - $S$: size of alphabet. #imp[Binary case ($S=2$)]: $cal(H)(pi) >= H(U|V)$
    - #def[Binary entropy function]: $ cal(H)(pi) = -pi log_2 pi - (1-pi) log_2 (1-pi) $

    *Interpretation:* The total uncertainty $H(U|V)$ is bounded by the uncertainty of *whether* an error occurs ($cal(H)(pi)$) plus the uncertainty of *which* symbol was sent given that an error occurred ($pi log_2 (S-1)$).

    *Meaning:* If uncertainty remains ($H(U|V) > 0$), then the #imp[error probability $pi$ cannot be zero]. It defines a #imp[minimum achievable error] $pi_"min"$.
  ]

  #subdefbox("Lemma 1.8 (Sequence Error)")[
    Extends Fano to a *sequence* of $k$ letters ($k > 1$):
    $ imp(overline(pi) log_2 (S - 1) + cal(H)(overline(pi)) >= 1/k H(U^k|V^k)) $
    If $H(U^k|V^k) > 0$, the average error probability $overline(pi)$ cannot be zero.
  ]

  #subdefbox("Lemma 1.9 (Theorem of Processing Chain)")[
    Consider the #def[Markov chain] $U^k -> X^n -> Y^n -> V^k$ where each step depends only on the previous one (no side info):
    $ imp(
      underbrace(I(U^k; V^k), #place(center)[#v(0.2em) #text(size: 7.5pt)[End-to-End]])
      <=
      underbrace(I(U^k; Y^n), #place(center)[#v(0.2em) #text(size: 7.5pt)[Received Source Info]])
      <=
      overbrace(I(X^n; Y^n), #text(size: 7.5pt)[Physical Channel Limit])
    ) $
    #v(1em)
    - #strong("Proof Intuition:") $H(Y|X, U) = H(Y|X) <= H(Y|U)$. Adding knowledge only decreases uncertainty; $underline(u)$ brings no info on $underline(y)$ if $underline(x)$ is already known.
    - #text(fill: fuchsia, weight: "bold")[Instinct:] We can only hope to #imp[not lose information] along the chain.
    - #text(fill: red, weight: "bold")[Limit:] We can #imp[never gain information from the side].
    #v(0.3em)
    *Relation:* Connects sequence uncertainty $H(U^k|V^k)$ to source entropy $H(U)$ and channel capacity $C$ (using $I(X^n; Y^n) <= n C$).
  ]
]
#block(fill: red, "TODO - ADD EXPLANATION How to compute the actual multual information, and its implications", inset: 0.4em)

#tbox("Proof of Lemma 1.7")[
  Compare $P(u|v)$ with the symmetric distribution $P^*(u|v)$ of parameter $pi$:
  $ P^*(u|v) = cases(pi/(S-1) & "if" u != v " (error)", 1 - pi & "if" u = v " (no error)") $
  Using $pi = sum_(u!=v) P(u,v)$, we evaluate the relative entropy difference:
  $ H(U|V) - [pi log_2 (S-1) + cal(H)(pi)] = sum_(u,v) P(u,v) log_2 ( (P^*(u|v)) / (P(u|v)) ) $
  Applying the log inequality $log_2 z <= z - 1$:
  $ &sum_(u,v) P(u,v) log_2 ( (P^*(u|v)) / (P(u|v)) ) \
    &<= sum_(u!=v) P(u,v) [ pi / ((S-1)P(u|v)) - 1 ] + sum_(u=v) P(u,v) [ (1-pi) / (P(u|v)) - 1 ] \
    &= pi/(S-1) sum_(u!=v) P(v) - sum_(u!=v) P(u,v) + (1-pi) sum_(u=v) P(v) - sum_(u=v) P(u,v) \
    &= pi - pi + (1-pi) - (1-pi) = 0 $

]

#fbox("Negative Result for Coding (Theorem 1.10)")[
  #underline[*Proof Walkthrough:*]
  $
    underbrace(overline(pi) log_2 (S - 1) + cal(H)(overline(pi)), #place(center, text(size: 7.5pt)[Fano's Lower Bound]))
    &>= 1/k H(U^k|V^k) \
    &= 1/k H(U^k) - 1/k I(U^k; V^k) \
    &= overbrace(H(U), #text(size: 7.5pt)[Source Entropy]) - 1/k overbrace(I(U^k; V^k), #text(size: 7.5pt)[End-to-End Info]) \
    &>= H(U) - 1/k overbrace(I(X^n; Y^n), #text(size: 7.5pt)[Data Process. Lemma])  >= H(U) - n/k C \
    imp(&>= H(U) - tau_s/tau_c C)
  $

  #hline()
  #underline[*Conclusion & Bitrate Condition:*]
  #def[Error-free transmission] ($overline(pi) -> 0$) is possible #imp[only if]:
  $ imp(underbrace(H(U) / tau_s, #place(center, dx: -2em, text(size: 7.5pt)[Source Rate (bits/s)])) < underbrace(C / tau_c, #place(center, dx: 4em, text(size: 7.5pt)[Channel Capacity (bits/s)])) quad "or" quad H(U) < C/R) $
  #v(0.4em)
  - #strong("Rate Definition:") #def[Coding rate] $R = tau_c / tau_s$. For binary equiprobable source ($H(U)=1$), this simplifies to #imp[$R < C$].
  - #strong("Uncertainty:") If bit rate (bits/s) > capacity (bits/s), uncertainty #imp[must remain] and $overline(pi)$ is bounded by a positive constant $gamma > 0$.
  - #strong("Scope:") This limit applies to #imp[any] combination of source and channel coding, but only to #imp[average error probability] $overline(pi)$, not individual $pi_l$.
]
#fbox([Convexity of $I(X;Y)$])[
  *How to compute the capacity?*
  $ imp(C = max_(Q(a_k)) I(X;Y)) $
  We analyze $I(X;Y)$ as a function of the input distribution $Q(a_k)$

  #subdefbox("Definition - Convexity")[
    A function $f: RR^K -> RR$ is #def[$inter$-convex (concave)] if, for all $alpha, beta in RR^K$ and $0 <= theta <= 1$:
    $
      imp(
        underbrace(theta f(beta) + (1 - theta) f(alpha), #place(center)[#v(0.3em) #text(size: 7.5pt)[Weighted average \ of outputs (chord)]])
        <=
        underbrace(f(theta beta + (1 - theta) alpha), #place(center)[#v(0.3em) #text(size: 7.5pt)[Output of weighted \ average input (curve)]])
      )
    $
    #v(1.2em)
    - The function curve is #imp[above] the straight line chord.
    - A function is #def[$union$-convex (convex)] if the inequality is reversed.
  ]

  #strong("Note:") By convexity, we mean on the $I(X;Y)$ bell curve diagram
]


#fbox("Convexity of Mutual Information")[
  #subdefbox("Theorem 1.2 - Convexity of Mutual Information")[
    The #imp[mutual information $I(X;Y)$] is #def[$inter$-convex] in the #imp[input distribution $Q(a_k)$].
  ]
  *Proof:* For $0 <= theta <= 1$, define $Q = theta Q_0 + (1 - theta) Q_1$. We aim to show $theta I_0 + (1 - theta) I_1 <= I(X;Y)$.
  Let $Z$ be an indicator with $P(Z=0)=theta$ and $P(Z=1)=1-theta$. Let $X$ follow $Q_z$ given $Z=z$, so $P(X) = Q$.

  #align(center)[
    $ Z cases(arrow.r^theta Q_0 arrow.r I_0, arrow.r^(1-theta) Q_1 arrow.r I_1) quad #block(stroke: 0.5pt, inset: 3pt, $X -> Y$) arrow.r I(X;Y) $
    #v(-0.5em) #text(size: 8pt)[Mixture system: $Q = theta Q_0 + (1-theta) Q_1$]
  ]

  Consider the Markov chain $Z -> X -> Y$. By property $P(y|x,z) = P(y|x)$, so $H(Y|X,Z) = H(Y|X)$.
  Since conditioning reduces entropy ($H(Y|Z) <= H(Y)$):
  $ I(X;Y|Z) = H(Y|Z) - H(Y|X,Z) <= H(Y) - H(Y|X) = I(X;Y) $
  Expanding $I(X;Y|Z)$ as an average over $Z$:
  $ I(X;Y|Z) = sum_z P(z) I(X;Y | Z=z) = theta I_0(X;Y) + (1-theta) I_1(X;Y) $

  $ imp(
    underbrace(theta I_0 + (1 - theta) I_1, #text(size: 7.5pt)[Average info when $Z$ is known \ (Combination of systems)])
    <=
    underbrace(I(X;Y), #text(size: 7.5pt)[Mutual info of the global mixture \ (The new system)])
  ) $
  #v(1em)

]

#fbox("Characterization of the Capacity")[
  *#imp[Maximization of $I(X;Y)$]* over parameters $alpha_k = Q(a_k)$:
  - #def[Convex set] $S$ of possible probabilities:
    $ S = { alpha in RR^K : alpha_k >= 0, quad sum_(k=1)^K alpha_k = 1 } $
  - Maximize a #imp[convex function] on a convex set: efficient algorithms exist. What about an #imp[analytical expression]?

  #subdefbox("Theorem 1.3 - Convex Optimization")[
    Based on #imp[Lagrange multipliers]. For a #def[$inter$-convex] function $f: S -> RR$ on convex set $S$, continuously derivable, the vector $alpha$ maximizes $f$ on $S$ iff there exists $lambda in RR$ such that:
    $
      underbrace((partial f(alpha)) / (partial alpha_k), #place(dx: -0.7em, center)[#v(0.2em) #text(size: 7.5pt)[Partial derivative]])
      &cases(
        = lambda quad &"for all " k " such that " overbrace(alpha_k > 0, #place(center, dy: -0.6em, text(size: 7.5pt)[Interior symbol])),
        <= lambda quad &"for all " k " such that " overbrace(alpha_k = 0, #text(size: 7.5pt)[Boundary symbol])
      )
    $
    *Note:* This is a constraint optimization problem
  ]

  #subdefbox("Theorem 1.4 - Characterization of Capacity")[
    Sometimes an #imp[analytical solution] can be proven. Let functions $g_k: S -> RR$ be:
    $ g_k (alpha) = sum_(j=1)^J P(b_j|a_k) log_2 ( P(b_j|a_k) / (sum_(t=1)^K alpha_t P(b_j|a_t)) ) $
    where $alpha_t = Q(a_t)$. The distribution $Q$ achieves #imp[capacity] iff there exists #imp[$C$] such that:
    $
      underbrace(g_k (alpha), #place(dx: -2.6em, center)[#v(0.2em) #text(size: 7.5pt)[Contribution of symbol $k$]])
      &cases(
        = C quad &"for all " k " such that " overbrace(Q(a_k) > 0, #place(center, dy: -0.6em, text(size: 7.5pt)[Active input])),
        <= C quad &"for all " k " such that " overbrace(Q(a_k) = 0, #text(size: 7.5pt)[Inactive input])
      )
    $
    The number $C$ is unique and is the #def[capacity] of the channel.
  ]
  *#imp[Property]*: Using Theorem 1.3 with $f(alpha) = I(X;Y)$, we can prove:
  $ imp(I(X;Y) = sum_(k=1)^K alpha_k g_k (alpha)) $
]

#fbox("Symmetric Channels")[
  A channel is characterized by its #def[transition probability matrix] $cal(P)$:
  $ cal(P) = mat(delim: "[",
      P(b_1|a_1), dots.h, P(b_J|a_1);
      dots.v, dots.down, dots.v;
      P(b_1|a_K), dots.h, P(b_J|a_K)
    ) $
  The channel is #def[symmetric] if there exists a #imp[partition of the columns]
  $ imp(cal(P) = [cal(P)_1, cal(P)_2, ..., cal(P)_m]) $
  of $cal(P)$ such that, inside each block $cal(P)_r$, the lines are #imp[equivalent up to a permutation], and the columns are #imp[equivalent up to a permutation].

  #hline()
  *Examples:*
  - *Example 1: Binary Symmetric Channel (BSC)*
    #grid(columns: (.5fr, 2fr), gutter: 1em, align: horizon, [
      #v(0.5em)
      #align(center, diagram(cell-size: 1.2em, $
        0 edge("r", q, "->") edge("dr", p, "->") & 0 \
        1 edge("r", q, "->") edge("ur", p, "->") & 1
      $))
    ], [
      $ cal(P) = mat(delim: "[", q, p; p, q), quad underbrace(p + q = 1, #text(size: 8pt)[Prob. sum]) $
      #text(size: 8pt)[Simple partition: One block $cal(P)_1 = cal(P)$]
    ])

    - *Example 2: Binary symmetric channel with #imp[erasure]*
      #grid(columns: (.5fr, 2fr), gutter: 1em, align: horizon, [
        #v(0.5em)
        #align(center, diagram(cell-size: 1.2em, $
          0 edge("r", q, "->") edge("ddr", p, "->") edge("dr", r, "->") & 0 \
          & phi \
          1 edge("uur", p, "->") edge("r", q, "->") edge("ur", r, "->") & 1 \
        $))
      ], [
        $ cal(P) = mat(delim: "[",
          overbrace(q, #place(center, dy: -0.8em)[0]), overbrace(p, #place(center, dy: -0.8em)[1]), overbrace(r, #place(center, dy: -1.2em)[$phi$]);
          p, q, r
        )
        quad
        underbrace(p + q + r = 1, #place(center, dx: 0em, dy: 0em, text(fill: fuchsia, size: 8pt)[Symmetric via partition])) $
        #v(0.3em)
        #text(size: 8pt)[Symbol $phi$ corresponds to erasure (column 3 is a separate block $cal(P)_2$). Note: #text(fill: fuchsia)[Symmetric] but requires multiple blocks.]
      ])

    - *Example 3: 3-state symmetric channel with #imp[zero diagonal]*
      #grid(columns: (.5fr, 2fr), gutter: 1em, align: horizon, [
        #v(0.5em)
        #align(center, diagram(cell-size: 1.2em, $
          a_1 edge("dr", p, "->") edge("ddr", q, "->") & b_1 \
          a_2 edge("ur", q, "->") edge("dr", p, "->")  & b_2 \
          a_3 edge("uur", p, "->") edge("ur", q, "->") & b_3
        $))
      ], [
        $ cal(P) = mat(delim: "[", 0, p, q; q, 0, p; p, q, 0)
        quad
        underbrace(p + q = 1, #place(center, dx: 0em, dy: 0em, text(fill: green.darken(20%), size: 8pt)[Permutation symmetry])) $
        #v(0.3em)
        #text(size: 8pt)[Each line and column are the #imp[same up to a permutation].]
      ])

]

#fbox("Capacity of Symmetric Channels")[
  #subdefbox("Theorem 1.5 - " + def[Optimal distribution] + " for symmetric channels")[
    For a symmetric channel, the #imp[uniform distribution] achieves capacity:
    $ #imp($Q(a_k) = 1 / K quad "for" k = 1, ..., K$) $
  ]

  *Proof:* Use Theorem 1.4 with $alpha = (1/K, ..., 1/K)$ and show that $g_k (alpha)$ is constant.
  - Consider the partition $T_1 union ... union T_m = {1, ..., J}$ corresponding to the symmetric partition $cal(P) = [cal(P)_1, ..., cal(P)_m]$.
    $ g_k (alpha) = sum_(r=1)^m underbrace(g_(k,r)(alpha), #place(center)[#v(0.2em) #text(size: 7.5pt)[Contribution of \ block $r$]]) quad "with" quad g_(k,r)(alpha) = sum_(j in T_r) P(b_j|a_k) log_2 ( P(b_j|a_k) / P(b_j) ) $
  - It is sufficient to show that for each $r$, $g_(k,r)(alpha)$ is independent of $k$.
  - For $j in T_r$ (with fixed $r$), $P(b_j)$ does not depend on $j$:
    $ P(b_j) = underbrace(sum_l Q(a_l) P(b_j|a_l), #place(center)[#v(0.2em) #text(size: 7.5pt)[Total prob. of $b_j$]]) = 1/K underbrace(sum_l P(b_j|a_l), #place(center)[#v(0.2em) #text(size: 7.5pt)[Column sum of $cal(P)_r$]]) = c_r $
    because the columns of $cal(P)_r$ are equivalent to each other.
  - The sum for $j in T_r$ of $P(b_j|a_k) log_2 P(b_j|a_k)$ does not depend on $k$ because all the lines of $cal(P)_r$ are equivalent. Similarly for the sum on $P(b_j|a_k) log_2 P(b_j)$ because $P(b_j) = c_r$.
  - #underline[Conclusion:] $g_(k,r)(alpha)$ does not depend on $k$.

  #imp[The capacity is given by] (using any value of $k$):
  $ imp(C = sum_(j=1)^J P(b_j|a_k) log_2 ( overbrace((K P(b_j|a_k)) / (sum_(l=1)^K P(b_j|a_l)), #text(size: 7.5pt)[Normalized transition ratio]) )) $

  #hline()
  *Example: Perfect error-free channel*\
  For an input #imp[alphabet of $K$ letters]:
  $ C = sum_(j=1)^K underbrace(delta_(j,k) log_2 (K delta_(j,k)), #place(center, dx: 0.5em, dy: -0.6em)[#v(0.2em) #text(size: 7.5pt)[Non-zero only when $j=k$]]) = log_2 K $

  Obvious since $I(X;Y) = H(X)$.
]
#block(fill: red, "TODO - ADD explanation what this all means practically", inset: 0.4em)

#tbox([Capacity Calculation: Examples])[
  #grid(columns: (1.2fr, 1fr), gutter: 1.5em, [
    #underline[*Ex 1: Binary Symmetric Channel (BSC)*]
    $ C &= q log_2 2q + p log_2 2p \
      &= log_2 2 + q log_2 q + p log_2 p \
      &= imp(log_2 (2) - cal(H)(p)) $
    where #def[$cal(H)(p)$] is the #imp[binary entropy function]:
    $ cal(H)(p) = -p log_2 p - (1-p) log_2 (1-p) $

    #hline()
    #underline[*Ex 3: 3-state Symmetric (Zero Diag)*]
    $ C &= q log_2 3q + p log_2 3p \
      &= log_2 3 + q log_2 q + p log_2 p \
      &= #imp[$log_2 3 - cal(H)(p)$] $
    #v(0.3em)
    #text(size: 8pt)[*Interpretation:* The capacity is the maximum possible info ($log_2 K$) minus the uncertainty introduced by the noise ($cal(H)(p)$).]
  ], [
    #align(center)[
      #stack(dir: ttb, spacing: 0.8em,
        text(size: 9pt, weight: "bold")[Capacity $C$ of BSC],
        {
          cetz.canvas(length: 65pt, {
            import cetz.draw: *

            let h2(p) = {
              if p <= 0 or p >= 1 { 0 }
              else { -(p * calc.log(p, base: 2) + (1 - p) * calc.log(1 - p, base: 2)) }
            }
            let cap(p) = 1 - h2(p)

            // Axes
            line((0,0), (1.15, 0), mark: (end: "stealth"), stroke: 0.5pt)
            line((0,0), (0, 1.15), mark: (end: "stealth"), stroke: 0.5pt)
            content((1.15, 0), [$p$], anchor: "west", padding: 3pt)
            content((0, 1.15), [$C$], anchor: "south", padding: 3pt)

            // Ticks
            line((0.5, -0.03), (0.5, 0.03))
            content((0.5, -0.05), [0.5], anchor: "north", size: 7pt)
            line((1, -0.03), (1, 0.03))
            content((1, -0.05), [1], anchor: "north", size: 7pt)
            line((-0.03, 1), (0.03, 1))
            content((-0.05, 1), [1], anchor: "east", size: 7pt)

            // Curve plot
            let points = range(0, 101).map(i => (i/100, cap(i/100)))
            line(..points, stroke: (paint: blue, thickness: 1.2pt))

            // Highlight at p=1
            circle((1, 1), radius: 0.06, stroke: (paint: green.darken(20%), thickness: 1.5pt))
          })
        },
        place(center, dx: 2em,dy: -10.5em)[#text(size: 7.5pt, fill: green.darken(30%))[*100% error:* Just inverted!]]
      )
    ]
  ])

  #hline()
  #underline[*Ex 2: BSC with Erasure ($r$)*]
  $ C = q log_2 (2q)/(p+q) + p log_2 (2p)/(p+q) + r log_2 (2r)/(2r) $
  $ C = (p+q) [ log_2 2 + q/(p+q) log_2 q/(p+q) + p/(p+q) log_2 p/(p+q) ] $
  $ #imp($C = (p+q) [ log_2 2 - cal(H)( p/(p+q) ) ]$) $

  #v(0.2em)
  #underline[*Limit cases:*]
  - #imp[1.] $r=0 ->$ #strong("Standard BSC"): $C = log_2 2 - cal(H)(p)$
  - #imp[2.] $p=0 ->$ #strong("Binary Erasure Channel"): $C = (1-r) log_2 2$

  #hline()
  #underline[*Ex 4: Z-Channel (Non-Symmetric)*]
  #grid(columns: (.5fr, 2fr), gutter: 1em, align: horizon, [
    #v(0.5em)
    #align(center, diagram(cell-size: 1.2em, $
      1 edge("r", 1, "->") & 1 \
      0 edge("r", q, "->") edge("ur", p, "->") & 0
    $))
  ], [
    $ cal(P) = mat(delim: "[", 1, 0; p, q), quad p+q=1 $
    #text(size: 8pt)[Application: #imp[On-Off Keying] (Fiber optics). "Flash lingers".] \
    #v(0.2em)
    #text(size: 8pt)[Let $sigma = 2^(cal(H)(q)/q)$. Optimal distribution $Q(0) = 1/(q(1+sigma))$ achieves:]
    $ imp(C = log_2 1 + 1/sigma)) $
  ])

  #hline()
  #underline[*Ex 5: W-Channel (Non-Symmetric)*]
  #grid(columns: (.5fr, 2fr), gutter: 1em, align: horizon, [
    #v(0.5em)
    #align(center, diagram(cell-size: 1.2em, $
      1 edge("r", 1, "->") & 1 \
      0 edge("ur", p, "->") edge("dr", q, "->") & \
      -1 edge("r", 1, "->") & 0
    $))
  ], [
    $ cal(P) = mat(delim: "[", 1, 0; p, q; 0, 1) $
    #text(size: 8pt)[Optimal: $Q(1)=Q(-1)=1/2$, $Q(0)=0$. "Error-free BSC".] \
    #imp[$C = log_2 2$]
  ])
  #v(0.5em)
  #text(size: 8pt)[*Note:* In general, no analytical expression exists for non-symmetric channels.]

]

#tbox([Channel Capacity: Exercises])[
  #underline[*Core Inequality Breakdown:*]
  $ overbrace(H(U) / tau_s, #place(center, dx: -2.5em, dy: -0.4em, text(size: 7.5pt)[Source bitrate (bits/s)])) <= overbrace(C / tau_c, #place(center, dx: 3.5em, dy: -0.4em, text(size: 7.5pt)[Channel capacity (bits/s)])) quad arrow.r quad H(U) <= C / (underbrace(tau_c / tau_s, #place(center, text(size: 7.5pt)[Code Rate $R$]))) $

  #hline()
  #strong("1. Fixed Channel Symbol Rate")\
  *Question:* Capacity $C = 0.5$ bits/symb, speed $1$ Msymb/s. Source: binary, $5$ Mbits/s. What rate $R$?
  - #strong("Options:") A) $R < 0.1$ | B) $R < 5$ | C) $R < 10$ | D) #def[It is impossible]
  - #strong("Reason:") A binary equiprobable source has $H(U) = 1$. The timings are $tau_s = 1 / (5 dot 10^6)$ and $tau_c = 10^(-6)$.
    Thus, $R = tau_c / tau_s = 5$. However, reliable transmission requires $H(U) / tau_s < C / tau_c$.
    Here, #imp[$5 " Mbits/s" > 0.5 " Mbits/s"$], making it #imp[impossible].

  #hline()
  #strong("2. Required Code Rate")\
  *Question:* Capacity $C = 0.5$ bits/symb. Source: binary equiprobable, $5$ Mbits/s. What rate $R$?
  - #strong("Options:") A) $R < 0.1$ | B) #def[Choose $R < 0.5$] | C) $R < 10$ | D) Impossible
  - #strong("Reason:") Here $tau_c$ is not fixed. Reliable transmission requires:
    $ R < C / H(U) = 0.5 / 1 = 0.5 $
    With source bitrate $5$ Mbits/s, the channel must accept at least #imp[$(5 " Mbits/s") / R = 10$ Msymb/s].

  #hline()
  #strong("3. Minimal Error Probability")\
  *Question:* Capacity $C = 0.5$, Source $H(U) = 1$, rate $R = 0.625$. Minimal error probability $pi$?
  - #strong("Options:") A) $cal(H)(pi) = 0.1$ | B) #def[It is given by $cal(H)(pi) = 0.2$] | C) $cal(H)(pi) = 0.3$
  - #strong("Reason:") Using #def[Fano's Inequality] for $S=2$ (where $log_2 S-1)=0$):
    $ underbrace(cal(H)(pi), #place(center, text(size: 7.5pt)[Binary Entropy of Error])) >= 1/k H(U^k | V^k) >= H(U) - C/R = 1 - 0.5 / 0.625 = 0.2 $
    Hence, #imp[$cal(H)(pi) >= 0.2$], which implies a minimal error $pi approx 0.03$.

  #hline()
  #strong("4. Average Mutual Information")\
  *Question:* Capacity $C = 0.5$, binary source ($H(U)=1$). Perfect transmission with $R = 0.25$.
  - #strong("Options:") A) #def[$I(X;Y) = 0.25$] | B) $I(X;Y) = 0.5$ | C) $I(X;Y) = 1$
  - #strong("Reason:") Perfect transmission means no remaining uncertainty: $H(X|Y) = 0$.
    Thus $I(X;Y) = H(X) - H(X|Y) = H(X)$. Averaging per symbol:
    $ I(X;Y) = 1/n I(X^n; Y^n) = 1/n H(U^k) = (k/n) H(U) = R H(U) $
    With $H(U) = 1$, we get #imp[$I(X;Y) = 0.25$] bits/symbol.
]

== Capacity Part 2: The Coding Theorem

#fbox("Positive Part of the Coding Theorem")[
  - #strong("Objective:") Show that if #def[source entropy] $<$ #def[channel capacity] ($H(U)/tau_s < C/tau_c$), reliable transmission is #imp[possible].
  - #def[Model:] Source and channel coding are #imp[separated].
    #diagMath($ underline(u) -> diagBox("Source\nCoder") stretch(->)^(underline(u)_"bin" in {0,1}^k)_(tau_s, k) diagBox("Channel\nCoder") stretch(->)^(underline(x) in A^n)_(tau_c, n) "Channel" $)
    - With $A^n thick ("K word alphabet"), B^n thick ("J word alphabet")$
    - #strong("Clocks:") $tau_s$ (source bit interval), $tau_c$ (channel letter interval).
    - #strong("Assumption:") Perfect source coding (uniform memoryless binary source).
]

#fbox("Block Coding & Parameters")[
  - #strong("Assumptions:") Restriction to #def[block channel coding] where binary inputs are grouped into blocks of fixed size #imp[$k$]: $underline(u) = (u_1, ..., u_k)$.
  - #strong("Channel Coder:") Injective mapping to a #def[codeword] $underline(x) in A^n$ of $n$ letters in alphabet $A$.
    $ imp(underbrace(n, #place(center)[#v(0.2em) #text(size: 7.5pt)[Code length]])) = overbrace(k, #place(dy: -0.4em, center,text(size: 7.5pt)[Block size])) tau_s / tau_c quad --> quad underbrace(n tau_c, #place(dy: -0.2em, center)[#text(size: 7.5pt)[Total block duration]]) = overbrace(k tau_s, #place(dy: -0.4em, center,text(size: 7.5pt)[Source duration])) $
  - #strong("Code Size:") $M = 2^k$ distinct codewords in the codebook.
  - #def[Code Rate] $R$:
    $ imp(underbrace(R, #place(center)[#v(0.2em) #text(size: 7.5pt)[Code rate]])) = (log_2 overbrace(M, #place(dy: -0.4em, center,text(size: 7.5pt)[Code size]))) / n = k / n = tau_c / tau_s $
    _Interpretation: Amount of unique information carried per symbol in bits_
  - #strong("Decoding:") From received $underline(y) in B^n$, the decoder provides an estimate $hat(underline(x)) in A^n$ or $hat(underline(u)) in {0,1}^k$.
  - #def[Decoding Error] ($pi$): Occurs if $hat(underline(u)) != underline(u)$.
    _Triggered if at least one bit is wrong, regardless of the number or positions of bit errors._

  #hline()
  #underline[*Performance and Complexity*]
  - #strong("Redundancy:") As rate $R$ decreases, redundancy increases, allowing a #imp[lower error probability] $pi$.
  - #imp("Surprising Result:") For $R < C$, the error probability $pi$ can be decreased as much as desired by #imp[increasing $n$] while keeping #imp[$R$ fixed]. (= #def[Coding Theorem])
  - #strong("Drawbacks") of long codes (large $n$):
    - #def[Delay]: Must wait for full block $n tau_c$ before transmitting/decoding.
    - #def[Complexity]: Decoding complexity increases with code size $M = 2^(n R) = 2^(k)$.
]

#fbox("Typical Sequences & Typical Set")[
  - #strong("Core Idea:") After many rounds (#imp[$n -> infinity$]), sequences $underline(x)$ generated by a memoryless source typically match the #imp[original distribution]. Any other repartition becomes #imp[unlikely].

  #subdefbox("Typical Set")[
    The #def[Typical Set] $cal(A)_epsilon^((n))$ (accuracy/set size $epsilon$) for a stationary source $X$ is defined by:
    $ imp(overbrace(2^(-n(H(X) + epsilon)), #place(dy: -0.8em, center)[#text(size: 7.5pt)[Lower bound ($P(x) approx 2^(-n H)$)]]) <= P(underline(x)) <= overbrace(2^(-n(H(X) - epsilon)), #text(size: 7.5pt)[Upper bound])) $
    #strong("Intuition (LLN):") By the #def[Law of Large Numbers], the average information per symbol (empirical entropy) converges to the theoretical entropy $H(X)$. This implies an #imp[approx. uniform probability] for each element in the typical set:
    $ underbrace(-1/n log_2 P(underline(x)), #place(center)[#v(0.3em) #text(size: 7.5pt)[Empirical entropy]]) approx underbrace(H(X), #place(center)[#v(0.3em) #text(size: 7.5pt)[Theoretical entropy]]) $

    #v(0.3em)
    _Smaller $epsilon$ reduces the set size but requires $n -> infinity$ for validity._
  ]
  Typical Length n : $P(x) approx 2^(-n H) $

  #subdefbox("Asymptotic Equipartition Property (AEP)")[
    For sufficiently #imp[large $n$], the typical set satisfies:
    + $underbrace(P(underline(x) in cal(A)_epsilon^((n))), #place(center)[#v(0em) #text(size: 7.5pt)[Prob. of typicality]]) >= underbrace(1 - epsilon, #text(size: 7.5pt)[Confidence])$
    #v(0.8em)
    + $underbrace((1 - epsilon) 2^(n[H(X) - epsilon]), #place(center)[ #text(size: 7.5pt)[Min Size]]) <= underbrace(|cal(A)_epsilon^((n))|, #place(center)[ #text(size: 7.5pt)[Typical set size]]) <= underbrace(2^(n[H(X) + epsilon]), #text(size: 7.5pt)[Max Size]) $ for arbitrarily #imp[low $epsilon$].
    #v(0.5em)
    #underline[*Main Consequences:*]
    - #imp[$P(underline(x) in cal(A)_epsilon^((n))) arrow.r 1$]: Probability that a sequence drawn randomly is typical #imp[tends to one].
    - #def[Equiprobability]: All typical sequences have #imp[approx. same probability $2^(-n H)$].
    - #def[Set Volume]: There is an #imp[amount $2^(n H)$] of such sequences.
  ]

  #underline[*Source Coding Application:*]
  Theoretically achieve #imp[perfect compression] by sending the #imp[index] within the typical set.
  - #strong("Resource:") Requires #imp[$n H(X)$ bits] for sequences of length $n$.
  - #strong("Efficiency:") #imp[$H(X)$ bits per symbol] on average (#def[Optimal]).
  - #strong("Properties:") #imp[Lossless] ($P("fail") -> 0$) and #imp[uniform probability] for each index.
]

#tbox([Example: Memoryless Binary Source])[
  Source prob. $P(X=0) = 0.8$, $P(X=1) = 0.2 -> H(X)=0.722$
  #grid(columns: (1fr, 1fr), gutter: 1em, align: top, [
    *Typical (80% 0s, 20% 1s):*\
    #text(size: 8pt)[$ P(underline(x)) &= underbrace((0.8)^(8n)(0.2)^(2n), #text(size: 7pt)[Prob. of 1 sequence (len 10n)]) \ &= (0.606)^(10n) = (2^(-H(X)))^(10n) $]
    #v(0.2em)
    - #strong("Amount:") #imp[$(2^(H(X)))^(10n)$] sequences.
    - #strong("Total prob:") #imp[Asymptotically approaches 1].
  ], [
    *Non-Typical (70% 0s, 30% 1s):*\
    #text(size: 8pt)[$ P(underline(x)) &= (0.8)^(7n)(0.2)^(3n) \ &= (0.528)^(10n) $]
    #v(0.2em)
    - #strong("Amount:") #imp[$(1.84)^(10n)$] sequences.
    - #strong("Total prob:") #imp[$(0.97)^(10n) -> 0$] as $n -> infinity$
    - Does not match original distribution.
  ])
  #v(-0.3em)
  #h(1em)#box[$=>$ _When $n -> infinity$, any other distribution is unlikely compared to the original one!_]
]


#fbox("Jointly Typical Sequences")[
  A pair of sequences $(underline(x), underline(y))$ is #def[$epsilon$-jointly typical] if the pair is typical with respect to the joint distribution and each sequence is typical with respect to its marginal distribution:
  1. $underbrace(2^(-n(H(X,Y)+epsilon)), #place(center)[#text(size: 7pt)[Joint prob. min]]) <= P(underline(x), underline(y)) <= underbrace(2^(-n(H(X,Y)-epsilon)), #text(size: 7pt)[Joint prob. max])$
  #v(0.3em)
  2. $underline(x) in cal(A)_epsilon^((n))(X) thick$ (#imp[marginal typicality])
  3. $underline(y) in cal(A)_epsilon^((n))(Y) thick$ (#imp[marginal typicality])

  #hline()
  #strong("Properties of the Jointly Typical Set:")
    - #imp[Probability:] $P((underline(X), underline(Y)) in cal(A)_epsilon^((n))(X,Y)) arrow.r 1$ for $n arrow.r infinity$.
    - #imp[Size:] $|cal(A)_epsilon^((n))(X,Y)| approx underbrace(2^(n H(X,Y)), #place(center, dy: -0.2em)[#text(size: 7.5pt)[Joint states]]) = underbrace(2^(n(H(X) + H(Y) - I(X;Y))), #place(center, dy: -0.2em)[#text(size: 7.5pt)[Overlap relation]])$ \
      _where $H(X,Y)$ is the #imp[joint entropy]._
    - #imp[Significance:] It accounts for the #def[dependence] between $X$ and $Y$ through $P(underline(x), underline(y))$.
    - Same properties as the typical set
  #hline()
  #strong("Probability of Accidental Typicality:") \
  If $underline(x)$ and $underline(y)$ are chosen #imp[independently] (drawn from $P(x)$ and $P(y)$), the probability they fall into the jointly typical set is:
  $ imp(P((underline(X), underline(Y)) in cal(A)_epsilon^((n))) &approx underbrace((|cal(A)_epsilon^((n))(X,Y)|) / (|cal(A)_epsilon^((n))(X)| dot |cal(A)_epsilon^((n))(Y)|), #place(center)[#text(size: 7.5pt)[Set size ratio]])\ &approx underbrace((2^(n H(X,Y))) / (2^(n H(X)) dot 2^(n H(Y))), #place(center)[#text(size: 7.5pt)[Exponents approx.]]) = 2^(-n I(X;Y))) $
  #v(0.4em)
  _Intuition: High #def[mutual information] $I(X;Y)$ makes accidental typicality very unlikely._
]

#block(fill: red, "TODO - ADD EXPLANATION how to use the typical sets", inset: 0.4em)

#tbox("Example : Jointly typical sequences")[
  #grid(columns: (1.1fr, 0.9fr), gutter: 1em, [
    *Ex 1: Dependent ($X ->$ BSC)* \
    $X$ (80% 0s), Channel error $5%$. \
    #text(size: 7pt)[$P(Y=0) = P(X=0)P_(n e) + P(X=1)P_e$]\
    $= 0.8 dot 0.95 + 0.2 dot 0.05 = 0.77$. \
    #text(size: 8pt)[#imp[Correlation] restricts the valid pairs. Only sequences matching the noise characteristics are jointly typical.]\
    #v(0.8em)
    #text(size: 7.5pt)[
      $ I(X;Y) != 0 \
      |cal(A)_epsilon^((n))(X,Y)| = 2^(n[H(X)+H(Y)-I(X;Y)]) \
      imp(= underbrace(2^(-n I(X;Y)), #place(center)[#v(0.2em) #text(size: 5.5pt)[Prob. of getting typical \ sequence if taken at random]]) dot |cal(A)_epsilon^((n))(X)| dot |cal(A)_epsilon^((n))(Y)|) $
    ]
  ], [
    *Ex 2: Independent ($X, Y$)* \
    $X$ (80% 0s), $Y$ (77% 0s). \
    #text(size: 7pt)[$I(X;Y) = 0 arrow.r H(X,Y) = H(X) + H(Y)$] \
    #text(size: 8pt)[Criterion always satisfied for any pair of typical $x$ and $y$. Set is the #imp[product] of individual typical sets.]\
    #v(0.8em)
    #text(size: 7.5pt)[
      $ I(X;Y) = 0 \
      |cal(A)_epsilon^((n))(X,Y)| &= 2^(n[H(X)+H(Y)])\ &= 2^(n H(X)) dot 2^(n H(Y)) \
      &imp(= |cal(A)_epsilon^((n))(X)| dot |cal(A)_epsilon^((n))(Y)|) $
    ]
  ])
  #v(0.8em)
]

#fbox("Random Coding & Typical Set Decoding")[
  - #def[Random Coding:] Generate a codebook $cal(C)$ of $M = 2^(n R) = 2^k$ codewords of length $n$ by drawing letters independently from distribution $Q(x)$.
  - #def[Typical Set Decoding Rule:] For a received output $underline(y)_0$:
    1. Search for a codeword $hat(underline(x)) in cal(C)$ that is #imp[$epsilon$-jointly typical] with $underline(y)_0$: $(hat(underline(x)), underline(y)_0) in cal(A)_epsilon^((n))(X, Y)$.
    2. If $hat(underline(x))$ is the #imp[unique] candidate in $cal(C)$, select it as the estimate.
    3. If #imp[zero or more than one] codewords satisfy the condition, declare a decoding error.
]

#fbox("Error Probability Analysis")[
  Let $underline(x)_0$ be the transmitted codeword. An error ($\pi = P(hat(underline(x)) != underline(x)_0)$) occurs if:
  - #strong("Missed detection:") $(underline(x)_0, underline(y)_0)$ is #imp[not] jointly typical.
    $ P((underline(x)_0, underline(y)_0) thin cancel(in) thin cal(A)_epsilon^((n))) <= epsilon $
  - #strong("False alarm:") At least one #imp[competitor] $underline(x)' != underline(x)_0$ is jointly typical with $underline(y)_0$.
    The prob. for #imp[one] independent competitor is $<= 2^(-n(I(X;Y) - 3 epsilon))$.
    Since there are #imp[$2^(n R) - 1$] competitors:
    $ overbrace((2^(n R) - 1), #text(size: 7.5pt)[#v(-0.2em)competitors]) overbrace(2^(-n(I(X;Y) - 3 epsilon)), #text(size: 7.5pt)[#v(-0.2em)prob. per seq.]) <= overbrace(2^(-n(I(X;Y) - R - 3 epsilon)), #place(center)[#v(-0.6em) #text(size: 7.5pt)[Total accidental overlap]]) $

  #hline()
  #underline[*Total Error Probability:*]
  $ imp(pi <= underbrace(epsilon, #place(center)[#text(size: 7.5pt)[Sent seq. not typical]]) + overbrace(2^(-n(I(X;Y) - R - 3 epsilon)), #place(center)[#v(-0.6em) #text(size: 7.5pt)[False alarm probability]])) $
  #v(0.5em)
  If #imp[$R < I(X;Y) - 3 epsilon$], the exponent is neg. and #imp[$pi -> 0$] as $n -> infinity$
]
#block(fill: red, "TODO - ADD EXPLANATION of what this error actually is, and what that epsilon is, is it a bound ?", inset: 0.4em)


#fbox("The Coding Theorem")[
  #subdefbox("Theorem 1.11 - Coding theorem for noisy channels")[
    For a memoryless channel of capacity $C$, a rate $R$, asymptotically large $n$ and small $epsilon$, there #imp[exists] a block code $(n, R)$ such that the #imp[average error probability] is bounded by:
    $ imp(pi <= epsilon + 2^(-n[C - R - 3 epsilon])) $
  ]
  - #strong("Note:") This assumes a #imp[binary source ($H(U)=1$)]. Otherwise, adapt $R$.
  - #strong("Condition:") If $Q(x)$ is optimal, $I(X;Y) = C$. If #imp[$R < C$], error tends to zero.
  - #strong("Significance:") It is #imp[always possible] to find a "good" code (error as low as desired) provided we choose a sufficiently large length $n$.
]

#fbox("Practical Implications & Bound on n")[
  - #strong("Random Coding Insights:")
    - Codes chosen randomly behave well #imp["on average"]. Even random codes #imp[could be good if found]! It guarantees existence but not construction.
    - #def[Drawbacks]: High #imp[complexity] (exponential search) and #imp[delay] ($n -> infinity$)

  #subdefbox("Result - Bound on code length n")[
    For a fixed target error probability $pi <= p_"max"$, the block length $n$ must satisfy:
    $ imp(n >= (log_2 (1 / p_"max")) / (underbrace(C - R, "Gap to capacity"))) quad <==> quad imp(underbrace(2^(-n(C-R)) <= p_"max", "Finite length bound")) $
  ]
  #v(0.2em)
  - #strong("Logarithmic Growth:") Required $n$ grows with $log_2 (1/p_"max")$ (slowly).
  - #strong("The Limit:") As #imp[$R -> C$], the needed length #imp[$n -> infinity$]
]
#block(fill: red, "TODO - ADD EXPLANATION on what that bound actually is, and if it has a name", inset: 0.4em)


#tbox([Exercises - Coding Theorem])[
  #strong("1. No Coding") \
  *Question:* Channel capacity $C = 0.5$ bits/symb. Binary source with independent equiprobable bits. Is error-free transmission possible #imp[without coding]?
  - #strong("Answer:") #def[No].
  - #strong("Reason:") Without coding, $R = 1$ bits/symb. Since $R > C$, the Coding Theorem implies that an error-free transmission is impossible. #imp[You can't do anything!]

  #hline()
  #strong([2. Coding with $R < C$]) \
  *Question:* Same setup. Is error-free transmission possible with a code of rate #imp[$R = 0.4$]?
  - #strong("Answer:") #def[Yes].
  - #strong("Reason:") Since $R < C$ ($0.4 < 0.5$), the Coding Theorem guarantees that there exists a code such that #imp[$pi -> 0$], provided the block length $n$ is #imp[high enough].

  #hline()
  #strong("3. Finite Block Length Constraints") \
  *Question:* Same setup. Is error-free transmission possible with a block code of $k = 4$ input bits and $n = 10$ output bits?
  - #strong("Answer:") #def[No].
  - #strong("Reason:") Here $R = k/n = 0.4$. While $R < C$ is satisfied, we have #imp[limited the length of the blocks]. The Coding Theorem is an #imp[asymptotic result] ($n -> infinity$). For small fixed $n$, error-free transmission is not guaranteed.

  #hline()
  #strong("4. Minimum Code Length for Target Error") \
  #grid(columns: 2, align: top, gutter: 0.3em,
  [*Question:* $C = 0.5$ bits/symb, $R = 0.4$. What code length $n$ is needed for an error probability $pi < 10^(-6)$?],
  block(stroke: 0.5pt, inset: 3pt)[*Hint:* $n >= (log_2 (1/P_"max")) / (C - R)$])
  - #strong("Calculation (assuming bits, so base 2):")
    $ n >= (log_2(10^6)) / (0.5 - 0.4) = (6 log_2(10)) / 0.1 approx (6 times 3.32) / 0.1 = 199.2 $
  - #strong("Result:") #def[$n = 200$]
]


#pagebreak()
== Code and parameter design (Lecture 6)

#fbox("Introduction: Code and Parameter Design")[
  - #def[Objective:] How to choose a code and its parameters?
    - How to design a code with desired correction capability?
    - How to choose the code parameters for a desired performance?
    - Following the constraints of the system.
  - #imp[Note:] In practice design is mostly done using simulations!
]

#tbox("Example 1: Evaluate Different Codes")[
  Assume a binary channel of capacity $C = 0.72 " bits/symbol"$. Evaluate 3 options:
  - Hamming code with redundancy $5$.
  - Regular LDPC with parity matrix size $300 times 1000$.
  - Binary image of a strict-sense Reed-Solomon code $C_(8,beta)$ in $F_16$

  #hline()
  #underline[*Option 1 — Hamming ($r=5$):*] \
  $n = 2^5 - 1 = 31$, $k = 31 - 5 = 26$. \
  $ imp(underbrace(R, #place(center, dy: 0.1em)[#text(size: 7.5pt)[Code Rate]]) = k / n = 26 / 31 approx 0.839 > overbrace(C, #text(size: 7.5pt)[Capacity])=0.72) $
  #text(fill: red.darken(20%), weight: "bold")[Reject:] Rate is above capacity.

  #hline()
  #underline[*Option 2 — Regular LDPC ($300 times 1000$):*] \
  $n = 1000$, $n-k = 300$, $k = 700$ assuming $H$ has full rank $300$. \
  $ imp(R = 700 / 1000 = 0.7 < C) $
  #text(fill: green.darken(20%), weight: "bold")[Good:] Rate below capacity. \
  $ underbrace(pi, #place(center, dy: -0.1em)[#text(size: 7.5pt)[Error Prob.]]) approx 2^(-underbrace(n, #place(center, dy: 0.1em)[#text(size: 7.5pt)[Length]]) (underbrace(C-R, #place(center, dy: 0.3em, text(size: 7.5pt)[Margin])))) = 2^(-1000(0.02)) = 2^(-20) approx 9.5 dot 10^(-7) $

  #hline()
  #underline[*Option 3 — Binary image of RS in $F_16$:*] \
  Symbols in $F_16$ have $m = 4$ bits. \
  Length $n_"RS" = q - 1 = 15$. For $k_"RS" = 8$, $d_"RS" = 15 - 8 + 1 = 8$. \
  Corrects $t = floor((d_"RS" - 1) / 2) = 3$ symbol errors. \
  Binary image: $n_"bin" = 15 dot 4 = 60$, $k_"bin" = 8 dot 4 = 32$. \
  $ imp(R = 32 / 60 approx 0.533 < C) $
  #text(fill: green.darken(20%), weight: "bold")[Good:] But lower rate than LDPC.
]

#tbox("Example 2: Code Design with Bounds")[
  #underline[*Target codes:*]
  *Objective:* Evaluate whether the desired codes are #def[possible or impossible] using theoretical bounds and known constructions.
  1. #imp[Binary] $[31,25]$, $d_min = 3$ (#imp[$t=1$] error correction)
  2. #imp[Binary] $[20,13]$, $d_min = 5$ (#imp[$t=2$] errors correction)
  3. Code $[31,25]$ in $FF_32$, $d_min = 5$ (#imp[$q=32$ symbols])
  4. Code $[40,32]$ in $FF_128$, $d_min = 10$ (#imp[$q=128$ symbols])
  3 and 4 are for RS codes.

  #hline()
  #grid(columns: (1fr, 1fr), gutter: 1em, [
    #underline[*1) Binary $[31,25]$, $d_min = 3$*] \
    Hamming bound for $t=1$: \
    #text(size: 7pt)[$ 2^25 (binom(31,0) + binom(31,1)) = 2^25 (32) = 2^30 <= 2^31 $]
    Also, a Hamming $[31,26,3]$ exists, taking a subcode works. \
    #text(fill: green.darken(20%), weight: "bold")[Possible.]

    #hline()
    #underline[*2) Binary $[20,13]$, $d_min = 5$*] \
    Hamming bound for $t=2$: \
    #text(size: 7.5pt)[$ 2^13 (1 + 20 + 190) = 2^13 (211) <= 2^20 $]
    $ imp(211 <= 2^(20-13) = 128) $ (False!) \
    #text(fill: red.darken(20%), weight: "bold")[Impossible.]
  ], [
    #underline[*3) Code $[31,25]$ in $F_32$, $d_min = 5$*] \
    Singleton bound: \
    #text(size: 8pt)[$ d_min <= n - k + 1 = 31 - 25 + 1 = 7 $]
    Since $5 <= 7$, the bound holds. An RS code provides $d = 7$. \
    #text(fill: green.darken(20%), weight: "bold")[Possible.]

    #hline()
    #underline[*4) Code $[40,32]$ in $F_128$, $d_min = 10$*] \
    Singleton bound: \
    #text(size: 8pt)[$ d_min <= n - k + 1 = 40 - 32 + 1 = 9 $]
    We want $d_min = 10 > 9$. \
    #text(fill: red.darken(20%), weight: "bold")[Impossible.]
  ])

  #hline()
  #underline[*Theoretical Reminders:*]
  - #def[Hamming Bound:] For a $q$-ary code correcting $t = floor((d_min - 1)/2)$ err.:
    $ imp(|cal(C)| sum_(i=0)^t binom(n, i) (q-1)^i <= q^n stretch(->)^(|cal(C)| = q^k) q^k sum_(i=0)^t binom(n, i) (q-1)^i <= q^n) $
  - #def[Singleton Bound:] For any $q$-ary code:
    $ imp(|cal(C)| <= q^(n - d_min + 1) stretch(->)^(|cal(C)| = q^k) d_min <= n - k + 1) $
    Reed-Solomon codes reach equality, hence they are MDS.
]

#tbox("Example 3: Parameter Design")[
  $C = 0.72$ bits/symb, channel rate $1$ Msymb/s ($tau_c = 1 mu s$), source stream $600$ kbits/s. Target $pi = 10^(-5)$.

  #hline()
  #grid(columns: (1fr, 1fr), gutter: 1em, [
    #underline[*Rate and Block Length:*] \
    Required code rate:
    $ imp(underbrace(R, #place(center, dy: 0.1em)[#text(size: 7.5pt)[Rate]]) = (600 " kbps") / (1000 " ksps") = 0.6 < overbrace(C, #place(center, dy: -0.4em,text(size: 7.5pt)[Capacity]))) $

    Using finite-length bound:
    $ 2^(-n(C-R)) <= 10^(-5) $

    $ imp(underbrace(n, #place(center, dy: 0.1em)[#text(size: 7.5pt)[Min Length]]) &>= (log_2(10^5)) / (C-R)\ &approx 16.61 / 0.12 approx 138.4) $

    Choose $n=140$, hence:
    $ k = R n = 0.6 dot 140 = 84 $

    #text(fill: green.darken(20%), weight: "bold")[Possible:] use a code with parameters around $[140,84]$.
  ], [
    #underline[*Using Fewer Channel Resources:*] \
    If we reduce the channel use and push the rate closer to capacity:
    $ R -> C = 0.72 $

    Minimum channel use:
    $ "Channel use" = (600 " kbps") / 0.72 approx 833 " ksps" $

    But as $R -> C, C - R -> 0 $ Therefore:
    $ n >= (log_2(1/pi))/(C-R) -> infinity $

    #text(fill: fuchsia, weight: "bold")[Tradeoff:] Fewer channel resources require longer codes and more decoding complexity.
  ])

  #hline()
  #underline[*Theoretical Reminder:*] \
  - #strong("Reliability:") Transmission with $pi -> 0$ is possible if #imp[$R < C$].
  - #strong("Finite Length Margin:") To achieve a target error $pi$ at rate $R$, the length $n$ must satisfy:
    $ imp(n >= (log_2(1/pi)) / (C - R)) $
]

#tbox("Example 4: Parameter Design for RS Codes")[
  Target binary length $n_"bin" = 30$.

  #hline()
  #grid(columns: (1fr, 1fr), gutter: 1em, [
    #underline[*In $F_8$ ($m=3$)?*] \
    Each symbol has $m=3$ bits:
    $ n_"RS" = n_"bin" / m = 30/3 = 10 $

    Max RS length in $F_8$:
    $ q - 1 = 8 - 1 = 7 $
    or $8$ if extended.\
    Since: $10 > 8 $

    #text(fill: red.darken(20%), weight: "bold")[Impossible in $F_8$.]
  ], [
    #underline[*In $F_32$ ($m=5$)?*] \
    Each symbol has $m=5$ bits:
    $ n_"RS" = n_"bin" / m = 30/5 = 6 $

    Max RS length in $F_32$:
    $ q - 1 = 32 - 1 = 31 $

    Since: $6 <= 31 $
    we can use a shortened RS code.

    #text(fill: green.darken(20%), weight: "bold")[Possible:] use $F_32$ with $n_"RS"=6$.
  ])

  #hline()
  #underline[*Theoretical Reminder:*] \
  - #strong("RS Code Selection:") Max strict-sense RS length is $n <= q-1$, where $q=2^m$ is the field size. Extended RS codes can reach $n <= q$.
  - #strong("Binary Image:") An $(n, k, d)$ code over $FF_(2^m)$ becomes an $(n dot m, k dot m)$ binary code.
  - #def[MDS Property:] RS codes satisfy $d = n - k + 1$, hence correction power:
    $t = floor((d-1)/2) = floor((n-k)/2) $
]

#tbox("Example 5 & 6: Constrained Applications")[
  #grid(columns: (1fr, 1fr), gutter: 1em, [
    #underline[*Ex 5: Video Streaming*] \
    Qualities: 1080p (3M), 720p (2M), 480p (1M). \
    Available code rates: $1/2, 2/3, 3/4$. \
    Given: $n=120$, channel rate $4$ Msymb/s, $C=0.714$, target $pi <= 10^(-4)$.

    #text(size: 8.5pt)[
      Using: $2^(-120(C-R)) <= 10^(-4) $

      $ imp(R &<= C - log_2(10^4)/120\ &approx 0.714 - 13.29/120 approx 0.603) $

      Test rates:
      $ 1/2 = 0.5 <= 0.603 quad #text(fill: green.darken(40%))[works] $
      $ 2/3 approx 0.667 > 0.603 quad #text(fill: red.darken(40%))[fails] $
      $ 3/4 = 0.75 > 0.603 quad #text(fill: red.darken(40%))[fails] $

      Useful rate:\
      $4 " Msymb/s" dot 1/2 = 2 "Mbps" $\
      #text(fill: green.darken(20%), weight: "bold")[Best:] 720p with $R=1/2$.
    ]
  ], [
    #underline[*Ex 6: 4G AMC*] \
    QAM-4, $C = 0.906$, $n=100$. \
    Available code rates: $1/2, 2/3, ...$ \
    Target $overline(pi) <= 10^(-7)$.

    #text(size: 8.5pt)[
      Using: $2^(-100(C-R)) <= 10^(-7) $

      $ imp(R &<= C - (log_2(10^7))/100\ &approx 0.906 - 23.25/100 approx 0.6735) $

      Test rates:
      $ 1/2 = 0.5 <= 0.6735 quad #text(fill: green.darken(40%))[works] $
      $ 2/3 approx 0.6667 <= 0.6735 quad #text(fill: green.darken(40%))[works] $
      $ 3/4 = 0.75 > 0.6735 quad #text(fill: red.darken(40%))[fails] $

      #text(fill: green.darken(20%), weight: "bold")[Best:] $R = 2/3$ for highest throughput.
    ]
  ])

  #hline()
  #underline[*Theoretical Reminder:*] \
  - #strong("Admissible Rate:") From $2^(-n(C-R)) <= pi$, we get:
    $ imp(R <= C - (log_2(1/pi))/n) $
  - #strong("Strategy:") Choose the largest available rate $R$ satisfying the admissible-rate constraint, to maximize useful throughput.
]

#fbox("Summary: Parameter Design Tools")[
  - #def[Code logic:] Reliable transmission requires #imp[$R < C$]. Finite length requires a margin $C - R > 0$.
  - #def[Rate design:] Source rate must fit inside channel usage:
    $ R = "source rate" / "channel rate" $
  - #def[Performance bound:] From $2^(-n(C-R)) <= pi$:
    $ n >= (log_2(1/pi)) / (C-R) $
    or equivalently:
    $ R <= C - (log_2(1/pi))/n $
  - #def[Tradeoff:] As $R -> C$, the margin $C-R -> 0$, so the required block length $n -> infinity$.
  - #def[RS selection:] Over $FF_(2^m)$, each symbol represents $m$ bits. Strict-sense RS has max length $n <= q-1$, extended RS can reach $n <= q$.
  - #def[Binary image:] An $(n,k,d)$ code over $FF_(2^m)$ becomes an $(n dot m, k dot m)$ binary code.
  - #def[MDS / RS:] Reed-Solomon codes are MDS:
    $ d = n-k+1, quad t = floor((d-1)/2) = floor((n-k)/2) $
]

#pagebreak()
== LDPC Codes (Lecture 5) (Not in exam, so barely covered here)
#fbox("LDPC & AWGN Channel")[
  #def[LDPC (Low-Density Parity-Check):] Linear block codes defined by a #imp[sparse parity-check matrix]. They retain a large block length to approach capacity while allowing efficient iterative decoding.

  #subdefbox("AWGN Channel")[
    #def[Additive White Gaussian Noise:] Binary symbols mapped to $x'_i in {+1, -1}$.
    $ imp(Y = X' + W) quad "with" quad W ~ cal(N)(0, sigma^2) $
    - #strong("Hard Decoding:") Decisions taken independently ($hat(x_i) = 1 "if" y_i > 0$). Equivalent to BSC.
    - #strong("Soft Decoding:") Uses the real value $y_i$. Max log-likelihood equals #imp[minimum Euclidean distance]. Optimal decoding is too complex for generic long codes, but enabled by LDPC.
  ]
]

#fbox("Tanner Graphs & Code Structure")[
  A #def[Tanner Graph] is a bipartite graph representing the sparse parity matrix $H$.
  - #def[Variable nodes (v-nodes) $x_j$:] Coded bits (columns of $H$).
  - #def[Check nodes (c-nodes) $f_i$:] Parity equations (rows of $H$).
  - #imp[Edge exists] iff $H_(i,j) = 1$. The parity of bits connected to $f_i$ must be zero.
  - #def[Regular LDPC:] Constant 1s per column ($W_c$) and row ($W_r$). Irregular codes often perform better.
  - #strong("Cycles:") Closed loops. #imp[Short cycles degrade performance] in iterative decoding and must be avoided.
  - LDPC implies low amount of connections per node.
  #align(center)[
    $ H = mat(
      0, 1, 0, 1, 1, 0, 0, 1;
      1, 1, 1, 0, 0, 1, 0, 0;
      0, 0, 1, 0, 0, 1, 1, 1;
      1, 0, 0, 1, 1, 0, 1, 0
    ) -> "Bad example\ntoo many ones" $
    #v(-1.5em)
    #scale(80%, [
      #cetz.canvas({
        import cetz.draw: *

        let c_pos = (1.2, 3.0, 4.8, 6.6)

        // c_nodes
        for i in range(4) {
          rect((c_pos.at(i) - 0.25, 2.75), (c_pos.at(i) + 0.25, 3.25), name: "f" + str(i))
          content((c_pos.at(i), 3.7), [$f_#i$])
        }

        // v_nodes
        for i in range(8) {
          circle((i * 1.1, 0), radius: 0.25, name: "c" + str(i))
          content((i * 1.1, -0.6), [$c_#i$])
        }

        content((8, 3), [$c_"nodes"$], anchor: "west")
        content((8, 0), [$v_"nodes"$], anchor: "west")

        let edges = (
          (0, 1), (0, 3), (0, 4), (0, 7),
          (1, 0), (1, 1), (1, 2), (1, 5),
          (2, 2), (2, 5), (2, 6), (2, 7),
          (3, 0), (3, 3), (3, 4), (3, 6)
        )

        for (f, c) in edges {
          let is_bold = (f == 1 and c == 2) or (f == 2 and c == 2) or (f == 2 and c == 5) or (f == 1 and c == 5)
          line("f" + str(f), "c" + str(c), stroke: if is_bold { 1.5pt } else { 0.5pt })
        }
      })
    ])
    #v(-1.5em)
  ]
]

#tbox("Hard decoding Example")[
  #underline[*Step 2:*] C-nodes process the received values and send messages.
  #align(center)[
    #text(size: 8pt)[
      #table(
        columns: 6,
        align: center,
        stroke: (x, y) => if y == 0 { (bottom: 0.5pt) } else if x == 0 { (right: 0.5pt) },
        [*c-node*], table.cell(colspan: 5)[*received/sent*],
        [$f_0$], [received:\ sent:], [$c_1 arrow.r 1$\ $0 arrow.r c_1$], [$c_3 arrow.r 1$\ $0 arrow.r c_3$], [$c_4 arrow.r 0$\ $1 arrow.r c_4$], [$c_7 arrow.r 1$\ $0 arrow.r c_7$],
        [$f_1$], [received:\ sent:], [$c_0 arrow.r 1$\ $0 arrow.r c_0$], [$c_1 arrow.r 1$\ $0 arrow.r c_1$], [$c_2 arrow.r 0$\ $1 arrow.r c_2$], [$c_5 arrow.r 1$\ $0 arrow.r c_5$],
        [$f_2$], [received:\ sent:], [$c_2 arrow.r 0$\ $0 arrow.r c_2$], [$c_5 arrow.r 1$\ $1 arrow.r c_5$], [$c_6 arrow.r 0$\ $0 arrow.r c_6$], [$c_7 arrow.r 1$\ $1 arrow.r c_7$],
        [$f_3$], [received:\ sent:], [$c_0 arrow.r 1$\ $1 arrow.r c_0$], [$c_3 arrow.r 1$\ $1 arrow.r c_3$], [$c_4 arrow.r 0$\ $0 arrow.r c_4$], [$c_6 arrow.r 0$\ $0 arrow.r c_6$],
      )
    ]
  ]

  #underline[*Step 3:*] v-nodes use a #imp[majority voting] on the bit value.
  #align(center)[
    #text(size: 8pt)[
      #table(
        columns: 4,
        align: center,
        stroke: (x, y) => if y == 0 { (bottom: 0.5pt) } else if x == 0 or x == 1 or x == 2 { (right: 0.5pt) },
        [*v-node*], [*$y_i$ received*], [*messages from check nodes*], [*decision*],
        [$c_0$], [$1$], [$f_1 arrow.r 0 quad f_3 arrow.r 1$], [$1$],
        [$c_1$], [$1$], [$f_0 arrow.r 0 quad f_1 arrow.r 0$], [$0$],
        [$c_2$], [$0$], [$f_1 arrow.r 1 quad f_2 arrow.r 0$], [$0$],
        [$c_3$], [$1$], [$f_0 arrow.r 0 quad f_3 arrow.r 1$], [$1$],
        [$c_4$], [$0$], [$f_0 arrow.r 1 quad f_3 arrow.r 0$], [$0$],
        [$c_5$], [$1$], [$f_1 arrow.r 0 quad f_2 arrow.r 1$], [$1$],
        [$c_6$], [$0$], [$f_2 arrow.r 0 quad f_3 arrow.r 0$], [$0$],
        [$c_7$], [$1$], [$f_0 arrow.r 0 quad f_2 arrow.r 1$], [$1$],
      )
    ]
  ]
  - #imp[Advantage:] We do not have to check all possible codewords, decisions are taken locally using majority voting.
  #v(-1.3em)
  #align(center)[
    #scale(80%, [
      #cetz.canvas({
        import cetz.draw: *

        let c_pos = (1.2, 3.0, 4.8, 6.6)
        let colors = (blue.lighten(20%), orange, fuchsia, red)

        // c_nodes
        for i in range(4) {
          rect((c_pos.at(i) - 0.25, 2.75), (c_pos.at(i) + 0.25, 3.25), name: "f" + str(i), stroke: colors.at(i) + 1.5pt)
          content((c_pos.at(i), 3.7), [$f_#i$])
        }

        // v_nodes
        for i in range(8) {
          circle((i * 1.1, 0), radius: 0.25, name: "c" + str(i), stroke: 1.5pt)
          content((i * 1.1, -0.6), [$c_#i$])
        }

        let edges = (
          (0, 1, "0"), (0, 3, "0"), (0, 4, "1"), (0, 7, "0"),
          (1, 0, "0"), (1, 1, "0"), (1, 2, "1"), (1, 5, "0"),
          (2, 2, "0"), (2, 5, "1"), (2, 6, "0"), (2, 7, "1"),
          (3, 0, "1"), (3, 3, "1"), (3, 4, "0"), (3, 6, "0")
        )

        for (f, c, lbl) in edges {
          line("f" + str(f), "c" + str(c), stroke: colors.at(f) + 1.2pt, mark: (end: "stealth", fill: colors.at(f), scale: 0.5))
          content(("f" + str(f), 0.75, "c" + str(c)), text(size: 8pt, weight: "bold", fill: colors.at(f), lbl), padding: 0.1)
        }
      })
    ])
  ]
  #v(-1.8em)
  #align(center)[
    #text(size: 9pt)[
      #table(
        columns: (auto, 1.2em, 1.2em, 1.2em, 1.2em, 1.2em, 1.2em, 1.2em, 1.2em, auto),
        align: center,
        stroke: none,
        [],[$c_0$],[$c_1$],[$c_2$],[$c_3$],[$c_4$],[$c_5$],[$c_6$],[$c_7$],[],
        text(fill: green.darken(20%), weight: "bold")[$underline(y)$], text(fill: green.darken(20%), weight: "bold")[$1$], text(fill: green.darken(20%), weight: "bold")[$1$], text(fill: green.darken(20%), weight: "bold")[$0$], text(fill: green.darken(20%), weight: "bold")[$1$], text(fill: green.darken(20%), weight: "bold")[$0$], text(fill: green.darken(20%), weight: "bold")[$1$], text(fill: green.darken(20%), weight: "bold")[$0$], text(fill: green.darken(20%), weight: "bold")[$1$], [],
        table.hline(stroke: 1.5pt + luma(150)),
        [], text(fill: orange.darken(20%))[$0$], text(fill: blue.darken(20%))[$0$], text(fill: orange.darken(20%))[$1$], text(fill: blue.darken(20%))[$0$], text(fill: blue.darken(20%))[$1$], text(fill: orange.darken(20%))[$0$], text(fill: fuchsia.darken(10%))[$0$], text(fill: blue.darken(20%))[$0$], table.cell(rowspan: 2, align: horizon + left)[#text(size: 14pt, fill: gray.darken(20%))[$\}$] #text(fill: gray.darken(20%))[Tells them\ what to be]],
        [], text(fill: red.darken(20%))[$1$], text(fill: orange.darken(20%))[$0$], text(fill: fuchsia.darken(10%))[$0$], text(fill: red.darken(20%))[$1$], text(fill: red.darken(20%))[$0$], text(fill: fuchsia.darken(10%))[$1$], text(fill: red.darken(20%))[$0$], text(fill: fuchsia.darken(10%))[$1$],
        table.hline(stroke: 1.5pt + luma(150)), align(horizon + left)[$arrow.r.squiggly$ #text(fill: gray.darken(20%))[From majority\ votes]],[1],[#def[0]],[0],[1],[0],[1],[0],[1]
      )
    ]
  ]

]

#fbox("Message Passing Decoding")[
  - #strong("Principle:") Nodes exchange #def[extrinsic information]: #imp[info from other neighbors + intrinsic channel info], #imp[excluding] the destination node. Exact on trees, approx on graphs with cycles.
  - #strong("Goal:") Estimate marginal probability $P(x_i = 1 | underline(y), cal(C))$.
  - #strong("Hard Passing:") v-nodes send bit guesses, c-nodes return required parities, v-nodes take #imp[majority vote].

  #subdefbox("Soft Message Passing (Sum-Product / Belief Propagation)")[
    #strong("Initialization:") $y_i = x_i' + w_i$. $underbrace(P_i, #place(center, dy: 0.2em)[#text(size: 7.5pt)[Channel belief]]) = P(x_i = 1 | y_i) = 1 / (1 + exp(-2 y_i / sigma^2))$.
    Init edges: $q_(i j)(0) = 1 - P_i$, $q_(i j)(1) = P_i$.
    #v(0.5em)

    1. #def[c-node $j$ to v-node $i$ ($r_(j i)$):] Prob that $x_i = b$ satisfies parity (via #imp[Gallager's Lemma]):
       $ imp(r_(j i)(0) = 1/2 + 1/2 product_(i' in V_j, i' != i) underbrace((1 - 2 q_(i' j)(1)), #place(center)[#v(0.2em) #text(size: 7.5pt)[Prob. bit = 1]])) $
       $ r_(j i)(1) = 1 - r_(j i)(0) $
    #v(1em)

    2. #def[v-node $i$ to c-node $j$ ($q_(i j)$):] Combine channel info with all checks except $j$:
       $ imp(q_(i j)(0) = K_(i j) underbrace((1 - P_i), #place(center)[#v(0.2em) #text(size: 7.5pt)[Channel]]) product_(j' in C_i, j' != j) underbrace(r_(j' i)(0), #place(center)[#v(0.2em) #text(size: 7.5pt)[Other checks]])) $
       $ q_(i j)(1) = K_(i j) P_i product_(j' in C_i, j' != j) r_(j' i)(1) $
       #text(size: 8pt)[(where $K_(i j)$ normalizes: $q_(i j)(0) + q_(i j)(1) = 1$)]
    #v(1.2em)

    3. #def[Final bit belief:] Use #imp[all] neighboring check messages:
       $ Q_i(0) = K_i (1 - P_i) product_(j in C_i) r_(j i)(0), quad Q_i(1) = K_i P_i product_(j in C_i) r_(j i)(1) $
       #strong("Decision:") $x_i = 1$ if $Q_i(1) > 0.5$. Iterate until $H underline(x)^T = 0$ or max iterations reached.
  ]

  #subdefbox("Gallager's Lemma")[
    For indep. bits $a_i$ with $P(a_i = 1)=p_i$, the probability their sum has even parity is:
    $ imp(P("even parity") = 1/2 + 1/2 product_(i=0)^(m-1) (1 - 2p_i)) $
  ]

  - #strong("Comments:") Exact on cycle-free graphs. Short cycles degrade decoding. Direct probabilities are unstable.
  - #strong("Log-Domain (LLR):") Use $L(x_i | y_i) = log_2 (P(x_i = 1 | y_i) / P(x_i = -1 | y_i))$ to replace multiplications with additions and avoid numerical instability. Products become sums:
    $ imp[$L(r_(j i)) = log_2 (r_(j i)(1) / r_(j i)(0)), quad L(q_(i j)) = L(x_i | y_i) + sum_(j' in C_i, j' != j) L(r_(j' i)))$] $
    Hard decision: $x_i = 1$ if $L(Q_i) > 0$.
]

/*
  The main missing parts are:

  AWGN / hard decoding details
  Maximum-likelihood hard decision:
  $ hat(x)_i = 1 " if " y_i > 0 $
  Equivalent BSC after hard decision:
  $ p = P(Y_i < 0 | X_i' = 1) = 1/2 "erfc"(1 / sqrt(2 sigma^2)) $
  Soft decoding as closest-neighbour / minimum Euclidean distance.
  LDPC definition details
  Regular LDPC:
  $ W_c = W_r (n/m) $
  where $W_c$ is ones per column and $W_r$ is ones per row.
  Irregular LDPCs are more general and often better.
  LDPCs are powerful because $H$ is sparse but block length is large.
  Design of LDPC codes
  Low density for efficient decoding.
  Avoid short cycles.
  One construction idea:
  $ H = [A | I] $
  so encoding is easier.
  But good LDPC design is usually done by computer search.
  Performance/result slides
  Error rate as a function of SNR.
  Longer codes perform closer to capacity.
  Increasing block length improves performance but increases complexity.
  Soldier-counting analogy
  This is not essential mathematically, but it explains #def[extrinsic information] very well:
  line/tree: messages converge correctly;
  loop: messages can circulate forever;
  same reason cycles hurt message passing.
  Conclusion slide
  LDPC codes are very powerful.
  Work on very large block sizes.
  Efficient iterative decoding due to sparse $H$.
  Short cycles should be avoided.
  Need careful design depending on code rate.
  Design should allow easy encoding.

  One correction to watch: your c-node formula uses

  1 - 2 q_(i' j)(0)

  This matches the slide notation, but it is only consistent if q(0) is the probability of the “1/error/active” value used in Gallager’s lemma. In your text, however, you define:

  q_(i j)(0) = 1 - P_i
  q_(i j)(1) = P_i

  where $P_i = P(x_i=1 | y_i)$. With that convention, the parity formula should usually use $q_(i'j)(1)$, not $q_(i'j)(0)$:

  r_(j i)(0) = 1/2 + 1/2 product_(i' in V_j, i' != i) (1 - 2 q_(i' j)(1))

  or equivalently:

  r_(j i)(0) = 1/2 + 1/2 product_(i' in V_j, i' != i) (q_(i' j)(0) - q_(i' j)(1))

  So: the block is good for the decoding algorithm, but if the goal is “all LDPC slides”, add the missing AWGN/design/performance/conclusion pieces, and clarify the $q(0)$ vs $q(1)$ convention.
 */


= Part 2 Exercise Sessions & Exams

#exerbox("Exercises 2.1 — Channel Coding / Information Identities")[
  #subdefbox("Core reminders")[
    - #def[Entropy:] $H(X) = - sum_x p(x) log_2 p(x)$.
    - #def[Conditional entropy:] $H(X|Y) = H(X,Y) - H(Y)$.
    - #def[Mutual information:]
      $I(X;Y) = H(X) - H(X|Y) = H(Y) - H(Y|X)$.
    - #def[Chain rule:]
      $I(A;B,C) = I(A;B) + I(A;C|B)$.
    - #def[Conditioning decreases entropy:]
      $H(Y|U) >= H(Y|X,U)$, hence $I(X;Y|U) >= 0$.
  ]

  #hline()
  #underline[*Problem 1 — Memoryless channel used $N$ times*] \

  #strong("Assumption:") The pairs $(X_i,Y_i)$ are independent across $i$, and the channel is memoryless:
  $ p(y^N|x^N) = product_(i=0)^(N-1) p(y_i|x_i) $

  If the input symbols are independent:
  $ p(x^N,y^N) = product_(i=0)^(N-1) p(x_i,y_i) $

  Then, using memorylessness $p(x^N|y^N) = product_(i=0)^(N-1) p(x_i|y_i)$:
  $ H(X^N|Y^N)
    = - sum_(x^N,y^N) p(x^N,y^N) sum_(i=0)^(N-1) log_2 p(x_i|y_i) $

  Marginalizing all variables except $(x_i,y_i)$:
  $ H(X^N|Y^N) = sum_(i=0)^(N-1) underbrace(- sum_(x_i,y_i) p(x_i,y_i) log_2 p(x_i|y_i), #place(center)[#imp[$H(X_i|Y_i)$]]) $

  Therefore:
  $ #imp[$H(X^N|Y^N) = sum_(i=0)^(N-1) H(X_i|Y_i)$] $

  Similarly, $H(Y^N|X^N) = sum_(i=0)^(N-1) H(Y_i|X_i)$. If the inputs are independent, then also:
  $ I(X^N;Y^N) = sum_(i=0)^(N-1) I(X_i;Y_i) $

  #hline()
  #underline[*Problem 2 — Joint entropy and independence*] \

  From $I(X;Y) = H(X) - H(X|Y)$ and $H(X,Y) = H(Y) + H(X|Y)$ we obtain:
  $ H(X,Y) = H(X) + H(Y) - I(X;Y) $

  Since $I(X;Y) >= 0$, we have $#imp[$H(X,Y) <= H(X) + H(Y)$]$, with equality iff $X$ and $Y$ are independent.

  #hline()
  #underline[*Problem 3 — Data Processing Inequality*] \

  Suppose $U -> X -> Y$, meaning $p(y|x,u) = p(y|x)$. Hence $I(U;Y|X) = 0$.

  Chain rule applied two ways:
  $ I(U;X,Y) = I(U;X) + underbrace(I(U;Y|X), #place(center)[#imp[$0$]]) = I(U;X) $
  $ I(U;X,Y) = I(U;Y) + I(U;X|Y) $

  Since $I(U;X|Y) >= 0$, we get $I(U;X) >= I(U;Y)$. Also $I(X;Y) >= I(U;Y)$, so information cannot increase through the Markov chain:
  $ #imp[$U -> X -> Y quad => quad I(U;Y) <= I(X;Y)$] $

  For the reverse chain $Y -> X -> U$, the same argument gives $#imp[$I(U;Y) <= I(U;X)$]$.

  #hline()
  #underline[*Problem 4 — Fano's Inequality*] \

  Let $Z$ take values in an alphabet of size $S$, $hat(Z)$ an estimate of $Z$ from $Y$, and:
  $ W = cases(0 &"if " Z = hat(Z), 1 &"if " Z != hat(Z)) $
  $ pi = P(W=1) = P(Z != hat(Z)) $

  #strong("Step 1: split the uncertainty.") \
  Since $W$ is determined by $(Z,hat(Z))$ and $hat(Z)$ is determined by $Y$:
  $ H(Z|Y) <= H(W|Y) + H(Z|W,Y) $

  Then $H(W|Y) <= H(W) = h_2(pi)$. If $W=0$, then $Z=hat(Z)$ so $H(Z|W=0,Y)=0$. If $W=1$, $Z$ can be any of at most $S-1$ wrong symbols, so $H(Z|W=1,Y) <= log_2(S-1)$.

  Therefore:
  $ #imp[$H(Z|Y) <= h_2(pi) + pi log_2(S-1)$] $

  #strong("Useful consequence:") $I(Z;Y) >= H(Z) - h_2(pi) - pi log_2(S-1)$.

  #strong("Function case:") If $Z=g(X)$, then $H(Z|Y) <= H(X|Y)$.
  #imp[Meaning:] small error probability forces the conditional entropy to be small.
]

#exerbox("Exercises 2.2 — Binary Linear Codes")[
  #subdefbox("Core reminders")[
    - #def[Block code:] $C subset.eq {0,1}^n$, with $M=|C|$ codewords.
    - #def[Dimension/rank:] for a binary linear code, $M=2^k$.
    - #def[Rate:] $R = k/n$.
    - #def[Minimum distance:] $d(C) = min_(c != c') d(c,c')$. For a linear code, $d(C)=min_(c in C, c != 0) w(c)$
    - #def[Correcting capability:] $t(C)=floor((d(C)-1)/2)$
    - #def[Linear code:] $0 in C$ and $c+c' in C$ for all $c,c' in C$
    - #def[Hamming bound, binary:] $|C| sum_(i=0)^t binom(n,i) <= 2^n$
  ]

  #hline()
  #underline[*Problem 1 — Binary code characteristics*] \

  #strong([Code $C_1$:]) $C_1 = {000000, 010101, 101100, 111010}$
  - $n=6$, $M=4=2^2$ ($k=2$), $R=2/6=1/3$
  - $d(C_1)=3$, $t(C_1)=floor((3-1)/2)=1$
  - #text(fill: red.darken(20%), weight: "bold")[Not linear:] $010101 + 101100 = 111001 in.not C_1$

  #strong([Code $C_2$:]) $C_2 = {00000,11111}$
  - $n=5$, $M=2=2^1$ ($k=1$), $R=1/5$
  - $d(C_2)=5$, $t(C_2)=2$
  - #imp[Linear:] it is the binary repetition code of length $5$.

  #underline[*Decoding in $C_1$ by nearest neighbour*]
  $y_1=010001$: $d(y_1,010101)=1 => hat(y_1)=010101$\
  $y_2=111000$: $d(y_2,111010)=1 => hat(y_2)=111010$\
  $y_3=110100$: distance $2$ from both $010101$ and $101100$, so #text(fill: red.darken(20%), weight: "bold")[unable to decode uniquely].

  #hline()
  #underline[*Problem 2 — Perfect codes*] \

  #strong("Repetition code of length $5$:") $n=5$, $M=2$, $d=5$, $t=2$.
  Sphere size: $sum_(i=0)^2 binom(5,i)=1+5+10=16$. Total: $2 dot 16 = 32 = 2^5$. #def[Perfect.]

  #strong("Repetition code of length $4$:") $n=4$, $M=2$, $d=4$, $t=1$.
  Sphere size: $1+4=5$. Total: $2 dot 5 = 10 < 16 = 2^4$. #text(fill: red.darken(20%), weight: "bold")[Not perfect.]

  #hline()
  #underline[*Problem 3 — Bounds on codes*] \

  Binary code $n=12$, $t=2$. Hamming bound: $M sum_(i=0)^2 binom(12,i) <= 2^12$.
  Sphere size: $1+12+66=79$, so $M <= 2^12 / 79 approx 51.84 --> M <= 51$. For linear $M=2^k$: $k <= 5$.
  $#imp[$R <= 5/12$]$

  #hline()
  #underline[*Problem 4 — From parity matrix to generator matrix*] \

  Given $H = mat(1,0,0,0,1,0,1; 0,1,0,0,1,1,0; 0,0,1,0,0,1,1; 0,0,0,1,0,0,1)$

  After column permutation to canonical form:
  $ H' = [A | I_4] = mat(1,0,1,|,1,0,0,0; 1,1,0,|,0,1,0,0; 0,1,1,|,0,0,1,0; 0,0,1,|,0,0,0,1) $

  $A = mat(1,0,1; 1,1,0; 0,1,1; 0,0,1)$ A generator: $G = [I_3 | A^T] = mat(1,0,0,|,1,1,0,0; 0,1,0,|,0,1,1,0; 0,0,1,|,1,0,1,1)$

  Codebook $C={u G : u in {0,1}^3}$ = ${0000000, 0011011, 0100110, 0111101, 1001100, 1010111, 1101010, 1110001}$.
  $n=7$, $k=3$, $M=8$, $R=3/7$, $d(C)=3$, $t(C)=1$.

  #hline()
  #underline[*Problem 5 — Cosets and syndrome decoding*] \

  Given $C_3 = {00000,01110,10101,11011}$: $n=5$, $M=4=2^2$, $k=2$, $R=2/5$, $d=3$, $t=1$.

  Systematic $G = mat(1,0,|,1,0,1; 0,1,|,1,1,0) --> A = mat(1,1; 0,1; 1,0)$, $H=[A|I_3] = mat(1,1,|,1,0,0; 0,1,|,0,1,0; 1,0,|,0,0,1)$.

  #underline[*Coset leaders and syndromes*]

  #align(center)[
    #table(
      columns: 3, align: center, stroke: 0.3pt + luma(70%),
      [Syndrome], [Leader], [Coset],
      [$000$], [$00000$], [$00000,01110,10101,11011$],
      [$001$], [$00001$], [$00001,01111,10100,11010$],
      [$010$], [$00010$], [$00010,01100,10111,11001$],
      [$011$], [$00011$], [$00011,01101,10110,11000$],
      [$100$], [$00100$], [$00100,01010,10001,11111$],
      [$101$], [$10000$], [$10000,11110,00101,01011$],
      [$110$], [$01000$], [$01000,00110,11101,10011$],
      [$111$], [$01001$], [$01001,00111,11100,10010$],
    )
  ]

  #underline[*Decoding examples*]
  $y_4=10100$: $H y_4^T = 001$, leader $00001 => hat(y_4)=10101$.\
  $y_5=01011$: $H y_5^T = 101$, leader $10000 => hat(y_5)=11011$.\
  $y_6=00111$: $H y_6^T = 111$, leader $01001 => hat(y_6)=01110$.

  #underline[*Why syndrome decoding is not useful here*]
  For this tiny code, nearest-neighbour decoding is already easy. Syndrome decoding becomes useful for large codes: $y -> s=H y^T -> "leader" -> y+"leader"$.
]

#exerbox("Exercises 2.3 — Galois Fields")[
  #subdefbox("Core reminders")[
    - In $F_(2^m)$, addition is XOR.
    - If $alpha$ is root of $pi(x)$, computations use $pi(alpha)=0$.
    - Non-zero elements form a multiplicative cyclic group of size $2^m-1$ if $alpha$ is primitive.
    - In $F_(16)$, if $alpha$ is primitive, then $alpha^15=1$ and $(alpha^i)^(-1)=alpha^(15-i)$.
  ]

  #hline()
  #underline[*Problem 1 — Unicity / isomorphism of $F_8$*] \

  First field: $alpha^3 + alpha + 1 = 0 => alpha^3 = alpha + 1$.
  ${0,1,alpha,alpha^2,alpha^3,alpha^4,alpha^5,alpha^6} = {0,1,alpha,alpha^2,alpha+1,alpha^2+alpha,alpha^2+alpha+1,alpha^2+1}$.
  In binary $(alpha^2,alpha,1)$: $000,001,010,100,011,110,111,101$.

  Second field: $beta^3 + beta^2 + 1 = 0 => beta^3 = beta^2 + 1$.
  ${0,1,beta,beta^2,beta^3,beta^4,beta^5,beta^6} = {0,1,beta,beta^2,beta^2+1,beta^2+beta+1,beta+1,beta^2+beta}$.
  In binary $(beta^2,beta,1)$: $000,001,010,100,101,111,011,110$.

  #underline[*Find the isomorphism*] \
  Need $gamma$ in the beta-field satisfying $gamma^3 + gamma + 1 = 0$. Try $gamma = beta^3$:
  $gamma^3 = beta^9 = beta^2$, so $gamma^3 + gamma + 1 = beta^2 + beta^3 + 1 = beta^2 + (beta^2+1) + 1 = 0$.
  Therefore $#imp[$alpha -> beta^3$]$. Extends to isomorphism: $f(alpha^i)=beta^(3i mod 7)$.

  #hline()
  #underline[*Problem 2 — Computations in $F_16$*] \

  Let $alpha^4 + alpha + 1 = 0 => alpha^4 = alpha + 1$.

  #align(center)[
    #table(
      columns: 4, align: center, stroke: 0.3pt + luma(70%),
      [Power], [Polynomial], [Tuple], [Note],
      [$0$], [$0$], [$0000$], [],
      [$1$], [$1$], [$0001$], [],
      [$alpha$], [$alpha$], [$0010$], [],
      [$alpha^2$], [$alpha^2$], [$0100$], [],
      [$alpha^3$], [$alpha^3$], [$1000$], [],
      [$alpha^4$], [$alpha+1$], [$0011$], [$alpha^4=alpha+1$],
      [$alpha^5$], [$alpha^2+alpha$], [$0110$], [],
      [$alpha^6$], [$alpha^3+alpha^2$], [$1100$], [],
      [$alpha^7$], [$alpha^3+alpha+1$], [$1011$], [],
      [$alpha^8$], [$alpha^2+1$], [$0101$], [],
      [$alpha^9$], [$alpha^3+alpha$], [$1010$], [],
      [$alpha^10$], [$alpha^2+alpha+1$], [$0111$], [],
      [$alpha^11$], [$alpha^3+alpha^2+alpha$], [$1110$], [],
      [$alpha^12$], [$alpha^3+alpha^2+alpha+1$], [$1111$], [],
      [$alpha^13$], [$alpha^3+alpha^2+1$], [$1101$], [],
      [$alpha^14$], [$alpha^3+1$], [$1001$], [],
      [$alpha^15$], [$1$], [$0001$], [loop],
    )
  ]

  #underline[*Reductions and inverses*]
  $alpha^30 = (alpha^15)^2 = 1$.
  $alpha^8 + alpha^16 = alpha^8 + alpha = (alpha^2+1)+alpha = alpha^2+alpha+1 = alpha^10$.
  $(alpha^3+alpha+1)(alpha^2+1) = alpha^7 alpha^8 = alpha^15 = 1$.
  $op("Inv")(alpha^3+alpha^2) = op("Inv")(alpha^6) = alpha^(15-6) = alpha^9 = alpha^3+alpha$.

  #underline[*Solving equations*]
  $x^2+1=0$: in characteristic $2$, $(x+1)^2=0$, so $#imp[$x=1$]$.
  $x^3+x=0$: $x(x+1)^2=0$, so $#imp[$x in {0,1}$]$.
  $alpha^5 x^2 + x + 1 = 0$: by table substitution, $#imp[$x in {alpha^11, alpha^14}$]$.
  $x^15+1=0$: every non-zero element satisfies $x^15=1$, so $#imp[$x in F_16^*$]$.

  #hline()
  #underline[*Problem 3 — Minimal polynomials in $F_16$*] \

  Frobenius conjugates: $alpha^i -> alpha^(2i mod 15)$. Cyclotomic classes mod $15$:
  $C_0={0}$, $C_1={1,2,4,8}$, $C_3={3,6,12,9}$, $C_5={5,10}$, $C_7={7,14,13,11}$.

  $m_i(x)=product_(j in C_i)(x-alpha^j)$.

  For $alpha^4$ (class $C_1$): $#imp[$m_(alpha^4)(x)=x^4+x+1$]$.

  For $alpha^5$ (class $C_5={5,10}$): $m_(alpha^5)(x) = (x-alpha^5)(x-alpha^10) = x^2 + (alpha^5+alpha^10)x + alpha^15$.
  $alpha^5+alpha^10 = (alpha^2+alpha)+(alpha^2+alpha+1)=1$, so $#imp[$m_(alpha^5)(x)=x^2+x+1$]$.
]

#exerbox("Exercises 2.4 — Reed-Solomon Codes")[
  #subdefbox("Core reminders")[
    - #def[Singleton bound:] $d(C) <= n-k+1$.
    - #def[MDS code:] reaches equality: $d(C)=n-k+1$.
    - #def[RS code:] evaluates polynomials of degree $<k$ at distinct field points.
    - RS codes are #imp[MDS], so $d=n-k+1$, $t=floor((d-1)/2)=floor((n-k)/2)$.
  ]

  #hline()
  #underline[*Problem 1 — Which matrices generate MDS codes over $F_4$?*] \

  $F_4={0,1,alpha,alpha^2}$, $alpha^2=alpha+1$. Theorem: $C$ is MDS iff any $k$ columns of $G$ are linearly independent.

  #strong("Matrix 1:") $[4,2]$, Singleton target $d=3$. All column pairs have non-zero determinants: #text(fill: green.darken(20%), weight: "bold")[MDS].

  #strong("Matrix 2:") $[5,3]$, Singleton target $d=3$. All column triples independent: #text(fill: green.darken(20%), weight: "bold")[MDS].

  #strong("Matrix 3:") $[6,3]$, Singleton target $d=4$. A $3 times 3$ submatrix with $det=0$ exists: #text(fill: red.darken(20%), weight: "bold")[Not MDS].
  #imp[Shortcut:] one dependent set of $k$ columns suffices to disprove MDS.

  #hline()
  #underline[*Problem 2 — Reed-Solomon encoding over $F_8$*] \

  RS code: $k=2$, $n=4$. $R=1/2$, MDS: $d=4-2+1=3$, $t=1$.

  #underline[*Binary image*] Each $F_8$ symbol = $3$ bits, so $n_"bin" = 4 dot 3 = 12$.

  #underline[*Encoding example*] Input $010100$ splits to $(alpha, alpha^2)$ (using $010|100$).
  RS codeword: $c = (alpha^4, 1, alpha^3, alpha^2)$.
  Binary: $alpha^4=110$, $1=001$, $alpha^3=011$, $alpha^2=100$, so $#imp[$c_"bin" = 110001011100$]$.
]

#exerbox("Exercises 2.5 — Channel Capacity")[
  #subdefbox("Core reminders")[
    - Channel matrix entries: $P_(Y|X)(y|x)$, each row sums to $1$.
    - Output distribution: $P_Y = P_(Y|X)^T P_X$.
    - Mutual information: $I(X;Y)=H(Y)-H(Y|X)$.
    - Capacity: $C = max_(P_X) I(X;Y)$.
  ]

  #hline()
  #underline[*Problem 1 — Channel transition matrices*] \

  #strong("a) Matrices from diagrams")\
  $P_(Y|X) = mat(0.5,0.5; 0.1,0.9; 1,0)$ and $P_(Y|X) = mat(0.8,0.2,0; 0.1,0.9,0; 0,0,1)$.

  #strong("b) Valid channel matrices") A matrix is valid iff entries $>=0$ and each row sums to $1$. Examples:
  - $mat(1,0;1,0;1,0)$ valid. $mat(1,1,1;0,0,0)$ invalid.
  - $mat(0.2,0.2;0.8,0.8)$ invalid (rows = inputs). $mat(0.2,0.8;0.8,0.2)$ valid.
  - $mat(0.2,0.9,0;0.8,0.1,0;0,0,1)$ invalid (row 1 sums to $1.1$).

  #strong("c) Symmetric channels") Rows are permutations of each other and columns have compatible sums. Example: $mat(0.2,0.8;0.8,0.2)$.

  #strong("d) Deterministic channel") $Y=f(X)$ iff each row has exactly one $1$, rest $0$.

  #strong("e) Output distribution") $#imp[$P_Y = P_(Y|X)^T P_X$]$.

  #hline()
  #underline[*Problem 2 — Conditional entropy decreases*] \

  Z-channel: $P(X=0)=1/3$, $P(X=1)=2/3$. Channel: $X=0 => Y=0$ (sure); $X=1 => Y in {0,1}$ equally likely.
  $P(Y=0)=1/3 + (2/3)(1/2)=2/3$, $P(Y=1)=1/3$. $H(X)=h_2(1/3) approx 0.918$.
  $H(X|Y=1)=0$, $H(X|Y=0)=1$, so $H(X|Y)=2/3 approx 0.667$, $I(X;Y) approx 0.252$.

  Thus $#imp[$H(X|Y)=2/3 <= H(X) approx 0.918$]$.

  #hline()
  #underline[*Problem 3 — Channel capacity of first two channels from 1.c*] \

  #strong("Channel 1: erasure-like") $P_(Y|X)=mat(0.8,0,0.2; 0,0.8,0.2)$. BEC with $epsilon=0.2$, $#imp[$C=1-epsilon=0.8$]$.

  #strong("Channel 2: identical rows") $P_(Y|X)=mat(0.2,0.8; 0.2,0.8)$. Output independent of input, $I(X;Y)=0$, so $#imp[$C=0$]$.
  #text(fill: red.darken(20%), weight: "bold")[This channel is useless for communication.]
]
#block(fill: red, "TODO - Move all exams here for this section, also, take older exams", inset: 0.4em)








#pagebreak()
= Secure Coding (3.1)

#fbox("Information-Theoretic Cryptography: Big Picture")[
  #grid(columns: (1fr, 1fr), gutter: 1em, [
    #underline[*Coding*]
    - #strong("Goal:") #imp[Reliable decoding] over noisy/oblivious channels.
    - Protects against #imp[random noise].
  ], [
    #underline[*Cryptography*]
    - #strong("Goals:") #imp[Authenticity] against modification + #imp[Confidentiality] against unsolicited decoding.
    - Protects against #imp[active adversaries].
  ])

  #hline()
  #underline[*Two approaches:*]
  - #def[Computational crypto:] efficient and widely used, but relies on computational assumptions.
  - #def[Information-theoretic crypto:] no computational assumptions, unconditional security, but often needs special channels, interaction, or large communication.

  #underline[*Uses:*] highest confidentiality, QKD, randomness extraction, secret sharing, distributed trust, secure function evaluation.
]

#fbox("Encryption, Perfect Secrecy & One-Time Pad")[
  #v(1.2em)
  $ "Alice" stretch(->)^("Enc") C #place(center, dy: -1.7em)[$arrow.tr$] #place(center, dy: -2.5em, dx: 1.3em)[Eve] stretch(->)^("Dec") "Bob" $
  Alice has message $M$ and shared key $K$; Eve observes ciphertext $C$

  #subdefbox("Perfect Secrecy [Shannon]")[
    $ I(M;C)=0 $
    i.e. $M$ and $C$ are independent: Eve learns nothing of $M$ from $C$
  ]

  #subdefbox("One-Time Pad (OTP)")[
    Message $M=(m_1,...,m_N)$\
    Key $K=(k_1,...,k_N)$ Uniform independent bit-string ($underbrace(perp M, #place(center)[independent of M])$)\
    Define Ciphertext $C=(c_1,...,c_N)$ with:
    #imp[$ underbrace(c_i = m_i plus.o k_i,"Enc") quad quad underbrace(m_i = c_i plus.o k_i,"Dec") $]
    This scheme achieves #def[perfect secrecy]
  ]
  - $forall (m,c)$ there is exactly one key $k=m plus.o c$, so $I(M;C)=0$.
  - #imp[Knowing any two] among $M,K,C$ determines the third.
  - #text(fill: red.darken(20%), weight: "bold")[Drawbacks:] fresh key of same entropy/length as message; #imp[reusing $K$, leaks] $C plus.o C' = M plus.o M'$.
  - Secrecy does #text(fill: red.darken(20%), weight: "bold")[not] imply integrity: Eve may modify/drop $C$.
]

#fbox("Information Quantities & Interaction Information")[
  #underline[*Information quantities*]
  $ "Mutual Info:" &quad& I(X;Y)&=H(X)-H(X|Y)\
    "Union Entropy:" &quad& H(X,Y)&=H(X|Y)+I(X;Y)+H(Y|X) $
  $ I(X;Y)=0 quad <=> quad X,Y " independent" $
  #hline()
  #underline[*Interaction information*]
  $ R(X;Y;Z)=I(X;Y)-I(X;Y|Z) $
  - #imp[Can be negative!]\ As in OTP: $C$ alone gives no info, but $C+K$ recovers $M$.
  #v(-0.3em)
  #align(center)[#image("Images/tripple_entropy_diagram.jpg", width: 60%)]
  #strong("Note:") When a variable is fixed, then we can say it carves away the circles, giving way only to conditional entropies.
]

#fbbox("One-Time Pad: Venn Diagram Analysis")[
  #grid(columns: (1fr, 1fr), gutter: 0.3em, align: top, [
    #underline[*Uniform One-Time Pad*]
    - Let $(M,K,C)$ be #imp[uniform bits] where:
      $ C := M plus.o K, quad M perp K $
    #hline()
    #strong("Deterministic Dependency:")\ #def[Any two variables determine the third], forcing #imp[outer-only regions to 0]#hline()
    #strong("Pairwise Independence:")\ Each pair alone looks independent:
    #text(size: 7.5pt)[$ I(M;K) = I(M;C) = I(K;C) = 0 $]
    #hline()
    #strong("Interaction Information:")\ The joint dependence only appears when considering all 3 variables together.
    #text(size: 7pt)[$ imp(
      underbrace(R(M;K;C), #place(center)[#text(size: 7.5pt)[Interaction (-1)]]) =
      underbrace(I(M;K), #place(center)[#text(size: 7.5pt)[0 (Indep.)]]) -
      underbrace(I(M;K|C), #place(center, dy: -0.3em)[#text(size: 7.5pt)[1 (Known $C$)]])
    ) $]
    #v(0.5em)
    #hline()
    #text(fill: blue.darken(20%))[*Interpretation:*] Ciphertext $C$ alone reveals #imp[nothing] about $M$, but $(C,K)$ reveals $M$ completely.
    #align(center)[#image("Images/uniform_OTP.jpg", width: 90%)]
  ], [
    #underline[*Perfect Secrecy (General Case)*]
    Consider $C := M plus.o K$ with $K perp M$ and $H(K) = N$\
    #strong("Note:") #imp[$M$ is not necessarily uniform; OTP can still be perfectly secret if $K$ is uniform and independent.]
    #hline()
    #def[Perfect secrecy] still requires #imp[$I(M;C) = 0$]\
    $=>$ Constraints place #imp[$H(M)$] in the bottom-left and #imp[$N$] in the bottom-right intersections respectively.
    #hline()
    #strong("Entropy Analysis:")
      #text(size: 8pt)[$ imp(
        underbrace(H(C), #place(center)[#text(size: 7.5pt)[Output unc.]]) <=
        overbrace(N, #place(center, dy: -0.4em,text(size: 7.5pt)[Key entropy limit]))  =>
        underbrace(H(M), #place(center)[#text(size: 7.5pt)[Message entropy]]) <=
        overbrace(a, #place(center, dy: -0.8em, dx: -0.3em,text(size: 7.5pt)[Overlap ($I(M;K|C)$)]))
      ) $]
    The ciphertext masks the message distribution using the uncertainty #imp[$N$] of the key.
    #hline()
    #text(fill: purple.darken(20%))[*Interpretation:*] Even for a #imp[non-uniform message], a uniform independent key makes the ciphertext useless to an eavesdropper as long as #imp[$N >= H(M)$]
    #align(center)[#image("Images/Perfectly_secret_OTP.jpg", width: 90%)]
  ])
]

#fbox("Shannon's Theorem & The Price of Perfect Secrecy")[
  #subdefbox("Shannon's Theorem")[
    For every perfectly secret cipher with #def[unique decodability]:
    $ imp(H(K) >= H(M)) $
    #text(size: 8pt)[_The key must be perfectly random, as long as the message, and never reused!_]
  ]
  #align(center)[#image("Images/Shannon's theorem generalization.jpg", width: 50%)]
  #underline[*Proof Idea:*]
  - #strong("Perfect secrecy:") $I(M;C) = 0 arrow.r #imp[$H(M|C) = H(M)$]$
    - Property : $I(M;C) >= 0 -> H(M) - H(M|C) >= 0$
  - #strong("Unique decodability:") $H(M|K,C) = 0 thick ("No uncertainty")$
  - From the diagram: $b >= a$ since $I(K;C) >= 0$
  - $H(K) >= b - a + c >= a - a + c = H(M) => #imp[$H(K) >= H(M)$]$

  #hline()
  #imp[Conclusion:] Perfect secrecy needs a huge key. #def[Can we do better?] Yes, by exploiting #imp[noisy channels].
]

#fbox("Noisy Channels & Wire-Tap Scenarios")[
  #underline[*BSC and Coping with Shannon:*]
  - #def[$"BSC"(epsilon)$]: each bit flips with probability $epsilon$ and is correct with probability $1-epsilon$.
  - If Eve receives a #imp[noisier] version than Bob, Alice/Bob may obtain a secrecy advantage.
  - Usually assume $0 <= epsilon <= 1/2$: $epsilon = 0$ means Eve sees perfectly, while $epsilon = 1/2$ means Eve sees pure noise.

  #hline()
  #underline[*Binary Wire-Tap*]
  #imp[Alice/Bob have perfect channels], Eve sees $"BSC"(epsilon)$.
  Alice sends random bits $X_1,...,X_(N-1)$ and chooses $X_N$ so:
  $ M = X_1 plus.o ... plus.o X_N $

  Eve sees noisy versions of all $X_i$. Her optimal guessing probability:
  $ P_"guess" =(1+(1-2epsilon)^N)/2 -> 1/2 $

  #text(size: 8.5pt)[
    #imp[Intuition:] the parity of many noisy bits becomes almost random for Eve. If $epsilon$ is close to $1/2$, her advantage disappears faster.
  ]

  #hline()
  #underline[*Wyner Wire-Tap*]
  #v(0.8em)
  #diagMath(text(size: 9pt)[$ #place(center, dx: 0.5em, dy: -1.5em)[Alice] X stretch(->) #place(center, dx: 2em, dy: -2em)[$P_(Y|X)$] diagBox("DMC") stretch(->) #place(center, dx: 0.5em, dy: -1.5em)[Bob] Y stretch(->) #place(center, dx: 2em, dy: -2em)[$P_(Z|Y)$] #place(center, dx: 2em, dy: 1em)[Noisier Leakage] diagBox("DMC") stretch(->) #place(center, dx: 0.5em, dy: -1.5em)[Eve] Z $])
  #v(0.8em)

  #underline[*Key Idea:*] Bob receives a #imp[better observation $Y$] than Eve's degraded observation $Z$.
  Alice can transmit at positive #def[secrecy rate] when Bob has an informational advantage:

  $ #imp($C_s = max_(P(X)) [I(X;Y) - I(X;Z)]$) $

  - #strong("Intuition:") Alice encodes message $M$ into $X^n$ such that:
    - $H(M | Y^n) approx 0$ (Bob decodes reliably)
    - $H(M | Z^n) approx H(M)$ (Eve learns nothing)
  - #strong("Wire-tap coding:") uses a #imp[stochastic encoder]: dummy randomness hides the message from Eve.

]

#fbbox("Broadcast Channels")[
  #v(0.8em)
  #diagMath(text(size: 9pt)[$
    #block[$
      #place(center, dx: 0.5em, dy: -1.5em)[Alice] X&
      stretch(->)
      #place(center, dx: 2em, dy: -2em)[$epsilon$] diagBox("DMC")
      stretch(->)
      #place(center, dx: 0.5em, dy: -1.5em)[Bob] Y\
      arrow.r.curve&
      #place(center, dx: 2em, dy: 1.3em)[$delta$] diagBox("DMC")
      stretch(->)
      #place(center, dx: 0.5em, dy: -1.5em)[Eve] Z
    $]
  $])
  #v(0.8em)

  - #strong("Scenario (Csiszár-Körner 1978):") Alice sends the same input $X$ into a #imp[broadcast channel]. Bob receives $Y$, Eve receives $Z$.
  - #strong("Important difference with Wyner:") here Bob and Eve are two outputs of the same transmission; Eve is not necessarily obtained by degrading Bob's output.
  - #strong("General rule:") secret communication #imp[requires Bob's observation to be better than Eve's] in an information sense.

  #subdefbox("Broadcast BSC Secrecy Rate")[
    Suppose Bob has #def[$"BSC"(epsilon)$] and Eve has #def[$"BSC"(delta)$], with #imp[$0 <= epsilon < delta <= 1/2$] (Eve is noisier).

    $ underbrace(C_B = 1 - cal(H)(epsilon), #place(center)[#text(size: 7.5pt)[Bob's Capacity]]) quad "and" quad underbrace(C_E = 1 - cal(H)(delta), #place(center)[#text(size: 7.5pt)[Eve's Capacity]]) $
    #v(0.1em)

    Therefore the #def[secrecy rate] is the advantage of Bob over Eve:
    $ imp(C_s = overbrace(C_B - C_E, #text(size: 7.5pt)[Advantage]) = cal(H)(delta) - cal(H)(epsilon)) $

    If $delta <= epsilon$, Eve is at least as good as Bob, so this simple secrecy rate becomes $#imp[$C_s = 0$]$

    #text(size: 8pt)[_where $cal(H)(x)$ is the binary entropy function._]
  ]

  - #text(fill: red.darken(20%), weight: "bold")[Annoying Practical Issue:] #imp[How do we know that Eve's channel is actually worse?] Maybe Eve has better antennas, position, or hardware.

  #hline()
  #underline[*Power of Interaction [Maurer 1993]:*] Suppose an #imp[authentic but monitored public channel] exists (e.g., phone).
  #v(0.8em)
  #move(dx: 2em,diagMath(text(size: 9pt)[$
    #block[$
      #place(center, dx: 0.5em, dy: -1.5em)[Alice] X&
      stretch(->)
      #place(center, dx: 2em, dy: -2em)[$epsilon$] diagBox("DMC")
      stretch(->)
      #place(center, dx: 0.5em, dy: -1.5em)[Bob] Y\
      arrow.r.curve&
      #place(center, dx: 2em, dy: 1.3em)[$delta$] diagBox("DMC")
      stretch(->)
      #place(center, dx: 0.5em, dy: -1.5em)[Eve] Z
    $] quad --> quad
    #move(dx:-4em,block[$
      #move(dy: -0.8em)[$text(#color.green.darken(40%),(C plus.o Y) plus.o X)$]& #move(dx: 0.8em, dy: -0.9em)[$arrow.l.long #move(dy: 0.3em)[$tack.b$] arrow.l.long $] quad #move(dy: -0.8em)[$(C plus.o Y)$]\
      #place(center, dx: 0.5em, dy: -1.5em)[#text(color.green.darken(40%),"Alice")] X&
      stretch(->)
      #place(center, dx: 2em, dy: -2em)[$epsilon$] diagBox("DMC")
      stretch(->)
      #place(center, dx: 0.5em, dy: -1.5em)[Bob] Y\
      #move(dx: 0.4em, dy: -0.1em)[$tack.r.long$]&
      #move(dy: -0.3em)[$
        stretch(->)^(C plus.o Y)
        text(#color.red.darken(40%),(C plus.o Y) plus.o Z)
      $]\
      arrow.r.curve&
      #place(center, dx: 2em, dy: 1.3em)[$delta$] diagBox("DMC")
      stretch(->)
      #place(center, dx: 0.5em, dy: -1.5em)[#text(color.red.darken(40%),"Eve")] text(#color.red.darken(40%),Z)
    $])
  $]))
  #v(0.8em)

  #text(fill: red.darken(20%), weight: "bold")[Allows secure communication! (Not perfectly secret)]

  #hline()
  #underline[*Equivalent to Inverted Wyner Scenario:*]
  - Bob effectively sends $C$ through a #imp[noisy channel ($epsilon$)] to Alice while Eve sees a #def[degraded version] with #imp[accumulated noise].
  - #imp[Secret transmission possible if] $#def[$delta in.not {0, 1}$]$ and $#def[$epsilon != 1/2$]$!

  #v(0.8em)
  #diagMath(text(size: 9pt)[$ #block[$
    #place(center, dx: 3em, dy: -1.5em)[Alice] (C plus.o Y) plus.o X&
    arrow.l.filled
    #place(center, dx: 2em, dy: -2em)[$epsilon$] diagBox("DMC")
    arrow.l.filled
    #place(center, dx: 0.5em, dy: -1.5em)[Bob] Y\
    arrow.r.curve&
    #place(center, dx: 2em, dy: 1.3em)[$delta$] diagBox("DMC")
    stretch(->)
    #place(center, dx: 3em, dy: -1.5em)[Eve] (C plus.o Y) plus.o Z
  $] $])
  #v(0.8em)
  (Accumulation of channel effects)

  #hline()
  #underline[*Interactive Key Agreement from Common Randomness:*]
  - Alice, Bob, Eve #imp[listen to a common random source] $P_(X Y Z)$ (e.g., satellite).
  - Using only an #def[authentic, monitored public channel] (no noise needed), Alice and Bob can #imp[agree on a secret key].

]

#fbox("Message Authentication Codes (MACs)")[
  #strong("Statistical guarantees for an unbounded opponent")\
  OTP gives #imp[perfect secrecy] but not #imp[integrity]: flipping a ciphertext bit flips the corresponding plaintext bit.

  If Bob reacts to invalid ciphertexts, e.g. by asking for retransmission, this can #text(fill: orange.darken(20%), weight: "bold")[leak information]. We need #def[message authentication].

  #subdefbox("MAC Setting")[
    Alice and Bob share a secret key $K$. Alice sends:
    $ M || "MAC"_K (M) $
    Bob accepts a received pair $(m,d)$ iff:
    $ d = "MAC"_K (m) $

    - #strong("Goal:") Eve should not be able to #imp[forge] a valid pair from scratch, nor #imp[modify] an observed valid pair consistently.
    - #strong("One-time assumption:") Eve observes at most #imp[one] valid pair $(m, "MAC"_K (m))$.
    - #strong("Good intuition:") For Eve, the tag should look #text(fill: purple.darken(20%), weight: "bold")[random/unpredictable], even after one observation.
  ]
]

#fbbox("Spaces and Payoffs")[
  #underline[*Spaces and Payoffs:*]
  Let $cal(M)$ be the message space, $cal(K)$ the key space, and $cal(D)$ the digest/tag space. Probabilities are over uniform $K$.

  - #def[From scratch:] Eve chooses $(m,d)$ and hopes it is valid:
    $ underbrace("payoff"(m,d), #place(center)[#text(size: 7.5pt, fill: blue.darken(20%))[success prob.]])
      = Pr[d = "MAC"_K (m)]
      = overbrace((|{K in cal(K) : d = "MAC"_K (m)}|) / (|cal(K)|), #place(center, dy: -0.6em)[#text(size: 7.5pt, fill: orange.darken(30%))[keys compatible with $(m,d)$]]) $
  - #def[After one observation:] Eve saw $(m,d)$ valid, tries  $m' != m$:
    $ underbrace("payoff"(m',d',m,d), #place(center, dy: 0.15em)[#text(size: 7.5pt, fill: blue.darken(20%))[conditional success]])
      = Pr[d' = "MAC"_K (m') | d = "MAC"_K (m)] $

    $ = overbrace(
      (|{K in cal(K) : d' = "MAC"_K (m') " and " d = "MAC"_K (m)}|)
        / (|{K in cal(K) : d = "MAC"_K (m)}|),
        #place(center, dy: -0.6em)[#text(size: 7.5pt, fill: orange.darken(30%))[intersection of compatible keys]]
      ) $

  #underline[*Forgery probabilities:*]
  - #def[No observation ($P_(d 0)$):] best direct guess:
    $ P_(d 0) = max_(m in cal(M), d in cal(D)) "payoff"(m,d) $
  - #def[One observation ($P_(d 1)$):] Eve may choose $m$, observes its tag $d$, then chooses the best new forgery:
    $ P_(d 1)
      = max_(m in cal(M)) {
        sum_(d in cal(D))
        underbrace("payoff"(m,d), #place(center)[#text(size: 7.5pt, fill: blue.darken(20%))[prob. observe $d$]])
        dot
        max_(m' != m, d' in cal(D)) {
          underbrace("payoff"(m',d',m,d), #place(center)[#text(size: 7.5pt, fill: red.darken(20%))[best forgery]])
        }
      } $
  #hline()
  #text(fill: green.darken(25%), weight: "bold")[Good MAC:] make $P_(d 0)$ and $P_(d 1)$ as small as possible. Ideal one-time target:
  $ P_(d 0) = P_(d 1) = 1 / (|cal(D)|) $
  so Eve can do no better than guessing the tag (uniform distrib).
]

#tbox([Example: MAC over $ZZ_3$])[
  Let $cal(M)=cal(D)=ZZ_3$, $cal(K)=ZZ_3 times ZZ_3$, with:
  $ "MAC"_(a,b)(m)=a dot m+b mod 3 $

  #text(size: 7.3pt)[
    #table(
      columns: 4,
      align: center,
      stroke: 0.3pt + luma(70%),
      [$K=(a,b)$], [$m=0$], [$m=1$], [$m=2$],
      [$(0,0)$], [$0$], [$0$], [$0$],
      [$(0,1)$], [$1$], [$1$], [$1$],
      [$(0,2)$], [$2$], [$2$], [$2$],
      [$(1,0)$], [$0$], [$1$], [$2$],
      [$(1,1)$], [$1$], [$2$], [$0$],
      [$(1,2)$], [$2$], [$0$], [$1$],
      [$(2,0)$], [$0$], [$2$], [$1$],
      [$(2,1)$], [$1$], [$0$], [$2$],
      [$(2,2)$], [$2$], [$1$], [$0$],
    )
  ]

  #hline()
  #strong([1. Estimation of $P_(d 0)$]) \
  For fixed $m in cal(M)$ and $d in cal(D)$:
  $ underbrace("payoff"(m,d), #place(center)[#text(size: 7.5pt, fill: blue.darken(20%))[success prob.]])
    = overbrace(||{K : d = "MAC"_K (m)}||, #place(center, dy: -0.35em)[#text(size: 7.5pt, fill: green.darken(20%))[repetitions in one column]])
    / underbrace(||cal(K)||, #place(center)[#text(size: 7.5pt, fill: orange.darken(20%))[all keys]])
    = 3/9 = 1/3 $

  Hence:
  $ #text(fill: green.darken(20%), weight: "bold")[$P_(d 0) = 1/3$] $

  #hline()
  #strong([2. Estimation of $P_(d 1)$]) \
  Fix one valid observed pair $(m,d)$. Then:
  - there are #text(fill: green.darken(20%), weight: "bold")[3 possible keys] consistent with $(m,d)$;
  - for any new $m' != m$, these 3 keys produce #imp[3 different digests].

  So:
  $ underbrace("payoff"(m',d',m,d), #place(center, dy: 0.15em)[#text(size: 7.5pt, fill: blue.darken(20%))[conditional success]])
    = (||#text(size: 7.5pt, fill: blue.darken(20%))[multiple matches per row]||)/underbrace(||{K : d = "MAC"_K (m)}||, #place(center, dy: -0.35em)[#text(size: 7.5pt, fill: green.darken(20%))[repetitions in one column]]) = overbrace(1, #place(center, dy: -0.35em)[#text(size: 7.5pt, fill: green.darken(20%))[one matching key]])
    / underbrace(3, #place(center)[#text(size: 7.5pt, fill: orange.darken(20%))[3 compatible keys]])
    = 1/3 $

  Therefore:
  $ P_(d 1)
    = sum_(d in cal(D)) underbrace("payoff"(m,d), #place(center, dy: 0.15em)[#text(size: 7.5pt, fill: purple.darken(20%))[prob. of observed tag]])
    dot max_(m' != m, d') underbrace("payoff"(m',d',m,d), #place(center, dy: 0.15em)[#text(size: 7.5pt, fill: red.darken(20%))[best forgery]])
    = 3 dot 1/3 dot 1/3 = 1/3 $

  #hline()
  #underline[*Illustration:*] \
  $ underbrace(m=1 "," d=0, #place(center)[#text(size: 7.5pt, fill: purple)[observed valid pair]]) quad --> quad underbrace(K in {(0,0),(1,2),(2,1)}, #place(center)[#text(size: 7.5pt, fill: purple)[possible keys]]) $

  For a new message, e.g. $m'=0$, these keys give:
  $ underbrace(d' in {0,2,1}, #place(center)[#text(size: 7.5pt, fill: purple)[3 different possible digests]]) $
  #v(0.3em)
  so each digest has probability:
  $#text(fill: blue.darken(20%))[1/3] $\
  #text(size: 8pt, fill: orange.darken(20%))[
    #imp[Intuition:] one observed equation in the two unknowns $(a,b)$ leaves one degree of freedom.
  ]

  #hline()
  #text(fill: green.darken(20%), weight: "bold")[Good:]
  $P_(d 0)=P_(d 1)=1/abs(cal(D))=1/3 $
  so this MAC is #imp[optimal].
]

#fbbox("Strongly Universal Hashing for MACs")[
  #subdefbox("Strongly Universal Hash Families [Carter-Wegman, 1979]")[
    A family $cal(H):={H_K}_(K in cal(K))$, with $H_K: cal(M) arrow.r cal(D)$, is #def[strongly universal] if, for every $m != m'$ and every $d,d' in cal(D)$:
    $ Pr_(K in cal(K))[
        H_K(m)=d " and " H_K(m')=d'
      ] = 1 / (||cal(D)||^2) $

    #text(fill: purple.darken(20%), weight: "bold")[Meaning:] two different messages behave like #imp[independent uniform tags].
  ]

  #underline[*Theorem:*] \
  If $cal(H)$ is strongly universal and $"MAC"_K (m) := H_K(m)$, then:
  $ #text(fill: green.darken(25%), weight: "bold")[
      $P_(d 0) = P_(d 1) = 1 / (||cal(D)||)$
    ] $

  #hline()
  #underline[*Proof:*]

  #strong([1. No observation: $P_(d 0)=1/(||cal(D)||)$]) \
  Fix $m,d$, and choose any $m' != m$.
  $ underbrace("payoff"(m,d), #place(center, dy: 0.2em)[#text(size: 7.5pt, fill: blue.darken(20%))[valid tag prob.]])
    = Pr[H_K(m)=d] \
    = sum_(d' in cal(D))
       overbrace(
         Pr[H_K(m)=d " and " H_K(m')=d'],
         #place(center, dy: -0.7em)[#text(size: 7.5pt, fill: orange.darken(20%))[split over all possible $d'$]]
       )
    #v(4em)
    = sum_(d' in cal(D)) underbrace(1 / (||cal(D)||^2), #place(center, dy: -0.2em)[#text(size: 7.5pt, fill: green.darken(25%))[strongly universal]]) = 1 / (||cal(D)||) $
  Since this holds for every $m,d$:
  $ #text(fill: green.darken(25%), weight: "bold")[$P_(d 0)=1/(||cal(D)||)$] $

  #hline()
  #strong([2. One observation: $P_(d 1)=1/(||cal(D)||)$]) \
  Fix $m != m'$ and $d,d' in cal(D)$.
  $ underbrace("payoff"(m',d',m,d), #place(center, dy: 0.2em)[#text(size: 7.5pt, fill: blue.darken(20%))[conditional forgery prob.]])
    = Pr[H_K(m')=d' | H_K(m)=d] \
    #v(6em)
    = overbrace(
         Pr[H_K(m')=d' " and " H_K(m)=d],
         #place(center, dy: -0.45em)[#text(size: 7.5pt, fill: orange.darken(20%))[joint prob.]]
       )
       /
       underbrace(
         Pr[H_K(m)=d],
         #place(center, dy: 0.2em)[#text(size: 7.5pt, fill: purple.darken(20%))[marginal prob.]]
       )
    = (1 / (||cal(D)||)^2) / (1 / (||cal(D)||))
    = 1 / (||cal(D)||) $

  Since this holds for every valid observation and every attempted new forgery:
  $ #text(fill: green.darken(25%), weight: "bold")[$P_(d 1)=1/(||cal(D)||)$] $

  #hline()
  #underline[*Examples:*]
  - #imp[Affine family:] for $cal(M)=cal(D)=ZZ_p$,
    $ H_(a,b)(m) = a dot m + b mod p $
    with key $(a,b) in ZZ_p times ZZ_p$ is strongly universal.

  - #imp[Large domains:] for binary non-zero vectors $M=(M_1,...,M_l) in {0,1}^l$ with $M != 0^l$,
    $ H_K(M) := sum_(i=1)^l M_i dot K_i mod p $
    with $K in (ZZ_p)^l$ and $cal(D)=ZZ_p$.

    #text(size: 8pt, fill: orange.darken(20%))[
      This restriction matters: over all of $(ZZ_p)^l$, two messages could be scalar multiples, which breaks strong universality. For non-zero binary vectors, distinct messages are not scalar multiples in this sense.
    ]

  #hline()
  #text(fill: green.darken(25%), weight: "bold")[Optimal MAC:] Eve can do no better than guessing one tag among $||cal(D)||$ possibilities.
]
#block(fill: red, "TODO - ADD EXPLANATION on Pd2 and how you can design a perfect MAC", inset: 0.4em)


#fbox("Secure Function Evaluation (SFE)")[
  #strong("Goal:") Parties $P_1,...,P_n$ with private inputs $x_i$ learn only $f(x_1,...,x_n)$.

  #underline[*Examples:*]
  - #def[Millionaire:] $f_"boolean" (x_1,x_2):=x_1 < x_2$.
  - #def[Election:] $f_"boolean" (x_1,...,x_n):=sum_(i=1)^n x_i >= n/2$.
  - #def[Vickrey auction:] winner is $"argmax"(x_i)$ and pays second-highest bid.

  #subdefbox("Feasibility / Adversaries")[
    - #def[Passive:] parties follow protocol but are curious; possible if fewer than $n/2$ are corrupted.
    - #def[Active:] parties may deviate; possible if fewer than $n/3$ corrupted.
    - Communication is assumed secret and authenticated P2P.
  ]
]

#tbox("Example: Privacy by Randomized Response")[
  Estimate a sensitive yes/no statistic without revealing individual answers.

  #underline[*Protocol:*]
  Secretly roll a die. If result is $6$, answer truthfully; otherwise answer the opposite/randomized forced answer as in Warner's strategy.

  Let $n$ be participants, $k$ honest yes answers, and $x$ observed yes answers. Slide formula:
  $ x approx 5/6 k + 1/6 (n-k) = n/6 + 2k/3 $

  Hence:
  $ k approx (6x-n)/4, quad k/n approx (6x-n)/(4n) $

  #imp[Interpretation:] the global statistic is estimated, while individuals keep plausible deniability.
]

#fbbox("Secret Sharing & Shamir Scheme (Blakley79, Shamir79)")[
  #def[Goal:] #imp[Share secret $a$ among $n$ parties] so that #imp[at least $t$ are needed] to reconstruct.

  - #strong([Simple case $t=n$:])
    choose $a_1,...,a_(n-1)$ randomly and set
    $ a_n = a - sum_(i=1)^(n-1) a_i mod p $
    Any $n-1$ #def[shares] reveal nothing.

  #subdefbox([Shamir's Secret Sharing : $t$-out-of-$n$])[
    Work over $FF_p$ with $p>n$. Choose random polynomial of degree $t-1$:
    $ f(x)=a+e_1 x+...+e_(t-1)x^(t-1) $

    - #def[Shares:] $a_i=f(i) mod p$.
    - #def[Reconstruction:] any $t$ points determine $f$, hence $a=f(0)$.
    - #def[Privacy:] any $t-1$ shares give no information about $a$.
  ]
  #hline()
  #underline[*Lagrange interpolation:*]\
  How to recover the secret $a = f(0)$ from $t$ shares $\{(i,f(i)) : i in C\}$ with $|C| = t$?

  - For each $i in C$, define the #def[lagrange basis polynomial] $delta_i (x)$:
    $ underbrace(delta_i (x), #place(center)[#text(fill: blue.darken(20%))[basis polynomial]])
      := product_(j in C, j != i) (x-j)/(i-j) $

    It acts as a #imp[selector] on the known points:
    $ delta_i (j) = cases(
      1 &"if " j = i,
      0 &"if " j != i
    ) $
  - Any polynomial $f$ with $deg(f) <= t-1$ can be reconstructed from its $t$ known values:
    $ f(x)
      =
      sum_(i in C)
      overbrace(f(i), #place(center, dy: -0.6em)[#text(fill: green.darken(20%))[known share]])
      underbrace(delta_i (x), #place(center, dy: -0.2em)[#text(fill: blue.darken(20%))[selector]])
    $
    This works because two polynomials of degree $<= t-1$ that agree on $t$ points are identical.

  - Evaluate at $x=0$ to recover the #def[secret]:
    $ underbrace(f(0), #place(center)[#imp[secret $a$]])
      =
      sum_(i in C)
      f(i)
      underbrace(delta_i (0), #place(center, dx: 3em, dy: -0.2em)[#text(fill: orange.darken(20%))[$r_i$: reconstruction factor]])
    $
    We write:
    $ r_i := delta_i (0) $
  #imp[Important:] the reconstruction factors $r_i$ depend only on the chosen index set $C$, not on the polynomial $f$.

  #hline()
  #imp[Meaning:] any $t$ shares uniquely determine the degree-$(t-1)$ polynomial and reveal $f(0)=a$. Fewer than $t$ shares leave degrees of freedom, so the secret remains hidden.

  #let f(x) = 0.35 * (x + 2.0) * (x + 0.15) * (x - 2.15)
  #let p1 = -1.25
  #let p2 = 1.10
  #let p3 = 2.55

  #grid(columns: (2fr, 1fr), align: horizon,[
    #align(center)[
      #simple-plot.plot(
        width: 3.5,
        height: 2.3,
        xmin: -2.4,
        xmax: 3.1,
        ymin: -1.8,
        ymax: 2.0,
        show-grid: true,
        axis-x-pos: "center",
        axis-y-pos: "center",
        (fn: x => f(x), stroke: gray.lighten(10%) + 1.2pt),
        simple-plot.scatter(((p1, f(p1)), (p2, f(p2)), (p3, f(p3))), mark: "*", mark-size: 0.12, mark-fill: green.darken(10%), mark-stroke: green.darken(30%)),
        simple-plot.scatter(((0.0, f(0.0)),), mark: "*", mark-size: 0.11, mark-fill: red.darken(10%), mark-stroke: red.darken(30%)),
        simple-plot.scatter(((p1, 0.0), (p2, 0.0), (p3, 0.0)), mark: "*", mark-size: 0.08, mark-fill: orange.darken(10%), mark-stroke: orange.darken(30%))
      )
    ]
  ],[
    #text(size: 7pt)[
      #text(fill: green.darken(20%), weight: "bold")[Green:] shares $P_i=(i,f(i))$.\
      #text(fill: red.darken(20%), weight: "bold")[Red:] secret point $(0,a)$.\
      #text(fill: orange.darken(20%), weight: "bold")[Orange:] shares $x$-axis proj.
    ]
  ])
]

#fbbox("Computing on Shares: SFE Protocol")[
  #subdefbox("Protocol Skeleton")[
    1. #def[Split shares:] Each party shares its input using Shamir's $t$-out-of-$n$ scheme, with $t < n/2$. \
    2. #def[Evaluate function:] Express $f$ as a circuit of $+$ and $dot$, and compute new shares gate by gate. \
    3. #def[Reconstruct:] Parties reconstruct only the final output from the shares.
  ]

  #underline[*Adding Shares:*] \
  Suppose $P_i$ has shares $a_i$ and $b_i$ of $a$ and $b$ through polynomials $a(x)$ and $b(x)$.
  $ imp(underbrace(c_i, #place(center)[#text(size: 7.5pt)[New share]]) = a_i + b_i) $
  - #strong("Why it works:")
  $ underbrace((a+b)(x), #place(center, dy: -0.4em)[#text(size: 7.5pt)[Same degree as $a$ and $b$]]) &= a(x) + b(x)\
   (a+b)(0) &= a+b \
   (a+b)(i) &= a(i) + b(i) $
  #imp[Note:] Secure addition is #def[local / non-interactive] (no inter-participant communication needed).

  #hline()
  #underline[*Multiplying Shares (Attempt):*] \
  $P_i$ computes local products $d_i=a_i dot b_i$ as a share of $a dot b$.
  - #strong("Why it fails:")
  $ (a dot b)(0) &= a dot b \
    (a dot b)(i) &= a(i) dot b(i) $
  But $d(x) = (a dot b)(x)$ has a degree up to #imp[$2t-2$]! \
  If we do this, the polynomial degree increases too much. We can only do #imp[one multiplication] without losing information (since we might have $4t > n$, #imp[we won't have enough participants to reconstruct]).

  #hline()
  #underline[*Secure Degree Reduction:*] \
  To fix this, we need to #imp[reduce the degree] back to $<= t-1$.
  - Each $P_i$ has a share $d_i$ of $d$ through a polynomial of degree $< n$.
  - Each $P_i$ can compute public reconstruction factors (#imp[Lagrange scalars]) $r_i$ such that $d = sum_(i=1)^n r_i d_i$.
  - Each $P_i$ #imp[shares $d_i$] as $d_(i 1), dots, d_(i n)$ using a fresh polynomial $d_i (x)$ of degree $<= t-1$.
  - Each $P_j$ computes:
  #v(-1em)
  $ imp(underbrace(c_j, #place(center, dx: -1em, dy: -0.2em)[#text(size: 7.5pt)[Share for $a dot b$]]) = sum_(i=1)^n overbrace(r_i, #place(center, dx: 4em, dy: -0.3em)[#text(size: 7.5pt)[Public Lagrange scalars]]) underbrace(d_(i j), #place(center, dx: 2em, dy: -0.2em)[#text(size: 7.5pt)[Shared around]])) $
  #v(0.4em)
  - #strong("Why it works:") $c_j$ is a share of $sum_(i=1)^n r_i d_i$, through a polynomial of degree $<= t-1$.
  #imp[Cost:] Multiplication requires #def[communication] (sharing $d_i$).
]

#tbox("Example of Share Multiplication")[
  #strong("Suppose:")
  - $a$ and $b$ shared between $P_1, P_2$ and $P_3$ with poly. of deg. 1
  - $P_i$ sets $d_i = a_i b_i$, which are shares of $a b$ with poly. of deg. 2

  #strong([Each $P_i$:])
  - shares $d_i$ as $d_(i 1), d_(i 2), d_(i 3)$ with fresh poly. of deg. 1 #text(fill: red.darken(20%), weight: "bold")[(They get shared around!)]
  - computes shares of $a b$ as $c_i$
  as follows:
  #v(-1em)
  #align(center)[
    #table(
      columns: (auto, 1fr, 1fr, 1fr),
      align: center,
      stroke: none,
      [], [$P_1$], [$P_2$], [$P_3$],
      [$P_1 : d_1 = a_1 b_1 "shared as:"$], [$d_(1 1)$], [$d_(1 2)$], [$d_(1 3)$],
      [$P_2 : d_2 = a_2 b_2 "shared as:"$], [$d_(2 1)$], [$d_(2 2)$], [$d_(2 3)$],
      [$P_3 : d_3 = a_3 b_3 "shared as:"$], [$d_(3 1)$], [$d_(3 2)$], [$d_(3 3)$],
      [], [$arrow.b$], [$arrow.b$], [$arrow.b$],
      [$a b = sum r_i d_i$], [$c_1 = sum r_i d_(i 1)$], [$c_2 = sum r_i d_(i 2)$], [$c_3 = sum r_i d_(i 3)$]
    )
  ]
  Now, $c_1, c_2, c_3$ are shares of $a b$ through a poly. of deg. 1
]

#fbbox("SFE Remarks & Conclusions")[
  #underline[*Why SFE works:*]
  - #def[Secret sharing] is perfectly secret.
  - Any $f$ can be expressed as a Boolean/arithmetic circuit.
  - #def[Secure addition] is non-interactive.
  - #def[Secure multiplication] only reveals new shares.
  - Output reconstruction discloses the output, and #imp[nothing else].

  #hline()
  #underline[*Computational vs Information-Theoretic (IT) SFE:*]
  - #strong("Adversary bounds:")
    - Computational crypto allows $< n$ cheating parties (passive) and $< n/2$ corrupted parties (active).
    - IT setting bounds ($n/2$ passive, $n/3$ active) are #imp[strict] for fairness (preventing a cheating party from computing the output while others get nothing).
  - #strong("Memory/Bandwidth:")
    - #def[IT setting] allows choosing $p$ as any upper bound on the manipulated numbers (can be very efficient for small integers).
    - #def[Computational crypto] requires $p$ to be a function of the security parameter.

  #hline()
  #underline[*Chapter Conclusions:*]
  - We can have unconditional #def[secrecy] (e.g., OTP).
  - We can have unconditional #def[authenticity] (e.g., strongly universal hashing).
  - We can have unconditional #def[SFE].
  - #text(fill: fuchsia, weight: "bold")[Techniques:]
    - Often require #imp[big communication overhead] when noise must be exploited.
    - Can be #imp[very efficient] when small integers are involved.
    - Useful in contexts needing #imp[very high security] and small integer computation.
]

#exerbox("Exercise Session — OTP, Secret Sharing, MAC")[
  #subdefbox("Core Reminders")[
    - #def[Perfect secrecy:] ciphertext gives no statistical information about the message:
      $ forall m,m',c:\ P(C=c | M=m) = P(C=c | M=m') quad <=> quad I(M;C)=0 $
    - #def[OTP over a finite group:] if $K$ is uniform and independent, then: $C = M + K => I(M;C)=0$
    - #def[Shannon bound:] for perfect secrecy with unique decoding: $H(K) >= H(M)$
    - #def[MAC payoff:] probability that an adversary's forged pair is accepted: $ "payoff"(m,d) = P[d = "MAC"_K (m)] $
  ]

  #hline()
  #underline[*Exercise 1 — June 2008: One-Time Pad Key Space*] \
  Alice sends $"yes"=11111$ or $"no"=00000$, encrypted as $C = M plus.o K$.
  #imp[Perfect secrecy:] $P(C=c | M=11111) = P(C=c | M=00000)$.

  #underline[*1) $K$ uniform in ${0,1}^5$*]
  - $2^5=32$ keys, exactly one key gives $c=m plus.o k$, so $P(C=c|M=m)=1/32$. Hence $I(M;C)=0$.
  - #text(fill: green.darken(20%), weight: "bold")[Perfectly secure] but $H(K)=5 > H(M)=1$ bit.

  #underline[*2) $K$ uniform in ${01010, 10101}$*]
  #align(center)[
    #table(
      columns: 3,
      align: center,
      stroke: 0.3pt + luma(70%),
      [$K \\ "pt"$], [$11111$], [$00000$],
      [$01010$], [#text(fill: purple)[$10101$]], [#text(fill: orange.darken(20%))[$01010$]],
      [$10101$], [#text(fill: orange.darken(20%))[$01010$]], [#text(fill: purple)[$10101$]],
    )
  ]
  Both messages produce the same ciphertext set ${01010,10101}$, so:
  $ P(C=c|11111) = P(C=c|00000) = 1/2 $
  $ I(M;C)=0, quad H(K)=1=H(M) $
  #text(fill: green.darken(20%), weight: "bold")[Best: perfect secrecy, minimal key entropy. This is the ideal one to choose.]

  #underline[*3) $K$ uniform in ${11010, 01011}$*]
  #align(center)[
    #table(
      columns: 3,
      align: center,
      stroke: 0.3pt + luma(70%),
      [$K \\ "pt"$], [$11111$], [$00000$],
      [$11010$], [#text(fill: red.darken(20%))[$00101$]], [#text(fill: purple.darken(20%))[$11010$]],
      [$01011$], [#text(fill: orange.darken(20%))[$10100$]], [#text(fill: blue.darken(20%))[$01011$]],
    )
  ]
  Disjoint ciphertext sets: ${00101,10100} inter {11010,01011} = emptyset$, so $H(M|C)=0$. Observer knows all info, no residual info is left.
  #text(fill: red.darken(20%), weight: "bold")[Not secure. This is the worst one to choose.]

  #hline()
  #underline[*Exercise 2 — June 2009: Secret Sharing in $ZZ_16$*] \
  Secret $a in ZZ_16$. Choose $a_1$ uniform, set $a_2 = a - a_1 mod 16$.
  #underline[*1) Reconstruction:*] $a = a_1 + a_2 mod 16$.
  #underline[*2) Privacy:*] $P(a_1=s|a=a_0)=1/16$, so $I(a;a_1)=0$ and $I(a;a_2)=0$.
  $ underbrace(I(a;a_1) = H(a) - H(a|a_1) = 0, #place(center, dy: -0.3em)[#text(size: 7.5pt, fill: blue.darken(20%))[$H(a)$]]) $
  #text(fill: fuchsia.darken(20%), weight: "bold")[Interpretation:] additive OTP: $a_2 = a - a_1$, with $a_1$ as key. THIS IS WHY THE OTP PROOF IS CRITICAL.

  #hline()
  #underline[*Exercise 3 — September 2008: Linear MAC*] \
  $ cal(M) = {0,1}^l - {0^l}, quad cal(K) = (ZZ_p)^l, quad cal(D)=ZZ_p $,
  $"MAC"_K (m) = sum_(i=1)^l m_i k_i mod p$.

  #subdefbox("Linear-Algebra Reminder")[
    Over $ZZ_p$: one non-trivial linear equation in $l$ unknowns leaves $p^(l-1)$ solutions; two independent equations leave $p^(l-2)$.
  ]

  #underline[*1) $P_(d 0)$ (no observation - forgery from nothing):*] For $m != 0$, $d = sum m_i k_i$ is one constraint:
  $ imp(
      overbrace(||{K in cal(K) : d = "MAC"_K (m)}||, #place(center, dy: -0.4em)[#text(size: 7.5pt, fill: orange.darken(20%))[$p^(l-1)$]]) /
      underbrace(||cal(K)||, #place(center, dy: -0.2em)[#text(size: 7.5pt, fill: blue.darken(20%))[$p^l$]])
      = 1/p
    ) $
  $ P_(d 0) = max_(m) (max_(d) "payoff"(m,d)) = 1/p $

  #underline[*2) $P_(d 1)$ (one observation):*] Observed $(m,d)$ and forgery $(m',d')$ with $m'!=m$ give two independent constraints. Conditional success:
  $ imp(
      overbrace(||{K in cal(K) : d' = "MAC"_K (m') " and " d = "MAC"_K (m)}||, #place(center, dy: -0.4em)[#text(size: 7.5pt, fill: orange.darken(20%))[$p^(l-2)$]]) /
      underbrace(||{K in cal(K) : d = "MAC"_K (m)}||, #place(center, dy: -0.2em)[#text(size: 7.5pt, fill: blue.darken(20%))[$p^(l-1)$]])
      = 1/p
    ) $
  #text(fill: green.darken(20%), weight: "bold")[Good:] Eve gains no advantage over guessing.

  #underline[*3) $P_(d 2)$ (two chosen observations):*] Linearity: $"MAC"_K (alpha m + beta m') = alpha "MAC"_K (m) + beta "MAC"_K (m')$. Choose $m^(1)=(1,0,...), m^(2)=(0,1,...)$, then forge $m^*=(1,1,0,...)$ with $d^*=d^(1)+d^(2)$. #text(fill: red.darken(20%), weight: "bold")[Broken:] $P_(d 2)=1$.

  #hline()
  #underline[*Exercise 4 — September 2009: Shamir-like Encryption*] \
  $p>2$ prime, $m,k in ZZ_p$. Key $e_1$ uniform; $f(x)=m+e_1 x mod p$; ciphertext $c=f(2)=m+2e_1 mod p$.
  Decryption: $m=c-2e_1 mod p$.

  #underline[*Perfect secrecy:*] For fixed $m,c$, exactly one key: $e_1=(c-m) dot 2^(-1) mod p$ (since $2$ is invertible mod $p$).
  $P(C=c|M=m)=1/p$ independently of $m$, so $#imp[I(M;C)=0]$.
  #text(fill: blue.darken(20%), weight: "bold")[Interpretation:] OTP with effective key $K'=2e_1$ (uniform by bijection of multiplication).

  #hline()
  #underline[*Exercise 5 — June 2013: Voting Protocol*] \
  $n$ voters $P_i$ with votes $x_i in {0,1}$ ($1$ = support). Modulus $q>n$ avoids wrap-around.

  #underline[*Protocol:*] Each $P_i$ splits $x_i$ into $n$ additive shares: pick $x_(i,1),...,x_(i,n-1)$ uniform, set $x_(i,n)=x_i - sum_(j=1)^(n-1) x_(i,j) mod q$. Send $x_(i,j)$ to $P_j$ privately. Each $P_j$ publishes column sum $y_j = sum_(i=1)^n x_(i,j) mod q$.

  #underline[*Correctness:*] $T = sum_(j=1)^n y_j = sum_(i=1)^n sum_(j=1)^n x_(i,j) = sum_(i=1)^n x_i mod q$. Since $q>n$ and $0 <= sum x_i <= n$, $#imp[T = "number of yes votes"]$.

  #underline[*Privacy:*] Each $x_i$ hidden by additive secret sharing: any strict subset of shares is uniform; only all $n$ shares reveal $x_i$.
  #text(fill: red.darken(20%), weight: "bold")[Caveat:] if all other voters collude, they can reconstruct that voter's shares from public sums. Basic protocol protects only under non-collusion assumption.
]

#ebox("Q2 - June 2022")[
  #underline[*Question:*]
  Alice and Bob share a #imp[perfect channel]; Eve has a #imp[BEC] ($epsilon$): each bit is received correctly w.p. $1-epsilon$, or erased ($e$) w.p. $epsilon$. Alice sends secret bit $m$ by picking $n-1$ uniform bits $m_1,...,m_(n-1)$, setting $m_n = m plus.o m_1 plus.o ... plus.o m_(n-1)$, and transmitting $m_1,...,m_n$. Initially $Pr[m=1]=1/2$; after transmission, Eve's recovery probability must be $<= (1+10^(-9))/2$.

  (a) How does Bob recover $m$?\
  (b) Minimum $n$ when $epsilon = 0.11$?

  #hline()
    #underline[*Part (a)*] \
    Bob receives all bits perfectly. He can simply compute:
    $ imp(m = m_1 plus.o m_2 plus.o ... plus.o m_n) $
    This works because $m_n = m plus.o m_1 plus.o ... plus.o m_(n-1)$, so adding $m_1 ... m_(n-1)$ to both sides (modulo 2) gives $m$.

  #hline()
  #underline[*Part (b) - Setup*] \
  Let $D$ be the event that #def[Eve decodes the message]. \
  Let $N$ be the event that #def[Eve has no erasures]. \
  Let $macron(N)$ be the event that #def[Eve has at least one erasure].

  Eve must receive #imp[all] $n$ bits to recover $m$ deterministically. If even one bit is erased, she is left with a missing uniform random variable, giving her zero information about $m$.

  #import cetz.draw: *

  // -----------------------------------------
  // Merged equivalent diagram
  // Preserves your original local coordinates.
  // -----------------------------------------
  #let merged-erasure-equivalence(
    p-good: "0,445",
    p-bad: "0,055",
    p-ok: "0,89",
    p-err: "0,11",
    scale: 0.8cm,
    right-rel-scale: 1.25, // because your right diagram was scale: 1cm while left was 0.8cm
  ) = cetz.canvas(length: scale, {
    // -----------------------------------------
    // Global placement controls
    // -----------------------------------------
    let left-origin = (0.0, 0.0)
    let right-origin = (6.6, 0.35)

    let L = (x, y) => (
      left-origin.at(0) + x,
      left-origin.at(1) + y,
    )

    let R = (x, y) => (
      right-origin.at(0) + right-rel-scale * x,
      right-origin.at(1) + right-rel-scale * y,
    )

    // =========================================
    // 1) Binary -> {0,e,1} diagram
    // Your original adjustments preserved
    // =========================================

    let xL = 0.0
    let xR = 3.2

    let y0 = 1.2
    let ye = 0.0
    let y1 = -1.2

    // ---- node labels ----
    content(L(xL - 0.25, y0), [$0$])
    content(L(xL - 0.25, y1), [$1$])

    content(L(xR + 0.25, y0), [$0$])
    content(L(xR + 0.20, ye), [$e$])
    content(L(xR + 0.25, y1), [$1$])

    // ---- edges ----
    line(L(xL, y0), L(xR, y0), mark: (end: "stealth"), stroke: 0.8pt)
    line(L(xL, y0), L(xR, ye), mark: (end: "stealth"), stroke: 0.8pt)
    line(L(xL, y1), L(xR, ye), mark: (end: "stealth"), stroke: 0.8pt)
    line(L(xL, y1), L(xR, y1), mark: (end: "stealth"), stroke: 0.8pt)

    // ---- formula labels ----
    let top-formula-pos    = (1.6, 1.48)
    let upperdiag-formula  = (1.3, 0.42)
    let lowerdiag-formula  = (1.3, -0.42)
    let bot-formula-pos    = (1.6, -1.48)

    content(L(top-formula-pos.at(0), top-formula-pos.at(1)), [$ \(1 - epsilon\)\/2 $])
    content(L(upperdiag-formula.at(0), upperdiag-formula.at(1)), [$ epsilon\/2 $])
    content(L(lowerdiag-formula.at(0), lowerdiag-formula.at(1)), [$ epsilon\/2 $])
    content(L(bot-formula-pos.at(0), bot-formula-pos.at(1)), [$ \(1 - epsilon\)\/2 $])

    // ---- numeric labels ----
    let top-num-pos   = (1.55, 1)
    let up-num-pos    = (2.5, 0.5)
    let low-num-pos   = (2.5, -0.5)
    let bot-num-pos   = (1.55, -1)

    content(L(top-num-pos.at(0), top-num-pos.at(1)), text(fill: blue)[#p-good])
    content(L(up-num-pos.at(0), up-num-pos.at(1)), text(fill: blue)[#p-bad])
    content(L(low-num-pos.at(0), low-num-pos.at(1)), text(fill: blue)[#p-bad])
    content(L(bot-num-pos.at(0), bot-num-pos.at(1)), text(fill: blue)[#p-good])


    // =========================================
    // 2) Middle arrow
    // =========================================

    line((4.05, 0.0), (5.85, 0.0), mark: (end: "stealth"), stroke: 0.9pt)
    content((4.95, 0.35), text(size: 8pt)[equivalent])


    // =========================================
    // 3) {0,1} -> {0,1} / e summary diagram
    // Your original adjustments preserved
    // =========================================

    let left  = (0.0, 0.0)
    let right = (3.0, 0.0)
    let down  = (2.4, -1.6)

    // ---- node labels ----
    content(R(-0, 0.0), [$\{0,1\}$])
    content(R(3, 0.0), [$\{0,1\}$])
    content(R(2.4, -1), [$e$])

    // ---- arrows ----
    line(R(0.55, 0.0), R(2.5, 0.0), mark: (end: "stealth"), stroke: 0.9pt)
    line(R(0.55, 0.0), R(2.2, -1), mark: (end: "stealth"), stroke: 0.9pt)

    // ---- labels on upper arrow ----
    let upper-num-pos     = (1.55, -0.20)
    let upper-formula-pos = (1.55, 0.2)

    content(R(upper-num-pos.at(0), upper-num-pos.at(1)), text(fill: blue)[#p-ok])
    content(R(upper-formula-pos.at(0), upper-formula-pos.at(1)), [$ 1 - epsilon $])

    // ---- labels on diagonal arrow ----
    let diag-formula-pos = (1.67, -0.52)
    let diag-num-pos     = (1.3, -0.8)

    content(R(diag-formula-pos.at(0), diag-formula-pos.at(1)), [$ epsilon $])
    content(R(diag-num-pos.at(0), diag-num-pos.at(1)), text(fill: blue)[#p-err])
  })

  #align(center)[
    #merged-erasure-equivalence()
  ]

  #hline()
  #underline[*Part (b) - Probability Analysis*] \
  $ Pr[D] &= underbrace(Pr[D|N], #place(center, dy: 0.1em)[#text(size: 7.5pt, fill: blue.darken(20%))[1 (certainty)]]) underbrace(Pr[N], #place(center, dy: 0.1em)[#text(size: 7.5pt, fill: orange.darken(20%))[$(1-epsilon)^n$]]) + underbrace(Pr[D|macron(N)], #place(center, dy: 0.1em)[#text(size: 7.5pt, fill: red.darken(20%))[$1/2$ (must guess)]]) underbrace(Pr[macron(N)], #place(center, dy: 0.1em, dx: 1em)[#text(size: 7.5pt, fill: green.darken(20%))[$1-(1-epsilon)^n$]]) \
  #v(2.5em)
  &= 1 dot (0.89)^n + 1/2 dot (1 - (0.89)^n) \
  &= (0.89)^n/2 + 1/2 = (1 + 0.89^n)/2 $

  #hline()
  #underline[*Part (b) - Finding $n$*] \
  We require Eve's success probability to be bounded (above $50%$):
  $ Pr[D] <= (1 + 10^(-9)) / 2 $

  $ imp( overbrace((1 + (0.89)^n)/2, #place(dy: -0.6em,center)[#text(size: 7.5pt, fill: orange.darken(20%))[$Pr[D]$]]) &<= overbrace((1 + 10^(-9))/2, #place(center, dy: -0.6em)[#text(size: 7.5pt, fill: orange.darken(20%))[Target bound]])\
    (0.89)^n &<= 10^(-9)\
     n &>= log_(0.89)(10^(-9)) approx 177.8 ) $

  Thus, the minimum number of bits is $#imp[$n = 178$]$ (often rounded up to $n >= 180$ in practice).
]
#block(fill: red, "TODO - ADD More older exams with a whole lot of detail", inset: 0.4em)








= Tips & Tricks Additional


#ebox("Question JL - June 2020")[
  #underline[*1. Code Rate*] \
  Given the channel symbol duration $tau_c = 1 mu s = 10^(-6) s$,
  and the input stream rate $800$ kbits/s,
  we find the source bit duration $tau_s = 1 / (800 dot 10^3) = 1.25 dot 10^(-6) s$.
  $ imp(underbrace(R_1, #place(center, dy: 0.1em)[#text(size: 7.5pt)[Code Rate]]) = tau_c / tau_s = (10^(-6)) / (1.25 dot 10^(-6)) = 0.8) $
  - #strong("Could the rate be higher/lower?")
    If the channel is used at #imp[not full speed]
    ($tau_c$ effectively increases),
    the redundancy decreases, so the rate $R$ can be #def[higher].
    However, it must remain bounded:
    - Speed constraint: $R >= 0.8$
    - Capacity constraint: $R <= C$

  #hline()
  #underline[*2. Channel Capacity*] \
  The channel is a #def[Binary Symmetric Channel (BSC)] with error probability $p = 0.0079$.
  $ imp(
      underbrace(C, #place(center, dy: 0.1em)[#text(size: 7.5pt)[Capacity]])
      &= 1 + p log_2(p) + (1-p) log_2(1-p)\
      &approx 1 - 0.066 = 0.934 " bits/symbol"
    ) $
  - #strong([Is $R_1$ providing enough redundancy?])\
    Yes, since #imp[$R_1 = 0.8 < C = 0.934$].
    In practice, any rate $0.8 <= R <= 0.934$ could work.

  #hline()
  #underline[*3. Required Code Length*] \
  Using the finite-length performance bound:
  $ p_e approx 2^(-n(C-R)) $
  $ imp(
      underbrace(n, #place(center, dy: 0.1em)[#text(size: 7.5pt)[Required Length]])
      &>= (log_2(1/p_e)) / (C - R_1)\
      &>= (log_2(10^4)) / (0.934 - 0.8)
      approx 13.287 / 0.134 approx 99.15
    ) $
  We can round this up to #imp[$n = 100$].

  #hline()
  #underline[*4. Hamming-bound upper limit on minimum distance*] \
  With $n = 100$ and $R_1 = 0.8$, we have $k = R_1 n = 80$. Thus $n - k = 20$.
  We evaluate the #def[Hamming Bound] for binary codes:
  $ sum_(i=0)^t binom(n, i) = sum_(i=0)^t n!/(i! (n-i)!) <= 2^(n-k) $
  #v(-0.6em)
  $ imp(
      underbrace(
        binom(100,0) + binom(100,1) + binom(100,2) + binom(100,3) + overbrace(cancel(binom(100,4)),#place(center, dy: -0.6em)[#text(size: 7.5pt)[Too big]]),
        #place(center, dy: -0.2em)[#text(size: 7.5pt)[$1 + 100 + 4950 + 161700 = 166751$]]
      )
      &<= overbrace(2^20, #place(center, dy: -0.6em)[#text(size: 7.5pt)[$approx 10^6$]])
    ) $
  #v(0.4em)
  But adding $binom(100,4) = 3921225$ would exceed $2^20$.
  So the Hamming bound only proves #imp[$t <= 3$]. It rules out guaranteed correction of $4$ errors. Equivalently, it gives the upper limit #def[$d_"min" <= 7$].\
  #text(fill: red.darken(20%), weight: "bold")[This does not prove that a binary $[100,80,7]$ code exists.]
  #text(size: 8pt)[
    _Note: The Singleton bound $d_"min" <= n - k + 1 = 21$ is too optimistic for binary codes (large alphabets). And is better for MDS codes such as Reed Solomon_
  ]

  #hline()
  #underline[*5. Reed–Solomon Code Design*] \
  - #strong([Smallest Galois field size ($q$):]) \
    The binary image length is $n_"BI" = m dot n_"RS"$,
    where $m = log_2(q)$ and $n_"RS" <= q - 1$.
    $ imp(
        underbrace(n_"BI", #place(center, dy: 0.1em)[#text(size: 7.5pt)[$>= 100$]])
        <= overbrace((q-1) log_2(q), #place(center, dy: -0.6em)[#text(size: 7.5pt)[Max binary length]])
      ) $
    #v(0.3em)
    Testing $q$ (when inequality is equal):
    - If $q = 16$ ($m = 4$): $thick 15 dot 4 = 60 < 100$ (Too small)
    - If $q = 32$ ($m = 5$): $thick 31 dot 5 = 155 >= 100$
      (#text(fill: green.darken(20%), weight: "bold")[Works!])
    So #imp[$q = 32$] is the smallest valid field size.
  - #strong("Reed–Solomon Parameters:") \
    We need:
    1. Correct at least 2 errors:
       $t >= 2 => d_"RS" >= 5$.
       Since RS is MDS: $n_"RS" - k_"RS" + 1 >= 5$.
    2. Binary image length $>= 100$:
       $n_"RS" dot 5 >= 100 => n_"RS" >= 20$.
    3. Usable in the scenario (rate constraint):
       $R = k_"RS" / n_"RS" >= 0.8$.

    Let's choose #imp[$n_"RS" = 20$].
    To satisfy the rate: $k_"RS" = 0.8 dot 20 = 16$.
    Checking distance:
    $d_"RS" = 20 - 16 + 1 = 5$,
    which gives $t = floor((5-1)/2) = 2$.\
    #text(fill: green.darken(20%), weight: "bold")[Valid design:]
    $"RS"(20, 16)$ over $"GF"(32)$.

  #hline()
  #subdefbox([*Theoretical Reminders & Logic:*])[
  - #def[2 Rate Constraints:] The rate is bounded by the #imp[channel speed] and #imp[channel capacity]: $H(U)/tau_s <= C/tau_c$, implying limits on $R$.
  - #def[Bounds Comparison:] The #imp[Hamming bound] relies on the volume formula and is good for binary codes. The #imp[Singleton bound] ($d_"min" <= n - k + 1$) is too optimistic for binary codes but is tight for MDS codes (large alphabets) like Reed-Solomon.
  - #def[Binary Image of RS Codes:] For an RS code over $"GF"(q)$ with $q=2^m$, the binary image length is $n_"BI" = m dot n_"RS"$. Since the maximum length of an RS code is $n_"RS" <= q-1$ (the zero element is generally not used), the binary image length is bounded by $n_"BI" <= (q-1)log_2(q)$.
  ]
]


#ebox("June 2013 - JL1")[
  #underline[*1. Rate, Length, and Redundancy*] \
  The generator matrix $G$ is a $3 times 6$ matrix.
  $ imp(underbrace(n, #place(center)[#text(size: 7.5pt)[Length]]) = 6 quad underbrace(k, #place(center)[#text(size: 7.5pt)[Dimension]]) = 3 quad underbrace(n-k, #place(center)[#text(size: 7.5pt)[Redundancy]]) = 3) $
  #v(0.3em)
  $ imp(underbrace(R, #place(center, dy: 0.1em)[#text(size: 7.5pt)[Rate]]) = k/n = 3/6 = 1/2) $
  #v(0.2em)
  #hline()
  #underline[*2. Parity Matrix*] \
  The matrix $G$ is already in canonical form $G = [I_k | A^T]$.
  $ G = mat(delim: "[",1, 0, 0, |, 0, 1, 1; 0, 1, 0, |, 1, 0, 1; 0, 0, 1, |, 1, 1, 0) $
  The parity check matrix is $H = [A | I_(n-k)] = [A | I_3]$. Since $A$ is symmetric, $A^T = A$. And following $H x^T = 0$ :
  $ imp(H = mat(delim: "[",0, 1, 1, |, 1, 0, 0; 1, 0, 1, |, 0, 1, 0; 1, 1, 0, |, 0, 0, 1)) $

  #hline()
  #underline[*3. Minimum Distance $>= 3$*] \
  The minimum distance $d_"min"$ is the minimum number of linearly dependent columns in $H$.
  - #strong("Weight 1:") No column is all zeros.
  - #strong("Weight 2:") No two columns are identical.
  Therefore, any linear combination summing to 0 requires #imp[at least 3 columns] (Weight 3).
  $ imp(d_"min" >= 3) $

  #hline()
  #underline[*4. Minimum Distance $<= 3$*] \
  The rows of the generator matrix $G$ are valid codewords.
  Looking at the first row of $G$: $c_1 = (1, 0, 0, 0, 1, 1)$.
  Its Hamming weight is $w(c_1) = 3$.
  Since $d_"min" <= min_(c in C, c != 0) w(c)$, we have:
  $ imp(d_"min" <= 3) $
  Combined with the previous result, $#imp[$d_"min" = 3$]$.

  #hline()
  #underline[*5. Correcting Capability*] \
  The number of correctable errors $t$ is given by:
  $ imp(underbrace(t, #place(center, dy: 0.1em)[#text(size: 7.5pt)[Max errors]]) = floor((d_"min" - 1)/2) = floor((3 - 1)/2) = 1) $
  So the code corrects #imp[one error].

  #hline()
  #underline[*6. Not Maximum Distance Separable (MDS)*] \
  By the #def[Singleton Bound], for a code to be MDS, we must have:
  $ d_"min" = n - k + 1 $
  Here, $n - k + 1 = 6 - 3 + 1 = 4$.
  Since $d_"min" = 3 < 4$, the code is #imp[not MDS].
  _Alternative proof from $H$: for MDS, any set of $n-k=3$ columns of $H$ must be linearly independent. But $text("Col")_1 + text("Col")_2 = text("Col")_3$, showing they are dependent._

  #hline()
  #underline[*7. Better Rate with Same Redundancy & Capability*] \
  We need the same redundancy:
  $ r = n-k = 3 $
  and the same correcting capability:
  $ t=1 quad <=> quad d_"min" = 3 $
  This matches the definition of a #def[Hamming Code].
  With redundancy $r=3$, the largest possible binary Hamming code has:
  $ n = 2^r - 1 = 7 $
  and:
  $ k = n-r = 7-3 = 4 $
  So the #def[Hamming code] has parameters $[7,4,3]$.
  Its rate is:
  $ imp(underbrace(R_("Hamming"), #place(center, dy: 0.1em)[#text(size: 7.5pt)[New Rate]]) = k/n = 4/7 > 1/2) $
  Therefore, yes: a #imp[Hamming $[7,4,3]$ code] has the same redundancy and same correcting capability, but a better rate.
]

#ebox("June 2013 - JL2")[
  #underline[*Given Data*] \
  Channel alphabet has $q=4$ symbols: $A,B,C,D$. \
  Channel use rate ($1/tau_c$): $thick 2 dot 10^6$ symbols/s. \
  Video rates:
  $ 720p: 10 " Mbits/s", quad 360p: 2.5 " Mbits/s", quad 240p: 10/9 " Mbits/s" $

  #hline()
  #underline[*1. Transition Matrix and Capacity*] \
  Each symbol is correct with probability $0.94$. Each wrong symbol has probability $0.02$.

  $ P_(Y|X) =
  mat(
    0.94, 0.02, 0.02, 0.02;
    0.02, 0.94, 0.02, 0.02;
    0.02, 0.02, 0.94, 0.02;
    0.02, 0.02, 0.02, 0.94
  ) $

  This is a #def[4-ary symmetric channel], so capacity is reached by the uniform input distribution.

  $ C = log_2(4) - H(0.94,0.02,0.02,0.02) $

  $ H(Y|X)
    = -0.94 log_2(0.94) - 3 dot 0.02 log_2(0.02)
    approx 0.4225 $

  Therefore:
  $ C approx 2 - 0.4225 = #imp[1.5775 " bits/symbol"] $

  In bits per second:
  $ C_"bps" = 2 dot 10^6 dot 1.5775 approx #imp[3.155 " Mbits/s"] $

  #hline()
  #underline[*2. Which Qualities Can Be Transmitted?*] \
  A quality can be transmitted reliably only if its information rate is below capacity.

  $ 720p: 10 > 3.155 quad arrow.r quad #text(fill: red.darken(20%), weight: "bold")[Impossible] $

  $ 360p: 2.5 < 3.155 quad arrow.r quad #text(fill: green.darken(20%), weight: "bold")[Possible] $

  $ 240p: 10/9 approx 1.111 < 3.155 quad arrow.r quad #text(fill: green.darken(20%), weight: "bold")[Possible] $

  So #imp[360p and 240p] can be transmitted with appropriate coding, but #imp[720p cannot], whatever the code.

  #hline()
  #underline[*3. Code Rate for 360p*] \
  At 360p, the source produces:
  $ 2.5 dot 10^6 " bits/s" $

  The channel uses:
  $ 2 dot 10^6 " symbols/s" $

  Therefore the useful information per channel symbol is:
  $ R_"bits/symbol" = (2.5 dot 10^6)/(2 dot 10^6) = #imp[1.25 " bits/symbol"] $

  Since each channel symbol has $log_2(4)=2$ raw bits, the normalized code rate is:
  $ R = R_"bits/symbol" / (log_2(4)) = 1.25/2 = #imp[5/8] $

  #text(fill: gray.darken(40%))[
    Definition used: $R = k/n$ for a code over the 4-symbol alphabet. Equivalently, the useful bit rate is $R log_2(4)$ bits per channel symbol.
  ]

  #hline()
  #underline[*4. Code Length $n=10$ at This Exact Rate?*] \
  With normalized rate:
  $ R = 5/8 $

  a length-$10$ code would require:
  $ k = R n = (5/8) dot 10 = 6.25 $

  But $k$ must be an integer number of information symbols for a block code over the channel alphabet.

  Equivalently, each block of $10$ channel symbols would need to carry:
  $ 10 dot 1.25 = 12.5 " bits" $

  which is not an integer number of bits.

  Therefore, with #imp[length $10$] and this #imp[exact rate], such a fixed block code is:
  $ #text(fill: red.darken(20%), weight: "bold")[not possible] $

  Also, Shannon's theorem is asymptotic: even if $R<C$, it guarantees almost error-free transmission only for sufficiently large block lengths, not automatically for $n=10$.

  #hline()
  #underline[*5. Average Mutual Information at 360p*] \
  If a code of the desired rate achieves almost error-free transmission at 360p, then the useful message information transmitted per channel use is:
  $ I_"message per use" = (2.5 dot 10^6)/(2 dot 10^6) = #imp[1.25 " bits/symbol"] $

  This is below the channel capacity:
  $ 1.25 < 1.5775 $
  so it is compatible with Shannon's theorem.\
  #text(fill: orange.darken(20%))[
    Careful: the physical single-letter channel mutual information $I(X;Y)$ is not necessarily equal to $1.25$ for every code. For the uniform input distribution, this symmetric channel gives:
  ]

  $ I(X;Y) = C = #imp[1.5775 " bits/symbol"] $

  Thus:
  - #imp[$1.25$ bits/symbol] = useful information rate required by 360p.
  - #imp[$1.5775$ bits/symbol] = maximum channel mutual information per symbol, i.e. capacity.
]
#block(fill: red, "TODO - Move these exams to their proper places, and add more old exam questions with many details", inset: 0.4em)
