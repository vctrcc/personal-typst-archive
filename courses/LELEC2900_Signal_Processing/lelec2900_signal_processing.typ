#import "../templates/template_syth_gen2.typ": *
#show: conf.with(
  course: "LELEC2900: Signal Processing",
  authors: (
    (
      name: "Victor Carballes",
      affiliation: "UCLouvain Masters LELEC",
      email: "victor.carballes@student.uclouvain.be"
    ),
  ),
  abstract: [This course covers the transition from discrete-time to continuous-time systems, including sampling theory, multirate systems, DFT, and filter design. The second part addresses nonlinear systems and Bayesian filtering. \ #box(move(dy: 0.4em, [ Source code here : #text(fill: color.aqua.darken(20%))[#link("https://github.com/vctrcc/personal-typst-archive")]]))],
  background_images: (),
)

#info_bx(title: "Course Format", [
The course is separated into 2 parts:
- Discrete-time systems to continuous-time systems and filters
- Nonlinear systems and filters
The first part is *recorded and uploaded on the course website*, whilst the second part is mostly theoretical with mathematical developments.
])




= Part 1 : Discrete and Continuous Time Systems (Prof. Luc Vanderdorp)
== Sampling
Sampling is the act of transforming a continuous-time signal into a discrete-time signal by taking measurements at regular intervals.

Sampled signals are *more flexible*, more *adaptable*, *accurate*, and *reproducible*. They are also easy to compress, error correct and protect the information.

Though, they *_have limitations_*, such as the *speed* and *accuracy* of the *ADC* (Analog-to-Digital Converter), and the non-linear *quantization* effects. (Other limitations will be mentioned later)
=== Sampling Theory
==== Notations and Wording
We represent both signals as :
#grid(
  columns: 2,
  inset: 4pt,
  [- Continuous-time signal $->$], $x(t)$,
  [- Discrete-time signal $->$], $x[n]$,
)
Where both are connected through the sampling period $T_s$.
$ x[n] = x(n T_s) forall n in ZZ $
#note_bx([
  Note that *Digital Signals* are actually *discrete-time signals* that are *Quantized*.
])
#block()

Sampling parameters are defined as:
- *Sampling Period*: $T_s = 1/f_s$ [seconds]
- *Sampling Frequency*: $f_s = 1/T_s$ [Hz]
- *Sampling Angular Frequency*: $omega_s = 2 pi f_s = (2 pi)/T_s$ [rad/s]

#warning_bx(title: "Critical Distinction", [
*Discrete-time frequency* vs *Continuous-time frequency*:
#grid(
  columns: 2,
  inset: 4pt,
  [- *Discrete-time* $"    "->$ Dimensionless (no time units)], [$Omega = 2 pi F$ \[rad\]],
  [- *Continuous-time* $->$ Has time units], [$omega = 2 pi f$ \[rad/s\]],
)
*Relationship*: $ Omega = omega T_s = omega / f_s = (2 pi f) / f_s $
where $F = f / f_s$ is the *normalized frequency*.
])

#definition_bx(name: "Fourier Transform (FT)", [
  Direct Fourier Transform of a continuous-time signal $x(t)$ is defined as:
  $ X(j omega) = integral_(-infinity)^infinity x(t) e^(-j omega t) dif t $
  Inverse Fourier Transform is:
  $ x(t) = 1/(2 pi) integral_(-infinity)^infinity X(j omega) e^(j omega t) d omega $
])

==== Ideal Sampling Model
Ideal sampling is modeled as multiplication by a *Dirac comb* (impulse train):
$ p(t) = sum_(n=-infinity)^infinity delta(t - n T_s) quad arrow.r.double quad P(j omega) = (2 pi)/T_s sum_(k=-infinity)^infinity delta(omega - k omega_s) $

The sampled signal $x_e (t) = x_a (t) dot p(t)$ gives $x[n] = x_a (n T_s)$.

#definition_bx(name: "Continuous Time Sampled Signal", [
  #v(-10pt)
  $ x_e (t) = sum_(n=-infinity)^infinity x[n] underbrace(delta(t - n T_s), "Dirac Delta") = sum_(n=-infinity)^infinity x(n T_s) delta(t - n T_s) $
  With its fourier transform:
  $ X_e (j omega) = integral_(-infinity)^infinity x_e (t) e^(-j omega t) d t = sum_(n=-infinity)^infinity x[n] e^(-j omega n T_s) = sum_(n=-infinity)^infinity x[n] e^(-j n Omega) $
])

==== Spectral Link: Discrete vs Continuous Domain

#definition_bx(name: "Discrete-Time Fourier Transform (DTFT)", [
  The *DTFT* of the discrete signal $x[n]$ is:
  $ underbrace(X(e^(j Omega)), "continuous\ntime") = sum_(n=-infinity)^infinity underbrace(x[n], "discrete\ntime") e^(-j Omega n) $
  $ x[n] = 1/(2 pi) integral_(-pi)^pi X(e^(j Omega)) e^(j Omega n) d Omega $

  - This function is *periodic* with period $2 pi$ in $Omega$
  - The *fundamental period* is $-pi <= Omega <= pi$ (or equivalently $0 <= Omega <= 2pi$)

  Equivalently, in terms of continuous-time angular frequency $omega$:
  $ X(j omega) = sum_(n=-infinity)^infinity x[n] e^(-j omega n T_s) = X(e^(j omega T_s)) $

  We can link :
  $ Omega = omega T_s = omega/f_s = 2pi f/f_s eq.def 2 pi F $
  With $F = f/f_s$ the *normalized frequency*.
])
#definition_bx(name: "Discrete Fourier Transform (DFT)", [
  The *DFT* of a finite-length sequence $x[n]$ of length $N$ is:
  $ X[k] = sum_(n=0)^(N-1) x[n] e^(-2 pi j k n/N) $
  $ x[n] = 1/N sum_(k=0)^(N-1) X[k] e^(2 pi j k n/N) $
  for $k = 0, dots, N-1$. This is a *sampled version* of the DTFT at frequencies $Omega_k = (2 pi k)/N$.
])

#note_bx([
  *DTFT vs DFT*: The DTFT is a *continuous function* of frequency for infinite-length signals. The DFT (covered later) is a *sampled version* of the DTFT for finite-length signals.
])

==== Convolution and Modulation Properties
#theorem_bx(name: "Convolution Theorems", [
Convolution in time $<->$ Multiplication in frequency
$ y(t) = x(t) * h(t) quad arrow.l.r.double quad Y(j omega) = X(j omega) dot H(j omega) $
where $ x(t) * h(t) = integral_(-infinity)^infinity x(tau) h(t-tau) d tau $

Multiplication in time $<->$ Convolution in frequency
$ y(t) = x(t) dot h(t) quad arrow.l.r.double quad Y(j omega) = 1/(2pi) X(j omega) * H(j omega) $
])

#theorem_bx(name: "Modulation Theorem", [
  Modulating a signal $x(t)$ by $e^(j omega_0 t)$ shifts its spectrum:
  $ y(t) = x(t) e^(j omega_0 t) quad arrow.l.r.double quad Y(j omega) = X(j (omega - omega_0)) $
  Modulating by $cos(omega_0 t)$ creates two spectral copies at $plus.minus omega_0$. This can extend to cosines and sines via Euler's formulas:
  $ cos(omega_0 t) = (e^(j omega_0 t) + e^(-j omega_0 t))/2 quad quad sin(omega_0 t) = (e^(j omega_0 t) - e^(-j omega_0 t))/(2j) $
  Modulation by $cos(omega_0 t)$ creates two symetrical spectral copies at $plus.minus omega_0$.
])

==== Sampling Theorem (Nyquist-Shannon)
The sampling theorem consists on sampling a continuous-time analytic signal $x_a (t)$ with a certain sampling period $T_s$ to obtain a sampled signal $x_e (t)$. This can be represented from a modulation of the singal by a Dirac comb we will call $p(t) = sum_(n=-infinity)^(infinity) delta(t - n T_s)$. As so,we can define the sampled signal :
$ x_e (t) = x_a (t) p(t) = sum_(n=-infinity)^(infinity) x_a (n T_s) delta(t - n T_s) = sum_(n=-infinity)^(infinity) x[n] delta(t - n T_s) $
Which can be expanded as a Fourier series with coefficients $c_n$ :
$ p(t) = underbrace(sum_(n=-infinity)^(infinity) c_n e^(2 pi j n t/T_s), "Fourier Series") = sum_(n=-infinity)^(infinity) 1/T_s e^(2 pi j n t/T_s) --> c_n = 1/T_s integral_T_s underbrace(p(t), delta(t)) e^(-2 pi j n t/T_s) = 1/T_s $
We can now express it all as a convolution in the frequency domain, by using the modulation property of the Fourier transform :
$ X_e (j omega) &= 1/(2 pi) X_a (j omega) times.o P(j omega) = 1/T_s sum_(k=-infinity)^(infinity) X_a (j(omega - k omega_s))\
  X_e (e^(j Omega)) &= 1/T_s sum_(k=-infinity)^(infinity) X_a (j(omega - 2 pi k\/T_s)) $
From here, we can see that the spectrum of the sampled signal $X_e (j omega)$ is a *scaled, periodic repetition* of the original spectrum $X_a (j omega)$ at intervals of $omega_s$.

This means, that if the original signal is *bandlimited* (i.e., $X_a (j omega) = 0$ for $|omega| > omega_"max"$), we can avoid overlap of the spectral replicas if the sampling frequency is high enough. This leads us to the Nyquist-Shannon Sampling Theorem.

#theorem_bx(name: "Nyquist-Shannon Sampling Theorem", [
  A bandlimited signal $x(t)$ with maximum frequency $f_"max"$ (i.e., $X(j omega) = 0$ for $|omega| > 2 pi f_"max"$) can be *perfectly reconstructed* from its samples if:
  $ f_s > 2 f_"max" quad "or equivalently" quad omega_s > 2 omega_"max" $
  The minimum sampling rate $f_"Nyquist" = 2 f_"max"$ is called the *Nyquist rate*.
])

We can see through the Nyquist-Shannon Sampling Theorem, and the property of the DFT, that the spectra will *repeat at multiples of the sampling frequency*. By that i mean, that it will repeat every $2 pi$. Meaning, if we don't wan't interference, we have to have only $-pi -> pi$ filled with the spectrum of the signal. This is the reason why we need to have $f_s > 2 f_"max"$, otherwise, the spectrum will repeat and overlap with itself, creating *aliasing*.
#figure(
  image("Images/sampling_spectrum.svg", width: 50%),
  caption: [Spectral replicas created by sampling ($f_"max" < f_s/2$)]
)

#warning_bx(title: "Aliasing", [
  If $f_s < 2 f_"max"$, spectral replicas *overlap* $->$ high frequencies appear as low frequencies (*aliasing*).

  *Example*: At sampling rate $f_s$, sinusoids at $f_s/8$ and $7f_s/8$ produce *identical samples* (indistinguishable). Real-world: stroboscopic effects (wheels appearing to spin backwards).
])
#figure(
  image("Images/aliasing_spectrum.svg", width: 50%),
  caption: [Aliasing when $f_"max" = f_s$]
)

#note_bx([
  *Nyquist frequency* ($f_s/2$): max frequency representable without aliasing.
  *Nyquist rate* ($2 f_"max"$): min sampling rate for a signal with bandwidth $f_"max"$.
])


=== Signal Recovery (Reconstruction)
==== Ideal Reconstruction for Low-Pass Signals
Since sampling creates spectral replicas at multiples of $omega_s$, we can recover the original signal by:
1. Applying an *ideal low-pass filter* with cutoff $omega_c = omega_s / 2 = pi / T_s$
2. Scaling by $T_s$ to compensate for the $1/T_s$ factor

#definition_bx(name: "Ideal Reconstruction Filter (under low-pass assumption)", [
  The ideal low-pass filter has frequency response:
  $ H_"LP" (j omega) = cases(T_s "if" |omega| < omega_s/2, 0 "otherwise") $

  In the time domain, this corresponds to the *sinc interpolation*:
  $ h_"LP" (t) = "sinc"(t / T_s) = (sin(pi t / T_s))/(pi t / T_s) $
])

#theorem_bx(name: "Reconstruction Formula (Whittaker-Shannon)", [
  $ hat(x)_a(t) = sum_(n=-infinity)^infinity x[n] "sinc"((t - n T_s)/T_s) $
  This reconstruction consists of a sort of interpolation. Where, the sinc function only affect the sample itself and the intermediary points. All other samples are not affected, as the sinc function is zero at their positions. This is the reason why it is called interpolation, as it only affects the points between the samples, and not the samples themselves.

  #figure(
    image("Images/whittaker_shannon.jpg", width: 50%),
    caption: [Sinc interpolation of samples of a sinusoid]
  )

  Wikipedia Reference : #link("https://en.wikipedia.org/wiki/Whittaker%E2%80%93Shannon_interpolation_formula")[Whittaker-Shannon interpolation formula]
])

In the case of *no aliasing*, we have that $hat(x)_a (t) = x_a (t)$.

But, if the signal was passband, we would need to use a *bandpass* reconstruction filter instead of a low-pass one, which would be more complex to implement.

==== Understanding Reconstruction
- *Frequency view*: Low-pass filter selects only the baseband copy, gain $T_s$ restores amplitude.

- *Time view*: Each sample $x[n]$ becomes a sinc centered at $t = n T_s$. Since $"sinc"(0) = 1$ and $"sinc"(k) = 0$ for integer $k != 0$, the sinc functions interpolate exactly through the samples.

==== Practical Reconstruction Methods
- *Zero-Order Hold (ZOH)*: Hold sample constant $->$ staircase output. Most DACs use this.

- *First-Order Hold (FOH)*: Linear interpolation between samples $->$ sminfinityther but still distorted.

In practice, a *post-filter* (analog low-pass) follows the DAC to sminfinityth the output.

#warning_bx(title: "Why Ideal Reconstruction is Impossible", [
  The ideal sinc interpolation cannot be implemented in practice because:
  1. *Non-causal*: $"sinc"(t)$ extends to $t -> -infinity$ (need future samples)
  2. *Infinite duration*: Requires infinitely many samples
  3. *Slow decay*: $"sinc"(t) approx 1/(pi t)$ decays slowly, causing truncation errors
])

==== Anti-Aliasing and Reconstruction Filters

*Anti-aliasing filter*: Low-pass before ADC (removes frequencies above $f_s/2$).
*Reconstruction filter*: Low-pass after DAC (removes spectral images).

#warning_bx([
  *Aliasing cannot be fixed after sampling!* Once high frequencies fold into low frequencies, they are indistinguishable. Always use anti-aliasing filters.
])

The two filters are *duals*: anti-aliasing removes high frequencies *before* sampling; reconstruction removes spectral images *after* D/A conversion.

=== Spectral Link: Discrete vs Continuous Domain

#theorem_bx(name: "Spectral Link Formula", [
  The discrete-time spectrum $X(e^(j Omega))$ relates to the continuous-time spectrum $X_a (j omega)$ by:
  $ X(e^(j Omega)) = 1/T_s sum_(k=-infinity)^infinity X_a (j(omega - (2 pi k)/T_s)) quad "where" Omega = omega T_s $
  This confirms: discrete spectrum = scaled, periodic repetition of continuous spectrum.
])

#extra_bx(title: "Derivation of Spectral Link", [
  Starting from $x[n] = x_a (n T_s)$ and comparing the inverse transforms:
  - Break the continuous integral into segments of width $2 pi / T_s$
  - Variable change $omega' = omega - 2 pi k / T_s$, then $Omega = omega' T_s$
  - Matching coefficients gives the spectral link formula

  *Intuition*: The continuous axis $omega in (-infinity, infinity)$ folds into $Omega in [0, 2pi)$. If segments overlap at the same $Omega$, aliasing occurs.
])

== Sampling Rate Conversion
=== Continuous-Time Analog Solution
We are trying to convert a analog digital sampled signal $x[n]$ with sampling frequency $f_s$ of period $T$ to a continuous-time signal $x_a (t)$, and then resample it at a different sampling frequency $f_"s2"$ of period $T'$ to obtain a new discrete-time signal $y[m]$.

This can be achieved by using a ideal DAC $->$ LP filter $->$ ADC chain, or somehting similar to it. The ideal DAC will perform a *sinc interpolation of the samples*, and then the ideal ADC will perform a sampling of the continuous-time signal at the new sampling frequency.
#todo_block(exp: "Draw the block diagram of the chain")

We require the LP filter to remove part of the spectrum of the original signal, to avoid aliasing when we resample it at the new sampling frequency. This is because, if we don't remove the high frequencies, they will fold into low frequencies and create aliasing.

Our final formula will be :
$ y[m] = sum_(n=-N_1)^N_2 hat(h)(m T' - n T) x[n] $

With $hat(h)(t) = "sinc"(t/T) dot "sinc"(t/T') $ for the ideal case.

Where, we define the *L-fold upsampling* as the process of increasing the sampling rate by an integer factor $L$ (i.e., $f_"s2" = L f_s$), and *M-fold downsampling* as the process of decreasing the sampling rate by an integer factor $M$ (i.e., $f_"s2" = f_s / M$). Where, we often have this rational relationship :
$ T'/T = M/L $
This makes the system *linear* but no longer *time-invariant* (since the sampling instants change). The system is also *non-causal* since it depends on future samples.

BUT its easilly solvable in the discreete domain, by using the properties of the Fourier transform and the convolution.
=== Downsampling and Upsampling
#figure(
  image("Images/interpolation_decimation_visualization.png", width: 100%),
  caption: [Downsampling and Upsampling block diagrams]
)
==== Downsampling (Decimation)
When we downsample by a factor of $M$, we keep only every $M$-th sample and discard the rest. This comes commes back to moving the sampling frequency from $(2 pi)/T$ to $(2 pi)/(M T)$. This means that the spectrum will be compressed by a factor of $M$, and the spectral replicas will be closer together. To avoid aliasing, we need to apply a low-pass filter with cutoff frequency $pi/M$ before downsampling. This is called *decimation*.

Let us analyze the different spectrums:
#lemma_bx(name: "Spectral Changes in Downsampling", [
  Continuous time sampled signal $w_e(t)$ :
  $
  w_e (t) &= sum_(n=-infinity)^(infinity) underbrace(w_a (n T) delta(t - n T), "Sampled signal") quad --> quad W_e (j omega )= 1/T sum_(k=-infinity)^(infinity) W_a (j(omega - 2 pi k/T)) quad "where" Omega = omega T \
  &#box(width: 0.8em, $stretch(arrow.b, size: #300%)$) #block([#v(-1em) M-fold Decimation])\
  y_e [n] &= w_c (n M T) quad --> quad Y_e (e^(j Omega)) = 1/(M T) sum_(k=-infinity)^(infinity) W_a (j(omega - 2 pi k/(M T))) quad "where" Omega = omega M T \
$
From the sampling theorem, we can describe this spectrum change :
$ 2/T <= 1/T_s -> 2/T <= 1/(M T_s) ==> f_"dec,max" = f_"orig,max"/M $
We can see here, that we HAVE to add a LP filter at the start of the chain, so that the spectrum of the original signal is limited to $f_"dec,max"$, otherwise, we will have aliasing.\
#block()
We see *2 effects* :
- M times faster repetition
- M times stretching or expansion of the spectrum elements
(the spectrum becomes wider by a factor of M, and the spectral replicas become closer together by a factor of M)

])

