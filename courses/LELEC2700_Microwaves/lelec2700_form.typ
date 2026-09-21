#import "../../templates/template_formulaire_gen2.typ": *

#show: formulaire.with(
  course: "LELEC2700 - Microwaves",
  authors: [Victor Carballes],
  layout: "horizontal", // Use "vertical" for portrait A4 with two columns.
  front_page: false,
)

= Fundamental constants and plane waves

#fbox("Free-space reference values", tag: "exam")[
  #def[Wave speed] and #def[intrinsic impedance] in vacuum are
  $
    c &= 1 / sqrt(mu_0 epsilon_0) approx 3 times 10^8 "m/s" \
    eta_0 &= sqrt(mu_0 / epsilon_0) approx 120 pi Omega approx 377 Omega
  $

  For a homogeneous medium,
  $
    overNote(v_p, "phase velocity", tone: "success")
      &= 1 / sqrt(mu epsilon) \
    underNote(beta, "phase constant", tone: "info")
      &= omega sqrt(mu epsilon) = 2 pi / lambda
  $

  #success[Use the medium parameters consistently.] #warn[Do not mix
  free-space and dielectric wavelengths.]
]

#tbox("Uniform plane wave")[
  A time-harmonic wave travelling in the $+z$ direction can be represented by
  $
    bold(E)(z) &= bold(E)_0 e^(-j beta z) \
    bold(H)(z) &= 1/eta hat(z) times bold(E)(z)
  $

  The vectors $bold(E)$, $bold(H)$, and the propagation direction form a
  right-handed orthogonal triad. The average power-density vector is
  $ imp(chevron.l bold(S) chevron.r = 1/2 Re(bold(E) times bold(H)^*)) $.

  #subdefbox("Lossy medium")[
    Write the propagation constant as $gamma = alpha + j beta$. The factor
    $e^(-alpha z)$ describes attenuation, while $e^(-j beta z)$ describes
    phase progression.
  ]
]

#exerbox("Quick wavelength check")[
  At $f = 10 "GHz"$ in air,
  $ lambda_0 = c/f approx 3 "cm" $.
  In a dielectric with $epsilon_r = 4$ and $mu_r = 1$, the wavelength becomes
  $lambda = lambda_0/sqrt(epsilon_r) approx 1.5 "cm"$.
]

#ebox("Common phasor trap")[
  Before using a propagation factor, check the chosen time convention.
  With $e^(j omega t)$, propagation toward $+z$ uses $e^(-j beta z)$.
  Mixing conventions reverses the apparent travelling direction.
]

= Transmission lines

#fbox("Telegrapher equations")[
  A uniform line is described per unit length by $R$, $L$, $G$, and $C$:
  $
    (dif V(z))/(dif z) &= -(R + j omega L) I(z) \
    (dif I(z))/(dif z) &= -(G + j omega C) V(z)
  $

  The two central line quantities are
  $
    gamma &= sqrt((R + j omega L)(G + j omega C)) \
    Z_0 &= sqrt((R + j omega L)/(G + j omega C))
  $
]

#tbox("Lossless-line relations")[
  For $R = G = 0$,
  $
    gamma = j beta, quad
    Z_0 = sqrt(L/C), quad
    v_p = 1/sqrt(L C)
  $

  Voltage and current are superpositions of forward and backward waves:
  $
    V(z) &= V^+ e^(-j beta z) + V^- e^(j beta z) \
    I(z) &= 1/Z_0 (V^+ e^(-j beta z) - V^- e^(j beta z))
  $
]

#fbox("Input impedance")[
  Looking into a lossless line of length $l$ terminated by $Z_L$ gives
  $
    Z_"in" = Z_0 (Z_L + j Z_0 tan(beta l))/(Z_0 + j Z_L tan(beta l))
  $

  #strong[Useful special cases:]
  - Quarter wave, $l = lambda/4$: $Z_"in" = Z_0^2/Z_L$.
  - Half wave, $l = lambda/2$: $Z_"in" = Z_L$.
  - Matched load, $Z_L = Z_0$: $Z_"in" = Z_0$ for every $l$.
]

#ebox("Open versus short circuit")[
  Do not substitute infinity too early. For a lossless line,
  $
    Z_"in,SC" = j Z_0 tan(beta l), quad
    Z_"in,OC" = -j Z_0 cot(beta l)
  $
  An open circuit can therefore appear as a short circuit after a
  quarter-wavelength transformation, and conversely.
]
#fbbox("Test", [
  #lorem(400)
])


= Reflection, matching, and standing waves

#fbox("Reflection coefficient")[
  At the load,
  $
    Gamma_L = (Z_L - Z_0)/(Z_L + Z_0), quad
    Z_L = Z_0 (1 + Gamma_L)/(1 - Gamma_L)
  $

  Along a lossless line,
  $ Gamma(z) = Gamma_L e^(-2 j beta z) $,
  so its magnitude is constant and only its phase rotates.

  - $Gamma_L = 0$: matched load.
  - $abs(Gamma_L) = 1$: total reflection for an ideal open or short.
  - $0 < abs(Gamma_L) < 1$: partial reflection.
]

#tbox("Standing-wave ratio and power")[
  The #def[voltage standing-wave ratio] is
  $
    "VSWR" = V_"max"/V_"min"
    = (1 + abs(Gamma_L))/(1 - abs(Gamma_L))
  $

  For a line with real $Z_0$, the average forward power and delivered power are
  $
    P^+ &= abs(V^+)^2/(2 Z_0) \
    P_L &= P^+ (1 - abs(Gamma_L)^2)
  $

  A perfect match gives #imp[maximum delivered power] and
  $"VSWR" = 1$.
]

#exerbox("Quarter-wave transformer")[
  To match a real load $R_L$ to a real line impedance $Z_0$, insert a
  quarter-wave section with
  $ Z_t = sqrt(Z_0 R_L) $.

  Example: matching $50 Omega$ to $100 Omega$ requires
  $Z_t = sqrt(50 times 100) Omega approx 70.7 Omega$.
]

#ebox("Smith-chart checklist")[
  1. Normalize the load: $z_L = Z_L/Z_0$.
  2. Locate $z_L$ on the impedance chart.
  3. Move toward the generator along the constant-$abs(Gamma)$ circle.
  4. Read the normalized input impedance and denormalize it.

  #imp[Exam check:] one full revolution corresponds to $lambda/2$ on the line,
  not $lambda$.
]

#bibliography(
  "./lelec2700_bib.bib",
  title: [References],
  full: true,
)
