#import "../../templates/template_syth_gen1.typ": conf, note_block, block_colors, todo_block, def_block
#show: conf.with(
  title: [
    Part 2 - Physics of semiconductor devices and components
  ],
  course: "LELEC1755",
  authors: (
     (name: "Victor Carballes", affiliation: "UCLouvain"),
   ),
  abstract: [
    This document covers the fundamental physics of semiconductor devices and components, including diodes, bipolar junction transistors (BJTs), and MOSFETs. It explores their operation principles, characteristics, and applications in electronic circuits.\ #box(move(dy: 0.4em, [ Source code here : #text(fill: color.aqua.darken(20%))[#link("https://github.com/vctrcc/personal-typst-archive")]]))
  ],
)
= Introduction
This course focuses on the understanding of the physics of electrons and holes in semiconductors, and how this knowledge can be applied to analyze and design semiconductor devices such as diodes and transistors. This part of the course is very similar to "part1.1 - Materials", but it has different notations, and focuses more on current equations, and some quantum physics relations. For example, the generation and recombination of electron-hole pairs is expressed in the equations we will use, but they have a much more difficult physical meaning to grasp behind.

#note_block(block_colors.warning)[
  For the exam, *DO NOT UNDERESTIMATE THE QUANTITY OF MATERIAL COVERED*, the amount of information is absolutely massive, and often requires multiple days to fully repass ! So it is absolutely *recommended that you do your own summaries*, and use the "Feuilles de Route" to help out seeking the information from the slides and notes.
]

For more information, see the following related courses:
- LELEC2330 - Opto-electronics and power devices
- LELEC2532 - Design and architecture of analog electronic systems
- LELEC2570 - Synthesis of digital integrated circuits
- LELEC2650 - Synthesis of analog integrated circuits
- LELEC2541 - Advanced transistors
- LELEC2580 - Design of RF and microwave communications circuits
- LELEC2895 - Design of micro- and nano-systems
- LELEC2560 - Micro and nanofabrication techniques
- LELEC2710 - Nanoelectronics

#note_block(block_colors.trick)[
  Don't forget to at the very least read the course notes ! They are very well written, and go into extensive detail about the physical meaning of the equations we will use in this part of the course.
]

= Theory
//// ------------------------------------------------------------------------------------------------
== Semiconductor Basics // NEW SECTION
#note_block(block_colors.warning)[
  The slides contain a bunch of info ! Don't forget to at the very least read them all once, as they contain a lot of physical explanations that are not in the notes.
]
=== Conduction in semiconductors
==== Basics of conduction and materials
The conduction in any solid is the movement of charges or carriers within the material following an electric field.

In semiconductors, the conduction will be described by 2 types of carriers :#footnote($q=1.602 times 10^-19 " [C]"$)
$ cases(
  "Electrons" &minus.o : e^- -> Q=-q,
  "Holes" &plus.o : h^+ -> Q=+q,
) $#block()
The movement of these carriers is called, *Current*, and is expressed in Ampere ($"A"$). The current density ($J$) is the current per unit area ($A/m^2$). This current is created when the carriers are moved by an electric field ($E$) through a process called *drift*. Though, carriers can also move from a region of high concentration to a region of low concentration, through a process called *diffusion*.

#block()
These charges are found in any material, and comme from the atoms that compose the material. They are defined in 3 categories :
- *Conductors* : Materials with a high number of free carriers, allowing the conduction of electricity. (e.g. Copper, Silver, Gold)
- *Insulators* : Materials with a very low number of free carriers, preventing the conduction of electricity. (e.g. Glass, Rubber, Air)
- *Semiconductors* : Materials with a number of free carriers between conductors and insulators, allowing the conduction of electricity under certain conditions. (e.g. Silicon, Germanium, Gallium Arsenide)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: center,
    stroke: 0.5pt,
    // Headers
    [], [*Conductor*],[*Insulator*],[*Semiconductor*],
    // Dielectric and electrostatic properties
    [Examples], [Copper, Silver, Gold],[Glass, Rubber, Air],[Silicon, Germanium, Gallium Arsenide],
    [Free carrier concentration $rho/q$], [High\ ($10^22 "cm"^(-3)$)],[Very low\ ($10^0 "cm"^(-3)$)],[Moderate\ ($10^10 ~ 10^18 "cm"^(-3)$)],
    [Electrical conductivity $sigma$], [High\ ($10^7 S/m$)],[Very low\ ($10^(-10) S/m$)],[Moderate\ ($10^(-6) ~ 10^3 S/m$)],
    [Permitivity $epsilon$], [Approximately $epsilon_0$],[Approximately $epsilon_0$],[Varies, typically a few times $epsilon_0$],
  ),
  caption: "Electrostatic properties of different materials",
)#block()

When a semiconductor is pure, it is called an *intrinsic semiconductor*. In this state, the *number of electrons ($n$)* is equal to the *number of holes ($p$)*. We classify such materials of having a valence of 4 (IV).

#figure(
  image("part3_diagrams/Silicon_doping_-_Type_P_and_N.svg.png", width: 80%),
  caption: [Atomic representation of doping in semiconductors @WikipediaDoping],
)#block()

To increase the number of carriers in a semiconductor, we can add impurities to the material, through a process called *doping*. Depending on the type of impurity added, we can create either an *n-type* or *p-type* semiconductor :
- *n-type* : Adding impurities that provide *extra electrons* to the material, increasing the number of electrons ($n > p$).
- *p-type* : Adding impurities that create *holes* in the material, increasing the number of holes ($p > n$).
#block()
#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    align: center,
    stroke: 0.5pt,
    [Valence III\ #text(size: 8pt)[(p-type, holes)]], [Valence IV], [Valence V\ #text(size: 8pt)[(n-type, electrons)]],
    [Boron (B)\ Gallium (Ga)\ Alluminium (Al)\ Indiium (In)],
    [Silicon (Si)\ Germanium (Ge)\ Silicon Carbide (SiC)\ Gallium Arsenide (GaAs)\ Silicon-on-Insulator (SOI)\ Indium Phosphide (InP)\ Gallium Nitride (GaN)],
    [Phosphorus (P)\ Arsenic (As)\ Antimony (Sb)\ Bismuth (Bi)],
  ),
  caption: "Valences and the examples of dopants for n-type and p-type semiconductors",
)#block()
The *conduction electrons* are the *free electrons in the conduction band*, while the *holes* are the *absence of electrons in the valence band*. The movement of these carriers is influenced by various factors, including temperature, electric fields, and doping levels.

==== Conduction currents in Semiconductors
In metals, conduction is the movement of the free electrons in the crystalline lattice of the metal. We can count about 1 free electron per atom in the metal, leading to a very high concentration of free electrons (about $10^22 "cm"^(-3)$).

At absolute zero (0 K), all the electrons in a metal occupy the lowest possible energy states, filling up the energy levels up to a certain point called the *Fermi level*. Allowing for a obstacle free travel of all carriers. As the temperature increases, some electrons gain enough thermal energy to move to higher energy states above the Fermi level, allowing them to contribute to electrical conduction, augmenting internal resistance.

At room temperature (about 300 K), the thermal energy is sufficient to excite a significant number of electrons above the Fermi level, resulting in a high density of free electrons available for conduction. This leads to the high electrical conductivity observed in metals at room temperature.

Under the effect of a electric field ($E$), these free electrons will accelerate in the opposite direction, increasing collisions with the metal lattice, and reaching a steady state average velocity called the *drift velocity* ($v_d$). The relation between the electric field and the drift velocity is given by the equation :
$ v_d = mu_n (-E) approx 10^5 " "[m/s]" " (20°C) $
Where $mu_n$ is the *electron mobility*, a measure of how easily electrons can move through the metal under the influence of an electric field.
#note_block(block_colors.note)[
  The mobility also varies with temperature, with a form of :
  $ mu_n (T) = mu_(n,0) (T/T_0)^(-1.5) $
  Where $m$ is a material-dependent exponent, typically ranging from 1.5 to 2.5 for metals.
]
#block()
The current density ($J$) in the metal can be expressed as :
$ J_n = n (-q) v_d = underbrace(q n mu_n, sigma) E = sigma (-V)/L $
$ rho = sigma^(-1) = 1.73 dot 10^(-5) " "[Omega m] " "(20°C) $
Where $q$ is the elementary charge, and $n$ is the free electron concentration. The term $sigma = q n mu_n$ is called the *electrical conductivity* of the metal, representing how well the metal can conduct electric current. The relation $J = sigma E$ is known as *Ohm's Law* in differential form, describing the linear relationship between current density and electric field in conductive materials.

The drift velocity ($v_d$) in a good conductor is generally much slower than its thermal velocity ($v_("th")$), which corresponds to the random thermal motion of electrons. Thermal velocity is typically of the order of $10^6 " "[m/s]$ at room temperature, whereas drift velocity is often around $10^(-4) " "[m/s]$ under typical electric fields. This means that while electrons move rapidly due to thermal energy, their net movement (current) under an electric field is much slower due to frequent collisions with the crystal lattice.

=== Energy and Band Structure in Semiconductors
==== Energy Bands
#figure(
  image("part3_diagrams/energy_bands.svg", width: 60%),
  caption: "Energy band structure in semiconductors",
)#block()
To create free carriers in a semiconductor, we need to provide enough energy to the electrons to move them from the *valence band ($E_v$)* to the *conduction band ($E_c$)*. This energy can be provided through thermal excitation, photon absorption, or electrical injection. This energy gap between the valence band and conduction band is called the *bandgap energy ($E_g$)* (or interdiction band energy). *Thermal energy* is the energy that carriers gain from the thermal agitation of the atoms in the material, which can help them overcome the bandgap energy and become free carriers.
#block()
$ "Average thermal energy per carrier :"& E_T = k T " [J] "\
"Thermal voltage :"& phi.alt_T = (k T)/q = 0.026 (T/300) " [V]" (T_0=300K) $

#note_block(block_colors.note)[
  Einsteins relation between diffusion and mobility :
  $ cases(delim: "|", D_n = mu_n phi.alt_T, D_p = mu_p phi.alt_T) --> cases(delim: "|", D_n/mu_n = (k T)/q = phi.alt_T, D_p/mu_p = (k T)/q = phi.alt_T) $

  Where the diffusion coefficient ($D$) represents how easily carriers can diffuse through the material, and is related to the mobility ($mu$) and thermal voltage ($phi.alt_T$).
]

Where $k$ is the Boltzmann constant, $T$ is the absolute temperature in Kelvin, and $q$ is the elementary charge.

$ "Bandgap energy :" E_g &= E_c - E_v = cases(
  "Si" &: 1.124 &" [eV] ",
  "Ge" &: 0.67 &" [eV] ",
) " ("T_0=300K")" \
"Bandgap voltage :" V_g &= E_g/q " [V]" (T_0=300K) $#block()

==== Interaction of light with semiconductors
Through light emission and absorption, we can see that the bandgap energy is directly linked to the wavelength of light absorbed/emitted by the semiconductor. This is the principle behind LEDs and photodetectors.
#block()
$ E_"photon" = h nu= (h c)/lambda  -->  E_g = (h c)/lambda_"cutoff" approx 1240/lambda_("cutoff", "nm") " [eV]" $

Where $h$ is Planck's constant, $nu$ is the frequency of the light, $c$ is the speed of light, and $lambda$ is the wavelength of the light.

==== Generation and Recombination of Carriers
A rise of free carriers through 2 main processes :
- *Thermal Generation ($phi.alt_T$)* : Higher release of free carriers due to temperature increase.
- *Drop of bandgap energy ($E_g$)* : Some materials have a lower bandgap energy, making it easier for electrons to be excited to the conduction band.
#block()

Even if there is a momentary release of free carriers, they will eventually recombine back to their original state, releasing energy in the form of heat or light. This process is called *recombination (R)*. This metric is directly linked to the quantity of free carriers in the material, as more free carriers will lead to a higher recombination rate.
#block()
$ R = r n p $
Where $r$ is the recombination coefficient, dependent on the material and temperature. At equilibrium, the *generation and recombination rates are equal, leading to a steady-state concentration of free carriers in the material.*
$ G= G_i = R_i = r n_i p_i = r n_i^2 $

From here, we can set 2 important hypotheses :
- *At "normal" temperatures and usual doping levels, all impurities are ionised* : This means that all the dopant atoms have either donated or accepted electrons, contributing to the free carrier concentration in the semiconductor.
  - We can then directly control the number of free carriers by adjusting the doping concentration.
- *The semiconductor is non-degenerate* : This means that the Fermi level is not too close to the conduction or valence band edges, allowing us to use classical statistics (Boltzmann statistics) to describe the carrier distribution in the semiconductor.
  - This allows us to use simpler equations to describe the carrier concentrations and their behavior in the semiconductor.

#note_block(block_colors.extra)[
  To calculate the carrier concentrations in a semiconductor, we use the *effective density of states* in the conduction band ($N_c$) and valence band ($N_v$). These values represent the number of available energy states for electrons and holes, respectively, and depend on the material properties and temperature.
  #block()
  $ N_c &= 2 ( (2 pi m_n^* k T)/(h^2) )^(3/2) approx cases(
    "Si" &: 2.8 times 10^19 & ["cm"^(-3)] ,
    "Ge" &: 1.04 times 10^19 & ["cm"^(-3)] ,
  )  " ("T_0=300K")" \
  N_v &= 2 ((2 pi m_n^* k T)/h^2)^(3/2) approx cases(
    "Si" &: 1.04 times 10^19 & ["cm"^(-3)] ,
    "Ge" &: 6.0 times 10^18 & ["cm"^(-3)] ,
  )  " ("T_0=300K")" $#block()
  Where $m_n^*$ and $m_p^*$ are the effective masses of electrons and holes, respectively, and $h$ is Planck's constant.

  From here, we can calculate the *intrinsic carrier concentration ($n_i$)*, which represents the number of free electrons and holes in a pure semiconductor at thermal equilibrium. It is given by the equation :
  $ n_i (T) &= sqrt(N_c (T) N_v (T)) e^(-E_g/(2 k T))\
          &= A . T^(3/2) e^(-E_g/(2 k T)) $
  $ A= 2((2pi k)/h^2)^(3/2) (m_n^* m_p^*)^(3/4) $
  Where $A$ is a material-dependent constant.

  Then, to get the electron and hole concentrations in an intrinsic semiconductor, we use the following relations :
  $ n_0 = p_0 = n_i $
  $ n_0 &= N_c e^((E_F - E_c)/(k T)) = n_i e^((E_F - E_i)/(k T)) = n_i e^(-phi.alt_F/phi.alt_T)\
  p_0 &= N_v e^((E_v - E_F)/(k T)) = n_i e^((E_i - E_F)/(k T)) = n_i e^(phi.alt_F/phi.alt_T) $

]
As to not go too deep, we will just use the intrinsic carrier concentration values at room temperature (300 K) for Silicon and Germanium.
$ n_i = cases(
  n_(i,"Si", 300K) &approx 1.38 times 10^10 &" "["cm"^(-3)] ,
  n_(i,"Ge", 300K) &approx 2.4 times 10^10 &" "["cm"^(-3)] ,
) $
Where if we want a temperature dependence, we can use the following approximation :
$ n_i (T) = n_i (T_0) . (T/T_0)^(1.5) e^((E_g (T_0)-E_g (T))/(2 k T)) = n_i (T_0) . (T/T_0)^(1.5) e^(- V_g/(2 phi.alt_(T_0)) (T_0/T -1)) $

At equilibrium, the product of the electron and hole concentrations is constant, given by the equation :
$ n_0 p_0 = n_i^2 $
#block()

==== Quantum, Fermi-Dirac and Density of States
From Schrödinger's equations, we can derive allowed and forbidden energy levels for electrons in a crystal lattice. The allowed energy levels form *energy bands*, while the forbidden energy levels form *bandgaps*. The distribution of electrons in these energy bands is described by the *Fermi-Dirac distribution function ($f_F(E)$)*, which gives the probability that an energy state at energy $E$ is occupied by an electron at thermal equilibrium.
#block()

We define bandgap energy ($E_g$) as the difference between the valence band ($E_v$, filled with electrons) and the conduction band ($E_c$, empty of electrons) :
$ E_g = E_c - E_v $

As quantum electron motion in a band is curved ($E(k)$), we will have to use a effective mass of that particle (Fermion) instead of the real mass of the electron ($m_0$) :
$ m^* = planck^2 / (dif^2 E)/(dif k^2) $

The density of states ($g(E)$) represents the number of available energy states per unit volume and per unit energy range at a given energy level $E$. It is given by the equation :
$ g(E) = cases(
  "Conduction band" &: N_C = (1/(2 pi^2)) (2 m_n^* /planck^2)^(3/2) sqrt(E - E_c) & " [J"^(-1) "m"^(-3)] ,
  "Valence band" &: N_V = (1/(2 pi^2)) (2 m_p^* /planck^2)^(3/2) sqrt(E_v - E) & " [J"^(-1) "m"^(-3)] ,
) $

Fermi-Dirac depending on temperature :
$ f(E) = 1/(1+e^((E - E_F)/(k T))) $

Where the Fermi level $E_F$ tells us :
- If $E > E_F$ : Low probability of occupation (mostly empty states)
- If $E < E_F$ : High probability of occupation (mostly filled states)
- How many holes occur in the conduction band
- How many holes occur in the valence band
- Where carriers diffuse

The carrier concentrations can be calculated by integrating the product of the density of states and the Fermi-Dirac distribution function over the respective energy bands :
$ "Conduction Band :" n=N_C e^(-(E_C - E_F)/k_T)$
$ "Valence Band :" p=N_V e^(-(E_F - E_V)/k_T)$
Where $N_C$ and $N_V$ are the effective density of states in the conduction and valence bands, respectively.
#block()

On the subject of doping, we can define the *Fermi level shift ($phi.alt_F$)* as the difference between the intrinsic Fermi level ($E_i$) and the actual Fermi level ($E_F$) in a doped semiconductor :
$ "N-Type : " E_F approx E_C -k T ln (N_C/N_D) $
$ "P-Type : " E_F approx E_V +k T ln (N_V/N_A) $
Where $N_D$ is the donor concentration for n-type semiconductors, and $N_A$ is the acceptor concentration for p-type semiconductors.
#block()
Through this, we can calculate the intrinsic Fermi level ($E_i$) as follows :
$ E_i = (E_C + E_V)/2 + (3/4) k T ln (m_p^* /m_n^*) $
And the Fermi level shift ($phi.alt_F$) as pseudo-fermi levels :
$ phi.alt_(F N) &= (k T)/q ln (n_0 / n_i) = (k T)/q ln (N_D / n_i) " "("n-type") \
phi.alt_(F P) &= -(k T)/q ln (p_0 / n_i) = -(k T)/q ln (N_A / n_i) " "("p-type") $
Where, we can correct to the actual Fermi level :
$ E_F = E_i + q phi.alt_(F N) = E_i + k T ln(N_D/n_i) $
$ E_F = E_i + q phi.alt_(F P) = E_i - k T ln(N_A/n_i) $

#block()
From here, we can calculate the electron and hole concentrations in a doped semiconductor using the following relations :
$ n_0 = N_C e^((E_F - E_C)/(k T)) = n_i e^((E_F - E_i)/(k T)) = n_i e^(-phi.alt_F/phi.alt_T)\
p_0 = N_V e^((E_V - E_F)/(k T)) = n_i e^((E_i - E_F)/(k T)) = n_i e^(phi.alt_F/phi.alt_T) $
Where $n_i$ is the intrinsic carrier concentration.
#block()

When dealing with non-equilibrium conditions, such as under illumination or electrical injection, we can define the *quasi-Fermi levels* for electrons ($E_"Fn"$) and holes ($E_"Fp"$) to describe the carrier distributions separately. The quasi-Fermi levels represent the effective energy levels for electrons and holes under non-equilibrium conditions.
$ n = N_C e^(-(E_C - E_"Fn")/(k T)) $
$ p = N_V e^(-(E_"Fp" - E_V)/(k T)) $
Where $E_"Fn"$ and $E_"Fp"$ are the quasi-Fermi levels for electrons and holes, respectively.
#block()

At equilibrium, the quasi-Fermi levels for electrons and holes are equal to the Fermi level ($E_F$) :
$ E_"Fn" = E_F = E_"Fp" $
The difference between band edges gives the built-in potential ($V_"bi"$) in a PN junction :
$ V_"bi" = (E_"Fn" - E_"Fp")/q $
This is entirely due to Fermi-Dirac statistics and the difference in doping levels creating diffusion currents due to Fermi level differences.

=== Doping, majority and minority carriers
At equilibrium, and room temperature, we can consider that all dopants are ionised. This means that the doping concentration is much higher than the intrinsic carrier concentration :
- *n-type* : $ n_(n 0) approx N_D " and " p_(n 0) = n_i^2 / n_(n 0) = n_i^2 / N_D << n_(n 0) $
- *p-type* : $ p_(p 0) approx N_A " and " n_(p 0) = n_i^2 / p_(p 0) = n_i^2 / N_A  << p_(p 0) $
Since a majority carrier density of the order of $10^17 " "["cm"^(-3)]$ corresponds to a minority carrier density of the order of $10^3 " "["cm"^(-3)]$.

We can therefore *neglect the effects of minority carrier variations on the majority carriers* thanks to this gap of 14 orders of magnitude.
#block()

Typically, in a *homogeneously* doped semiconductor, the concentrations of mobile charges are equal to the concentration of doping atoms. This means that the conductivity ($sigma$) can be approximated as :
$ sigma = q ( n mu_n + p mu_p ) approx cases(
  "n-type" &: q N_D mu_n ,
  "p-type" &: q N_A mu_p ,
) $
Where $mu_n$ and $mu_p$ are the mobilities of electrons and holes, respectively. (Assuming the dopant concentration is much higher than the intrinsic carrier concentration)

We can also verify that the overall charge neutrality is maintained in the semiconductor :
$ p - n - N_A + N_D = 0 $

=== Effect of Voltage
// ADD FIGURE
When a voltage ($V$) is applied across a semiconductor of length ($L$), it creates an electric field ($E$) given by :
$ E = - (V/L) $

We describe the excess of carriers created by this voltage as :
$ delta n = n - n_0 $
$ delta p = p - p_0 $
Where $n_0$ and $p_0$ are the equilibrium concentrations of electrons and holes, respectively.

Through the fermi level shift created by the voltage, we can express the new carrier concentrations as :
$ n = n_i e^((E_"Fn" - E_i)/(k T)) = n_0 e^(q V/(k T)) = n_0 e^(V/phi.alt_T) $
$ p = n_i e^((E_i - E_"Fp")/(k T)) = p_0 e^(-q V/(k T)) = p_0 e^(-V/phi.alt_T) $
Where $E_"Fn"$ and $E_"Fp"$ are the quasi-Fermi levels for electrons and holes, respectively.
#block()
We can also express them fully as :
$ n &= n_0 + delta n = n_i e^((phi.alt_(F N) + V)/phi.alt_T) = n_i e^((phi.alt_T*ln(n_0/n_i) + V)/phi.alt_T)\
p &= p_0 + delta p = n_i e^(-(phi.alt_(F P) + V)/phi.alt_T) = n_i e^((phi.alt_T*ln(p_0/n_i) - V)/phi.alt_T) $

=== Charge and Electric Field in Semiconductors
In a doped semiconductor, the charge density ($rho$) is determined by the concentrations of electrons and holes, as well as the ionized dopant atoms. The charge density can be expressed as :
$ rho(x) = q (p(x) - n(x) - N_A + N_D) $

// ADD FIGURE

We define the electric field ($E$) in the semiconductor using Gauss's law, which relates the electric field to the charge density :
$ (dif E)/(dif x) = rho/epsilon_s --> E(x) = 1/epsilon_s integral^x rho(x) dif x $
Where $epsilon_s$ is the permittivity of the semiconductor material.
$ epsilon_s = 1 " "["pF"/"cm"] " "("Si, 300K") $

// ADD FIGURE

Voltage is then obtained by integrating the electric field over the length of the semiconductor :
$ phi.alt (x) = - integral_0^L E(x) dif x $

// ADD FIGURE


=== Drift and Diffusion Currents
#figure(
  image("part3_diagrams/flow of things in doped semiconductors.svg", width: 60%),
  caption: "Flow of electrons and holes in n-type and p-type semiconductors",
)
==== Diffusion Currents (Due to concentration gradients)
// ADD FIGURE (Non Homogeneous doping, and the direction of carriers, leading to diffusion currents 2 diagrams)
There requires 2 things for diffusion of carriers to occur :
- A concentration gradient ($dif n/dif x$ or $dif p/dif x$)
- Random thermal motion of carriers (temperature > 0 K)

The movement of the charges will be inverse to the concentration gradient ($- (dif n/dif x)$ or $- (dif p/dif x)$), as they move from high concentration to low concentration regions.

This charge movement creates a diffusion current density ($J_"diffusion"$) given by :
$
cases(J_(n,"diffusion") &= -&q D_n (-(dif n)/(dif x)) = &q D_n (dif n)/(dif x) ,
  J_(p,"diffusion") &= &q D_p (-(dif p)/(dif x)) = -&q D_p (dif p)/(dif x)) $

$ J_"diffusion" = J_(n,"diffusion") + J_(p,"diffusion") = q(D_n (dif n)/(dif x) - D_p (dif p)/(dif x)) $

Where $D_n$ and $D_p$ are the diffusion coefficients for electrons and holes, respectively. They represent how easily carriers can diffuse through the material.
#block()

Einstein's relation links the diffusion coefficients to the mobilities (due to probabilistic link of both phenomena) :
$ D_n/mu_n = D_p/mu_p = (k T)/q = phi.alt_T $
From this relation, we can re-express the diffusion current density as :
$ cases(
  J_(n,"diffusion") &= q mu_n (phi.alt_T (dif n)/(dif x)) ,
  J_(p,"diffusion") &= -q mu_p (phi.alt_T (dif p)/(dif x))
)
$

#note_block(block_colors.note)[
  Don't forget that $mu_n$ and $mu_p$ are the mobilities of electrons and holes, respectively, which describe how easily carriers can move through the material under the influence of an electric field.
]
// ADD FIGURE (exponential decay of excess carriers)
We can also define the *diffusion length ($L_D$)* as the average distance a carrier can diffuse before recombining. It is given by the equation :
$ L_D = sqrt(D tau) $
Where $D$ is the diffusion coefficient and $tau$ is the carrier lifetime. Also understood as the average time a carrier exists before recombining.
#block()
We can define the excess carrier concentration ($delta n$ or $delta p$) as the difference between the actual carrier concentration and the equilibrium carrier concentration :
$ delta n = n_0 e^(-x/L_D)$

==== Drift Currents (Due to forces)
#figure(
  image("part3_diagrams/flow of things in doped semiconductors.svg", width: 60%),
  caption: "Flow of electrons and holes in n-type and p-type semiconductors",
)
#block()
When an electric field ($E$) is applied to a semiconductor, it exerts a force on the charge carriers (electrons and holes), causing them to move in the direction of the field. This movement creates a drift current density ($J_"drift"$) given by :
$ J_"drift" &= J_(n,"drift") + J_(p,"drift")\
&=underbrace(q (n mu_n + p mu_p), sigma) E $
Where $mu_n$ and $mu_p$ are the mobilities of electrons and holes, respectively.

