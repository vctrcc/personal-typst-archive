#import "../syth_template.typ": conf, note_block, block_colors
#show: conf.with(
  title: [
    Part 1.1 - Dielectric, Magnetic and Conductive Materials
  ],
  course: "LELEC1755",
  authors: (
     (name: "Victor Carballes", affiliation: "UCLouvain"),
   ),
  abstract: [
  This document summarizes the main properties of dielectric, magnetic and conductive materials, as covered in the LELEC1755 course. In a theoretical and practical manner, prepared for the exams. \ #box(move(dy: 0.4em, [ Source code here : #text(fill: color.aqua.darken(20%))[#link("https://github.com/vctrcc/personal-typst-archive")]]))
  ],
)
= Introduction
This document is meant to summarize the key concepts and formulas related to dielectric, magnetic, and conductive materials as covered in the LELEC1755 course. It is meant to go slightly further and help with the resolution of exercises involving these materials, as well as providing a quick reference for the main equations and concepts.

One amazing resource is the book "Elements of Electromagnetics" by Matthew N.O. Sadiku @sadiku2014elements (2014), which covers most of the topics in a clear and concise manner. As well as the next part on transmission lines.

This part of the course will be useful for the next part on the physics of semiconductors.

Have a nice read.

= Electrostatics, Electrodynamics and Magnetism <electrostatics>
== How to solve

=== Hypotheses
#table(
  columns: (auto, 1fr),
  stroke: none,
  column-gutter: 1em,
  [*Infinite length*], [translational invariance along z-axis → 2D problem (x,y basis)],
  [*Infinite plane*], [translational invariance along x,y → 1D problem (z basis)],
  [*Cylindrical symmetry*], [rotational invariance around z-axis → cylindrical coords (r,z)],
  [*Spherical symmetry*], [invariance under all rotations → spherical coords (r only)],
  [*Quasi-static*], [slow time variation → neglect $partial/(partial t)$ terms, use electro/magnetostatics],
  [*Homogeneous medium*], [constant $epsilon, mu, sigma$ → uniform material equations],
  [*Linear medium*], [field-independent properties → superposition applies, linear PDEs],
  [*Isotropic medium*], [direction-independent properties → scalar uniform variables : $epsilon, mu, sigma$],
  [*Source-free region*], [No charge injection → the divergent is nul $nabla dot arrow(D) = rho_v = 0$],
  [*Perfect conductors*], [$sigma → infinity → E_"inside" = 0$, equipotential surfaces],
  [*Negligible edge effects*], [large enough geometry and field variations → ignore fringing],
)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  row-gutter: 0.5em,

  // Left image with caption
  figure(
    image("part1_diagrams/Sadiku matthew electronics/Sadiku Matthew Elements of Electromagnetics 2014_dielectric diagram.png", width: 100%),
    caption: [Dielectric material properties and electric field relationships. Shows how $arrow(E)$ and $arrow(D)$ fields behave in different dielectric media.@sadiku2014elements]
  ),

  // Right image with caption
  figure(
    image("part1_diagrams/Sadiku matthew electronics/Sadiku Matthew Elements of Electromagnetics 2014_magnetic diagram.png", width: 100%),
    caption: [Magnetic material properties and field relationships. Shows how $arrow(B)$ and $arrow(H)$ fields behave in different magnetic media.@sadiku2014elements]
  )
)

#note_block(block_colors.trick)[
Keep in mind that often the $arrow(E)$ and $arrow(D)$ fields are aligned from from negative to positive voltage, and from negative to positive charge. And, the $arrow(B)$ and $arrow(H)$ fields are aligned perpendicularly to current flows according to the right-hand rule. As well as perpendicular to $arrow(E)$ in electromagnetic waves. These relations are also represented in the boundary conditions. that we will see later.
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  row-gutter: 0.5em,

  // Left image with caption
  figure(
    image("part1_diagrams/E-H_fields.jpg", width: 100%),
    caption: [Coaxial cable E and H field simulations in regime.@pulse_coax]
  ),

  // Right image with caption
  figure(
    image("part1_diagrams/Electric-field-E-and-magnetic-field-H-distribution-in-the-cross-section-of-a-2331032985.png", width: 100%),
    caption: [Field representation for a planar conductor on a pcb with a ground plane. @milimiter_wave_antenna]
  )
)
]

=== Coordinate systems and field representations
Choose the appropriate coordinate system based on problem symmetry, then express fields in that basis.

General field representations:

$arrow(E) (x,y,z) &= E_x (x,y,z) hat(x) + E_y (x,y,z) hat(y) + E_z (x,y,z) hat(z) && --> && "Cartesian"\
arrow(E) (r, phi, z) &= E_r (r, phi, z) hat(r) + E_phi (r, phi, z) hat(phi) + E_z (r, phi, z) hat(z) && --> &&"Cylindrical" \
arrow(E) (r, theta, phi) &= E_r (r, theta, phi) hat(r) + E_theta (r, theta, phi) hat(theta) + E_phi (r, theta, phi) hat(phi) && --> && "Spherical"
$

*Example applications:*
- Infinite wire → cylindrical symmetry → $arrow(E) (r, cancel(phi), cancel(z)) = E_r (r, cancel(phi), cancel(z)) hat(r) + cancel(E_phi) hat(phi) + cancel(E_z) hat(z)$ (only radial component)
- Point charge → spherical symmetry → $arrow(E) (r, cancel(theta), cancel(phi)) = E_r (r, cancel(theta), cancel(phi)) hat(r) + cancel(E_theta) hat(theta) + cancel(E_phi) hat(phi)$
- Parallel plates → planar symmetry → $arrow(E) (cancel(x), cancel(y), z) = E_z (cancel(x), cancel(y), z) hat(z)$ (1D problem)

*Common coordinate systems used:*
- 1D Euclidean (z)
  - $arrow(E) (z) = E_z hat(z)$
  - $nabla dot arrow(E) (z) = (d E_z) / (d z) hat(z)$
  - $nabla times arrow(E) (z) = 0$
- 3D Cartesian (x,y,z)
  - $arrow(E) (x,y,z) = E_x hat(x) + E_y hat(y) + E_z hat(z)$
  - $nabla dot arrow(E) (x,y,z) = (d E_x)/(d x) hat(x) + (d E_y)/(d y) hat(y) + (d E_z)/(d z) hat(z)$
  - $nabla times arrow(E) (x,y,z) &= ((d E_z)/(d y) - (d E_y)/(d z)) hat(x) + ((d E_x)/(d z) - (d E_z)/(d x)) hat(y) + ((d E_y)/(d x) - (d E_x)/(d y)) hat(z)\ &= vec((d E_z)/(d y) - (d E_y)/(d z), (d E_x)/(d z) - (d E_z)/(d x), (d E_y)/(d x) - (d E_x)/(d y))$
