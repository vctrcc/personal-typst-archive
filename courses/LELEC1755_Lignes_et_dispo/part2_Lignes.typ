#import "../syth_template.typ": conf, note_block, block_colors, todo_block
#show: conf.with(
  title: [
    Part 1.2 - Transmission Lines
  ],
  course: "LELEC1755",
  authors: (
     (name: "Victor Carballes", affiliation: "UCLouvain"),
   ),
  abstract: [
  This document covers the fundamental concepts of transmission lines, including their characteristics, behavior, and applications from the course LELEC1755. In a theoretical and practical manner, in preparation for the exams.\ #box(move(dy: 0.4em, [ Source code here : #text(fill: color.aqua.darken(20%))[#link("https://github.com/vctrcc/personal-typst-archive")]]))
  ],
)

= Introduction
Transmission lines are the baseline of most modern circuitry and communication systems. They guide electromagnetic waves from one point to another with minimal loss and distortion. Such lines can also be tuned to perform specific functions, such as impedance matching, filtering, or phase shifting.

When the wavelength of a signal becomes comparable to or smaller than the physical length of a conductor, that conductor must be treated as a transmission line. In this regime, voltage and current vary along its length, and phase effects cannot be ignored any longer. Additional effects such as reflections, standing waves, and dispersion become significant, affecting signal integrity and power transfer.

The principles discussed in this course form the foundation for understanding topics such as printed circuit board (PCB) signal integrity, impedance matching, antenna feed design, and power transmission systems used in electrical grids. #footnote([
  More will be covered in the following master courses :\ LELEC2910 (Antennas and Propagation), LELEC2532 (Analog Electronic Systems), LELEC2520 (Electrical Power Systems), LELEC2530 (Electromagnetic Waves), LELEC2580  (Design of RF and microwave communication circuits), and LELEC2700 (Microwaves).
])

This document provides an overview of transmission lines, covering their fundamental principles, common configurations, and methods of analysis.

#note_block(block_colors.extra)[
  #text(size: 9pt)[
  We will not address the many additional phenomena that occur in real transmission lines, such as resistive losses, radiation, crosstalk, parallel conductor coupling, and skin effect. Likewise, effects relevant to antennas—like high-frequency atmospheric attenuation, surface currents, and the use of metamaterials—are beyond the scope of this course. For power transmission systems, topics such as corona discharge, air ionization, interactions with vegetation, weather influences, and nearby conductive structures are also omitted. These subjects are explored in greater depth in the Electronics Master.
  ]
]

#note_block(block_colors.warning)[
  You will need both a compas as well as a complex capable calculator for the exercises and exams. If you don't have them, borrow them from someone who does. Here, good hardware can make a BIG difference in precision and time !
]

#grid(
  columns: 3,
  gutter: 0.1em,
  row-gutter: 0.5em,
  align: horizon + center,
  [#figure(
    image("part2_diagrams/Typical-High-Voltage-Power-Transmission-system-Picture-source-internet-999415016.jpg", width: 90%),
    caption: [Diagram of a typical HV transmission line @animalia_power_lines],
  )],
  [#figure(
    image("part2_diagrams/impedance-compare2.png", width: 120%),
    caption: [Asymmetric stripline vs. microstrip field lines @altium_microstrip],
  )],
  [#figure(
    image("part2_diagrams/coaxial-cable-diagram-1.jpg", width:100%),
    caption: [Diagram of a coaxial cable @coax_cable_image_asktheman],
  )],
  [#figure(
    image("part2_diagrams/Microstrip pad antenna for 5.4GHz.png", width: 90%),
    caption: [2.44GHz matched microstrip dual patch antenna with stub, created in LELEC2910 by Group 18 2024.],
  )],
  grid.cell(colspan:2,
    [#figure(
      image("part2_diagrams/applsci-09-00248-g001-979602817.png", width: 90%),
      caption: [(a) Open circuit microstrip line stub. (b) Transmission line model of the open circuit stub. @kusama_compact_microstrip_2019],
    )]),
  )

// Add image of power line, triphase conductor geometry, strip line (PCB), pad antenna with feed line and radiation lobe.

= Transmission Lines Overview
== What are Transmission Lines?
A transmission line is a structure designed to carry electromagnetic energy from one point to another. It becomes necessary to treat a conductor as a transmission line when the wavelength ($lambda$) of the signal is comparable to or smaller than the physical length of the line ($L$).

#block()
Here are the hypotheses we will be using throughout this course :
- *Long enough line* : $L >> lambda$
- *Thin enough line* : $D << lambda$ (where $D$ is the distance between opposing conductors)
- *Perfect conductor* : No losses (R=0, G=0)
- *Homogeneous and linear medium* : $epsilon$, $mu$, $sigma$ constant
- *Quasi-TEM mode of propagation* : No longitudinal E or H fields (only transverse components)
- *Isotropic medium* : Properties do not depend on direction (nor time)
- *Continuity* : R,L,G,C per unit length parameters constant along the line
- *Negligible radiation* : Does not intentionally radiate energy (not an antenna)
- *Weak external coupling* : Isolated, single line (does not have multiple conductors close to each other)
#block()

#grid(columns: 2, gutter: 0.1em, align: horizon, [
#figure(
  image("part2_diagrams/Transmission_line_element.svg.png", width: 70%),
  caption: [Schematic representation of a transmission line element @wikipedia_tranmission_line],
)<fig:telegraphers>],[
#figure(
  image("part2_diagrams/Transmission_line_symbols.svg.png", width: 80%),
  caption: [Different equivalent schematics for a line of impedance $Z_0$, with a load $Z_L$ and source $S$ @wikipedia_tranmission_line],
)<fig:shematics>
])

=== Telegrapher's Equations & Characteristic Parameters

From the Telegrapher's equations, we can derive the wave equations for voltage and current along the line, using small segments of length $dif x$ with lumped parameters R, L, G, C per unit length, as seen on @fig:telegraphers. This leads to the following equations :