#figure(
  image("Images/downsampling_effect.svg", width: 100%),
  caption: [Spectrum effect of downsampling by a factor of M=3 without low-pass filtering at $[0, pi/M]$, showing a little bit of overlap/aliasing]
)#block()

We can also see that the spectrum of the downsampled signal is a *scaled, compressed, and periodic repetition* of the original spectrum, with period $2 pi/(M T)$ and scaling factor $1/M$.

#note_bx([
  The name *Decimation* comes from the unification of the LP filtering and downsampling operations. It is a common term in multirate signal processing, and it emphasizes the importance of the anti-aliasing filter in the downsampling process.
])

#definition_bx(name: "Decimation Chain", [
  #figure(
    image("Images/downsampling_chain.svg", width: 50%),
    caption: [Decimation chain block diagram]
  )

  *Downsampling of a signal $w[n]$*:
  $ y[m] = w[m M] $
  *Non Rigorous Chain*:
  $ y[m] = underbrace((x[n] times.o h [n] ), "Low Pass Filter") [n M] $
  *Rigorous Chain*:
  $
    y[m] &= w[m M]\
    &= 1/(2 pi) integral_(0)^(2 pi) Y(e^(j Omega)) e^(j m Omega ) dif Omega\ &= 1/(2 pi) integral_(0)^(2 pi) text(fill: #color.purple, W)(e^(j Omega)) e^(j m text(fill: #color.purple, M) Omega ) dif Omega \
    &#box(width: 0.8em, $stretch(arrow.b, size: #300%)$) #block([#v(-1.5em) Periodic Sampling])\
    &= 1/(2 pi) text(fill: #color.purple, sum_(k=0)^(M-1)) integral_text(fill: #color.purple, (2 pi k)/M)^text(fill: #color.purple, (2 pi (k+1))/M) W(e^(j Omega)) e^(j m M Omega) dif Omega \
    &#box(width: 0.8em, $stretch(arrow.b, size: #300%)$) #block([#v(-1.5em) $Omega''=Omega-(2 pi k)/M$])\
    &= 1/(2 pi) sum_(k=0)^(M-1) integral_((2 pi k)/M)^((2 pi (k+1))/M) W(e^(j (Omega''+text(fill: #color.purple, (2pi k)/M)))) e^(j m M (Omega''+text(fill: #color.purple, (2pi k)/M))) dif Omega'' \
    &#box(width: 0.8em, $stretch(arrow.b, size: #300%)$) #block([#v(-1.5em) $Omega'=M Omega''$])\
    &= 1/(2 pi text(fill: #color.purple, M)) sum_(k=0)^(M-1) integral_text(fill: #color.purple, 0)^text(fill: #color.purple, 2 pi) W(e^(j text(fill: #color.purple, (Omega'+ 2pi k)/M))) e^(j m M text(fill: #color.purple, Omega')) dif Omega' \
  $
  Therefore, the spectrum of the downsampled signal is:
  $ Y(e^(j Omega)) = 1/M sum_(k=0)^(M-1) W(e^(j (Omega + (2 pi k)/M))) $
  This shows us that the frequency axis is compressed by a factor of $M$, and the spectrum is repeated $M$ times within the interval $[0, 2 pi[$. To avoid the aliasing problem, we have to filter it with a low-pass filter that only keeps the first copy of the spectrum situated on $[-pi/M, pi/M]$ so that the other copies do not overlap with it when repeated. This operation must be donne before downsampling, otherwise, we will still have aliasing.

  #todo_block(exp: "Add a figure of the filtered signal, and then its downsampled version, showing the compression of the spectrum and the repetition of it, and how the low pass filter only keeps the first copy of the spectrum, and then how it is repeated after downsampling ")
  //#figure(
  //  image("Images/downsampling_effect_fits.jpg", width: 40%),
  //  caption: [Representation of the spectrum if it fits ]
  //)

  *Filtering*:\
  We define the filtering function as :
  $ H(e^(j Omega)) = cases(1 &|Omega| <= pi/M, 0 &"otherwise") $
  Where :
  $ w_f [n] = h[n] times.o w[n] $
  $ Y_f (e^(j Omega)) = 1/M sum_(k=0)^(M-1) W_f (e^(j (Omega-2 pi k)/M)) = 1/M W_f (e^(j Omega/M)) $
])

==== Upsampling (Interpolation)
When we upsample by a factor of $L$, we insert $L-1$ zeros between each sample. This effectively increases the sampling frequency from $(2 pi)/T$ to $(2 pi)/(T/L) = L (2 pi)/T$. The spectrum will be stretched by a factor of $L$, and the spectral replicas will be farther apart. To obtain a sminfinityth signal, we need to apply a low-pass filter with cutoff frequency $pi/L$ after upsampling. This is called *interpolation*.

#lemma_bx(name: "Spectral Changes in Upsampling", [
  Continuous-time sampled signal with period $T$ :
  $
    w_(e,T)(t) &= sum_(n=-infinity)^(infinity) underbrace(x_a (n T) delta(t - n T), "Sampled signal") " "-->  &W_(e,T)(j omega) &= 1/T sum_(k=-infinity)^(infinity) X_a ( j(omega - 2 pi k/T)\
    &#box(width: 0.8em, $stretch(arrow.b, size: #300%)$) #block([#v(-1.5em) L-fold Upsampling : $T' = T/L$])&&\
    w_(e,T')(t) &= sum_(n=-infinity)^(infinity) x_a (n T') delta(t - n T') --> &W_(e,T')(j omega) &= 1/T' sum_(k=-infinity)^(infinity) X_a (j(omega - 2 pi k/T')) \
    &&&= text(fill: #color.purple, L)/T sum_(k=-infinity)^(infinity) X_a (j(omega - 2 pi text(fill: #color.purple, L) k/T))
  $

  From the sampling theorem, increasing the sampling rate from $1/T$ to
  $
    1/T' = L/T
  $
  means that the spectral repetitions in $Y_(e,T')(j omega)$ are *L times less frequent*
  than in $W_(e,T)(j omega)$.

  Equivalently, the spacing between spectral replicas increases from
  $ (2 pi) / T ->  (2 pi) / T' = text(fill: #color.purple, L) (2 pi) / T $

  In discrete time, this corresponds to *inserting $L-1$ zeros between* successive samples.
  This operation creates *extra spectral images*, so we HAVE to add a LP interpolation filter
  after the upsampler in order to eliminate the unwanted repeated spectra and keep only the
  desired baseband copy.\
  #block()

  We see *2 effects* :
  - the sampling rate is increased by a factor of $L$
  - the spectral replicas become $L$ times farther apart
  (equivalently: the repetitions are $L$ times less frequent, and the extra images must be removed by interpolation filtering)

])

#note_bx([
  The factor L in the upsampling spectral formula, represents the *multiplication of the quantity of energy by L* , that comes from the operation. Due to that, we have to filter it to make it energy conserving, and ALSO make the signal actually connected.
])

#figure(
  image("Images/upsampling_effect.svg", width: 100%),
  caption: [Spectrum effect of upsampling by a factor of L=3 without low-pass filtering at $[0, pi/L]$, showing the stretching of the spectrum and the repetition of it, and how the low pass filter only keeps the first copy of the spectrum, and then how it is repeated after upsampling\ (approximative sizes due to figure limitations)]
)#block()



#todo_block(exp: "Figure that shows the zero insertion, and what it linfinityks like")



// Also, since we are filtering with a low pass filter. Its like convoluting with a sinc function. Which in turn is a sort of rectangle construction int he frequency domain. This means, that the sinc is ZERO on the other samples. But interpolates in between samples.
We can see this low pass filter as a sort of *sinc interpolation* of the upsampled signal, which is a sequence of impulses at the original sample positions, and zeros everywhere else. The sinc function will interpolate between the original samples, and will be zero at the positions of the inserted zeros, which is why it is called interpolation.

#todo_block(exp: "Add a figure explaining the parallel between the rectangles and the sinc function on the samples and the in between samples, from slide 28 or something like that")



#definition_bx(name: "Interpolation Chain", [
  #figure(
    image("Images/upsampling_chain.svg", width: 50%),
    caption: [Interpolation chain block diagram]
  )
  *Upsampling of a signal $w[n]$*:
  $ w[m] = cases(
    x[m/L] &"if" m mod L = 0,
    0 &"otherwise"
  ) $
  #block([(Also known as *zero insertion*, since we insert zeros between the original samples)])
  *Non Rigorous Chain*:
  $ y[m] = h[m] times.o underbrace(w[m], "zero\ninserted")  $
  *Rigorous Chain*:

  We can describe a *contraction* of the frequency axis, due to distance between samples
  $ W(e^(j Omega)) &= sum_(m=-infinity)^(infinity) w[m]e^(-j m Omega)\
    &#box(width: 0.8em, $stretch(arrow.b, size: #300%)$) #block([#v(-1.5em) $m=L n$])\
    &= sum_(n=-infinity)^(infinity) x[n] e^(-j n text(fill: #color.purple,L) Omega) quad "where" Omega = omega T/L \
    &= X(e^(j text(fill: #color.purple,L) Omega))
  $

  *Filtering*:
  We define the filtering function as :
  $ H(e^(j Omega)) = cases(1 &quad|Omega| <= pi/L, 0 &quad"otherwise") $
  Where :
  $ y [n] = h[n] times.o w[n] --> Y(e^(j Omega)) = H(e^(j Omega)) X(e^(j text(fill: #color.purple,L) Omega)) $

  ])

#info_bx(title: "Faster interpolation using Padding", [
  To perform interpolation more efficiently, we can use the FFT:
  1. Compute the N-point DFT of the original signal
  2. *Pad the DFT* with zeros to length L*N (inserting zeros in the frequency domain)
  3. Compute the inverse DFT to obtain the interpolated signal

  This method is computationally efficient and avoids explicit convolution with a sinc filter.
])


==== Fractional/Rational Sampling Rate Conversion (RSRC)

#figure(
  image("Images/rational_sampling.svg", width: 70%),
  caption: [Rational resampling chain block diagram]
)
#block()

For rational sampling-rate conversion, we first upsample by a factor of $L$
(insert $L-1$ zeros between samples), then apply a low-pass filter, and finally
downsample by a factor of $M$ (keep one sample out of every $M$).
The output sampling rate is therefore

$
  f_"s2" = L/M f_s
  quad "and" quad
  T_"s2"/T_s = M/L
$

Direct-domain formulation:
$
  y[n] = arrow.b#h(-0.01em)M ( h[n] * u[n] )
  quad "with" quad
  u[n] = arrow.t#h(-0.01em)L x[n]
$

The low-pass filter is required for *both* operations:
- it removes the spectral images created by upsampling,
- it prevents aliasing before downsampling.

For lowpass signals, an ideal global filter can be written as
$
  H(e^(j Omega)) = cases(
    1 &quad |Omega| <= pi / max(L, M),
    0 &quad "otherwise"
  )
$
where $Omega$ is normalized with respect to the intermediate sampling rate $L f_s$.

#note_bx([
  This direct implementation is conceptually simple, but *not computationally efficient*,  because many intermediate samples created by upsampling are either zero or discarded after downsampling. A more efficient implementation will be introduced in the next section.
])

#example_bx(name: "Examples of Rational Resampling", [
  #table(
    columns: (2.1fr, 2.1fr, 1.4fr, 1.4fr, 0.6fr, 0.6fr),
    align: (left, left, center, center, center, center),
    inset: 8pt,
    stroke: (x: none, y: 0.4pt + luma(180)),

    [*Source*], [*Target*], [*$f_s$*], [*$f_"s2"$*], [*$L$*], [*$M$*],

    [CD audio], [Professional audio], [$44.1 " kHz"$], [$48 " kHz"$], [$160$], [$147$],
    [Professional audio], [CD audio], [$48 " kHz"$], [$44.1 " kHz"$], [$147$], [$160$],
    [Digital TV audio], [CD audio], [$32 " kHz"$], [$44.1 " kHz"$], [$441$], [$320$],
    [CD audio], [High-resolution audio], [$44.1 " kHz"$], [$96 " kHz"$], [$320$], [$147$],
    [High-resolution audio], [CD audio], [$96 " kHz"$], [$44.1 " kHz"$], [$147$], [$320$],
    [Telephone speech], [CD audio], [$8 " kHz"$], [$44.1 " kHz"$], [$441$], [$80$],
  )
])

=== Bandpass Sampling (Without the Low-Pass Hypothesis)

When the signal is *bandlimited but not low-pass*, i.e. it occupies a frequency band
$[f_"low", f_"high"]$, it can still be sampled without aliasing.

A direct but non-efficient use of the sampling theorem gives
$
  f_s > 2(f_"low" + f_Delta),
$
where
$
  f_Delta = f_"high" - f_"low"
$
is the signal bandwidth.

This is called *bandpass sampling* or *undersampling*.

#figure(
  image("Images/bandpass_representation.svg", width: 60%),
  caption: [Representation of a real-valued bandpass signal and its spectral copies after sampling]
)
#block()

More efficiently, the useful band can be brought back to baseband before reducing the sampling rate.

#example_bx(name: "Two possible approaches", [
  1. *Bandpass decimation*: isolate the desired band, then downsample so that one spectral replica falls around DC.

  2. *Complex-envelope extraction*: shift the band to baseband by modulation, then low-pass filter and downsample.
])

#figure(
  image("Images/bandpass_representation_modulated.svg", width: 60%),
  caption: [Frequency translation of the useful band to baseband]
)


==== Solution 1 — Bandpass Decimation then Interpolated Recovery
#explanation_bx(name: "Bandpass Decimation Principle", [
  For *low-pass* signals, decimation requires a low-pass anti-aliasing filter.

  For *bandpass* signals, we do not preserve the whole spectrum. Instead, we first isolate the subband of interest, then downsample so that one of its replicas is folded back around DC.

  Before $M$-fold downsampling, the input must therefore be filtered by a bandpass filter:
  $
    H_"bp"(e^(j Omega)) = cases(
      1 &quad k pi / M <= |Omega| <= (k + 1) pi / M,
      0 &quad "otherwise"
    ) "with" k in {0, 1, ..., M - 1}
  $
  The selected band always has width
  $ Delta Omega = pi / M $
])

#info_bx(title: "What the decimator does", [
  After filtering, only one spectral slice is kept. The decimator then compresses the frequency axis so that this band appears around DC, giving a *low-rate baseband representation* of the original subband.
])

Let $x_"bp" [n]$ be the bandpass-filtered signal. After decimation by $M$,
$ y[m] = x_"bp" [m M] $

Its spectrum is
$ Y(e^(j Omega)) = 1/M sum_(l=0)^(M-1) H_"bp" (e^(j (Omega - 2 pi l)/M)) X(e^(j (Omega - 2 pi l)/M)) $

Hence, downsampling repeats the spectrum *M times faster*.\
If the correct subband has been isolated beforehand, one of these repeated versions falls around the DC component.

#todo_block(exp: "Add a figure showing the frequency domain evolution: (1) original bandpass signal spectrum, (2) after bandpass filtering isolating one subband, (3) after decimation showing the compressed frequency axis with the selected band folded around DC")

#warning_bx(title: "Possible mirroring", [
  Depending on the chosen subband index $k$, the folded spectrum around DC may be:
  - preserved in orientation, or
  - mirrored.

  When mirroring occurs, it *can be corrected by a shift* of $pi$ in the frequency domain, which corresponds in the time domain to multiplication by
  $ (-1)^n $
])

To reconstruct the selected band at a higher sampling rate, we apply the complementary operation:
*upsampling* followed by *bandpass filtering*.

First, insert $M-1$ zeros between samples:
$ w[n] = cases(y[n / M] &quad "if" n = m M, 0 &quad "otherwise") $

This operation creates spectral images.

Then, a bandpass interpolation filter selects the desired image:
$ G_"bp" (e^(j Omega)) = cases(M &quad k' pi / M <= |Omega| <= (k' + 1) pi / M, 0 &quad "otherwise") $

The gain factor $M$ restores the amplitude after zero insertion.

#figure(
  image("Images/ai_decimation_bandpass.png", width: 90%),
  caption: "Visualization of the bandpass decimation re-sampling principle (Ai Generated)"
)

#todo_block(exp: "Add a figure showing the frequency domain evolution during reconstruction: (1) after zero insertion showing spectral images, (2) after bandpass interpolation filtering selecting the desired image and placing it at the target frequency location")

#note_bx(title: "Recovery Procedure", [
  The interpolation stage is therefore:
  - upsample by zero insertion,
  - optionally correct mirroring by $(-1)^n$,
  - apply a bandpass filter to place the spectrum in the desired output band.
])

#definition_bx(name: "Transmultiplexing Operation", [
  *Transmultiplexing* is a signal processing technique that *extracts a band of interest* from one spectral location, processes it at a reduced rate around baseband (DC), and *reinjects it at a different frequency position*.

  The fundamental cascade of operations is:
  $
    "band selection" -> "decimation" -> "optional mirror correction" -> "interpolation"
  $

  This enables flexible spectral band relocation without reconstructing the full continuous-time signal, making it efficient for multi-channel frequency translation applications.
])

#todo_block(exp: "Add a complete block diagram chain showing the transmultiplexing operation: bandpass filter → decimator (with optional (-1)^n correction multiplier) → interpolator → bandpass filter, illustrating how a signal is extracted from one frequency band, processed at lower rate, and repositioned at a different frequency location")