==== Total Currents
// Diagram of a non-homogeneously doped semiconductor with both diffusion and drift currents, and all the rest
We define the total current density ($J$) in the semiconductor as the sum of the drift and diffusion current densities :
$ J &= J_n + J_p = J_"drift" + J_"diffusion" $

$ cases(
  J_n &= q mu_n (n(x) (dif V)/(dif x) + phi.alt_T (dif n)/(dif x)) ,
  J_p &= q mu_p (p(x) (dif V)/(dif x) - phi.alt_T (dif p)/(dif x)) ,
) $

We also note that the mobility of N-type semiconductors is about 3 times higher than that of P-type semiconductors, due to the difference in effective mass between electrons and holes.
$ mu_n approx 3 mu_p $
With a dependence on temperature and doping concentration.
$mu = mu_0 (T/T_0)^(-1.5)$

==== Continuity Equation
The continuity equation describes the conservation of charge in a semiconductor. It relates the time rate of change of the carrier concentration to the divergence of the current density and the generation-recombination processes. The continuity equations for electrons and holes are given by :
$ (dif n)/(dif t) = (1/q) (dif J_n)/(dif x) + G(x) - U_n(x) $
$ (dif p)/(dif t) = -(1/q) (dif J_p)/(dif x) + G(x) - U_p(x) $
Where $G(x)$ is the generation rate of carriers, and $U(x)$ is the recombination rate of carriers.

Also, the recombination rate can be expressed as :
$ U_n = (n(x) - n_0)/tau_n $
$ U_p = (p(x) - p_0)/tau_p $
Where $tau_n$ and $tau_p$ are the lifetimes of electrons and holes, respectively.

#todo_block()

=== Hall Effect
This effect depends fully on the Lorentz force (magnetic component):
$ arrow(F) = Q " " arrow(v) times arrow(B) $
When a current-carrying conductor or semiconductor is placed in a magnetic field perpendicular to the current flow, the charge carriers (electrons and holes) experience a force due to the magnetic field. This force causes the charge carriers to accumulate on one side of the material, creating a voltage difference across the material, known as the Hall voltage ($V_H$).

The consumed current is as follows :
$ I = arrow(J_n) dot hat(S) = q n mu_n arrow(E) dot hat(S) $

The Hall voltage can be expressed as :
$ arrow(E) = arrow(E_parallel) + arrow(E_perp) $
$ arrow(E_perp) = arrow(B) times arrow(v) = - 1/(q n) (arrow(B) times arrow(J_n)) = -mu_n (arrow(B) times arrow(E_parallel)) $
$ V_H = - arrow(l) dot arrow(E_perp) $

#note_block(block_colors.extra)[#text(size: 9pt)[
  When separating particles by weight from a ion cannon, to know the composistion of certain elements, the Lorentz force is used to deviate the particles depending on their mass/charge ratio. This is called a mass spectrometer.
  Also, old tv screens (the ones that would hiss, and shock you) used this effect to direct the electron beam to the right spot on the screen, turning on phosphors to create an image.
]]

#note_block(block_colors.extra)[
  #text(size: 9pt)[
  These days, another type of device is slowly emerging, called TMR's (Tunnel Magneto-Resistive devices). These devices use the spin of the electrons to create a resistance change when a magnetic field is applied. This effect is called Tunnel Magneto-Resistance (TMR) and is used in some modern magnetic sensors and memory devices for better precision and lower power consumption.
]]

=== Weird setups and physical phenomena
==== Biasing a semiconductor device
#todo_block()
==== Gradients without bias
If a meterial is not connected to any conductor, then, even if there is a concentration gradient, there will be no current flow. This means, that the diffusion current will be exactly balanced by the drift current created by the built-in electric field. In this case, then, charges are moved to one side, creating a permanent external electric field.
#block()
For example, if we take parafin wax, and pour it melted into a mold, and apply a massive electic field while it cools down, the mobile charges will move to one side, creating a permanent electric field in the material. This permanent charge allows you to then attract small pieces of paper, attract hair, stick to walls, etc. This is called a *ferroelectric* material.

==== Generation and recombination of carriers
#todo_block()

//// ------------------------------------------------------------------------------------------------
#pagebreak()
== Diodes and junctions (PN, PN+, Zener, Schottky, PIN, PNN+) // NEW SECTION
=== Introduction and structure of PN junctions
#figure(
  grid(
    columns: (1fr, 1fr),
    align: (right, left),
    inset: 3pt,
    image("part3_diagrams/Diode Diagram.svg", width: 40%),
    image("part3_diagrams/diode_material.svg", width: 60%)
  ),
  caption: "Structure of a PN junction",
)
We define the diode as a device that has a current in function of the voltage. It has 2 working modes :
- *Forward Bias* : When the voltage is applied in the direction that allows current to flow
- *Reverse Bias#footnote([or blocked for perfect diodes])* : When the voltage is applied in the direction that blocks current flow
#block()
The function is :
$ I = I_s ( e^( (q V) / ( k T ) ) - 1 ) $
Where $I_s$ is the saturation current, $q$ is the elementary charge, $V$ is the applied voltage, $k$ is the Boltzmann constant, and $T$ is the absolute temperature in Kelvin. At a negative voltage (reverse bias), the current is approximately equal to $-I_s$, which is a small leakage current. At a positive voltage (forward bias), the current increases exponentially with the applied voltage.

#block()
#note_block(block_colors.note)[
  For historical reasons, the PN junction is called "Jonction Métalurgique", as it was first created by joining two different types of semiconductors (P-type and N-type) together, similar to how metals are joined in metallurgy.
]#block()

We define the amount of doping on each side as :
$ N(x) = N_D (x) - N_A (x) $
Where $N(x_m)=0$ at the metallurgical junction ($x_m$).
#block()

For simplification reasons, we will *consider abrupt junctions*, where the doping concentration changes abruptly at the metallurgical junction. (When possible, things will get generalized later)

#note_block(block_colors.note)[
  In real-world applications, PN junctions are often created using techniques such as ion implantation or diffusion, which can lead to non-abrupt doping profiles. However, for the sake of simplicity and ease of analysis, we will focus on abrupt junctions in this course. (Or in some cases, the linear transition)
  #block()
  Also, real *diodes generally are asymmetric*, with one side being heavily doped (PN+) to create a strong electric field and a narrow depletion region, while the other side is lightly doped (PN) to allow for better control of the junction properties.
]

We can still accept 2 hypotheses : *all dopants are ionised*, and the *semiconductor is non-degenerate#footnote([Reminder, the semiconductor is non-degenerate means that the Fermi level is not too close to the conduction or valence band edges, allowing us to use classical statistics (Boltzmann statistics) to describe the carrier distribution in the semiconductor.])*. Since we are at ambient temperature, and usual doping levels. We can use Maxwell-Boltzmann statistics using the Fermi-Dirac approximation.
$ f(E) = 1/(1 + e^((E - E_F) / (k T))) stretch(->)^"Maxwell-Boltzmann" f_"MB" (E) = e^(-(E-E_F)/(k_B T)) " (valid when "e^((E-E_F)/(k_B T))>>1")" $

=== PN Junctions at Equilibrium (Contact potential)
In whichever state a crystal is in (homogenous or not), at equilibrium, the Fermi level is constant throughout the material. This means that when 2 different materials are joined together, the Fermi levels must align, leading to a built-in potential ($phi.alt_0$) across the junction.
#block()
Energies :
$ E_(F P) != E_(F N) --> E_(F N) - E_(F P) = q phi.alt_0 --> cases(
  E_(F N) = E_i + k T ln(N_D/n_i) ,
  E_(F P) = E_i - k T ln(N_A/n_i)
) $
Concentrations :
$ cases("N" : n_(n 0) = N_D " and " p_(n 0) = n_i^2 / N_D,
"P" : p_(p 0) = N_A " and " n_(p 0) = n_i^2 / N_A) stretch(->)^"Generalization" cases(
  n_0 &= n_i e^((E_F - E_i)/(k T)),
  p_0 &= n_i e^((E_i - E_F)/(k T))
) $
Internal potential :
$ phi.alt_0 = phi.alt_(F N) - phi.alt_(F P) = (E_(F N) - E_(F P))/q = (k T)/q ln((N_D N_A)/n_i^2) $
$ cases(delim: "|",
  phi.alt_("Si", 0) &in [600 ; 900] " [mV]",
  phi.alt_("Ge", 0) &in [300 ; 500] " [mV]"
) $

#align(center)[
  #block(
    inset: 20pt,
    outset: -5pt,
    fill: luma(240),
    radius: 10pt,
    [#figure(
      image("part3_diagrams/energy_junctions.png", width: 70%),
      caption: "Energy band diagram of a PN junction at equilibrium \n(3 zones in french: ZQN, ZD, ZQN)",
    )<fig:energy_junctions>]
  )
]
// ADD FIGURE (Depletion region diagram)
// ADD FIGURE (Energy band diagram at equilibrium)

This contact potential comes from the *strong gradient of carriers* near the junction, leading to diffusion currents that create a charge imbalance, and therefore an electric field that opposes further diffusion, linked to the local charge density. From Poisson's equation, we can derive the electric field and potential distribution across the junction :
$ (partial^2 phi.alt)/(partial x^2) (x) = - (partial E)/(partial x) (x)= -q/epsilon_s [p_0 (x) - n_0 (x) + N_D (x) - N_A (x)] $
$ phi.alt (x) = (E_F - E_i)/q --> (partial^2 E_i (x))/(partial x^2) = q^2/epsilon_s [p_0 (x) - n_0 (x) + N_D (x) - N_A (x)] $
Thi electric field ($E$) applies to all carriers a electrostatic force ($F = q E$) that opposes further diffusion, leading to equilibrium. This means that each carrier contains internal potential energy ($U = q phi.alt$) connected to the zone of spatial charges. This explains the curvature of the energy bands near the junction. This internal potential from the electric field is refered as $phi.alt (x)$.
#block()

We can compute the distribution of $phi.alt (x)$ using the free carrier concentrations at equilibrium :
$ cases(
  n_0 (x) &= n_i e^((E_F - E_(i 0))/(k T)) e^(q phi(x) / (k T)) ,
  p_0 (x) &= n_i e^(-(E_F - E_(i 0))/(k T)) e^(-q phi(x) / (k T)) ,
) stretch(->)^"Intrinsic Energy\nat phi(x)=0" cases(
  n_0 (x) = n_i e^((phi.alt (x))/phi.alt_T),
  p_0 (x) = n_i e^(-(phi.alt (x))/phi.alt_T)
) $
#block()

With non-homogenous doping, we can't use the crystalline contact potential argument, we will have to consider that the built-in potential ($phi.alt_0$) is the difference of potential between the 2 sides *far* from the junction :
$ phi.alt_0 = underbrace(phi.alt_(n 0), "far N") - underbrace(phi.alt_(p 0), "far P") $
In these far regions, the semiconductor is neutral and homogenous. Meaning, from the boundary conditions, we can compute the equilibrium carrier concentrations on each side of the junction as :

#grid(
  columns: (1fr, 1fr),
  align: center+horizon,
  inset: 7pt,
  [ P-Type ], [ N-Type ],
  [ $p_(p 0) = N_A = n_i e^(-(phi.alt_(p 0))/(phi.alt_T))$ ], [ $n_(n 0) = N_D = n_i e^((phi.alt_(n 0))/(phi.alt_T))$ ],
  [ $n_(p 0) = n_i^2 / N_A = n_i e^((phi.alt_(p 0))/(phi.alt_T))$ ], [ $p_(n 0) = n_i^2 / N_D = n_i e^(-(phi.alt_(n 0))/(phi.alt_T))$ ],
)

These relations can be combined to form the *Boltzmann relations* for the PN junction at equilibrium :
$ (p_(p 0))/(p_(n 0)) = (n_(n 0))/(n_(p 0)) = e^((phi.alt_(n 0) - phi.alt_(p 0)) / phi.alt_T) = e^(phi.alt_0 / phi.alt_T) $
From here, we can find the typical contact potential formula :
$ phi.alt_0 = (k T)/q ln((N_A N_D)/n_i^2) $

#block(
  width: 100%,
  grid(
    columns: (1fr, 2fr),
    align: center+horizon,
    gutter: 15pt,
    figure(
      image("part3_diagrams/PN_numerical_resolution.png", width: 110%),
      caption: [Computer simulation \ ($N_A = 3.10^16 ; N_D = 1.10^16 ; V=0$) ],
    ),
    align(left)[
      We can see that near the junction, the electrons and holes are much lower than the doping concentrations, due to the formation of the depletion region. Far from the junction, the carrier concentrations approach the doping levels, indicating that the semiconductor is neutral in these regions.\
      #block()
      We also see that *the total charge quantity is 0*, meaning, all positive and negative charges balance out. This is expected at equilibrium, as there is no net charge accumulation in the semiconductor.
      #block()
      The electric field is directed from N to P, in this case, the field is negative. We can also see a direct correlation between the energy diagram and the potential $phi.alt (x)$. $E_c = E_(c 0) - q phi.alt (x)$
      #block()
      Finally, the space charge density and eletric field are nul far enough from the junction (in the ZQN region), as expected. And the concentration of carriers stays constant (*Quazi Neutral Regions*).
    ]
))

#def_block(
  color: rgb("#cf53c9"),
  [#text(size: 13pt, weight: "bold", style: "normal")[Analytical modeling of a abrupt PN junction at equilibrium]

  The analytical solution is only possible through the simplification hypotheses.
  #block()
    #figure(
    image("part3_diagrams/PN analytical solution.png", width: 40%),
    caption: "Analytical solution of an abrupt PN junction at equilibrium",
  )
  #block()
  The spatial charge zone defines the *depletion region (Z.D.)*, where all *mobile carriers are depleted*, leaving only the fixed ionised dopants. Outside this region, we have the *Quasi Neutral Regions (Z.Q.N.)*, where the semiconductor is *neutral and homogenous*. This hypotese allows us to estimate the charge density as $q N_D "and" q N_A$.
  $ rho(x) = cases(
    "ZQN"&: -&infinity &< x < -&l_(p 0) &: &0 ,
    "ZD"&: -&l_(p 0) &< x < &0 &: -&q N_A ,
    "ZD"&: &0 &< x < &l_(n 0) &: +&q N_D ,
    "ZQN"&: &l_(n 0) &< x < +&infinity &: &0 ,
  ) $
  We can integrate the spatial charge density to find the electric field and potential distribution across the junction. Applying the boundary conditions (electric field is null in the Quasi Neutral Regions (Z.Q.N.)), we can find :
  $ E(x) = integral_(x_1)^(x_2) rho(x) dif x= cases(
    "ZQN"&: -&infinity &< x < -&l_(p 0) &: &0 ,
    "ZD"&: -&l_(p 0) &< x < &0 &: &q N_A / epsilon_s (x + &l_(p 0)) ,
    "ZD"&: &0 &< x < &l_(n 0) &: -&q N_D / epsilon_s (x - &l_(n 0)) ,
    "ZQN"&: &l_(n 0) &< x < +&infinity &: &0 ,
  ) $
  From here, we can integrate again to find the potential distribution :
  $ phi.alt (x) = - integral_(x_1)^(x_2) E(x) dif x = cases(
    "ZQN"&: -&infinity &< x < -&l_(p 0) &: &phi.alt_(p 0) ,
    "ZD"&: -&l_(p 0) &< x < &0 &: &phi.alt_(p 0) + q N_A / (2 epsilon_s) (x + &l_(p 0))^2 ,
    "ZD"&: &0 &< x < &l_(n 0) &: &phi.alt_(n 0) + q N_D / (2 epsilon_s) (&l_(n 0) - x)^2 ,
    "ZQN"&: &l_(n 0) &< x < +&infinity &: &phi.alt_(n 0) ,
  ) $
  Where the continuity of the fields and electrical potential is assured at $-l_(p 0)$ and $l_(n 0)$. As they are still unknown, we can aplly the boundary condition of the built-in potential :
  $ "Contact potential :" &phi.alt_0 = phi.alt_(n 0) - phi.alt_(p 0) = (q)/(2 epsilon_s) (N_A l_(p 0)^2 + N_D l_(n 0)^2)\
   "Charge preservation :" &N_A l_(p 0) = N_D l_(n 0) $
From here, we can find the depletion region widths on each side of the junction as :
  $ l_(p 0) = sqrt((2 epsilon_s phi.alt_0)/(q) (N_D)/(N_A (N_A + N_D))) "      "
  l_(n 0) = sqrt((2 epsilon_s phi.alt_0)/(q) (N_A)/(N_D (N_A + N_D))) $
  The total depletion zone (also called transition zone) is then :
  $ l_(p 0) + l_(n 0) = sqrt((2 epsilon_s phi.alt_0)/(q) ((N_A + N_D)/(N_A N_D))) $

  #note_block(block_colors.note)[
    The use of the 3 zone hypotese (Z.Q.N. and Z.D.), leads to a square distribution of the charge, a triangular distribution of the electric field, and a parabolic distribution of the potential in the depletion region. Outside of this region, potential and field are constant (0 field in Z.Q.N.). (Under the assumption of no applied voltage)
  ]

  A much higher doping leads to a shorter depletion region, and a stronger electric field. This is why one side of the junction is often heavily doped (PN+) to create a strong electric field and a narrow depletion region.#footnote([
    Typical values of asymetrical PN junctions are :\
    Concentrations : $cases(N_A = 10^18" "["cm"^(-3)],N_D = 10^16 " "["cm"^(-3)]) --> cases(
    l_(p 0) approx 3*10^-7 " [cm] ",
    l_(n 0) approx 3.27*10^-5 " [cm] "
    ) --> w = l_(n 0) + l_(p 0) = 3.3*10^-5 " [cm] "$
  ])
  #block()
  *Properties of the depletion region* :
  - As the total quantity of charge must be 0, the depletion widths are inversely proportional to the doping concentrations. $ q N_D l_(n 0) - q N_A l_(p 0) = 0 $

  - The maximum electric field ($E_"max"$) occurs at the metallurgical junction ($x=0$) and is given by :
  $ E_"max" = E(0) = - (q N_D l_(n 0))/(epsilon_s) = - (q N_A l_(p 0))/(epsilon_s) = - sqrt((2 q phi.alt_0)/(epsilon_s) (N_A N_D)/(N_A + N_D)) = - (2 phi.alt_0)/(l_(p 0) + l_(n 0)) $

  - Real junctions are asymetric, with the depletion region (Z.D.) situated mostly in the less doped side. The heaviest doped side will have little to no effect on the maximum field of the junction. And we can approximate the prevous equations as (for $N_A >> N_D$ $P^+ N$) :
  $ l_(p 0) approx sqrt((2 epsilon_s)/q (phi.alt_0 N_D)/(N_A^2)) << l_(n 0) approx sqrt((2 epsilon_s)/q (phi.alt_0)/(N_D)) --> l_(n 0) + l_(p 0) approx l_(n 0) $
  $ E_max = E(0) approx -sqrt((2 q)/(epsilon_s) phi.alt_0 N_D)=-(2 phi.alt_0)/l_(n 0) $

])

/// TODO rest of the document : Go over values, and get the values for both germanium and silicon (They must be known for the exam)

=== Biased PN Junctions (Forward and Reverse continuous voltage)
For a $V=0$, the diffusion currents are exactly balanced by the drift currents created by the built-in electric field.
#block()

#block([
  #block(text(size: 11pt, weight: "bold", style: "normal")[
    Forward Bias ($V >0$)
  ])
  - When applied, the barrier potential is lowered ($phi.alt_0 arrow.b$), reducing the intensity of the built-in electric field ($E arrow.b$). This leads to an *increase in the diffusion currents*, as more carriers can cross the junction (each in its own direction).

  #block()
  #block(text(size: 11pt, weight: "bold", style: "normal")[
    Reverse Bias ($V <0$)
  ])
  - When applied, the barrier potential is increased ($phi.alt_0 arrow.t$), increasing the intensity of the built-in electric field ($E arrow.t$). This leads to a *blockage of diffusion currents* and a *increase in drift currents*, as less carriers can cross the junction (each in its own direction). This leads to a *weak leakage current ($I_s$)* due to minority carriers, which stays more or less constant.
  #block()
  ]
)

#note_block(block_colors.note)[
  The resolution of the biased PN junction requires numerical methods, as the equations become non-linear and complex (3 coupled PDEs: Poisson, continuity for electrons and holes). However, we can still use the depletion approximation to estimate the depletion region width and electric field under bias conditions.

  Results of <fig:pn_voltage_bias> shows the results of the numerical simulation of a PN junction under different voltage biases. We can see how the depletion region width and electric field change with applied voltage.
]

#figure(
  image("part3_diagrams/PN juncntion voltage bias.png", width: 70%),
  caption: [Voltage Bias \ ($N_A = 3.10^16 ; N_D = 1.10^16 ; V=[-0.3, 0.5]V$) ],
)<fig:pn_voltage_bias>
#block()

==== Voltage distribution and depletion region
From the simulations done in <fig:pn_voltage_bias>, we can see that :
- When a voltage is applied, the carrier repartition changes slightly, we can see that there are 2 zones that don't really change (the Z.Q.N. regions), and a zone that changes a lot (the Z.D. region).
- The electric field ($E$) in the quasi neutral regions (Z.Q.N.) remains approximately zero.
#block()
From these observations, we can emit these 2 hypotheses :
#def_block(grid(columns: (1fr, 15fr), align: left + horizon,
[#text(size:13pt, weight: "bold", style:"normal")[H1.]],
[
  We consider 3 zones :
  - Quasi Neutral Regions (Z.Q.N.) on each side of the junction, where the semiconductor is neutral and homogenous.
  - Depletion Region (Z.D.) near the junction, where mobile carriers are depleted, leaving only fixed ionised dopants.
]))
#block()
#def_block(grid(columns: (1fr, 15fr), align: left + horizon,
[#text(size:13pt, weight: "bold", style:"normal")[H2.]],
[
  The applied voltage ($V$) is only applied at the edges of the depletion region (Z.D.), meaning the electric field ($E$) in the quasi neutral regions (Z.Q.N.) remains approximately zero.
]))

Let us solve for the voltage distribution and depletion region width under bias conditions using these hypoteses.
#def_block(
  color: rgb("#cf53c9"),
  [#text(size: 13pt, weight: "bold", style: "normal")[Analytical modeling of a abrupt PN junction with bias]

  The analytical solution is only possible through the simplification hypotheses.
  #block()
    #figure(
    image("part3_diagrams/PN_voltage_bias_graphing.png", width: 40%),
    caption: "Evalution of the analytical solution of an abrupt PN junction under bias",
  )
  #block()
  Following the same procedure as for the equilibrium case, we can define the spatial charge density in the depletion region (Z.D.) as :
  $ rho(x) = cases(
    "ZQN"&: -&infinity &< x < -&l_(p) &: &0 ,
    "ZD"&: -&l_(p) &< x < &0 &: -&q N_A ,
    "ZD"&: &0 &< x < &l_(n) &: +&q N_D ,
    "ZQN"&: &l_(n) &< x < +&infinity &: &0 ,
  ) $
  We can integrate the spatial charge density to find the electric field and potential distribution across the junction. Using H2, we can find :
  $ E(x) = integral_(x_1)^(x_2) rho(x) dif x= cases(
    "ZQN"&: -&infinity &< x < -&l_(p) &: &0 ,
    "ZD"&: -&l_(p) &< x < &0 &: &q N_A / epsilon_s (x + &l_(p)) ,
    "ZD"&: &0 &< x < &l_(n) &: -&q N_D / epsilon_s (x - &l_(n)) ,
    "ZQN"&: &l_(n) &< x < +&infinity &: &0 ,
  ) $
  From here, we can integrate again to find the potential distribution :
  $ phi.alt (x) = - integral_(x_1)^(x_2) E(x) dif x = cases(
    "ZQN"&: -&infinity &< x < -&l_(p) &: &phi.alt_(p) ,
    "ZD"&: -&l_(p) &< x < &0 &: &phi.alt_(p) + q N_A / (2 epsilon_s) (x + &l_(p))^2 ,
    "ZD"&: &0 &< x < &l_(n) &: &phi.alt_(n) + q N_D / (2 epsilon_s) (&l_(n) - x)^2 ,
    "ZQN"&: &l_(n) &< x < +&infinity &: &phi.alt_(n) ,
  ) $
  Where the continuity of the fields and electrical potential is assured at $-l_(p)$ and $l_(n)$. As they are still unknown, we can aplly the *boundary condition* of the built-in potential under bias :
  $ "Contact potential under bias :" &phi.alt_0 - V = phi.alt_(n) - phi.alt_(p) = (q)/(2 epsilon_s) (N_A l_(p)^2 + N_D l_(n)^2)\
   "Charge preservation :" &N_A l_(p) = N_D l_(n) $
From here, we can find the depletion region widths on each side of the junction as :
  $ l_(p) = sqrt((2 epsilon_s)/(q) (phi.alt_0 - V) (N_D)/(N_A (N_A + N_D))) "      "
  l_(n) = sqrt((2 epsilon_s)/(q) (phi.alt_0 - V) (N_A)/(N_D (N_A + N_D))) $
  The total depletion zone (also called transition zone) is then :
  $ l_(p) + l_(n) = sqrt((2 epsilon_s )/(q) (phi.alt_0 - V) ((N_A + N_D)/(N_A N_D))) $
  Where the maximum electric field ($E_"max"$) occurs at the metallurgical junction ($x=0$) and is given by :
  $ E_"max" = E(0) = - (q N_D l_(n))/(epsilon_s) = - (q N_A l_(p))/(epsilon_s) = - sqrt((2 q)/(epsilon_s) (phi.alt_0 - V) (N_A N_D)/(N_A + N_D)) = - (2 (phi.alt_0 - V))/(l_(p) + l_(n)) $
])
From the results of the analytical solution, we can see that the width of the depletion region is directly proportional to $sqrt(phi.alt_0 - V)$ A bigger forward bias ($V>0$) leads to a smaller depletion region, while a bigger reverse bias ($V<0$) leads to a larger depletion region.

#note_block(block_colors.warning)[
  This solution is breaks if we assume a too high forward bias ($V approx phi.alt_0$), as the depletion region would then disappear, which is not possible in real life. In this case, the depletion approximation is no longer valid, and a more complex numerical solution is required.

  In reverse bias, the depletion region can grow significantly, but it is limited by the breakdown voltage of the junction, beyond which avalanche or Zener breakdown can occur.
]