$ cases(
  (partial V (x, t))/(partial x) &= -L (partial I(x, t))/(partial t) - R I(x, t),
  (partial I(x, t))/(partial x) &= -C (partial V (x, t))/(partial t) - G V (x, t))
  -->^"homogenous" cases(
    V(x) &= V_+ (x)e^(-gamma x) + V_- (x)e^(+ gamma x),
    I(x) &= I_+ (x)e^(-gamma x) - I_- (x)e^(+ gamma x)
  ) $
  $ &"Characteristic impedance :" Z_c=sqrt((R+j omega L)/(G+j omega C))\
    &"Propagation constant :" gamma = underbrace(alpha, "attenuation\nconstant") + j underbrace(beta, "phase\nconstant"#footnote([$beta$ can be also called wavenumber, as it is the spatial analog of angular frequency $omega$.])) = sqrt((R+j omega L)(G+j omega C)) $
$ beta = omega sqrt(L C) = (2 pi)/lambda $

#block()
And in sinusoidal lossless steady-state regime (R=0, G=0) :
$ cases(Z_c = sqrt(L/C),
gamma = j beta = j (2 pi)/lambda) --> cases(
  V(x) &= V_0^+ e^(-j beta x) + V_0^- e^(+ j beta x),
  I(x) &= (1/Z_c)(V_0^+ e^(-j beta x) - V_0^- e^(+ j beta x))
) $

=== Quadripole Model of a Transmission Line
#figure(
  image("part2_diagrams/Transmission_line_4_port.svg.png", width: 30%),
  caption: [Equivalent quadripole of a line @wikipedia_tranmission_line],
)<fig:quadripole>
#block()
A transmission line can be modeled as a two-port network (quadripole) with ABCD parameters that relate the input and output voltages and currents. For a lossless line of length $l$, the ABCD parameters are given by:
$
  mat(delim: "[",
    A, B;
    C, D;
  ) = mat(delim: "[",
    cos(beta l), j Z_c sin(beta l);
    j (1/Z_c) sin(beta l), cos(beta l);
  ) -->
  vec(V_1, I_1) = mat(delim: "[",
    A, B;
    C, D;
  ) vec(V_2, -I_2)
$
From this quadripole, we can cascade it as many times as needed to represent a full line if need be#footnote([
  Cascading quadripoles : $vec(V_1, I_1) = mat(delim: "[",
    A_"line1", B_"line1";
    C_"line1", D_"line1";
  ) mat(delim: "[",
    A_"line2", B_"line2";
    C_"line2", D_"line2";
  ) vec(V_2, -I_2)$\

]). We can also derive the formulas for the input impedance $Z_"in"$ and input admittance $Y_"in"$ of the line when terminated with a load impedance $Z_L$ or admittance $Y_L$ :
$ Z_"in" &= V_1/I_1|_(Z_L) = (A Z_L + B)/(C Z_L + D) = (Z_L cos(beta l) + j Z_c sin(beta l))/(cos(beta l) + j Z_L/Z_c sin(beta l)) = Z_c (Z_L cos(beta l) + j Z_c sin(beta l))/(Z_c cos(beta l) + j Z_L sin(beta l)) \
 Y_"in" &= 1/Z_"in" =
 (D Y_L + C)/(B Y_L + A)
 = (Y_L cos(beta l) + j Y_c sin(beta l))/(cos(beta l) + j Y_L/Y_c sin(beta l))
 = Y_c (Y_L cos(beta l) + j Y_c sin(beta l))/(Y_c cos(beta l) + j Y_L sin(beta l)) $\

 Then, we can also form 2 other useful equations from this :
$ Z_"in" &= Z_c (Z_L + j Z_c tan(beta l))/(Z_c + j Z_L tan(beta l)) = Z_c (Z_L + Z_c tanh(beta l))/(Z_c + Z_L tanh(beta l)) \
 Y_"in" &= Y_c (Y_L + j Y_c tan(beta l))/(Y_c + j Y_L tan(beta l)) = Y_c (Y_L + Y_c tanh(beta l))/(Y_c + Y_L tanh(beta l)) $
=== Reflection Factor and Wave Reflection Coefficient
In the general case without hypothesis, we are considering a progressive wave that travels through a transmission line and hits a load $Z_L$. Represented#footnote([Notice that $x$ has changed to $z$ for the position on the line]) in @fig:reflection_shematic :

#figure(
  image("part2_diagrams/m0087_fZinTerminatedTL.png", width: 40%),
  caption: [Description of the transmission line in question @libretexts_input_impedance],
)<fig:reflection_shematic>
#block()

$ V(z) =V_+ e^(-gamma z) + V_- e^(+ gamma z) $
$ "Reflection Factor" : Gamma (z) eq.delta (V_- e^(+ gamma z))/(V_+ e^(-gamma z)) = V_-/V_+ e^(2 gamma z) = (Z_L - Z_c)/(Z_L + Z_c) e^(2 gamma z) = Gamma_L e^(2 gamma z) $\

This reflection factor represents the ratio of the reflected wave amplitude to the incident wave amplitude at any point $z$ along the line. At the load ($z=0$), it simplifies to:

$ Gamma_L = Gamma(0) = (Z_L - Z_c)/(Z_L + Z_c) $
$ Gamma(0) = Gamma(l) e^(2 gamma l) <==> Gamma(l) = Gamma(0) e^(-2 gamma l) $\

This coefficient indicates how much of the incident wave is reflected back due to impedance mismatch at the load. The value of $Gamma_L$ ranges from -1 to 1, where:
- $Gamma_L = 0$ : Perfectly matched load (no reflection, full power transfer)
- $Gamma_L = 1$ : Open circuit (total reflection with no phase change)
- $Gamma_L = -1$ : Short circuit (total reflection with 180-degree phase change)
#block()

From here, we can also find another form of $Z_"in"$ :
$ Z_"in" = (V(z))/(I(z))= Z_c (1 + Gamma(z))/(1 - Gamma(z)) = Z_c (1 + Gamma_L e^(2 gamma z))/(1 - Gamma_L e^(2 gamma z)) $\

