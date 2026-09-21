---
name: typst-large
description: High-detail Typst (0.13) skill for high-context models. Full syntax, scripting, types, math deep-dive, layout, styling, introspection, packages, CLI, error catalog, version notes.
---

# Typst — Detailed Skill (Typst 0.13)

All snippets verified against the typst 0.13.1 compiler. Package versions verified against typst.app/universe on 2026-08-08. Version deltas for 0.14/0.15 are noted inline.

## 0. Mental model

**Three modes**: markup (default) → `#` enters **code**, `$..$` enters **math**, `[..]` = **content block** (parsed markup usable in code; no `#` needed inside). All output is *content*: a tree of elements with fields. Strings are plain data, never parsed.

**Strings vs content**: `"..."` renders literally; `[...]` parses. `#box("Super text $A!=B$")` prints `$A!=B$` as text (verified via `repr`); `#box([Super text $A!=B$])` renders the equation. Where content is expected, strings/`none` coerce (rendered literally). Content joins: `[a] + [b]`, `3 * [a]` repeats, `none` joins as nothing.

**Typst ≠ LaTeX ≠ Markdown**: the only LaTeX habit that works is `$...$`. `\frac`, `\textbf`, `\section{}`, `%` comments, `**bold**`, `# heading`, `<br>` never error — they silently render as literal text or garbage (control escapes like `\f` = form-feed, `\t` = tab). `*text*` = strong (bold), `_text_` = emph (italic) — swapped vs Markdown.

## 1. Markup syntax

| Element | Syntax | Element fn |
|---|---|---|
| paragraph break | blank line | `parbreak` |
| line break | `\` + space or EOL (backslash escape) | `linebreak` |
| strong (bold) | `*text*` (word boundaries only) | `strong` |
| emph (italic) | `_text_` (word boundaries only) | `emph` |
| heading | `= H1` `== H2` `=== H3` | `heading(level: n)` |
| bullet list | `- item` (indent 2 to nest; blank line = loose list) | `list` |
| numbered list | `+ item` | `enum` |
| term list | `/ Term: description` | `terms` |
| raw code | `` `code` `` / ```lang fences | `raw` |
| link | bare `https://…` auto-links; `#link("url")[text]` | `link` |
| label / ref | `<intro>` / `@intro` | `label` / `ref` |
| math | `$x^2$` | `math.equation` |
| smartquote | `'single'` `"double"` | `smartquote` |
| symbol shorthand | `~` nbsp, `---` em dash, `--` en dash, `...` ellipsis | `sym` |
| comment | `// line` / `/* block */` (all modes) | — |

**Escapes**: `\$ \# \* \_ \= \- \+ \~ \; \ ` `\\` → literal char; `\u{1f600}` → codepoint; `\` + newline = linebreak. **`\\` is NOT a newline — it renders a literal backslash** (common LaTeX/Markdown confusion).

**Identifiers**: letters, digits, `-`, `_`; start with letter or `_`; kebab-case convention (`top-edge`).

Mistakes: `\\` = literal `\`; `\frac`/`\textbf`/`\emph`/`\section{}`/`\begin{...}` = silent garbage (`\f`/`\t`/`\b` are control-character escapes — they silently eat surrounding text); `**bold**` = warning "no text within stars" + literal; `# heading` = error `expected expression` (`#` is code mode); `## heading` = literal text; `<br>`/`<b>`/HTML = literal text (no HTML parser); `% comment` doesn't work; `-item` (no space) = literal; list markers must start the line.

## 2. Scripting

```typst
#let x = 5                      // binding; kebab-case
#(1 + 2)                        // parenthesize compound expressions
#let (a, b) = (1, 2)            // destructuring: arrays, dicts, rest (a, .., last)
#let (key: v) = (key: "val")    // dict destructure
#let f(a, b: 1, ..rest) = ...   // positional, named (needs default), sink
#f(1, b: 2)                     // named order-free; #f(1, 2) → "unexpected argument"
#box[content] ≡ #box([content]) ≡ #box(body: [content])
#if c [..] else if d {..} else [..]   // expression, yields a value
#for x in (1, 2, 3) [..]        // arrays, strings, dicts, ranges; for (k, v) in dict
#while cond { ..; none }        // blocks join values → end side-effect loops with none
#break #continue #return        // in loops / functions
```

**Code blocks** `{ ... }`: statements separated by `;` or newlines; the block **joins** statement values (bindings yield `none`, joining as nothing). The last statement's value is the block's value.

**Operators** (precedence high→low): unary `- +`, `* /`, `+ -`, comparisons (`== != < <= > >= in not in`), `not`, `and`, `or`, assignment (`= += -= *= /=`). There is NO `%` (use `calc.rem`/`calc.euclid`), NO `&&`/`||` (use `and`/`or`), NO `!` (use `not`), NO `**` (use `calc.pow`), NO `//` floor-division (use `calc.quo`). No ternary `?:` — use `if`.

**Modules**: `#import "x.typ": a, b as c` / `: *` / `as mod`; `#include "x.typ"` (evaluates to content). `.typ` extension required. Imported definitions are usable before the import in code blocks? No — imports follow source order like everything else.

Mistakes:
- `let x = 5` in markup (no `#`) → literal text. `#` is needed once per expression in markup.
- `#let x = 5; x + 1` → renders "x + 1" as text (the `;` ends the code expression). Use `#(x + 1)` or `#{ let x = 5; x + 1 }`.
- `#while i < 3 { i += 1 }` on the same line as a preceding `#let` → parse error; separate with newlines.
- Loop bodies yielding ints → `cannot join integer with integer`; end with `none` or produce content.
- No hoisting: `unknown variable` if used before definition; block-scoped (`#let` inside `{}` is invisible outside).
- Reassignment: `x = 2` works on existing bindings; `=` never declares.

## 3. Functions

- Named: `#let f(a, b: 1, ..rest) = body`; lambda: `#let f = (a, b) => a + b` (parens optional for one param).
- Body = any expression or block; `#return` early-exits. Recursion works; closures capture the enclosing scope; functions are pure (no shared state — use `state` for document state).
- **Arguments**: named args require declared defaults and are callable only by name (`#f(1, b: 2)`); `..args` is the **arguments** type — `args.pos()` / `args.named()`, not an array.
- **Spreading**: `#f(..arr)` (array → positional); `#f(..dict)` (dict → named); re-pass a sink: `#f(..args)`.
- **Trailing content blocks**: `#list[A][B]` passes two content blocks; `#box[A]` drops empty parens.
- **Partial application**: `f.with(b: 5)` → new function (show rules, templates). `f.where(field: v)` → selector.
- **Method form**: `arr.push(1)` — `array.push(arr, 1)` errors (`cannot mutate a constant: array`).
- **Evaluating vs referencing**: `#f` inserts the function value (renders as repr); `#f()` calls it. Pass bare `f` when a callback is wanted.
- Element functions create output and support `set`/`show`; `content.func()` returns the element function of content.

Mistakes: passing `#f` where a call was intended; `#show heading: heading` (re-emitting) → infinite show recursion — transform fields instead (`it => block[#it.body]`); default params are named-only; `sum(..nums)` fails with `type arguments has no method sum`.

## 4. Types & argument expectations