- 3D cylindrical (r,z, $phi$)
  - $arrow(E) (r,z, phi) = E_r hat(r) + E_phi hat(phi) + E_z hat(z)$
  - $nabla dot arrow(E) (r,z, phi) = (d E_r)/(d r) hat(r) + (1/r)(d E_phi)/(d phi) hat(phi) + (d E_z)/(d z) hat(z)$
  - $nabla times arrow(E) (r,z, phi) &=
    (1/r (d E_z)/(d phi) - (d E_phi)/(d z)) hat(r) +
    ((d E_r)/(d z) - (d E_z)/(d r)) hat(phi) +
    (1/r)( (d(r E_phi))/(d r) - (d E_r)/(d phi)) hat(z)\
    &= vec(
      (1/r)(d E_z)/(d phi) - (d E_phi)/(d z),
       (d E_r)/(d z) - (d E_z)/(d r),
        (1/r)(d(r E_phi))/(d r) - (1/r)(d E_r)/(d phi))$
- 3D cylindrical (r, $theta$, $phi$)
  - $arrow(E) (r, theta, phi) = E_r hat(r) + E_theta hat(theta) + E_phi hat(phi)$
  - $nabla dot arrow(E) (r, theta, phi) = (d E_r)/(d r) hat(r) + (1/r)(d E_theta)/(d theta) hat(theta) + (1/(r sin(theta)))(d E_phi)/(d phi) hat(phi)$
  - $nabla times arrow(E) (r, theta, phi) &=
    (1/(r sin(theta)))((partial ( sin(theta) E_phi))/(partial theta) - (partial(r E_theta))/(partial phi)) hat(r) +
    ((1/(r sin(theta)))(partial E_r)/(partial phi) - (1/r) (partial (r E_phi))/(partial r)) hat(theta) +
    (1/r)((d(r E_theta))/(d r) - (d E_r)/(d theta)) hat(phi)\
  &= vec(
    (1/(r sin(theta)))(partial ( sin(theta) E_phi))/(partial theta) - (1/(r sin(theta)))(partial(r E_theta))/(partial phi),
    (1/(r sin(theta)))(partial E_r)/(partial phi) - (1/r) (partial (r E_phi))/(partial r),
    (1/r)(d(r E_theta))/(d r) - (1/r)(d E_r)/(d theta))$

#note_block(block_colors.note)[
  The cross product of vectors is defined as :

  $ arrow(A) times arrow(B) =|A||B|sin(theta)= vec(A_y B_z - A_z B_y, A_z B_x - A_x B_z, A_x B_y - A_y B_x) <-> cases(A_i : x -> y -> z -> x\
  B_i : y <- z <- x <- y) $
]

=== Maxwell equations
Then, next step is writing down Maxwell's equations in the chosen basis, and simplifying them using the hypotheses.

Maxwell's equations (time-domain, differential form):
- $nabla dot arrow(D) = rho_v$
- $nabla dot arrow(B) = 0$
- $nabla times arrow(E) = -(partial B)/(partial t)$
- $nabla times arrow(H) = arrow(J_"tot") + (partial D)/(partial t)=arrow(J_"conduction") + arrow(J_"displacement")=(sigma arrow(D)) + (epsilon (partial arrow(E))/(partial t))$#footnote([Expansion of $(partial arrow(D))/(partial t) = (partial (epsilon arrow(E)))/(partial t)= arrow(E)(partial epsilon)/(partial t) + epsilon (partial arrow(E))/(partial t)$ and with epsilon uniform in time, we have : $(partial arrow(D))/(partial t) = epsilon (partial arrow(E))/(partial t)$])
- $nabla dot arrow(J) = -(partial rho_v)/(partial t)$

When integrating, it is important to keep the full solution of the integral $ integral f(x) dif x = F(x)+C$ where C is often the key to solving the exercice ! As most of the equations are with $f(x)=0$.

#note_block(block_colors.trick)[
  To obtain the harmonic form of Maxwell's equations, assume time-harmonic fields with angular frequency $omega$ (e.g., $arrow(E)(r,t) = Re{arrow(E)(r) e^(j omega t)}$). Then, replace time derivatives with multiplication by $j omega$ (e.g., $(partial)/(partial t) arrow(E)(r,t) = j omega arrow(E)(r)$). This leads to the frequency-domain form of Maxwell's equations:
  - $nabla dot arrow(D) = rho_v$
  - $nabla dot arrow(B) = 0$
  - $nabla times arrow(E) = -j omega arrow(B)$
  - $nabla times arrow(H) = arrow(J_"tot") + j omega arrow(D) = sigma arrow(E) + j omega epsilon arrow(E) = (sigma + j omega epsilon) arrow(E)$
  - $nabla dot arrow(J) = -j omega rho_v$
]


=== Boundary conditions
There are 6 different boundary conditions that can be applied at the interface between two different materials. These conditions are derived from Maxwell's equations and ensure the continuity of certain field components across the boundary.

In this course, all problems are well posed, such as that all the boundary conditions can be applied at the same time, and that there is no contradiction between them. If such a case appears, it means that one of the hypotheses is not valid. And you will need to use the principle of superposition to split the problem into several sub-problems that can be solved independently.

The boundary conditions are:
1. Continuity of the tangential component of the electric field:
   - $hat(n) times (arrow(E)_1 - arrow(E)_2) = 0$
   - This condition ensures that the tangential component of the electric field is continuous across the boundary between two materials.
   - Only apply it when the normal is perpendicular to the $arrow(E)$ field

2. Discontinuity of the normal component of the electric flux density:
   - $hat(n) dot (arrow(D)_1 - arrow(D)_2) = rho_s$
   - This condition accounts for any surface charge density ($rho_s$) present at the boundary between two materials (dielectric $epsilon != 0$ and conductor $sigma != 0$).
   - Only apply it when the normal is aligned with the $arrow(D)$ field

3. Continuity of the normal component of the magnetic flux density:
    - $hat(n) dot (arrow(B)_1 - arrow(B)_2) = 0$
    - This condition ensures that the normal component of the magnetic flux density is continuous across the boundary between two materials.
    - Only apply it when the normal is aligned with the $arrow(B)$ field

4. Discontinuity of the tangential component of the magnetic field intensity:
   - $hat(n) times (arrow(H)_1 - arrow(H)_2) = arrow(K) = arrow(J_s)$
   - This condition accounts for any surface current density ($arrow(J_s)$) present at the boundary between two materials (conductor $sigma != 0$ and dielectric $epsilon != 0$).
   - Only apply it when the normal is perpendicular to the $arrow(H)$ field

