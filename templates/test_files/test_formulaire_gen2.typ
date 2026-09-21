#import "../template_formulaire_gen2.typ": *
#import "../template_formulaire_gen2_legacy_wrapper.typ": *

#show: formulaire.with(
  course: "TEST0000 - Gen 2 Formulaire Stress Test",
  authors: [Template Test and Victor Carballes],
  title: "Dense cards, mathematics, diagrams, and metadata",
  institution: "UCLouvain",
  layout: "horizontal",
  front_page: true,
  details: [
    This document deliberately stresses card breakability, nested components,
    mathematical annotations, diagrams, semantic labels, metadata collection,
    page transitions, and compatibility aliases.
  ],
  show_outline: true,
  outline_depth: 2,
  chapter_new_page: true,
  bibliography_new_page: true,
)

= Core cards and semantic structure

#fbox(
  "Probability and information essentials",
  tags: ("definition", "exam"),
  collection_summary: [
    Entropy, conditional entropy, and mutual information identities with their
    principal bounds.
  ],
)[
  #laass[All logarithms are in base $2$, so information is measured in bits.]

  $
    &strong("Entropy")             &quad& H(X) = -sum_x p(x) log_2 p(x) \
    &strong("Joint entropy")       &quad& H(X,Y) = -sum_(x,y) p(x,y) log_2 p(x,y) \
    &strong("Conditional entropy") &quad& H(X|Y) = H(X,Y) - H(Y) \
    &strong("Mutual information")  &quad& I(X;Y) = H(X) + H(Y) - H(X,Y)
  $

  #bsec("Bounds and equality conditions")
  - $0 <= H(X) <= log_2 |cal(X)|$; the upper bound holds for a uniform source.
  - $0 <= I(X;Y) <= min(H(X),H(Y))$.
  - $I(X;Y)=0$ iff $X$ and $Y$ are independent.
  - $H(X|Y)=0$ iff $X$ is determined by $Y$.
]

#fbbox(
  "Long breakable theory card",
  tags: ("important",),
  metadata_tags: ("stress", "breakable"),
  collection_summary: [A deliberately long card used to validate column splitting.],
)[
  #laint[
    A tinted body indicates that the card may continue in another column or on
    another page. The following filler intentionally forces that behavior.
  ]

  #subdefbox("Core reminder", metadata_tags: ("definition",))[
    For a memoryless channel,
    $p(y^n|x^n)=product_(i=1)^n p(y_i|x_i)$.
  ]

  #bsec("Dense prose stress")
  #lorem(420)

  #bsec("Aligned derivation after filler", tone: "important")
  $
    H(X^n|Y^n)
      &= -sum_(x^n,y^n) p(x^n,y^n) log_2 p(x^n|y^n) \
      &= -sum_(x^n,y^n) p(x^n,y^n)
         sum_(i=1)^n log_2 p(x_i|y_i) \
      &= sum_(i=1)^n H(X_i|Y_i)
  $
  #laconc[Memorylessness converts the block conditional entropy into a sum.]
]

#tbox("Data processing inequality", tags: ("exam", "important"))[
  #lahyp[$U -> X -> Y$, meaning $p(y|x,u)=p(y|x)$.]

  #bsec("Two chain-rule expansions", separator: false)
  $
    I(U;X,Y)
      &= I(U;X) + underNote(
        I(U;Y|X),
        "zero by Markovity",
        tone: "success",
        dx: #(-0.25em),
        dy: #(0.08em),
      ) \
      &= I(U;Y) + underNote(
        I(U;X|Y),
        "non-negative",
        tone: "important",
        dx: #(0.35em),
      )
  $

  #laconc[$I(U;Y) <= I(U;X)$: deterministic or stochastic processing cannot
  increase the information carried about $U$.]
]