==== Solution 2 - Complex Envelope Extraction
A *real-valued bandpass signal* centered around $Omega_0$ contains *two conjugate spectral copies*:
one around $+Omega_0$ and one around $-Omega_0$.

Instead of resampling this signal directly at its carrier frequency, we first *_translate_* the useful band to *baseband*.
The result is a *complex low-pass representation* of the band, called the *complex envelope*.

This is the key idea behind bandpass resampling: once the band has been shifted to DC, the admissible sampling rate depends only on the *bandwidth* $Omega_Delta$, and no longer on the carrier position $Omega_0$.

#definition_bx(name: "Complex Envelope Through Rice Components (I-Q Components)", [
  Assume that $x[n]$ is a real bandpass signal whose useful band has width $Omega_Delta$ and is centered around $Omega_0$.

  #todo_block(exp: "Figure of the bandpass signal at Omega_0, with width Omega_Delta (must be symetric), but add an arrow that says SHIFT to baseband, that says which is x, and which is e")

  A convenient choice is to keep the *positive-frequency* part and shift it to the left, toward DC.
  The corresponding complex envelope in baseband is defined as:
  $ e_"positive" [n] = 2 ((x[n] e^(-j Omega_0 n)) * h[n]) $

  where $h[n]$ is an ideal low-pass filter with frequency response
  $ H(e^(j Omega)) = cases(
    1 &quad |Omega| <= Omega_Delta / 2,
    0 &quad "otherwise"
  ) $

  Expanding the complex exponential gives
  $ e_"positive" [n] &= underbrace(2 (x[n] cos(Omega_0 n)) * h[n], "In-Phase") - j underbrace(2 (x[n] sin(Omega_0 n)) * h[n], "Quadrature")\
         &= x_I [n] #text(fill: color.green,weight: "bold",$-$) j x_Q [n] $

  Equivalently, for the left bandpass signal shifted to the right :
  $ e_"negative" [n] &= underbrace(2 (x[n] cos(Omega_0 n)) * h[n], "In-Phase") + j underbrace(2 (x[n] sin(Omega_0 n)) * h[n], "Quadrature")\
    &= x_I [n] #text(fill: color.red,weight: "bold",$+$) j x_Q [n] $

  The two real sequences $x_I [n]$ and $x_Q [n]$ are called the *in-phase* and *quadrature* components, or equivalently, the *Rice Components* or the *I-Q components* of the original signal.\
  With its spectrum as :
  $ E_"positive" (e^(j Omega)) = H(e^(j Omega)) X( e^(j(Omega#text(fill: color.green,weight: "bold",$+$)Omega_0)))\
    E_"negative" (e^(j Omega)) = H(e^(j Omega)) X( e^(j(Omega#text(fill: color.red,weight: "bold",$-$)Omega_0))) $
])

#figure(
  image("Images/rice_bandpass_signal_recovery.jpg", width: 50%),
  caption: [Complex envelope extraction block diagram]
)

#info_bx(title: "Equivalent Analytic-Signal View", [
  The same operation can be expressed through the *analytic signal*
  $ underbrace(z[n], "Analytic") = x[n] + j x_H [n] $
  where $x_H [n]$ is the *Hilbert transform* of $x[n]$.

  #block()

  Its spectrum contains only the positive frequencies and that the frequencies are multiplied by 2 (hypothesis):
  $ Z(e^(j Omega)) &= cases(
    2 X(e^(j Omega)) &quad 0 <= Omega <= pi,
    0 &quad -pi <= Omega < 0 )\
 &= E_"positive" [e^(j(Omega#text(fill: color.red,weight: "bold",$-$)Omega_0))] $

  Hence, the complex envelope is then simply obtained by frequency translation:
  $ e_"positive"[n] = z[n] e^(-j Omega_0 n) $

  After obtaining one of the 2 complex envelopes, it can be *downsampled* to a rate compatible with the bandwidth $Omega_0$ or the largest frequency of the original signal $Omega_0/2$.
])

#definition_bx(name: "Hilbert Transform", [
  The Hilbert Transform is a linear operator that extracts the "imaginary part" of a signal by performing a $-90°$ phase shift on all positive frequencies and a $+90°$ phase shift on all negative frequencies, effectively computing the analytic signal when combined with the original signal as the real part.

  $ underbrace(z[n], "Analytic") = x[n] + j underbrace(x_H [n], "Hilbert\nTransform") $

  Its spectrum is given by :
  $ X_H (e^(j Omega)) &= ([Z(e^(j Omega) - X(e^(j Omega)))])/j\
    &= cases(&X(e^(j Omega)) &quad 0 <= Omega <= pi, -&X(e^(j Omega))&quad -pi <= omega <= 0)\
    &= -j #text(fill:color.purple, $"sign"(Omega)$) X(e^(j Omega)) quad "for" |Omega| <= pi $

  This spectrum explains the name.
])

#note_bx(title: "Why Complex Envelope Extraction is Useful", [
  After extraction, the signal behaves like a *low-pass complex signal*.#block()
  Therefore, it can be downsampled exactly like an ordinary low-pass sequence, provided the new rate still satisfies the Nyquist condition for the envelope bandwidth.
  #block()

  If the envelope is decimated by a factor $M$, $e_d [m] = e[m M]$,
  then the only requirement is
  $ M Omega_Delta < pi $

  There are *2 big advantages* to this technique :
  - No need to worry about the carrier frequency $Omega_0$ causing problems
  - More efficient bandpass signal processing, as you can process at a much lower rate !
])

Now, for *Real Signal Recovery*, we just have to combine back both negative and positive complex envelopes.\

Though, if we *downsampled before, then we have to interpolate the signals back to their original rates*. Then, we can re-modulate them back to $Omega_0$.
The recovered real signal is
$ x_"rec" [n] &= (e_"positive"[n] e^(j Omega_0 n) + e_"negative" [n] e^(-j Omega_0 n)) / 2\
  &#box(width: 0.8em, $stretch(arrow.b, size: #300%)$) #block([#v(-1.7em) $e[n] = x_I [n] - j x_Q [n]$])\
  x_"rec" [n] &= x_I [n] cos(Omega_0 n) + x_Q [n] sin(Omega_0 n) $

In other words, the original bandpass signal is *reconstructed from its two low-rate* I-Q components (Rice Components).

== Efficient Multi Rate Systems
In this section, we will focus on Graph theory to improve the efficiency of the different structures and math behind them.
=== Structures and Graph Theory
#warning_bx(title: "test",[
  The following images follow the american notation for continuous and discreet time signals :
  $
    ""& "Continuous Time" quad & quad "Discrete Time"&\
    "American :"&quad quad quad Omega & omega quad quad quad&\
    "Ours :"&quad quad quad omega & Omega quad quad quad&
  $
  (Mentioned by the Teacher)
])
==== Signal Flow Graphs

#grid(
  columns: (1.3fr, 1fr),
  align: horizon,
  figure(
    image("Images/Signal_flow_graph_table.jpg", width: 100%),
    caption: "List of all the possible operations in a flow graph"
  ),
  figure(
    image("Images/Signal_flow_graph_nodes.jpg", width: 100%),
    caption: "All possible node states"
  )
)
#trick_bx(title: "How to solve LIT (Linear In Time) Flow Graph Systems", [
    1. *Identify the signal flow*: Trace all signal paths and feedback linfinityps in the graph.

    2. *Write time-domain equations*: Express each node as a linear combination of inputs and delayed outputs.
       Example: $y[n] = a x[n] + b y[n-1]$

    3. *Apply the z-transform*: Convert time-domain difference equations to frequency domain.
       Replace $y[n-k]$ with $z^(-k) Y(z)$ and $x[n-k]$ with $z^(-k) X(z)$.

    4. *Algebraically solve for the transfer function*: Rearrange to isolate $Y(z)$ and compute
       $ H(z) = Y(z) / X(z) $

    5. *Factor and simplify*: Express as a ratio of polynomials in $z$ or $z^(-1)$.

    6. *(Optional) Inverse z-transform*: Convert back to time domain if a difference equation is needed.

    *Key insight*: The z-transform linearizes the feedback linfinityps, allowing algebraic manipulation instead of recursive substitution.
])

#example_bx(name: "Non Causal Cyclic Flow Graph", [
  #figure(
    image("Images/non_causal_flow_graph_example_1.jpg", width: 50%),
    caption: "The flow graph"
  )
  We can determine its characteristic equation through a common point :
  $
     w[n] &= x[n] + c_1 w[n-1]\
    y[n] &= w[n] + c_2 w[n-1] = x[n] + w[n-1](c_1 + c_2)
 $
 Now, we quickly get stuck due to having multiple unknowns ($w[n], w[n-1]$), but if we first use the *z-transform*, then, we can linearly obtain an equivalence with $z^(-1)$ :
  $
    cases(delim: #none,
      w[n] &= x[n] &+ c_1 w[n-1],
      y[n] &= w[n] &+ c_2 w[n-1]
    )
    quad stretch(->)^"z-transform" quad
    cases(delim: #none,
      W(z) &= X(z) &+ c_1 W(z)z^(-1),
      Y(z) &= W(z) &+ c_2 W(z)z^(-1)
    )
  $
  Then, we just have to solve the system, by first factorizing :
  $
    cases(delim: #none,
      X(z) &= W(z) (1 - c_1 z^(-1)),
      Y(z) &= W(z) (1 + c_2 z^(-1))
    )quad stretch(->)^"Combine" quad
    Y(z) (1 - c_1 z^(-1)) = W(z) = X(z) (1 + c_2 z^(-1))
  $
  We can now, re-transform it back to the discrete time :
  $
    y[n] - c_1 y[n-1] = w[n] = x[n] + c_1 x[n-1]\
    "Solution : " y[n] = x[n] + c_1 x[n-1] + c_1 y[n-1]
  $
])

#definition_bx(name: "Linearly Time Invariant (LTI) System", [
  #h(-1em) A *linear time invariant* system with $x[n]$ and $y[n]$ as their respective in/out, can be denoted with a *linear operator* $H$ :
  $ y[n] = H(x[n]) $
  - *Linearity* : $ H(alpha_1 x[n] + alpha_2 y[n]) = alpha_1 H(x[n]) + alpha_2 H(y[n]) $
  - *Time Invariance* :
  $
    H(x[n]) = y[n] => H(x[n-n_0]) = y[n-n_0]
  $
  #block()
  Such a system is *completely characterized* by its impulse response :
  $ y[n] = H(x[n]) = sum_(m=-infinity)^infinity h[m]x[n-m] $

  #warning_bx([
    The *upsampling ($arrow.t#h(-0.05em)L$)* and *downsampling ($arrow.b#h(-0.05em)M$)* operations are *NOT* time invariant !
  ])
])
#definition_bx(name: "Z-transform", [
  The *z-transform* is a Fourier transform completely in the discrete domain using the transform $z=e^(j Omega)$. And assumes this form :
    $ X(z) = sum_(m=-infinity)^infinity x[m]z^(-m) $
  Its properties are the following :
  - *Linearity* :
  $ alpha_1 x[n] + alpha_2 y[n] --> alpha_1 X(z) + alpha_2 Y(z) $
  - *Time Shift* :
  $ x[n-n_0] --> z^(-n_0) X(z) $
  - * Convolution* :
  $ x[n]times.o y[n] --> X(z)Y(z) $
])
#definition_bx(name: "The Difference Equation", [
  Any LTI graph or system can be re-written as follows :
$ y[n] = underbrace(sum_(k=0)^(M-1) b_k x[n-k], "Forward Part") - underbrace(sum_(l=0)^(N-1) a_l y[n-l], "Feedback part") $
#block()
If we apply the *z-transform* $Y(z)=H(z)X(z)$ :
$ H(z) = (sum_(k=0)^(M-1) b_k z^(-k))/(1+ sum_(l=0)^(N-1) a_l z^(-l)) $
This function is called the *transfer function*.

#align(center, table(
  columns: 2,
  gutter: 0.3em,
  stroke: 0em,
  [if $alpha_l = 0$ ], [ *Finite Impulse Response (FIR)* Filter],
  [Otherwise ], [ *Infinite Impulse Response (IIR)* Filter]
))
])
==== Commutation Rules and Identities

#theorem_bx(name: "Linearly Time Invariant (LTI) Commutation and Identities", [

  #figure(
    image("Images/LIT_operations_graph_part1.jpg", width: 50%),
    caption: "Generic LTI commutation rule"
  )
  #figure(
    image("Images/linearly_invariant_ops.jpg", width: 50%),
    caption: [Example commutation rules : $X(z)Y(z) =  Y(z)X(z)$]
  )

])
#theorem_bx(name: "Cascade of Scalar Products and Time Varying Ops", [

  #figure(
    image("Images/LIT_operations_graph_part2.jpg", width: 50%),
    caption: "Examples of : Scalar products and time varying ops "
  )

])
#lemma_bx(name: "Decimation and Interpolation Formulations", [
  // FIGURE X2
  //
  #todo_block(exp: "Check if this block should be more a theorem or some kind of other box. Depending on the auto compilation aspect bellow.")
  #grid(
    columns:2,
    [#figure(
      image("Images/Decimation_formulations.jpg", width: 95%),
      caption: "Downsampling properties for graphs"
    )
    $ y[m] = underbrace(s[m#text(fill: color.purple, $-1$)], "intermediate") &= x[M(m-1)]\ &=x[M m #text(fill: color.purple, $-M$)] $
    ], [  #figure(
      image("Images/interpolation_formulations.jpg", width: 95%),
      caption: "Upsampling properties for graphs"
    )]
  )
  #figure(
    image("Images/Upsampling and downsampling ops.jpg", width: 50%),
    caption: "Fusion of up/down ops"
  )

  Note: On the b formulation, the fractional $1/M$ delay is not realizable, but useful for intermediate steps#block()

  (Uses the noble identity)
])

#definition_bx(name: "Noble Identity (Flow Graphs)", [
  This identity comes from the the Decimation and Upsampling operations, such as in the lemma above.
  #block()
  We express the *Noble Identity* as :
  #grid(
    columns: (1fr, 1fr),
    align: center,
    inset: 0.5em,
    "Upsampling", "Decimation",
    $ stretch(->)^(H(z)) #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $arrow.t L$) #h(0.8em) stretch(->)^(H(z^L))$,
    $ stretch(->)^(H(z^M)) #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $arrow.b M$) #h(0.8em) stretch(->)^(H(z))$  )
  #figure(
    image("Images/noble_identity.jpg", width: 60%),
    caption: "Noble Identity representation (Decimation)"
  )
  #figure(
    image("Images/upsampling_noble_identity.jpg", width: 60%),
    caption: "Noble Identity representation (Interpolation)"
  )
  #todo_block(exp: "From my handwritten notes, i have noted that the spetrum h[nM] has zero insertion! Also, i remember having a lot of trouble understanding the implications of z^M --> So all of this has to be explained in more detail")

  Where the filter is discribed as :
  $ H(z^M) = sum_(n=-infinity)^infinity h[n]z^(-n M) $

  #todo_block(exp: "Custom figure to represent the 2 sides of the noble identity with decimation")
  #proof_bx(name: "Noble Identity Prinfinityf (Decimation)", [
    Denote the _impulse response_ of the transfer function $H(z^M)$ as $h'[n]$. And, let us define the middlepoint of the *Noble Identity* as $w[n]$.\
    We also have :
    $
      y[n] &= overbrace(w[n M], "sample after\nfilter")\
      w[n] &= sum_(m=-infinity)^(infinity) h'[m] x[n-m]
    $
    Since we have this property of the impulse response $h'[n]$ of the filter :
    $ h'[n] = cases(h[m'] &quad m=m'M, 0 &quad "otherwise") $
    Then, we can compute :
    $
      w[n] &= sum_(m'=-infinity)^(infinity) h'[m'] x[n-m'M]\
      y[n] &= w[n M] = sum_(m'=-infinity)^(infinity) h'[m'] underbrace(x[M (n-m')], "sample before\nfilter")
    $
  ])
  #proof_bx(name: "Noble Identity Prinfinityf (Interpolation)", [
    Denote the _impulse response_ of the transfer function $H(z^L)$ as $h'[n]$. And, let us define the output of the upsampler by $x'[n]$.\
    We also have :
    $
      y[n] &=  sum_(m=-infinity)^(infinity) h'[m] x[n-m]\
      &#box(width: 0.8em, $stretch(arrow.b, size: #300%)$) #block([#v(-1.5em)$ h'[n] = cases(h[m'] &quad m=m'L, 0 &quad "otherwise")$])\
      &= sum_(m'=-infinity)^(infinity) h'[m'] x[n-m' L]\
      &#box(width: 0.8em, $stretch(arrow.b, size: #300%)$) #block([#v(-1.5em)$ x'[n] = cases(x[m'] &quad m=m'L, 0 &quad "otherwise")$])\
      y[n L] &= sum_(m'=-infinity)^(infinity) h'[m'] x[(n-m') L] = sum_(m'=-infinity)^(infinity) h'[m'] x[n-m']
    $
    #todo_block(exp: [VERIFY THAT THIS PRinfinityF IS CORRECT, AS IT DOES NOT LinfinityK CORRECT])
  ])
])

==== Transposition and Duality
#definition_bx(name: "Dual Systems", [
  Dual systems perform operations *complementary* to each other :
  #align(center,grid(
    columns: 3,
    gutter: 1em,
    [Downsampling],[$<-->$],[Upsampling],
    [Branching],[$<-->$],[Summation],
  ))


  A system dual to another is named *complementary* to it, and can be obtained using the *transposition rules* and the *transposition operation*
])

For LTI systems, the in/out transfer function remains unchanged if :
- Branches are reversed, keeping the operation
- Branching nodes become summation nodes and vice versa
- Inputs and outputs are interchanged

Transposition is rarely donne, but its important to know.
#figure(
  image("Images/transposed_system.jpg", width: 40%),
  caption: "Example of transposition of a flow graph"
)
#warning_bx(title: "Transposition for Time Varying Systems", [
The *transposition* for *time varying systems* does NOT assure the *same* system transfer function !
#grid(
  columns: 2,
  figure(
    image("Images/dual_transposition_ups_down.jpg", width: 85%),
    caption: "Example : Dual transposition of downsampling and upsampling operations"
  ),
  figure(
    image("Images/dual_transpose_LTI.jpg", width: 95%),
    caption: "Example : Dual transposition of a mixed system"
  )
)
])