5. Preservation of current continuity:
   - $hat(n) dot (arrow(J)_1 - arrow(J)_2) + underbrace(nabla arrow(K), nabla arrow(J_s)) +  (partial rho_s)/(partial t)= 0$
   - This condition ensures that the normal component of the current density is continuous across the boundary between two conductive materials.
   - Only apply it when the normal is aligned with the $arrow(J)$ field

6. Voltage to electric field relation (not really a boundary condition):
   - $V = - integral_a^b arrow(E) dot dif arrow(l)$
   - This condition relates the voltage difference between two points (a and b) to the line integral of the electric field along a path connecting those points.
   - Only apply it when you need to find the voltage difference between two points in an electric field.
   - This one is not really a boundary condition, but it is very useful to solve exercices.

=== Dealing with charges
When dealing with charges, one must consider carefully the situations, such as when there are free charges injected in the system, or if the medium is inhomogeneous, etc. Here are some points to give attention to.

Due to charge conservation, the continuity equation must always be satisfied:
$ "Charge conservation equation"
    #footnote([The charge conservation equation comes from :\ $nabla times H=J_"tot" +(partial D)/(partial t) -->_(nabla dot (nabla times H) = 0) 0=nabla J_"tot" + partial/(partial t)(nabla D) -->_(nabla D=rho_v) 0=nabla J_"tot" + (partial rho_v)/(partial t)$])
  &: (partial rho_v)/(partial t) + nabla . arrow(J) = 0\
 "Surface distribution condition"
  &: hat(n)(arrow(J_1) - arrow(J_2)) + nabla_s K + (partial rho_s)/(partial t) = 0 $


==== Finding the total charge $Q_"tot"$
Using these equations, we can determine the various representations of $Q_"tot"$, which remains constant throughout the system in steady-state conditions. However, in a transient state, the time evolution of the charge densities must be considered. If the system is closed (i.e., no charge injection or applied voltage), then $Q_"tot" = 0$, implying that $Q_+ = Q_(-)$.

$ Q_"tot" = Q_+ - Q_(-) &= integral.double_S rho_s dif S + integral.triple_V rho_v dif V = "cst"\
&= integral.cont_(partial V) D dif S = integral.triple_V nabla D dif V
$
#note_block(block_colors.warning)[At the exam, when asked for the charge, they are asking for $Q_+$ or $Q_-$, as $Q_"tot" = 0$ !]
This charge has a time evolution that can be further developped with :
$ (dif Q_"tot")/(dif t) = -integral.cont_(partial V) J dif S - integral.double_(S_"interior") nabla_s K dif S $
#note_block(block_colors.note)[Keep in mind that $arrow(K)$ is not really used in this course.]

In steady-state conduction with closed boundaries, $(dif Q_"tot")/(dif t) = 0$, and then, $nabla arrow(J) = 0$ and $nabla arrow(D) = rho_v$.

==== $rho_v$ general solution (any $epsilon$, $sigma$)
General solution of $rho_v$ for any $epsilon$, $sigma$ :

$ "From" &: cases(nabla dot arrow(D) = nabla dot (epsilon arrow(E)) = epsilon nabla dot arrow(E) + arrow(E) nabla epsilon = rho_v,  nabla dot arrow(J) = nabla dot (sigma arrow(E)) = sigma nabla dot arrow(E) + arrow(E) dot nabla sigma = -(partial rho_v)/(partial t))\
"Obtain" &: rho_v = arrow(E) dot (nabla epsilon - epsilon/sigma nabla sigma) - epsilon/sigma (partial rho_v)/(partial t) ==>^(tau=epsilon/sigma) rho_v=arrow(E) dot (nabla epsilon - tau nabla sigma) - tau (partial rho_v)/(partial t)\
"Equation" &: (partial rho_v)/(partial t) + 1/tau rho_v = arrow(E) dot (1/tau nabla epsilon - nabla sigma)\
"Solution" &: rho_v (t) = rho_v^((infinity)) + (rho_v (0) - rho_v^((infinity))) e^(-t/tau) --> rho_v^((infinity))=arrow(E) dot (nabla epsilon - tau nabla sigma)\
$
Where $arrow(E), epsilon "and" sigma$ are temporaly constant. This last solution can be *further simplified* in the case of simple decay of charges in a *homogeneous* medium :
$ rho_v &= epsilon/sigma (partial rho_v)/(partial t) \
 rho_v (t) &= rho_v (0) e^(-t/tau) --> rho_v(0) = 0 $

==== $rho_v$ conditional table
#table(
  columns: (2.1fr, 2.5fr, 1fr, 3fr),
  align: (left, left, center, left),
  inset: 6pt,
  stroke: 0.5pt,

  table.header(
    [*Medium \ parameters*],
    [*Situation*],
    [*$rho_v$*],
    [*Reason*],
  ),

  [ $epsilon="cst"$, $sigma="cst"$ ],
  [ Steady-state conduction ],
  [ $0$ ],
  [ Uniform medium ⇒ $ nabla dot (sigma arrow(E))=0 -> epsilon nabla dot arrow(E)=0 -> rho_v = 0$. ],

  [ $epsilon="cst"$, $sigma="cst"$ ],
  [ Time-varying fields (AC), no injection ],
  [ $0$ ],
  [ Gauss law unchanged: $rho_v=0$. ],

  [ $epsilon="cst"$, $sigma="cst"$ ],
  [ Injected free charges Q (Mentioned in problem)],
  [ $≠0$ ],
  [ Injected free charges create $rho_v$ (eg. doping of semiconductors). ],

  [ $epsilon="cst"$, $sigma=sigma(r)$ ],
  [ Steady-state conduction,\ Inhomogeneous ],
  [ $≠0$ ],
  [ $epsilon nabla dot arrow(E)=rho_v$ and $nabla dot (sigma arrow(E)) = 0$\ $rho_v=-epsilon (arrow(E) dot nabla sigma)/sigma=-arrow(D) dot (nabla sigma)/sigma$.],

  [ $epsilon=epsilon(r)$, $sigma="cst"$ ],
  [ Steady-state conduction,\ Inhomogeneous ],
  [ $≠0$ ],
  [ $nabla dot (epsilon arrow(E))=rho_v$ and $sigma nabla dot arrow(E) = 0$\ $rho_v= arrow(E) dot nabla epsilon$.],

  [ $epsilon=epsilon(r)$, $sigma=sigma(r)$ ],
  [ Steady-state conduction,\ Inhomogeneous ],
  [ $≠0$ ],
  [ $nabla dot (epsilon arrow(E))=rho_v$ and $nabla dot (sigma arrow(E)) = 0$\
  $rho_v=arrow(E) dot (nabla epsilon - epsilon/sigma nabla sigma)$.],

  [ $epsilon=epsilon(r)$, $sigma=0$ ],
  [ Electrostatics, \ (inhomog. dielectric) ],
  [ $0$ ],
  [ No free charges in dielectric (bound charge not covered). ],

  [ $epsilon="cst"$, $sigma=0$ ],
  [ Electrostatics,\ homogeneous, no sources ],
  [ $0$ ],
  [ Source-free uniform medium. ],

  [ Vacuum ($epsilon_0$), $sigma=0$ ],
  [ No charges present ],
  [ $0$ ],
  [ $nabla (epsilon E)=0$ in source-free region. ],

  [ Vacuum ($epsilon_0$), $sigma=0$ ],
  [ With point/line charges Q \ (Explicitly mentioned) ],
  [ $≠0$ (singular) ],
  [ $rho_v$ as delta functions at charges. ],

  [ $sigma→∞$ (perfect conductor) ],
  [ Electrostatics ],
  [ bulk $0$ ],
  [ E=0 inside; charge moves to surface ($rho_s$). ],
)