#smartbox(
  "Custom violet palette",
  kind: "custom",
  breakable: true,
  tags: ("extra", "optional"),
  metadata_tags: ("custom-palette",),
  palette: (
    title: rgb("#f3e8ff"),
    tint: rgb("#fcf8ff"),
    border: rgb("#a855f7"),
    accent: colors.purple,
  ),
  collection_summary: [Custom palettes remain compatible with metadata.],
)[
  #ladet[This card validates direct palette injection into `smartbox`.]
  #lorem(90)
]

== Structured labels and small utilities

#theory_box("All structured label variants", breakable: false)[
  #lahyp[The alphabet is finite.] \
  #laass[Successive channel uses are independent.] \
  #lacond[$R<C$.] \
  #lagiv[$p=0.01$ and $n=1000$.] \
  #lamet[Apply the union bound.] \
  #lastp[Compute the exponent.] \
  #lachk[Probabilities remain in $[0,1]$.] \
  #ladet[The logarithm is base $2$.] \
  #laext[Compare against a finite-length approximation.] \
  #laspc[For $p=0$, the channel is noiseless.] \
  #laconc[The selected rate is achievable asymptotically.] \
  #laint[Capacity is an information rate per channel use.] \
  #lawarn[Do not mix bits per symbol and bits per second.] \
  #laans[$C=1-h_2(p)$.]
]

#fbox("Pills and utility helpers", tags: ("important", "extra", "optional"))[
  Visible searchable pills: #pill("exam") #pill("warn") #pill("custom") \
  Metadata-only tag: #tag("search-only", visible: false). \
  Timing hint: #estimate(15, label: "target").

  #bsec("Writing area")
  #note_lines(count: 3)
]

= Equations and annotations

#equation_box(
  title: [Entropy identities],
  tags: ("exam", "important"),
  metadata_tags: ("equation", "definition"),
  collection_summary: [$I(X;Y)=H(X)-H(X|Y)$.],
)[
  $
    H(X,Y) &= H(X) + H(Y|X) \
           &= H(Y) + H(X|Y) \
           &= H(X) + H(Y) - I(X;Y)
  $
]

#eqbox(label: [Legacy `label` argument], tag: "extra")[
  $
    D_"KL" (P || Q)
      = sum_x P(x) log_2 (P(x)/Q(x))
      >= 0
  $
]

#tbox("Annotation positioning controls", metadata_tags: ("annotation-test",))[
  #laint[The labels below deliberately use different offsets, fills, body
  movements, and layout behavior.]

  $
    Pr[D]
      &= underNote(
          Pr[D|N],
          "certainty",
          tone: "success",
          dx: #(-0.35em),
          dy: #(0.1em),
          affect_layout: #true,
        ) quad
        underNote(
          Pr[N],
          "no erasure",
          fill: #orange.darken(20%),
          dx: #(0.55em),
          affect_layout: #true,
        ) \
      &+ underNote(
          Pr[D|macron(N)],
          [#text(fill: red.darken(15%))[must guess]],
          tone: #none,
          fill: #none,
          size: #none,
          dx: #(-1.6em),
          body_dy: #(0.05em),
          affect_layout: #true,
        ) quad
        underNote(
          Pr[macron(N)],
          "some erasure",
          tone: "warning",
          dx: #(2.4em),
          affect_layout: #true,
        )
  $

  #v(1.2em)
  $
    overNote(
      (1 + (1-epsilon)^n)/2,
      "adversary success",
      tone: "warning",
      dx: #(-0.35em),
      dy: #(-0.75em),
      body_dx: #(0.08em),
      affect_layout: #true,
    )
    &<= overNote(
      (1 + 10^(-9))/2,
      [#text(fill: purple)[target bound]],
      tone: #none,
      fill: #none,
      size: #none,
      dx: #(0.4em),
      affect_layout: #true,
    ) \
    n &>= log_(1-epsilon)(10^(-9))
  $
]

#fbox("Matrices, cases, sums, and limits", metadata_tags: ("math-stress",))[
  $
    G &= mat(
      1, 0, 1, 1;
      0, 1, 1, 0;
      1, 1, 0, 1
    ) \
    H_b (p) &= cases(
      0 &"if " p in {0,1},
      -p log_2 p -(1-p)log_2(1-p) &"if " 0<p<1,
    ) \
    C &= max_(p(x)) I(X;Y) \
    R(D) &= min_(p(hat(x)|x): E[d(X,hat(X))] <= D) I(X;hat(X)) \
    lim_(n->oo) 1/n log_2 |cal(C)_n| &= C
  $
]