==== Direct Form and Transposed Structures
#definition_bx(name: "Direct Form FIR", [
  From the *convolution equation* :
  $ y[n] = sum_(k=0)^(N-1) h[k]x[n-k] $
  #grid(
    columns: 2,
  figure(
    image("Images/direct_form_fir.jpg", width: 70%),
    caption: "Direct Form FIR"
  ),
  figure(
    image("Images/direct_form_fir_transposed.jpg", width: 70%),
    caption: "Transposed Direct Form FIR"
  )
  )
])

#definition_bx(name: "Direct Form IIR", [
  From the *difference equation* :
  $ y[n] = sum_(k=0)^(M-1) b_k x[n-k] - underbrace(sum_(l=1)^(N-1) a_l y[n-l], "unique to IIR") $
  #figure(
    image("Images/direct_form_iir.jpg", width: 50%),
    caption: "Direct Form IIR"
  )
  With :
  $ H(z) = (sum_(k=0)^(M-1) b_k z^(-k))/(1+sum_(l=1)^(N-1) a_l z^(-l)) $
  $ Y(z)(1+sum_(l=1)^(N-1) a_l z^(-l)) quad = quad X(z) sum_(k=0)^(M-1) b_k z^(-k) $
])

#todo_block(exp: "Add 2 figures to show the difference between a FIR and IIR impulse response that is create through this system, to show the difference between the 2 structures")

#theorem_bx(name: "Efficient Reordering - Commutative Property", [
  For a cascade of LTI systems, the order of the systems can be rearranged without changing the overall transfer function, due to the *commutative property* of convolution in LTI systems.
  $ H(z) = text(fill: #color.purple, sum_(k=0)^(M-1) b_k z^(-k)) 1/(1+sum_(l=1)^(N-1) a_l z^(-l)) = 1/(1+sum_(l=1)^(N-1) a_l z^(-l)) text(fill: #color.purple, sum_(k=0)^(M-1) b_k z^(-k)) $
  $ "Commutatively : " Y(z)/(sum_(k=0)^(M-1) b_k z^(-k)) = X(z)/(1+sum_(l=1)^(N-1) a_l z^(-l))  $
  Let us make a variable change :
  $ "Variable : " Y'(z)=X(z)/(1+sum_(l=1)^(N-1) a_l z^(-l)) $
  $ Y'(z)(1+sum_(l=1)^(N-1)) = X(z) quad -->quad y'[n]+ sum_(l=1)^(N-1) a_l y'[n-k] = x[n] $
  $ "Rordered System : " y'[n] = x[n] - sum_(l=1)^(N-1) a_l y'[n-k] $
  Now, we can revert the variable change through this relation :
  $ Y(z) = Y'(z) sum_(k=0)^(M-1) b_k z^(-k) --> y[n] = sum^(M-1)_(k=0) b_k y'[n-k] $
  $ "Final Reordered System : "\ y[n] = underbrace(sum_(l=1)^(N-1) a_l y[n-l], "unique to IIR") + sum^(N-1)_(k=0) b_k x[n-k] $

  #grid(
    columns: 2,
    figure(
      image("Images/direct_form_iir.jpg", width: 70%),
      caption: "Direct Form IIR structure"
    ),
    figure(
      image("Images/reordered_iir.jpg", width: 80%),
      caption: "Reordered IIR structure"
    )
  )

  (Since this is for IIR filters, it can also be applied to FIR filters by setting $a_l = 0$ for all $l$)
])

#figure(
  image("Images/equivalent_re_ordered.jpg", width: 40%),
  caption: "Equivalent Reordered IIR structure"
)
=== Efficient Structures for Multi-Rate Systems
These structures are efficient, as they try to keep the low rate parts for as long as possible, with downsampling at the start, and interpolation at the end.
#grid(
  columns: 2,
  gutter: 1em,
  figure(
    image("Images/efficient_m_fold_decimation.jpg", width: 76%),
    caption: "Efficient structure for M-fold decimation"
  ),
  figure(
    image("Images/efficient_l_fold_interpolation.jpg", width: 100%),
    caption: "Efficient structure for L-fold interpolation"
  )
)

We could also go one step further for the decimation and interpolation structures, where at the end, we end up with these non integer delay structures, which are not realizable, but can be useful for intermediate steps and understanding the structure of the system.
$ "Decimation : " x[n] --> #h(1em) #box(stroke: 0.05em, outset: 0.5em, $arrow.b M$) #h(1em) --> underbrace(z^(-1/M), "Noble\nIdentity") --> h(0) --> y[m] $
$ "Interpolation : " x[m] --> h(0)  --> underbrace(z^(-1/L), "Noble\nIdentity") --> #h(1em) #box(stroke: 0.05em, outset: 0.5em, $arrow.t L$) #h(1em) --> y[n] $


=== Polyphase Structures
==== Polyphase Components
Polyphase components are a technique to decompose a signal into "lower frequency" components, that can be processed each at a lower rate, then re-assembled to obtain back the processed result.

#definition_bx(name: "Polyphase Decomposition", [
  The *polyphase decomposition* of a sequence $x[n]$ with respect to a factor $M$ is defined as the set of $M$ subsequences (or components) obtained by taking every $M$-th sample starting from different offsets:
  $ x_k [m] = x[M m + k], quad k = 0, 1, dots, M-1 $

  Each component $x_k [m]$ represents a "phase" of the original sequence, and together they can be used to reconstruct the original signal or to perform efficient multi-rate processing.
])

#todo_block(exp: "Figure representing the polyphase decomposition of a signal x[n] into M components, showing how each component corresponds to a different phase of the original signal. WITH enphasis on the M first elements, representing the indexes of the phase ! And the fact its like a repeated window slice")
#todo_block(exp: "Use 2 or 3 colors to explain the intermeshing of the components")
We define the *polyphase components* of a filter $h[n]$ as :
$ H(z) &= sum_(n=-infinity)^infinity h[n]z^n\
&= sum_(n=-infinity)^infinity sum_(k=0)^(M-1) underbrace(h[M n + k], p_k [n]) z^(-(M n + k)) \
&= sum_(k=0)^(M-1) z^(-k) underbrace(sum_(n=-infinity)^infinity h[M n + k] z^(-M n), "Polyphase Component") \
&= sum_(k=0)^(M-1) z^(-k) P_k (z^M)
$
Where we define the *k-th polyphase component* of the filter as :
$ P_k (z) &= sum_(n=-infinity)^infinity h[M n + k] z^(-n)\
  p_k [n] &= h[M n + k] $
Here, $k$ represents the "phase" of the original filter, and each $P_k (z)$ is a downsampled version of the original filter by a factor of $M$, containing only the coefficients corresponding to that phase.
#note_bx([
  Note the difference between $P_k (z)$ and $P_k (z^M)$, as the latter is the polyphase component expressed in terms of the original variable $z$, while the former is expressed in terms of $z^M$ which corresponds to the *downsampled domain*.
])
==== Polyphase Interpolation
$ x[n] --> #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $arrow.t L$) #h(0.8em) --> #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $H(z)$) #h(0.8em) --> y[n] $

We define interpolation as a zero insertion followed by a filter:
$
  Y(z) &= H(z) X(z^L) \
       &= sum_(k=0)^(L-1) z^(-k) P_k (z^L) X(z^L)
$

This gives a massive binfinityst in efficiency, because each polyphase branch filters at the low input rate, and the branch outputs are then upsampled, shifted, and summed to obtain the final result.

Equivalently, for the efficient implementation, we define:
$
  W_k (z) &= P_k (z) X(z) \
  Y(z) &= sum_(k=0)^(L-1) z^(-k) W_k (z^L)
$

#figure(
  image("Images/upsampling_polyphase.jpg", width: 60%),
  caption: "Polyphase interpolation structure (the upsampling factor is L)"
)

In the figure above, the filter is decomposed into its polyphase components. Each branch filter operates on the low-rate input signal $x[n]$ (equivalently, $X(z)$). The resulting branch outputs are then upsampled by $L$, shifted, and summed to obtain the final output.

#explanation_bx(name: "Polyphase interpolation renaming", [
When taking only one branch of the above structure, we have:
$ x[n] stretch(->)^(X(z)) #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $P_i (z)$) #h(0.8em) stretch(->)^(W_i (z)) #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $arrow.t L$) #h(0.8em) stretch(->)^(W_i (z^L)) #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $z^(-i)$) #h(0.8em) stretch(->)^(Y_i (z^L)) plus.o stretch(->)^(Y(z)) y[n] $

From here, we can rename some of the parts to explain them better:
- $P_i (z)$ is the *i-th polyphase component* of the _filter_. Its coefficients are given by $p_i [n] = h[n L + i]$, so it contains every $L$-th coefficient of the original filter, starting at phase $i$.
- $arrow.t L$ is the *upsampling* operation, which inserts $L - 1$ zeros between consecutive samples.
- The factor $z^(-i)$ shifts the upsampled branch output by $i$ samples so that all branches align properly before summation.

#block()
Reminder of the Noble Identity for interpolation:
$ stretch(->)^(H(z)) #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $arrow.t L$) #h(0.8em) stretch(->)^(H(z^L))   $
])

#extra_bx(title: "Parallel to Serial conversion structure using a moving switch",[#v(-1em)#figure(
  image("Images/polyphase_interpolation_parallel_to_serial.jpg", width: 50%),
  caption: "Parallel to Serial conversion Structure"
)])

==== Polyphase Decimation
Through *Transposition* and *Duality*, we can obtain the polyphase decimation structure from the interpolation one, by reversing all the operations and replacing upsampling by downsampling, and vice versa.
$ x[n] --> #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $H(z)$) #h(0.8em) --> #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $arrow.b M$) #h(0.8em) --> y[m] $

#figure(
  image("Images/Polyphase_M_fold_decimation.jpg", width: 60%),
  caption: "Polyphase decimation structure (the downsampling factor is M)"
)

#info_bx(title: "Efficient Orthogonalisation of CPU Branch Prediction",[
  To make this structure faster, we can orthogonalise the branches to make them more efficient for CPU branch prediction, by simply applying the same operation with different coefficients to each branch. This would also allow us to use SIMD instructions or a Compute Shader to process all branches in parallel, which would be a huge binfinityst in efficiency.
  #figure(
    image("Images/polyphase_decimation_orthogonalised.jpg", width: 40%),
    caption: "Orthogonalised Polyphase decimation structure"
  )
])

We can then also push its efficiency further, by using the noble identity to move the downsampling operation before the filtering, which would allow us to keep the low rate parts for as long as possible, and thus reduce the computational cost of the system even more.

#figure(
  image("Images/Polyphase_M_fold_decimation_optimized.jpg", width: 50%),
  caption: "Polyphase decimation structure (the downsampling factor is M)"
)

From the picture above, we can see that the first stage implements a *serial to parallel* conversion, where the input signal is split into $M$ branches, each containing a different phase of the original signal. Each branch is then filtered by its corresponding polyphase component $P_k (z)$ at the low input rate, and finally combined.


#note_bx(title:"Noble Identity Reminder", [  #v(-0.5em)
  $ stretch(->)^(H(z^M)) #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $arrow.b M$) #h(0.8em) stretch(->)^(H(z))   $
  #v(0.5em)
])

==== Polyphase Properties
Polyphase components have the *all-pass property*, which means that they can be used to reconstruct the original signal without any loss of information, as long as all components are used together. This is because the polyphase decomposition is a linear operation that preserves the energy of the original signal. These components are only dependant on the phase of the original signal, and not on its frequency content, which allows them to be used for efficient multi-rate processing without introducing aliasing or distortion.\

For an ideal lowpass prototype, the spectrum of the $k$-th polyphase component
becomes very simple.
For $M$-fold upsampling:
$ P_k (e^(j Omega)) = e^(j k Omega/M) $

For $M$-fold downsampling:
$ P_k (e^(j Omega)) = 1/M e^(j k Omega/M) $

So each polyphase component has the same form:
it is a pure phase term, or a scaled pure phase term in the downsampling case.

In particular:
#block(  inset: (x: 8em), grid(
  columns: (1fr, 1fr),
  align: center,
  inset: 0.4em,
  [Upsampling], [Downsampling],
  $abs(P_k (e^(j Omega))) = 1$,
  $abs(P_k (e^(j Omega))) = 1/M$
))

The phase is linear in both cases:
$
  arg P_k (e^(j Omega)) = k Omega/M.
$

Therefore, each polyphase filter behaves like an allpass branch
with a phase determined by $k$;
for downsampling, it is more precisely a scaled allpass.

