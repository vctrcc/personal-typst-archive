---
name: typst-medium
description: Balanced Typst (0.13) skill for standard models. Modes, content model, markup, scripting, math, layout, styling, packages, CLI, mistakes.
---

# Typst — Balanced Skill (Typst 0.13)

## 0. Mental model

**Three modes**: markup (default) → `#` enters **code**, `$..$` enters **math**, `[...]` = **content block** (markup inside code, no `#` inside).

**Strings vs content — the #1 trap**: `"..."` is **never parsed**. `#box("Super text $A!=B$")` compiles but prints `$A!=B$` literally. `#box([Super text $A!=B$])` renders real math `A≠B`. Strings = data; content = rendering. When in doubt: `[...]`.

**Typst ≠ LaTeX ≠ Markdown**: the ONLY LaTeX habit that works is `$...$`. Everything else renders literally (no error!) or errors in math. `*text*` = **strong** (bold), `_text_` = **emph** (italic) — swapped vs Markdown.

## 1. Markup

| Want | Syntax |
|---|---|
| paragraph break | blank line |
| line break | `\` + space or EOL — **`\\` prints a literal backslash** |
| strong / emph | `*text*` / `_text_` |
| headings | `= H1` `== H2` `=== H3` |
| lists | `- item` `+ item` (indent 2 to nest) `/ Term: desc` |
| raw code | `` `code` `` |
| link | bare `https://…` auto-links; `#link("url")[text]` |
| label / ref | `<intro>` / `@intro` |
| escape | `\$ \# \* \_ \~ \u{1f600}` |
| comment | `// line` `/* block */` |

Mistakes: `\\` = literal `\`; `\frac`/`\textbf` = silent garbage; `**bold**` = warning; `# heading` = error (code mode!); `## heading` = error (2nd `#` re-enters code); `<br>`, `| a | b |` = literal.

## 2. Scripting

```typst
#let x = 5                      // kebab-case names
#(1 + 2)                        // parenthesize compound exprs
#let f(a, b: 1, ..rest) = ...   // named args need declared defaults
#f(1, b: 2)                     // ✅   #f(1, 2) ❌ "unexpected argument"
#box[content] ≡ #box([content]) // trailing content block
#if c [..] else if d {..} else [..]
#for x in range(3) [..]         // also dicts/strings/arrays; for (k, v) in dict
#while cond { ..; none }        // loops join values → end side-effect loops with none
```

- Operators: `and or not` (NOT `&& !`); math via `calc.min/abs/pow/sqrt/rem` (NOT `min % **`); `gradient.linear`; no duration literals → `duration(hours: 1)`.
- `..args` is the **arguments** type → `args.pos()`, `args.named()` (not an array).
- Functions are pure; document state uses `state`/`counter`, not variables.
- Types: length `10pt 2cm 1em`, ratio `50%`, fraction `1fr` (grid/table/stack only), angle `90deg`, color `red rgb("#0178A4")`, stroke `1pt + red`, alignment `top + right`.
- Mistakes: missing `#` renders literally; `#let x = 5; x + 1` renders "x + 1"; loop bodies yielding ints → "cannot join integer with integer".

## 3. Math mode

Enter: `$x^2$` inline; `$ x^2 $` (space at **both** ends) = block. `$...$` works in headings, tables, code (`#let e = $x^2$`).

**Identifiers**: single letters are characters. **Any multi-letter run is a variable lookup**: `$xy$`, `$sqrt x$`, `$foo(x)$` → `unknown variable`. ✅ `$x y$` = x·y. `#let alpha = 1; $alpha$` → 1, but `#let x = 5; $x$` prints the letter → use `$#x$`.

**Scripts take ONE atom** — group with parens (absorbed in scripts):
- `$e^(i Theta + pi)$` ✅ (`$e^(i Theta) + pi$` puts `+pi` outside)
- `$log_(n+1)(Theta + pi)$` ✅ parens shown, auto-scaled
- `$e^x^2$` = e^(x²) (chained scripts nest — valid); `$x_1^2$` ≡ `$x^2_1$`
- After a subscripted symbol, add a space before its arguments: `$H_b (p)$` ✅, `$H_b(p)$` ❌. With no space, the call can bind to the subscript, producing `H_(b(p))` instead of `H_b` applied to `p`.
- `{ }` are **visible braces** — never `x_{n+1}`; group with `( )`: `x_(n+1)`
- `$a^b c$` → c NOT in exponent.

**Fractions**: `$a/(b + c)$`; `/` is left-assoc (`a/b/c` = (a/b)/c). Parens around num/denominator vanish (`(x+1)/2` none shown; `((x+1))/2` one pair). `$(partial u)/(partial x)$` ✅; `$a//b$` is a *comment*, not division. `frac(a, b)` explicit.