==== $rho_s$ conditional table
#table(
  columns: (2.1fr, 2.5fr, 1fr, 3fr),
  align: (left, left, center, left),
  inset: 6pt,
  stroke: 0.5pt,

  table.header(
    [*Interface parameters*],
    [*Situation*],
    [*$rho_s$*],
    [*Reason*],
  ),

  [ Metal | Dielectric contact (Voltage)],
  [ With explicit voltage $V_0$ (no deposited sheet) ],
  [ $≠0$ ],
  [ Inside metal $E=0$ ⇒ $D=0$;\ $hat(n) dot (arrow(D_2)-arrow(D_1))=D_"diel"=rho_s$ ],// V_0

  [ Metal | Dielectric contact\ (Charge Injection)],
  [ With explicit free sheet charge $Q$ ],
  [ $≠0$ ],
  [ By definition of a sheet:\ $hat(n)dot (arrow(D_2) - arrow(D_1)) D_"diel"= ρ_s\ "Gauss" : integral.cont_(delta Omega) D_"diel" dif S = Q_"in"$],// Q= integral

  [ Dielectric 1 | Dielectric 2 ],
  [ No free surface charge ],
  [ $0$],
  [ Free charge condition : \ $hat(n) dot (arrow(D_2) - arrow(D_1)) = 0$],

  [ Dielectric | Vacuum ],
  [ No free surface charge ],
  [ $0$ ],
  [ Bound $rho_s$ arises if polarization is discontinuous (no free sheet).#footnote("Polarization is the alignment of electric dipoles in a material in response to an electric field, which can lead to bound charges at interfaces when it changes abruptly.") ],

  [ Conduction $sigma$ jump at interface ],
  [ Same $epsilon$, but $sigma_1 ≠ sigma_2$ ],
  [ $0$ ],
  [ Conductivity jump alone does not create $rho_s$ at steady state. ],

  [ Conductor cavity wall ($sigma!=0 -> sigma=0$) ],
  [ Charges accumulate on the surface (often $rho_v != 0$) ],
  [ $≠0$ ],
  [ Induced $rho_s$ enforces $E=0$ inside the conductor. ],

  [ Conductor edges / corners in dielectric],
  [ Electrostatics (use Finite Elements)],
  [ singular],
  [ Local divergence of $arrow(E)$ at sharp edges ⇒ high $rho_s$ (finite charge). ],
)


=== Resolution of exercices
==== Defining the problem
1. Draw the problem ! A clear picture is worth a thousand words. And this way, the teacher can understand your normals and the geometry you are referring to.
2. Define the coordinate system and the field representations. (Ansatz)
3. Write down Maxwell's equations and the boundary conditions in the chosen basis. While also simplifying them using the hypotheses. (e.g. $rho_v=0 "and" rho_s=0$ in most cases)
==== Finding first level unknowns $arrow(E)$, $arrow(D)$, $arrow(H)$, $arrow(B)$, $arrow(J)$
4. Solve the equations to find the primary unknown fields. This may involve integrating differential equations, applying boundary conditions, and using material properties.
5. Apply boundary conditions at interfaces between different materials to ensure continuity and account for any surface charges or currents.

==== Finding second level unknowns $rho_s$, $rho_v$, $I$, $V$, $Q$
6. Once the primary fields are known, calculate secondary quantities such as surface charge density ($rho_s$), volume charge density ($rho_v$), current ($I$), voltage ($V$), and charge ($Q$) using the relevant equations and relationships.
7. Verify the results by checking for consistency with physical laws and boundary conditions.

==== Circuit element equivalences $R$, $G$, $C$, $L$