#block()
Let us study its spectrum, to understand better its properties. We define the k-th polyphase component of the signal as :
$ p_k [n] &= h[M n + k]\
  &= 1/(2 pi) integral_(0)^(2 pi) P_k (e^(j Omega')) e^(j Omega' n) dif Omega'\
  &#box(width: 0.8em, $stretch(arrow.b, size: #300%)$) #block([#v(-1.5em)Apply the definition])\
  &=  1/(2 pi) integral_(0)^(2 pi) H (e^(j Omega)) e^(j Omega (n M + k)) dif Omega\
  &#box(width: 0.8em, $stretch(arrow.b, size: #300%)$) #block([#v(-1.5em)Split into slices of M bins\ the frequency axis])\
  &= 1/(2 pi) text(fill: #color.purple, sum_(p=0)^(M-1)) integral_text(fill: #color.purple, 2 pi p/M)^text(fill: #color.purple, (2 pi (p+1))/M) H(e^(j Omega)) e^(j(M n + k) Omega) dif Omega\
  &#box(width: 0.8em, $stretch(arrow.b, size: #300%)$)
      #block([#v(-1.5em)Set $Omega'' = Omega - 2 pi p/M$ and $p' = M - p$]) \
    &= 1/(2 pi) integral_text(fill: #color.purple, 0)^text(fill: #color.purple, 2 pi/M)
        sum_text(fill: #color.purple, p'=1)^text(fill: #color.purple, M)
        H(e^(j (text(fill: #color.purple, Omega'' - 2 pi p'/M))))
        e^(j (M n + k)(text(fill: #color.purple, Omega'' - 2 pi p'/M)))
        dif text(fill: #color.purple, Omega'') \
    &= 1/(2 pi) integral_(0)^(2 pi/M)
        text(fill: #color.purple, sum_(p'=0)^(M-1))
        H(e^(j (Omega'' - 2 pi p'/M)))
        e^(j (M n + k)(Omega'' - 2 pi p'/M))
        dif Omega'' \
    &#box(width: 0.8em, $stretch(arrow.b, size: #300%)$)
      #block([#v(-1.5em)Let $Omega' = M Omega''$]) \
    &= 1/(2 pi) integral_text(fill: #color.purple, 0)^text(fill: #color.purple, 2 pi)
        text(fill: #color.purple, 1/M) sum_(p'=0)^(M-1)
        e^(-2 pi j k p'/M)
        H(e^(j (text(fill: #color.purple, Omega'/M) - 2 pi p'/M)))
        e^(j (M n + k) text(fill: #color.purple, Omega'/M))
        dif text(fill: #color.purple, Omega') \
    &= 1/(2 pi) integral_(0)^(2 pi)
        underbrace([1/M e^(j k Omega'/M)
        sum_(p'=0)^(M-1)
        e^(-2 pi j k p'/M)
        H(e^(j (Omega' - 2 pi p')/M))], P_k (e^(j Omega))) e^(j Omega' n)
        dif Omega'
$
By identification,
$
  P_k (e^(j Omega)) =
    1/M e^(j k Omega/M)
    sum_(p=0)^(M-1)
    e^(-2 pi j k p/M)
    H(e^(j (Omega - 2 pi p)/M)).
$

#lemma_bx(name: "Symmetry property of Polyphase Components", [
  $ p_k [n] = h[n M + k] quad <--> quad dash(p_k)[n] = h[n M - k] $
  Prinfinityf :
  $ dash(p_k)[n] &= h[n M - k]\
    &= h[underbrace(n M - M, (n-1)M) + M-k]\
    &= p_(M-k) [n-1] $
])

==== Ideal Low Pass
We will here analyze the ideal low pass filter for *upsampling*, which is the filter that gives a rectangles in the frequency domain.
$ h[k] = sin(pi k/M)/(pi k/M) quad stretch(->)^"polyphase" quad p_rho [n] = sin(pi (n+rho/M))/(pi(n+rho/M)) $
Where the first polyphase component just transfers values from input to output :
$ p_0 [n] = delta [n] $
The missing values are *interpolated* by the other polyphase branches.

#note_bx(title: "Symmetry", [
  Since this filter is symetric :
  $ h[n] = h[-n] $
  The symmetry property of the polyphase components: $p_rho [n] = p_(M-rho) [-n-1]$
])


=== IIR structures for decimation and interpolation
Reminder of generic IIR filter :
$ H(z) = (sum_(k=0)^(M-1) b_k z^-k)/(1 - sum_(l=1)^(M-1) a_l z^-l) = N(z)/D(z) $
With the decimation IIR structure.
#figure(
  image("Images/unefficient_iir_decimation.jpg", width: 40%),
)
This structure is not totally efficient, as some parts are computed at high rates still. Also, only *numerator coefficients* can be commuted with the downsampling operation.We are aiming to have the recursive parts be realized at the low sampling rate.\
#block()
To achieve this, we will try to split the filter into a polyphase nominator, and a reordered denominator that is _common to all components_, also called *rational form* :
$ P_text(fill: #color.purple, rho) (z) = (N_text(fill: #color.purple, rho) (z))/(hat(D) (z))= (sum_(k=0)^(N_text(fill: #color.purple, rho) -1) d_(k,text(fill: #color.purple, rho)) z^(-k))/(1-sum_(r=1)^R c_r z^(-r)) $
This constraint of having the rational form with a common denominator implies : That the denominator of $H(z)$ is a polynomial in $z^M$, with its numerator being a polynomial in $z^(-1)$.
$ H(z) = N(z)/D(z) &= sum^(M-1)_(rho=0) z^(-rho) P_rho (z^M)\ &= (sum^(M-1)_(rho=0) z^(-rho) N_rho (z^M))/(hat(D)(z^M)) $

#figure(
  image("Images/efficient_polyphase_iir_decimation.jpg", width: 40%),
  caption: "Efficient Decimation Structure using a efficient IIR filter"
)

Pushing it even further, we can share the delays of the different components :
#figure(image("Images/efficient_iir_delays.jpg", width: 40%), caption: "Transposed version of the direct form reordering polyphase filter")
#grid(
  columns: 2,
  figure(image("Images/efficient_polyphase_iir_decmiation_delays.jpg", width: 80%), caption: "Efficient IIR decimation structure with optimized delays"),
  figure(image("Images/efficient_polyphase_iir_interpolation_delays.jpg", width: 80%), caption: "Efficient IIR interpolation structure with optimized delays")
)

#theorem_bx(name: "Efficient Generalization of IIR structures for decimation & interpolation", [
  It is hard to find a general efficient decimator of the following form with $H(z)=(N(z))/(D(z))$ :
  $ x[n] --> #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $H(z)$) #h(0.8em) --> #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $arrow.b M$) #h(0.8em) --> y[n] $
  As such, if we have a denominator that is a polynomial in $z^(2M)$ such as $D(z) = hat(D)(z^M)$, we can then re-order the system to obtain an efficient structure for decimation :
  $ x[n] --> #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $N(z)$) #h(0.8em) --> #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $1/(D(z)) = 1/(hat(D)(z^M))$) #h(0.8em) --> #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $arrow.b M$) #h(0.8em) --> y[n] $
  We can use the noble identity to reduce the computational cost further :
  $ x[n] --> underbrace(#box(inset: 0.3em, [#h(0.6em) #box(outset: 0.5em, stroke: 0.05em, $N(z)$) #h(0.6em) $-->$ #h(0.6em) #box(outset: 0.5em, stroke: 0.05em, $arrow.b M$) #h(0.6em)]), "Standard form FIR decimator") --> #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $1/(hat(D)(z))$) #h(0.8em)  --> y[n] $
  The standard form FIR decimator can then be implemented using an efficient direct form polyphase structure.
  We say this is efficient, as all filters run at a lower rate (polyphase components and decimation) !
])

=== Filter Banks
The idea of this technique is to *separate the spectrum into $M$ different sub-bands*. Depending on the application *all sub-bands don't have the same importance*, so we can allocate more resources to the important ones, and less to the others, which allows us to save a lot of computational cost while still having ginfinityd performance.\

Each sub-band is *centered in $Omega_k$*, and its contents are obtained using a *bandpass filter using frequency shifting* such as : $ H_k (e^(j Omega)) = H(e^(j(Omega - Omega_k))) quad <-> quad h_k [n] = h_0 [n] e^(j Omega_k n) $
For a uniform filter bank, the sub-bands are :
$ Omega_k = 2 pi k/M, quad k = 0, 1, dots, M-1 $
#note_bx([#v(-1em) Sub-band filters *CAN overlap* or not])
#lemma_bx(name: "Sub-band processing at a lower rate", [
  If the sub-bands are non-overlapping, we can process each sub-band at a lower rate, as long as we respect the Nyquist criterion for each sub-band. This is because the bandwidth of each sub-band is reduced by a factor of $M$, so we can downsample by $M$ without introducing aliasing.
  #figure(
    image("Images/Efficient_sub_band_processing_at_low_rate.jpg", width: 80%),
    caption: "Not Efficient sub-band processing at a lower rate using a filter bank"
  )
  Structure :
  - Analysis filter bank (separation): $quad quad x[n] --> #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $H_k (z)$) #h(0.8em) --> #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $arrow.b M$) #h(0.8em) --> y_k [m]$

  - Synthesis filter bank (reconstruction): $quad z_k [n] --> #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $arrow.t M$) #h(0.8em) --> #h(0.8em) #box(outset: 0.5em, stroke: 0.05em, $hat(H)_k (z)$) #h(0.8em) --> y[n] $
])
Let us define the polyphase components for the filter $h[h]$:
$ H(z) = sum_(l=0)^(M-1) z^(-l) underparen(P_l (z^M)) quad -->quad P_l (z^M) = sum_(n=-infinity)^(infinity) h[n M+l] z^(-n M) $
From the definition of the filter bank, we have :
$ underbrace(H_k (z), H_k (e^(j Omega))) = underbrace(H(z e^(-j Omega_k)), H(e^(j (Omega - Omega_k)))) = sum_(l=0)^(M-1) z^(-l) e^(j (2 pi)/M k l) P_l (z^M underbrace(e^(-j (2 pi)/M M k), 1)) = sum_(l=0)^(M-1) e^(j (2 pi)/M k l) P_l (z^M) z^(-l)  $
Hence, filtering the signal $x[n]$ is equivalent to :
$ H_k (z) X(z) = sum_(l=0)^(M-1) e^(j (2 pi)/M k l) P_l (z^M) z^(-l) text(fill: #color.purple, X(z)) $
Hence, the *k-th sub-band* is the output of the *k-th output of an IDFT*.

#figure(
  image("Images/AFB_polyphase.jpg", width: 50%),
  caption: "Resulting Polyphase AFB network structure (not yet efficient)"
)
Here comes the real tricks :
#grid(
  columns: 2,
  gutter: 0.5em,
  figure(
    image("Images/AFB_polyphase_linearity.jpg", width: 90%),
    caption: [Using the *linearity of the IDFT* (matrix multiplication), it can be commuted with the downsampling operation]
  ),
  [#figure(
    image("Images/AFB_polyphase_noble_identity.jpg", width: 90%),
    caption: [The *noble identity* can be used to swap the downsampler and filter]
  )<fig:nobleFB>]
)
We finally have the most efficient structure for the analysis filter bank in @fig:nobleFB, where all filters run at the low rate, and the IDFT is performed at the low rate as well, which gives a huge binfinityst in efficiency.\

Similarly, we can obtain the efficient *SFB network*, obtained through *transposition* and *duality* of the AFB network:
#figure(
  image("Images/SFB_polyphase.jpg", width: 50%),
  caption: "Efficient Synthesis Filter Bank structure"
)
#note_bx([
  #v(-1em)
  Be careful of the transposition of $"IDFT" <-> "DFT"$, which are quite complex in nature.
])

==== Quadrature Mirror Filters (QMF)
The idea of this technique is to design a *two-band filter bank* where the analysis filters are *mirror images* of each other in the frequency domain, such that the output sub-bands are *perfectly complementary* and can be used for efficient sub-band processing. The analysis filters are designed such that their frequency responses are related by a simple modulation, which allows for perfect reconstruction of the original signal from the sub-bands.

#figure(
  image("Images/QMF_basic.jpg", width: 40%),
  caption: "Quadrature Mirror Filter structure"
)
With $h_0 [n]$ and $h_1 [n]$ representing the analysis filters, and $f_0 [n]$ and $f_1 [n]$ representing the synthesis filters.
$ "AFB Output :" cases(
  X_0 (e^(j Omega)) = H_0 (e^(j Omega/2)) X(e^(j Omega/2)) + H_0 (e^(j (Omega - pi)/2)) X(e^(j (Omega - pi)/2)),
  X_1 (e^(j Omega)) = H_1 (e^(j Omega/2)) X(e^(j Omega/2)) + H_1 (e^(j (Omega - pi)/2)) X(e^(j (Omega - pi)/2))
) $
$ "SFB Output :" hat(X)(e^(j Omega) = hat(X_0)(e^(j 2 Omega))F_0 (e^(j Omega)) + hat(X_1)(e^(j 2 Omega))F_1 (e^(j Omega)) $

#todo_block(exp: "Finish this part, from slide 91 onwards, its like 4 slides, but its maybe not important idk")


== Discrete Fourier Transform (DFT)
=== Definitions and properties
#lemma_bx(name: "Continuous and Discrete time systems", [
  #v(-1em)
  #grid(
    columns: (1fr, 1fr),
    align: center,
    gutter: 2em,
    [Continuous time], [Discrete time],
    $y(t) &= integral_(-infinity)^(infinity) h(tau) x(t - tau) dif tau\
      &=integral_(-infinity)^(infinity) h(tau) e^(j omega(t - tau)) dif tau\
      &=e^(j omega t) underparen(integral_(-infinity)^(infinity) h(tau) e^(-j omega tau) dif tau)\
      &= e^(j omega t) H(j omega)
    $,
    $y[n] &= sum_(k=-infinity)^(infinity) h[k] x[n-k]\
      &= sum_(k=-infinity)^(infinity) h[k] e^(j Omega (n-k))\
      &= e^(j Omega n) underparen(sum_(k=-infinity)^(infinity) h[k] e^(-j Omega k))\
      &= e^(j Omega n) H(e^(j Omega))
     $
  )
])
#definition_bx(name: "Complex exponential", [
  - We say that complex exponentials are the *eigenfunctions* of LTI systems.
  - The output is proportional to the input, with a proportionality factor of :
    $ underbrace(H(j omega), "Continuous Time") quad quad quad underbrace(H(e^(j Omega)),"Discrete Time")  $
  - Makes it into a sume of complex exponentials, which is the basis of the Fourier analysis of signals and systems.
  (Convolution is modified into a product in the frequency domain, and vice versa)
])

#definition_bx(name: "5 types of fourier transforms",[
  #table(
      columns: (1.2fr, 1.3fr, 1fr, 1.3fr, 1fr),
      align: center,
      inset: 8pt,
      stroke: (x: none, y: 0.4pt + luma(180)),
      [*Name*], [*Time Type*], [*Time \ Periodic*], [*Freq Type*], [*Freq \ Periodic*],

      [CTFT \ #text(5pt)[Continuous-time Transform]],
      [Continuous], [No], [Continuous], [No],

      [CTFS \ #text(5pt)[Continuous-time Fourier Series]],
      [Continuous], [Yes], [Discrete], [No],

      [DTFT \ #text(5pt)[Discrete-time Transform]],
      [Discrete], [No], [Continuous], [Yes],

      [DTFS \ #text(5pt)[Discrete-time Fourier Series]],
      [Discrete], [Yes], [Discrete], [Yes],

      [DFT \ #text(5pt)[Limited Duration Discrete Transform]],
      [Discrete (Limited)], [No], [Discrete (Limited)], [No],
  )
])

#definition_bx(name: "Fourier Transform (FT, CTFT)", [
  - *Direct transform:* $ X(j omega) = integral_(-infinity)^infinity x(t) e^(-j omega t) dif t $
  - *Inverse transform:* $ x(t) = 1/(2 pi) integral_(-infinity)^infinity X(j omega) e^(j omega t) dif omega $
  - *Properties:*
    - For continuous time non-periodic signals.
    - Evaluates a continuum of frequencies ($omega in ]-infinity; infinity[$).
    - Converges for absolutely summable signals ($integral_(-infinity)^infinity |x(t)| dif t < infinity$).
])
#definition_bx(name: "Discrete time Fourier Transform (DTFT)", [
  - *Direct transform:* $ X(e^(j Omega)) = sum_(n=-infinity)^infinity x[n] e^(-j Omega n) $
  - *Inverse transform:* $ x[n] = text(fill: #color.purple,1/(2 pi)) integral_text(fill: #color.purple,0)^text(fill: #color.purple,2 pi) X(e^(j Omega)) e^(j Omega n) dif Omega $
  - *Properties:*
    - For discrete time non-periodic signals.
    - The spectrum $X(e^(j Omega))$ is *periodic with period $2 pi$* in $Omega$ (Mapping $Omega=omega t$).
    - Converges for absolute summable sequences.
    - Inverse integral can be over *any interval of width $2 pi$*.
])
#definition_bx(name: "Fourier Series (FS, CTFS)", [
  - *Expansion:* $ x(t) = sum_(k=-infinity)^infinity X[k] e^(j k omega_0 t) $
  - *Coefficients:* $ X[k] = text(fill: #color.purple,1/T) integral_text(fill: #color.purple,0)^text(fill: #color.purple,T) x(t) e^(-j k omega_0 t) dif t $
  - *Properties:*
    - Expands *continuous time periodic* signals of *period $T$* (fundamental frequency $omega_0/(2 pi) = 1/T$).
    - The repetition of the fundamental frequencies are called *harmonics* at $k/T = k omega_0/(2 pi)$
    - The spectrum consists of *spectral lines/samples* ($delta$) at multiples $k/T = k (2 pi)/omega_0$ of amplitude $2 pi X[k]$:
    $ underbrace(X(j omega),"Continuous\nFrequency") = text(fill: #color.purple,2 pi) sum_(k=-infinity)^infinity X[k] underbrace(delta(omega - k omega_0),"Continuous\n Dirac Impulse") $
    (The fundamental frequency $omega_0$ is the spacing between samples)
])
#proof_bx(name: "CTFS devlopment proof (Compact)", [
  $
    X(j omega) &= integral_(-infinity)^(infinity) x(t) e^(-j omega t) dif t stretch(=)^"CTFS\nDef" integral_(-infinity)^(infinity) (sum_(k=-infinity)^(infinity) X[k] e^(j k omega_0 t)) e^(-j omega t) dif t\
    &= sum_(k=-infinity)^(infinity) X[k] underbrace(integral_(-infinity)^(infinity) e^( - j (omega - k omega_0)t) dif t, 2 pi delta(omega - k omega_0)) = 2 pi sum_(k=-infinity)^infinity X[k] delta(omega - k omega_0)
  $
])
#definition_bx(name: "Discrete time Fourier Series (DTFS)", [
  - *Expansion:* $ x[n] = sum_(k=0)^(N-1) X[k] e^(j k Omega_0 n) = underbrace(sum_(k=text(fill: #color.purple,k_0))^(text(fill: #color.purple,k_0) + N-1) X[k] e^(j k Omega_0 n),"N Periodic Repetition") $
  - *Coefficients:* $ X[k] = 1/N sum_(n=0)^(N-1) x[n] e^(-j k Omega_0 n) = 1/N underbrace(sum_(k=text(fill: #color.purple,n_0))^(text(fill: #color.purple,n_0) + N-1) x[n] e^(-j k Omega_0 n),"N Periodic Repetition") $
  - *Properties:*
    - Expands discrete time periodic signals of period $N$.
    - Has $N$ degrees of freedom, hence N therms.
    - Periodic in both time and frequency with repetition at frequency $(k+p N) Omega_0 quad forall p in NN$.
    - Spectrum consists of spectral lines at positions multiple of the fundamental frequency $ (2 pi) / N = Omega_0$:
    $ X(e^(j Omega)) = text(fill: #color.purple,2 pi) sum_text(fill: #color.purple,k=0)^text(fill: #color.purple,N-1) X[k] underbrace(delta(Omega - k Omega_0),"Continuous\n Dirac Impulse") $
  (The fundamental frequency $Omega_0$ is the spacing between samples)
])
#note_bx(title: "Aliasing exists in any sampled system",[
  #v(-1em)
  Remember that any discrete signal will get aliasing due to the periodicity of the spectrum !
])

#proof_bx(name: "From DTFT to Z-transform",[
  Reconstructing the continuous DTFT spectrum from discrete DFT samples.

    - *1. IDFT Substitution:*
      Substitute the IDFT $x[n] = 1/N sum_(k=0)^(N-1) X[e^(j Omega_k)] e^(j 2 pi (k n)/N)$ into the Z-transform definition $X(z) = sum_(n=0)^(N-1) x[n] z^(-n)$:
      $ X(z) = 1/N sum_(k=0)^(N-1) X[e^(j Omega_k)] sum_(n=0)^(N-1) (e^(j 2 pi k/N) z^(-1))^n $

    - *2. Geometric Series:*
      The inner sum reduces via $(1-r^N)/(1-r)$. Since $(e^(j 2 pi k/N))^N = 1$, the numerator simplifies:
      $ sum_(n=0)^(N-1) r^n = (1 - (e^(j 2 pi k/N) z^(-1))^N) / (1 - e^(j 2 pi k/N) z^(-1)) = (1 - z^(-N)) / (1 - e^(j 2 pi k/N) z^(-1)) $

    - *3. Final Interpolation Formula:*
      $ X(z) = (1 - z^(-N))/N sum_(k=0)^(N-1) X[e^(j Omega_k)] / (1 - e^(j 2 pi k/N) z^(-1)) $
      Evaluating on the unit circle ($z = e^(j Omega)$) smoothly interpolates the discrete samples into the continuous, $2pi$-periodic DTFT.
])
#theorem_bx(name: "Orthogonality Property (Roots of Unity)", [
  This formula proves that the complex exponential basis functions used in the DFT and DTFS are orthogonal. This is what allows us to perfectly isolate specific frequencies and invert the transforms.

  - *The Geometric Series:*
    $ sum_(n=0)^(N-1) e^(j (2 pi)/N (l-m) n) = sum_(n=0)^(N-1) (e^(j (2 pi)/N (l-m)))^n $
    This is the sum of a geometric progression where the ratio is a complex exponential. The term $e^(j 2 pi / N)$ is the fundamental $N$-th root of unity.

  - *Case 1: $(l - m)$ is NOT a multiple of $N$ (Different frequencies)*
    The complex vectors are spread evenly around the unit circle. Because of their perfect radial symmetry, they pull equally in all directions, making their vector sum exactly zero.
    $ "Sum" = (1 - e^(j 2 pi (l-m))) / (1 - e^(j (2 pi)/N (l-m))) = (1 - 1) / "non-zero" = 0 $
    *(This corresponds to your red note: "Sum of all roots = 0")*

  - *Case 2: $(l - m)$ IS a multiple of $N$ (e.g., $l = m$)*
    The exponent becomes a multiple of $2 pi$. Every term in the sum reduces to $e^(j 2 pi p) = 1$. The vectors perfectly align on the real axis, adding up constructively.
    $ sum_(n=0)^(N-1) 1^n = N $
    *(This corresponds to your green note: "Not 0 when multiple of N -> coherent vectors")*

  - *Visual Context ($N=8$):* Your drawing on the complex plane shows the 8 equally spaced roots of unity. If you add these 8 vectors together tip-to-tail, you return to the origin ($0$). If you rotate them by $0$ degrees (coherent), they stretch out sequentially to length $N$.
])

=== The DFT, properties and definition
#todo_block(exp: "Possible missing Information here, donne with AI, slides 28-31")
#definition_bx(name: "Discrete Fourier Transform (DFT)", [
  - *Definition (Spectrum Sampling):* Samples the DTFT spectrum $X(e^(j Omega))$ at positions $Omega_k = 2 pi k / N$:
    $ X(e^(j Omega_k)) = sum_(n=-oo)^oo x[n] e^(-j Omega_k n) $
  - *Sampling the Spectrum:*
    $ X(e^(j Omega)) times sum_(k=0)^(N-1) delta(Omega - (2 pi k)/N) = sum_(k=0)^(N-1) X(e^(j Omega_k)) delta(Omega - (2 pi k)/N) $
  - *Properties:*
    - Sampling in the frequency ($Omega$) domain with period $2 pi/N$ creates a periodization of the time signal with period $N$:
      $ x_p[n] = sum_(i=-oo)^oo x[n - i N] $
    - *No Aliasing Condition:* To perfectly reconstruct a finite sequence $x[n]$ of length $L$, the number of frequency samples must be $N >= L$.

  - *DFT / IDFT Pair (Finite Sequence):* Using the twiddle factor $W_N = e^(-j (2 pi)/N)$:
    - *DFT:* $X[k] = sum_(n=0)^(N-1) x[n] W_N^(k n)$
    - *IDFT:* $x[n] = 1/N sum_(k=0)^(N-1) X[k] W_N^(-k n)$

  - *Periodicity:* Both sequences are implicitly periodic with period $N$.
    $ x[n+N] = x[n] quad "and" quad X[k+N] = X[k] $

  - *Matrix Formulation:* The DFT can be expressed as a linear transformation $X = W_N x$, where $X$ and $x$ are column vectors and $W_N$ is the $N times N$ DFT matrix with elements $[W_N]_(k,n) = W_N^(k n)$.
  - *Matrix Properties:* - It is a *Vandermonde* matrix.
    - It is *Symmetric*: $W_N = W_N^T$
    - It is *Orthogonal*: $1/N W_N^* W_N = I$, which means the inverse matrix is $W_N^(-1) = 1/N W_N^*$.
])

#proof_bx(name: "Time-Domain Periodization from Frequency Sampling", [
  We want to find the inverse DTFT of the discretely sampled spectrum. Let's represent the sampled spectrum as $X_p(e^(j Omega))$ using Dirac impulses with proper area scaling $(2 pi)/N$:
  $ X_p (e^(j Omega)) = sum_(k=0)^(N-1) X(e^(j Omega_k)) (2 pi)/N delta(Omega - (2 pi k)/N) $

  Taking the Inverse DTFT to find $x_p[n]$:
  $ x_p[n] &= 1/(2 pi) integral_0^(2 pi) [ sum_(k=0)^(N-1) X(e^(j Omega_k)) (2 pi)/N delta(Omega - (2 pi k)/N) ] e^(j Omega n) dif Omega \
           &= 1/N sum_(k=0)^(N-1) X(e^(j Omega_k)) e^(j (2 pi k n)/N) $

  Substitute the continuous DTFT definition $X(e^(j Omega_k)) = sum_(l=-oo)^oo x[l] e^(-j (2 pi k l)/N)$:
  $ x_p[n] &= 1/N sum_(k=0)^(N-1) [ sum_(l=-oo)^oo x[l] e^(-j (2 pi k l)/N) ] e^(j (2 pi k n)/N) \
           &= sum_(l=-oo)^oo x[l] underbrace([ 1/N sum_(k=0)^(N-1) e^(j (2 pi k (n-l))/N) ], "Orthogonality property") $

  Due to the orthogonality of the roots of unity, the inner bracket equals $1$ only when $(n - l)$ is a multiple of $N$ (i.e., $l = n - m N$ for some integer $m$), and equals $0$ otherwise.

  Therefore, the sum collapses to:
  $ x_p[n] = sum_(m=-oo)^oo x[n - m N] $
  This proves that sampling in the frequency domain results in an infinite periodic extension of the original signal in the time domain.
])

#note_bx(title: "DFT Matrix Structure", [
  The DFT can be written as a matrix multiplication: $X = W_N x$.

  - *Dimensions:* $W_N$ is a square $N times N$ matrix, mapping $N$ time samples to $N$ frequency samples.
  - *Coefficients:* Let the base twiddle factor be $W = e^(-j (2 pi)/N)$. The coefficient at row $k$ and column $n$ is exactly:
    $ [W_N]_(k,n) = W^(k n) $

  - *General Layout:* Because $k=0$ and $n=0$ yield $W^0 = 1$, the first row and first column are always entirely $1$s. The rest of the matrix is populated by multiplying the row and column indices:

    $ W_N = mat(
      1, 1, 1, dots.h, 1;
      1, W^1, W^2, dots.h, W^(N-1);
      1, W^2, W^4, dots.h, W^(2(N-1));
      dots.v, dots.v, dots.v, dots.down, dots.v;
      1, W^(N-1), W^(2(N-1)), dots.h, W^((N-1)(N-1))
    ) $
])

#let hl(x) = text(fill: purple, x)

#theorem_bx(name: "Computation of the discrete Fourier transform (DFT)", [
  #todo_block(exp: "Verify and cleanup, maybe rename as its not really a theorem")
  To compute the signal $tilde(x)[n]$ obtained from the samples $X(e^(j Omega_k))$, one can approximate the inverse Fourier transform (continuous in $Omega$) by the *rectangle method*, which leads to:

  $ tilde(x)[n] &= 1/(2pi) integral_0^(2pi) X(e^(j Omega)) e^(j n Omega) dif Omega \
  &approx.eq 1/(2pi) hl(sum_(k=0)^(N-1)) X(e^(hl(j k Delta Omega))) e^(hl(j n k Delta Omega)) hl(Delta Omega) quad "where" Delta Omega = (2pi)/N \
  &= 1/(2pi) sum_(k=0)^(N-1) X(e^(hl(2pi j k / N))) e^(hl(2pi j k n / N)) hl((2pi)/N) \
  &= hl(1/N) sum_(k=0)^(N-1) X(e^(2pi j k / N)) e^(2pi j k n / N) $

  Aside from the factor $1/N$, this corresponds to a Fourier series expansion where we limit the index $n$ to $n = 0, dots, N-1$.

  #line(length: 100%, stroke: 0.5pt + luma(200))

  Expanding the frequency-domain samples $X(e^(2pi j k / N))$ back into their time-domain summation reveals the effect on the resulting signal:

  $ tilde(x)[n] &= 1/N sum_(k=0)^(N-1) X(e^(2pi j k / N)) e^(2pi j k n / N) \
  &= 1/N sum_(k=0)^(N-1) hl([sum_(l=-infinity)^infinity x[l] e^(-2pi j k l / N)]) e^(2pi j k n / N) \
  &= 1/N hl(sum_(l=-infinity)^infinity x[l] sum_(k=0)^(N-1)) e^(-2pi j k l / N) e^(2pi j k n / N) \
  &= 1/N sum_(l=-infinity)^infinity x[l] hl([N sum_(i=-infinity)^infinity delta[l - n - i N]]) \
  &= hl(sum_(i=-infinity)^infinity x[n + i N]) $

  which confirms the *time periodization* of the signal with period $N$.
])