**Symbols**: bare names (`alpha pi sum integral partial oo`), shorthands (`!= -> => <=> <= >= dots`), modifiers (`arrow.r.long gt.eq.not phi.alt`), `RR NN ZZ QQ CC`, `bb(x) cal(L) frak(g) mono(x) bold(x) upright(x)`, `dot` (NOT `cdot`), `dif` = upright d. `bar` = the `|` glyph → use `overline(x)`/`accent(x, macron)`; `hat(x) tilde(x) vec(x)` work.

**Operators/functions**: `sin cos log exp lim max min det` = upright ops; `$sin(x + y)$` ≠ `$sin x + y$` (=(sin x)+y). `sqrt(x) root(n, x)` (index FIRST) `abs(x) floor(x) ceil(x) binom(n, k) op("foo")`.

**Delimiters**: matched `( ) [ ] { }` auto-scale; `lr(...)` forces; `abs(x)`/`norm(x)` for bars — **plain `|x|` does NOT scale**. **Text/spacing**: `$a "is natural"$` = upright; `thin med thick quad`; `#h(1em)`.

**Code in math**: `$x = #(2*3)$` → x = 6; `$#x$`; `$#sym.alpha$` ≡ `alpha`. **`math.eval` does NOT exist** → `#eval("x^2", mode: "math")` (mode mandatory).