*Basic definitions and frequency response:*
#table(
  columns: (auto, 1fr, 1fr),
  stroke: 0.5pt,
  [*Element*], [*Basic Definition*], [*AC Impedance*],
  [*Resistor*], [$R = V/I$ (Ohm's law)], [$Z_R = R$],
  [*Capacitor*], [$C = Q/V$ (charge storage)], [$Z_C = 1/(j omega C)$],
  [*Inductor*], [$L = Phi_B/I$ (flux linkage)], [$Z_L = j omega L$],
)

*Material-based formulas for simple geometries:*

*Resistance and conductance* (current flow through material):
- $R = rho (l)/(A) = (l)/(sigma A)$ where $rho = 1/sigma$ (resistivity)
- $G = 1/R = (sigma A)/(l)$ (conductance)
- Physical meaning: Longer path → higher R; larger area → lower R

*Capacitance* (charge storage between conductors):
- $C = (epsilon A)/(d)$ (parallel plates)
- Physical meaning: Larger area or higher ε → more C; larger separation → less C

*Inductance* (magnetic flux linkage):
- $L = (mu N^2 A)/(l)$ (solenoid with N turns)
- Physical meaning: More turns, larger area, or higher μ → more L

*Field-based calculations for complex geometries:*

When geometry is complex, use electromagnetic fields to find equivalent circuit values:

*Method:*
1. Apply unit excitation (1V or 1A)
2. Solve for electromagnetic fields
3. Calculate equivalent circuit parameter

*Field-to-circuit relationships:*
- *Capacitance*: $C = (Q)/(V) = (integral_S arrow(D) dot dif arrow(S))/(integral_"path" arrow(E) dot dif arrow(l))$
  - Apply 1V between conductors → find D field → integrate to get Q

- *Inductance*: $L = (Phi_B)/(I) = (integral_S arrow(B) dot dif arrow(S))/(integral_"loop" arrow(H) dot dif arrow(l))$
  - Apply 1A current → find B field → integrate flux through loop

- *Resistance*: $R = (V)/(I) = (integral_"path" arrow(E) dot dif arrow(l))/(integral_S arrow(J) dot dif arrow(S))$
  - Apply voltage → find E field → relate to current density J

*Key insight:* These field integrals convert distributed electromagnetic energy storage/dissipation into lumped circuit elements.

==== Resolving for time variations $V(t)$, $I(t)$, $Q(t)$, $rho_s (t)$, $rho_v (t)$
When fields change with time, we need to account for displacement currents, induced EMFs, and dynamic behavior.

*Kirchhoff's current law (KCL):*
$ sum I_"node" = 0 quad --> quad "Conservation of charge at any node" $

#text(size: 13pt)[*Current through circuit elements:*]
#block()
*Capacitor current* (*displacement* current):
$ I_C = (dif Q)/(dif t) = C (dif V)/(dif t) =  (dif)/(dif t) integral_S arrow(D) dot dif arrow(S) = integral_S epsilon (partial arrow(E))/(partial t) dot dif arrow(S) $
- Physical meaning: Current flows when electric field changes, even without physical charge movement
- Key insight: $I_C = C (dif V)/(dif t)$ for lumped elements

*Resistor current* (*conduction* current):
$ I_R = V/R = integral_S arrow(J) dot dif arrow(S) = integral_S sigma arrow(E) dot dif arrow(S) $
- Physical meaning: Current due to charge carriers moving through conductor
- Key insight: $I_R = V/R$ (Ohm's law) for lumped elements

*Circuit analysis approach:*
1. Apply KCL: $I_C + I_R + I_L = 0$ (or appropriate combination)
2. Express each current in terms of fields or circuit variables
3. Solve the resulting differential equation
4. For sinusoidal steady-state: use phasors and complex impedance ($Z_C = 1/(j omega C)$, $Z_L = j omega L$)

#note_block(block_colors.note)[
*First-order differential equations in circuit analysis*

Many electromagnetic problems lead to 1st-order ODEs of the form:
$ tau (dif x)/(dif t) + x = x_"final"$

where $x(t=0) = x_0 "and" x(t -> infinity) = x_"final"$ (initial condition).

*Solution:* $x(t) = x_"final" + (x_0 - x_"final") e^(-t/tau)$

*Physical interpretation:*
- $x_0$: initial value at $t = 0$
- $x_"final"$: steady-state value as $t → infinity$
- $tau$: time constant (how fast the system responds)

*Time constant definitions:*
- RC circuits: $tau = R C$ (charging/discharging capacitor)
- RL circuits: $tau = L/R$ (current buildup in inductor)

*Key insight:* After time $tau$, the system reaches ~63% of its final value. After $5tau$, it's ~99% complete.

*Example:* Capacitor charging through resistor R with voltage source V₀:
- Equation: $R C (dif V_C)/(dif t) + V_C = V_0$
- Solution: $V_C (t) = V_0(1 - e^(-t/(R C)))$

*Example:* Volumetric charge density decay in time due to conduction:
- Equation: $ nabla dot arrow(J) + (partial rho_v)/(partial t) = 0  -> nabla arrow(D)=rho_v "and"  hat(n)(arrow(J_1) - arrow(J_2)) + cancel(nabla arrow(K)) + cancel((partial rho_s)/(partial t))=0$
- Solution: $rho_v (t) = rho_v (0) e^(-t/tau)$ with time constant $tau = epsilon/sigma$
]

== Solving exercices
This part will focus on the resolution of exercices, and the key steps to perform. We will see the tricks and little nuances that will be very useful for the exam. This part is by no mean a good formulaire for the exam, but its meant for it to be readable for revision.

A good practice for the exam, is to re-draw the problem, and write the full ansatz, with justifications. As the teacher will be giving points for the explanations too.

#note_block(block_colors.note)[
  This part will be useful for the second part of the course on the physics of semiconductors, junctions and both BJT and MOS transistors.
]
#note_block(block_colors.warning)[
  Always keep in mind the physical meaning of the equations you are using. This will help you to avoid mistakes and to understand the problem better.
  Here are a few suggestions :
  - The direction of the fields :
    - $arrow(E)$ points from high to low potential (positive to negative voltage or charge)
    - $arrow(D)$ points from positive to negative charge
    - $arrow(B)$ and $arrow(H)$ follow the right-hand rule around current-carrying conductors
  - In conductors, $arrow(E)$ is very small (ideally zero in perfect conductors), while $arrow(J)$ can be large
  - In dielectrics, $arrow(J)$ is ideally zero, while $arrow(E)$ can be significant
  - If there is a current flowing, then there are charges moving. Meaning there will be a $rho_s != 0$ as there will be surface charges, and also $rho_v != 0$ with the charge movement.
  - The surface charge density $rho_s$ is only on the surface of conductors, and is zero in between pure dielectrics.
  - Boundary conditions reflect physical continuity or discontinuity of fields at material interfaces
  - Time-varying fields induce additional effects (displacement current, induced EMF) that must be accounted for
  - Make sure the units are consistent throughout your calculations (e.g., SI units)
  - Don't forget to derive spherical and cylindrical coordinates carefully, as they can be tricky (with the $1/r$ and $1/(r sin(theta))$ terms)
]
// TODO

=== Methodology
1. *Draw the diagram*, and define the "zones" and vector directions (such as *normals*, field directions, coordinate system). Normals should always go from zone 2 to zone 1. #footnote("Here, zones refer to possibly different materials. They have different properties, and require to be defined in a clear manner.")
2. Write the ansatz, with the coordinate system (cartesian, cylindrical, spherical) and the field representations and simplify them with the hypotheses.
3. Write down Maxwell's equations in the chosen basis, and simplify them using the hypotheses, and identify the elements that are unknown.
4. Solve these maxwell equations for each "zone".
5. Apply the boundary conditions at the interfaces between the different zones.
6. Solve the resulting equations to find the unknowns (often E, D J, B, H or V).
7. Solve for the secondary unknowns (often $rho_s$, $rho_v$, I, Q), these often have a dependance on time. And if asked, find the equivalences R, G, C, L.
8. Solve for time for t=0 and t=$infinity$, and find the time constant if needed (often $rho_v(t)$, $rho_s(t)$, $E(t)$ or $J(t)$). This part also require sometimes the equivalences R, G, C, L. Where the resolution is simple circuit analysis with KCL and the element equations.