The reflection factor is crucial in understanding how signals behave in transmission lines, as it affects voltage standing wave ratio (VSWR), power transfer efficiency, and overall signal integrity. VSWR, also known TOS (taux d'ondes stationnaires) in French, is defined as:
$ "VSWR" : S = (|V(z)|_"max")/(|V(z)|_"min") = (1 + |Gamma|)/(1 - |Gamma|) $\
Where $|V(z)|_"max"$ and $|V(z)|_"min"$ are the maximum and minimum voltage amplitudes along the line, respectively. A VSWR of 1 indicates a perfectly matched line, while higher values ($--> infinity$) indicate greater mismatch and more significant reflections, and a stationarity of the wave (VSWR $approx infinity$).
#block()
The reflection factor also allows the creation of a "Smith Chart", which is a graphical tool used to represent complex impedances and reflection coefficients in transmission lines. It provides a visual way to analyze and design transmission line systems, particularly for impedance matching. We will see this in more detail later on.

#note_block(block_colors.note)[
  The objective of adaptation is to minimize the reflection coefficient $Gamma_L$ to zero, which maximizes power transfer and minimizes signal distortion. This is typically achieved by ensuring that the load impedance $Z_L$ matches the characteristic impedance $Z_c$ of the transmission line. This technique has a great broadband performance, as it works for all frequencies (within the limits of the line's design and model).
  #block()
  Techniques include :
  - Adjusting the physical length of the line to create a quarter-wave transformer
  - Employing stubs (short-circuited or open-circuited sections of transmission line)
  #block()
  - Using matching networks (L, Pi, T networks)
  - Using baluns (balanced to unbalanced transformers)
  - Implementing tapered lines (gradually changing the line's impedance)
  - Using transformers (for AC signals)
  - Using active components (amplifiers, negative impedance converters)
  (Most of these are covered in the course LELEC2910 (antenna design project) and LELEC2531)
]

== Transmission Line Configurations
// Speak about sources

=== Basic Configurations
#grid(columns: 2, gutter: 1em, row-gutter: 1em,
  align: (x, y) => if x == 1 {(left + top)} else { center + horizon } ,
  stroke: (x, y) => if x == 0 {(right: 0.7pt)} else { none },
[#figure(
  image("part2_diagrams/cascade_transmission.png", width: 90%),
  caption: "Cascade Transmission Line",
)],
[
  #align(center, [*_Cascade_*])\
  $Z_"in" = underbrace(Z_"eq","Cascade function") (Z_"0,2", l_2, Z_"inter")$\
  #block()\
  $Z_"eq" (Z_c, l, Z_L) = Z_c (Z_L + j Z_c tan(beta l))/(Z_c + j Z_L tan(beta l))$\
],
  [#figure(
  image("part2_diagrams/parallel transmission.png", width: 90%),
  caption: "Parallel Transmission Line",
)],
  [
    #align(center, [*_Parallel_*])\
    #text(rgb("#808080"))[$Z_"in" = (Z_"inter,1" Z_"inter,2")/(Z_"inter,1" + Z_"inter,2")$]\ #block()
    $Y_"in" = Y_"inter,1" + Y_"inter,2"$
    #block()\
],
[#figure(
  image("part2_diagrams/series_transmission.png", width: 75%),
  caption: "Series Transmission Line",
)],
  [
    #align(center, [*_Series_*])\
    $Z_"in" = Z_"inter,1" + Z_"inter,2"$\ #block()
    #text(rgb("#808080"))[$Y_"in" = (Y_"inter,1" Y_"inter,2")/(Y_"inter,1" + Y_"inter,2")$]
]
)


#note_block(block_colors.warning)[
  Be VERY careful to not confuse "series" and "cascade" configurations.
  - Series : We sum up the impedances of each element
  - Cascade : We multiply the ABCD matrices of each element (or use the formula for $Z_L$)
]

=== Passive and Other Elements
// Table of formulas for series resistor, parallel resistor and quarter wave transformer)
#grid(columns: 2, gutter: 1em, row-gutter: 1em,
  align: (x, y) => if x == 1 {(left + top)} else { center + horizon } ,
  stroke: (x, y) => if x == 0 {(right: 0.7pt)} else { none },
  [#figure(
   image("part2_diagrams/Line Diagrams_series.drawio.svg", width: 90%),
    caption: [Series Impedance Diagram],
  )],
  [
    #align(center, [*_Series Impedance_*])\
    $Z_"inter,2" = Z_s + Z_"inter,1"$\ #block()
    $Y_"inter,2" = (Y_"inter,1" Z_s)/(Y_"inter,1" + Z_s)$
  ],
  [#figure(
    image("part2_diagrams/Line Diagrams_parallel.drawio.svg", width: 90%),
    caption: [Parallel Impedance Diagram],
  )],
  [
    #align(center, [*_Parallel Impedance_*])\
    $Y_"inter,2" = Y_"inter,1" + (1/Z_p)$\ #block()
    $Z_"inter,2" = (Z_"inter,1" Z_p)/(Z_"inter,1" + Z_p)$
  ],
  [#figure(
    image("part2_diagrams/Line Diagrams_quarter_wave.drawio.svg", width: 90%),
    caption: [Quarter Wave Transformer Diagram],
  )],
  [
    #align(center, [*_Quarter Wave Transformer_*])\
    $Z_"inter,2" = Z_c^2/Z_"inter,1"$\ #block()
    $Y_"inter,2" = Y_c^2/Y_"inter,1"$\ #block()
    #text(rgb("#808080"))[(Essentially just another line)]
  ],
)

=== Dielectric and Magnetic Materials
This will not appear at the exam, but to be complete we will cover also cover it. TP5 exercise 3 has this exact problem :
#grid(columns: 2, gutter: 1em, align: horizon, [
#figure(
  image("part2_diagrams/dielectric_line.svg", width: 90%),
  caption: [Exercise 5.3 : Dielectric transmission line],
)],[
#figure(
  image("part2_diagrams/TP5_3_line.png", width: 120%),
  caption: [Exercise 5.3 : Equivalent transmission line],
)],
)#block()

When a transmission line is filled with a dielectric material, the characteristic impedance and propagation constant of the line are affected by the material's permittivity ($epsilon_r$) and permeability ($mu_r$). The modified characteristic impedance ($Z_c'$) and propagation constant ($gamma'$) can be expressed as:
$ Z_c' = eta = sqrt((mu_0 mu_r)/(epsilon_0 epsilon_r)) = eta=376.7 sqrt(mu_r/epsilon_r) $
$ gamma' = j beta' = j omega sqrt(mu_r mu_0 epsilon_r epsilon_0) = j beta sqrt(epsilon_r mu_r) $
$ lambda_m = lambda_0 / sqrt(epsilon_r mu_r) $

The presence of the dielectric material generally reduces the characteristic impedance of the line and increases the phase constant, leading to slower signal propagation. This is particularly important in high-frequency applications where signal integrity and timing are critical. As we can see, Exercise 5.3 has a non-matched line with a dielectric material, and we have to adapt it to free space (air) at the input.
#block()
If we cosider adding a anti-reflection coating (to have $Gamma(z=0)=0$), we can use the quarter-wave transformer principle to adapt the real impedance of the line to the load. In the case of semi-conductors like in Exercise 5.3, we can use $S i_3 N_4$ ($epsilon_r = 4$), and deposit 2 layers, one with a fixed impedance to make the impedance real, then another made as a quarter wave transformer to adapt to the line impedance, where we change the thickness and permittivity $epsilon_r$. We have to consider the wavelength in the material for this, which is $lambda_m = lambda_0/sqrt(epsilon_r)$.
$ "Coating 1" : cases(
  Z_"eq" (z=-l_1) = Z_(c, S i_3 N_4) (Z_"eq" (z=0) + j Z_(c, S i_3 N_4) tan(beta' l_1))/(Z_(c, S i_3 N_4) + j Z_"eq" (z=0) tan(beta' l_1)) in RR,
  Gamma(z=-l_1) = (Z_"eq" (z=0) - Z_(c, S i_3 N_4))/(Z_"eq" (z=0) + Z_(c, S i_3 N_4)) --> underbrace(angle(Gamma(z=-l_1)) = 0, "Real Conversion Condition"),
  l_1 = lambda_m angle(Gamma(z=0))/(4 pi) = lambda_m angle(Gamma(z=-l_1) e^(-j 2 beta' l_1))/(4 pi),
  ) $
$ "Coating 2" : cases(
  Gamma(z=-l_1 - l_2) = 0 --> Z_"in" = Z_0= 376.7 Omega " and " beta'l_2 = pi/2,
  Z_"eq" (z=-l_1 - l_2) = underbrace(Z_"in", Z_0) = Z_(c, "Quarter Wave")^2/(Z_"eq" (z=-l_1)) in RR,
  epsilon_r = (eta_0/(Z_(c, "Quarter Wave")))^2 --> l_2 = lambda_0/(4 sqrt(epsilon_r))
) $\

#grid(columns: 2, gutter: 1em, [
#figure(
  image("part2_diagrams/dielectric_line_coating.svg", width: 90%),
  caption: [Dielectric transmission line with anti-reflection coating (TP5.3 solution)],
)],[
#figure(
  image("part2_diagrams/dielectric_line_oblique_angle.svg", width: 94%),
  caption: [Diagram of a dielectric transmission line with oblique incidence],
)<fig:dielectric_oblique_angle>
],
)#block()