#proof_box("Fano inequality skeleton", tags: ("exam",), collection_summary: [Fano bounds uncertainty through the error probability.])[
  Let $hat(X)$ be estimated from $Y$, let $P_e=Pr[X != hat(X)]$, and let
  $|cal(X)|=M$.

  #bsec("Error indicator", separator: false)
  Define $E=1$ when the estimate is wrong. Since $E$ is determined by
  $(X,hat(X))$,
  $
    H(X|Y)
      &<= H(E|Y) + H(X|E,Y) \
      &<= H_b (P_e) + P_e log_2(M-1).
  $

  #bsec("Reusable consequence")
  $
    I(X;Y)
      >= H(X) - H_b (P_e) - P_e log_2(M-1).
  $
  #lachk[As $P_e -> 0$, the remaining uncertainty must also vanish.]
]

= Exercises, warnings, and nested cards

#exercise_box(
  "Binary symmetric channel calculation",
  tags: ("exam",),
  collection_summary: [Compute $C=1-H_b (p)$ and compare the proposed rate.],
)[
  #sub_reminder_box("Core reminders")[]
  #sub_definition_box("Binary symmetric channel")[
    A transmitted bit is flipped independently with probability $p$.
  ]
  #sub_theorem_box("Capacity")[
    $C=1-H_b (p)$ bits per channel use, achieved by a uniform input.
  ]

  #bsec("Given")
  #lagiv[$p=0.0079$, code rate $R=0.8$, and target block error $10^(-4)$.]

  #bsec("Capacity calculation")
  $
    C
      &= 1 + p log_2 p + (1-p)log_2(1-p) \
      &approx 0.934 " bits/use".
  $

  #bsec("Rate decision")
  Since $R=0.8<C$, the asymptotic capacity condition is satisfied.
  #lawarn[This does not by itself guarantee the target error at a short block length.]

  #bsec("Finite-length estimate")
  Using the crude model $P_e approx 2^(-n(C-R))$,
  $
    n >= (log_2(1/P_e))/(C-R)
      approx 13.287/(0.934-0.8)
      approx 99.2.
  $
  #laans[Choose at least $n=100$ under this approximation.]
]

#example_box("Joint-distribution table", tags: ("extra",))[
  #table(
    columns: 4,
    align: center,
    stroke: 0.3pt + colors.line,
    inset: 3pt,
    [$(X,Y)$], [$Y=0$], [$Y=1$], [Marginal],
    [$X=0$], [$0.35$], [$0.15$], [$0.50$],
    [$X=1$], [$0.10$], [$0.40$], [$0.50$],
    [Marginal], [$0.45$], [$0.55$], [$1$],
  )

  #bsec("Checks")
  #lachk[Every entry is non-negative and the complete table sums to one.]
  #laext[Compute $I(X;Y)$ directly and compare it with $H(X)-H(X|Y)$.]
]

#warning_box("Common failure modes", tags: ("warn", "exam"))[
  - #danger[Wrong units:] comparing bits/source symbol with bits/second.
  - #danger[Wrong independence assumption:] replacing $H(X^n)$ by $n H(X)$
    without verifying independent inputs.
  - #danger[Wrong logarithm base:] using natural logs while reporting bits.
  - #danger[Premature rounding:] rounding probabilities before an exponentiation.
  - #danger[Missing condition:] quoting a capacity formula outside its channel model.
]