#note_block(block_colors.trick)[
  ALWAYS justify your simplifications and hypoteses for ansatz and maxwewll equations. As these give many points at the exam for cheap.
]
#note_block(block_colors.trick)[
  ALWAYS draw the whole diagram with the normals, and the field directions. As this will help you and the teacher to understand your reasoning.
]
#note_block(block_colors.trick)[
  At the exam, you can sometimes gain a few bonus points by proving that the charge is 0 for example, and that its independant to the conductance.

  $"Situation :" nabla arrow(D) = nabla epsilon arrow(E) =^(epsilon="cst") epsilon nabla arrow(E) = rho_v " & " nabla arrow(J) = nabla sigma arrow(E) =^(sigma="cst") sigma nabla arrow(E) = -(partial rho_s)/(partial t) =^(t="cst") 0$

  $"Solution :" sigma nabla arrow(E) = 0 -> nabla arrow(E) = 0 -> nabla arrow(D) = 0 -> rho_v=0 -> Q=integral.cont_(partial V) arrow(D) dif S= integral_V rho_v dif V = 0$
]

=== Tricks found in exercices
==== Integral Constant as a key to the solution
When deriving the maxwell equations, always keep the constant part. As it will then be solved using the boundary conditions.

$ nabla D = 0
 &-->^((x, y, z)) (partial D_z)/(partial z) =0 -> D_z = integral 0 dif z = K_1(z) \
 &-->^((r, theta, z)) (partial D_r)/(partial r) = 1/r (partial (r D_r))/(partial r) = 0 -> D_r = (K_2(r))/r \
 &-->^((r, theta, phi)) (partial D_r)/(partial r) = 1/r^2 (partial (r^2 D_r))/(partial r) = 0 -> D_r = (K_3 (r))/r^2 \
 &-->^((r, theta, phi)) (partial D_theta)/(partial theta) = 1/(r sin(theta)) (partial (sin(theta) D_theta))/(partial theta) = 0 -> D_theta = (K_4 (theta))/(sin(theta)) $

==== Multiple materials and only one charged conductor
When 2 materials are touching the same perfect conductor, then the total charge is shared proportionally between them. Through the Gauss law, we are integrating a sort of circle/surface on the surface with rho_s density (the electric flux density going through that surface). This means that you have to solve a small equation here.
$ Q=sum_i^N Q_i = sum_i^N integral_S rho_(s, i) dif S -> underbrace(integral.cont_S arrow(D) dif S=Q, "Gauss Law") $

For example, for a capacitor with 2 dielectrics, the charge on each plate would have its charge equation looking like this :
$ rho_(s, 1) dot (a b)/2 + rho_(s, 2) dot (a b)/2 = Q -->^"top plate\n normals up" -D_1 (a b)/2 - D_2 (a b)/2 =Q $

But be very careful with $rho_s != 0$ and $rho_v != 0$ when we are not in homogenous materials.

==== Side by side non void materials must have a boundary condition
When 2 materials are one next to the other, if they touch perpendicularly to the E field. Then, you have to apply the $hat(n) times (arrow(E_1) - arrow(E_2)=arrow(0))$ limit condition. This condition will work with the $nabla times E = - (partial arrow(B))/(partial t) = arrow(0)$ maxwell equation. As the curl of E is zero, then the tangential component of E must be continuous. This will often give you a relation between the fields in the 2 materials.

==== Look at the direction of the charges
A positive charge generates an outgoing electric field, while a negative charge generates an ingoing one. This is important when setting up the ansatz, as it helps identify the correct orientation of the fields. The electric field $arrow(E)$ always points from positive to negative potential, i.e. opposite to the direction of increasing voltage. As we can see from Figure @fig:cap_diagram, $E_+ + E_- = 0$ on top and on the bottom of the plates, just like in a coaxial cable. Also, from the equations, we can see that the direction $hat(D) = hat(E) = hat(J)$ are equal, as $D = epsilon E$ and $J = sigma E$.

#figure(
  image("part1_diagrams/capacitor_charges diagram.svg", width: 50%, format: "svg"),
  caption: [Diagram of the charges and fields in a capacitor with a positive and a negative plates.]
)<fig:cap_diagram>

==== Boundary conditions are applied at boundaries
Boundary conditions are applied at the interface between two different materials. These conditions are derived from Maxwell's equations and ensure the continuity of certain field components across the boundary.
For example, a capacitor with a plate at 0, and another at d :
$ hat(n) (arrow(D_1) - arrow(D_2)) = 0 --> D_1(d) = D_2(d)  "  and  " D_1(0) = D_2(0) $

==== Finding surface and volume charge densities on injected geometries
When free charges are injected into a system, they can create both surface charge densities ($rho_s$) and volume charge densities ($rho_v$). The distribution of these charges depends on the geometry of the system and the material properties.
$ ρ_s = Q / S &--> ρ_s = cases(
  "rectangular:" Q / (a b),
  "disk:" Q / (π r^2),
  "cylinder (lateral surface):" Q / (2 π r h),
  "sphere (surface):" Q / (4 π r^2)
) \

 ρ_v = Q / V &--> ρ_v = cases(
  "rectangular:" Q / (a b h),
  "cylinder:" Q / (π r^2 h),
  "sphere:" Q / ((4 / 3) π r^3)
) $

For a sphere in these problems, a special condition is needed, where $arrow(E)(0)=arrow(0)$ to solve the singularity at the center. This is the missing limit condition.

==== Potential of a injected charge (Reference of voltage)
When a point charge Q is placed in a medium with permittivity $epsilon$, it creates an electric potential V at a distance r from the charge. The potential for a sphere of radius a is given by:
$ V = cases(r>a : V(+infinity) - V(r) = - integral E_(r,2) dif arrow(l), r<a : V(a) - V(r) = - integral E_(r,1) dif arrow(l)) $

Where $V(+infinity) = 0$ in a linear medium, and is the potential reference of the system.

==== Checking equivalent component solutions
One very nice way to check if your solution is correct, is to just verify that there are no dependencies on axis variables, such as $r, theta, phi, x, y,z, ...$ Most often than not, you just forgot to simplify, integrate or derive something.

=== Exercise Examples
==== Dealing with a axis aligned conductor creating a magnetic field
We consider a flat ring conductor, with a current I flowing counter clockwise. We have to proceed a bit differently :
$ arrow(H)(cancel(r), cancel(phi), z) &= cancel(H_r (cancel(r), cancel(phi), z)hat(r)) + cancel(H_phi (cancel(r), cancel(phi), z)hat(phi)) + H_z (cancel(r), cancel(phi), z) hat(z) \ H(z)&= H_z (z) hat(z) $
Ansatz justification :
- $H_r = 0$ by symmetry (no preferred radial direction)
- $H_phi = 0$ by symmetry (no preferred tangential direction)
- independant of $phi$ by symmetry (rotational symmetry around z)
- independant of $r$ by symmetry (no preferred radial distance, axis at r=0)