If we consider a wave not incident to the surface, we have to also consider the angle of incidence $theta_i$ and the angle of transmission $theta_t$ (from Snell's law), which will modify the characteristic impedance and length of the lines (due to a change of permitivity and longer path and offset delays) :
- *Polarization* : Polarization must be considered as the TM and TE modes will have different characteristic impedances.
- *Impedance* : The TE and TM modes will have different impedances at the interface, which can be expressed as $Z_"TM" = Z_c cos(theta_i)$ and $Z_"TE" = Z_c / cos(theta_t)$.
- *Length* : The effective length of the transmission line will be increased by a factor of $1/cos(theta_t)$ due to the oblique incidence.

#note_block(block_colors.extra)[
  As you can seen in orange in @fig:dielectric_oblique_angle in orange, we can alos model a micro-facet model for light interaction with rough surfaces. This is useful for antennas and waveguides, as it allows to model the scattering and reflection of waves on rough surfaces. This is the base in PBR rendering (Physically Based Rendering) in computer graphics. And is a beautiful field of study on its own.
]

== Steady-State and Transitory Regimes
// Write a bit about the general math that ties it all together (look at that slide)
#note_block(block_colors.note)[
  Contrary to what one could think, transitory analysis of transmission lines is easier than steady-state analysis. This is due to the complex impedances of the loads and lines, which make the analysis more difficult.
]

As we are working with perfect transmission lines (no losses), we can prove that the impedance of the lines $Z_c$ are purely real. This is very important, as it will allow us to simplify strongly some of the calculations later on.

Proof :
$ Z_c = sqrt((R + j omega L)/(G + j omega C)) -->^("lossless") Z_c = sqrt(L/C) in RR $

=== Steady-State Regime


$ Z_"eq" =Z_c (Z_L cos(beta L) + j Z_c sin(beta L))/(Z_c cos(beta L) + j Z_L sin(beta L)) $

$ beta = (2 pi)/lambda $

We can also convert this to admittances, which is often more practical (proof at the end of the document):
$
Y_"eq"&= 1/Z_c (1/Z_L cos(beta L) + j 1/Z_c sin(beta L))/(1/Z_c cos(beta L) + j 1/Z_L sin(beta L)) \
&= Y_c (Y_L cos(beta L) + j Y_c sin(beta L))/(Y_c cos(beta L) + j Y_L sin(beta L)) $

For stubs in short circuit form, we have :
$ Z_"stub, short" &= j Z_c tan(beta L)\
 Y_"stub, short" &= -j Y_c cot(beta L) = Y_c/(j tan(beta L)) $

For stubs in open circuit form, we have :
 $
 Z_"stub, open" &= -j Z_c cot(beta L)=Z_c/(j tan(beta L))\
 Y_"stub, open" &= j Y_c tan(beta L) $

From here, we can also derive the reflection coefficient at the load (also known as the fresnel coefficient) :
$ Gamma_L = (V_0^-(z)e^(j beta z))/(V_0^+(z)e^(-j beta z)) = (Z_L - Z_c)/(Z_L + Z_c) --> cases(
  \["-1, 0"\[ " : Undermatched Load (Reflection)",
  0 "      : Matched Load (No Reflection)",
  \]"0, 1"\[ "  : Overmatched Load",
  "1" "      : Short Circuit",
) $
$ Gamma(z) = Gamma_L e^(j 2 beta z) --> V(z) = V_+ e^(-j beta z)(1+Gamma(z)) $
Where *$z$* is the position along the line, with $z=0$ at the load.

#block()

We can also analyse stationarity, or the ammount of interference in the line, through the standing wave ratio (SWR) (also known as TOS in french) :
$ underbrace("TOS","French") = underbrace("VSWR", "English") = (|V(z)_"max"|)/(|V(z)_"min"|) = (1+|Gamma(z)|)/(1 - |Gamma(z)|) --> cases(
  \["0, 1"\[ "  : Progressive Wave",
  \["1," infinity\[ " : Almost Standing Wave",
  infinity "     : Standing Wave",
) $

=== Transitory regime
#figure(
  image("part2_diagrams/ncident-and-reflected-waves-on-a-transmission-line.png", width: 50%),
  caption: [Representation of the incident and reflected waves on a transmission line ($V_+$ and $V_-$) @mccabe_impulse_tdr_2011],
)<fig:line_waves>

When working in the transient regime (impulse launch or front of a continuous wave), analyze incident and reflected waves via reflection coefficients at each interface. Model the structure as alternating transmission-line sections ("lines") and connection nodes where lumped components live ("zones") and can be treated with Kirchhoff’s laws. At every line–zone boundary, the reflection coefficient is defined as:

$ Gamma_"zone, line" = (Z_"zone, percieved" - Z_"c, line")/(Z_"zone, percieved" + Z_"c, line") $\

We can represent this reflection coefficient with an arrow going from the line to the zone.

We measure immediately after the source (just after $Z_s$ in @fig:line_waves). The source impedance $Z_s$ and the first line impedance $Z_c$ form a divider from the first interface, so the launched voltage is:
$ V_"in" = V_"gen" (Z_c)/(Z_s + Z_c) $

Then, for the following interfaces, we can calculate the reflected and transmitted voltages as :
$ "Interface Impulse Voltages" := cases(
  V_"reflected" &= Gamma_"zone, line" dot V_"incident",
  V_"transmitted" &= (1+ Gamma_"zone, line") dot  V_"incident"
) $

When going a bit further, we can also calculate the total voltage and current from the waves on the line at any point $(z,t)$ as :
$ "Transient Regime (Lossless Line)" :=cases(
  V(z, t) &= V_+ (t - z/v) + V_- (t + z/v),
  I(z, t) &= (1/Z_c)(V_+ (t - z/v) - V_- (t + z/v))
) $
$ "Steady State (Line is Wire)" :=cases(
  V(z, t=infinity) &= V_"gen" * (Z_L/(Z_g + Z_L)),
  I(z, t=infinity) &= V(z, t=infinity)/Z_L
) $

When we repeat these steps to infinity (so we propagate the waves back and forth infinitely), we can find the final voltages and currents at any point on the line. Though, most of the times, with only 2-3 reflections the voltage will have converged enough to the final value. As the losses in intesity and power are geometric (multiplicative), the convergence is (often) quite fast.

#note_block(block_colors.note)[
  For the rest of this section, i will refer to the generator's internal impedance $Z_s$ in @fig:line_waves as $R_g$, as we will consider it purely resistive for simplicity.
]

==== Configurations and how to solve therm
===== Basic Propagation Line
// Practical example
#grid(columns: (1.5fr, 1fr), gutter: 1em, align: bottom, [
#figure(
  image("part2_diagrams/Wikipedia/Transitory Line Base.svg", width: 115%),
  caption: [Time Domain Reflectometry (TDR) schematic of a basic propagation line],
)<fig:basic_propagation_line>],[#figure(
  image("part2_diagrams/Wikipedia/Transitory Line Base Reflections.svg", width: 75%),
  caption: [TDR measurement of reflections on a basic propagation line],
)<fig:basic_propagation_line_reflections>],
)#block()