#todo_box("Deliberate TODO rendering test", metadata_tags: ("development",))[
  #lorem(70)
]

#theory_box("Nested-card density test", tags: ("important",))[
  #subdefbox("Definition", metadata_tags: ("definition",))[
    #def[Typical set:] sequences whose empirical self-information is close to
    the entropy rate.
  ]
  #sbrembox("Reminder")[
    The typical set has probability approaching one while containing roughly
    $2^(n H(X))$ sequences.
  ]
  #sbthmbox("Asymptotic equipartition property")[
    For an i.i.d. source, $-1/n log_2 p(X^n) -> H(X)$ in probability.
  ]
  #sbexbox("Quick scale")[
    If $H(X)=0.5$ bits/symbol and $n=100$, the typical-set scale is about
    $2^50$ sequences rather than $2^100$.
  ]
  #sbwarnbox("Limitation")[
    Asymptotic typicality does not directly provide a sharp finite-length error
    bound.
  ]
]

= Diagram stress tests

#diagram_box(
  title: [Communication chain],
  tags: ("important",),
  collection_summary: [Linear source-to-destination communication chain.],
)[
  #scale(x: 65%, y: 65%, reflow: true)[
    #flowdiag(
      (
        [Source],
        [Source encoder],
        [Channel encoder],
        [Noisy channel],
        [Channel decoder],
        [Destination],
      ),
      arrows: (
        [$U^k$],
        [$M$],
        [$X^n$],
        [$Y^n$],
        [$hat(U)^k$],
      ),
      spacing: 0.22em,
    )
  ]
]

#diagram_box(title: [Vertical processing chain], tags: ("extra",))[
  #flowdiag(
    (
      [Observed sequence $Y^n$],
      [Compute likelihoods],
      [Select maximum],
      [Return estimate $hat(X)^n$],
    ),
    arrows: ([normalize], [compare], [decode]),
    direction: "down",
    spacing: 0.25em,
    node_fill: colors.theory_tint,
    node_stroke: colors.blue,
  )
]

#diagram_box(title: [Parallel coding architecture], metadata_tags: ("diagram", "stress"))[
  #scale(x: 65%, y: 65%, reflow: true)[
  #grid(
    columns: (1fr, auto, 1fr),
    rows: (auto, auto, auto),
    column-gutter: 0.35em,
    row-gutter: 0.35em,
    align: center,
    [#flowdiag(([Source 1], [Encoder 1], [Codeword 1]), spacing: 0.18em)],
    [$+$],
    [#flowdiag(([Codeword 1], [Decoder 1], [Estimate 1]), spacing: 0.18em)],
    [#flowdiag(([Source 2], [Encoder 2], [Codeword 2]), spacing: 0.18em)],
    [$->$ *Shared channel* $->$],
    [#flowdiag(([Codeword 2], [Decoder 2], [Estimate 2]), spacing: 0.18em)],
    [#flowdiag(([Source 3], [Encoder 3], [Codeword 3]), spacing: 0.18em)],
    [$+$],
    [#flowdiag(([Codeword 3], [Decoder 3], [Estimate 3]), spacing: 0.18em)],
  )
  ]
]

#dbox(title: [Large algebraic transformation])[
  #scale(x: 80%, y: 80%, reflow: true)[
  $
    underbrace(
      [u_0 | u_1 | dots.c | u_(K-1)],
      "K source symbols",
    )
    stretch(arrow.r.long)^"outer encoding"
    underbrace(
      [a_0 | a_1 | dots.c | a_(N-1)],
      "N field symbols",
    )
    stretch(arrow.r.long)^"inner encoding"
    underbrace(
      [x_0 | x_1 | dots.c | x_(n N-1)],
      "binary channel word",
    )
  $
  ]
]

= Compatibility aliases and layout extremes

#fixedbox("Legacy `fixedbox`")[
  This alias is supplied by `template_formulaire_gen2_legacy_wrapper.typ`.
]