==== Simplification hypotesies for the analysis of PN junctions
Since we have obtained the concentration profiles ($p(x), n(x)$) from the continuity equations and the electric field ($E(x)$) from Poisson's equation's approximations, we can now compute the total current density :
$ J(x) = J_n (x) + J_p (x) = q[n(x) mu_n E(x)+ D_n (dif n)/(dif x)] + q[p(x) mu_p E(x) - D_p (dif p)/(dif x)] $
In practice, we will *use a point x far outside the depletion region* (in the Z.Q.N. region), as the transition region's complex behavior makes it difficult to analyze directly (case of $V <0$). But then we can't use the majority carriers, as the precision would be too low (they are in very high concentration compared to the minority carriers). We will therefore *only consider the minority carriers* for the current calculation.
#note_block(block_colors.note)[
  Due to H2. it is impossible to compute directly inside the ZQN region the current densities, as the electric field is nul. Therefore, we will have to compute the *carrier concentrations only at the boundaries* of the depletion region.
]
We are considering 2 modes :
- *Forward Bias* ($V >0$) : *Injection* of $p_n (x), n_p (x)$ in the ZQN regions towards the ZD (reduction of the ZD).
- *Reverse Bias* ($V <0$) : *Extraction* of $p_n (x), n_p (x)$ from the ZQN regions towards the ZD (growth of ZD).
#note_block(block_colors.note)[
  The repartition of $p_n (x), n_p (x)$ depend on $V$, but also the *recombination lifetime* of carriers. This will create a *threshold voltage* for injection to be effective, as recombination can prevent carriers from reaching the junction.
]
For a voltage lower than the threshold, the excess carriers will be smaller than the equilibrium minority majority carriers :
$ cases(
  p_n (x) < p_(n 0) << n_(n 0) " in N region ",
  n_p (x) < n_(p 0) << p_(p 0) " in P region "
) $<eq:weak_injection>
#def_block(grid(columns: (1fr, 15fr), align: left + horizon,
[#text(size:13pt, weight: "bold", style:"normal")[H3.]],
[
  We suppose *weak injection* in the Z.Q.N. regions. (@eq:weak_injection)
]))
The quasi-neutrality implies :
$ overbrace(n_n (x) - n_(n 0) = p_n (x) - p_(n 0), "quasi-neutral N region") "    "
overbrace(p_p (x) - p_(p 0) = n_p (x) - n_(p 0), "quasi-neutral P region") $
With H3., the second members are negligeable :
$ cases(
  n_n (x) &approx n_(n 0) &" in N region ",
  p_p (x) &approx p_(p 0) &" in P region "
) $
Since we are in the *weak injection* regime (H3.) and in the *quasi-neutral regions* (H1.), we can simplify the current density equations by neglecting the drift components (as $E approx 0$ from H2.) :
$ cases(
  J_n (x) &approx &q D_n (dif n_n)/(dif x) &" in N region ",
  J_p (x) &approx - &q D_p (dif p_p)/(dif x) &" in P region "
) $<eq:simplified_current_density>

#def_block(grid(columns: (1fr, 15fr), align: left + horizon,
[#text(size:13pt, weight: "bold", style:"normal")[H4.]],
[
  The currents of minority carriers in the Z.Q.N. regions are *dominated by diffusion* (as the electric field is nul. (@eq:simplified_current_density)
]))
Since the doping levels are so much higher, even with $V != 0$, it means that in the depletion region (ZD), the *majority carriers will still dominate*. Therefore, the *diffusion and drift currents will be massive* (Electric field and gradients will be big), and of opposite signs, like in equilibrium (*approximately equilibrium*). This means that the *Boltzmann relations will still hold true* in the depletion region (Z.D.) :
$ J_"drift" + J_"depletion" approx 0 --> cases(
  J_p (x) = q mu_p p(x) E(x) - q D_p (dif p)/(dif x) approx 0 ,
  J_n (x) = q mu_n n(x) E(x) + q D_n (dif n)/(dif x) approx 0 ,
) $
If we take into account Einstein's relation ($D = mu phi.alt_T$), we can rearrange the equations and integrate to find the Boltzmann relations :
$ cases(
  p(x) = p_p (-l_p) e^(- ((phi.alt (x) - phi.alt_p))/(phi.alt_T)),
  n(x) = n_n (l_n) e^(((phi.alt (x) - phi.alt_n))/(phi.alt_T)),
  p(x) . n(x) = p_n (-l_p) . n_p (l_n) e^(((V - phi.alt_0))/(phi.alt_T))
) stretch(->)^(x=(-l_p; l_n)) cases(
  (p_n (l_n))/(p_p (-l_p)) = e^(((phi.alt_p - phi.alt_n))/(phi.alt_T)) = e^(- ((phi.alt_0 - V))/(phi.alt_T)) = p_(n 0) / p_(p 0) e^(V/(phi.alt_T)) ,
  (n_p (-l_p))/(n_n (l_n)) = e^(((phi.alt_n - phi.alt_p))/(phi.alt_T)) = e^(((phi.alt_0 - V))/(phi.alt_T)) = n_(p 0) / n_(n 0) e^(-V/(phi.alt_T)),
) $
This shows that the Boltzmann relations still hold true in the depletion region (Z.D.) under bias conditions. Giving us H5.

#def_block(grid(columns: (1fr, 15fr), align: left + horizon,
[#text(size:13pt, weight: "bold", style:"normal")[H5.]],
[
  In the transition region (Z.D.), the Boltzmann relations remain valid.
]))
From H3., and that the majority carriers at the boundaries are approximately equal to the doping levels, we can find the minority carrier concentrations at the edges of the depletion region (Z.D.) as :
$ cases(
  p_n (-l_p) &= p_(n 0) e^(V/(phi.alt_T)) &= (n_i^2)/N_D e^(V/(phi.alt_T)) " in N region ",
  n_p (l_n) &= n_(p 0) e^(V/(phi.alt_T)) &= (n_i^2)/N_A e^(V/(phi.alt_T)) " in P region "
) $

We now need to find the total current density. And using H4., we can also calculate the minority carrier density. But since the currents $J_p (l_n)$ and $J_n (-l_p)$ are computed in different regions, and their sum only gives a approximation of the total current density. Let us calculate the error made by this approximation.
#block()
In the permanent regime, and the abscence of a generation term ($G=0$), we obtain the compensation term :
$ (dif J_n)/(dif x) = q U_n (x) --> J_n (l_n) = J_n (-l_p) + q integral_(-l_p)^(l_n) U_n (x) dif x $
We can now get the corrected total current density as :
$ J = J_p (l_n) + J_n (l_n) = underbrace(J_p (l_n) + J_n (-l_p), "Approximation Under\nH6 hypothesis") + underbrace(q integral_(-l_p)^(l_n) U_n (x) dif x, "Correction Term") $

#def_block(grid(columns: (1fr, 15fr), align: left + horizon,
[#text(size:13pt, weight: "bold", style:"normal")[H6.]],
[
  We neglect the recombination-generation processes in the depletion region (Z.D.) // Add eq ref
]))

==== Recapitulation of hypotheses
#table(
  columns: (1.5fr, 8fr),
  align: (center, left),
  stroke: 0.5pt,

  // Row 1: headers
  [*Hypothesis*],[*Description*],

  // Row 2: content
  [H1.], [3 zones : Quasi Neutral Regions (Z.Q.N.) and Depletion Region (Z.D.)],
  [H2.], [Applied voltage ($V$) only affects the depletion region (Z.D.), electric field ($E$) in Z.Q.N. is approx. zero],
  [H3.], [Weak injection in Z.Q.N. regions : minority carriers << majority carriers],
  [H4.], [Minority carrier currents in Z.Q.N. dominated by diffusion],
  [H5.], [Boltzmann relations valid in depletion region (Z.D.) even under bias\ ($J_n$ and $J_p$ negligible in Z.D.)],
  [H6.], [Neglect recombination-generation processes in depletion region (Z.D.) (approximation)],
)

==== Current Voltage Characteristic of the PN junction in permanent regime
Let us derive the ambipolar equations of semiconductors (dual continuity equations)n in the quasi-neutral regions (Z.Q.N.) under H1. to H6., in the permanent regime ($dif / dif t = 0$) with no generation ($G=0$), starting from the continuity equations :
$ (dif J_p)/(dif x) = -q U_p " and " U_p = (p_n - p(n 0))/tau_p $
From H4. the hole current reduces to :
$ J_p (x) = - q D_p (dif p_n)/(dif x) $
With substitution, we obtain the ambipolar equations (if we do the same for electrons) :
#def_block(
  color: red,
$ D_p (d^2 p_n)/(d x^2) - (p_n - p_(n 0))/tau_p = 0 " and " D_n (d^2 n_p)/(d x^2) - (n_p - n_(p 0))/tau_n = 0 $)
These are the N and P type ambipolar equations in the quasi-neutral regions (Z.Q.N.) under H1. to H6., in the permanent regime with no generation, and a null electric field (H2.).

The general solutions of these equations are :
$ p_n (x) = A_1 e^(x/L_p) + B_1 e^(-x/L_p) + p_(n 0) " and " n_p (x) = A_2 e^(x/L_n) + B_2 e^(-x/L_n) + n_(p 0) $
Where $L_p = sqrt(D_p tau_p)$ and $L_n = sqrt(D_n tau_n)$ are the diffusion lengths of holes and electrons respectively.

#block()
Where the constants $A_1, B_1, A_2, B_2$ are determined by the boundary conditions :
- *Boltzmann relations at the edges of the depletion region (Z.D.)* :
$ cases(
  p_n (-l_p) &= p_(n 0) e^(V/(phi.alt_T)),
  n_p (l_n) &= n_(p 0) e^(V/(phi.alt_T))
) $
- *Far from the junction finite charge (in Z.Q.N.)* :
   - (Ohmic contact due to infinite recombination of excess carriers)
$ cases(
  p_n (+&infinity) &= p_(n 0) ,
  n_p (-&infinity) &= n_(p 0)
) $

#note_block(block_colors.note)[
  The addition of generation ($G != 0$) would add a constant term to the ambipolar equations and their solutions :
  $ D_p (d^2 p_n)/(d x^2) - (p_n - p_(n 0))/tau_p + G = 0 " and " D_n (d^2 n_p)/(d x^2) - (n_p - n_(p 0))/tau_n + G = 0 $
  $ p_n (x) = A_1 e^(x/L_p) + B_1 e^(-x/L_p) + p_(n 0) + G tau_p " and " n_p (x) = A_2 e^(x/L_n) + B_2 e^(-x/L_n) + n_(p 0) + G tau_n $
]

Solving the system of equations with the boundary conditions, we find the minority carrier distributions in the quasi-neutral regions (Z.Q.N.) as :
$ cases(
  p_n (x) = p_(n 0) + p_(n 0) (e^(V/(phi.alt_T)) - 1) (e^((x + l_p)/L_p)) " in N region ",
  n_p (x) = n_(p 0) + n_(p 0) (e^(V/(phi.alt_T)) - 1) (e^(- (x - l_n)/L_n)) " in P region "
) $
We can also get the current densities at the edges of the depletion region (Z.D.) using H4. :
$ cases(
  J_p (x) = 1/L_p q D_p p_(n 0) (e^(V/(phi.alt_T)) - 1) e^((x + l_p)/L_p) " in N region ",
  J_n (x) = 1/L_n q D_n n_(p 0) (e^(V/(phi.alt_T)) - 1) e^(- (x - l_n)/L_n) " in P region "
) $

Finally, we can find the total current density ($J$) using H6. :
$ J = J_p (l_n) + J_n (l_n) = underbrace(q (D_p p_(n 0) / L_p + D_n n_(p 0) / L_n), J_s) (e^(V/(phi.alt_T)) - 1) = J_s (e^(V/(phi.alt_T)) - 1) $<eq:j_total_pn>
#note_block(block_colors.note)[
  We define $J$ as constant across the whole device (in permanent regime).
]

Where by defintion, *$J_s$ is the saturation current density* of the PN junction.
#def_block(color: red,
[$ J_s = q ((D_n n_(p 0))/L_n + (D_p p_(n 0))/L_p) = q n_i^2 (1/N_A sqrt(D_n/tau_n) + 1/N_D sqrt(D_p/tau_p)) $]
)

#figure(
  image("part3_diagrams/PN Solved minority carriers and current ZQN.png", width: 50%),
  caption: [$P^+N$ Junction Minority Carrier Distributions and Current Density for $V>0$ \ (under H1. to H6., $N_A=10N_D -> N_A >> N_D$)]
)<fig:pn_solved_minority_carriers_and_current_zqn>
#block()

We can finally deduce the *majority carrier current densities* in the quasi-neutral regions (Z.Q.N.) using the total current density ($J$) and the minority density functions :
$ cases(
  J_n (x) = J - J_p (x) = J_s (e^(V/(phi.alt_T)) - 1) (1 - e^(-(x - l_n)/L_p))" in N region ",
  J_p (x) = J - J_n (x) = J_s (e^(V/(phi.alt_T)) - 1) (1 - e^((x + l_p)/L_p)) " in P region "
) $
#note_block(block_colors.note)[
  If we are far enough inside the doped regions ($x->plus.minus infinity$), then, the currents will be logically mostly due to majority carriers ($J_(n,p) (plus.minus infinity) = J$) (Type N is electrons, Type P is holes).
]
To obtain the current-voltage curve ($(I, V)$) flowing through the PN junction, we multiply the current density ($J$, obtaind in @eq:j_total_pn) by the cross-sectional area ($A$) of the junction :
$ I = J . A = I_s (e^(V/(phi.alt_T)) - 1) =cases(
  I_s e^(V/(phi.alt_T)) &" for " V >> phi.alt_T " "("forward bias") #footnote([
    For silicon at room temperature ($T=300K$), $phi.alt_T approx 25"mV"$. Therefore, for voltages higher than $100"mV"$, the approximation holds true.
  ]) ,
  -I_s &" for " V << -phi.alt_T " "("reverse bias"),
) $<eq:i_total_pn>
Where *$I_s$ is the saturation current* of the PN junction, defined as :
$ I_s = J_s . A = q A n_i^2 (1/N_A sqrt(D_n/tau_n) + 1/N_D sqrt(D_p/tau_p)) $

#note_block(block_colors.note)[
  The saturation current $I_s$ (and density $J_s$) depends on $n_i^2$, which has a strong temperature and bandgap dependence:
  $ n_i^2 = N_C N_V e^(-E_g / (k T)) prop T^3 e^(-E_g / (k T)) $

  Since $E_g ("Si") = 1.12 "eV" > E_g ("Ge") = 0.66 "eV"$, silicon has a *much smaller* intrinsic carrier concentration than germanium at the same temperature:
  $ n_i ("Si", 300K) approx 1.5 times 10^10 "cm"^(-3) << n_i ("Ge", 300K) approx 2.4 times 10^13 "cm"^(-3) $

  Therefore, for identical doping and geometry, *germanium diodes have a higher saturation current* than silicon diodes (by a factor of $approx 10^6$), leading to:
  - Higher leakage currents in reverse bias
  - Lower forward voltage drop (Ge: $approx 0.35 "V"$, Si: $approx 0.7 "V"$)
  - Worse high-temperature performance (Ge becomes intrinsic at lower $T$)

  This is why silicon dominates modern electronics despite germanium's higher mobility.

  #figure(
    image("part3_diagrams/pn_IV_curves.png", width: 30%),
    caption: "Comparison of I-V characteristics of Ge and Si PN junctions at room temperature",
  )
]
To *reach the ideal diode* ($J=0$ for $V<0$), we want to minimize $J_s$:
- Use a *wide bandgap* material to reduce $n_i$ (e.g., Si over Ge, or SiC/GaN for power).
- Use *high doping levels* ($N_A, N_D$) to reduce minority carrier concentrations ($p_(n 0), n_(p 0) prop n_i^2/N$), often through the avalanche effect or spetial fabrication techniques.
- *Maximize carrier lifetimes* $tau_p, tau_n$ (since $J_s prop 1/sqrt(tau)$), achieved through high-purity crystals with few recombination centers.

#note_block(block_colors.note)[
  The ideal diode equation assumes *low-level injection* (H3.: $Delta p << n_(n 0)$). At high forward bias ($V >> 0.7$ V for Si), this breaks down:

  - *High-level injection*: $Delta p approx n_(n 0)$ → conductivity modulation, $I prop e^(V/(2 phi.alt_T))$ (ideality factor $eta -> 2$)
  - *Series resistance*: Ohmic drops in neutral regions become significant ($V_"applied" = V_"junction" + I R_s$)
  - *Depletion recombination*: Violates H6., adds current component $prop e^(V/(2 phi.alt_T))$

  The ideal exponential ($eta = 1$) is most accurate for $phi.alt_T << V << 0.5$ V (Si), where H3. and H6. hold.
]

#note_block(block_colors.note)[
  Real diodes are very often doped asymetrically, for example, with a $P^+N$ diode :
  $ J_p (l_n) >> J_n (-l_p) " and " J approx J_p (l_n) (q n_i^2)/N_D sqrt(D_p/tau_p)(e^(V/phi.alt_T)-1) $
  The *current comes entirely from the least doped side* ($N$), as the injection and extraction of carriers in the more heavily doped side ($P^+$) is negligible compared to the equivalent effects in the less doped side ($N$).
]

==== Temperature dependence of the PN junction
The diode I-V characteristic $I = I_s (e^(V/phi.alt_T) - 1)$ is influenced by several temperature-dependent parameters:

#figure(
  table(
    columns: (2fr, 3fr, 2fr),
    align: (left, left, center),
    stroke: 0.5pt,
    [*Parameter*], [*Temperature Effect*], [*Impact on $I_s$*],
    [$n_i$ (intrinsic conc.)], [Increases exponentially with $T$], [$I_s arrow.t$],
    [$E_g$ (bandgap)], [Decreases with $T$ → increases $n_i$], [$I_s arrow.t$],
    [$mu_n, mu_p$ (mobility)], [Decreases due to phonon scattering], [$I_s arrow.b$],
    [$tau_n, tau_p$ (lifetime)], [Generally decreases (enhanced recombination)], [$I_s arrow.b$],
    [$phi.alt_T = k T / q$], [Increases linearly with $T$], [Reduces I-V slope],
  ),
  caption: "Temperature dependence of PN junction parameters",
)#block()

The *dominant effect* is the exponential increase of $n_i^2$, which overwhelms mobility and lifetime reductions:
$ n_i^2 = N_C N_V e^(-E_g / (k T)) prop T^3 e^(-E_g / (k T)) $

For practical calculations, the *Van't Hoff approximation* provides a simple exponential form:
#def_block(color: red,
$ n_i^2 (T) = n_i^2 (T_0) e^(a (T - T_0)) quad "where" a = cases(
  0.18 " K"^(-1) &" for Si",
  0.12 " K"^(-1) &" for Ge"
) $)

This leads to an approximate *doubling of $I_s$* for every 7–10°C increase in temperature.

#figure(
  image("part3_diagrams/pn_IV_T_Curves.png", width: 40%),
  caption: "Effect of temperature on PN junction I-V characteristic",
)
#note_block(block_colors.note)[To maintain the current constant, an increase in temperature requires a decrease in forward voltage:
$ ((dif V)/(dif T))_(I="cst") = V/T - phi.alt_T (dif ln(I_s))/(dif T) = V_T - phi.alt_T . a $
As a rule of thumb, we take for silicon, a $2 ("mV")/(°C)$.
#block()
In reverse bias, the current is essentially the the generation current $-I_(s, r, g) prop n_i (T)$. It is about doubled for every 7 to 8 °C increase in temperature. Though, at 200°C for silicium, the reverse current then becomes the source current $-I_s prop n_i^2$ In this case, the current is doubled every 4°C for the silicium. (Germanium is for 200K and 10°C increases).]

==== Short PN junctions (abrupt junction approximation)
We consider a junction short, if the width of this junction is smaller than the diffusion lengths of minority carriers :
$ W << L_n " and " W << L_p $
When sovling the ambipolar equations in the quasi-neutral regions (Z.Q.N.), we can then *neglect recombination* of minority carriers in these regions. Therefore, one of the solutions is :
$ p_n (x) = p_(n 0) + p_(n 0) (e^(V/phi.alt_T)-1)(1-x/W) $
We then obtain a *linear profile* of minority carriers in the quasi-neutral regions (Z.Q.N.) instead of an exponential one. We obtain the same current density equation as before, but with L_p replaced by W :
$ J = q (D_p p_(n 0)/W + D_n n_(p 0)/W)(e^(V/phi.alt_T)-1) $
Since the minority carrier distribution is linear, then, the *diffusion current is constant* :
$ J_p (x) = J_p (0) $

This means that in the continuity equation, the recombination term ($U_p$) is zero throughout the quasi-neutral regions (Z.Q.N.). Physically, this implies that carriers traverse these regions *without recombining*, which is valid when:
$ tau_"transit" << tau_p, tau_n $
where $tau_"transit" approx W^2 / D$ is the transit time across the short region, and $tau_p, tau_n$ are the carrier lifetimes. In other words, carriers reach the contacts before they have time to recombine.

#linebreak()
=== Non-Idealities of PN Junctions
==== Recombination and Generation Currents
Through H6., we can approximate the calculation of the total current density ($J$) by neglecting the recombination-generation processes in the depletion region (Z.D.). But in reality, there is always some recombination-generation happening in this region, which will add an extra current component to the total current density. This is especially true under reverse bias conditions, where generation processes dominate.
#block()
From the continuity equations for carriers in the permanent regime ($(dif )/(dif t) = 0$) with no generation ($G=0$) :
$ (dif J_n)/(dif x) = q U_n "  and  " (dif J_p)/(dif x) = -q U_p $
As $J=J_n + J_p$ is contant throughout the structure, we have :
$ U_n = U_p = U $

Where $U$ is the net recombination-generation rate. Therefore, the total current density can be expressed as :
$ J = J_p (l_n) + J_n (l_n) = underbrace(J_p (l_n) + J_n (-l_p), "Approximation Under\nH6 hypothesis") + underbrace(q integral_(-l_p)^(l_n) U (x) dif x, "Recombination-Generation\n Current") $
We will define $J_(r,g)$ as the *recombination-generation current density* :
$ J_(r,g) = q integral_(-l_p)^(l_n) U (x) dif x $
$ J = underbrace(J_s (e^(V/phi.alt_T)-1), "Approximation Under H6") + underbrace(J_(r,g), "R.-G.\n Current") $

Let us add to this term, the *Shockley-Read-Hall (SRH) recombination model* for the recombination rate ($U$) through mid-gap traps in the depletion region (Z.D.) :
#def_block(color: red,[
  $ U = (p n - n_i^2)/(tau_p (n + n_1) + tau_n (p + p_1)) $
  #block()
  Where $n_1 = n_i e^((E_t - E_i)/(k T))$ and $p_1 = n_i e^(- (E_t - E_i)/(k T))$ are the equilibrium carrier concentrations when the trap energy level ($E_t$) equals the Fermi level ($E_F$). For mid-gap traps, $E_t approx E_i$, so $n_1 = p_1 = n_i$.
])
#note_block(block_colors.note)[
  The *SRH model* describes recombination via *defect states (traps) within the bandgap*. These traps can capture electrons and holes, *facilitating recombination* that would otherwise be unlikely in a perfect crystal.
]
To simplify this model, we will consider the following assumptions :#footnote([
  And additional assumption could be used, of low-level injection in the depletion region (Z.D.) : $p approx p_(p 0) << n$ in P region and $n approx n_(n 0) << p$ in N region.
])
- *Mid-gap traps* : $E_t approx E_i$ → $n_1 = p_1 = n_i$
- *Identical lifetimes* : $tau_n = tau_p = tau$

The resulting recombination rate ($U$) simplifies to :
$ U = 1/tau (p.n - n_i^2)/(n + p + 2 n_i) $
From H5., we can consider $J_n$ and $J_p$ negligible in the depletion region (Z.D.), we can then get the relation of the product of carrier concentrations ($p.n$) from the Boltzmann relations :
$ p(x).n(x) = p_n (-l_p).n_p (l_n) e^((V - phi.alt_0)/phi.alt_T) = n_i^2 e^(V/phi.alt_T) $
We can now rewrite the recombination-generation current density ($J_(r,g)$) as :
$ J_(r,g) = 1/tau q n_i^2 (e^(V/phi.alt_T) - 1) integral_(-l_p)^(l_n) 1/(n + p + 2n_i) dif x $

Now, let us analyze the influence of the voltage  :
- *Forward Bias* ($V > 0$) : Recombination current, as the centers of the Z.D. are filled with both electrons and holes from the excess injection from the Z.Q.N. regions.
- *Reverse Bias* ($V < 0$) : Generation current, as the centers of the Z.D. are depleted of carriers (lower than equilibrium), leading to *thermal generation* of electron-hole pairs (electrons injected in ZQN-N, and holes in ZQN-P).
#block()

As this current is hard to calculate exactly, we will consider its maximum at the point where $n=p$ (midpoint of the depletion region Z.D.) to estimate its order of magnitude. Therefore, we can approximate :
$ n = p = n_i e^(V/phi.alt_T) --> J_(r,g) = (q n_i)/(2 tau) (e^(V/phi.alt_T)-1)/(e^(V/(2 phi.alt_T) )+ 1) integral_(-l_p)^(l_n) dif x $
$ J_(r,g) = underbrace((q n_i)/(2 tau) sqrt((2 epsilon_s)/q (phi.alt_0 - V) (N_A + N_D)/(N_A N_D)), J_(s,r,g))[e^(V/(2 phi.alt_T))-1] $
Where we defined *$J_(s,r,g)$ as the saturation recombination-generation current density* of the PN junction.
#block()
#note_block(block_colors.note)[
  The saturation recombination-generation current $J_(s,r,g)$ is much bigger than the standard saturation current $J_s$ (from diffusion in Z.Q.N. regions) because it depends linearly on $n_i$ instead of $n_i^2$, and also depends on the depletion width ($W prop sqrt((phi.alt_0 - V)/(N_A + N_D)/(N_A N_D))$).
  For Silicon at room temperature (300 K), $J_(s,r,g)$ is typically $10^3$ to $10^6$ times larger than $J_s$.
]
This means that for $V<-phi.alt_T$, the *recombination-generation current dominates* the total current, as :
$ J approx - J_(s, r, g) $
#note_block(block_colors.note)[
  The reverse current is *not constant*, but follows a $sqrt(phi.alt_0 - V)$ dependence due to the voltage-dependent depletion width. This means the leakage current increases with higher reverse bias (until breakdown).

  *Bias regimes from @fig:pn_generation_recombi_currents:*
  - *Forward bias ($V > 0$):* Two distinct regions:
    - Low voltage ($V < 0.4$ V for Si): Dominated by *recombination-generation current* ($prop e^(V/(2 phi.alt_T))$, $eta approx 2$)
    - Higher voltage ($V > 0.4$ V for Si): Dominated by *diffusion current* ($prop e^(V/phi.alt_T)$, $eta approx 1$)
  - *Reverse bias ($V < 0$):* Dominated by *generation current*, which increases as $sqrt(phi.alt_0 - V)$ until avalanche or Zener breakdown occurs.

  #figure(
  image("part3_diagrams/pn_generation_recombi_currents.png", width: 60%),
  caption: "Current characteristic of a PN junction in both directions, showing diffusion and recombination-generation currents",
  )<fig:pn_generation_recombi_currents>
]