#todo_block(exp: "Do all slides from slide 34 - 40")

=== Types of signals in a DFT
==== Finite Duration
When computing the DFT of a finite duration signal $x[n]$ of length $N$, the resulting spectrum consists of $N$ frequency samples positioned at $Omega_l = 2pi l / N$ for $l = 0, dots, N-1$. If a higher density of frequency samples is desired (i.e., $L$ samples where $L > N$), the original sequence can be extended by appending $L - N$ zeros. This operation, known as *zero padding*, produces a new sequence $bold(y)$ computed as:

$ bold(y) = [x[0], x[1], dots, x[N-1], underbrace(0\, dots\, 0, L-N "zeros")]^T $

Applying an $L$-point DFT to this padded sequence yields frequency samples evaluated at $Omega_l = 2pi l / L$:

$ Y(e^(j 2pi l / L)) &= sum_(n=0)^(hl(L-1)) hl(y[n]) e^(-j 2pi l n / L) \
&= sum_(n=0)^(hl(N-1)) hl(x[n]) e^(-j 2pi l n / L) \
&= hl(X(e^(j 2pi l / L))) quad "for " l = 0, dots, L-1 $

It is important to emphasize that zero padding *does not add any new information* to the signal. The underlying frequency resolution remains $Delta Omega = 2pi/N$. The zero padding simply computes a denser *interpolation* of the same spectrum.

==== Periodic
#todo_block(exp: "Must rewrite or adjust stuff here, as its written by AI, and i had a hard time controlling it")

#let hl(x) = text(fill: purple, x)

===== Periodic signal: truncation to one period
When the Discrete Fourier Transform (DFT) is fed with a periodic signal $x[n]$ of period $N$, it implicitly truncates the signal to $N$ samples. This truncation is equivalent to multiplying $x[n]$ by a *rectangular window* $w_N [n]$ defined as:
$ w_N [n] = cases(1 quad "for " n = 0, dots, N - 1, 0 quad "otherwise") $

In the frequency domain, the spectrum of $x[n]$ is thereby modified by a *convolution* with the spectrum of $w_N [n]$.
If $x_t [n] = x[n] w_N [n]$ is the *truncated version* of $x[n]$ to $N$ samples, the spectrum $X_t (e^(j Omega))$ is given by:
$ X_t (e^(j Omega)) = 1 / (2pi) X(e^(j Omega)) convolve.o W_N (e^(j Omega)) $

(Remark: the $W_N (e^(j Omega))$ used here should not be confused with the twiddle factor $W_N$)

#proof_bx(name: "Spectrum of the truncated signal", [
  The *spectrum* of the window $w_N [n]$ is given by:
  $ W_N (e^(j Omega)) = (1 - e^(-j N Omega)) / (1 - e^(-j Omega)) = (e^(-j N Omega / 2) sin(N Omega / 2)) / (e^(-j Omega / 2) sin(Omega / 2)) = e^(-j (N - 1) Omega / 2) (sin(N Omega / 2)) / (sin(Omega / 2)) $
  $arrow$ this is a *sinc* function with $0$s at positions $Omega = 2k pi / N$ except when $Omega = 0$ for which we get $N$.

  If $x[n]$ is precisely $N$-periodic, its spectrum consists of discrete spectral lines:
  $ X(e^(j Omega)) = 2pi sum_(k=0)^(N-1) X[k] delta(Omega - k Omega_0) $
  where $Omega_0 = 2pi / N$.

  Convolving this with $W_N (e^(j Omega))$ gives:
  $ hl(X_t (e^(j Omega))) &= hl(1 / (2pi) X(e^(j Omega)) convolve.o W_N (e^(j Omega))) \
  &= hl(sum_(k=0)^(N-1) X[k] W_N (e^(j (Omega - k Omega_0)))) $
  $arrow$ a *sinc* is placed in front of each of the spectral lines at *positions* $Omega = 2k pi / N$. Each sinc has a *value* hl($N$) in front of the spectral line where it is located and has a *$0$ value* in front of all the other spectral lines.

  As the frequency sampling is precisely at positions $Omega = 2l pi / N$, one only samples at the positions of the spectral lines which are not modified (except for the factor $N$).
  Sampling $X_t (e^(j Omega))$ at positions $l Omega_0 = 2pi l / N$ with $l in [0, dots, N - 1]$, one obtains:
  $ X_t (e^(j l Omega_0)) &= 1 / (2pi) X(e^(j l Omega_0)) convolve.o W_N (e^(j l Omega_0)) \
  &= sum_(k=0)^(N-1) X[k] W_N (e^(j (l Omega_0 - k Omega_0))) $

  About $W_N (e^(j Omega))$ we have:
  $ W_N (e^(j (l - k) Omega_0)) = e^(-j (N - 1)(l - k) Omega_0 / 2) (sin(N (l - k) Omega_0 / 2)) / (sin((l - k) Omega_0 / 2)) $
  The $sin$ of the numerator is $0$ when $N(l - k) Omega_0 / 2 = i pi arrow l - k = i$ (integer except $i = 0$).
  For $i = 0$ or $k = l$, we have $W_N (e^(j 0)) = N$ and $X_t (e^(j l Omega_0)) = N X[l]$.
])

*The discrete spectrum $X(e^(j Omega))$, made of spectral lines, is perfectly preserved for a DFT applied to $x[n]$ truncated to exactly one period $N$ (except for a scaling by $N$).*

#v(1em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(1em)

===== Periodic signal: truncation to several periods
Assume now a truncation to *$M$ periods* and a *DFT of size $M N$*.
The truncation means now that $x[n]$ is multiplied by a rectangular window $w_(M N) [n]$ defined by:
$ w_(M N) [n] = cases(1 quad "for " n = 0, dots, M N - 1, 0 quad "otherwise") $

The spectrum of $x[n]$ is modified by a convolution with the spectrum of $w_(M N) [n]$.
Let us denote by $x_(t, M N) [n]$ the truncated version to $M N$ samples of $x[n]$; $X_(t, M N) (e^(j Omega))$ is given by:
$ X_(t, M N) (e^(j Omega)) = 1 / (2pi) X(e^(j Omega)) convolve.o W_(M N) (e^(j Omega)) $

#proof_bx(name: "Spectrum of the multi-period truncated signal", [
  The spectrum of $w_(M N) [n]$ is given by:
  $ W_(M N) (e^(j Omega)) = e^(-j (M N - 1) Omega / 2) (sin(M N Omega / 2)) / (sin(Omega / 2)) $
  $arrow$ this is a sinc function with $0$ at positions $Omega = 2k pi / (M N)$ except when $Omega = 0$ for which we get $M N$.

  If $x[n]$ is $N$-periodic, its spectrum has the structure:
  $ X(e^(j Omega)) = 2pi sum_(k=0)^(N-1) X[k] delta(Omega - k Omega_0) $
  With $Omega_0 = 2pi / N$, it therefore comes:
  $ X_(t, M N) (e^(j Omega)) &= 1 / (2pi) X(e^(j Omega)) convolve.o W_(M N) (e^(j Omega)) \
  &= sum_(k=0)^(N-1) X[k] W_(M N) (e^(j (Omega - k Omega_0))) $
  $arrow$ a sinc is placed in front of each of the spectral lines at positions $Omega = 2k pi / N$.
  $arrow$ each sinc has a value $M N$ in front of the spectral line where it is located and has a $0$ value in front of all the other spectral lines; it also has $0$ values for positions $l = k M + i$ except for $i = 0$.

  As the frequency sampling is precisely at positions $Omega = 2l pi / (M N)$, one only samples at the positions of the spectral lines which are not modified (except for the factor $M N$) and at positions where the sinc is equal to $0$.

  Sampling $X_(t, M N) (e^(j Omega))$ for all positions hl($2pi l / (M N) = l Omega_(0, M)$) with $l in [0, dots, M N - 1]$, we obtain:
  $ X_(t, M N) (e^(j l Omega_(0, M))) &= 1 / (2pi) X(e^(j l Omega_(0, M))) convolve.o W_(M N) (e^(j l Omega_(0, M))) \
  &= sum_(k=0)^(N-1) X[k] W_(M N) (e^(j (l Omega_(0, M) - k Omega_0))) $

  We have about $W_(M N) (e^(j Omega))$ that:
  $ W_(M N) (e^(j (l Omega_(0, M) - k Omega_0))) = e^(-j (M N - 1)(l - k M) Omega_(0, M) / 2) (sin(M N (l - k M) Omega_(0, M) / 2)) / (sin((l - k M) Omega_(0, M) / 2)) $
  The $sin$ at the numerator takes a $0$ value when $M N (l - k M) Omega_(0, M) / 2 = i pi arrow l - k M = i$ (integer except $i = 0$).
  For $i = 0$ or $l = k M$, we have $W_(M N) (e^(j 0)) = M N$ and:
  $ X_(t, M N) (e^(j l Omega_(0, M))) = cases(hl(M N X[l / M]) quad "for " l = k M, hl(0) quad "otherwise") $
])

#note_bx([
  *The spectrum of $X(e^(j Omega))$, made of spectral lines, is maintained when the DFT is fed with $x[n]$ truncated to $M$ periods* (that is $M N$ samples).
  There are however two modifications:
  - the spectral lines located in $k Omega_0$ are multiplied by a *factor $M N$*
  - *$(M - 1)$ $0$s are inserted* between two successive spectral lines.

  - To compute the spectrum of an $N$-periodic signal $x[n]$ using the DFT, we MUST compute the DFT over exactly $N$ samples (or $M N$ samples, a multiple of $N$).
  - The resolution of the DFT is then $Delta Omega = 2pi / N$ (or $2pi / (M N)$) and precisely matches the spacing of the true spectral lines.
  - The only impact on the DFT output is a scaling factor $N$ (or $M N$) that is easily compensated.
  - In this case, the analysis window perfectly matches the signal's period, thus *no leakage* occurs.
  - Otherwise, if we truncate to a non-integer number of periods, leakage will occur and *artifacts* (sinc lobes) will appear between the real spectral lines.
])

===== Power Spectral Density (PSD)
For stationary random signals, we analyze the *Power Spectral Density (PSD)* defined as the Discrete Time Fourier Transform (DTFT) of the autocovariance function $gamma_x[k]$

$ S_x (e^(j Omega)) = sum_(k=-infinity)^infinity gamma_x[k] e^(-j k Omega) $

In practice, we only have one realization of the random signal $x[n]$ of finite length $N$.
We use the *periodogram* to estimate the PSD:

$ hat(S)_x (e^(j Omega)) = 1/N | sum_(n=0)^(N-1) x[n] e^(-j n Omega) |^2 = 1/N | X(e^(j Omega)) |^2 $

Is the periodogram a good estimator of the PSD? Let's compute its expected value:

$ "E"[hat(S)_x (e^(j Omega))] = "E" [ 1/N | sum_(n=0)^(N-1) x[n] e^(-j n Omega) |^2 ] $

It can be shown that

$ "E"[hat(S)_x (e^(j Omega))] = sum_(k=-(N-1))^(N-1) (1 - |k|/N) gamma_x[k] e^(-j k Omega) $

This is the DTFT of the autocovariance function multiplied by a triangular window $w_B [k]$ (Bartlett window).

$ "E"[hat(S)_x (e^(j Omega))] = 1/(2pi) S_x (e^(j Omega)) convolve.o W_B(e^(j Omega)) $

#note_bx(title: "Asymptotically Unbiased Estimator", [
  $W_B (e^(j Omega))$ is the DTFT of the Bartlett window, and it is a squared sinc function.
  Its main lobe width is proportional to $1/N$.
  When $N arrow infinity$, $W_B(e^(j Omega)) arrow 2pi delta(Omega)$

  Therefore, the estimator is *asymptotically unbiased*:

  $ lim_(N arrow infinity) "E"[hat(S)_x (e^(j Omega))] = S_x(e^(j Omega)) $

  For finite $N$, the periodogram is a biased estimator. The true PSD is smoothed by the Bartlett window, reducing the spectral resolution.
])