#theorybox("Legacy `theorybox`")[#lorem(90)]
#exercisebox("Legacy `exercisebox`")[Short exercise body.]
#examplebox("Legacy `examplebox`")[Short example body.]
#proofbox("Legacy `proofbox`")[Short proof body.]
#exambox("Legacy `exambox`")[Short exam body.]
#warningbox("Legacy `warningbox`")[Short warning body.]
#todobox("Legacy `todobox`")[Short TODO body.]
#subbox("Legacy `subbox`")[Nested legacy body.]
#diagMath[$X arrow.r Y arrow.r Z$]
#diagBox(title: [Legacy diagram wrapper])[$X arrow.r Y$]

#fbbox("Very long final breakable card", metadata_tags: ("stress",))[
  #bsec("First segment", separator: false)
  #lorem(260)
  #bsec("Middle mathematics")
  $
    sum_(i=1)^n I(X_i;Y_i)
      &<= sum_(i=1)^n C_i \
      &<= n max_i C_i,
  $
  #lorem(260)
  #bsec("Final check", tone: "success")
  #lachk[The complete card should split cleanly without losing its tinted body,
  border, or title semantics.]
]

= LELEC2348-derived channel-coding section

#fbox(
  "Discrete memoryless channel",
  tags: ("definition", "exam"),
  collection_summary: [A DMC is specified by its alphabets and transition matrix.],
)[
  A #def[discrete memoryless channel (DMC)] is described by an input alphabet
  $cal(X)$, an output alphabet $cal(Y)$, and transition probabilities
  $W(y|x)$ satisfying
  $
    W(y|x) >= 0, quad sum_(y in cal(Y)) W(y|x)=1
    quad "for every " x in cal(X).
  $

  For $n$ independent uses,
  $
    W^n(y^n|x^n)=product_(i=1)^n W(y_i|x_i).
  $
  #laass[Memorylessness is a conditional statement: outputs become independent
  once the complete input sequence is fixed.]
]

#fbox("Binary symmetric and erasure channels", metadata_tags: ("definition",))[
  #sub_definition_box("Binary symmetric channel — BSC")[
    Each bit is flipped independently with probability $p$:
    $
      W = mat(1-p, p; p, 1-p), quad 0 <= p <= 1.
    $
    Its capacity is $C_"BSC"=1-H_b (p)$ bits/use.
  ]

  #sub_definition_box("Binary erasure channel — BEC")[
    Each bit is either received correctly or replaced by an erasure symbol with
    probability $epsilon$:
    $
      C_"BEC"=1-epsilon " bits/use".
    $
  ]

  #lachk[$p=0$ gives a noiseless BSC, while $p=1/2$ gives zero capacity.]
  #lachk[$epsilon=0$ gives a noiseless BEC, while $epsilon=1$ erases everything.]
]

#tbox(
  "Mutual information through a channel",
  tags: ("important",),
  collection_summary: [$I(X;Y)=H(Y)-H(Y|X)$ measures conveyed information.],
)[
  Given an input distribution $P_X (x)$, the induced output distribution is
  $
    P_Y (y)=sum_x P_X (x)W(y|x).
  $

  The mutual information can be evaluated in several equivalent ways:
  $
    I(X;Y)
      &= sum_(x,y) P_X (x)W(y|x)
         log_2 (W(y|x)/(P_Y (y))) \
      &= H(X)-H(X|Y) \
      &= H(Y)-H(Y|X) \
      &= H(X)+H(Y)-H(X,Y).
  $

  #bsec("Interpretation")
  - $H(Y)$ measures output variability.
  - $H(Y|X)$ measures variability caused by the channel once the input is known.
  - Their difference is the part of the output variability that actually
    carries information about the input.
]