#note_block(block_colors.extra)[
  *Why does diffusion current eventually dominate in forward bias?*

  The key lies in the *exponential growth rates*:
  $ J_"diff" prop e^(V/phi.alt_T) "  vs  " J_(r,g) prop e^(V/(2 phi.alt_T)) $

  At low forward voltages, $J_(s,r,g) >> J_s$ (for Si), so recombination dominates. But since $e^(V/phi.alt_T)$ grows *twice as fast* as $e^(V/(2 phi.alt_T))$, the diffusion current eventually overtakes. The crossover occurs around $V approx 0.4$ V for silicon at room temperature.

  *Temperature and material dependence:*
  #figure(
    table(
      columns: (2fr, 2fr, 3fr),
      align: (center, center, left),
      stroke: 0.5pt,
      [*Material*], [*Dominant current*], [*Temperature behavior*],
      [Silicon (300K)], [$J_(r,g)$ at low $V$], [$J_(s,r,g) prop n_i$ doubles every 7–8°C],
      [Silicon (>150°C)], [$J_s$ dominates], [$J_s prop n_i^2$ catches up as $n_i$ rises exponentially],
      [Germanium], [$J_s$ always], [$J_(r,g)$ negligible except at $T < 200$K],
    ),
    caption: "Material comparison of current components",
  )

  *Physical explanation:*
  - $J_s prop n_i^2$: Diffusion current depends on *minority carrier injection*, which scales with $n_i^2$ (mass action law).
  - $J_(s,r,g) prop n_i$: Generation-recombination current depends on *trap-assisted processes*, scaling linearly with $n_i$.

  Since Ge has a much higher $n_i$ ($approx 10^13$ vs $approx 10^10$ for Si), its $J_s$ is inherently large, making $J_(r,g)$ comparatively negligible. For Si, the smaller $n_i$ means $J_s$ is tiny at room temperature, allowing $J_(r,g)$ to dominate until high forward bias or elevated temperatures.
]

==== Carrier multiplication and Breakdown phenomena
Breakdown phenomena occur under *high reverse bias conditions* in PN junctions, leading to a sudden and large increase in current. There are two primary breakdown mechanisms: *Zener breakdown* and *Avalanche breakdown*.
#block(
  fill: luma(245),
  stroke: (left: 2pt + purple),
  inset: (x: 10pt, y: 8pt),
  radius: 2pt,
  width: 100%,
  [
  - #underline[*Avalanche breakdown*] occurs under *high reverse bias conditions*, when the electric field in the depletion region (Z.D.) becomes strong enough to accelerate free carriers (electrons and holes) to *energies sufficient to ionize lattice atoms upon collision*. This process generates additional electron-hole pairs, leading to a *chain reaction or "avalanche" of carriers*, resulting in a sudden and *large increase in current* (exponential).
  #block()
  - #underline[*Zener breakdown*] occurs in *heavily doped PN junctions* under *lower reverse bias voltages*. The high doping levels create a very thin depletion region (Z.D.) with an extremely strong electric field. This field can cause *quantum mechanical tunneling* of electrons from the valence band of the p-side to the conduction band of the n-side, leading to a *sudden increase in current* (sharp knee in I-V curve).

  #grid(
    columns: (1fr, 1fr),
    align: (center, center),
    gutter: 15pt,
    figure(
      image("part3_diagrams/pn_avalanche_breakdown_mechanism.svg", width: 90%),
      caption: [Avalanche Breakdown: Impact ionization chain reaction creates exponential current increase],
    ),
    figure(
      image("part3_diagrams/pn_zener_breakdown_mechanism.svg", width: 90%),
      caption: [Zener Breakdown: Quantum tunneling in heavily doped junction creates sharp current rise],
    ),
  )
])

==== Avalanche Breakdown Mechanism
Let us study the *Avalanche breakdown* mechanism in more detail. As the reverse bias voltage ($V$) increases, the width of the depletion region (Z.D.) ($W$) increases, leading to a stronger electric field ($E$) across the junction. When this *field exceeds a critical value ($E_"crit"$)*, free carriers gain enough kinetic energy between collisions to ionize atoms (break covalent bonds) in the lattice upon impact, creating additional electron-hole pairs. This process is called *impact ionization*. The newly generated carriers are also accelerated by the electric field, leading to further ionization events. This *chain reaction* results in an *avalanche multiplication* of carriers, causing a dramatic increase in current.
#block()
#note_block(block_colors.extra)[For enough high reverse bias voltages, the avalanche process can lead to *device failure* due to excessive current and power dissipation. Therefore, devices are designed with a *breakdown voltage ($V_"BR"$)* rating, which is the maximum reverse voltage the device can withstand without entering avalanche breakdown.
#note_block(block_colors.warning)[
  In avalanche, the current grows without bound unless limited by the external circuit. Without protection, the resulting power dissipation ($P = V I$) causes *thermal runaway* and device destruction via Joule heating.
]
]

===== Ionization coefficients (impact ionization)
To quantify this process, we define the *ionization coefficients* $alpha_n$ (electrons) and $alpha_p$ (holes):
$ alpha_(n,p) = "number of EHPs created per unit distance traveled by a carrier" $

These coefficients depend exponentially on the local electric field $E$ via the *Chynoweth law*:
#def_block(color: red)[
$ alpha_n = alpha_(n,infinity) e^(-b_n / |E|) quad "and" quad alpha_p = alpha_(p,infinity) e^(-b_p / |E|) $
]
Where $alpha_(n,infinity)$, $alpha_(p,infinity)$, $b_n$, and $b_p$ are material-specific constants. The exponential dependence reflects that carriers need a threshold field to gain enough kinetic energy for impact ionization.

#figure(
  image("part3_diagrams/pn_chynowethLaw.png", width: 50%),
  caption: [Ionization coefficients $alpha_n$ and $alpha_p$ vs. inverse electric field for Silicon (Chynoweth's law)],
)#block()

===== Continuity equations with impact ionization
Since impact ionization generates new carriers, we must add *generation terms to the continuity equations*. In steady state ($partial / partial t = 0$):
$ (d J_n)/(d x) &= alpha_n |J_n| + alpha_p |J_p| + q U(x) \
 -(d J_p)/(d x) &= alpha_n |J_n| + alpha_p |J_p| + q U(x) $

These coupled equations describe how both electron and hole currents grow as they traverse the high-field depletion region. Alos, *these therms are only significant in the depletion region (Z.D.)* where the electric field is strong enough to cause impact ionization.#footnote([
  In the quasi-neutral regions (Z.Q.N.), the electric field is weak, so $alpha_n$ and $alpha_p$ are negligible, and generation due to impact ionization can be ignored. This means that the minority carrier currents ($J_n (-l_p)$ and $J_p (l_n)$) in Z.Q.N at the limits, can be computed as before (without generation terms).
])
Introducing the total current density $J$ and the $alpha_(n p)$ notation:
$ J = J_n (x) + J_p (x) quad "and" quad alpha_(n p) = alpha_n - alpha_p $

We can rewrite the continuity equations with boundary conditions as:
$ cases(
  (dif J_n)/(dif x) - alpha_(n p) J_n &= alpha_p J + q U(x) quad &"with " J_n (-l_p) "at" x = -l_p,
  (dif J_p)/(dif x) + alpha_(n p) J_p &= -alpha_n J - q U(x) quad &"with " J_p (l_n) "at" x = l_n
) $

Integrating from the boundaries to position $x$:
$ cases(
  J_n (x) &= J_n (-l_p) e^(integral_(-l_p)^x alpha_(n p) dif x') + integral_(-l_p)^x (alpha_p J + q U) e^(integral_(x')^x alpha_(n p) dif x'') dif x',
  J_p (x) &= J_p (l_n) e^(-integral_x^(l_n) alpha_(n p) dif x') - integral_x^(l_n) (alpha_n J + q U) e^(-integral_x^(x') alpha_(n p) dif x'') dif x'
) $

Evaluating at $x = l_n$ for $J_n$ and using $J = J_n (l_n) + J_p (l_n)$:
$ J = underbrace(J_n (-l_p) M_n + J_p (l_n) M_p, "Multiplied injected currents") + underbrace("generation integral", "R-G contribution") $

where $M_n$ and $M_p$ are the *multiplication factors* due to impact ionization.

#note_block(block_colors.note)[
  We will skip the calculations due to unecessary complexity, but the *generation integral* accounts for the additional carriers generated within the depletion region (Z.D.) due to impact ionization, contributing to the total current density ($J$).
]
#def_block(color: red, [
  We define the *current density without ionization phenomena* as :
  $ J^* = J_p (l_n) + J_n (-l_p) + integral_(-l_p)^(l_n) q U(x) dif x $
])

===== Multiplication factor and avalanche breakdown
We define a *multiplication factor* ($M$) as the ratio of the total current density ($J$) to the current density without ionization ($J^*$), that characterizes the increase in current due to impact ionization :
$ M = J / J^* " "(>=1) $

This factor is an *increasing function of reverse voltage*: as $|V|$ increases, the electric field grows, ionization rates rise, and $M$ increases. When $M -> infinity$, the junction enters *avalanche breakdown*.
#note_block(block_colors.note)[
    From the previous derivation, the multiplication factor $M$ can be expressed as :
    $ M = 1 / (1 - integral_(-l_p)^(l_n) (alpha_n J_n (x) + alpha_p J_p (x))/J^* dif x) $
    Avalanche breakdown happens when the denominator approaches zero, causing $M$ to diverge.
]

===== Avalanche breakdown condition
Mathematically, avalanche occurs when the denominator of $M$ vanishes. This yields the *ionization integral condition*:
#def_block(color: red)[
$ 1 = integral_(-l_p)^(l_n) alpha_n e^(-integral_(-l_p)^x alpha_(n p) dif x') dif x quad "or equivalently" quad 1 = integral_(-l_p)^(l_n) alpha_p e^(integral_x^(l_n) alpha_(n p) dif x') dif x $
]

Since $alpha_n$ and $alpha_p$ depend on the local electric field $E(x)$, and $E(x)$ depends on the applied voltage $V$, these conditions *implicitly define the avalanche breakdown voltage* $V_"BR"$.

===== Simplified avalanche condition
To simplify calculations, we assume the ratio of ionization coefficients is approximately constant:
$ gamma = alpha_p / alpha_n approx "const" $

This assumption is reasonable based on the Chynoweth law data (see previous figure). With this simplification, we define an *effective ionization coefficient*:
$ alpha_"eff" = alpha_n dot (gamma - 1) / ln(gamma) $

The avalanche condition then reduces to an elegant form:
#def_block(color: red)[
$ integral_(-l_p)^(l_n) alpha_"eff" dif x = 1 $
]

This is an *implicit equation* for the breakdown voltage: both the integration limits ($l_n$, $l_p$) and $alpha_"eff"$ depend on the applied voltage through the electric field distribution.

For *Silicon at 300K*, the effective ionization coefficient follows:
$ alpha_"eff" (E) = 7.03 times 10^5 e^(-1.468 times 10^6 / |E|) quad ["cm"^(-1)] $

#note_block(block_colors.note)[
  *Breakdown voltage dependence on doping:*

  The avalanche voltage depends on the *impurity profile* near the metallurgical junction. For *asymmetric abrupt junctions* ($P^+ N$ or $N^+ P$), the breakdown voltage is determined almost entirely by the *less doped side*, since:
  - The depletion region extends primarily into the lightly doped region
  - The electric field profile is controlled by this region's doping

  *Key design rule:* Higher breakdown voltages require *lighter doping* on the lightly-doped side.

  #figure(
    image("part3_diagrams/pn_avalanche_breakdown_voltage.png", width: 50%),// TODO
    caption: [Breakdown voltage $V_"BR"$ vs. doping concentration for $P^+ N$ junctions in Si, Ge, and GaAs. Dashed line separates avalanche (low doping) from Zener (high doping) breakdown regimes.],
  )
]

===== Temperature dependence of avalanche breakdown voltage

The avalanche breakdown voltage *increases with temperature* (positive temperature coefficient):
$ (dif |V_"BR"|)/(dif T) > 0 quad "(approx. +0.1% per °C for Si)" $

*Physical explanation:*
1. At higher temperatures, *lattice vibrations (phonons#footnote([Phonons are quantized lattice vibrations that scatter charge carriers, affecting their mobility and mean free path. This concept explains why increased temperature leads to more frequent carrier scattering.])) increase*
2. Carriers experience *more frequent collisions*, reducing their mean free path $lambda$
3. Between collisions, carriers gain *less energy* from the electric field ($Delta E approx q E lambda$)
4. To achieve the same ionization rate, a *stronger electric field* (higher voltage) is required

#figure(
  image("part3_diagrams/pn_temperature_breakdown_voltage.png", width: 50%), // TODO
  caption: [Temperature dependence of breakdown voltage for Si PN junctions. Avalanche breakdown shows positive temperature coefficient.],
)

#note_block(block_colors.extra)[
  *Avalanche vs. Zener: Temperature coefficient sign*
  #figure(
    table(
      columns: (1.2fr, 1.2fr, 1.5fr, 2fr),
      align: (left, center, center, left),
      stroke: 0.5pt,

      [*Mechanism*], [*Doping Level*], [*Temperature Coefficient*], [*Physical Reason*],

      [Avalanche], [Low], [$V_"BR" arrow.t$ with $T$\ (Positive)], [Reduced mean free path due to increased phonon scattering],

      [Zener], [High], [$V_"BR" arrow.b$ with $T$\ (Negative)], [Band gap shrinks with $T$, lowering barrier],
    ),
    caption: "Breakdown mechanism temperature dependence in PN junctions",
  )#block()

  This difference in sign can be used to identify the dominant breakdown mechanism in a device.
]

==== Zener Breakdown phenomena
*Zener breakdown* occurs in *heavily doped PN junctions* ($N_A, N_D > 10^18 "cm"^(-3)$) at relatively low reverse voltages ($V_Z < 5$–$6$ V). The high doping creates:
1. A *very thin depletion region* ($W < 10$ nm)
2. An *extremely strong electric field* ($E > 10^6$ V/cm)

Under these conditions, the potential barrier becomes thin enough for electrons to *quantum-mechanically tunnel* directly from the P-side valence band to the N-side conduction band—without gaining kinetic energy from the field.

#figure(
  image("part3_diagrams/pn_zener_energy_bands.png", width: 45%),
  caption: [Energy band diagram under Zener breakdown: electrons tunnel through the narrow barrier rather than being accelerated over it.],
)<fig:pn_zener_energy_bands>

*Key characteristics:*
- *Sharp I-V knee:* Current rises abruptly at $V_Z$ due to the quantum nature of tunneling.
- *Low breakdown voltage:* Typically $V_Z < 5$ V (vs. avalanche: $V_"BR" > 6$ V).
- *Negative temperature coefficient:* As $T$ increases, the bandgap $E_g$ shrinks, reducing the tunneling barrier height. This makes tunneling easier, so $V_Z$ *decreases* with temperature:
$ (dif |V_Z|)/(dif T) < 0 $


#note_block(block_colors.trick)[
  *Distinguishing Avalanche vs. Zener breakdown:*

  - *Doping levels:* Zener occurs in heavily doped junctions (n and p > 10^18 cm^-3), while avalanche occurs in lightly doped junctions.
  - *Breakdown voltage:* Zener breakdown voltages are typically < 5 V, while avalanche breakdown voltages are higher.
  - *Temperature coefficient:* Zener has a negative temperature coefficient (breakdown voltage decreases with T), while avalanche has a positive coefficient.

  These characteristics help identify the dominant breakdown mechanism in a given PN junction device.
]

==== Breakdown Voltage Calculation (and temperature dependence)
For a heavily asymmetric $P^+ N$ junction ($N_A >> N_D$), the depletion region extends almost entirely into the lightly-doped N-side:
$ l_p approx 0 quad "and" quad l_n approx sqrt((2 epsilon_s)/(q N_D) (phi.alt_0 - V)) $

The electric field peaks at the metallurgical junction ($x = 0$) and decreases linearly across the depletion region:
$ E(x) = E_"max" (1 - x/l_n) quad "where" quad E_"max" = -sqrt((2 q)/(epsilon_s) (phi.alt_0 - V) N_D) $

*Avalanche condition for $P^+ N$ junction:*

Substituting the linear field profile into the ionization integral:
$ 1 = integral_0^(l_n) alpha_"eff" dif x = integral_0^(l_n) alpha_infinity e^(-b/|E(x)|) dif x $

Since impact ionization is significant only near $x = 0$ where $|E| approx |E_"max"|$, we can use the approximation $(1 - x/l_n)^(-1) approx 1 + x/l_n$ for small $x$:
$ 1 = integral_0^(l_n) alpha_infinity e^(-b/(|E_"max"|) (1 + x/l_n)) dif x $

Evaluating this integral yields an *implicit equation* for the critical field:
$ 1 = alpha_infinity (epsilon_s E_"max"^2)/(q N_D b) e^(-b/|E_"max"|) (1 - e^(-b/|E_"max"|)) $

Once $E_"max"$ is determined from this equation, the *avalanche breakdown voltage* follows directly:
#def_block(color: red)[
$ V_"BR" = phi.alt_0 - (epsilon_s E_"max"^2)/(2 q N_D) $
]

#note_block(block_colors.note)[
  *Physical interpretation:*
  - The breakdown *voltage decreases with higher doping* ($N_D$) because the depletion region becomes narrower, concentrating the electric field.
  - The term $(epsilon_s E_"max"^2)/(2 q N_D)$ represents the voltage drop across the depletion region at the critical field for avalanche.
  - For lightly-doped substrates, $V_"BR"$ can reach hundreds of volts; for heavily-doped junctions, it drops to a few volts (Zener regime).
]

==== Strong Injection Effects and Serries Resistance
The ideal diode theory assumes *low-level injection* (H3.: $Delta p << n_(n 0)$), where the injected minority carrier concentration remains much smaller than the majority carrier concentration. This *assumption breaks down at high forward bias*, leading to two important non-idealities:

===== High-Level Injection Regime

For a $P^+ N$ junction, high-level injection occurs when the *applied voltage exceeds a critical threshold* related to the doping of the lightly-doped N-region:
$ V > 2 phi.alt_T ln(N_D/(2 n_i)) $

In this regime, the *injected hole concentration becomes comparable to the background electron concentration* ($Delta p approx n_(n 0)$), causing *conductivity modulation* in the neutral region.

*Modified saturation current density $J_s^*$:*

Under high-level injection, the standard saturation current $J_s$ (derived for low-level injection) no longer applies. We define a *modified saturation current* $J_s^*$ that accounts for:
- Both carrier types contributing equally to current (not just minority carriers)
- Conductivity modulation in the neutral regions
- Altered recombination dynamics (ambipolar transport)

The high-injection saturation current is:
$ J_s^* = q n_i sqrt(D_a / tau_a) = q n_i sqrt((2 D_n D_p)/(tau_n D_p + tau_p D_n)) $

#note_block(block_colors.extra)[
  *Ambipolar transport parameters:*

  In high-level injection, electrons and holes move *together* to maintain quasi-neutrality ($Delta n approx Delta p$). This coupled motion is described by *ambipolar* parameters:

  - *Ambipolar diffusion coefficient* $D_a$: The *harmonic mean* of $D_n$ and $D_p$, weighted by a factor of 2. Since both carriers must diffuse together, the slower carrier limits the pair.
  $ D_a = (2 D_n D_p)/(D_n + D_p) approx 2 D_"slower" quad "(when " D_n >> D_p " or vice versa)" $

  - *Ambipolar lifetime* $tau_a$: A *weighted average* of the individual lifetimes, reflecting that recombination requires both an electron and a hole to meet.
  $ tau_a = (tau_n D_p + tau_p D_n)/(D_n + D_p) $

  These parameters naturally emerge from solving the coupled continuity equations under the constraint $Delta n = Delta p$.
]

The current density in the high-injection regime then follows:
$ J = J_s^* e^(V/(2 phi.alt_T)) $

#figure(
  table(
    columns: (1.5fr, 3fr, 3fr),
    align: (center, left, left),
    stroke: 0.5pt,
    [*Parameter*], [*Low-Level Injection ($J_s$)*], [*High-Level Injection ($J_s^*$)*],
    [*Scaling*], [$J_s prop n_i^2$], [$J_s^* prop n_i$],
    [*Physical Origin*], [Minority carrier injection (mass action law)], [Both carrier types participate equally (ambipolar transport)],
    [*Temperature Dependence*], [Exponential; doubles ~every 7–8 °C], [Less severe; linear $n_i$ term],
    [*Dominance Regime*], [Forward bias $V > 0.4$ V (Si)], [Forward bias $V > 2 Phi_T ln(N_D/(2 n_i))$ (high $V$)],
    [*Magnitude Comparison*], [$J_s$ (baseline)], [$J_s^* >> J_s$ typically by 10–100×],
    [*Current Exponent*], [$I prop e^(V/Phi_T)$ ($eta = 1$)], [$I prop e^(V/(2 Phi_T))$ ($eta = 2$)],
  ),
  caption: "Comparison of saturation currents in low-level vs. high-level injection regimes.",
)


#note_block(block_colors.note)[
  *Why the factor of 2 in the exponent?*

  In low-level injection, only minority carriers limit current ($J prop e^(V/phi.alt_T)$, $eta = 1$). In high-level injection, *both* carrier types must increase together to maintain quasi-neutrality ($Delta n approx Delta p$). Since the $n p$ product appears in the current equations, the effective voltage is split between electrons and holes, yielding $eta = 2$.

  This results in a *slower exponential growth* of current with voltage compared to low-level injection.
]

===== Series Resistance Effects

At high currents, the resistance of the quasi-neutral regions and metal-semiconductor contacts becomes significant. Let $R_s$ be the total series resistance for a diode of area $A$. The voltage actually applied to the junction is reduced by the ohmic drop:
$ I = I_s^* e^((V - I R_s)/(2 phi.alt_T)) $

This can be rewritten as:
$ V = underbrace(I R_s, "Ohmic drop") + underbrace((2 k T)/q ln(I/I_s^*), V_j "Junction voltage") $

#note_block(block_colors.note)[
  *Key observations:*
  - At *low currents*, $I R_s << V_j$, so series resistance is negligible.
  - At *high currents*, the ohmic drop $I R_s$ dominates, and the I-V curve becomes nearly linear.
  - While the junction voltage $V_j$ cannot exceed the built-in potential $phi.alt_0$ (otherwise the depletion width becomes imaginary), the *total applied voltage* $V = V_j + I R_s$ can exceed $phi.alt_0$ due to the series resistance drop.

  Manufacturers minimize $R_s$ to reduce power dissipation ($P = V I$) at high currents, which can cause excessive heating and device failure.
]

#figure(
  image("part3_diagrams/pn_IV_injection.png", width: 50%),
  caption: [I-V characteristic showing: (1) ideal low-injection ($eta = 1$), (2) high-injection regime ($eta = 2$), and (3) series resistance limiting at high currents.],
)

=== Dynamic Behavior of PN Junctions (Capacitances, Switching times)
==== Small Signal Model at low frequencies
For small perturbations around a DC operating point $(V_0, I_0)$:
$ V(t) = V_0 + v(t) quad "and" quad I(t) = I_0 + i(t) quad "where" |v(t)| << phi.alt_T $

At *low frequencies* ($f << 1/(2 pi tau)$), capacitive effects are negligible. Linearizing the diode equation via Taylor expansion:
$ i(t) = underbrace(I_s (e^(V_0/phi.alt_T) - 1), "Order 0") + underbrace(I_s (v(t)/phi.alt_T) e^(V_0/phi.alt_T) , "Order 1") + underbrace(O(v(t)^2), "Higher orders") approx I_0 + i_1 (t) $

#note_block(block_colors.warning)[\
  Don't confuse:
  - *Equilibrium* ($V = 0$, $I = 0$): No bias applied, junction at thermal equilibrium
  - *Operating point* ($V_0$, $I_0$): Any DC bias condition for small-signal analysis
]
#grid(
  columns: (1fr, 1fr),
  align: center + horizon,
  gutter: 15pt,
  [#figure(
    image("part3_diagrams/pn_small_signal_polarization.png", width: 120%),
    caption: [Small-signal model around operating point ($V_0$, $I_0$). With $g_0$ the small-signal conductance.],
  )<fig:pn_small_signal_polarization>],
  [#figure(
    image("part3_diagrams/pn_small_signal_variance.png", width: 60%),
    caption: [Representation of the I-V linear approximation around operating point ($V_0$, $I_0$).],
  )<fig:pn_small_signal_variance>],
)
We can then replace the junction with a linear resistor (as in @fig:pn_small_signal_polarization) of value $r_d$ (dynamic resistance) defined by the first-order term:
$ i_1 (t) = g_d v(t) = v(t)/r_d $

This defines the *dynamic conductance* (or dynamic resistance):
#def_block(color: red)[
$ g_d = 1/r_d = (dif I)/(dif V)|_(V_0) = (I_0 + I_s)/phi.alt_T approx I_0/phi.alt_T quad "(for" I_0 >> I_s")" $
]
- In *reverse bias* ($V_0 < -phi.alt_T$, $I_0 approx -I_s$):
$ g_d -> 0  "  and  " r_d -> +infinity $
- In *forward bias* ($V_0 > phi.alt_T$, $I_0 >> I_s$):
$ g_d approx I_0/phi.alt_T  "  and  " r_d approx phi.alt_T / I_0 $
At 300K, we have $phi.alt_T approx 25$ mV, $r_d = phi.alt_T/I_0 = 25/I_0 [Omega]$, and the dynamic conductance $g_d = 40 .I_0 ["mS"]$.#footnote([
  We are talking about *Sieverts* here: $1$ S $= 1$ A/V. $1$ mS $= 10^(-3)$ S.
])
#note_block(block_colors.note)[
  *Geometrical interpretation:*\
  We are taking the tangent to the I-V curve at the operating point ($V_0$, $I_0$). The slope of this tangent line is the dynamic conductance $g_d = (dif I)/(dif V)|_(V_0)$, and its reciprocal is the dynamic resistance $r_d = 1/g_d$.
  $ g_d = (dif I)/(dif V)|_(V_0) = (I_0 + I_s)/phi.alt_T $
  *Physical interpretation:*
  - The dynamic resistance $r_d = phi.alt_T / I_0$ decreases with increasing bias current.
  - At $I_0 = 1$ mA (Si, 300K): $r_d approx 26 Omega$
  - At $I_0 = 10$ mA: $r_d approx 2.6 Omega$

  This is why diodes appear as near-short-circuits at high forward currents in AC analysis.
]

==== Transistion Capacitance ($C_"T"$)
When a voltage bias is applied to a PN junction, charges redistribute in the device, leading to two distinct capacitance components:

#def_block(
  color: rgb("#4a90e2"),
  grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      #text(size: 12pt, weight: "bold")[*Transition Capacitance* ($C_T$)]
      #block(inset: 10pt, fill: luma(250), radius: 5pt)[
        - Caused by *depletion region width* variation
        - Dominates in *reverse bias* ($V < 0$)
        - Decreases with $|V|$: wider depletion → lower $C_T$
        - Non-linear: $C_T prop 1/sqrt(phi_0 - V)$
        - Junction behaves like *voltage-tuned capacitor*
      ]
    ],
    [
      #text(size: 12pt, weight: "bold")[*Diffusion Capacitance* ($C_D$)]
      #block(inset: 10pt, fill: luma(250), radius: 5pt)[
        - Caused by *minority carrier charge* variation
        - Dominates in *forward bias* ($V > 0$)
        - Increases with $V$: more injection → higher $C_D$
        - Exponential: $C_D prop e^(V/Phi_T)$
        - Related to *carrier storage time*
      ]
    ]
  )
)