#text(size: 10pt)[$ underbrace(cases(
  Gamma_(1,1) = (R_g - Z_(c,1))/(R_g + Z_(c,1)),
  Gamma_(2,1) = (Z_"mid" parallel Z_(c, 2) - Z_(c,1))/(Z_"mid" parallel Z_(c,2) + Z_(c,1)),
  Gamma_(2,2) = (Z_"mid" parallel Z_(c, 1) - Z_(c,2))/(Z_"mid" parallel Z_(c,1) + Z_(c,2)),
  Gamma_(3,2) = (Z_L - Z_(c,2))/(Z_L + Z_(c,2)),
), "Reflection coefficients") -> underbrace(cases(
  a = overbrace(V_"gen" (Z_(c,1)/(R_g + Z_(c,1))),V_0 (t=0)),
  b = a (1 + Gamma_(2,1)),
  c = a Gamma_(2,1),
  d = b Gamma_(3,2),
  e = d (1+ Gamma_(2,2)),
  V_1 (t=T_1) = c (1 + Gamma_(1,1)),
  V_2 (t=T_2) = e (1 + Gamma_(1, 1))
), "Impulse voltages in lines") -> underbrace(cases(
  T_1 = 2/v l_1,
  T_2 = 2/v (l_1 + l_2),,
  V(z=0, t=0) &= a,
  V(z=0, t=T_1) &= a + V_1,
  V(z=0, t=T_2) &= a + V_1 + V_2
), "Final voltages at entry of generator zone") $]



===== Series Propagation Line
#grid(columns: (1.5fr, 1fr), gutter: 1em, align: bottom, [
#figure(
  image("part2_diagrams/Wikipedia/Transitory Line Series.svg", width: 100%),
  caption: [Time Domain Reflectometry (TDR) schematic of a series propagation line],
)<fig:series_propagation_line>],[#figure(
  image("part2_diagrams/Wikipedia/Transitory Line Series Reflections.svg", width: 100%),
  caption: [TDR measurement of reflections on a series propagation line],
)<fig:series_propagation_line_reflections>],
)#block()

#text(size: 10pt)[$ underbrace(cases(
  Gamma_(1,1) = (R_g - Z_(c,1))/(R_g + Z_(c,1)),
  Gamma_(2,1) = ((Z_(c,3) + Z_(c, 2)) - Z_(c,1))/((Z_(c,3) + Z_(c,2)) + Z_(c,1)),
  Gamma_(2,2) = ((Z_(c,3) + Z_(c, 1)) - Z_(c,2))/((Z_(c,3) + Z_(c,1)) + Z_(c,2)),
  Gamma_(2, 3) = ((Z_(c, 2) + Z_(c,1)) - Z_(c,3))/((Z_(c,2) + Z_(c,1)) + Z_(c,3)),
  Gamma_(3,2) = (Z_(L,1) - Z_(c,2))/(Z_(L,1) + Z_(c,2)),
  Gamma_(4,3) = (Z_(L,2) - Z_(c,3))/(Z_(L,2) + Z_(c,3)),
), "Reflection coefficients") -> underbrace(cases(
  a = overbrace(V_"gen" (Z_(c,1)/(R_g + Z_(c,1))),V_0 (t=0)),
  Z_"eq" = Z_(c, 1) + Z_(c,2) + Z_(c,3),

  // Transmission of "a"
  b = a (Z_(c, 2)/Z_"eq")(1 + Gamma_(2,1)),
  g = a (Z_(c, 3)/Z_"eq")(1 + Gamma_(2, 1)),

  // Reflections of "a"
  c = a Gamma_(2,1),

  // Reflection of "b" and "g"
  d = b Gamma_(3,2),
  h = g Gamma_(4,3),

  // Transmission of "d"
  e = d (Z_(c, 1)/Z_"eq")(1+ Gamma_(2,2)),
  f = d (Z_(c, 3)/Z_"eq")(1+ Gamma_(2,2)),

  // Transmission of "h"
  i = h (Z_(c, 2)/Z_"eq")(1 + Gamma_(2,3)),
  j = h (Z_(c, 1)/Z_"eq")(1 + Gamma_(2,3)),

  V_1 (t=T_1) = c (1 + Gamma_(1,1)),
  V_2 (t=T_2) = e (1 + Gamma_(1, 1)),
  V_3 (t=T_3) = j (1 + Gamma_(1, 1)),
), "Impulse voltages in lines") -> underbrace(cases(
  T_1 = 2/v l_1,
  T_2 = 2/v (l_1 + l_2),
  T_3 = 2/v (l_1 + l_3),,
  V(z=0, t=0) &= a,
  V(z=0, t=T_1) &= a + V_1,
  V(z=0, t=T_2) &= a + V_1 + V_2,
  V(z=0, t=T_3) &= a + V_1 + V_3
), "Final voltages at entry of generator zone") $]