#fbbox(
  "Capacity of weakly symmetric channels",
  tags: ("exam",),
  metadata_tags: ("capacity", "derivation"),
  collection_summary: [For a weakly symmetric channel, $C=log_2|cal(Y)|-H(r)$.],
)[
  A channel is #def[weakly symmetric] when every row of its transition matrix is
  a permutation of every other row and all column sums are equal.

  #bsec("Uniform input")
  Under a uniform input, the output is uniform:
  $
    H(Y)=log_2 |cal(Y)|.
  $
  Since all rows have the same entropy $H(r)$,
  $
    H(Y|X)=sum_x P_X (x)H(W(dot|x))=H(r).
  $

  Therefore
  $
    imp(C=log_2 |cal(Y)|-H(r)).
  $

  #bsec("Strongly symmetric special case")
  If the matrix is square and every row and column is a permutation, the same
  expression applies immediately. The uniform input achieves capacity.

  #bsec("Sanity checks")
  - A deterministic permutation channel has $H(r)=0$ and
    $C=log_2|cal(Y)|$.
  - A channel with identical rows has no input-dependent output information and
    therefore has $C=0$.

  #lorem(150)
]

#proof_box(
  "Concavity argument for channel capacity",
  tags: ("proof", "exam"),
  collection_summary: [Mutual information is concave in the input distribution.],
)[
  Fix the channel $W(y|x)$ and vary the input distribution $P_X$.

  #bsec("Conditional part", separator: false)
  $
    H(Y|X)=sum_x P_X (x)H(W(dot|x))
  $
  is linear in $P_X$ because the row entropies are fixed.

  #bsec("Output part")
  The induced $P_Y$ is linear in $P_X$, while entropy is concave. Hence
  $H(Y)$ is concave in $P_X$.

  #bsec("Difference")
  $
    I(X;Y)=underNote(H(Y), "concave", tone: "success")
      - underNote(H(Y|X), "linear", tone: "important")
  $
  is concave in $P_X$. Thus every local maximum over the probability simplex is
  globally optimal.

  #laconc[Capacity optimization is a concave maximization problem over a compact
  simplex, so a maximizing input distribution exists.]
]

#theory_box("Capacity with symbol durations", tags: ("important", "exam"))[
  Let $tau_s$ be the source-symbol duration and $tau_c$ the channel-symbol
  duration. A source emitting $H(U)$ bits/source symbol produces information at
  rate
  $
    underNote(H(U)/tau_s, "source bitrate", tone: "important", dx: #(-0.4em))
  $
  A channel with capacity $C$ bits/channel use supports at most
  $
    underNote(C/tau_c, "channel bitrate", tone: "success", dx: #(0.4em))
  $

  Reliable transmission requires
  $
    H(U)/tau_s < C/tau_c.
  $
  Defining the timing rate $R=tau_c/tau_s$ gives the equivalent condition
  $
    H(U)<C/R.
  $

  #lawarn[The quantity $R=tau_c/tau_s$ is dimensionless. Do not confuse it with
  a physical bitrate in bits per second.]
]