===== General case
Let us derive the expression of the *transition capacitance* ($C_"T"$), let's start from the junction width with a voltage change $V+Delta V$ :
$ l_p = sqrt((2 epsilon_s)/q (phi.alt_0 - V - Delta V) N_D/(N_A (N_A+N_D))) "  and  " l_n=sqrt((2 epsilon_s)/q (phi.alt_0 - V - Delta V) N_A/(N_D (N_A+N_D))) $
$ W = l_n + l_p = sqrt((2 epsilon_s)/(q) (phi.alt_0 - V) ((N_A + N_D)/(N_A N_D))) $
When voltage changes by $Delta V$, the depletion width changes ($W=l_n + l_p$), causing charge redistribution. The majority carriers in the quasi-neutral regions respond *quasi-instantaneously* through the *dielectric relaxation time*:
$ tau_"diel" = epsilon_s / sigma approx 10^(-12) " s" $

Since this is much faster than typical circuit time scales, the depletion region remains in *quasi-static equilibrium* with the applied voltage. This means we can use static (DC) analysis at each instant, without solving complex transient equations.
#block()
We can approximate the space charge $Q_j$ at each side of the metalurgic junction as :
$ Q_j = A dot q N_A l_p = A dot q N_D l_n $

We can then define the *transition capacitance* ($C_"T"$) as the variation of this charge ($Q_j$) with respect to the applied voltage ($V$):
#def_block(color: red)[
$ C_"T" = lim_(Delta V -> 0) |(Delta Q_j)/(Delta V)| = |(dif Q_j)/(dif V) | = (A epsilon_s)/(l_n + l_p) = = (A epsilon_s)/W $
]

#note_block(block_colors.note)[
  We can observe that the *resulting capacitance* is similar in form to that of a parallel-plate capacitor, with the plates separated by the depletion width ($W = l_n + l_p$) and an effective permittivity of $epsilon_s$.
]
#note_block(block_colors.extra)[
  As the capacitance $C_"T"$ depends on the applied voltage $V$, it is a *non-linear capacitance*. This non-linearity is exploited in applications such as *varactor diodes*, where the capacitance can be tuned by adjusting the reverse bias voltage.
]


#figure(
  image("part3_diagrams/pn_capacitance_in_junction.png", width: 50%),
  caption: [Transition capacitance $C_"T"$ vs. applied voltage $V$ for an abrupt PN junction. For both linear and abrupt junctions, $C_"T"$ decreases with increasing reverse bias due to widening depletion region.],
)<fig:pn_capacitance_in_junction>


===== Abrupt case
In the case of an *abrupt junction*, we have :
$ Q_"j,abrupt" = 2 A sqrt(phi.alt_T - V) underbrace(sqrt((epsilon_s q)/2 (N_A N_D)/(N_A + N_D)), K_a) $
#def_block(color: red)[
$ C_"T,abrupt" = (A epsilon_s)/(l_n + l_p) stretch(=)^"abrupt" A/sqrt(phi.alt_0 - V) K_a $
]
With $K_a$ a constant depending on the doping concentrations.

#note_block(block_colors.note)[
  *Key behavior:* The transition capacitance $C_"T"$ decreases with increasing reverse bias because the depletion region widens, increasing the "plate separation" in the junction capacitor.

  For an *abrupt junction*, this creates a linear relationship between $1/C_T^2$ and applied voltage—a characteristic used to extract doping profiles:
  $ (1)/(C_T^2) = (2(phi.alt_0 - V))/(A^2 q epsilon_s (N_A N_D)/(N_A + N_D)) $

  This *$C_T^{-2}$ vs. $V$ plot* (Mott-Schottky plot) is a standard characterization tool because:
  - It linearizes the capacitance-voltage relationship
  - The slope yields the doping concentration product $N_A N_D$
  - The intercept at $1/C_T^2 = 0$ gives the built-in potential $phi.alt_0$
]

===== Linear graded case
In the case of a *linear graded junction*, we have :
$ Q_"j,linear" = A dot q N_A l_p = A dot q N_D l_n $
#def_block(color: red)[
$ C_"T,linear" = (A epsilon_s)/(l_n + l_p) stretch(=)^"linear" A / (phi.alt_0 - V) K_1  $
]

#note_block(block_colors.note)[
  *Key behavior:* The transition capacitance $C_"T"$ decreases with increasing reverse bias because the depletion region widens, increasing the "plate separation" in the junction capacitor.

  For a *linear graded junction*, this creates a linear relationship between $1/C_T^3$ and applied voltage—a characteristic used to extract doping profiles:
  $ (1)/(C_T^3) = (3(phi.alt_0 - V))/(A^3 q epsilon_s K_1^3) $

  This *$C_T^{-3}$ vs. $V$ plot* is a standard characterization tool because:
  - It linearizes the capacitance-voltage relationship for graded junctions
  - The slope yields information about the doping gradient
  - The intercept at $1/C_T^3 = 0$ gives the built-in potential $phi.alt_0$
]

==== Diffusion Capacitance ($C_"D"$, $C_"diff"$, abrupt junction)

While the transition capacitance ($C_T$) arises from majority carrier rearrangement in the depletion region, a second capacitance mechanism exists due to *minority carrier storage* in the quasi-neutral regions. This is the *diffusion capacitance* ($C_D$).

===== Time scales: Majority vs. Minority carriers

#note_block(block_colors.note)[
  *Majority carriers respond quasi-instantaneously:*

  When the applied voltage $V$ changes, majority carriers rearrange on the *dielectric relaxation time scale*:
  $ tau_"diel" = epsilon_s / sigma approx 10^(-12) "s" $

  This is so fast that even at very high frequencies, the depletion region charges remain in *quasi-static equilibrium* with the instantaneous voltage. We can therefore use DC analysis results at each instant.
]

#note_block(block_colors.warning)[
  *Minority carriers respond slowly:*

  The Boltzmann relations set minority carrier concentrations at the depletion edges as functions of $V$. When $V$ changes, these excess carriers must:
  1. Cross the depletion region
  2. Diffuse into the quasi-neutral regions (over distances $L_n, L_p$)

  This process has a characteristic time $tau approx L^2 / D$, which can be *significant at high frequencies*. In this case, the instantaneous minority carrier distribution *lags behind* the applied voltage, and quasi-static analysis breaks down.
]

===== Derivation of diffusion capacitance

For a simplified analysis, we define the *total excess minority carrier charge* stored in the quasi-neutral regions:
$ Q = Q_(n P) + Q_(p N) $
where $Q_(n P)$ is the excess electron charge in the P-region and $Q_(p N)$ is the excess hole charge in the N-region.

A time-varying voltage causes this stored charge to change, producing a *displacement current*:
$ I = (dif Q)/(dif t) = (dif Q)/(dif V) (dif V)/(dif t) = C_D (dif V)/(dif t) $

This defines the *diffusion capacitance*:
#def_block(color: red)[
$ C_D = (dif Q_(n P))/(dif V) + (dif Q_(p N))/(dif V) $
]

#note_block(block_colors.note)[
  The charge is the sum of the difference in minority carrier concentrations from equilibrium:
  $ Delta n_p (x) = n_p (x) - n_(p 0) stretch(approx)^"Boltzmann" n_(p 0) (e^(V/phi.alt_T) - 1) $
  $ Q_(n P) = A q integral_0^(W_P) Delta n_p (x) dif x $
  #figure(
    image("part3_diagrams/charge interpretation.png", width: 30%),
    caption: [The charge is the area under the excess minority carrier profile in the quasi-neutral region.],
  )
]

===== Short junction case

For a *short junction* (linear minority carrier profile, $W << L$), the excess charge in the P-region of length $W_P$ is:
$ Q_(n P) = A q integral_0^(W_P) Delta n_p (x) dif x = 1/2 A q W_P n_(p 0) (e^(V/phi.alt_T) - 1) $

Taking the derivative with respect to $V$:
$ (dif Q_(n P))/(dif V) = (Q_(n P 0))/(phi.alt_T) e^(V/phi.alt_T) approx (Q_(n P))/(phi.alt_T) $

By analogy for holes in the N-region, the total diffusion capacitance becomes:
#def_block(color: red)[
$ C_D = (A q)/(2 phi.alt_T) e^(V/phi.alt_T) [W_P n_(p 0) + W_N p_(n 0)] $
]

#note_block(block_colors.note)[
  The characteristics of a short junction are the follwowing:
  - *Linear minority carrier profile:* The excess minority carrier concentration varies linearly from the depletion edge to the ohmic contact.
  - *Triangular area for stored charge:* The total stored charge corresponds to the area of a triangle with base $W_P$ and height $n_(p 0)(e^(V/phi.alt_T) - 1)$.
  - *Exponential voltage dependence:* The diffusion capacitance increases exponentially with applied voltage due to the Boltzmann relation at the depletion edge.
  $ n_P (x) = n_(p 0) + n_(p 0)(e^(V/phi.alt_T) - 1)(1 - x/W_P) $
]

===== Comparison: $C_T$ vs. $C_D$

#figure(
  table(
    columns: (2fr, 2.5fr, 2.5fr),
    align: (left, center, center),
    stroke: 0.5pt,
    [*Property*], [*Transition $C_T$*], [*Diffusion $C_D$*],
    [Physical origin], [Depletion width variation], [Minority carrier storage],
    [Voltage dependence], [$prop (phi.alt_0 - V)^(-1/2)$], [$prop e^(V/phi.alt_T)$],
    [Dominant regime], [Reverse bias ($V < 0$)], [Forward bias ($V >> 0$)],
    [Frequency limit], [Valid to very high $f$], [Quasi-static only for $f << 1/tau$],
  ),
  caption: "Comparison of PN junction capacitance mechanisms",
)

#note_block(block_colors.note)[
  *Key insight:*
  - In *forward bias* ($V >> 0$): $C_D >> C_T$ due to exponential growth of stored minority carriers.
  - In *reverse bias* ($V < 0$): $C_D -> 0$ and $C_T$ dominates (used in varactor diodes).
  - Both capacitances are *voltage-dependent*, making the junction a nonlinear capacitor.
]

#figure(
  image("part3_diagrams/pn_cdiff_ct.png", width: 50%),
  caption: [Evolution of transition capacitance $C_T$ and diffusion capacitance $C_D$ with applied voltage $V$ in a PN junction. $C_T$ dominates in reverse bias, while $C_D$ dominates in forward bias.],
)<fig:pn_total_capacitance>

=== Instinctive representation of movements of charges in PN junctions
#todo_block() // TP11, sucking metaphore, and the currents in contacts

#def_block([
  #note_block(block_colors.extra)[
  *Building intuition for PN junction physics:*

  The following mental models help understand why charges move the way they do. While simplified, they capture the essential physics.
]

==== At Equilibrium (No Applied Voltage)

Even with $V = 0$, charges are constantly in motion due to thermal energy. Here's what happens:

1. *Formation of the depletion zone:*
   - At the junction, electrons from the N-side diffuse into the P-side (high $n$ → low $n$)
   - Holes from the P-side diffuse into the N-side (high $p$ → low $p$)
   - These diffusing carriers *recombine* near the junction, leaving behind *fixed ionized dopants*
   - Result: A region depleted of mobile carriers, with exposed $N_D^+$ ions on the N-side and $N_A^-$ ions on the P-side

2. *Built-in electric field:*
   - The exposed ions create an electric field pointing from N to P (positive to negative charges)
   - This field opposes further diffusion: it pushes electrons back to N and holes back to P
   - Equilibrium is reached when *diffusion current = drift current* (net current = 0)

3. *Energy perspective:*
   - Electrons "want" to minimize potential energy
   - The P-side has fewer electrons → less electron-electron repulsion → lower potential energy for electrons
   - But the built-in field creates a *potential barrier* that prevents unlimited flow
   - At equilibrium, the barrier height exactly balances the concentration gradient driving force

#figure(
  ```
  Equilibrium (V = 0):

       P-region      |  Depletion  |      N-region
                     |   Zone      |
    ○ ○ ○ ○ ○ ○ ○   | ⊖ ⊖ | ⊕ ⊕ |   ● ● ● ● ● ● ●
    ○ ○ ○ ○ ○ ○ ○   | ⊖ ⊖ | ⊕ ⊕ |   ● ● ● ● ● ● ●
    (holes ○)        |fixed|fixed|   (electrons ●)
                     |ions |ions |

    ←── Diffusion ───←───────────→─── Diffusion ──→
    ───→ Drift (E) ──→           ←─── Drift (E) ←──

    Net current = 0 (balanced)
  ```,
  caption: "Equilibrium: diffusion and drift currents cancel",
)

==== Forward Bias ($V > 0$, P connected to +)

Applying a positive voltage to P relative to N:

1. *Barrier lowering:*
   - External voltage opposes the built-in field ($phi.alt_0 - V$ instead of $phi.alt_0$)
   - The potential barrier is *reduced* → easier for carriers to cross
   - Depletion width *shrinks* (less "no-man's land" between P and N)

2. *Injection of carriers:*
   - More electrons can now climb over the reduced barrier into the P-side
   - More holes can cross into the N-side
   - These are *minority carriers* in their new regions (electrons in P, holes in N)
   - They diffuse away from the junction and eventually *recombine* with majority carriers

3. *Current flow:*
   - The continuous injection and recombination creates a steady current
   - Current grows *exponentially* with voltage: $I prop e^(V/phi.alt_T)$
   - Convention: Current flows from P to N (opposite to electron flow)

#figure(
  ```
  Forward Bias (V > 0):

    +V ──→ P-region  |  ZD  |  N-region ──→ 0V
                     |(thin)|
    ○ ○ ○ →● ● →    | ⊖|⊕ |    ←○ ○← ● ● ●
    (holes)  ↓recomb |     |  recomb↓  (electrons)
             ●→○     |     |     ○←●

    Electrons: N → P (minority injection into P)
    Holes: P → N (minority injection into N)
    Current I: P → N (exponentially large)
  ```,
  caption: "Forward bias: barrier lowered, carriers injected, large current",
)

==== Reverse Bias ($V < 0$, P connected to −)

Applying a negative voltage to P relative to N:

1. *Barrier raising:*
   - External voltage *adds* to the built-in field ($phi.alt_0 + |V|$)
   - The potential barrier is *increased* → harder for carriers to cross
   - Depletion width *grows* (more ionized dopants exposed)

2. *Extraction of carriers:*
   - Minority carriers near the junction edges are *swept across* by the strong field
   - Electrons in P are pulled to N; holes in N are pulled to P
   - But there are very few minority carriers → only a tiny current

3. *Generation current:*
   - Thermal generation creates EHPs in the depletion region
   - The strong field immediately separates them (electrons → N, holes → P)
   - This *generation current* is nearly independent of voltage (until breakdown)
   - Result: Small, approximately constant reverse current $I approx -I_s$

#figure(
  ```
  Reverse Bias (V < 0):

    -V ──→ P-region  |   Depletion   |  N-region ──→ 0V
                     |   (wide)      |
    ○ ○ ○ ○ ○ ○     | ⊖ ⊖ ⊖ | ⊕ ⊕ ⊕ |     ● ● ● ● ●
                     |   ↑   |   ↑   |
                     | thermal generation
                     | e→    |    ←h |

    Few minority carriers to extract → tiny current
    Current I ≈ -I_s (small, roughly constant)
  ```,
  caption: "Reverse bias: barrier raised, depletion widened, tiny current",
)

==== Sign Conventions and Directions

#figure(
  table(
    columns: (2fr, 1.5fr, 1.5fr, 2fr),
    align: (left, center, center, left),
    stroke: 0.5pt,
    [*Quantity*], [*Direction*], [*Sign*], [*Physical meaning*],
    [Voltage $V$], [P → N], [+ forward], [P at higher potential than N],
    [Electric field $E$], [N → P], [Negative], [Points from + to − charges in depletion],
    [Electron flow], [N → P (fwd)], [—], [Electrons move opposite to $E$ in drift],
    [Hole flow], [P → N (fwd)], [—], [Holes move along $E$ in drift],
    [Current $I$], [P → N], [+ forward], [Conventional current (opposite to $e^-$ flow)],
  ),
  caption: "Sign conventions for PN junction analysis",
)

#note_block(block_colors.trick)[
  *Memory aid for directions:*
  ```
  P ←─V─→ N     (Voltage defined P to N)
  P ←─E── N     (E-field points N to P, into the negative)
  P ←─e⁻─ N     (Electrons flow N to P in forward bias)
  P ──h⁺→ N     (Holes flow P to N in forward bias)
  P ──I─→ N     (Conventional current P to N in forward bias)
  ```

  *Key insight:* Current direction = hole flow direction = opposite of electron flow direction.
]

==== Why Does Forward Current Grow Exponentially?

The Boltzmann factor $e^(V/phi.alt_T)$ appears because:

1. Carriers follow *Boltzmann statistics*: probability of having energy $E$ scales as $e^(-E/(k T))$
2. The barrier height is $q(phi.alt_0 - V)$, so probability of crossing scales as $e^(-q(phi.alt_0 - V)/(k T))$
3. Since $e^(-q phi.alt_0/(k T))$ is constant (absorbed into $I_s$), current $prop e^(q V/(k T)) = e^(V/phi.alt_T)$

*Physical intuition:* Each $phi.alt_T approx 26$ mV increase in voltage increases the number of carriers with enough energy to cross by a factor of $e approx 2.7$. This is why the curve is so steep!

==== Why Is Reverse Current Nearly Constant?

In reverse bias:
- The barrier is *too high* for majority carriers to cross (would need energy $> q(phi.alt_0 + |V|)$)
- Current comes only from *minority carriers* generated thermally near the junction
- Generation rate depends on temperature and material, not on voltage
- Result: $I approx -I_s$ until breakdown (where new mechanisms kick in)

*Caveat:* The depletion width grows as $sqrt(phi.alt_0 + |V|)$, so generation current actually increases slightly with $|V|$ (more volume for thermal generation). This is the *generation-recombination current* contribution.
])

//// ------------------------------------------------------------------------------------------------

== Bipolar Junction Transistors (PNP, NPN) // NEW SECTION
BJTs use both electron and hole charge carriers, and they offer high gain and good high-frequency performance. In an *NPN transistor, the essential current is carried by electrons*, while in a *PNP transistor it is carried by holes*. These carriers always flow *from the emitter* (the origin of the carriers) *to the collector* (the collector of the carriers), while the base is used to control the current flowing through the device.#block()

This is why the *emitter is always more heavily doped than the collector*. Through the injection or extraction of current in the base region (that is, the injection of minority carriers), the current flowing from the emitter to the collector can be controlled.#block()

The main *difference between NPN and PNP* transistors lies in the *polarities of their voltages and currents*. Because N-type carriers are about three times more mobile than P-type carriers in silicon, *NPN transistors are more common in integrated circuits and are generally more efficient*. PNP transistors are mainly used to complement NPN transistors in certain circuit topologies, such as complementary designs.

=== The BJT structure and operation
==== Bipolar Structure
A Bipolar Junction Transistor (BJT) consists of *three regions of semiconductor material* with alternating doping types, forming two PN junctions. The three regions are called the *emitter (E)*, *base (B)*, and *collector (C)*.#block()

#figure(
  image("part3_diagrams/BJT_comparison.svg", width: 50%),
  caption: [Structure of an NPN Bipolar Junction Transistor (BJT) with its three regions: Emitter (E), Base (B), and Collector (C).],
)#block()

All currents enter the transistor, so by applying Kirchhoff's current law, we have :
$ I_B + I_E + I_C = 0 $
Then we have the different voltages, defined as :
$ V_"BE" = V_B - V_E $
$ V_"BC" = V_B - V_C $
$ V_"CE" = V_C - V_E $
With these definitions, we have the relation :
$ V_"CE" = V_"BC" + V_"BE" $

#block()

#note_block(block_colors.extra)[
  *Fabrication details (planar technology):*#block()

  The structure of an NPN bipolar transistor is shown in the following figure and is fabricated using planar technology.

  #figure(
    image("part3_diagrams/bjt_planar_epitaxy.png", width: 60%),
    caption: [Planar fabrication process of an NPN BJT using epitaxial growth and diffusion steps.],
  )#block()

  A *thin, heavily doped N-type layer (N⁺)* is first created by epitaxial growth on the surface of a heavily doped substrate. Epitaxy is a silicon growth technique that allows a *crystalline layer* with controlled thickness and doping to be *deposited on the surface*. The substrate, connected by a metallic layer, forms the collector contact of the device.#block()

  After *surface oxidation*, a *window is opened* in the oxide layer, through which *P-type impurities are diffused* to create the first junction. A surface contact is then formed in this region, which serves as the base contact (B).#block()

  A *new oxidation step creates a smaller window inside the base region*. Through this opening,* N-type impurities are diffused* to form the *emitter region,* where the emitter contact (E) is placed.

  #figure(
    image("part3_diagrams/bjt_planar_epitaxy_reality.png", width: 50%),
    caption: [Integrated transistor structure fabricated using planar technology.],
  )#block()
]

==== Polarisations (Active, Saturation, Cut-off, Inverse)
#figure(
  table(
    columns: (2fr, 2fr, 2fr, 2fr),
    align: (center, center, center, center),
    stroke: 0.5pt,
    [*Region*], [*$V_"BE"$*], [*$V_"BC"$*], [*Operation*],
    [Active], [> 0.7], [< 0], [Amplification mode\ Electron flow $E->C$,\ $I_B$ small],
    [Saturation], [> 0.7], [> 0.7], [Both Diodes Biased\ Electron flow $E->C$,\ $I_B$ large],
    [Cut-off], [< 0], [< 0], [Both Diodes Off\ No electron flow,\ $I_B approx 0$],
    [Inverse], [< 0], [> 0.7], [Collector Diode Biased\ Electron flow $C->E$,\ $I_B$ small],
  ),
  caption: "BJT operating regions based on junction polarizations",
)
Polariazation consists of 4 regions, depending on the voltages $V_"BE"$ and $V_"BC"$, resulting in the activation of the diodes or of a charge flow between the different regions of the BJT.#block()

Let us describe the charge flow in each region :
- *Active region:* The base-emitter junction is forward biased ($V_"BE" > 0.7$ V), allowing electrons to be injected from the emitter into the base. The base-collector junction is reverse biased ($V_"BC" < 0$ V), enabling these electrons to be swept into the collector. This region is used for amplification, with a small base current controlling a larger collector current.#block()
- *Saturation region:* Both the base-emitter and base-collector junctions are forward biased ($V_"BE" > 0.7$ V and $V_"BC" > 0.7$ V). This allows maximum electron flow from the emitter to the collector, with a large base current. The transistor is fully "on" in this region.#block()
- *Cut-off region:* Both junctions are reverse biased ($V_"BE" < 0$ V and $V_"BC" < 0$ V), preventing any significant electron flow. The transistor is "off," with negligible collector current.#block()
- *Inverse region:* The base-emitter junction is reverse biased ($V_"BE" < 0$ V), while the base-collector junction is forward biased ($V_"BC" > 0.7$ V). This causes electrons to flow from the collector to the emitter, opposite to the normal operation. The transistor can conduct in this mode, but it is less efficient.#block()

#grid(
  columns: (1fr, 1fr),
  gutter: 20pt,
  [
    #figure(
      image("part3_diagrams/BJT_activation_regions_Ideal.svg", width: 80%),
      caption: [BJT activation regions for a ideal NPN transistor based on $V_"BE"$ and $V_"BC"$.],
    )
  ],
  [
    #figure(
      image("part3_diagrams/BJT_activation_regions_Real.svg", width: 80%),
      caption: [BJT activation regions for a real NPN transistor based on $V_"BE"$ and $V_"BC"$. (With a hypotetical junction voltage of $approx 0.7$ V).],
    )
  ]
)

==== Quick analysis of current injection
In the *active mode*, as the emitter is more heavily doped than the base ($N_E >> N_B$), then the amount of $p$ minorities in the emitter is very small. Therefore, there will be *much fewer holes injected from the base to the emitter*. #block()

The base, being very thin ($W_B << L_n, L_p$), allows most of the electrons injected from the emitter to *diffuse through the base without recombining* and reach the base-collector junction. As this junction is reverse biased, these electrons are *swept into the collector*, resulting in a large collector current ($I_C$).#block()

The base current ($I_B$) is primarily due to the *small number of electrons that recombine with holes in the base region*. Since the base is thin and lightly doped, this recombination current is much smaller than the collector current. #block()

The *base metal contact* provides both electrons and holes to maintain charge neutrality. The final base current ($I_B$) consists of three components:

#grid(
  columns: (1fr, 20fr),
  gutter: 12pt,
  align: (center, left),

  [*1*], [*Hole injection to emitter :* Holes from the base contact and base region diffuse into the emitter where they recombine with injected electrons.],

  [*2*], [*Base recombination :* Holes from the contact recombine with electrons from the emitter throughout the base region, limiting the collector current.],

  [*3*], [*Electron replacement current :* Electrons from the contact replenish the base, replacing those swept into the collector by the reverse-biased base-collector junction.],
)

#note_block(block_colors.note)[
  The base current can be approximated as the sum of these three components. However, in practice, component (2)—*recombination within the base*—dominates, since the base is thin and lightly doped, minimizing the hole injection into the emitter (component 1).
]

#figure(
  image("part3_diagrams/BJT_simple_analysis.png", width: 70%),
  caption: [Simple current flow analysis in an NPN BJT in active mode.],
)

Equations :
- Emitter current ($I_E$)
  - Electron flow to collector : $I_(E -> C, n) = gamma I_E$
  - Electron recombination from base : $I_(E -> B, n) = (1 - gamma) I_E = I_(B->E, p, 1) = I_B - I_(C B 0) - (gamma - alpha )I_E $
- Base current ($I_B$)
  - Hole injection to emitter : $I_(B->E, p, 1) = (1 - gamma) I_E$
  - Electron recombination from emitter : $I_(B->C, p, 2) = (gamma - alpha )I_E$
  - Electron replacement current : $I_(B->C, n) = I_(C B 0)$
- Collector current ($I_C$)
  - Electron flow from emitter : $I_(E -> C, n) = -alpha I_E$
  - Hole recombination from base : $I_(C->B, p) = I_(C B 0)$

#block()
Typical values for the parameters :
- $I_(C B 0)$ : *Leakage current* from the blocked base-collector junction (very small, in the order of pA)
- $gamma$ : *Emitter injection efficiency* (close to 1, typically 0.98 - 0.999)
- $alpha$ : *Common-base current gain* (also close to 1, typically 0.95 - 0.998)
#block()
Equations summary :
$ I_C &= -alpha I_E + I_(C B 0) approx - alpha I_E \ &= alpha/(1 - alpha) I_B = beta I_B $
$ I_E = -(I_C + I_B) $
$ beta = alpha/(1 - alpha) approx 100 - 200 $

#note_block(block_colors.note)[
  Note: This simplified analysis follows the conventions used in the course notes.
]

#grid(
  columns: (1fr, 1fr),
  gutter: 20pt,
  [
    #figure(
      image("part3_diagrams/Wikipedia/NPN_Band_Diagram_Equilibrium.svg", width: 80%),
  caption: [Band diagram for NPN transistor at equilibrium, showing no net current flow.],
    )
  ],
  [
    #figure(
      image("part3_diagrams/Wikipedia/NPN_Band_Diagram_Active.svg", width: 80%),
  caption: [Band diagram for NPN transistor in *active mode*, showing injection of electrons from emitter to base, and their overshoot into the collector.],
    )
  ])