In this example, we have to be careful of the fact that the voltage goes through a sort of voltage divider at each series connection. This is why we have to calculate the equivalent impedance of the lines at the junction.

===== Parallel Propagation Line
#grid(columns: (1.5fr, 1fr), gutter: 1em, align: bottom, [
#figure(
  image("part2_diagrams/Wikipedia/Transitory Line Parallel.svg", width: 100%),
  caption: [Time Domain Reflectometry (TDR) schematic of a parallel propagation line],
)<fig:parallel_propagation_line>],[#figure(
  image("part2_diagrams/Wikipedia/Transitory Line Series Reflections.svg", width: 100%),
  caption: [TDR measurement of reflections on a parallel propagation line],
)<fig:parallel_propagation_line_reflections>],
)#block()

#text(size: 10pt)[$ underbrace(cases(
  Gamma_(1,1) = (R_g - Z_(c,1))/(R_g + Z_(c,1)),
  Gamma_(2,1) = ((Z_(c,3) + Z_(c, 2)) - Z_(c,1))/((Z_(c,3) + Z_(c,2)) + Z_(c,1)),
  Gamma_(2,2) = ((Z_(c,3) + Z_(c, 1)) - Z_(c,2))/((Z_(c,3) + Z_(c,1)) + Z_(c,2)),
  Gamma_(2, 3) = ((Z_(c, 2) + Z_(c,1)) - Z_(c,3))/((Z_(c,2) + Z_(c,1)) + Z_(c,3)),
  Gamma_(3,2) = (Z_(L,1) - Z_(c,2))/(Z_(L,1) + Z_(c,2)),
  Gamma_(4,3) = (Z_(L,2) - Z_(c,3))/(Z_(L,2) + Z_(c,3)),
), "Reflection coefficients") -> underbrace(cases(
  a = overbrace(V_"gen" (Z_(c,1)/(R_g + Z_(c,1))),V_0 (t=0)),

  // Transmission of "a"
  b = a (1 + Gamma_(2,1)),
  g = a (1 + Gamma_(2, 1)),

  // Reflections of "a"
  c = a Gamma_(2,1),

  // Reflection of "b" and "g"
  d = b Gamma_(3,2),
  h = g Gamma_(4,3),

  // Transmission of "d"
  e = d (1+ Gamma_(2,2)),
  f = d (1+ Gamma_(2,2)),

  // Transmission of "h"
  i = h (1 + Gamma_(2,3)),
  j = h (1 + Gamma_(2,3)),

  V_1 (t=T_1) = c (1 + Gamma_(1,1)),
  V_2 (t=T_2) = e (1 + Gamma_(1, 1)),
  V_3 (t=T_3) = j (1 + Gamma_(1, 1)),
), "Impulse voltages in lines") -> underbrace(cases(
  T_1 = 2/v l_1,
  T_2 = 2/v (l_1 + l_2),
  T_3 = 2/v (l_1 + l_3),,
  V(z=0, t=0) &= a,
  V(z=0, t=T_1) &= a + V_1,
  V(z=0, t=T_2) &= a + V_1 + V_2,
  V(z=0, t=T_3) &= a + V_1 + V_3
), "Final voltages at entry of generator zone") $]

Here, the biggest nuance is the current divider at each parallel connection. This is why we don't have to calculate the equivalent impedance of the lines at the junction, as the voltage is the same on both branches.

==== Impulse propagation at different points
#figure(
  image("part2_diagrams/Exercise6_4.png", width: 90%),
  caption: [Example of a simple circuit for impulse propagation analysis (Exercise 6.4)],
)<fig:impulse_propagation_line>

When the switch closes, a voltage step propagates down the transmission line toward the load. The voltage at any point along the line can be determined by considering the time it takes for the wave to reach that point and any reflections that may occur due to impedance mismatches (Where we will refer to the previous section's diagrams).

#block()
For a point located at position $z$ along the line, the voltage at time $t$ can be expressed as:
$ V(z, t) = V_"incident" (t - z/v) + V_"reflected" (t + z/v) $
Where $V_"incident"$ is the voltage of the wave traveling toward the load, and $V_"reflected"$ is the voltage of any wave reflected back toward the source.

#figure(
  image("part2_diagrams/Exercise6_4_continuous_signal.png", width: 70%),
  caption: [Continuous signal propagation within the line, at different points, depending on time],
)<fig:impulse_t0>
#figure(
  image("part2_diagrams/Exercise6_4_impulsion_signal.png", width: 50%),
  caption: [Impulse propagation within the line, at different at $t=T$ and $t=2T$],
)<fig:impulse_t1>


#block()
Often, the reflected wave comes from further down the line, meaning, it goes through a whole line, or multiple lines before coming back. In this case, we have to consider the time it takes for the wave to travel back and forth along the line. This extressed as such :
$ T_"reflected" = T_"traversed" * 2 $
Where $T_"traversed"$ is the time it takes for the wave to travel a networks up until the reflection point to consider. And $T_"reflected"$ is the total time it takes for the wave to travel to the reflection point and back to the point of interest (So the same time, just the path backward).

#note_block(block_colors.note)[
  This chapter should be redonne !
  #todo_block()
]


#pagebreak()
= Using the Smith Chart
Smith charts are a graphical tool used in electrical engineering to represent complex impedance and reflection coefficients in transmission lines and RF circuits. They provide a visualization for how we have to adapt the circuit to match impedances and minimize signal reflections for better transmission.

$ theta = 2 beta L = (4 pi)/lambda L $
#text(size: 14pt)[#grid(columns: (1fr, 1fr), align: center+horizon, inset: 0.6em,$z_"n" = Z_L/Z_c$,$y_n=Y_L/Y_c = Y_L Z_c$)]

#note_block(block_colors.trick)[
  One strong recommendation is to always re-normalize the impedances to the characteristic impedance of the line you are working with. This will make your life much easier, as you will be able to use the smith chart directly without having to do any conversions.
  #block()
  At the exam, don't hesitate to ask for more diagrams if need be !
]

== Basics of the Smith Chart
#grid(columns: 2, gutter: 1em, [
#figure(
  image("part2_diagrams/CERN/mobius transform smith.png", width: 100%),
  caption: [Mobius transformation from the impedance plane to the reflection coefficient plane @caspers_smith_chart],
)<fig:cern_impedance>],[
#figure(
  image("part2_diagrams/CERN/admittance_mapping.png", width: 100%),
  caption: [Mobius transformation from the admittance plane to the reflection coefficient plane @caspers_smith_chart],
)<fig:cern_admittance>],)
#block()