#block()
From here on, we can use the Biot-Savart law to find the magnetic field, as we can easilly describe the distance to the ring conductor of any point, as we are aligned along the z axis. If this where not true, then, we would have to use maxwell's equations to find the field (which is much more complicated).
#footnote([The Biot-Savart law has 3 representation, depending on the problem. It is often used as $arrow(B) = mu_0 arrow(H)$, as we often want to find the magnetic field density. But here, we are only interested in the magnetic field intensity.])
$ H(z)
= integral.triple_V ((arrow(J_phi) dif V) times hat(u_r))/(4 pi |u_r|^2)
= integral.double_S ((arrow(K_phi) dif S) times hat(u_r))/(4 pi |u_r|^2)
= integral_(partial Omega) ((arrow(I_phi) dif l) times hat(u_r))/(4 pi |u_r|^2) $
Here, we have flat geometry, so we can use the surface current density $arrow(K)$ for the representation, as we don't just have a thin wire. We define $arrow(K) = K_phi hat(phi)$.
$ arrow(K) = I/(b-a) hat(phi) $
Also, as we have a *cross product*, we have to be careful of the *resulting coefficients and scaling*.
$ hat(u_r) = (arrow(z) - arrow(r))/sqrt(z^2 + r^2) --> hat(phi) times hat(u_r) = vec(0, 0, 1)times vec(-r/sqrt(z^2+r^2), 0, z/sqrt(z^2+r^2))= (r hat(z) + z hat(r))/sqrt(z^2+r^2) -->^"Symmetry" (r hat(z))/sqrt(z^2+r^2) $
Now, we can finally calculate the magnetic field.
$ H(z) = integral_a^b integral_0^(2pi) (K_phi hat(phi) times hat(u_r))/(4 pi sqrt(z^2+r^2)^2)r dif phi dif r=integral_a^b (2pi I)/(4pi (b-a)) (r^2 hat(z))/sqrt(z^2+r^2)^3 dif phi $
I will not be writing the full solution, as its very big, and its not the point of this document. This is from exercise 2.4.

==== Calculating the magnetic field in a coaxial permeable cable
Here, the trick is differenciating the 4 zones of the cable. When using Ampere's law, we have to consider the current enclosed by the Amperian loop. This current will change depending on the zone we are in. ($integral.cont arrow(H) arrow(dif l) = integral_"in" arrow(J) arrow(dif S)$ in steady state conduction)
- Zone 1 : $0<r<a$ (inner conductor) $-->$ Current is modulated by the surface area of the radius
- Zone 2 : $a<r<b$ (inner dielectric) $-->$ The whole current is considered in the equation
- Zone 3 : $b<r<c$ (outer conductor) $-->$ The current is reduced by the inverse current on the outer sleeve
- Zone 4 : $c<r$ (outer dielectric) $-->$ The magnetic field is 0, as the total current is 0 (perfect compensation of the inner and outer conductor)

#pagebreak()
= More Ressources
== Definitions
#table(
  columns: (4.5em, 11em, auto, 6em),
  stroke: none,
  column-gutter: 0.3em,

  [*Symbols*], [*Name*], [*Definition*], [*Units*],

  [* $arrow(E)$ *], [Electric field intensity], [Describes the force per unit charge at a point in space. Created by a voltage difference.], [$V/m = N/C = ("kg" dot m)/(s^3 dot A)$],

  [* $arrow(D)$ *], [Electric flux density], [Electric displacement field; relates to electric field by $arrow(D) = ε arrow(E)$. Represents charge storage in a medium.], [$C/m^2$],

  [* $ρ$ *], [Free (volume) charge density], [Charge per unit volume; appears in Gauss’s law as $integral_S arrow(D) · hat(n) dif S = Q_("enc")$.], [$C/m^3$],

  [* $ρ_s$ *], [Surface charge density], [Charge per unit area on a surface; $Q_s = integral_S ρ_s dif S$.], [$C/m^2$],

  [* $arrow(B)$ *], [Magnetic flux density], [Magnetic induction; relates to magnetic field by $arrow(B) = μ arrow(H)$. Measures magnetic flux per unit area.], [$T = "Wb"/m^2 = N/(A dot m)$],

  [* $arrow(H)$ *], [Magnetic field intensity], [Field produced by currents or magnetization; $hat(n) × (arrow(H)_2 - arrow(H)_1) = arrow(K)$.], [$A/m$],

  [* $μ$ *], [Magnetic permeability], [Proportionality constant between $arrow(B)$ and $arrow(H)$ in a medium; $μ = μ_0 μ_r$.], [$H/m = N/A^2$],

  [* $ε$ *], [Electric permittivity], [Proportionality between $arrow(D)$ and $arrow(E)$; $arrow(D) = ε arrow(E)$. Determines material’s ability to store electric energy.], [$F/m = C/(V dot m) = (A dot S)/(V dot m)$],

  [* $arrow(J)$ *], [Current density], [Conduction current per unit area. Ohm’s law: $arrow(J) = σ arrow(E)$. Continuity: $(dif ρ)/(dif t) + ∇ · arrow(J) = 0$.], [$A/m^2$],

  [* $arrow(J)_s = arrow(K)$ *], [Surface current density], [Current per unit width on a surface. Boundary condition: $hat(n) × (arrow(H)_2 - arrow(H)_1) = arrow(K)$.], [$A/m$],

  [* $σ$ *], [Electrical conductivity], [Material property linking current and electric field: $arrow(J) = σ arrow(E)$.], [$S/m = A/(V dot m)$],

  [* $σ_s$ *], [Surface conductivity], [Sheet conductance; property of thin conductive layers.], [$S$],

  [* $Φ_B$ *], [Magnetic flux], [Total magnetic field passing through a surface: $Φ_B = integral_S arrow(B) · hat(n) dif S$.], [$"Wb"$],

  [* $Q_("enc")$ *], [Enclosed charge], [Total charge inside a closed surface: $Q_("enc") = integral_V ρ dif V$.], [$C$],

  [* $I_("enc")$ *], [Enclosed current], [Total current passing through a surface: $I_("enc") = integral_S arrow(J) · hat(n) dif S$.], [$A$],

  [* $t$ *], [Time], [Temporal variable used in dynamic field analysis.], [$s$],

  [* $hat(n)$ *], [Unit normal vector], [Direction perpendicular to a surface element; $dif arrow(S) = hat(n) dif S$.], [—],

  [* $C=partial Omega$ *], [Closed contour], [Path for line integration; used in $integral.cont_C  dot dif l$.], [$m$],

  [* S *], [Surface], [Area domain for surface integrals; used in $integral_S  dot dif S$.], [$m^2$],

  [* $dif S$ *], [Surface element], [Infinitesimal area element; vector form $dif arrow(S) = hat(n) dif S$.], [$m^2$],

  [* $dif l$ *], [Line element], [Infinitesimal length element along contour $C$.], [$m$],

  [* $integral$ *], [Integral operator], [Continuous sum over space; examples: $integral_S  dot dif S$, $integral_V  dot dif V$.], [—],

  [* $integral.cont$ *], [Contour integral], [Closed path integration operator; example: $integral.cont_C  dot dif l$.], [—],
)