*Periodogram Variance*: For a Gaussian white noise, it can be shown that $"var"(hat(S)_x(e^(j Omega))) approx S_x^2(e^(j Omega))$. The variance *does not decrease* when $N$ increases! The periodogram is NOT a consistent estimator.

===== Methods for Improved PSD Estimation
- *Solution 1: Bartlett method*
  - Split the $N$ samples into $K$ non-overlapping segments of length $L = N/K$.
  - Compute the periodogram for each segment.
  - Average the $K$ periodograms.
  - The variance is divided by $K$, but the resolution is reduced by $K$ (since length is $L=N/K$).

- *Solution 2: Welch method*
  - Similar to Bartlett, but segments *overlap* (e.g., 50%).
  - Apply a window $w[n]$ (e.g., Hamming) to each segment before computing the periodogram to reduce leakage.
  - Averaging overlapping, windowed periodograms.
  - Better trade-off between variance reduction and spectral resolution.

- *Solution 3: Blackman-Tukey method*
  - Based on the definition of the PSD.
  - First, estimate the autocovariance sequence $hat(gamma)_x [k]$ from the data.
  - Multiply $hat(gamma)_x [k]$ by a window $w_c[k]$ of length $2M-1$ (with $M < N$).
  - Compute the DTFT of the windowed autocovariance.
  - This is equivalent to *smoothing* the periodogram:

    $ hat(S)_(B T) (e^(j Omega)) = 1/(2pi) hat(S)_x (e^(j Omega)) convolve.o W_c (e^(j Omega)) $

#table(
  columns: 5,
  align: center + horizon,
  [*Signal type*], [*Temporal sequence*], [*Theoretical continuous spectrum*], [*Windowed continuous spectrum* (size $N$)], [*DFT spectrum* ($N$ pts)],
  [Finite energy signal], [$x[n]$], [$X(e^(j Omega))$], [$X_w(e^(j Omega)) = 1/(2pi) X(e^(j Omega)) convolve.o W_N(e^(j Omega))$], [$X[k] = X_w(e^(j 2pi k / N))$],
  [Finite duration signal \ ($L <= N$)], [$x[n]$ \ ($L$ samples)], [$X(e^(j Omega))$], [$= X(e^(j Omega))$], [$X[k] = X(e^(j 2pi k / N))$],
  [Periodic signal \ (period $N_0 = N$)], [$tilde(x)[n]$], [$2pi sum_k X[k] delta(Omega - 2pi k / N_0)$], [$sum_k X[k] W_N(e^(j (Omega - 2pi k / N_0)))$], [$N_0 X[k]$]
)

==== Infinite Length
#todo_block(exp: "Must add the details form slide 66 onwards, from what i wrote on the side, as they give additional detail and explanations.")
Prior to applying the Discrete Fourier Transform (DFT), infinite duration signals must be *truncated by multiplication with a window function* $w[n]$, yielding $y[n] = x[n]w[n]$. In the frequency domain, this is equivalent to *convoluting the original spectrum with the window's spectrum*:
$ Y(e^(j 2 pi k / N)) = 1/(2 pi) integral_(2 pi) X(e^(j Omega)) W(e^(j (2 pi k / N - Omega))) d Omega $
To minimize spectral distortion, $W(e^(j Omega))$ should ideally *approach a Dirac delta*.

To properly compare different windows, they are normalized such that the *sample at their center of gravity equals 1* ($w[(N-1)/2] = 1$). This ensures the area below the real part of the spectrum curve is exactly $ 1/(2 pi) integral_(2 pi) W_r (e^(j Omega)) d Omega = 1 $

The most basic truncation uses a *rectangular window*, defined as $w[n] = 1$ for $n = 0, ..., N-1$. While simple, it has a *wide main lobe* (width of $2/N$) that broadens transitions, and high secondary lobes that cause *significant spectral leakage*. Its main-to-secondary lobe ratio is approximately 13 dB.
#block()

Windows with a *smoother temporal decay* provide *better secondary lobe attenuation*. For instance, the *triangular window* has a main peak width of $4/N$ and a lobe ratio of $-24$ dB. Similarly, the *cosine window* has a width of $3/N$ and a ratio of $-24$ dB (for $N=9$).
#block()
Even greater sidelobe reduction is achieved with the *generalized cosine, or Blackman family*, defined by $w[n] = a_0 + sum_(l=1)^L (-1)^l 2a_l cos((2 pi n l)/(N-1))$. This family includes:
- The *Hanning* window ($L=1, a_0=0.5, 2a_1=0.5$) with a peak width of $4/N$ and a $-32$ dB lobe ratio.
  - Good sidelobe attenuation, but wider main lobe reduces frequency resolution.
- The *Hamming* window ($L=1, a_0=0.54, 2a_1=0.46$) with a peak width of $4/N$ and its first lobe at $-90$ dB.
  - Better peak sidelobe attenuation, but slower high-frequency decay than the Hanning window.
- The *Blackman* window ($L=2, a_0=0.42, 2a_1=0.5, 2a_2=0.08$) with a peak width of $6/N$ and its first lobe at $-59$ dB.
  - Superior sidelobe attenuation, but wider main lobe reduces the frequency resolution.

#note_bx[
  The reduction of sidelobes to mitigate leakage inherently requires *enlarging the main lobe*. However, the resulting *loss in frequency resolution* due to the wider main lobe can be effectively compensated by *increasing the total length $N$* of the window.
]

=== Properties of Fourier Transforms
==== Link with the z-transform
From the definition of the *discrete-time Fourier transform (DTFT)*:
$ X(e^(j Omega)) = sum_(n=-infinity)^infinity x[n] e^(-j Omega n) quad stretch(->)^"Z-transform"_(z=e^(j Omega)) quad X(z) = sum_(n=-infinity)^infinity x[n] z^(-n) $

As $z$ is a complex variable, $z = e^(j Omega)$ corresponds to the *unit circle*. Hence, evaluating the z-transform on the unit circle provides the DTFT of the signal:
$ X(e^(j Omega)) = X(z) |_(z=e^(j Omega)) $

Moreover, from the definition of the *spectrum of a sampled continuous-time signal* (in [rad/s]):
$ X_s(j omega) = sum_(n=-infinity)^infinity x(n T_s) e^(-j omega n T_s) $
it appears that the associated DTFT spectrum (in [rad]) is linked to the former through:
$ X(e^(j Omega)) = X_s (j omega) |_(omega = Omega/T_s) $
if $x[n] = x(n T_s)$. This relation is *_valid for any continuous-time signal_*.

#note_bx([
  Actually, there is a *one-to-one mapping* between the Laplace continuous-time complex variable $s$ and the discrete-time complex variable $z$ given by:
  $z = e^(s T_s)$
  Then:
  $X(z) = X_s (s) |_(s = 1/T_s ln(z))$

  For $s=j omega$, we find $z=e^(j omega T_s) = e^(j Omega)$ (unit circle), as $X(e^(j Omega))$ is *periodic* in $Omega$.
])

For a finite-duration signal of length $N$, the Z-transform can be expressed directly in terms of its discrete frequency samples $X(e^(j Omega_k))$ by substituting the IDFT into the Z-transform definition:
$
X(z) &= sum_(n=0)^(N-1) x[n] z^(-n) = sum_(n=0)^(N-1) [ 1/N sum_(k=0)^(N-1) X(e^(j Omega_k)) e^(j 2 pi n k / N) ] z^(-n) \
     &= 1/N sum_(k=0)^(N-1) X(e^(j Omega_k)) sum_(n=0)^(N-1) (e^(j 2 pi k / N) z^(-1))^n \
     &= 1/N sum_(k=0)^(N-1) X(e^(j Omega_k)) (1 - z^(-N)) / (1 - e^(j 2 pi k / N) z^(-1))
$
This result demonstrates that the continuous Z-transform of a finite sequence can be obtained by *interpolating* its discrete DFT samples in the complex $z$-plane.

==== Link with the Fourier Transform
By evaluating the previous result on the unit circle ($z = e^(j Omega)$), we obtain:
$
  X(e^(j Omega)) &= 1/N sum_(k=0)^(N-1) X(e^(j Omega_k)) (1 - e^(-j N Omega)) / (1 - e^(j 2 pi k / N) e^(-j Omega)) \
                 &= 1/N sum_(k=0)^(N-1) X(e^(j Omega_k)) (e^(-j N Omega / 2)) / (e^(-j (Omega / 2 - (pi k) / N))) (sin(N Omega / 2)) / (sin(Omega / 2 - (pi k) / N)) \
                 &= 1/N sum_(k=0)^(N-1) X(e^(j Omega_k)) e^(-j ( (N-1) Omega / 2 - (pi k) / N ) ) (sin(N Omega / 2)) / (sin(Omega / 2 - (pi k) / N))
$

#note_bx([
  This equation represents *interpolation in the frequency domain*.
])
==== Properties
#table(
  columns: (0.7fr, 1fr, 1fr),
  align: center + horizon,
  inset: 0.5em,
  stroke: 0.5pt + luma(150),
  [*Non Periodic Signals*], [
    Continuous time signals (FT)\
    $z(t)=a x(t) + b y(t)$\
    $Z(j omega) = a X(j omega) + b Y(j omega)$
  ], [
    Discrete time signals (DTFT)\
    $z[n] = a x[n] + b y [n]$\
    $Z(e^(j Omega)) = a X(e^(j Omega)) + b Y(e^(j Omega))$
  ],
  [*Periodic signals with same period*], [
    Continuous Time signals (FS)\
    $z(t)=a x(t) + b y(t)$\
    $Z[k]=a X[k] + b Y[k]$
  ], [
    Discrete Time signals (DTFS)\
    $z[n] = a x[n] + b y [n]$\
    $Z[k]=a X[k] + b Y[k]$
  ]
)
#let eq_size = 0.9em
#figure(
  caption: [Summary of properties for Non-periodic signals (FT and DTFT)],
  [
    #show math.equation: set text(size: eq_size)
    #pad(x: -4em, table(
      columns: (0.7fr, 1fr, 1.3fr, 1fr, 1.2fr),
      inset: 0.5em,
      stroke: 0.5pt + luma(150),
      align: center + horizon,

      // Header Rows
      table.cell(colspan: 5)[*Non periodic signals*],
      [*Properties*], table.cell(colspan: 2)[*Continuous time signals (FT)*], table.cell(colspan: 2)[*Discrete time signals (DTFT)*],

      // Body Rows
      [convolution],
      [$integral_(-infinity)^infinity h(tau) x(t-tau) dif tau$], [$H(j omega) X(j omega)$],
      [$sum_(n=-infinity)^infinity h[n] x[m-n]$], [$H(e^(j Omega)) X(e^(j Omega))$],

      [derivation],
      [$dif / (dif t) x(t)$], [$j omega X(j omega)$],
      [], [],

      [integration],
      [$integral_(-infinity)^t x(tau) dif tau$], [$1/(j omega) X(j omega) + pi X(j 0) delta(omega)$],
      [], [],

      [time shift],
      [$x(t - t_0)$], [$e^(-j omega t_0) X(j omega)$],
      [$x[n - n_0]$], [$e^(-j Omega n_0) X(e^(j Omega))$],

      [frequency shift],
      [$X[j(omega - nu)]$], [$e^(j nu t) x(t)$],
      [$X(e^(j(Omega - Omega_0)))$], [$e^(j Omega_0 n) x[n]$],

      [product],
      [$x(t) times y(t)$], [$1/(2 pi) integral_(-infinity)^infinity X(j eta) Y(j(omega - eta)) dif eta$],
      [$x[n] times y[n]$], [$1/(2 pi) integral_(2 pi) X(e^(j Omega)) Y(e^(j(Theta - Omega))) dif Omega$],

      [scale modification],
      [$x(a t)$], [$1/(|a|) X(j omega / a)$],
      [], [],

      [Parseval],
      [$integral_(-infinity)^infinity |x(t)|^2 dif t$], [$1/(2 pi) integral_(-infinity)^infinity |X(j omega)|^2 dif omega$],
      [$sum_(n=-infinity)^infinity |x[n]|^2$], [$1/(2 pi) integral_(2 pi) |X(e^(j Omega))|^2 dif Omega$],
    ))
  ]
)

#figure(
  caption: [Summary of properties for Periodic signals (FS and DTFS)],
  pad(x: -4em, table(
    columns: (0.6fr, 1fr, 1.1fr, 1fr, 1fr),
    inset: 0.5em,
    stroke: 0.5pt + luma(150),
    align: center + horizon,

    // Header Rows
    table.cell(colspan: 5)[*Periodic signals*],
    [], table.cell(colspan: 2)[*Continuous time signals with period $T$ (FS)*], table.cell(colspan: 2)[*Discrete time signals with period $N$ (DTFS)*],

    // Body Rows
    [convolution],
    [$integral_0^T h(tau) x(t-tau) dif tau$], [$T H[k] X[k]$],
    [$sum_(n=0)^(N-1) h[n] x[m-n]$], [$N H[k] X[k]$],

    [time shift],
    [$x(t - t_0)$], [$e^(-j k omega_0 t_0) X[k]$],
    [$x[n - n_0]$], [$e^(-j k Omega_0 n_0) X[k]$],

    [frequency shift],
    [$X[k - k_0]$ ($k_0$ integer)], [$e^(j k_0 omega_0 t) x(t)$],
    [$X[k - k_0]$ ($k_0$ entier)], [$e^(j n k_0 Omega_0) x[n]$],

    [product],
    [$x(t) times y(t)$], [$sum_(k'=-infinity)^infinity X[k'] Y[k-k']$],
    [$x[n] times y[n]$], [$sum_(k'=0)^(N-1) X[k'] Y[k-k']$],

    [Parseval],
    [$integral_0^T |x(t)|^2 dif t$], [$T sum_(k=-infinity)^infinity |X[k]|^2$],
    [$sum_(n=0)^(N-1) |x[n]|^2$], [$N sum_(k=0)^(N-1) |X[k]|^2$],
  ))
)

#figure(
  caption: [Summary of the properties for the DFT],
  table(
    columns: (1fr, 1.5fr, 1.5fr),
    inset: 0.5em,
    stroke: 0.5pt + luma(150),
    align: (left, center, center),

    // Header Row
    [*Operation*], [*$x[n]$*], [*$X_"DFT"[k] = X(e^(j 2 pi k / N))$*],

    // Body Rows
    [Linear combination], [$alpha_1 x_1[n] + alpha_2 x_2[n]$], [$alpha_1 X_{1,"DFT"}[k] + alpha_2 X_{2,"DFT"}[k]$],
    [Time reversal], [$x[-n]$], [$X_"DFT"[-k]$],
    [Complex conjugation], [$x^*[n]$], [$X_"DFT"^*[-k]$],
    [Shift], [$x[n - n_0]$ ($n_0$ entier)], [$e^(-j 2 pi k n_0 / N) X_"DFT"[k]$],
    [Modulation], [$e^(j 2 pi j k_0 / N) x[n]$ ($k_0$ entier)], [$X_"DFT"[k - k_0]$],
    [Cyclic convolution], [$sum_(m=0)^(N-1) x[n] y[n - m]$], [$X_"DFT"[k] times Y_"DFT"[k]$],
    [Multiplication], [$x[n] y[n]$], [$1/N sum_(k=0)^(N-1) X_"DFT"[k] Y_"DFT"[n - k]$],
    [Parseval], [$sum_(n=0)^(N-1) |x[n]|^2$], [$1/N sum_(k=0)^(N-1) |X_"DFT"[k]|^2$],
  )
)

#note_bx([
  *Fourier Transforms in Practice:*
    - *DTFT* is mostly theoretical.
    - *DFT* is practical thanks to the *Fast Fourier Transform (FFT)*, which reduces complexity from $cal(O)(N^2)$ to $cal(O)(N log_2 N)$.
    - Thanks to this efficiency, FFT is the standard for implementing:
      - *Convolutions* (via FFT/IFFT).
      - *Multirate operations* like decimation and upsampling.
    - FFT is foundational across DSP applications, including audio, video, radar, and telecommunications.
])

=== Zero Padding
There are 2 effects of zero padding:
- *Zero paddin in time* corresponds to *interpolation in the frequency domain*.
- *Zero padding in frequency* corresponds to *interpolation in the time domain*.

#todo_block(exp: "Add figure of what happens when you append zeros at the end of the spectrum. And how that spetrum folds on itself to form a interpolation. And what indexes of the spectrum it actually corresponds to (slides 87)")

#figure(
  image("Images/interpolation_dft_structure_padding.jpg", width: 50%),
  caption: "Structure to achieve interpolation using zero padding in the DFT structure"
)
#warning_bx(title: "Interpolation DFT Structure index nuances",[
  When padding with zeros in the DFT structure, we can see that the zeros are inserted between $N/2 -1 " and " N/2$, but that point is actually the END of the positive spetrum, and it already is looping back. This is the representation that the numpy fft function uses !
])

Decimation can also be achieved through the transposition of the structure, where instead of inserting zeros in the middle of the spectrum, we are deleting the end samples (after $N/(2M)$). These zeros in the middle then *correspond to filtering*.

 #figure(
  image("Images/upconversion_dft_padding.jpg", width: 40%),
  caption: "Structure to achieve upconversion using zero padding in the DFT structure"
)
This results in the frequency domain as a modification of the temporal frequency, but no change of the $0->2pi$ support of the spectrum, which is the same as the original one, but with a different sampling (interpolation in frequency domain).\
This also means that the frequency shape is getting moved to a certain position in the spectrum, which is the same as the original one but with a different sampling (interpolation in frequency domain).

=== Convolution
#todo_block(exp: "Slides 93-105")
#theorem_bx(name: "Periodic Convolution with the DFT", [
  For two sequences $x[n]$ and $g[n]$ of length $N$, their *circular convolution* corresponding to the product of their spectrums, is defined as
  $ y[m] = x[n] times.o g[n] = sum_(n=0)^(N-1) x[n] g[m-n] $
  The convolution of a signal $x[n]$ of length $n_x$ and a signal $g[k]$ of length $n_g$ produces a signal of length :