The smith chart is a polar plot of the complex reflection coefficient $Gamma$ and is used to represent normalized impedances and admittances. It is a mobius transformation that maps the entire complex impedance plane onto a unit circle in the complex reflection coefficient plane. As we can see form @fig:cern_impedance and @fig:cern_admittance, the impedance and admittance planes are mapped onto the same reflection coefficient plane, but with different transformations.

#figure(
  image("part2_diagrams/Wikipedia/Smith_chart_explanation.svg", width: 70%),
  caption: [Smith chart connections to transmission lines @wikipedia_smith_chart],
)<fig:wikipedia_smith_chart>

From @fig:wikipedia_smith_chart, we can see the different regions of the smith chart and how they correspond to different types of impedances and admittances. The right half of the chart corresponds to inductive impedances (positive imaginary part), while the left half corresponds to capacitive impedances (negative imaginary part). The top half corresponds to positive reactance (inductive), while the bottom half corresponds to negative reactance (capacitive).

$ Gamma(0) = (Z_L - Z_0) / (Z_L + Z_0) $
$ Gamma(0) = (z_L - 1) / (z_L + 1) <--> z_L = (1+Gamma(0))/(1-Gamma(0)) $
$ Gamma_"in" (0) = Gamma_"load" (x) e^( -2 j beta x) $
With $z_L = Z_L/Z_0$ the normalized load impedance, and $beta x$ the phase shift along the line of length $x$.
#block()
We can match the load by minimizing the reflected power, which comes to minimizing the reflection coefficient $Gamma(0)$ for a line starting at 0, with its final load at $L$. The power delivered to the load is given by :
$ P=P_"forward" - P_"reflected"=(|a|^2)/2 (1 - |Gamma(0)|^2) $
With $a$ the incident wave amplitude.
#block()

As we can see from @fig:overlay_berkley_fusion, the impedance and admittance transformations are related by 180° rotation and mirror symmetry. This means that for every point on the impedance smith chart, there is a corresponding point on the admittance smith chart that is rotated by 180° and mirrored across the real axis.
#grid(columns: 2, gutter: 1em, [
#figure(
  image("part2_diagrams/Wikipedia/berkley_fusion.png", width: 80%),
  caption: [Overlay of both admitance and impedance transforms on the Smith chart @niknejad_smith_chart],
)<fig:overlay_berkley_fusion>],[#figure(
  image("part2_diagrams/CERN/mirror conversion.png", width:80%),
  caption: [Equivalent admitance on the impedance Smith chart @caspers_smith_chart],
)<fig:mirror_conversion>],)
#block()


$ Gamma_z (0) = (z_L - 1) / (z_L + 1) " " stretch(<=>)^"Mirror Symmetry"_"180° Chart Rotation" " " Gamma_y (0) = - (y_L - 1) / (y_L + 1) = - Gamma_z (0) $
#block()
Though, using 2 fused charts is not very practical, so we will be working in the impedance smith chart only, and convert to admittance when needed by using the mirror symmetry and 180° rotation as we can see in @fig:mirror_conversion.

#block()
Different components have different representations on the smith chart, as we can see in @fig:complex_components. Inductors and capacitors will move the point along the constant resistance circles, while resistors will move the point along the constant reactance circles.
#grid(columns: 2, gutter: 1em, align: center+horizon, [
  We can summarize the behavior of the different components on the smith chart as follows :
  $ "Base Elements :" cases(Z_"inductance" &= j omega L, Z_"capacitance" &= 1/(j omega C), Z_"resistance" &= R) $
  We can see that they follow the complex circles, and the resistance follows the central axis (not shown in the graph).
],[
#figure(
  image("part2_diagrams/CERN/Complex components.png", width: 80%),
  caption: [Complex components of reactive elements on the Smith chart @caspers_smith_chart],
)<fig:complex_components>])

#block()
When adding a transmission line of length $l$, we rotate the point on the smith chart by an angle of $2 beta l$, where $beta = (2 pi)/lambda$ is the phase constant of the line.

#block()
#figure(
  image("part2_diagrams/Wikipedia/Transmission Line.svg", width: 35%),
  caption: [Transmission line representation on the Smith chart],
)<fig:full_smith_chart>

#grid(columns: 2, align: bottom, gutter: 1em, [
#figure(
  image("part2_diagrams/Wikipedia/Smith Diagram_line_rotation.svg", width: 100%),
  caption: [Arbitrary line length movement on the Smith chart],

)<fig:line_length_movement>],[#figure(
  image("part2_diagrams/Wikipedia/Smith Diagram_constant_reflection.svg", width: 100%),
  caption: [Constant reflection coefficient circles on the Smith chart],
)<fig:constant_reflection_rings>],)

#block()
Moving through a transmission line of length $l$ causes a rotation on the smith chart, which can be clockwise or counter-clockwise depending on the direction of the line (towards the generator or towards the load). This rotation is given by :
$ "Transmission Line Rotation :" cases(arrow.cw theta_"to gen" &= 2 beta l , arrow.ccw theta_"to load" &= 2 beta l) $
$ Gamma(x) = Gamma(0) e^(2j beta x) = Gamma(0) e^(j theta) $
#block()
These expressions represent the rotation in a ring of constant reflection coefficient magnitude (such as those from @fig:constant_reflection_rings). This also gives a bit more information on the conditions to match a line, as we are searching for a way to make the reflection at $|Gamma_"in"(0)| = 0$.

#block()

#grid(columns: 2, gutter: 1em, [
#figure(
  image("part2_diagrams/Wikipedia/Smith Diagram_different_lines.svg", width: 80%),
  caption: [Arbitrary rotation circles of lines with different characteristic impedances $Z_c = 2Z_0$],
)<fig:arbitrary_rotation_circles>],[
#figure(
  image("part2_diagrams/Wikipedia/Smith Diagram_equivalent_stubs.svg", width: 80%),
  caption: [Equivalent circles for a line and series stub of unknown length, in impedance and admittance forms],
)<fig:equivalent_stubs>],)
#block()
In a little bit more detail, we can also consider lines with different characteristic impedances $Z_c$. In this case, the circles of constant reflection coefficient will have different centers, as we can see in @fig:arbitrary_rotation_circles. This is useful when considering stubs or other elements that have a different characteristic impedance than the main line.

 Also, as we will have to work with series or parallel stubs, we can also consider their equivalent circles on the smith chart, as we can see in @fig:equivalent_stubs. But as we are working in the impedance smith chart, we will have to convert the admittance stubs to impedance stubs through the mirror symmetry and 180° rotation method explained earlier. BUT their complex variation (stub is complex), will still be a circle on the right side of the smith chart.