| Type | Literal / construction | Notes |
|---|---|---|
| int | `10`, `0xff`, `0b101` | |
| float | `3.14`, `1e5` | |
| bool | `true`, `false` | |
| none | `none` | absence; joins as nothing |
| auto | `auto` | "compute a default" — distinct from none! |
| str | `"..."` | escapes `\" \\ \n \t \u{..}` |
| content | `[...]` | parsed markup |
| array | `(1, 2, 3)` | `range(3)` = `(0,1,2)`; no `+` — spread `(..a, ..b)` |
| dictionary | `(a: 1, b: 2)` | `.keys() .values() .pairs()` |
| length | `10pt 2cm 5mm 1in 1em 1ex` | pt/cm/mm/in absolute; em/ex relative |
| ratio | `50%` | of container |
| fraction | `1fr` | grid/table/stack/flex only |
| angle | `90deg`, `1rad` | |
| color | `red rgb("#0178A4") rgb(1,2,3) luma(50) cmyk(...)` | |
| gradient | `gradient.linear(red, blue, angle: 45deg)` `.radial` `.conic` | |
| symbol | `sym.arrow.r`, `emoji.face` | |
| stroke | `1pt`, `red`, `(thickness: 2pt, paint: blue, dash: "dashed")` | |
| alignment | `left center top + right horizon` | |
| datetime | `datetime(year: 2026, month: 8, day: 8)` | `datetime.today()` |
| duration | `duration(hours: 1, minutes: 30)` | **no literal syntax** (`1h` errors) |
| version | `version(0, 13, 0)` | |
| regex | `regex("\w+")` | |
| bytes | `bytes("...")` | |

**What common args expect** (all verified): `text(fill:)` → color/gradient (string → error); `box(width:)`/`height:` → length/ratio/auto/fraction (`10` → error; `50%` ✅; `1fr` ✅ in flex); `box(inset:)`/`block(inset:)` → length or dict `(x:, y:)`; `pad` takes `x:/y:/rest:` (no `inset:`); `page(margin:)` → length or dict `(x:, y:)` or `(top:, right:, bottom:, left:)`; `rect(fill:)` → paint, `stroke:` → stroke; `set text(font:)` → string or array of strings; `grid(columns:)` → array of length/fraction/auto or int; `place(alignment)`; `counter(key)` → element fn/str/int/label; `query(selector)` → label/element fn/str.

Type mistakes: `#box(width: 10)` → "expected auto, relative length, or fraction, found integer"; `#text(fill: "red")` → "expected color…found string"; `#rect(width: 1fr)` → "expected relative length or auto, found fraction"; `#(1h)` → "invalid number suffix"; `#min(1,2)` → unknown variable (use `calc.min`); `#linear-gradient(...)` → unknown variable (use `gradient.linear`); `#(1 % 2)` → error (use `calc.rem`); `#("2" + 2)` → "cannot add string and integer"; `#str([content])` → error (use `repr`); `#stack(dir: "ltr")` → direction values are bare (`ltr`).

## 5. Math mode (highest-failure area)

### 5.1 Entering math
- `$x^2$` inline; `$ x^2 $` (space at **both** ends) = block (centered). A lone edge space stays inside as spacing.
- Works in headings, table cells, footnotes, code (`#let e = $x^2$`).
- **Strings are never parsed**: `#box("$x$")` literal; `#box([$x$])` math.
- Escapes in math: `\$ \# \^ \{ \}` render literally; `\\` = literal backslash; `//` starts a comment (**`$a//b$` is NOT division**).
- `math.eval` does NOT exist → use global `#eval("x^2", mode: "math")` (mode: `"code"` default, `"math"`, `"markup"`; `scope:` named arg for variables).

### 5.2 Identifiers & variables (the #1 trap)
- Single letters and numbers are math characters: `$x$`, `$2$`, `$2x$` (2·x).
- **Any multi-letter run is looked up as a variable**: `$xy$`, `$sqrt x$`, `$unknownthing(x)$` → `unknown variable: ...`. ✅ `$x y$` = x·y; `$2 pi r$` = 2πr; `$sin x$`.
- `#let`-bound multi-letter names resolve (`#let alpha = 1; $alpha$` → 1); single-letter variables do NOT (`#let x = 5; $x$` prints the letter x) → `$#x$`.
- Code scope shadows math scope (`#let pi = 5; $pi$` → 5).
- Math identifiers cannot contain `_` or `-` (they parse as operators/scripts).
- Strings in math = upright text: `$a "is natural"$`.

### 5.3 Scripts (`^` and `_`)
- Take **one atom**; group with parens; **parens in scripts are absorbed** (never shown):
  - `$e^(i Theta + pi)$` ✅ — `$e^(i Theta) + pi$` puts `+pi` outside
  - `$x_(i, j)^(n + 1)$` ✅; `$log_(n+1)(Theta + pi)$` ✅ (parens shown + auto-scaled)
  - `$a^b c$` → c NOT in the exponent; `$a^(b c)$` = a^(bc)
- **Chained scripts nest (right-assoc), not errors**: `$e^x^2$` = e^(x²); `$x_1^2_3$` nests.
- Order irrelevant: `$x_1^2$` ≡ `$x^2_1$`.
- `$x_ 1$` (space after `_`) is valid.
- **Subscripted function notation needs separation before arguments:** write `$H_b (p)$`, `$P_X (x)$`, and `$D_"KL" (P || Q)$`. Do not write `$H_b(p)$`: because scripts take one atom and `b(p)` is a call-shaped atom, Typst can parse it as `H_(b(p))` rather than as `H_b` followed by `(p)`.
- Primes: `$f'$`, `$f''$`; scripts attach as usual.
- `{ }` are **visible braces** (auto-scaling delimiters) — there is NO `{}` grouping in Typst! `$x_{n+1}$` renders braces. Group with `( )`.
- `$S_1.plus.a$` → error (symbol modifier after script); use `attach(S, t:, b:)`.

### 5.4 Parens semantics (verified)
- `( )` group AND display; they are **removed** only (a) around a fraction's numerator/denominator, (b) around a radicand, (c) around a script argument.
- `$f(x) = (x + 1)/x$` → (x+1) removed; `$1/((x+1))$` → one pair shown; `$x + (y)$` → parens kept; `$[x]^2$` → brackets kept + auto-scaled.
- `(a+b)/2` parens removed; `[a+b]/2` brackets kept.

### 5.5 Fractions
- `/` = fraction, **left-assoc**: `$a/b/c$` = (a/b)/c; group `$a/(b/c)$`.
- `$a/(b + c)$`; `$(partial u)/(partial x)$` ✅ (`\partial` ❌ LaTeX).
- `frac(a, b)` explicit form (parens NOT auto-removed around its args). `frac.style` param is 0.14+.
- `$10 m/s$` fine (single letters); `$10 m/speed$` → variable lookup error → `$10 m/"speed"$`.

### 5.6 Math calls
- `name(args)` directly after an identifier (no space) = math call. Args parse in math mode; `;` builds 2D arrays (for `mat`); named args and `..` spread work.
- Callee is a function → real call. Callee is an op/single letter (e.g. `sin`, `f`) → **no error**: displays callee + args in auto-scaled parens (`$sin(x)$` → sin(x)).
- Undefined multi-letter callee → error.
- `$sin x + y$` = (sin x) + y; `$sin(x + y)$` = sin of (x+y). `$sqrt x$` shows literal "sqrt" → always `sqrt(x)`.
- Custom operators: `op("lim", limits: #true)_x`.

### 5.7 Implicit multiplication
- Whitespace between atoms = multiplication: `$a b$`, `$2 pi r$`, `$2x$`, `$sin x$`.
- No space between multi-letter names = variable lookup error.
- When ambiguous, use explicit `dot`/`times`.