**Display math**: numbering via `#set math.equation(numbering: "(1)")`; `<eq>` + `@eq`; align: one `$` block, `\` rows, `&` points (`x &= 1 && y &= 2`); `mat(a, b; c, d)` (rows by `;`), `vec(a, b, c)` (1D), `cases(a &= 1, b &= 2)`; `underbrace(a + b)_("result")`; `cancel(x)`; `attach(x, t:, b:)`; `limits(x)`/`scripts(x)` for sum limits.

**LaTeX commands in math fail** (`\alpha` → `unknown variable`): write `alpha`, `1/2`, `sum_(i=0)^n i`, `lr(`, `"text"`, `RR`, `->`, `dots.c`, `underline(x)`.

## 4. Layout

- `box` = inline; `block` = block-level (`block(breakable: true)` multi-page); `place(top + right, dx: 1cm)` = absolute; **floats**: `place(bottom, float: true)` — NO `float()` function in 0.13 (it's the number type!).
- `#v(1fr)` push, `#h(1fr)` right-align, `h(0pt, weak: true)` kills space.
- `pad(x:, y:)` — `pad(inset:)` doesn't exist (inset is on box/block). `grid(columns: (1fr, 2fr))` uniform vs `table` per-cell. `columns(n)`; `#align(center)`; `#rotate(90deg)`.
- `#figure(image("fig.png", width: 80%), caption: [...])`.
- `#set page(margin: 10)` → error (needs units); `1fr` outside flex containers → error; `#set page(...)` inside containers → error (top-level only); `place` mid-paragraph breaks the line (wrap in `box`); `measure()`/`here()`/`locate()` outside `context` → "can only be used when context is known".

## 5. Styling (set / show)

```typst
#set text(11pt, fill: rgb("#222"), font: ("Libertinus Serif", "Noto Sans"))
#set page(paper: "a4", margin: 2cm, numbering: "1")
#set heading(numbering: "1.")  #set par(justify: true, leading: 0.65em)
#show heading: set text(navy)                 // show-set (overridable)
#show heading: it => block[#emph(it.body)]    // transform; fields: it.body, it.level
#show "Project": smallcaps                    // selectors: text, regex, <label>, where(level: 1)
#show: template.with(title: [X])              // whole-document — place at TOP
#text(fill: red, 18pt)[one-shot]
```

- `#set` only on **element functions**; set/show affect content **after** them only; scope = enclosing block.
- Running header (context mandatory): `#set page(header: context { counter(page).display() })`; "Page X of Y" → `numbering: "1 / 1"`.
- `#context counter(heading).get()`; `#counter(heading).update(1)` (0.13); `#state("k", def).update(v)` read in context; `#context query(<label>)`; `#metadata(42) <m>` + `query(<m>).first().value`.

## 6. Documents & bibliography

```typst
#bibliography("refs.bib", style: "apa", full: true)   // BibLaTeX or .yml Hayagriva
#include "chapter1.typ"   // raw content (body text)
#import "lib.typ": fn     // definitions, no output
#set document(title: "…", author: "…")
```

Mistakes: `@nokey` → `label '<nokey>' does not exist`; `full: true` lists uncited works; `#include`d `#set`/`#show` rules **leak** into the whole doc (scope them or import a template fn); relative paths resolve from the **including file's dir** (`--root .` = security boundary).

## 7. Packages (versions verified 2026-08-08 — re-verify at typst.app/universe)

Import: `#import "@preview/name:0.1.0": *` — exact version mandatory (no ranges). `package @preview/x:0.1.0 not found` = wrong pin/typo/case/offline. Local installs & cache: `%LOCALAPPDATA%\typst\packages\{local,preview}\name\ver` (verified 0.13.1).

**DEAD (404 — do not use):** `arrows`, `vega`, `chart`, `preprint`, `simple`, `artify`, `ieee-conf`, `thesis`, `academic`, `emojify`, `grify`, `circo`, `metropolis`. `hydra` = running headers. Emoji built-in (0.13+): `#emoji.face`.

```typst
// CeTZ — pin 0.4.2 for Typst 0.13; 0.5.2 needs Typst ≥ 0.14
#import "@preview/cetz:0.4.2"
#cetz.canvas({                       // code block, NOT [content]
  import cetz.draw: *                // draw fns are NOT top-level
  line((0, 0), (3, 2), mark: (end: ">"))
  circle((1.5, 1), radius: 1cm, fill: blue.lighten(80%))
  content((3, 3), [label], anchor: "south-west")  // 0.4.x: content(); 0.5+: text()
})
// 1 unit = 1cm; canvas(length: 5cm) rescales; polar coords (30deg, 2)

// Commutative diagrams & flowcharts — fletcher
#import "@preview/fletcher:0.5.8": diagram, node, edge, shapes
#diagram(cell-size: 15mm, $ G edge(f, ->) edge("d", pi, ->>) & im(f) \ $)
#diagram(node((0, 0), [Start]), edge("-|>"), node((0, 1), [Process], shape: shapes.diamond))
// NO flow(), NO `A -- B`/`=>` (0.1.x-era); string labels via label:

// Slides — touying (recommended) or polylux
#import "@preview/touying:0.7.4": *
#import themes.simple: *             // submodule of touying
#show: simple-theme.with(aspect-ratio: "16-9")
= Title slide          // = level-1 heading
== Slide one           // == level-2 = each slide
#pause                 // on its own line
#import "@preview/polylux:0.4.0": *   // 0.4 removed #pause → #show: later; no === separators

// Code blocks — codly
#import "@preview/codly:1.3.0": *
#show: codly-init.with()             // mandatory — without it codly does nothing

// QR — cades (grify is dead)
#import "@preview/cades:0.3.1": qr-code
#qr-code("https://typst.app", width: 3cm)

// Templates — apply via show rule or nothing happens
#import "@preview/charged-ieee:0.1.4": ieee
#show: ieee.with(title: [...], authors: ((name: "…", email: "…"),))  // authors:, NOT author:
#import "@preview/modern-cv:0.10.0": *   // needs Roboto/Source Sans Pro/FontAwesome fonts
#show: resume.with(author: (firstname: "J", lastname: "S", positions: ()), profile-picture: none)
```

## 8. CLI

```sh
typst compile --root . main.typ        # --root fixes #image/#include/#bibliography paths
typst watch main.typ
typst compile main.typ out-{0p}.png --format png --ppi 300   # --ppi or blurry
typst fonts                            # verify font discovery
typst query main.typ "heading" --field body --one
typst init @preview/name:version
# env: TYPST_FONT_PATHS, TYPST_ROOT; --input k=v → sys.inputs.k
```

## 9. Debugging

`#repr(x)` inspect elements · `#type(x)` inspect type · `#context text.size` active styles · `typst query` to inspect output.

Error → cause: "can only be used when context is known" → wrap in `#context`; "expected …, found string/int" → wrong type; "unknown variable" → missing `#` or multi-letter math run; "cannot join integer with integer" → loop needs trailing `none`; "module 'math' does not contain 'eval'" → `#eval(.., mode: "math")`; "only element functions can be used in set rules" → `#set` needs an element; "unknown font family" → `typst fonts`; "text is not locatable" → query headings/labels.

## 10. Rules of thumb

1. Strings render literally; `[...]` parses. `*` = strong, `_` = emph, `\`+space = linebreak; `$...$` is the only LaTeX survivor.
2. Multi-letter math = variable lookup; group scripts/fractions with parens; `{}` never groups.
3. Named params need defaults; `..args` → `.pos()`; units on every length.
4. `and/or/not`, `calc.*`, `gradient.linear`; `context` unlocks measure/counters/state.
5. set/show apply to content after them; show-everything templates go at the top.
6. Pin package versions exactly; distrust old tutorials — verify on typst.app/universe.
7. 0.14+ added `frac(style:)`, `math.scr`, `equation(alt:)`, `title`; 0.15 added `path`, `typst eval`.