==== The simple model (Ebers-Moll)
The *Ebers-Moll model* is a widely used equivalent circuit representation of the Bipolar Junction Transistor (BJT). It captures the essential behavior of the BJT in different operating regions by modeling it as two coupled diodes with current sources.#block()
#grid(
  columns: (1fr, 1fr),
  gutter: 20pt,
  [
    #figure(
      image("part3_diagrams/Wikipedia/Ebers_Moll_model_schematic_NPN.svg", width: 80%),
      caption: [Ebers-Moll model for an NPN BJT.],
    )
  ],
  [
    #figure(
      image("part3_diagrams/Wikipedia/Ebers_Moll_model_schematic_PNP.svg", width: 80%),
      caption: [Ebers-Moll model for a PNP BJT.],
    )
  ]
)

In this model, the BJT is represented by two diodes: one between the base and emitter (BE junction) and another between the base and collector (BC junction). The model includes current sources that account for the transistor action, allowing current flow from emitter to collector controlled by the base-emitter voltage.#block()

In Wikipedia, the *approximated* Ebers-Moll equations for an NPN transistor are given by :
$ I_E &= I_(E S) ( e^( V_"BE" / phi.alt_T ) - 1 ) \
  I_C &= alpha_F I_E \
  I_B &= (1 - alpha_F) I_E
$
The base internal current is mainly through diffusion of electrons from emitter to collector, with a small recombination current in the base (Fick's Law). Where :
- $I_(E S)$ : Saturation current of the emitter-base diode
- $alpha_F$ : Forward common-base short circuit current gain (approx 0.98 - 0.998)

The *non-approximated* Ebers-Moll equations for an NPN transistor are given by :
$ i_E &= I_S [(e^(V_"BE"/phi.alt_T) - e^(V_"BC"/phi.alt_T)) + 1/beta_F (e^(V_"BE"/phi.alt_T) -1)]\
i_C &= I_S [(e^(V_"BE"/phi.alt_T) - e^(V_"BC"/phi.alt_T)) - 1/beta_R (e^(V_"BC"/phi.alt_T) -1)]\
i_B &= I_S [1/beta_F (e^(V_"BE"/phi.alt_T) -1) + 1/beta_R (e^(V_"BC"/phi.alt_T) -1)]
$

With the final parameters as :
- $alpha = I_C/I_E$ : Common-base current gain (approx 0.95 - 0.998)
- $beta_R = I_E/I_B$ : Reverse common-emitter current gain (approx 1 - 10)
- $beta_F = I_C/I_B$ : Forward common-emitter current gain (approx 100 - 200)

In the course, the Ebers-Moll model is sligtly differently epxressed but equivalent :
#figure(
  image("part3_diagrams/Ebers-Mol Model.png", width: 30%),
  caption: [Ebers-Moll model from the course, for a active NPN BJT.],
)

#note_block(block_colors.extra)[\
  *Fick's Law application:*#block()
  The electron current density in the base region is derived from Fick's Law of diffusion, which states that the flux of particles is proportional to the concentration gradient. In the BJT, the excess minority carrier concentration in the base due to forward biasing of the BE junction leads to a diffusion current of electrons from the emitter to the collector.#block()
  The expression $ J_(n, "base") = (1/W) q D_n n_(b 0) e^( V_"BE" / phi.alt_T ) $ captures this diffusion current density, where:
  - $W$ is the width of the base region,
  - $q$ is the elementary charge,
  - $D_n$ is the diffusion coefficient for electrons,
  - $n_(b 0)$ is the equilibrium minority carrier concentration in the base,
  - $e^( V_"BE" / phi.alt_T )$ represents the increase in minority carrier concentration due to the applied base-emitter voltage. #block()
  This diffusion current is the primary contributor to the collector current in the active region of BJT operation, as most electrons injected from the emitter diffuse through the thin base and are swept into the collector by the reverse-biased BC junction.
]


#figure(
  image("part3_diagrams/BJT_equivalent_diagram_activations.svg", width: 70%),
  caption: [Ebers-Moll equivalent circuit diagrams for the four BJT operating regions.],
)

==== Characteristic Curves

#grid(
  columns: (1fr, 1fr),
  gutter: 20pt,
  [
    #figure(
      image("part3_diagrams/BJT_Common_Emitter_CM.png", width: 80%),
      caption: [Common-emitter output characteristics ($I_C$ vs. $V_"CE"$) of an NPN BJT for various base currents $I_B$.],
    )
  ],
  [
    #figure(
      image("part3_diagrams/BJT_Common_base_CM.png", width: 80%),
      caption: [Common-base output characteristics ($I_C$ vs. $V_"CE"$) of an NPN BJT for various emitter currents $I_E$.],
    )
  ]
)

#figure(
  image("part3_diagrams/Berkley/BJT_berkley_chenming_hu_Common_Emitter_curves.png", width: 60%),
  caption: [ (a) Common-emitter convention; (b) IC vs. VCE; (c) IB may be used as the
parameter instead of VBE; and (d) circuit symbol of an NPN BJT and an inverter circuit.],
)

=== Working principle analysis of the BJT
We will now analyze only the cases of the NPN transistor, as the PNP transistor works the same way, but with inverted polarities and currents, and a factor 3 in mobility $mu_p$.#block()

The only zone in the BJT we will have to analyze is the *base region*, as this zone will be proportionally influenced by the two junctions, and the other two regions don't have another junction to influence them.#block()

#figure(
  image("part3_diagrams/BJT_zones_and_distributions.png", width: 50%),
  caption: [Diffusion zones, dimensions and parameters of an NPN polarized BJT.],
)

By applying the same reasoning as for the PN junction, we can find the different concentrations of electrons and holes in the different regions of the BJT, depending on the polarizations of the two junctions.#block()

Let us apply the electron (minoritary carrier in the base) *diffusion equation* in the base region :
$ D_n (dif^2 n(x)) / (dif x^2) - (n(x) - n_(b 0)) / tau_n = 0 --> (dif^2 n'(x))/(dif x^2) = (n'(x))/L_n^2 $

To apply the boundary conditions, we need to know the excess electron concentrations at the edges of the base region. This means that we have to know the *working mode* of the BJT before continuing with the math.#block()

#figure(
  image("part3_diagrams/BJT_carrier_bands_modes.svg", width: 80%),
  caption: [Carrier band representations of all the different BJT operating modes. This is not exactly how the band diagrams would look, but it gives an idea of the carrier distributions in each mode.],
)<fig:bjt_carrier_bands_modes>

#note_block(block_colors.extra)[
  *Quick summary: Key equations for PN junction analysis*

  #figure(
    table(
      columns: (1.5fr, 3fr, 2fr),
      align: (left, left, center),
      stroke: 0.5pt,
      [*Quantity*], [*Equation*], [*When to use*],

      [*Built-in Potential*], [$phi.alt_0 = (k T)/q ln((N_A N_D)/n_i^2)$], [At equilibrium ($V=0$)],

      [*Depletion Width*], [$W = sqrt((2 epsilon_s)/(q) (phi.alt_0 - V) ((N_A + N_D)/(N_A N_D)))$], [Any bias $V$],

      [*Max Electric Field*], [$E_"max" = sqrt((2 q)/(epsilon_s) (phi.alt_0 - V) (N_A N_D)/(N_A + N_D))$], [Peak at metallurgical junction],

      [*Excess Minority Carriers*], [$n_p (-l_p) = n_(p 0) e^(V/phi.alt_T)$, $p_n (l_n) = p_(n 0) e^(V/phi.alt_T)$], [At depletion edges],

      [*Saturation Current Density*], [$J_s = q n_i^2 (1/N_A sqrt(D_n/tau_n) + 1/N_D sqrt(D_p/tau_p))$], [Forward & reverse bias],

      [*Diode I-V*], [$I = I_s (e^(V/phi.alt_T) - 1)$], [Active operation],

      [*Transition Capacitance*], [$C_T = (A epsilon_s)/(l_n + l_p) prop (phi.alt_0 - V)^(-1/2)$], [Reverse bias dominates],

      [*Diffusion Capacitance*], [$C_D prop e^(V/phi.alt_T)$], [Forward bias dominates],
    ),
    caption: "Essential PN junction formulas for quick reference.",
  )

  #grid(
    columns: (1fr, 1fr),
    gutter: 12pt,
    [
      #figure(
        image("part3_diagrams/Diode Diagram.svg", width: 30%),
        caption: [Diode symbol and polarizations],
      )
      #figure(
        image("part3_diagrams/energy_junctions.png", width: 95%),
        caption: [Band diagram under bias],
      )

    ],
    [
      #figure(
        image("part3_diagrams/PN analytical solution.png", width: 95%),
        caption: [Depletion model: three zones],
      )
    ],
  )

  #text(size: 9pt, style: "italic")[
    *Memory tricks:*
    - $phi.alt_0$ increases with doping (narrower depletion)
    - $C_T$ ∝ $1/sqrt(V)$ (varactor diodes use this)
    - $J_s$ doubles ~every 7–8°C (exponential $T$-dependence from $n_i^2$)
    - Forward bias: $I prop e^(V/phi.alt_T)$ (sharp exponential growth)
    - Reverse bias: $I approx -I_s$ (nearly flat until breakdown)
  ]
]

==== Active Mode
In the active mode, the base-emitter junction is forward biased ($V_"BE" > 0$ V) and the base-collector junction is reverse biased ($V_"BC" < 0$ V).\
With the *boundary conditions* on the excess electron concentration $n'(x) = n(x) - n_(b 0)$ :
- At $x = 0$ (Base-Emitter junction) : $n'(0) = n_(b 0) ( e^( V_"BE" / phi.alt_T ) - 1 ) approx n_(b 0) e^( V_"BE" / phi.alt_T )$
- At $x = W_B$ (Base-Collector junction) : $n'(W_B) = n_(b 0) ( e^( V_"BC" / phi.alt_T ) - 1 ) approx -n_(b 0) approx 0$#block()

With $n'(W_B) << n'(0)$.
The solution of this equation gives the electron concentration profile in the base region :
$ n'(x) = n_(b 0) (e^(V_"BE"/phi.alt_T) - 1) (sinh((W_B - x)/L_n) / sinh(W_B/L_n)) $
As $W_B << L_n$, we can *approximate* $sinh(W_B/L_n) approx W_B/L_n$ and $sinh((W_B - x)/L_n) approx (W_B - x)/L_n$. Therefore, the electron concentration profile simplifies to :
$ n'(x) approx n_(b 0) (e^(V_"BE"/phi.alt_T) - 1) (1 - x/W_B) $
#figure(
  image("part3_diagrams/Berkley/BJT_berkley_base_approx.png", width: 30%),
  caption: [ Approximate excess minority carrier concentration profile in the base region of an NPN BJT in active mode.],
)#block()
Then, with $n_(b 0)= n_(b i)^2/N_B$, we can find the *electron diffusion current density* in the base region using Fick's Law :
$ J_(n, "base") = q underbrace(D_n, mu_n phi.alt_T)(dif n'(x))/(dif x) = 1/W_B q D_n n_(b 0) (e^( V_"BE" / phi.alt_T ) -1) $
#note_block(block_colors.note)[
  The cross sectional area of charge contribution is approximately :
  $ A_E J_(n B) = Q_(n B 0)/ tau_T (e^(V_"BE"/phi.alt_T) -1 ) $
  Where $Q_(n B 0) = q A_E L_n n_(b 0)$ is the total equilibrium charge of electrons in the base, and $tau_T = W_B^2 / (2 D_n)$ is the transit time of electrons through the base.

  Similarly, we can calculate $J_(p E)$ from the diffusion of excess holes minorities in the ZQN of the emitter.
]

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  align: horizon,
  stroke: 0.1pt,
  inset: 10pt,
  [
    #figure(
      image("part3_diagrams/BJT_Emittor_active_base current.png", width: 60%),
      caption: [Charge representation of the charge in the base from the emittor ($J_(n B)$)],
    )
  ],
  [
    $"CL :"&cases(n_B'(0) = n_(b 0) (e^(V_"BE"/phi.alt_T) - 1), n_B'(W_B) approx 0 )\
      n_B' (x) &approx n_(b 0) (e^(V_"BE"/phi.alt_T) - 1) (1 - x/W_B) \
      J_(n B)(x) &= q D_n (dif n_B'(x))/(dif x) = 1/W_B q D_n n_(b 0) (e^( V_"BE" / phi.alt_T ) -1) \
      Q_(n B)(x) &= integral_0^(W_B) q n_B'(x) A_E dif x = 1/2 q A_E W_B n_(b 0) (e^( V_"BE" / phi.alt_T ) -1)
    $
  ],
  [
    #figure(
      image("part3_diagrams/BJT_Emittor_active_emittor current.png", width: 60%),
      caption: [Charge representation of the charge in the emitter from the emitter ($J_(p E)$)],
    )
  ],
  [
    $"CL :"&cases(p_E'(-l_E) = p_(e 0) (e^(V_"BE"/phi.alt_T) - 1), p_E'(0) approx 0 )\
      p_E' (x) &approx p_(e 0) (e^(V_"BE"/phi.alt_T) - 1) (1 + x/l_E) \
      J_(p E)(x) &= -q D_p (dif p_E'(x))/(dif x) = - 1/l_E q D_p p_(e 0) (e^( V_"BE" / phi.alt_T ) -1) \
      Q_(p E)(x) &= integral_(-l_E)^0 q p_E'(x) A_E dif x = 1/2 q A_E l_E p_(e 0) (e^( V_"BE" / phi.alt_T ) -1)
    $
  ]
) #block()
We can now get the full *Emitter current* $I_E$ as the sum of the electron diffusion current from the emitter to the base and the hole diffusion current from the base to the emitter :
$ I_E = A (J_(n, "base") + J_(p, "emittor")) $

Where we can also obtain the other 2 currents :
$ I_B = -A*J_(p, "emittor") $
$ I_C = -A*J_(n, "base") $

Then, as the *base-collector junction* is reverse biased, there is *no significant injection of carriers* from the collector to the base. Therefore, the excess minority carrier concentration at the base-collector junction is approximately zero.#block()
$ J_(p, "collector") approx 0 $

Using the same collector current found :
$ I_C = -A J_(n B) = I_s (e^( V_"BE" / phi.alt_T ) -1) = I_F $
Where :
- *Saturation current* : $ I_s = A q D_n n_(p 0)/W_B$
- *Forward current (Transport Current)* : $ I_F = I_s (e^( V_"BE" / phi.alt_T ) -1)$

Then, the *base current* can be re-defined as :
$ I_B = A J_(p E) = I_F / beta_F $

From here we can re-define the *emitter current* as :
$ I_E = A( J_(n B) + J_(p E) ) = - (1 + 1/beta_F) I_F $

Where we can find the *current gain* as :
$ beta_F = I_C / I_B = (J_(n B)) / (J_(p E)) = (mu_(n B) W_E N_(D E))/(mu_(p E) W_B N_(A B)) $

#note_block(block_colors.note)[
  In common emitter, the relationship between the currents is :
  $ I_C = beta_F I_B $
  If in common base, the relationship is :
  $ I_C = -alpha_F I_E $
  with $ alpha_F = beta_F / (beta_F + 1) approx 1 $
  (With all currents entering the transistor)
]

==== Inverse Mode
In the inverse mode, the base-emitter junction is reverse biased ($V_"BE" < 0$ V) and the base-collector junction is forward biased ($V_"BC" > 0$ V).#block()
With the *boundary conditions* on the excess electron concentration $n'(x) = n(x) - n_(b 0)$ :
- At $x = 0$ (Base-Emitter junction) : $n'(0) = n_(b 0) ( e^( V_"BE" / phi.alt_T ) - 1 ) approx -n_(b 0) approx 0$
- At $x = W_B$ (Base-Collector junction) : $n'(W_B) = n_(b 0) ( e^( V_"BC" / phi.alt_T ) - 1 ) approx n_(b 0) e^( V_"BC" / phi.alt_T )$#block()
With $n'(0) << n'(W_B)$.
The solution of this equation gives the electron concentration profile in the base region :
$ n'(x) = n_(b 0) (e^(V_"BC"/phi.alt_T) - 1) (sinh(x/L_n) / sinh(W_B/L_n)) $
As $W_B << L_n$, we can *approximate* $sinh(W_B/L_n) approx W_B/L_n$ and $sinh(x/L_n) approx x/L_n$. Therefore, the electron concentration profile simplifies to :
$ n'(x) approx n_(b 0) (e^(V_"BC"/phi.alt_T) - 1) (x/W_B) $

#grid(
  columns: (1fr, 2fr),
  gutter: 10pt,
  align: horizon,
  stroke: 0.1pt,
  inset: 10pt,
  [
    #figure(
      image("part3_diagrams/BJT_Inverse_base_collector.png", width: 80%),
      caption: [Charge representations of both the base current ($J_(n B)$) and collector current ($J_(p C)$) in inverse mode.],
    )
  ],
  [
    $"CL :"&cases(n_B'(0) approx 0, n_B'(W_B) = n_(b 0) (e^(V_"BC"/phi.alt_T) - 1) )\
      n_B' (x) &approx n_(b 0) (e^(V_"BC"/phi.alt_T) - 1) (x/W_B) \
      J_(n B)(x) &= q D_n (dif n_B'(x))/(dif x) = - 1/W_B q D_n n_(b 0) (e^( V_"BC" / phi.alt_T ) -1) \
      Q_(n B)(x) &= integral_0^(W_B) q n_B'(x) A_E dif x = 1/2 q A_E W_B n_(b 0) (e^( V_"BC" / phi.alt_T ) -1)
    $
    $"CL :"&cases(p_C'(W_B) = p_(c 0) (e^(V_"BC"/phi.alt_T) - 1), p_C'(0) approx 0 )\
      p_C' (x) &approx p_(c 0) (e^(V_"BC"/phi.alt_T) - 1) (1 - (W_B - x)/l_C) \
      J_(p C)(x) &= -q D_p (dif p_C'(x))/(dif x) = 1/l_C q D_p p_(c 0) (e^( V_"BC" / phi.alt_T ) -1) \
      Q_(p C)(x) &= integral_0^(l_C) q p_C'(x) A_E dif x = 1/2 q A_E l_C p_(c 0) (e^( V_"BC" / phi.alt_T ) -1)
    $
  ]
)
We can then define the *Emitter current* $I_E$ from the *Base current density* $J_(n B)$, as well as the *Reverse Transport Current* $I_R$ :
$ I_E = A J_(n, "base") = I_s (e^( V_"BC" / phi.alt_T ) -1) = I_R $
Where :
- *Saturation current* : $ I_s = A q D_n n_(p 0)/W_B$
- *Reverse Transport Current* : $ I_R = I_s (e^( V_"BC" / phi.alt_T ) -1)$

The *Collector current* can be defined by the sum of both current densities :
$ I_C = - A (J_(n, "base") + J_(p, "collector")) = -(1+ 1/(beta_R))I_R $
Where the *reverse current gain* is defined as :
$ beta_R = I_E / I_B = (J_(p C)) / (J _(n B)) = (mu_(p C) W_B N_(A B))/(mu_(n B) W_C N_(D C)) $

Finally, we can define the *Base current* as :
$ I_B = - A J_(p, "collector") = I_E/(beta_R) = I_R / beta_R $

We generally never use it in this mode, as the gain $beta_R$ is very small (1 - 10), compared to $beta_F$ (100 - 200), that gets boosted through asymetrical doping of the emitter ($N_D^+$) and collector ($N_D^-$).#block()

#note_block(block_colors.note)[
  With $I_s$ the same as in active mode.
]

#note_block(block_colors.note)[
  In common emitter, the relationship between the currents is :
  $ I_C = - (1 + 1/beta_R) I_R $
  If in common base, the relationship is :
  $ I_C = alpha_R I_E $
  with $ alpha_R = beta_R / (beta_R + 1) approx 1 $
  (With all currents entering the transistor)
]

#note_block(block_colors.warning)[
  We can derive other properties if :
  - $W_E$ = $W_C$
  - $mu_(n B) = mu_(p C)$
  Then , we have :
  $ cases(beta_F -> N_(D E) approx 10 N_(A B), beta_R -> N_(D C) approx N_(A B)/10) $
  Though, in practice, we will often set $W_E$ < $W_C$ to improve the injection efficiency of the emitter. (By allowing more electrons to be injected than holes, meaning, increasing $beta_F$)
]

==== Saturation Mode
The saturation mode occurs when both the base-emitter junction and the base-collector junction are forward biased ($V_"BE" > 0$ V and $V_"BC" > 0$ V).#block()
Here is the setup :
#grid(
  columns: (1fr, 1fr),
  gutter: 20pt,
  [
    #figure(
      image("part3_diagrams/BJT_Ebersmoll_saturation_setup.png", width: 40%),
      caption: [Ebers-Moll equivalent circuit diagram for an NPN BJT in saturation mode.],
    )
  ],
  [
    #figure(
      image("part3_diagrams/BJT_Saturation circuit example_common_emitter.png", width: 60%),
      caption: [Common emitter (*emitter to ground*) amplifier circuit example in saturation mode.],
    )
  ],
)#block()

We first have to know how/when does the BJT enters saturation mode. From the above circuit, we can derive :
- If $V_"in"> 0$ V :
$ I_B approx (V_"in" - 0.7)/R_1 " & " I_C = beta_F I_B " & " V_"out" = (5 - I_C *R_2) $
- If $V_"out" < 0.7$ V :
$ "The B-C junction flows, and the transistor saturates" $

#block()
We can then describe the flows of carriers in this mode :
#figure(
  image("part3_diagrams/BJT_saturation_current_densities_flows.png", width: 50%),
  caption: [Carrier flows in an NPN BJT in saturation mode. Both junctions are forward biased, leading to significant injection of carriers from both the emitter and collector into the base.],
) #block()

We define the total *Base minority current density* $J_(n B)$ as :
$ J_(n B) =& J_(n, "emittor to base") + J_(n, "collector to base")\
 =& I_s/A [(e^(V_(B E)/phi.alt_T) - 1) - (e^(V_(B C)/phi.alt_T) - 1)] $

We can now analyze the charge profiles to compute the inverse and forward transport currents.#block()
#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  [
    #figure(
      image("part3_diagrams/BJT_saturation_charge_densities_superimposition.png", width: 80%),
      caption: [Charge flows from both the emitter and collector into the base in saturation mode.],
    )
  ],
  [
    #figure(
      image("part3_diagrams/BJT_saturation_charge_densities_excedent_finalization.png", width: 80%),
      caption: [Final excess charge profile in the base region, resulting from the superposition of charges injected from both the emitter and collector.],
    )
  ]
)
#note_block(block_colors.warning)[
  If $W_B$ is too large, then, the current flow will greatly decrease, as recombination in the base will increase. This is why BJTs are made with very thin bases.
]
Let us define the forward and reverse transport currents as :
$ I_F = I_s (e^( V_"BE" / phi.alt_T ) - 1) $
$ I_R = I_s (e^( V_"BC" / phi.alt_T ) - 1) $
With $I_s = A q D_n n_(p B 0)/W_B $
With the final current being :
$ I_C = - A J_(n B) = I_F - I_R $

#note_block(block_colors.note)[
  We can see that, in saturation mode, both transport currents $I_F$ and $I_R$ contribute to the total current flow through the BJT. The excess minority carrier concentration in the base region is increased due to injection from both the emitter and collector, leading to a higher overall current flow compared to active or inverse modes.
]

==== Complete Model (Ebers-Moll)
The complete Ebers-Moll model accounts for both forward and reverse transport currents in the BJT, allowing it to accurately describe the transistor's behavior in all operating regions (active, inverse, saturation, and cutoff).#block()
#figure(
  image("part3_diagrams/BJT_ebers_mol_sylla.png", width: 30%),
  caption: [Complete Ebers-Moll model for an NPN BJT, incorporating both forward and reverse transport currents.],
)
Equations :
$
  cases(
  I_C &= -A(J_(n B) + J_(p C))
    &=& (I_F - I_R) - I_R/beta_R
    &=& I_S [(e^(V_"BE"/phi.alt_T) - e^(V_"BC"/phi.alt_T)) - 1/beta_R (e^(V_"BC"/phi.alt_T) -1)],
  I_E &= A(J_(n B) + J_(p E))
     &=& - (I_F - I_R) - I_F/beta_F
     &=& I_S [(e^(V_"BE"/phi.alt_T) - e^(V_"BC"/phi.alt_T)) + 1/beta_F (e^(V_"BE"/phi.alt_T) -1)],
  I_B &= underbrace(-(I_E + I_C) "      ", "Kirshoff Formulation")
     &=& underbrace(I_F/beta_F + I_R/beta_R "          ", "F-R Formulation")
     &=& underbrace(I_S [1/beta_F (e^(V_"BE"/phi.alt_T) -1) + 1/beta_R (e^(V_"BC"/phi.alt_T) -1)], "Saturation Current Formulation")
  )
 $
With the following parametters :
#grid(
  columns: (1fr, 1fr),
  align: center + top,
  text(size: 13pt)[
    $\
      beta_F = I_C / I_B = (J_(n B)) / (J_(p E)) = (mu_(n B) W_E N_(D E))/(mu_(p E) W_B N_(A B)) = alpha_F/(1 - alpha_F)\
      beta_R = I_E / I_B = (J_(p C)) / (J _(n B)) = (mu_(p C) W_B N_(A B))/(mu_(n B) W_C N_(D C)) = alpha_R/(1 - alpha_R)\
      alpha_F = beta_F / (beta_F + 1) " & " alpha_R = beta_R / (beta_R + 1)\
    $
  ],
  text(size: 12pt)[
    $\
      I_S = A q D_n n_(p 0)/W_B\
      I_F = I_S (e^( V_"BE" / phi.alt_T ) -1)\
      I_R = I_S (e^( V_"BC" / phi.alt_T ) -1)
    $
  ]
)
We can also define the total voltage accross the BJT as :
$ V_"CE" &= V_"CB" + V_"BE" = -phi.alt_T ln(I_R/I_S) + phi.alt_T ln(I_F/I_S)\ &= phi_T ln(I_F/I_R) $
We can also formulate it in therms of matrices and vectors :
$
  vec(I_E, I_C) = I_S mat(-(1 + beta_F)/beta_F, 1; 1, -(1 + beta_R)/beta_R) vec(e^(V_"BE"/phi.alt_T) -1, e^(V_"BC"/phi.alt_T) -1)
 $
==== Interpretations
Common Emitter and Common Base characteristic curves :
#grid(
  columns: (1fr, 1fr),
  gutter: 20pt,
  [
    #figure(
      image("part3_diagrams/BJT_common_emittor_curves.png", width: 80%),
      caption: [*Common-emitter* output characteristics ($I_C$ vs. $V_"CE"$) of an NPN BJT using the Ebers-Moll model for various base currents $I_B$.],
    )
  ],
  [
    #figure(
      image("part3_diagrams/BJT_common_base_curves.png", width: 80%),
      caption: [*Common-base* output characteristics ($I_C$ vs. $V_"CE"$) of an NPN BJT using the Ebers-Moll model for various emitter currents $I_E$.],
    )
  ]
)