### 5.8 Symbols, shorthands, modifiers
- All `sym` symbols usable bare in math: `alpha pi theta Gamma partial nabla sum integral union inter subset in oo` ...
- Shorthands: `...`(…) `-`(−) `*`(∗) `~`(∼) `!=`(≠) `:=` `<<` `>>` `<=` `>=` `->` `-->` `|->` `=>` `==>` `<=>` `<==>` `||`(‖) `[|` `|]` ...
- `==` is NOT a shorthand — renders two `=` glyphs. Identity: `eq.triple` (≡).
- Modifiers: `arrow.r.long`, `gt.eq.not`, `phi.alt`, `dots.v`, `dots.c`, `dots.h`, `lt.eq.slant`... order irrelevant.
- Blackboard: `RR NN ZZ QQ CC` or `bb(x)`; `cal(L)`, `frak(g)`, `mono(x)`, `bold(x)`, `upright(x)`, `sans`, `serif`, `italic(x)`.
- `dot` (⋅) NOT `cdot`; `oo` NOT `infty`; `dif` = upright differential d with thin spacing.
- Greek via Unicode also fine: `θ λ` ≡ `theta lambda`.
- Accents: `hat(x) tilde(x) dot(x) vec(x) grave(x) acute(x) arrow(x) harpoon(x)`; generic `accent(base, accent)` e.g. `accent(x, macron)`. **`bar` is the `|` glyph** — `bar(x)` renders `|(x)`; use `overline(x)`.
- `sum`/`product`/`integral`/`union` are symbols, not functions: `$sum_(i=0)^n i$` ✅. Limits auto-place (below in display, side in inline); force with `limits(x)`/`scripts(x)`.
- ⚠️ Version drift: `times.o` is 0.14+ (absent in 0.13 — use `times.circle`); `inter`, `sect` (deprecated), `numero`, `eq.triple.not` were added in 0.13.0 and DO exist. Check the version's symbol table.

### 5.9 Delimiters & sizing
- Matched `( ) [ ] { }` auto-scale; `lr(...)` forces scaling; `lr(size: 1em)` disables.
- `abs(x)`, `norm(x)`, `floor(x)`, `ceil(x)`, `round(x)` — **plain `|x|` does NOT auto-scale**; `\|` is a literal pipe escape.
- `mid(|)` scales a middle bar.
- `sqrt(x)`; `root(n, x)` — **index first** (`root(3, x)` = ∛x).
- Sizes: `display(x) inline(x) script(x) sscript(x)`; `stretch(x)` for wide arrows with labels: `stretch(arrow.r.long)^"over"`.

### 5.10 Display math & alignment
- `#set math.equation(numbering: "(1)", supplement: [Eq.])` numbers block equations; `<eq1>` label + `@eq1` reference.
- Line breaks: `\` (backslash + space); each line can have `&` alignment points; `&` alternates right/left-aligned columns; `&&` = two points.
- `mat(a, b; c, d)` — rows by `;`; params `delim`, `align`, `augment`, `gap`; `#set math.mat(delim: "[")`.
- `vec(a, b, c)` column vector — **1D, no `;`** (`vec(a, b; c, d)` errors).
- `cases(a &= 1, b &= 2)` — comma-separated; `&` aligns.
- Under/over: `underline overline underbrace(x, "ann") overbrace underbracket overbracket underparen overparen`; annotation via 2nd arg or `_("...")`.
- `cancel(x)` (params: length, inverted, cross, angle, stroke).
- `attach(base, t:, b:, tl:, bl:, tr:, br:)`; `underbrace(a + b)_("result")`.
- No `\tag`, no environments, no `equation*` — numbering is global via set rule; `#set math.equation(numbering: none)` disables.
- `&` in markup is a literal character; special only in math.

### 5.11 Spacing & styling in math
- `thin` (0.17em), `med`, `thick`, `quad` (1em), `wide`; or `#h(1em)`.
- `text(...)` works inside math calls: `$text(fill: #maroon, 2 a b)$`.
- `#` injects code: `$x = #(2*3)$` → x = 6; `$#calc.pow(2, 3)$`; `$#rect(...)/x$` embeds content in math.
- Font-level: `#show math.equation: set text(font: ...)`.
- 0.13 has NO `tt`/`rm`/`it`/`scr` (use `mono`/`upright`/`italic`; `scr` is 0.14+).

### 5.12 The 0.13 math module (verified list)
Elements: `equation text lr mid attach stretch scripts limits accent underline overline underbrace overbrace underbracket overbracket underparen overparen undershell overshell cancel frac binom vec mat cases root class op primes`.
Functions: `abs norm round sqrt upright bold italic serif sans cal frak mono bb display inline script sscript` (+ `floor ceil` in lr family).
Operators (op elements): `arccos arcsin arctan arg cos cosh cot coth csc csch ctg deg det dim exp gcd lcm hom id im inf ker lg lim liminf limsup ln log max min mod Pr sec sech sin sinc sinh sup tan tanh tg tr`.
Spacing: `thin med thick quad wide`. Symbols: whole `sym` table + `dif` `Dif`.
Does NOT exist: `math.eval math.solve math.tt math.rm math.it math.scr math.hspace math.hfill math.sum math.product math.diff math.grad math.shr math.and math.or math.not` (those are symbols or absent).