#note_block(block_colors.extra)[
  A Smith chart can also be used to represent other parameters, such as the admittance, reflection coefficient, and standing wave ratio (SWR). This makes it a versatile tool for analyzing and designing transmission line systems. It is widely used in RF engineering, antenna design, and microwave circuit design.
]

= Resolving Exercises with Transmission Lines

== Tricks and Tips to solve Exercises
#todo_block()

#pagebreak()
= Additional Resources
== Variables and Constants

#todo_block()
- Speed of light in vacuum, $c = 3 times 10^8 m/s$
- Permittivity of free space, $epsilon_0 = 8.854 times$
- Admittance of free space, $Y_0 = sqrt(epsilon_0/mu_0) = 1/377 S$


== Mathematical bases
=== Complex Numbers
Complex numbers are a subset of quaternions with no j or k component. They can be represented in rectangular form as $z = x + i y$ or in polar form as $z = r e^{i theta}$, where $r = sqrt(x^2 + y^2)$ and $theta = arctan(y/x)$. The exponential form is particularly useful for multiplication and division of complex numbers.

#block()
They have the following properties:
- Addition: $z_1 + z_2 = (x_1 + x_2) + i (y_1 + y_2)$
- Multiplication: $z_1 z_2 = x_1 x_2 - y_1 y_2 + i (x_1 y_2 + y_1 x_2)$
- Division: $z_1 / z_2 = (x_1 x_2 + y_1 y_2)/(x_2^2 + y_2^2) + i (y_1 x_2 - x_1 y_2)/(x_2^2 + y_2^2) = (x_1 x_2 + y_1 y_2)/(z z^*) + i (y_1 x_2 - x_1 y_2)/(z z^*)$
- Power: $z^n = (x + i y)^n = |z|^n (cos(n arg(z)) + i sin(n arg(z)))$
- Square root: $sqrt(z) = sqrt(x + i y) = sqrt(|z|) (cos(arg(z)/2) + i sin(arg(z)/2))$
- Conjugate: $z^* = x - i y$
- Magnitude: $|z| = sqrt(x^2 + y^2) = sqrt(z z^*)$
- Phase: $arg(z) = arctan(y/x)$
- Complex scaling : $i z = -y + i x = |z| (cos(arg(z) + pi/2) + i sin(arg(z) + pi/2))$

#block()
Properties of the magnitude :
- $|z_1 z_2| = |z_1||z_2|$
- $|z_1 / z_2| = (|z_1|) / (|z_2|)$
- $|z^*| = |z|$
- $|z|^2 = z z^*$
- $|z_1 + z_2| <= |z_1| + |z_2|$ (Triangle inequality)
- $|z_1 - z_2| >= ||z_1| - |z_2||$ (Reverse triangle inequality)

=== Phasor Representation
The phasor representation (a.k.a. complex exponential form) is a powerful tool to represent complex signals based on their phase and magnitude.
$ z &= |z| e^(i arg(z)) \ &= |z| e^(i (omega t + phi)) \ &= |z| e^(i omega t) e^(i phi) \ &=|z| (cos(omega t + phi) + i sin(omega t + phi)) $

#block()
As we are working with exponentials, all its properties apply, such as:
- $e^(a+b) = e^a e^b$
- $e^(a-b) = e^a / e^b$
- $e^(a b) = (e^a)^b = (e^b)^a$
- $e^0 = 1$
- $e^(i pi/2) = i$
- $e^(i pi) = -1$ (Euler's identity)

#block()
Through this, we can obtain the following complex properties:
- $z_1 + z_2 = |z_1| e^(i arg(z_1)) + |z_2| e^(i arg(z_2))$
- $z_1 z_2 = |z_1||z_2| e^(i (arg(z_1) + arg(z_2)))$
- $z_1 / z_2 = ((|z_1|) / (|z_2|)) e^(i (arg(z_1) - arg(z_2)))$
- $z^n = |z|^n e^(i n arg(z))$
- $sqrt(z) = sqrt(|z|) e^((i arg(z))/2)$
- $z^* = |z| e^(-i arg(z))$
- $|z| = sqrt(z z^*)$
- $arg(z) = (1/i) ln(z/(|z|))$
- $i z = |z| e^(i (arg(z) + pi/2))$

#block()
With the representation of each trigonometric fuction as :
- $cos(x) = (e^(i x) + e^(-i x))/2$
- $sin(x) = (e^(i x) - e^(-i x))/(2 i)$
- $tan(x) = sin(x)/cos(x) = (e^(i x) - e^(-i x))/(i (e^(i x) + e^(-i x)))$
- $cosh(x) = (e^x + e^(-x))/2$
- $sinh(x) = (e^x - e^(-x))/2$
- $tanh(x) = sinh(x)/cosh(x) = (e^x - e^(-x))/(e^x + e^(-x))$

=== Solving Complex Quadratic Equations
To solve complex quadratic equations of the form $a z^2 + b z + c = 0$, we can use the quadratic formula:
$
a z^2 + b z + c = 0 \
z = (-b plus.minus sqrt(b^2 - 4 a c))/(2 a) $
Where the discriminant $D = b^2 - 4 a c$ can be complex. To compute the square root of a complex number, we can use its polar form:
$ sqrt(D) = sqrt(|D|) e^(i arg(D)/2) = sqrt(|D|) (cos(arg(D)/2) + i sin(arg(D)/2)) $

== Proofs
=== Admittance Form of the Transmission Line Equation
Starting from the impedance form of the transmission line equation:
$ Z_"eq" =Z_c (Z_L cos(beta L) + j Z_c sin(beta L))/(Z_c cos(beta L) + j Z_L sin(beta L)) $
We can convert it to admittance form by taking the reciprocal:
$ Y_"eq" &= 1/Z_"eq" \
&= 1/Z_c (Z_c cos(beta L) + j Z_L sin(beta L))/ (Z_L cos(beta L) + j Z_c sin(beta L)) dot ((Z_c Z_L)/(Z_c Z_L)) \
&= Y_c (1/Z_L cos(beta L) + j (1/Z_c) sin(beta L))/(1/Z_c cos(beta L) + j (1/Z_L) sin(beta L)) \
&= Y_c (Y_L cos(beta L) + j Y_c sin(beta L))/(Y_c cos(beta L) + j Y_L sin(beta L)) $

#bibliography("references_part2.bib", full:true, style: "ieee")