=== Limits of the approximate model (Ebers-Moll) // Search about Gummel-Poon model
==== Early Effect
The Early effect, also known as *base-width modulation*, refers to the variation of the effective base width in a bipolar junction transistor (BJT) due to *changes in the collector-base voltage (saturation mode)* ($V_"CB"$).#block()
#figure(
  image("part3_diagrams/BJT_Early_Effect_base_carrier_modulation.png", width: 50%),
  caption: [Diagram of the change of surplus minority carrier concentration in the base region due to the Early effect. As $V_"CB"$ increases, the depletion region at the base-collector junction widens, reducing the effective base width $W_B$ and increasing the collector current $I_C$ for a given base current $I_B$.],
)#block()

The collector current $I_C$ arises from electrons injected from the emitter that diffuse through the base to the collector. The base width $W_B$ determines how many electrons traverse successfully: if $W_B$ is too large, recombination dominates and current drops; if $W_B$ is small, electrons transit faster with minimal recombination.

A positive collector-base voltage ($V_"CB" > 0$) widens the base-collector depletion region, effectively reducing $W_B$.

#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  [
    #figure(
      image("part3_diagrams/BJT_early_curves_transistor.png", width: 80%),
      caption: [Common-emitter output characteristics curves with Early effect. The collector current $I_C$ increases with $V_"CE"$ due to the reduction in effective base width $W_B$.],
    )
  ],
  [
    #figure(
      image("part3_diagrams/BJT_early_projection_curves.png", width: 100%),
      caption: [Determination of the Early voltage $V_A$ from the extrapolated intersection point of the $I_C$ vs. $V_"CE"$ curves.],
    )
  ]
)

#note_block(block_colors.note)[
  If the collector is less doped than the base, the depletion region extends preferentially into the collector side (as seen in the PN junction chapter). This means the neutral base is less affected, and the *Early effect is reduced*. This justifies typical BJT fabrication choices.
]

*Empirical modeling:* A complete physical model is possible but very complex. Instead, a direct empirical approach is preferred: observing that the $I_C$ vs. $V_"CE"$ curves at constant base current all converge to the same point on the negative voltage axis.

In practice, $beta_F$ (and thus $I_C$) increases when $V_"CE"$ increases. This is captured by:
$ I_C = beta_(F 0) I_B (1 + V_"CE"/V_A) $

Where $V_A$ is the *Early voltage*, corresponding to the (negative) voltage at which the extrapolated curves intersect. This parameter is typically provided in transistor datasheets.

*Circuit model:* To model the Early effect, a resistance $R_A$ is added in parallel with the output current source:
$ R_A = V_A / I_F $

This resistance accounts for the non-ideal (non-horizontal) characteristic in normal mode.

#note_block(block_colors.note)[
  *Typical values:*
  - In *common-emitter* configuration: $V_A approx 100 "V"$
  - In *common-base* configuration: curves appear nearly horizontal in normal mode, but an Early voltage still exists. It can be shown that it is $beta_F$ times larger than in common-emitter.
]

==== Limits of hypothesis: Infinite lifetime $tau$ and weak injection

*Variation of current gain with current level:*

Under the hypotheses made (infinite carrier lifetime and weak injection), the current gain $beta_F$ should be constant for all current values. This is approximately correct for typical operating currents, but breaks down at the extremes:

- *At low currents:* the assumption of infinite recombination lifetime $tau$ is no longer valid. Recombination becomes non-negligible, reducing the number of carriers that successfully traverse the base and thus lowering $beta_F$.

- *At high currents:* the weak injection hypothesis fails. When injection levels become comparable to the doping concentration, the simple exponential relationships no longer hold, and $beta_F$ decreases.

#note_block(block_colors.note)[
  The current gain $beta_F$ is only approximately constant over a limited range of operating currents. Device datasheets typically specify $beta_F$ (or $h_"FE"$) at specific test conditions for this reason.
]

#figure(
  image("part3_diagrams/BJT_limits_of_hypotesis.png", width: 60%),
  caption: [Logarithmic plot of collector and base currents ($log I_C$ and $log I_B$) versus base-emitter voltage $V_"BE"$, showing the variation of current gain $beta_F$ with current level. At low currents (left), recombination becomes significant. At high currents (right), strong injection of minority carriers into the base reduces $beta_F$.],
)

==== Temperature effects on BJT parameters

To understand the effect of temperature on BJT behavior, we must consider that:#block()

*1. Saturation current $I_S$ depends on temperature:*
$ I_S (T) approx I_S (T_0) (T/T_0)^(m_B) e^(-(V_(g B))/(phi.alt_(T 0)) (T_0/T - 1)) $
Where $m_B$ is a material-dependent exponent and $V_(g B)$ is the bandgap voltage.

The forward current then becomes:
$ I_F (T) = I_S (T) e^(V_"BE"/phi.alt_T) $

#note_block(block_colors.warning)[
  Since $I_S prop n_i^2$ and $n_i$ increases exponentially with temperature, the saturation current roughly *doubles every 7–10°C*. This is why BJTs are sensitive to thermal runaway!
]

*2. Current gain $beta_F$ also depends on temperature:*
$ beta_F (T) = beta_F (T_0) (T/T_0)^(m_B - m_E) exp[(E_(g B) - E_(g E))/(k T_0) (T_0/T - 1)] $

Where $m_E$ is the emitter material exponent, and $E_(g B)$, $E_(g E)$ are the bandgap energies in the base and emitter respectively.

#note_block(block_colors.note)[
  In practice, $beta_F$ generally *increases with temperature* because the diffusion length increases and recombination decreases. However, this relationship is complex and device-specific.
]

*Thermal equivalent circuit model:*

The thermal effects can be modeled by adding parasitic sources to the standard BJT model:

 #figure(
   image("part3_diagrams/BJT_thermal_equivalent_circuit.png", width: 60%),
   caption: [Thermal equivalent circuit for a BJT. The voltage source $delta V_"th"$ and current source $delta I_"th"$ account for temperature-induced variations in $V_"BE"$ and $I_B$ respectively.],
 )

These sources account for:
- $delta V_"th"$: variation of $V_"BE"$ with temperature (affects the base-emitter voltage)
- $delta I_"th"$: variation of $I_S$ with temperature (affects the base current)

#note_block(block_colors.extra)[
  *Typical values for silicon transistors:*
  - $partial V_"th" approx 4 "mV/K"$ (voltage source contribution)
  - $partial I_"th" approx 1% I_B "/K"$ (current source contribution)

  Both contribute to *increasing* the effective base voltage and current as temperature rises, which in turn increases the collector current as expected.
]

#note_block(block_colors.warning)[
  *Thermal runaway risk:* As $I_C$ increases → power dissipation increases → junction temperature rises → $I_S$ increases → $I_C$ increases further. This positive feedback loop can destroy the transistor if not properly managed with thermal design or negative feedback biasing.
]

#note_block(block_colors.note)[
  Manufacturers provide these thermal parameters in datasheets for each transistor model, allowing designers to predict temperature behavior and design appropriate compensation circuits.
]

=== Dynamic behavior of BJTs (Capacitances, Switching times)
==== Minority Excess Charge Transport

For variational signals at typical frequencies, we can model the dynamic behavior from the general model by writing the current-charge relationships, where $tau_T$ is the *transit time* through the base:
$ Q_F = tau_T I_F #h(2cm) Q_R = tau_T I_R $

These charges are *non-linear functions of the voltages*. The model is simplified by assuming the same transit time for both forward and reverse directions. The following graphs represent the corresponding charge profiles, from which we can express the current in each direction. The total current is the sum of both contributions.

#figure(
  image("part3_diagrams/BJT_charge_transports_diagrams_in_base.png", width: 60%),
  caption: [Excess minority carrier charge profiles in the base region for forward ($Q_F$) and reverse ($Q_R$) transport. The area under each profile represents the stored charge, which is proportional to the transport current via the transit time $tau_T$.],
)

#note_block(block_colors.note)[
  *Physical interpretation:* The transit time $tau_T$ represents the average time for a minority carrier (electron in NPN) to diffuse across the base. For a base width $W_B$ and diffusion coefficient $D_n$:
  $ tau_T = W_B^2 / (2 D_n) $
  Typical values are in the range of picoseconds to nanoseconds.
]

#note_block(block_colors.warning)[\
  *Key insight:* The charge-based formulation is essential for understanding switching behavior. When the BJT transitions between states (e.g., from saturation to cutoff), the stored charge $Q_F$ and $Q_R$ must be removed, which takes time and limits switching speed.
]

==== Generalization with the Charge Control Model

The complete transistor model in terms of charges extends the static Ebers-Moll model by adding *dynamic currents* corresponding to the *time variations of charges*. These variations are calculated using a *quasi-static approximation*: we use the static charge expressions derived previously and differentiate them with respect to the time-varying applied voltages.

$ I = (dif Q)/(dif t) = underbrace((dif [Q(V)])/(dif t), "Chain rule") = (dif Q)/(dif V) dot (dif V)/(dif t) $

#figure(
  image("part3_diagrams/BJT_charge_control_model.png", width: 55%),
  caption: [Charge control model of the BJT, extending Ebers-Moll with dynamic charge elements $Q_F$, $Q_R$, $Q_"DE"$, and $Q_"DC"$.],
)

*Built-in potentials of the junctions:*

The B-E and B-C diode behavior is described by their internal built-in potentials:
#grid(
  columns: (1fr, 1fr),
  gutter: 20pt,
  align: center,
  [$ phi.alt_(0 E) = phi.alt_T ln((N_(A B) N_(D E))/n_i^2) $],
  [$ phi.alt_(0 C) = phi.alt_T ln((N_(A B) N_(D C))/n_i^2) $],
)

*Depletion charges (voltage affects depletion width):*

#grid(
  columns: (1fr, 1fr),
  gutter: 20pt,
  align: center,
  [$ Q_"DE" = Q_(D E 0) sqrt((V_"BE" + phi.alt_(0 E))/phi.alt_(0 E)) $],
  [$ Q_"DC" = Q_(D C 0) sqrt((V_"BC" + phi.alt_(0 C))/phi.alt_(0 C)) $],
)

#note_block(block_colors.note)[
  The depletion charges depend on the *square root* of voltage, reflecting how the depletion width changes with bias (as seen in the PN junction chapter).
]

*Diffusion charges (voltage affects minority carrier profile):*

#grid(
  columns: (1fr, 1fr),
  gutter: 20pt,
  align: center,
  [$ Q_F = tau_T I_S (e^(V_"BE"/phi.alt_T) - 1) $],
  [$ Q_R = tau_T I_S (e^(V_"BC"/phi.alt_T) - 1) $],
)

*Complete current equations (with dynamic terms):*

Differentiating the charge expressions gives the complete currents:

$ I_C = underbrace((Q_F - Q_R)/tau_T, "Transport") - underbrace(Q_R/(beta_R tau_T), "Reverse recomb.") - underbrace((dif [Q_"DC" + Q_R])/(dif V_"BC") dot (dif V_"BC")/(dif t), "Dynamic (capacitive)") $

$ I_E = -underbrace((Q_F - Q_R)/tau_T, "Transport") - underbrace(Q_F/(beta_F tau_T), "Forward recomb.") - underbrace((dif [Q_"DE" + Q_F])/(dif V_"BE") dot (dif V_"BE")/(dif t), "Dynamic (capacitive)") $

$ I_B = underbrace(Q_F/(beta_F tau_T), "Fwd recomb.") + underbrace(Q_R/(beta_R tau_T), "Rev recomb.") + underbrace((dif [Q_"DE" + Q_F])/(dif V_"BE") dot (dif V_"BE")/(dif t), "B-E dynamic") + underbrace((dif [Q_"DC" + Q_R])/(dif V_"BC") dot (dif V_"BC")/(dif t), "B-C dynamic") $

#note_block(block_colors.extra)[
  The derivatives $(dif Q)/(dif V)$ represent *capacitances*. This is how junction and diffusion capacitances naturally appear in the dynamic model!
]

*Simplified model in active mode:*

In active mode, $Q_R$ is negligible (B-C junction is reverse biased), so the model simplifies:

#figure(
  image("part3_diagrams/BJT_charge_model_active_simplified.png", width: 60%),
  caption: [Simplified charge control model in active mode with parasitic elements. $Q_R approx 0$ since the B-C junction is reverse biased.],
)

*Parasitic elements in real transistors:*

The parasitic elements added to the model account for:
- *Series base resistance $r_(B B')$*: accounts for the resistivity and length of the base region between the contact and the active zone
- *Package parasitic capacitance*: added directly between base and collector terminals (external to the junction)

#note_block(block_colors.warning)[
  The package capacitance, added to the internal capacitance $Q_"DC"$, becomes very important in *common-emitter* configurations with high voltage gain, as it creates a Miller effect that limits bandwidth.
]

*Integrated transistor parasitics:*

In integrated transistors, the collector connection is not made directly on the active zone. Additional parasitic elements must be considered:
- *Collector series resistance*: due to the buried layer and epitaxial path
- *Collector-substrate capacitance*: junction between collector and substrate

#figure(
  image("part3_diagrams/BJT_integrated_parasitics_cross_section.png", width: 40%),
  caption: [Cross-section of an integrated NPN transistor showing parasitic resistances and capacitances due to the physical structure.],
)

=== Linear Model and Small Signal Analysis of BJTs

==== Principle of Small-Signal Analysis

The transistor we have analyzed so far is a *non-linear* device: currents depend exponentially on voltages. However, for small variations around an operating point, we can *linearize* the behavior and use simpler linear circuit analysis techniques.

#note_block(block_colors.note)[
  The term $e^(x)$ can be approximated as $e^(x) approx 1 + x$ for small $x$. This is the foundation of small-signal analysis.
]

*Operating point (DC bias):*

Consider a transistor biased in *active mode* with:
- A DC base current $I_B$ (or equivalently, a DC base-emitter voltage $V_"BE"$)
- Resulting in a DC collector current $I_C = beta_F I_B$

*Small-signal superposition:*

When a small AC signal is superimposed on the DC bias:
#grid(
  columns: (1fr, 1fr),
  gutter: 20pt,
  align: center,
  [$ v_"BE" = V_"BE" + underbrace(v_"be", "small signal") $],
  [$ i_C = I_C + underbrace(i_c, "small signal") $],
)

The key insight is that for *small* variations, the relationship between $i_c$ and $v_"be"$ becomes *linear*.

#note_block(block_colors.warning)[
  *What is "small"?* The signal amplitude must satisfy $v_"be" << phi.alt_T approx 26 "mV"$. In practice, signals up to ~5-10 mV are considered small enough for linear approximation.
]

==== The Hybrid-$pi$ Model (Giacoletto Model)

The *hybrid-$pi$ model* (also called the *Giacoletto model*) is the most widely used small-signal equivalent circuit for the BJT. It represents the transistor as a voltage-controlled current source with associated resistances and capacitances.

#note_block(block_colors.extra)[
  *Why "hybrid-$pi$"?* The name comes from:
  - *Hybrid*: mixes voltage and current parameters (unlike pure h-parameter or y-parameter models)
  - *$pi$*: the circuit topology resembles the Greek letter $pi$ when drawn
]

==== Derivation of the Hybrid-$pi$ Parameters

*Transconductance $g_m$:*

Starting from the collector current equation in active mode:
$ I_C = I_S e^(V_"BE"/phi.alt_T) $

Taking the derivative with respect to $V_"BE"$:
$ g_m = (dif I_C)/(dif V_"BE") = I_S/phi.alt_T e^(V_"BE"/phi.alt_T) = I_C/phi.alt_T $

#note_block(block_colors.extra)[
  *Key result:* The transconductance is proportional to the DC collector current:
  $ g_m = I_C/phi.alt_T approx I_C/(25 "mV") = 40 I_C " [S]" $
  For example, at $I_C = 1 "mA"$, we get $g_m = 40 "mS"$.
]

#note_block(block_colors.note)[
  *Physical meaning of $g_m$:* It tells you how much the collector current changes for a given change in base-emitter voltage. Higher $g_m$ means higher gain capability!
]

*Input resistance $r_pi$:*

The base current is $I_B = I_C / beta_F$, so:
$ r_pi = (dif V_"BE")/(dif I_B) = (dif V_"BE")/(dif I_C) dot (dif I_C)/(dif I_B) = 1/g_m dot beta_F = (beta_F phi.alt_T)/I_C $

#note_block(block_colors.note)[
  *Fundamental relationship:* Notice that $r_pi = beta_F / g_m$. This is a key relationship in the hybrid-$pi$ model!
]

*Output resistance $r_o$ (Early effect):*

Including the Early effect, the collector current becomes:
$ I_C = I_S e^(V_"BE"/phi.alt_T) (1 + V_"CE"/V_A) $

The output resistance is:
$ r_o = (dif V_"CE")/(dif I_C) = V_A/I_C $

#note_block(block_colors.warning)[
  *Ideal vs. Real:* Without Early effect, $r_o -> infinity$ (ideal current source). With Early effect, $r_o$ is finite, meaning the collector current does depend slightly on $V_"CE"$.
]

==== Non-Linear Charge Control Model in Active Mode

Before deriving the linearized hybrid-$pi$ model, we must understand the *non-linear charge control model*. In active mode, the BJT behavior is described by:

#figure(
  image("part3_diagrams/BJT_hybrid_pi_model.png", width: 50%),
  caption: [Non-linear charge control equivalent circuit in active mode. Left: recombination current $q_F / tau_(B F)$ (diode symbol) and stored charge $q_F$ (capacitor). Right: transport current source $q_F / tau_T$.],
)

The fundamental equations relating currents and charge are:

$ I_C = underbrace(q_F / tau_T, "transport current") #h(2cm) I_B = underbrace(q_F / tau_(B F), "recombination") + underbrace((dif q_F)/(dif t), "charging current") $

$ I_E = -(I_B + I_C) = -q_F underbrace((1/tau_(B F) + 1/tau_T), 1/tau_F) - (dif q_F)/(dif t) $

#note_block(block_colors.note)[
  *Time constants:*
  - $tau_T$: transit time through the base (ps to ns)
  - $tau_(B F)$: recombination lifetime in the base (much larger than $tau_T$)
  - $tau_F = (1/tau_(B F) + 1/tau_T)^(-1) approx tau_T$ (effective forward time constant)
]

Where the stored charge depends exponentially on voltage:
$ q_F = underbrace(q_(F 0), "equilibrium charge") [underbrace(exp(V_"BE"/(k T)) - 1, "Boltzmann factor")] #h(1cm) "with" #h(0.5cm) q_(F 0) = I_S tau_T $

And the current gain is:
$ beta_F = tau_(B F) / tau_T = underbrace("recombination time", tau_(B F)) / underbrace("transit time", tau_T) >> 1 $

#note_block(block_colors.extra)[
  *Why $beta_F >> 1$:* The recombination time $tau_(B F)$ is much longer than the transit time $tau_T$ because the base is thin and carriers traverse it quickly before they can recombine. Typical values: $tau_T ~ 10 "ps"$, $tau_(B F) ~ 1 "ns"$ → $beta_F ~ 100$.
]

#note_block(block_colors.note)[
  *Physical interpretation:*
  - $q_F$: excess minority charge stored in the base (capacitor-like behavior)
  - $q_F / tau_T$: collector current (charge transiting to collector per unit time)
  - $q_F / tau_(B F)$: recombination current in base (charge lost per unit time)
  - $(dif q_F)/(dif t)$: charging/discharging current when $V_"BE"$ varies
]

#note_block(block_colors.extra)[
  The non-linear equivalent circuit contains a diode (representing $q_F / tau_(B F)$), a capacitor (representing $q_F$), and a current source (representing $q_F / tau_T$). This model is valid for *any* signal amplitude, not just small signals.
]

==== Linearization: Deriving the Hybrid-$pi$ Model

To obtain a *linear* model, we linearize the charge expression. If we superimpose a small variational signal $v_"BE"(t)$ on the DC bias $V_"BE0"$:
$ V_"BE"(t) = underbrace(V_"BE0", "DC bias (constant)") + underbrace(v_"BE"(t), "small signal (time-varying)") $

#note_block(block_colors.note)[
  *Convention:* Capital letters ($V$, $I$, $Q$) denote DC quantities. Lowercase letters ($v$, $i$, $q$) denote small-signal AC quantities. The subscript "0" emphasizes the DC operating point.
]

The charge can be expanded using a Taylor series (keeping only first-order terms):
$ q_F = underbrace(q_(F 0) [exp(V_"BE0"/(k T)) - 1], Q_F "(DC charge)") + underbrace(v_"BE" q/(k T) q_(F 0) exp(V_"BE0"/(k T)), q_f "(small-signal charge)") $

Taking the time derivative:
$ (dif q_F)/(dif t) = q/(k T) q_(F 0) exp(V_"BE0"/(k T)) (dif v_"BE")/(dif t) $

*Collector current decomposition:*

The collector current separates into DC and AC components:
$ underbrace(I_(C 0), "DC") + underbrace(i_c, "AC") = underbrace(q_(F 0)/tau_T [exp(V_"BE0"/(k T)) - 1], "DC component") + underbrace(v_"BE" q/(k T) dot q_(F 0)/tau_T exp(V_"BE0"/(k T)), "AC component") $

Identifying terms:
$ I_(C 0) = q_(F 0)/tau_T [exp(V_"BE0"/(k T)) - 1] #h(1cm) "and" #h(1cm) i_c = g_m v_"BE" $

Where the *transconductance* is:
$ g_m = (partial I_C)/(partial V_"BE") = q/(k T) underbrace((I_(C 0) + q_(F 0)/tau_T), approx I_(C 0)) approx I_(C 0)/phi.alt_T $

#note_block(block_colors.extra)[
  *The $g_m$ formula is fundamental:* At room temperature ($phi.alt_T approx 25 "mV"$):
  $ g_m = I_(C 0) / (25 "mV") = 40 times I_(C 0) $
  For example: $I_(C 0) = 1 "mA"$ → $g_m = 40 "mS"$ (very high transconductance compared to MOSFETs!)
]

#note_block(block_colors.note)[
  *Key result:* The transconductance $g_m = partial I_C / partial V_"BE"$ is directly proportional to the DC collector current. This is a fundamental property of BJTs (and also applies to MOSFETs in weak inversion).
]

*Base current decomposition:*

Similarly, the base current decomposes as:
$ underbrace(I_(B 0), "DC") + underbrace(i_b, "AC") = q_(F 0)/tau_(B F) [exp(V_"BE0"/(k T)) - 1] + q/(k T) q_(F 0) exp(V_"BE0"/(k T)) (v_"BE"/tau_(B F) + (dif v_"BE")/(dif t)) $

Identifying the DC and AC terms:
$ I_(B 0) = q_(F 0)/tau_(B F) [exp(V_"BE0"/(k T)) - 1] = I_(C 0)/beta_F $
$ i_b = underbrace(v_"BE"/r_pi, "resistive") + underbrace(C_F (dif v_"BE")/(dif t), "capacitive") $

With the *input resistance* and *diffusion capacitance*:
$ r_pi = tau_(B F)/tau_T dot 1/g_m = beta_F / g_m #h(1cm) "and" #h(1cm) C_F = g_m tau_T $

#note_block(block_colors.note)[
  *Circuit interpretation of $i_b$:*
  - The term $v_"BE"/r_pi$ represents current through a resistor $r_pi$
  - The term $C_F (dif v_"BE")/(dif t)$ represents current through a capacitor $C_F$
  - These two elements are *in parallel* in the equivalent circuit!
]

#note_block(block_colors.extra)[
  *Important relationship:* The parameters $C_F$ and $r_pi$ both depend on the DC bias current $I_(C 0)$ through $g_m$. They are related by:
  $ C_F r_pi = tau_(B F) $
  This product equals the base recombination time constant, independent of bias!
]

==== Linearized Equivalent Circuit (Intermediate Model)

The small-signal variational currents $i_c$ and $i_b$ can be represented by the following equivalent circuit:

#figure(
  image("part3_diagrams/BJT_small_signal_AC_model.png", width: 60%),
  caption: [Linearized hybrid-$pi$ model in active mode: input resistance $r_pi$, diffusion capacitance $C_F$, Early resistance $r_"EAB"$, and voltage-controlled current source $g_m v_"BE"$.],
)

*Summary of linearized parameters:*

#figure(
  table(
    columns: (1.2fr, 2fr, 2fr),
    align: (center, left, center),
    stroke: 0.5pt,
    [*Parameter*], [*Expression*], [*Physical meaning*],

    [$g_m$], [$I_(C 0) / phi.alt_T = q I_(C 0) / (k T)$], [Transconductance],

    [$r_pi$], [$beta_F / g_m = (beta_F phi.alt_T) / I_(C 0)$], [Input resistance (B-E)],

    [$C_F$], [$g_m tau_T = tau_T I_(C 0) / phi.alt_T$], [Diffusion capacitance],

    [$r_"EAB"$], [$V_A / I_(C 0)$], [Output resistance (Early effect)],
  ),
  caption: [Hybrid-$pi$ small-signal parameters derived from linearization.],
)

#note_block(block_colors.extra)[
  *Quick estimation rules (at room temperature, $phi.alt_T approx 25 "mV"$):*
  - $g_m approx 40 times I_(C 0)$ (with $I_(C 0)$ in Amps, $g_m$ in Siemens)
  - $r_pi approx beta_F times 25 "mV" / I_(C 0)$
  - $r_"EAB" approx V_A / I_(C 0)$ (typically $V_A approx 50 - 200 "V"$)
]

#note_block(block_colors.note)[
  *When to use this model:* This intermediate model is suitable for frequencies where $C_F$ matters but the B-C junction capacitance and base spreading resistance can be neglected. It captures the essential frequency-dependent behavior.
]

==== Complete Hybrid-$pi$ Model (with All Parasitics)

The dynamic model must also account for *extrinsic elements*, mainly:
- The *transition capacitances* of the E-B and B-C depletion regions
- The *series resistance* of the base contact

From the depletion charge expressions $q_E$ and $q_C$, we derive the transition capacitances:
$ C_E = (dif q_E)/(dif V_"BE") #h(2cm) C_C = (dif q_C)/(dif V_"BC") $

In the complete equivalent circuit, we introduce a capacitance $C_pi$ that *replaces the parallel combination* of $C_F$ and $C_E$:
$ C_pi = underbrace(C_F, "diffusion") + underbrace(C_E, "depletion") = underbrace(g_m tau_T, prop I_C) + underbrace(C_(E 0) / sqrt(1 - V_"BE"/phi.alt_0), "voltage-dependent") $

#note_block(block_colors.note)[
  *Dominant contribution:* At typical bias currents, $C_F >> C_E$, so $C_pi approx C_F = g_m tau_T$. The diffusion capacitance dominates because of the large stored charge in the forward-biased B-E junction.
]

The series base resistance $r_(B B')$ is also made explicit, as its perturbative effect is generally important. Under these conditions, the current source is controlled by the *internal voltage* $v_(B' E)$ (not $v_"BE"$!).