== Useful formulas
=== Basic Formulas
- Integration properties
  - $ integral_a^b f(x) dif x = F(x)+C$
  - $ integral_a^b f(x) dif x = F(b)-F(a)$
  - $ integral_S arrow(F) dot dif arrow(S) = integral_S arrow(F) dot hat(n) dif S$
  - $ integral_S arrow(F) dot dif arrow(S) = Phi_F$
  - $ integral.cont_(partial Omega) arrow(F) dot dif arrow(l) = integral.cont_(partial Omega) arrow(F) dot hat(l) dif l$
  - $ integral.cont_(partial Omega) arrow(F) dot dif arrow(l) = V_F$
- Differential properties
  - $ nabla dot (phi arrow(A)) = phi (nabla dot arrow(A)) + arrow(A) dot (nabla phi)$
  - $ nabla times (phi arrow(A)) = phi (nabla times arrow(A)) + (nabla phi) times arrow(A)$
  - $ nabla dot (arrow(A) times arrow(B)) = arrow(B) dot (nabla times arrow(A)) - arrow(A) dot (nabla times arrow(B)) -->^(arrow(A) perp arrow(B)) nabla dot (arrow(A) times arrow(B)) = 0$
  - $ nabla times (arrow(A) dot hat(n)) = (nabla times arrow(A)) dot hat(n) + arrow(A) dot (nabla times hat(n))$
  - $ nabla times (arrow(A) times arrow(B)) = arrow(A)(nabla dot arrow(B)) - arrow(B)(nabla dot arrow(A)) + (arrow(B) dot nabla)arrow(A) - (arrow(A) dot nabla)arrow(B)$
  - $ integral_S nabla dot arrow(F) dif V = integral.cont_(partial S) arrow(F) dot dif arrow(S) " (Divergent)"$
  - $ integral_S nabla times arrow(F) dif S = integral.cont_(partial S) arrow(F) dot dif arrow(l) " (Curl/Rotational)"$
- Equation properties
  - $ a x + b = 0 -> x=b/a$
  - $ a x + b y = 0 -> y = - (a/b) x$
  - $ a x^2 + b x + c = 0 -> x = (-b +- sqrt(b^2 - 4 a c))/(2 a)$
  - $ a (dif x)/(dif t) + b x = c -> x(t) = (c/b) + (x(0) - c/b) e^(- (b/a) t)$
  - $ (dif x)/(dif t) = a x -> x(t) = x(0) e^(a t)$
- Surface area definitions
  - Plane surface: $S = "width" times "height"$
  - Disk surface: $S = integral_0^r integral_0^(2 pi) r dif theta dif r = 2 pi r^2$
  - *Spherical surface*: $S = integral_0^pi integral_0^(2 pi) r^2 sin(theta) dif phi dif theta = 4 pi r^2$
  - *Cylindrical surface*: $S = integral_0^h integral_0^(2 pi) r dif phi dif z = 2 pi r h$
- Volume definitions
  - Box volume: $V = "width" times "height" times "length"$
  - *Sphere volume*: $V = integral_0^R integral_0^pi integral_0^(2 pi) r^2 sin(theta) dif phi dif theta dif r = (4/3) pi R^3$
  - *Cylinder volume*: $V = integral_0^h integral_0^R integral_0^(2 pi) r dif phi dif r dif z = pi R^2 h$

=== Maxwell's equations (integral form)
- Gauss's law (integral form): $ integral_S arrow(D) dot dif arrow(S) = Q_"enc"$
- Ampere's law (integral form): $ integral_C arrow(H) dot dif arrow(l) = I_"enc" + (d)/(d t) integral_S arrow(D) dot dif arrow(S)$
- Faraday's law (integral form): $ integral_C arrow(E) dot dif arrow(l) = - (d)/(d t) integral_S arrow(B) dot dif arrow(S)$
- Magnetic flux continuity (integral form): $ integral_S arrow(B) dot dif arrow(S) = 0$
- Current continuity (integral form): $ integral_S arrow(J) dot dif arrow(S) + (d)/(d t) integral_S rho_v dif S = 0$
- Lorentz force (on a charge q): $ arrow(F) = q (arrow(E) + arrow(v) times arrow(B))$
- Power density (Joule heating): $ P_v = arrow(J) dot arrow(E) = sigma |arrow(E)|^2$
- Energy density (electromagnetic): $ W_v = (1/2)(arrow(E) dot arrow(D) + arrow(B) dot arrow(H)) = (1/2)(epsilon |arrow(E)|^2 + (1/mu) |arrow(B)|^2)$
- Poynting vector (power flow density): $ arrow(S) = arrow(E) times arrow(H)$
- Poynting theorem (energy conservation): $ integral_S arrow(S) dot dif arrow(S) + integral_V P_v dif V + (d)/(d t) integral_V W_v dif V = 0$

== Other Connections
#align(center, figure(
  image("part1_diagrams/Sadiku matthew electronics/Sadiku Matthew Elements of Electromagnetics 2014_flow diagram of formulas.png", width: 80%),
  caption: [Flow diagram of formulas to solve electrostatic and magnetostatic problems. @sadiku2014elements]
))

#align(center, figure(
  image("part1_diagrams/Sadiku matthew electronics/Sadiku Matthew Elements of Electromagnetics 2014_analogy between electric and magnetic.png", width: 50%),
  caption: [Links between electric and magnetic formulas @sadiku2014elements]
))

#align(center, figure(
  image("part1_diagrams/Sadiku matthew electronics/Sadiku Matthew Elements of Electromagnetics 2014_common inductance formulas.png", width: 80%),
  caption: [Common inductance formulas @sadiku2014elements]
))

#bibliography("references_part1.bib", full:true, style: "ieee")