#exercise_box(
  "Exercise session — capacity and code design",
  tags: ("exam", "important"),
  metadata_tags: ("exercise-session", "stress"),
  collection_summary: [Four complete capacity and parameter-design exercises.],
)[
  #sub_reminder_box("Core reminders")[
    - $C_"BSC"=1-H_b (p)$.
    - $C_"BEC"=1-epsilon$.
    - Reliable coding requires $R<C$ for binary equiprobable sources under the
      usual coding-rate convention.
    - A linear $[n,k,d]$ code corrects at most
      $t=floor((d-1)/2)$ adversarial symbol errors.
  ]

  #bsec("Problem 1 — BSC capacity")
  A BSC has crossover probability $p=0.11$.
  $
    C
      &= 1+p log_2 p +(1-p)log_2(1-p) \
      &approx 1-0.500 \
      &approx 0.500 " bits/use".
  $
  #laans[A code rate $R=0.4$ is below capacity; $R=0.6$ is not.]

  #bsec("Problem 2 — BEC repetition")
  A bit is repeated $n$ times through independent BEC uses. The decoder knows
  the bit whenever at least one copy survives. Therefore
  $
    P_"fail"=epsilon^n.
  $
  To ensure $P_"fail"<=delta$,
  $
    n >= (log delta)/(log epsilon),
  $
  where both logarithms are negative for $0<epsilon,delta<1$.
  #lachk[Always round $n$ upward.]

  #bsec("Problem 3 — Hamming bound")
  A binary code of length $n$ correcting $t$ errors must satisfy
  $
    |cal(C)| sum_(i=0)^t binom(n,i) <= 2^n.
  $
  For a linear $[n,k,d]$ code, $|cal(C)|=2^k$, hence
  $
    k <= n-log_2(sum_(i=0)^t binom(n,i)).
  $
  #laint[The balls of radius $t$ around codewords must be disjoint.]

  #bsec("Problem 4 — Singleton bound")
  Puncturing any $d-1$ coordinates must leave all codewords distinct, so
  $
    |cal(C)| <= q^(n-d+1).
  $
  For a linear $q$-ary code, this becomes
  $
    k <= n-d+1 quad <=> quad d <= n-k+1.
  $
  #laans[Codes meeting equality are maximum-distance separable (MDS).]

  #lorem(180)
]

#exam_box(
  "Exam-style code and parameter design",
  tags: ("exam", "important"),
  metadata_tags: ("parameter-design",),
  collection_summary: [Choose rate and block length under capacity and error constraints.],
)[
  A binary source emits $800$ kbit/s. The channel accepts one coded bit every
  $tau_c=1 mu s$ and behaves as a BSC with $p=0.0079$.

  #bsec("1. Timing rate", separator: false)
  The source-bit duration is
  $
    tau_s=1/(800 dot 10^3)=1.25 dot 10^(-6) " s".
  $
  Hence
  $
    underNote(R, "timing rate", tone: "important")
      = tau_c/tau_s
      = 0.8.
  $

  #bsec("2. Channel capacity")
  $
    C
      &= 1+p log_2 p +(1-p)log_2(1-p) \
      &approx 0.934 " bits/use".
  $
  Since $R=0.8<C$, the asymptotic capacity condition is satisfied.

  #bsec("3. Required code length")
  Using the rough exponent model $P_e approx 2^(-n(C-R))$ and requiring
  $P_e<=10^(-4)$ gives
  $
    n
      &>= (log_2(1/P_e))/(C-R) \
      &>= log_2(10^4)/(0.934-0.8) \
      &approx 99.2.
  $
  #laans[Select $n>=100$ under this approximation.]

  #bsec("4. Interpretation")
  #lawarn[Capacity only guarantees the existence of sufficiently long good
  codes. The exponent model used here is an approximation, not a universal
  finite-length theorem.]
]

#warning_box("Channel-coding traps", tags: ("warn", "exam"))[
  - Capacity is maximized over the #imp[input distribution]; it is not generally
    obtained from an arbitrary input.
  - $I(X;Y)$ is symmetric in its arguments, but the channel law $W(y|x)$ is not.
  - The Hamming bound is necessary, not always sufficient.
  - Minimum distance controls worst-case error correction, whereas channel
    capacity concerns probabilistic reliable communication.
  - A rate below capacity does not identify a concrete encoder or decoder.
]

#todo_box("TODO — add the missing old-exam variant")[
  Add a second parameter-design problem using a non-binary alphabet, an explicit
  Reed–Solomon construction, and a finite-length comparison. This box must be
  impossible to overlook while editing.
]

= Generated metadata collections

#collect_cards(
  tag: "definition",
  title: [Collected definitions],
  compact: true,
)

#collect_cards(
  tag: "exam",
  title: [Collected exam material],
  compact: true,
)

#collect_cards(
  kind: "diagram",
  title: [Collected diagrams],
  compact: true,
)

#collect_cards(
  tag: "stress",
  title: [Collected stress-test cards],
  compact: true,
)