#figure(
  image("part3_diagrams/BJT_charge_control_active_equivalent.png", width: 60%),
  caption: [Complete hybrid-$pi$ model (also called Giacoletto model) with base spreading resistance $r_(B B')$, input resistance $r_pi$, total input capacitance $C_pi$, collector capacitance $C_C$, and controlled source $g_m v_(B' E)$. This is the "$pi$-hybrid model without Early effect" when $r_"EAB" -> infinity$.],
)

#note_block(block_colors.warning)[
  *Critical notation:* In the complete model:
  - B is the external base terminal, B' is the internal base node
  - $v_"BE" = v_(B B') + v_(B' E)$ where $v_(B B') = i_B r_(B B')$
  - The current source is controlled by $v_(B' E)$, *not* $v_"BE"$!
]

#note_block(block_colors.note)[
  *Origin of the name "hybrid-$pi$":*
  - *Hybrid*: the current source is controlled by a voltage (mixing voltage and current variables)
  - *$pi$*: the circuit topology resembles an inverted Greek letter $Pi$
]

#note_block(block_colors.extra)[
  *Notation equivalences across textbooks:*
  - $C_F equiv C_"diff"$ (diffusion capacitance alone)
  - $C_pi = C_F + C_E$ (total B-E capacitance including depletion)
  - $C_C equiv C_mu equiv C_"bc"$ (B-C depletion capacitance)
  - $r_"EAB" equiv r_o equiv r_"ce"$ (output resistance from Early effect)
]

*Miller Effect:*

The capacitance $C_C$, though typically small (fraction of a pF), becomes critical in common-emitter configurations due to the *Miller effect*:

#note_block(block_colors.warning)[
  *Miller effect:* In common-emitter, $C_C$ appears multiplied by the voltage gain $(1 + |A_v|)$ at the input. For a voltage gain of 100, a 1 pF $C_C$ looks like ~100 pF at the input, severely limiting bandwidth!

  $ C_"Miller" = C_C (1 + |A_v|) $
]

*Transition Frequency $f_T$:*

The frequency at which the current gain $|beta|$ drops to unity is:
$ f_T = underbrace(g_m, I_C\/phi.alt_T) / (2 pi underbrace((C_pi + C_C), "total capacitance")) approx g_m / (2 pi C_pi) approx 1/(2 pi tau_T) $

#note_block(block_colors.note)[
  *Derivation insight:* Since $g_m = I_C / phi.alt_T$ and $C_pi approx g_m tau_T$, we get:
  $ f_T approx g_m / (2 pi g_m tau_T) = 1/(2 pi tau_T) $
  The $g_m$ terms cancel! This means $f_T$ depends primarily on the *transit time*, not on bias current.
]

#note_block(block_colors.extra)[
  *$f_T$ is a key figure of merit:* Higher $f_T$ means the transistor can amplify at higher frequencies. Modern high-speed BJTs can achieve $f_T > 100 "GHz"$! The approximation $f_T approx 1/(2 pi tau_T)$ holds when $C_pi >> C_C$.
]

*Summary: From Charge Model to Hybrid-$pi$*

#figure(
  table(
    columns: (1fr, 1.5fr, 1.5fr),
    align: (center, center, center),
    stroke: 0.5pt,
    [*Charge Model*], [*Linearization*], [*Hybrid-$pi$ Element*],

    [$q_F / tau_(B F)$ (diode)], [$-> v_"BE" / r_pi$], [$r_pi = beta_F / g_m$],

    [$q_F$ (capacitor)], [$-> C_F (dif v) / (dif t)$], [$C_F = g_m tau_T$],

    [$q_F / tau_T$ (source)], [$-> g_m v_"BE"$], [$g_m = I_C / phi.alt_T$],

    [—], [+ depletion caps], [$C_E$, $C_C$],

    [—], [+ base resistance], [$r_(B B')$],
  ),
  caption: [Correspondence between charge control model elements and hybrid-$pi$ parameters.],
)

==== Design Considerations and Common Pitfalls

#note_block(block_colors.extra)[
  *Design insight — Minimizing high-frequency limitations:*
  - Reduce $C_C$ by using smaller device geometries
  - Use *cascode configurations* to reduce Miller effect (isolates input from output voltage swing)
  - Bias at higher $I_(C 0)$ to increase $g_m$ (but watch power dissipation and $C_pi$ increase)
  - Choose transistors with higher $f_T$ for high-frequency applications
  - Minimize $r_(B B')$ by using wide emitter stripes or interdigitated layouts
]

#note_block(block_colors.warning)[
  *Common mistakes to avoid:*
  - Don't confuse $r_pi$ (small-signal input resistance) with DC input resistance. The DC resistance is non-linear; $r_pi$ is the linearized slope at the operating point.
  - Don't forget $r_(B B')$ in high-frequency calculations — it creates a voltage divider that reduces the effective $v_(B' E)$.
  - Don't neglect Miller effect when estimating bandwidth in common-emitter stages.
  - Remember that $C_pi prop I_C$ — increasing bias current improves $g_m$ but also increases capacitance!
]

=== Usage of the BJT in circuits (Amplifier, Switch)
==== BJT Circuit Symbols and Models
#grid(
  columns: (1fr),
  gutter: 10pt,
  align: horizon,
  stroke: 0.5pt,
  inset: 5pt,
  [#figure(image("part3_diagrams/BJT_NPN_diagrams.png", width: 80%), caption: [NPN Transistor Model])],
  [#figure(image("part3_diagrams/BJT_PNP_diagrams.png", width: 80%), caption: [PNP Transistor Model])],
)

==== 4 Working Modes (Ebers-Moll Model)
#figure(
  image("part3_diagrams/BJT_Ebersmol_Modes.png", width: 80%),
  caption: [BJT NPN working modes based on B-E and B-C junction biases: Active, Cutoff, Saturation, Reverse Active.],
)

==== Using it as a Switch

By controlling $V_"in"$ (0 to 5V), we control the current through load $R$. The resistor $10 R$ limits base current to protect the B-E junction.

#grid(
  columns: (1fr, 2fr),
  gutter: 20pt,
  [#figure(image("part3_diagrams/BJT_example_part1.png", width: 80%), caption: [Common-emitter switch: $V_"in"$, base resistor $10 R$, load $R$, 5V supply.])],
  [#figure(image("part3_diagrams/BJT_example_part2.png", width: 110%), caption: [Ebers-Moll model with $I_B$, $I_F / beta_F$, and current source $I_F$.])],
)

*Case 1: $V_"in" = 0V$ (Cutoff)*

B-E diode blocked → $I_F = 0$ → no current through $R$ → $V_"out" = 5V$

*Case 2: $V_"in" = 5V$ (Saturation)*

The model predicts $V_"out" < 0$, so the B-C diode turns on → transistor saturates → $V_"out" approx 0V$

#grid(
  columns: (1fr, 1fr),
  gutter: 20pt,
  [#figure(image("part3_diagrams/BJT_example_part3.png", width: 80%), caption: [$V_"in" = 5V$: B-C diode conducts, transistor in saturation.])],
  [#figure(image("part3_diagrams/BJT_example_part4.png", width: 100%), caption: [LED driver: $R_1$, $R_2$ sized for proper LED current $I_D$.])],
)

#note_block(block_colors.extra)[
  *Switch behavior:*
  #table(
    columns: (1fr, 1fr, 1fr),
    align: center,
    stroke: 0.5pt,
    [$V_"in"$], [State], [$V_"out"$],
    [0V], [OPEN (cutoff)], [5V],
    [5V], [CLOSED (saturation)], [$approx 0V$],
  )
]

//// ------------------------------------------------------------------------------------------------

== Metal-Oxide-Semiconductor (n-MOS, p-MOS, CMOS, FD-SOI, JFET) // NEW SECTION






== Other Semiconductor Devices (JFETs, MESFETs, IGBTs) // NEW SECTION







/////////////////////////////////////////////////////////////////////////////////////////////////
= Exercices
== How to solve basic monocrystal semiconductor problems
== Solving the PN junctions
== Solving BJTs
== Solving MOSFETs
== Solving high frequency physics problems

/////////////////////////////////////////////////////////////////////////////////////////////////
= Exam info
== Exam devices possible
#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  align: left,
  stroke: 0.5pt,

  // Row 1: headers
  [Semiconductor bar],[PN junction],[Bipolar transistor],[MOS transistor],

  // Row 2: content
  [- Temperature effect\
   - Doping\
   - Unbiased doping profiles],
  [- PIN junction\
   - PNN+ junction\
   - Semi-infinite diode\
   - Infinite diode\
   - Photodiode\
   - Variable depletion\
   ],
  [- PNP\
   - NPN\
   - Saturation regime\
   - Reverse bias\
   - Phototransistor],
  [- FinFET\
   - FDSOI\
   - JFET\
   - PMOS\
   - Accumulation mode],
)

/////////////////////////////////////////////////////////////////////////////////////////////////
= Exam Formulaires (Theory Part)
== Diodes : All you need to know
== BJTs : All you need to know
== MOSFETs : All you need to know

/////////////////////////////////////////////////////////////////////////////////////////////////
= Exam Formulaires (Exercises Part)
== Semiconductor basics : All you need to know
== PN junctions : All you need to know
== BJTs : All you need to know
== MOSFETs : All you need to know

/////////////////////////////////////////////////////////////////////////////////////////////////
#pagebreak()
= Additional Ressources
== Variable Definitions
#let column_widths = (1.4fr, 2.8fr, 4fr, 1.3fr, 2fr)
#let definition_tables_overload = 100% + 3.5cm

#align(center)[#box(width: definition_tables_overload)[
  #grid(columns: (1fr), align: center+horizon, inset: 10pt,[#text(size: 16pt)[
    *Fundamental semiconductor parameters and transport equations*
  ]])
#table(
  columns: column_widths,
  table.header(
    repeat: true,
    [*Symbol*], [*Definition*], [*Formulas / where (very light why)*], [*Units*], [*Typical values*],
  ),

  [$q$], [Elementary charge], [q scales electric forces/currents.\ $I = I_s ( e^( q V / ( k T ) ) - 1 )$], [$"C"$], [1.602 × 10^-19],

  [$k$], [Boltzmann constant], [$phi_T = k T / q$; thermal energy/voltage scale.], [$"J" · "K"^-1$], [1.38 × 10^-23],

  [$T$], [Absolute temperature], [Appears in$phi_T$,$n_i(T)$, and$I_s(T)$; temperature controls carriers.], [$"K"$], [300],

  [$phi_T$], [Thermal voltage], [$phi_T = k T / q$; small-signal slopes often use$1 / phi_T$.], [$"V"$], [≈ 25 mV at 300 K],

  [$mu_n , mu_p$], [Electron / hole mobility], [$J = q ( n mu_n + p mu_p ) E$; higher mobility ⇒ higher conductivity.], [$"m"^2 · "V"^-1 · "s"^-1 (or "cm"^2 · "V"^-1 · "s"^-1)$], [Order of 10^-2 m^2·V^-1·s^-1 (material/doping dependent)],

  [$n , p$], [Free electron / hole concentration], [$sigma = q ( n mu_n + p mu_p )$; set by doping and temperature.], [$"m"^-3 ("often" "cm"^-3)$], [Context-dependent],

  [$n_i$], [Intrinsic concentration], [In$I_s ∝ n_i^2$and$n p = n_i^2$; strong T-dependence.], [$"cm"^-3$], [≈ 1.38 × 10^10 (Si, 300 K)],

  [$sigma , rho$], [Conductivity / resistivity], [$sigma = q ( n mu_n + p mu_p )$,$R = rho L / A$.], [$"S" · "m"^-1 / "Ω" · "m"$], [Cu ref: ρ ≈ 1.73 × 10^-8 Ω·m],

  [$E$], [Electric field], [Drives drift:$J = q ( n mu_n + p mu_p ) E$.], [$"V" · "m"^-1$], [—],

  [$J$], [Current density], [Drift + diffusion (e.g. electrons):$J_n = - q n mu_n , (dif V)/(dif x) - q mu_n phi_T , (dif n)/(dif x)$(analogous for holes).], [$"A" · "m"^-2$], [—],

  [$I , V , R , G , A$], [Current, voltage, resistance, conductance, area (not ampere)], [$I = J A$,$R = rho L / A$,$G = 1 / R$.], [A, V,$"Ω"$, S,$"m"^2$], [—],
)]]

#align(center)[#box(width: definition_tables_overload)[
  #grid(columns: (1fr), align: center+horizon, inset: 10pt,[#text(size: 16pt)[
    *Semiconductor parameters & PN junction basics*
  ]])
#table(
  columns: column_widths,
  table.header(
    repeat: true,
    [*Symbol*], [*Definition*], [*Formulas / where (very light why)*], [*Units*], [*Typical values*],
  ),

  [$N_D , N_A$], [Donor / acceptor doping concentration], [Built-in:$phi_0 = ( k T / q ) , ln( N_A N_D / n_i^2 )$; depletion widths scale with$N_A , N_D$.], [$"cm"^-3 (or "m"^-3)$], [Example:$N_A = 10^18 , N_D = 10^16$cm^-3],

  [$phi_0$], [Built-in potential of PN], [Sets PN barrier; increases with doping.], [$"V"$], [Si: ~0.6–0.9 V (typical)],

  [$epsilon_s$], [Semiconductor permittivity], [In Poisson & depletion; enters$E_(max)$and widths.], [$"F" · "m"^-1$], [Material constant (Si)],

  [$l_(p_o) , l_(n_o)$], [Depletion widths (P / N side)], [From depletion model; sum sets junction width.], [$"m" ("often" "µm")$], [l_(p_o) ≈ 0.003 µm, l_(n_o) ≈ 0.327 µm (example)],

  [$E_(max)$], [Peak electric field at junction], [$E_(max) ≈ - 2 phi_0 / ( l_(p_o) + l_(n_o) )$.], [$"V" · "m"^-1 (or "V" · "cm"^-1)$], [≈ 5 × 10^4 V·cm^-1 (example)],

  [$L_n , L_p$], [Diffusion length (electrons / holes)], [$L = D tau$; sets minority profiles and recombination reach.], [$"m" ("often" "µm")$], [Tech-dependent],
  [$D_n , D_p$], [Diffusion coefficients], [Linked to mobility via Einstein:$D = mu , phi_T$.], [$"m"^2 · "s"^-1$], [—],
)]]

#align(center)[#box(width: definition_tables_overload)[
  #grid(columns: (1fr), align: center+horizon, inset: 10pt,[#text(size: 16pt)[
    *PN diode parameters & equations*
  ]])
#table(
  columns: column_widths,
  table.header(
    repeat: true,
    [*Symbol*], [*Definition*], [*Formulas / where (very light why)*], [*Units*], [*Typical values*],
  ),

  [$I , V$], [Diode current & voltage], [$I = I_s ( e^( q V / ( k T ) ) - 1 )$; exponential I–V.], [A, V], [phi_T ≈ 25 mV at 300 K],

  [$I_s$], [Saturation current], [$I_s ∝ n_i^2$; rises rapidly with T. Sets leakage/slope.], [A], [Roughly doubles per 7–8 °C (rule-of-thumb)],

  [$(dif V) / (dif T)$], [Forward-voltage temp. coefficient (at constant$I$)], [Negative in forward bias; typical Si rule: ≈ −2 mV·°C^-1.], [$"V" · "°C"^-1$], [≈ −2 mV·°C^-1],
)]]

#align(center)[#box(width: definition_tables_overload)[
  #grid(columns: (1fr), align: center+horizon, inset: 10pt,[#text(size: 16pt)[
    *Bipolar Junction Transistor (BJT) parameters & equations*
  ]])
#table(
  columns: column_widths,
  table.header(
    repeat: true,
    [*Symbol*], [*Definition*], [*Formulas / where (very light why)*], [*Units*], [*Typical values*],
  ),

  [$I_B , I_C , I_E$], [Base / collector / emitter currents], [Active:$I_C ≈ beta_F I_B$,$I_E ≈ I_C + I_B$.], [A], [—],

  [$beta_F$], [Current gain (emitter common)], [$I_C = beta_F I_B$; varies with$V_(C E)$(Early effect).], [—], [Tens to >100; often increases with$V_(C E)$],

  [$alpha$], [Common-base gain], [Links$I_C$to$I_E$.], [—], [0.9–0.99],

  [$I_(C B O)$], [Collector–base leakage (B–C reverse)], [Adds to collector current in cutoff/blocking.], [A], [Very small (tech-dependent)],

  [$V_(B E)$, $V_(C E)$, $V_(C B)$], [Terminal voltages], [Enter exponentials:$e^( q V_(B E) / ( k T ) )$,$e^( q V_(B C) / ( k T ) )$.], [V], [$V_(B E) ~ 0.7 V$(rule-of-thumb)],

  [$V_A$], [Early voltage], [Finite output slope:$I_C = beta_(F_0) I_B ( 1 + V_(C E) / V_A )$.], [V], [~100 V (EC typical)],

  [$tau_T$], [Base transit time / charge time constant], [Dynamic charge:$Q_F = tau_T I_F$,$Q_R = tau_T I_R$.], [$"s"$], [Device-specific],
)]]

#align(center)[#box(width: definition_tables_overload)[
  #grid(columns: (1fr), align: center+horizon, inset: 10pt,[#text(size: 16pt)[
    *Metal-Oxide-Semiconductor (MOS) parameters & equations*
  ]])
#table(
  columns: column_widths,
  table.header(
    repeat: true,
    [*Symbol*], [*Definition*], [*Formulas / where (very light why)*], [*Units*], [*Typical values*],
  ),

  [$V_G , V_D , V_S , V_B$], [Gate / drain / source / bulk voltages], [Define$V_(G S)$,$V_(D S)$; bias to keep body diodes off.], [V], [—],

  [$W , L$], [Channel width & length], [Current scales$I_D ∝ W / L$; set by layout.], [$"m" ("often" "µm")$], [VLSI: L ~ 0.1 µm],

  [$e_("ox")$], [Oxide thickness], [Sets$C_("ox") = epsilon_("ox") / e_("ox")$.], [$"m"$], [Few tens of Å (classical processes)],

  [$epsilon_("ox") , C_("ox")$], [Oxide permittivity & per-area capacitance], [Charge model uses$Q_c = - C_("ox") ( V_G - V_T - lambda V_c )$.], [$"F" · "m"^-1 , "F" · "m"^-2$], [Process-dependent],

  [$V_T , V_("T0")$], [Local / zero-bias threshold], [$V_T = V_("T0") + lambda V_c$(local channel-potential dependence).], [V], [Measured per process / bias],

  [$lambda$], [Threshold/channel-modulation factor], [Appears in$V_("Dsat") = ( V_G - V_("TD") ) / lambda$and in$V_T(V_c)$.], [—], [Extracted; geometry-dependent],

  [$V_("TS") , V_("TD")$], [Local thresholds at source / drain], [Define on/off and saturation boundaries.], [V], [—],

  [$V_("Dsat")$], [Drain saturation voltage], [Boundary to saturation:$V_("Dsat") = ( V_G - V_("TD") ) / lambda$.], [V], [—],
  [$mu_n$], [Electron mobility in channel], [Enters$beta = (1/2) mu_n C_("ox")$; field-dependent at high$V_G$.], [$"m"^2 · "V"^-1 · "s"^-1$], [Extracted from IV],

  [$beta$], [Process transconductance parameter], [Ideal sat.:$I_D = beta ( W / L ) ( V_G - V_("TS") )^2 / lambda$.], [$"A" · "V"^-2$], [Measured with$V_T , lambda$],

  [$I_D$], [Drain current], [Linear (charge-based integral) and quadratic (ideal sat.) forms; in sat,$I_D ∝ ( V_G - V_T )^2$.], [A], [—],

  [$g_m , g_d$], [Transconductance / output conductance], [Small-signal derivatives of$I_D$around the bias point.], [S], [Extracted at operating point],

  [$C_("GS") , C_("GD")$], [Small-signal gate capacitances], [At$V_("DS") = 0$:$C_("GS") = C_("GD") = W L C_("ox") / 2$; in deep sat: trend to$2 W L C_("ox") / 3$and$0$.], [F], [Bias-dependent],

  [$Q_G$, $Q_T$, $Q_C$, $Q_D$], [Gate / total / channel / depletion charges], [Charge-based dynamic model; these charges determine caps and transients.], [C], [—],

  [$Q_("SB") , Q_("DB")$], [S/B and D/B depletion charges], [Add junction caps; impact AC behavior.], [C], [—],
  [$Q_("GSov") , Q_("GDov")$], [Gate–S/D overlap charges (parasitics)], [Overlap contributions to$C_("GS") , C_("GD")$.], [C], [—],

  [$V_A$], [“Early-like” parameter in MOS saturation], [Non-flat sat. slope:$I_D ∝ ( 1 + ( V_D - V_("Dsat") ) / V_A )$.], [V], [Extracted (device-dependent)],
)]]

#pagebreak()
== How to solve the practical part (From given template)
=== Step 1 : Analyze and describe the problem
- Structure of the problem (1D or even 2 times 1D for MOS)
  - Diagram of the device
  - Dimensions
  - Characteristics
  - Doping of the different zones
- Mathematical conditioning (minority carriers, majority carriers, ...)
  - Definitions
  - notations
  - Units
  - Boundary conditions
- Physical phenomena involved (The physical equations you will need to solve the problem)
  - Charges
  - Electric fields
  - Voltages
  - Boltzmann relations
  - ZQN (zones of quasi-neutrality)
  - (_See "Feuilles de route" for more details on this step._)
=== Step 2 : Solve the problem
There are 4 unknowns you will have to always compute : $n, p, E, Phi$
- Compute the carriers ($n$, $p$), charge density ($rho$) and capacitances ($C$)
  - Hypothesis : Approximation of depletion zone, abrupt junction, ...
  - Important Concepts :
    - Depletion lengths ($l_p$, $l_n$)
    - Contact potential (potential barrier due to the junction) ($phi_0$)
  - Stored charges in the structure ($Q_p$, $Q_n$)
    - Compute the depletion lengths ($l_p$, $l_n$)
    - Solve for Poisson's equation to get the electric field and potential in the depletion zone ($E$, $Phi$)
- Compute the current ($J_n$, $J_p$)
  - Diffusion (PN junction and BJTs)
    - Hypothesis : Short zones, short base, ...
    - Important Concepts :
      - Gain of the device ($beta_F$, $beta_R$ for BJTs, $k_n$, $k_p$ for MOSFETs)
    - Solve the equation
  - Drift (MOSFETs in linear regime)
    - Hypothesis : Charge sheet approximation, ...
    - Important Concepts :
      - Threshold voltage ($V_T$)
    - Solve the equation

Check the units of each equation you will use, and verify that they are coherent with the physical quantities you want to compute.
#note_block(block_colors.trick)[
  Checking your units could save you too, to get back the correct formula if you forget it during the exam !
]
=== Step 3 : Compute the values asked
Now, replace all variables with the numerical values, and compute the different values asked in the problem.

Verify their coherence with the physical phenomena involved, and the order of magnitude expected.

#pagebreak()
#bibliography("references_part3.bib", full:true, style: "ieee")


/* = Theory
== Semiconductor Basics

=== Charge Carriers and Materials
Current in solids is the movement of charge carriers under an electric field ($arrow(E)$) or a concentration gradient. In semiconductors, two types of carriers exist:#footnote($q=1.602 times 10^(-19) " [C]"$)
$ cases(
  "Electrons" & (n) : e^- -> Q = -q,
  "Holes" & (p) : h^+ -> Q = +q " (absence of electron in valence band)"
) $

Materials are classified by their band gap energy ($E_g$) and carrier availability:
#figure(
  table(
    columns: (auto, 1fr, 1fr, 1fr),
    align: (col, row) => if col == 0 { left } else { center },
    stroke: 0.5pt,
    [], [*Conductor*], [*Semiconductor*], [*Insulator*],
    [**Band Gap** $E_g$], [$approx 0$ eV (Overlap)], [$0.6 - 3$ eV], [$> 3$ eV],
    [**Free Carriers**], [Very High ($10^22 "cm"^(-3)$)], [Moderate ($10^10 "cm"^(-3)$)], [Negligible],
    [**Conductivity** $sigma$], [High], [Variable (Doping/Temp)], [Very Low],
    [**Examples**], [Cu, Ag, Au], [Si, Ge, GaAs], [$"SiO"_2$, Diamond],
  ),
  caption: "Comparison of material classes based on electrical properties.",
)

=== Doping and Carrier Concentration
A pure semiconductor is called *intrinsic*. At $T > 0$K, thermal energy excites electron-hole pairs (EHPs), so $n = p = n_i$.
$ n_i(T) = A T^(3/2) e^(-E_g / (2 k T)) approx cases(10^10 "cm"^(-3) &"for Si", 10^13 "cm"^(-3) &"for Ge") "at 300K" $

To control conductivity, impurities are added (*doping*) to create *extrinsic* semiconductors:
- **N-type (Donors, Valence V):** Atoms like P, As, Sb provide extra electrons. $n approx N_D >> p$.
- **P-type (Acceptors, Valence III):** Atoms like B, Ga, In create holes. $p approx N_A >> n$.

#figure(
  image("part3_diagrams/Silicon_doping_-_Type_P_and_N.svg.png", width: 70%),
  caption: [Atomic lattice showing N-type (extra electron) and P-type (missing electron/hole) doping.],
)

=== Transport Mechanisms
There are two fundamental mechanisms for carrier movement:

1. **Drift (Electric Field):** Carriers accelerate due to $arrow(E)$ but constantly collide with the lattice, reaching a constant *drift velocity* $v_d$.
   $ arrow(v)_d = cases(-mu_n arrow(E) &"for electrons", +mu_p arrow(E) &"for holes") $
   This leads to **Ohm's Law** ($J = sigma E$):
   $ J_"drift" = J_n + J_p = q n v_(d,n) + q p v_(d,p) = underbrace(q(n mu_n + p mu_p), sigma) E $

2. **Diffusion (Concentration Gradient):** Carriers move from high to low concentration regions.
   $ J_"diff" = q D_n (d n)/(d x) - q D_p (d p)/(d x) $
   *Einstein Relation:* Links mobility and diffusion: $D/mu = (k T)/q = Phi_T$.

=== Energy Bands and Fermi Level
Electrons occupy energy states defined by bands. The *Fermi Level* ($E_F$) represents the energy state with a 50% probability of being occupied.
- **Conduction Band ($E_c$):** Lowest energy band for free electrons.
- **Valence Band ($E_v$):** Highest energy band for bound electrons.
- **Band Gap ($E_g$):** $E_c - E_v$. No states exist here.

$ E_g("Si") approx 1.12 "eV", " " E_g("Ge") approx 0.66 "eV at 300K" $

The thermal voltage, representing thermal energy in volts, is:
$ Phi_T = (k T)/q approx 26 "mV at 300K" $

=== Hall Effect
Used to determine carrier type and density. A magnetic field $arrow(B)$ perpendicular to current $I$ creates a Lorentz force $arrow(F) = q arrow(v) times arrow(B)$, deflecting carriers and creating a transverse voltage $V_H$.

$ V_H = (I B)/(q n t) " " ("for n-type bar of thickness" t) $
The sign of $V_H$ indicates if carriers are electrons ($-$) or holes ($+$). */