$ n_y = n_x + n_g - 1 $
The DFT and IDFT deliver a *periodic convolution* of period $N$, *BUT we want a linear convolution* of *at least* length $n_y$. To achieve this, we can *zero pad* both signals to a length $N >= n_y$ before computing the DFT, multiplying in the frequency domain, and applying the IDFT. This process yields the desired linear convolution result *without aliasing*.

  (Convolution of non periodic signals is also possible with the DFT, but care has to be given.)
])

#theorem_bx(name: "Fast DFT/FFT convolution of massive signals", [
  When we require massive FFT's, we have to wait for the end. To avoid this, 2 methods *exploit linearity* to compute the convolution in a *block-wise* manner:
  - *Overlap-add method*: The input signal is split into overlapping blocks, each block is convolved with the impulse response, and the results are added together.
  #align(center, image("Images/overlap_add.jpg", width: 50%))


  - *Overlap-save method*: The input signal is split into overlapping blocks, each block is convolved with the impulse response, and only the valid part of the convolution is saved, discarding the overlapping parts that contain artifacts from the previous block's convolution.
  #align(center, image("Images/overlap_save.jpg", width: 50%))
  // Source : https://dsp.stackexchange.com/questions/90137/why-not-overlap-save-for-inverse-stft
])

=== Fast Fourier Transform (FFT Radix-2)
==== Butterfly Construction

The *butterfly* is the fundamental $2$-point operation at the heart of every FFT stage.
It takes two complex inputs $P$ and $Q$, applies a twiddle factor $W_N^r$, and produces two outputs.

#figure(
  image("Images/butterfly_diagram.png", width: 15%),
  caption: [Single butterfly operation @wikipedia_butterfly]
)

#definition_bx(name: "Butterfly Operation", [
  Given two complex values $P$ and $Q$ and a twiddle factor $W_N^r = e^(-2 pi j r \/ N)$,
  the radix-2 butterfly computes:

  $
  A &= P + W_N^r dot Q \
  B &= P - W_N^r dot Q
  $

  requiring exactly *1 complex multiplication* and *2 complex additions*.
])

#note_bx(title: "DIT vs DIF Butterfly", [
  The DIT and DIF butterflies are transposes of each other:
  - *DIT*: twiddle factor applied to $Q$ *before* the addition/subtraction
  - *DIF*: twiddle factor applied to the difference *after* the subtraction

  $
  "DIT:" quad A &= P + W_N^r Q, quad B = P - W_N^r Q \
  "DIF:" quad A &= P + Q, quad B = (P - Q) dot W_N^r
  $
])

#trick_bx(title: "Computational Cost", [
  For $N = 2^m$, the FFT performs $m = log_2 N$ stages, each containing $N\/2$ butterflies.
  Total cost:

  $
  underbrace(N/2 log_2 N, "complex multiplications") + underbrace(N log_2 N, "complex additions") = cal(O)(N log N)
  $

  compared to $cal(O)(N^2)$ for a naive DFT — for $N = 1024$ this is a *100x* speedup.
])

==== FFT - Radix-2 decimation in time algorithm - DIT ($x[n] -> X(Omega)$)
The decimation-in-time algorithm splits the *input* $x[n]$ into even and odd indexed samples, computing two $N\/2$-point DFTs and recombining.

#figure(
  image("Images/DIT_diagram_radix2_N8.jpg", width: 30%),
  caption: "DIT diagram for radix-2 N=8"
)

#theorem_bx(name: "FFT - Radix-2 decimation-in-time algorithm",[
  For $N=2^m$ the $N$-point DFT of a sequence $x[n]$ can be computed recursively by splitting $x[n]$ into even and odd subsequences
  $x_e [n]=x[2n]$, $x_o [n]=x[2n+1]$, computing their $(N\/2)$-point DFTs $E[k]$ and $O[k]$, and combining them as

  $
  X[k] &= E[k] + W_N^k thin O[k], \
  X[k + N/2] &= E[k] - W_N^k thin O[k], quad k = 0, dots, N/2 - 1,
  $

  with $W_N = e^(-2 pi j \/ N)$. Applying this decomposition recursively for $m$ stages yields the radix-2 DIT FFT with complexity $O(N log N)$.

  #proof_bx([
  From the definition of the DFT
  $ X[k] = sum_(n=0)^(N-1) x[n] underbrace(e^(-2 pi j k n/N), W_N^(k n)) = sum_(n=0)^(N-1) x[n] underbrace(W_N^(k n), "twiddle\nfactor") $
  Separate it into even and odd indexed elements (one on two elements)
  $ X[k] &= sum_(n=0)^(N/2-1) x[2n] underbrace(e^(-2 pi j k ((2 n))/N), W_N^(2 k n)) + sum_(n=0)^(N/2-1) x[2n+1] underbrace(e^(-2 pi j k ((2 n + 1))/N), W_N^(k)W_N^(2 k n))\
    &= sum_(n=0)^(N/2-1) x[2n] W_N^(2 k n) + W_N^(k)sum_(n=0)^(N/2-1) x[2n+1]W_N^(2 k n)\
    & #box(width: 0.8em, $stretch(arrow.b, size: #400%)$) #block([#v(-2em) We can adjust the indices of the twiddle factor\ $e^(-2 pi j k ((2n))/N) = e^(-2 pi j k n 2/N) = W_(N/2)^(k n)$])\
    &= sum_(n=0)^(N/2-1) x[2n] W_(N/2)^(k n) + W_N^(k) sum_(n=0)^(N/2-1) x[2n+1]W_(N/2)^(k n)\
  $
  Now, we define a second half $X[k+N/2]$ the equations
  $
    X[k+N\/2] &= sum_(n=0)^(N/2-1) x[2n] W_(N/2)^((k+N/2) n) + W_N^(k+N/2) sum_(n=0)^(N/2-1) x[2n+1]W_(N/2)^((k+N/2) n)\
    &= sum_(n=0)^(N/2-1) x[2n] W_(N/2)^(k n) underbrace(W_(N/2)^(N/2 n), 1) + W_N^(k) underbrace(W_N^(N/2), -1) sum_(n=0)^(N/2-1) x[2n+1]W_(N/2)^(k n)underbrace(W_(N/2)^(N/2 n), 1)\
    & #box(width: 0.8em, $stretch(arrow.b, size: #400%)$) #block([#v(-2em) We can adjust the indices of the twiddle factor\ $W_(N/2)^(N/2 n) = e^(-2 pi j (N/2 n)/(N/2)) = e^(-2 pi j n) = 1$])\
    &= sum_(n=0)^(N/2-1) x[2n] W_(N/2)^(k n) - W_N^(k) sum_(n=0)^(N/2-1) x[2n+1]W_(N/2)^(k n)\
  $
  If we regroup it both :
  $
    X[k] &= sum_(n=0)^(N/2-1) x[2n] W_(N/2)^(k n) #box(fill: red.lighten(40%), inset: 3pt, radius: 5pt, $+$) W_N^(k) sum_(n=0)^(N/2-1) x[2n+1]W_(N/2)^(k n)\
    X[k+N\/2] &= sum_(n=0)^(N/2-1) x[2n] W_(N/2)^(k n) #box(fill: red.lighten(40%), inset: 3pt, radius: 5pt, $-$) W_N^(k) sum_(n=0)^(N/2-1) x[2n+1]W_(N/2)^(k n)\
  $
  And in a simplified form :
  $
    X[k]       &= G[k] + W_N^k H[k] \
    X[k+N\/2]  &= G[k] - W_N^k H[k]
  $
  From here, you can do it recursively !

  ])
])

==== FFT - Radix-2 decimation in frequency algorithm - DIF ($x[n] -> X(Omega)$)

The decimation-in-frequency algorithm splits the *output* $X[k]$ into even and odd indexed bins, by splitting $x[n]$ into its *first half* and *second half*.

#figure(
  image("Images/DIF_diagram_radix2_N8.jpg", width: 30%),
  caption: "DIT diagram for radix-2 N=8"
)

#theorem_bx(name: "FFT - Radix-2 decimation-in-frequency algorithm", [
  For $N=2^m$ the radix-2 DIF FFT splits the *output* into even and odd indexed samples.
  The $N$-point DFT $X[k]$ is computed by first combining the input halves as

  $
  x_1[n] &= x[n] + x[n + N\/2], \
  x_2[n] &= lr((x[n] - x[n + N\/2])) dot W_N^n, quad n = 0, dots, N\/2 - 1,
  $

  then computing the $(N\/2)$-point DFTs of $x_1[n]$ and $x_2[n]$ to yield the even-indexed outputs
  $X[2k]$ and odd-indexed outputs $X[2k+1]$ respectively, with $W_N = e^(-2 pi j \/ N)$.
  Applying this decomposition recursively for $m$ stages yields the radix-2 DIF FFT with complexity $O(N log N)$.

  The butterfly operation at each stage is

  $
  A &= P + Q, \
  B &= (P - Q) dot W_N^r,
  $

  where $P$ and $Q$ are inputs and $W_N^r$ is the twiddle factor for stage $r$.

  #note_bx(title: "Idea", [
    Instead of separating $x[n]$ by even/odd index (DIT), we separate $X[k]$ into
    even bins $X[2k]$ and odd bins $X[2k+1]$, by splitting $x[n]$ into its *first*
    and *second half*.
  ])

  #proof_bx([
    From the definition of the DFT:
    $
      X[k] = sum_(n=0)^(N-1) x[n] W_N^(k n)
    $

    *Even bins — split the sum at $N\/2$:*
    $
      X[2k]
        &= sum_(n=0)^(N\/2-1) x[n] W_N^(2k n)
         + sum_(n=0)^(N\/2-1) x[n + N\/2] W_N^(2k(n + N\/2)) \
        &= sum_(n=0)^(N\/2-1) x[n] W_N^(2k n)
         + sum_(n=0)^(N\/2-1) x[n + N\/2] W_N^(2k n) underbrace(W_N^(k N), 1) \
        & #box(width: 0.8em, $stretch(arrow.b, size: #400%)$)
          #block([#v(-2em) $W_N^(k N) = e^(-j 2 pi k N \/ N) = e^(-j 2 pi k) = 1$]) \
        &= sum_(n=0)^(N\/2-1) (x[n] + x[n + N\/2]) W_N^(2k n) \
        & #box(width: 0.8em, $stretch(arrow.b, size: #400%)$)
          #block([#v(-2em) Adjust indices: $W_N^(2k n) = e^(-j 2 pi k n \/ (N\/2)) = W_(N\/2)^(k n)$]) \
        &= sum_(n=0)^(N\/2-1) (x[n] + x[n + N\/2]) W_(N\/2)^(k n)
    $

    *Odd bins — same split for $X[2k+1]$:*
    $
      X[2k+1]
        &= sum_(n=0)^(N\/2-1) x[n] W_N^((2k+1) n)
         + sum_(n=0)^(N\/2-1) x[n + N\/2] W_N^((2k+1)(n + N\/2)) \
        &= sum_(n=0)^(N\/2-1) x[n] W_N^((2k+1) n)
         + sum_(n=0)^(N\/2-1) x[n + N\/2] W_N^((2k+1) n) underbrace(W_N^((2k+1) N\/2), -1) \
        & #box(width: 0.8em, $stretch(arrow.b, size: #400%)$)
          #block([#v(-2em) $W_N^((2k+1) N\/2) = e^(-j pi (2k+1)) = -1$ for all integer $k$]) \
        &= sum_(n=0)^(N\/2-1) (x[n] - x[n + N\/2]) W_N^((2k+1) n) \
        & #box(width: 0.8em, $stretch(arrow.b, size: #400%)$)
          #block([#v(-2em) Factor: $W_N^((2k+1) n) = W_N^n dot W_N^(2k n) = W_N^n dot W_(N\/2)^(k n)$]) \
        &= sum_(n=0)^(N\/2-1) (x[n] - x[n + N\/2]) underbrace(W_N^n, "twiddle factor") W_(N\/2)^(k n)
    $

    Regrouping both results:
    $
      X[2k] &= sum_(n=0)^(N\/2-1) (x[n] + x[n + N\/2]) W_(N\/2)^(k n) \
      X[2k+1] &= sum_(n=0)^(N\/2-1) (x[n] - x[n + N\/2]) underbrace(W_N^n, "twiddle factor") W_(N\/2)^(k n)
    $

    From here, apply the same decomposition recursively!
  ])
])

#trick_bx(title: "DIT vs DIF", [
  - *Decimation-in-Time (DIT)*: splits $x[n]$ into *even/odd indexed samples* $->$ acts on the *input*
  - *Decimation-in-Frequency (DIF)*: splits $x[n]$ into *first/second half* $->$ separates *even/odd output bins*
  - Both give the same $cal(O)(N log N)$ complexity. The DIF butterfly is the *transpose* of the DIT butterfly.
])

#extra_bx(title: "FFT Variants", [
  - *Radix-4*: splits into 4 subsequences (indices mod 4), more efficient for $N=4^m$.
  - *Mixed-Radix*: handles composite $N$ by splitting into factors (e.g., $N=12$ as $3 x 4$).
  - *Split-Radix*: combines radix-2 and radix-4 for optimal efficiency.
  - *Prime Factor*: uses the Chinese Remainder Theorem for coprime factors.
])

#extra_bx(title: "Origins", [
  The
  #link("https://en.wikipedia.org/wiki/Cinfinityley%E2%80%93Tukey_FFT_algorithm")[Cinfinityley--Tukey algorithm]
  is the most widely used
  #link("https://en.wikipedia.org/wiki/Fast_Fourier_transform")[FFT algorithm],
  reducing the computational cost of a
  #link("https://en.wikipedia.org/wiki/Discrete_Fourier_transform")[Discrete Fourier Transform]
  from $O(N^2)$ to $O(N log N)$ by recursively breaking it down into smaller DFTs.
  Though it bears the names of
  #link("https://en.wikipedia.org/wiki/James_Cinfinityley")[James Cinfinityley]
  of IBM and
  #link("https://en.wikipedia.org/wiki/John_Tukey")[John Tukey]
  of Princeton : who published their influential paper in 1965 : the algorithm was
  actually first conceived around 1805 by
  #link("https://en.wikipedia.org/wiki/Carl_Friedrich_Gauss")[Carl Friedrich Gauss],
  who used it to interpolate the trajectories of asteroids, though his work went largely
  unrecognized for over a century. The origin of the 1965 rediscovery has a fascinating
  backstory: Tukey reportedly devised it during a meeting of President Kennedy's Science
  Advisory Committee, where the need arose to detect Soviet nuclear tests using seismometer
  data : a problem that demanded fast DFT computation across many sensors over long time
  periods. The algorithm works by splitting a size-$N$ DFT into two interleaved DFTs of
  size $N\/2$, combining their results through a simple
  #link("https://en.wikipedia.org/wiki/Butterfly_diagram")[butterfly operation],
  and applying this decomposition recursively : a classic
  #link("https://en.wikipedia.org/wiki/Divide-and-conquer_algorithm")[divide-and-conquer]
  approach.
])

== Discrete-Time Filters
#pad(x:-4em,definition_bx(name: "IIR vs FIR",[
  #set par(justify: false)
  #v(-1em)
  #table(
    columns: (0.35fr, 1fr, 1fr),
    align: (x, y) => if x == 0 or y ==0 {center + horizon} else {left},
    inset: 0.5em,
    stroke: 0.5pt + luma(150),
    [/], [*FIR*], [*IIR*],
    [*Advantages*], table.cell(fill: color.green.lighten(80%))[
      - *Unconditional stability* (poles at the origin)
      - *Precise* over phase response
      - Can have exactly *linear phase* (constant group delay)
        - Like a shift, *non-distorting/dispersive*
      - *Optimal algorithms* for design (Parks-McClellan, windowing)
      - *Robust* for finite precision implementations
    ], table.cell(fill: color.green.lighten(80%))[
      - *Lower computational cost* (fewer coefficients for same specs)
      - *Shorter input-output delay* (due to fewer coefficients)
      - *Compact implementations* (IIR can achieve sharp filters with few coefficients)
    ],
    [*Disadvantages*], table.cell(fill: color.red.lighten(80%))[
      - *Longer input-output delay* (due to more coefficients)
      - *Higher computational cost* (more multiplications/additions)
    ], table.cell(fill: color.red.lighten(80%))[
      - Can be *unstable* (poles outside unit circle)
      - *Non-linear phase response* (phase distortion)
      - *More complex design methods* (e.g., bilinear transform, impulse invariance)
      - *Sensitive to coefficient quantization* (finite precision issues)
    ]
  )
]))
#definition_bx(name: "Filter Specifications and Tradeoffs", [
  As the frequency response of real valued filters is symetric, we only need to look at $[0,pi]$
  #figure(
    image("Images/filter_specifications.jpg", width: 50%),
    caption: "Filter specifications on the spectrum"
  )
  - 3 bandwidths:
    - *Passband bandwidth* (width of the passband)
    - *Stopband bandwidth* (width of the stopband)
    - *Transition bandwidth* (width of the transition from passband to stopband)
  - 3 ripple tolerances:
    - *Passband ripple* (maximum allowed variation in the passband)
    - *Stopband attenuation* (minimum required attenuation in the stopband)
    - *Generic tolerance* (overall tolerance for the filter design, in +- the passband and stopband)

])
=== Causality and Stability
=== Filter Templates (Specifications)
=== Design of FIR Filters (Finite Impulse Response)
==== Filters With Linear Phase (4 Types)
==== Properties of Linear Phase Filters
==== Design methods of Linear Phase Filters

=== Design of IIR Filters (Infinite Impulse Response)
#note_bx([
  *FIR vs IIR Comparison*:
  - *IIR*: More efficient (fewer coefficients for same specs), but *cannot have exactly linear phase* and can be *unstable*
  - *FIR*: Can have *exactly linear phase* (constant group delay), always *stable*, but require more coefficients

  Linear phase is crucial for applications where signal shape preservation matters (audio, communications).
])





= Part 2 : Nonlinear Systems and Filters (Prof. ? & Prof. ?)
== Linear Bayesian Filters (Kalman Filters)
== Nonlinear Bayesian Filters (Particle Filters)
== Wavelet Theory (Local in Time/Space & Frequency)
== Compressed Sensing



= Exam Prep
== All Definitions
#auto_box_fetcher("Definition")
== All theorems
#auto_box_fetcher("Theorem")


#bibliography("bibliography.bib", full: true, style: "ieee")