### 5.13 Math mistakes (condensed)
| ❌ | ✅ |
|---|---|
| `$xy$` (want x·y) | `$x y$` or `#let xy = ...` |
| `$sqrt x$` | `$sqrt(x)$` |
| `$e^(i Theta) + pi$` (want e^(iΘ+π)) | `$e^(i Theta + pi)$` |
| `$x_{n+1}$` (LaTeX grouping) | `$x_(n+1)$` — braces show! |
| `\frac{1}{2}`, `\alpha`, `\sum_{i=0}^n` | `$1/2$`, `alpha`, `sum_(i=0)^n` |
| `\|x\|` norm | `norm(x)` or `lr(|x|)` |
| `$a//b$` division | `$a/b$` (// = comment) |
| `\text{hi}`, `\mathbb{R}`, `\mathcal{L}` | `"hi"`, `RR`, `cal(L)` |
| `\bar{x}` | `overline(x)` or `accent(x, macron)` |
| `\cdot` | `dot` |
| `x = "10"` (want number) | `$x = #10$` or string is upright text |
| `#math.eval("1+2")` | `#eval("1+2")` / `#eval("x^2", mode: "math")` |
| `$x²$` superscript char | `$x^2$` |
| `$vec(a, b; c, d)$` | `mat(a, b; c, d)` — vec is 1D |
| `$cases(1, 2; 3, 4)$` | `cases(1, 2, 3, 4)` — no `;` |
| `$root(x, n)$` | `root(n, x)` — index FIRST |
| `$a/b/c$` wanting a/(b/c) | `$a/(b/c)$` — left-assoc |
| `$sin x + y$` meaning sin(x+y) | `$sin(x + y)$` |
| `$H_b(p)$` meaning binary entropy at p | `$H_b (p)$` — keep the call out of the subscript |
| `#let x = 5; $x$` expecting 5 | `$#x$` — single letters never look up |

### 5.14 Cross-language conversion (LaTeX → Typst)

| LaTeX | Typst | LaTeX form in Typst |
|---|---|---|
| `\documentclass{article}` | `#set page(...)` + optional template | literal text |
| `\usepackage{amsmath}` | nothing — batteries included; packages via `#import "@preview/..."` | literal text |
| `\section{...}` | `= Heading` | literal text |
| `\textbf{}` / `\emph{}` | `*strong*` / `_emph_` (markup); `bold(x)` / `italic(x)` (math) | literal / error |
| `\texttt{}` | `` `raw` `` / `#text(font: "… Mono")`; math `mono(x)` | literal / error |
| `\\` line break | `\` + space | `\\` prints a literal backslash |
| `\newpage` | `#pagebreak()` | literal |
| `\hspace{1cm}` | `#h(1cm)`; math `quad`/`thin`/`hspace`? no — `thin med thick quad wide` | literal |
| `\label{}` / `\ref{}` | `<label>` / `@label` | literal |
| `\cite{}` | `@key` + `#bibliography(...)` | literal |
| `\begin{itemize}` / `enumerate` / `description` | `- item` / `+ item` / `/ Term: desc` | literal |
| `\begin{tabular}` | `#table(...)` / `#grid(...)` | literal |
| `\begin{figure}` | `#figure(...)` | literal |
| `\begin{equation}` / `\begin{align}` | `$ x $` block / `$ x &= y \ z &= w $` | literal |
| `\newcommand{}` | `#let f = ...` | literal |
| `\include{ch.tex}` / `\input{}` | `#include "ch.typ"` | literal |
| `%` comment | `//` / `/* */` | `%` is literal text |
| `\frac{a}{b}` | `$a/b$`, `a/(b+c)`, `frac(a, b)` | `unknown variable: rac` |
| `\alpha` `\beta` `\theta` | `alpha` `beta` `theta` (or `#sym.alpha`) | `unknown variable: lpha` |
| `\sum_{i=0}^n` | `sum_(i=0)^n` | `unknown variable: um` |
| `\int_0^1` | `integral_0^1` | `unknown variable: ntegral` |
| `\lim_{x\to 0}` | `lim_(x -> 0)` | `unknown variable: im` |
| `\text{hello}` | `"hello"` (upright) | `unknown variable: ext` |
| `\left( \right)` | automatic; `lr(...)` | `unknown variable: eft` |
| `\sqrt{x}` / `\sqrt[n]{x}` | `sqrt(x)` / `root(n, x)` | error |
| `\cdot` `\times` `\div` | `dot` `times` `div` | `cdot` errors |
| `\infty` | `oo` | error |
| `\le \ge \ne` | `<=` `>=` `!=` | error |
| `\equiv` | `eq.triple` | `==` renders two `=` |
| `\to \rightarrow` / `\Rightarrow` / `\Leftrightarrow` | `->` / `=>` / `<=>` | error |
| `\mathbb{R}` | `RR` / `bb(R)` | error |
| `\mathcal{L}` / `\mathfrak{g}` | `cal(L)` / `frak(g)` | error |
| `\mathbf{x}` / `\mathrm{x}` | `bold(x)` / `upright(x)` | error |
| `\hat{x}` `\tilde{x}` `\vec{x}` `\dot{x}` | `hat(x)` `tilde(x)` `vec(x)` `dot(x)` | error |
| `\bar{x}` | `overline(x)` / `accent(x, macron)` | `bar` = `\|` glyph |
| `\underbrace{a}_{b}` | `underbrace(a)_(b)` | error |
| `\binom{n}{k}` | `binom(n, k)` | error |
| `\|x\|` / `\left|...\right|` | `norm(x)` / `abs(x)` | literal pipe, no scaling |
| `\lfloor \rfloor` | `floor(x)` `ceil(x)` `round(x)` | error |
| `\,` `\;` `\quad` | `thin` `thick` `quad` | literal |
| `\mathrm{d}x` | `dif x` | error |
| `\operatorname{foo}` | `op("foo")` | error |
| `\cdots` / `\ldots` | `dots.c` / `dots.h` | error |
| `\cup` / `\cap` / `\notin` | `union` / `inter` / `in.not` | error |

### 5.15 Cross-language conversion (Markdown → Typst)

| Markdown | Typst | Markdown form in Typst |
|---|---|---|
| `**bold**` | `*strong*` | warning + literal |
| `*italic*` | `_emph_` | `*text*` = strong! |
| `_italic_` | `_emph_` ✓ | works (emph) |
| `# heading` | `= heading` | error (`#` = code mode) |
| `- item` | `- item` ✓ | works |
| `1. item` | `+ item` (or `1. item` also works) | both fine |
| `[link](url)` | `#link("url")[text]` | prints `link(url)` with clickable url |
| `![img](path)` | `#image("path")` | literal |
| `<b>bold</b>` | `#text(weight: "bold")[bold]` | `<b>` parsed as label warning |
| `\| a \| b \|` tables | `#table(...)` | literal pipes |
| `` `code` `` | `` `code` `` ✓ | works (raw) |
| `> quote` | `#quote[...]` | `>` literal |
| `~strike~` | `#strike[...]` | `~` = nbsp |
| `---` hr | `#line(length: 100%)` | `---` = em dash |
| backtick fences | fences ✓ | works |

Unicode: typing `α θ λ ≠ ≤ ≥ → ⇒ ∑ ∫ —` directly works everywhere (markup + math). Beware `²`/`³` are plain characters, not math scripts; `−` (U+2212) vs `-`; homoglyphs `λ/Λ`, `∂/δ`.

## 6. Layout

- **box** = inline container (`inset`, `outset`, `width`, `height`, `clip`; never breaks pages, wraps lines).
- **block** = block-level container (`breakable: true` for multi-page, `above/below`, `sticky`).
- **place** = absolute positioning relative to parent (or page): `place(top + right, dx: 1cm, dy: 0pt)`; overlays by default.
- **Floats**: `place(align, float: true, clearance: 6pt)` — **NO `float()` function in 0.13** (`float` is the number type!). `place.flush()` forces queued floats out. Column-spanning: `place(top + center, scope: "parent", float: true)`.
- **v / h**: `#v(2em)` vertical space, `#v(1fr)` flexible push (center content: `#v(1fr)` + content + `#v(1fr)`), `#h(1fr)` right-alignment, `h(0pt, weak: true)` collapses surrounding space. `#v(2em, weak: true)` allows collapse.
- **pad**: `pad(x: 10pt, y: 5pt)` or `pad(10pt)` — **no `inset:` param** (inset lives on box/block).
- **align**: `#align(center)[...]`; `#align(top + right)`.
- **grid** vs **table**: grid = uniform cells (`grid(columns: (1fr, 2fr), rows: auto, [a], [b], [c], [d])`); table = per-cell features (`table(columns: 2, [a], [b], [c], [d])`, spans, strokes, alignment). Use grid unless you need per-cell control.
- **columns(n)** multi-column flow; **colbreak()**; **#pagebreak()**.
- **stack**: `stack(dir: ltr, spacing: 4pt, ..)` (0.12+).
- **context + measure/here/layout**: layout-dependent values:
  ```typst
  #context { let w = measure([Hello]).width; [width #w] }
  #context here().page()
  #context layout(size => [container: #size.width])
  ```
- Mistakes: `#float(...)` → confusing errors; `box(width: 1fr)` compiles (box accepts fractions) but `rect(width: 1fr)` errors ("expected relative length or auto") — `fr` is only meaningful in flex containers (use `100%`); `#pad(inset: 10pt)` → "unexpected argument: inset"; `place` mid-paragraph breaks the line → wrap in `box` + `sym.wj`; `measure()`/`here()`/`locate()`/`counter().get()` outside `context` → "can only be used when context is known"; `#stack(dir: "ltr")` → direction is a bare value; negative margins not allowed (use negative `pad`); `box` has no `breakable` param.

## 7. Styling (set / show)

### 7.1 set rules
- `#set text(size: 11pt, font: "Libertinus Serif", fill: rgb("#222"), weight: "bold", style: "italic", lang: "en", tracking: 0.02em, baseline: 0.8em)`; `#set par(justify: true, leading: 0.65em, first-line-indent: 1.8em)`; `#set page(...)`; `#set heading(numbering: "1.")`; `#set list(marker: [--])`; `#set enum(numbering: "I.")`; `#set figure(numbering: "1.")`.
- **Only element functions** can be set (`#set lorem(20)` → "only element functions can be used in set rules").
- Scope: applies to content AFTER the rule, to end of enclosing block. Content before is unaffected. `#set text(..) if condition` = set-if.
- `#set page(...)` must be top-level — "page configuration is not allowed inside of containers".

### 7.2 show rules
- Selectors: element fn (`#show heading:`), text (`#show "Project":`), regex (`#show regex("\w+"):`), label (`#show <intro>:`), `where` (`#show heading.where(level: 1):`), everything (`#show: body => ..`).
- RHS: function (transform: `it => ...`; `it.body`, `it.level` fields), string (literal replacement), content, or set rule.
- **show-set**: `#show heading: set text(navy)` — set only on selected elements; stays overridable (preferred over set-inside-show).
- **Transformational**: `#show heading: it => block[#emph(it.body)]`.
- **show-everything** for templates: `#show: template.with(title: [X])` — must come BEFORE content.
- **Declaration style**: `#show: smallcaps` (applies to rest of scope).
- Precedence: set rules apply first, then show rules; rules chain; same-specificity rules: the one closest to the content wins (later in source order).
- Recursion trap: `#show heading: heading` or replacing with the same content = infinite loop/divergence.
- `#show "a": "b"` — replacement must not re-match the selector.
- `#show par: ...` in 0.13 only affects "proper paragraphs".

### 7.3 Styling functions
- `#text(fill: blue, 18pt)[styled]` one-shot; `#text(style: "italic", weight: 700)`.
- Gradients: `#text(fill: gradient.linear(red, blue))`; `gradient.radial`, `.conic`.
- Colors: named colors (120+), `rgb("#hex")`, `rgb(0-255,...)`, `luma`, `oklch`, `cmyk`.
- Numbering patterns: `"1."` `"I."` `"(a)"` `"1 / 1"` (page x of y) `"1.2"` (hierarchical); custom via function `numbering((n) => ...)`.
- Block-scoped styling: `#[{ #set text(red) this is red }]`.
- Font fallback list: `#set text(font: ("Libertinus Serif", "Noto Sans"), fallback: true)`.

## 8. Introspection

- **counter**: `counter(heading)`, `counter(page)`, `counter("custom")`; `.get()` (needs context), `.at(<label>)`, `.step()`, `.update(n)` (0.13: single value; 0.14+: `update(level:, value:)`), `.display("1.")`; `#counter(page).update(1)`.
- **state**: `#state("name", default)`, `.update(v)` (document-wide, order = document order), `.get()` (context), `.at(loc)`. ⚠️ Don't read state in headers where updates are ambiguous → "document did not converge within five attempts".
- **query**: `#context query(heading).len()`, `#context query(<label>)`, `#context query(<label>).first().value` (metadata value).
- **metadata**: `#metadata(42) <m>` — invisible, queryable.
- **locate**: `#context locate(<label>).position()` / `.page()`.
- **here()**: `#context here().page()`.
- Counter resets: `#counter(heading).update(1)` at chapter starts; hierarchical numbering `"1.1"` auto-manages levels.
- All of these need `context` (0.13 removed `state.display()`, `counter.at` location args, and `style()`/`measure(styles:)` in favor of `context`).

## 9. Documents

```typst
#set page(paper: "a4", margin: (x: 2cm, y: 2.5cm), columns: 1, numbering: "1",
          header: context { counter(page).display() }, background: none)
#set document(title: "My doc", author: "A. Author")
#pagebreak() #colbreak()
```

- Running header with current section:
  ```typst
  #set page(header: context {
    let sec = query(heading.where(level: 1)).last()
    if sec != none { sec.body } else { none }
  })
  ```
- "Page X of Y": `numbering: "1 / 1"`.
- First-page special header: `#set page(header: context { if counter(page).get().first() == 1 { none } else { ... } })`.
- `outline()` for TOC (entries are blocks; style via `show outline.entry`).
- **bibliography**: `#bibliography("refs.bib", style: "apa", full: true)` (BibLaTeX `.bib` or Hayagriva `.yml`; multiple files as array; 80+ CSL styles; custom CSL by path). Citations: `@key`, `#cite(<key>, form: "prose"|"short"|"full")`, multiple `@a @b`, footnotes `#footnote[@key]`. `full: true` REQUIRED to list uncited works. Unknown key → "unknown citation". Place bibliography in/after content.
- **multi-file**: `#include "chapters/ch1.typ"` = raw content; `#import "lib.typ": fn` = definitions (no output); circular imports error. ⚠️ Show/set rules inside `#include`d files leak into the whole parent document — scope with blocks or use template functions.
- Global state across files: none (each module has own scope) — use `state`/`counter`.
- Relative paths (`#image`, `#include`, `#import`, `#bibliography`, `#read`) resolve relative to the **containing file's directory** on 0.13 (empirically verified); `--root` defines the security boundary (files outside it → access denied). Run `typst compile --root . main.typ` from the project root to keep things consistent.

## 10. Packages & ecosystem (versions verified 2026-08-08)

### 10.1 Package system
- `#import "@preview/name:0.1.0": *` / `: item1, item2` / `as mod` / bare (binds module by name).
- **Exact version mandatory** — no ranges, no "latest". `#import "@preview/cetz"` = hard error.
- `package @preview/x:0.1.0 not found` = wrong version/typo/case/offline (cache miss). Case-sensitive.
- Local installs: `{data-dir}/typst/packages/local/name/ver` — on Windows empirically `%LOCALAPPDATA%\typst\packages\local\...` (verified 0.13.1; some docs say `%APPDATA%` — check the error message "searched at ..." which prints the real path). Cache: `%LOCALAPPDATA%\typst\packages\preview\...` (Local).
- Publishing: PR to github.com/typst/packages with `typst.toml` manifest (`name`, `version`, `entrypoint`, `authors`, `license`, `description`, `compiler`, `exclude`; `[template]` section for templates).
- Transitive deps pin their own versions; mixing two cetz versions in one doc = two separate modules (fletcher 0.5.8 pins cetz 0.3.4).

### 10.2 DEAD packages (verified 404 — never recommend)
`arrows`, `vega`, `chart`, `preprint`, `simple`, `artify`, `ieee-conf`, `thesis`, `academic`, `emojify`, `grify`, `circo`, `metropolis`, `typst-package` (repo). `hydra` is **running headers** (not a drawing lib). Emoji is **built-in** since 0.13: `#emoji.face`, `#emoji.wave` (needs a color emoji font).

### 10.3 Recipes (verified on 0.13.1 where marked ✓)

**CeTZ** (✓ compiled): pin `cetz:0.4.2` for Typst 0.13; 0.5.x needs Typst ≥ 0.14.
```typst
#import "@preview/cetz:0.4.2"
#cetz.canvas({
  import cetz.draw: *            // MUST be inside the canvas body
  line((0, 0), (3, 2), stroke: 1.5pt + red, mark: (end: ">"))
  circle((1.5, 1), radius: 1cm, fill: blue.lighten(80%))
  rect((0, 0), (2, 1), fill: green, radius: 2pt)
  polygon((0, 0), 3)                             // 0.4.x: polygon(origin, sides); point lists are 0.5+
  bezier((0, 0), (1, 2), (2, -1), (3, 0))
  content((3, 3), [label], anchor: "south-west")   // 0.4.x name; 0.5+: text()
  circle((30deg, 2), radius: 2pt)                  // polar (angle, radius)
  line((+1, 0), (0, 0))                            // relative to last position
})
```
- canvas takes a **code block**, not content; auto-sizes; 1 unit = 1cm by default (`length:` param rescales; ratio → relative to parent).
- `group(name: "g", { ... })` for named reusable groups (name is a NAMED arg — `group("g", {...})` errors); `mark: (start: ..., end: ...)` dict for arrowheads; anchors: `"center"`, `"north-east"`, named-element refs as plain strings `"c1.north"` (tuple refs `("c1",)` error on 0.4.x).
- Docs are "work in progress" — the universe page example is authoritative. Old tutorials (pre-cetz 0.3, late 2024) use removed APIs.

**cetz-plot** (plotting): on 0.13 use **cetz-plot 0.1.1 + cetz 0.3.2** (compiles and renders on 0.13 — verified); cetz-plot 0.1.4 needs cetz ≥ 0.5 → Typst ≥ 0.14 and uses the newer API (`plot.plot(x:, y:, { plot.add(plot.line(...)) })`, `chart.bar`, `chart.pie`). 0.1.1's API is older (`plot.add(points)`, `plot.add-bar`). Can't mix cetz-plot 0.1.4 with cetz 0.4.2 (version conflict).

**fletcher** (✓ compiled) — commutative diagrams & flowcharts:
```typst
#import "@preview/fletcher:0.5.8": diagram, node, edge, shapes
#diagram(cell-size: 15mm, $ G edge(f, ->) edge("d", pi, ->>) & im(f) \ $)  // math mode
#diagram(
  node-stroke: 1pt,
  node((0, 0), [Start], corner-radius: 2pt, extrude: (0, 3)),
  edge("-|>"),
  node((0, 1), align(center)[Process], shape: shapes.diamond),
  edge("d,r,u,l", "-|>", [Yes], label-pos: 0.1),
)
```
- Edge mark strings: `->` `-|>` `-->` `<->` `|->` `-o` `-x` `hook-->` `-<|` `||-` crow's foot `n?` brackets `"["` `"]"`. Implicit edges continue from previous node.
- Node shapes from `fletcher.shapes`: diamond, pill, parallelogram, hexagon, ellipse, octagon, trapezium, cylinder, brace, bracket, paren...
- 0.5.x: NO `flow()`, NO `A -- B`/`=>` syntax (0.1.x-era). String labels not allowed positionally on `edge()`.
- `fletcher.hide()` for incremental slide builds; touying has a `fletcher-diagram` wrapper.

**nulite** (Vega-Lite, WASM plugin; vega is dead): `#import "@preview/nulite:0.1.0": render` + `#render(width: 100%, height: 100%, zoom: 1, json("spec.json"))` — spec size ignored (pass to render); `url` data loading errors; inline data only.

**touying** (slides, ✓ compiled):
```typst
#import "@preview/touying:0.7.4": *
#import themes.simple: *            // theme submodules: simple, metropolis, dewdrop, university, aqua, stargazer
#show: simple-theme.with(aspect-ratio: "16-9")
= Section title slide                 // level-1 heading
== Slide one                          // level-2 = slides
#pause                                // own line, not inline
```
- `#cols[...][...]`, `#cols(columns: (1fr, 1fr))`, `#uncover("2-")[...]`, `#only("2-")[...]`, `#alternatives`, `#focus-slide`, `#outline-slide`, `#speaker-note[...]`, `#show: appendix`; `touying-reducer` wraps cetz/fletcher canvases for animations.
- Mistakes: forgetting `#import themes.<name>: *`; `#pause` on the same line as text; show rule placed after content; old `themes.default` → `themes.simple`.

**polylux** 0.4.0 (✓ compiled): `#slide[ ... ]` blocks; `#uncover(n)[...]` (reserves space) vs `#only(n)[...]` (no space); `#show: later` replaces `#pause`; `#alternatives`; `#side-by-side` lives in `polylux.toolbox` (not top-level). **0.4.0 removed** `#pause`, themes, `===` separators, `polylux-init` — 0.2.x tutorials will not compile. Themes are now separate packages (`metropolis-polylux`, etc.).

**codly** (✓ compiled): `#import "@preview/codly:1.3.0": *` + `#show: codly-init.with()` (mandatory); configure via `#codly(number-format: none, highlights: ((line: 4, start: 2, end: 8, fill: red),), skips: ((5, 32),))` — single-element arrays need trailing commas or they collapse to dicts; `#codly-range(5, end: 10)` (start is positional); `#no-codly[...]`.

**pinit** 0.2.2: `#pin(1)`/`#pin(2)` markers + `#pinit-highlight(1, 2)` / `#pinit-point-from(2)[note]` / `#pinit-arrow(1, 2)`; `#pinit(callback: (..positions) => ...)`. Heuristic alignment — known misalignment issues; add blank lines around calls. `pinit-fletcher-edge(fletcher, 1, end: 2, ...)` passes the fletcher module as first arg.

**hydra** 0.6.3: running headers — `#import "@preview/hydra:0.6.3": hydra` + `hydra(1)`/`hydra(2)` inside `#set page(header: context { ... })`.

**cades** 0.3.1 (QR): `#import "@preview/cades:0.3.1": qr-code` + `#qr-code("https://typst.app", width: 3cm)` (error-correction: "L"|"M"|"Q"|"H"). Others: `tiaoma` (barcodes), `rustycure`.

**Templates** (official current set): `charged-ieee` 0.1.4, `modern-cv` 0.10.0, `appreciated-letter`, `badformer`, `cereal-words`, `dashing-dept-news`, `icicle`, `unequivocal-ams`, `wonderous-book`. Preprint replacements: `preprintx`, `diprint`, `clean-math-paper`. Old names are dead.
```typst
#import "@preview/charged-ieee:0.1.4": ieee
#show: ieee.with(title: [...], authors: ((name: "…", email: "…"),),
  abstract: [...], paper-size: "us-letter", bibliography: bibliography("refs.bib"))
#import "@preview/modern-cv:0.10.0": *
#show: resume.with(author: (firstname: "J", lastname: "S", email: "…"),
  profile-picture: none, date: datetime.today().display())
```
- Template = function; apply with `#show: <fn>.with(...)` or nothing happens. Params differ per template (charged-ieee `authors:` array of dicts vs modern-cv `author:` dict) — read the template's universe page.
- modern-cv needs Roboto, Source Sans Pro, FontAwesome installed (`--font-path` or system).

**matplotlib fallback** (when it's the right call): `python -c "...; plt.savefig('plot.png', dpi=300, bbox_inches='tight', transparent=True)"` + `#figure(image("plot.png", width: 100%), caption: [...])`. Use for complex stats (error bars, log scales, seaborn), quick iteration, or deterministic output. Don't use when diagrams must match document fonts.

**Other verified packages**: `theorion` 0.6.0 (theorems), `numbly` (heading numbering), `fontawesome` (icons), `echarm` 0.4.0 (ECharts WASM), `lilaq`/`gribouille`/`primaviz`/`simple-plot` (charts), `timeliney`/`gantty` (timelines), `circuiteria`/`zap` (circuits), `tiptoe` 0.4.0/`xarrow` 0.4.0/`commute` 0.3.0 (arrows), `metropolyst` 0.1.0 (metropolis touying theme).

## 11. CLI & tooling

```sh
typst compile main.typ                       # -> main.pdf
typst compile --root . main.typ              # THE fix for broken #image/#include paths
typst compile --font-path fonts/ main.typ    # extra font dirs (or TYPST_FONT_PATHS)
typst compile --format png --ppi 300 main.typ out-{0p}.png   # {0p} page template; --ppi or blurry
typst compile --format svg main.typ          # one SVG per page
typst compile --jobs 8 main.typ
typst watch main.typ                         # incremental recompile
typst init @preview/name:version             # scaffold from template
typst fonts                                  # list discovered fonts (forgot a font? check here)
typst query main.typ "heading" --field body --one   # 0.15+: typst eval
# typst info is 0.14+ (package path/cache paths; on 0.13 read the error message)
typst update
```

- Path resolution: relative paths resolve against the **root** (cwd or `--root`), not the file. `typst compile chapters/ch1.typ` breaks `#include "common.typ"` — use `--root .`.
- `--input k=v` → `sys.inputs.k`; env vars: `TYPST_FONT_PATHS`, `TYPST_IGNORE_SYSTEM_FONTS`, `TYPST_ROOT`, `TYPST_PACKAGE_PATH`, `TYPST_FEATURES` (0.13; only feature: experimental `html` export via `--features html`).
- No `typst preview` command — preview = tinymist-based VS Code extension. tinymist = LSP; typst-fmt = formatter; typstyle = alternative.
- 0.15: `typst eval` supersedes `typst query`; paths may not contain backslashes (forward slashes only, even on Windows); new `path` type.
- PNG default ppi = 144 (blurry); SVGs render text with local fonts (can differ from producing app).

## 11b. Recipes (verified patterns)

**Minimal document skeleton**:
```typst
#set page(paper: "a4", margin: (x: 2cm, y: 2.5cm), numbering: "1",
          header: context { counter(page).display() })
#set text(font: "Libertinus Serif", size: 11pt, lang: "en")
#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.")

= Introduction
Body text with *emphasis* and _strong_.
```

**Thesis/multi-file skeleton**:
```typst
// defs.typ — shared styles + helpers
#let chapter-title = it => block(above: 2em, below: 1em)[#it]
#show heading.where(level: 1): chapter-title
// main.typ
#import "defs.typ": *
#include "chapters/intro.typ"
#include "chapters/methods.typ"
#bibliography("refs.bib", style: "apa", full: true)
```

**Box with title + body (custom function with trailing content)**:
```typst
#let callout(body, fill: blue.lighten(90%)) = block(
  fill: fill, inset: 8pt, radius: 4pt, width: 100%,
)[#body]
#callout[Important *content* here.]
```

**Two-column paper layout with spanning figure**:
```typst
#set page(columns: 2)
#place(top + center, scope: "parent", float: true, clearance: 1em)[
  #figure(image("fig.png", width: 80%), caption: [Spanning figure]) <fig-main>
]
```

**Math-heavy page with numbered equations and references**:
```typst
#set math.equation(numbering: "(1)")
$ E = m c^2 $ <eq-mass>
From @eq-mass we get $E = m c^2$ directly.
```

**Data-driven table from CSV**:
```typst
#let data = csv("data.csv")
#table(
  columns: data.at(0).len(),
  ..data.flatten().map(x => if type(x) == str { text(x) } else { x }),
)
```

**Simple bar-chart substitute without packages**:
```typst
#let bars = ((3, red), (5, blue), (2, green))
#grid(columns: 3, ..bars.map(((v, c)) => block(
  height: v * 1cm, fill: c, width: 100%,
)))
```

## 11c. Power-user patterns (distilled from real UCLouvain study documents, all compile-verified)

### Math styling through shadowed helpers — the master technique
```typst
#let imp(body) = text(fill: blue.desaturate(10%).darken(10%), weight: "bold", body)
#let def(term) = text(fill: red, weight: "bold", term)
#let strong(txt) = text(weight: "bold")[#txt]
#let ok(body) = text(fill: green.darken(25%), weight: "bold")[#body]
#let muted(body) = text(fill: luma(40%), size: 0.9em)[#body]
```
Shadowing markup builtins with `#let` lets you call them **bare inside math** (`$&strong("Name")$`, `$imp(P(A|B) = ...)$`, `$#ok[CORRECT]$`) — the real `strong`/`purple` error in math ("unknown variable … try adding a hash"). This unlocks the aligned-formula-table pattern below. In math, code-injected helpers need `#` (`text(fill: #color.purple, W)` ✓; bare `color.purple` ✗).

### Aligned formula tables (`&` column grid)
```typst
$ &strong("Expected Value")  &quad& EE[X] = sum_(x) x P(x) \
  &strong("Bayes Theorem")   &quad& imp(P(A|B) = (P(B|A)P(A)) / P(B)) \
  &&& quad quad quad quad = H(Y) - H(Y|X) \
  &&& quad quad quad quad = I(X; Y) + underbrace(H(X|Y) + H(Y|X), "sum the hulls") $
```
Leading `&` opens a spacer cell; `&quad&` ends the name column; the equation starts the 4th column. Continuation rows re-enter the equation column with `&&&` + manual `quad` indents (fragile eyeball hack — keep the name column short).

### Annotation devices
- `underbrace(expr, "label")` — the primary margin-note; **`\n` in the string = line break**; label can be any content: `underbrace(H(Y|X), imp("Recursive Separation"))`, `underbrace(a + b)_("result")`.
- Full control via code injection in the label slot: `underbrace(H(X), #place(center, dx: -2em)[#text(size: 7.5pt)[Uncertainty on X]])` — `place` works inside math (131 uses in one real doc).
- Text over relations: `stretch(=)^"Expand"`, `stretch(->)^(mu_x=0)`, multi-level `stretch(<=>)^"Mirror Symmetry"_"180° Chart Rotation"`, `stretch(arrow.b, size: #300%)`.
- Derivation-step arrows inside a single math block: `&#box(width: 0.8em, $stretch(arrow.b, size: #300%)$) #block([#v(-1em) M-fold Decimation])\` — `#block` is legal in math rows; the negative `#v` pulls the note up beside the arrow.
- Colored math pills: `#box(fill: red.lighten(40%), inset: 3pt, radius: 5pt, $+$)`.
- `cases(delim: #none, ...)`, `cases(reverse: #true, ...)`, nested cases; `mat(1, 2; 3, 4)` with `delim: "[", "|"` (determinant bars) — a **trailing `;` in `mat` is tolerated**.

### The metadata-collection pattern (self-describing content)
```typst
#let auto_box_fetcher(box-type, gap: 2pt) = context {
  let hits = query(metadata)
    .filter(m => type(m.value) == dictionary)
    .filter(m => m.value.box-type == box-type)
    .map(m => m.value.at("box", default: none))
  stack(dir: ttb, spacing: gap, ..hits)
}
// emitter side, inside every box:
#let definition_bx(...) = [#metadata((box-type: "Definition", box: outer_box)) #outer_box]
```
`metadata` is invisible but locatable and carries arbitrary dict values — content self-describes, and `== All Definitions / #auto_box_fetcher("Definition")` auto-builds exam-prep sections. Paragraph census: `show par: it => { it [#metadata("par")] }` (TWO statements — the one-liner is a parse error) + `selector(metadata.where(value: "par")).after(start).before(end)` to count paragraphs per section for reading-time estimates.

### Compound selectors & breadcrumbs
```typst
#set page(header: context {
  let hs = query(selector(heading).before(here(), inclusive: true))
  let active = (none,) * 3
  for h in hs { if h.level <= 3 { active.at(h.level - 1) = h
    for k in range(h.level, 3) { active.at(k) = none } } }
  let crumbs = active.filter(x => x != none)
  ...
  #crumbs.map(h => { let nums = counter(heading).at(h.location())
    let num = if h.numbering != none { numbering(h.numbering, ..nums) } else { "" }
    if h == crumbs.last() { text(weight: "semibold")[#num #h.body] } else { text(fill: luma(120))[#num #h.body] }
  }).join(h(6pt) + text(fill: luma(180))[#sym.angle.r] + h(6pt))
})
```
`selector(X).before(here(), inclusive: true)` + the per-level active-array algorithm (clear deeper levels on each hit) = running breadcrumb header. `counter(heading).at(location)` + `numbering(h.numbering, ..nums)` renders numbers in the heading's own scheme. `sym.chevron.r` is 0.14+ — use `sym.angle.r` on 0.13.

### Show rules & context power moves
- `show heading:` function returning an **array**: `result += pagebreak()/line()/block(...)` — accumulate heterogeneous pieces; guard auto-pagebreaks with `it.outlined` so outline-generated headings don't trigger them.
- `context` **propagates through function calls**: a helper invoked from inside `context { }` can read `page.width`/`page.height`.
- `set page/text/par/...` inside a wrapper function with trailing `body` works on 0.13 — one import + `#show: formulaire.with(layout: "horizontal")` styles the whole document. `flipped:` (NOT `flip`) is the landscape param; `header-ascent:`/`footer-descent:` ratios exist; `#pagebreak(to: "odd")` and `pagebreak(weak: true)`/`colbreak(weak: true)` for section helpers.

### Grid/table construction kit
- `(1fr,) * ncols` array repeat; partial-last-row centering: `colw = (100% - gutter * (ncols - 1)) / ncols` then `align(center)[block(width: colw * rem + gutter * (rem - 1))[grid(...)]]`.
- `stroke: 1pt + white` on grid/table + per-cell `fill:` = seamless colored spreadsheet; stroke **functions** `stroke: (x, y) => if y == 0 { (bottom: 0.7pt) } else { none }` for book-style rules.
- `table.cell(rowspan: 5, fill: ..., align: center + horizon)` category banners; `#let sm(x) = [#h(-0.1em) #text(size: 7pt)[$#x$]]` tiny-math header cells (strings render upright in `$#x$`); `#align(center)[#block(width: 110%)[...]]` lets a wide table bleed past the text column.
- Custom figure numbering: `numbering: (x) => numbering("1.a", counter(figure.where(kind: image)).get().at(0), idx + 1)` + `kind: "sub_figure"` sub-figures; `supplement: [Figures]`.
- Opacity by overlay: `place(top + left, rect(width: 100%, height: 100%, fill: rgb(255, 255, 255, 100% - 25%)))` over an image grid.
- Box building: per-side stroke dicts `stroke: (left: ..., bottom: none)`, per-corner `radius: (top-left: 4pt, ...)`, `#v(-10pt)` negative-space overlap to fuse a title strip and body, `move(dx: -4pt)` + `width: 100% + 8pt` to indent a nested box, color algebra `color.lighten(40%).desaturate(60%)`, `#text(red)` positional fill (named colors like `eastern` are built-in on 0.13+).

### Verified symbol/idiom inventory (0.13.1)
`plus.minus`, `minus.plus`, `inter`, `eq.triple`, `eq.delta`, `backslash` (`A_(backslash {0})` ✓), `\\` = literal backslash, `\/` = literal slash, `B_*` (`∗` glyph subscript), `arrow.cw/ccw`, `arrow.b/t`, `integral.double/triple/cont`, `underparen/overparen`, `dots.v/h/down`, `subset.eq`, `perp`, `times`/`dot`/`div`, `ast.circle` (0.13; deprecated in 0.14 → `convolve.o`), `times.o`/`plus.o` (0.14+; 0.13 = `times.circle`/`plus.circle`), `#text(fill: #color.purple, ...)` ✓ in math, `#table` inside math (`$#table(...) -> #table(...)$`), footnote inside math/underbrace labels, `#block()` empty spacers, negative `#v`/`#h` spacing.

### Anti-patterns seen in the wild (avoid)
- `@fig:label` referencing a never-defined label → hard error; dangling `}` in math compiles silently; `#sym.chevron.r`/`times.o` break on 0.13; single-element arrays of dicts `((a: 1))` collapse to a dict (need `((a: 1),)`) — the #1 cause of "type dictionary has no method map"; `query(selector(table))` fails on 0.13 ("table is not locatable", locatable since 0.14); OCR-style typos in prose are invisible to the compiler; fixed `#v(-10pt)` overlaps break if titles wrap.

## 12. Debugging & error catalog

Tools: `#repr(x)` (inspect element structure), `#type(x)` (value type), `#context text.size` (active styles), `typst query` (inspect document), `typst fonts` (fonts).

Troubleshooting recipes:
- **Math renders literally in a box/figure**: the content came from a string — change `"..."` to `[...]`.
- **Missing `#` symptoms**: literal text like "let x = 5" or "rect(width: 1cm)" in the PDF.
- **Invisible show rule**: the rule is placed after the content — move it before; a whole-document `#show:` must be at the top.
- **Template "doesn't work"**: you imported but never applied — add `#show: <fn>.with(...)`.
- **Blurry PNGs**: add `--ppi 300`.
- **Package not found**: check version spelling/case on typst.app/universe; `typst info` (0.14+) for cache paths; needs network on first fetch.
- **Header shows nothing**: `#set page(header: ...)` needs `context` for counters (`context { counter(page).display() }`).
- **`#include`d chapter breaks the doc style**: its `#set`/`#show` rules leak — wrap the include in a block or import a template function instead.
- **Diagrams/plots too complex for cetz**: matplotlib → PNG is the pragmatic fallback; don't fight the tool.

| Error | Cause / fix |
|---|---|
| `can only be used when context is known` | `measure`/`here`/`locate`/`counter.get`/`state.get` outside `#context { }` |
| `expected auto, relative length, or fraction, found integer` | units missing: `10` → `10pt`/`10%` |
| `expected color, gradient, or tiling, found string` | `fill: "red"` → `red`/`rgb(...)` |
| `unknown variable: X` | missing `#`, multi-letter math run, undefined name, or use-before-definition |
| `cannot join integer with integer` | side-effect loop/block yields non-content values → end with `none` |
| `unexpected argument` / `the argument b is positional` | named-without-default or positional-for-default mismatch |
| `type arguments has no method sum` | `..args` is `arguments` → `args.pos().sum()` |
| `module 'math' does not contain 'eval'` | `#eval(src, mode: "math")` |
| `only element functions can be used in set rules` | `#set` on non-element (e.g. `#set lorem(...)`) |
| `page configuration is not allowed inside of containers` | `#set page(...)` in block/function — top-level only |
| `cannot reference text` / `cannot reference link` | `@` ref on plain text/link — label headings/figures/equations |
| `label '<key>' does not exist in the document` | `@key` typo or missing bib entry (not "unknown citation" on 0.13) |
| `text is not locatable` | `typst query` on text — query headings/labels or add `#metadata` |
| `unknown font family` | font not installed → fallback; check `typst fonts` |
| `cannot divide by zero` | guard the division |
| `the character '&'/'%' is not valid in code` / `expected expression` for `!` | use `and`/`or`/`not`, `calc.rem`, `not` |
| `package @preview/x:0.1.0 not found` | wrong pin/typo/case/offline; check universe |
| `expected expression` | `# heading` (Markdown ATX) — `#` is code mode |
| `expected content, found function` | passed a function where content expected (e.g. `limits(sum)` when `sum` is shadowed) |
| `invalid number suffix: h` | no duration literals → `duration(hours: 1)` |

## 13. Version notes (0.13 vs 0.14/0.15)

- **0.14 added**: `frac(style:)`, `math.scr`, `equation(alt:)`, `title` element, `counter.update(level:, value:)` positional tuples, better math text shaping, `sym.chevron.*`, tables/par/enum/list locatable.
- **0.15 added**: `path` type (explicitly file-relative), `typst eval` (supersedes `typst query`), backslash ban in paths, `--pretty`, multiple bibliographies (`target:`/`group:`), built-in shadowing warnings. (Watch live-reload for HTML was 0.13.0.)
- **0.13**: `style()`/`measure(styles:)` removed (use `context`); `state.display()` removed; `path`→`curve` deprecated 0.13 / removed 0.14 (visualize); image arg `path:`→`source:`; `linear-gradient`→`gradient.linear`; no duration literals; `par` show rules only affect "proper paragraphs"; removed symbols `ohm`, `kelvin`, `degree.c/f`. (`float()` was removed in **0.12** — use `place(float: true)`.)
- Symbols drift: only `times.o` is genuinely absent in 0.13 (use `times.circle`; `plus.circle`, `ast.circle`, `dot.o`); `inter`, `sect` (deprecated), `numero`, `eq.triple.not` were ADDED in 0.13.0 and exist. Verify against the version's table.

## 14. Rules of thumb

1. Strings render literally; content `[...]` parses. Math needs content.
2. `*` = strong, `_` = emph, `\`+space = linebreak, `//` = comment. `$...$` is the only LaTeX survivor.
3. Multi-letter math = variable lookup; group scripts/fractions with parens; `{}` never groups.
4. One `#` per expression in markup, none inside code blocks.
5. Named params need defaults; `..args` → `.pos()`.
6. Units on every length; `and/or/not`, `calc.*`, `gradient.linear`.
7. `context` unlocks measure/here/counters/state/query.
8. set/show apply to content after them; show-everything templates go at the top.
9. Pin package versions exactly; distrust old tutorials — verify on typst.app/universe.
10. Verify symbols/functions against the target version's docs, not the live (newer) table.
