---
name: typst-master
description: High-level Typst (0.13+) expertise — markup, scripting, math, layout, styling, packages. Use when writing, fixing, or optimizing .typ files. Code-first, verified against official docs and real compilers.
---

# Typst — The Skill

Target: Typst 0.13 (deltas for 0.14/0.15 noted). Every snippet verified. Compact by design: snippets > prose.

## 0. Mental model (read first)

**Three modes**: markup (default) → `#` enters **code**, `$..$` enters **math**, `[..]` is a **content block** (markup inside code). In code mode, no `#` needed.

**Strings vs content — the #1 trap.**
- `"..."` = plain data. **Never parsed.** `#box("Super text $A!=B$")` compiles but prints `$A!=B$` literally.
- `[...]` = parsed markup. `#box([Super text $A!=B$])` renders real math `A≠B`.
- Rule: strings for *data* (paths, keys, labels); content for *rendering*. When in doubt: `[...]`.

**Typst ≠ LaTeX ≠ Markdown.** The ONLY LaTeX habit that works: `$...$`. Everything else silently renders as literal text (no error!) or errors in math. `*text*` = **strong** (bold), `_text_` = **emph** (italic) — *swapped* vs Markdown.

## 1. Markup syntax

| Want | Syntax |
|---|---|
| paragraph break | blank line |
| line break | `\` (backslash, followed by space or EOL) — **`\\` prints a literal backslash** |
| strong (bold) | `*text*` |
| emphasis (italic) | `_text_` |
| headings | `= H1` `== H2` `=== H3` |
| lists | `- bullet` `+ numbered` (indent 2 spaces to nest) |
| term list | `/ Term: description` |
| raw code | `` `code` `` |
| link | bare `https://…` auto-links; `#link("url")[text]` |
| label / ref | `<intro>` / `@intro` |
| escape | `\$ \# \* \_ \= \~ \; \\` `\u{1f600}` |
| symbols | `~` nbsp, `---` em dash, `--` en dash, `...` ellipsis |
| comment | `// line` `/* block */` |

Mistakes: `\\` = literal `\` (not newline); `\frac`/`\textbf`/`\emph`/`\section{}` = silent garbage (control escapes); `**bold**` = warning + literal; `# heading` = error (`#` is code mode); `## heading`, `<br>`, `| a | b |` tables = literal text; `% comment` doesn't work (use `//`).

## 2. Scripting

```typst
#let x = 5                      // binding (kebab-case names)
#(1 + 2)                        // parenthesize compound exprs
#let f(a, b: 1, ..rest) = ...   // positional, named (needs default), sink
#f(1, b: 2)                     // ✅   #f(1, 2) ❌ "unexpected argument"
#box[content] ≡ #box([content]) // trailing content block
#if c [..] else if d {..} else [..]
#for x in range(3) [..]         // also: strings, dicts, arrays; destructure (k, v)
#while cond { ..; none }        // blocks join values → loops must end in none or content
```

- Operators: `and or not` (NOT `&& || !`); math via `calc.min calc.max calc.abs calc.pow calc.sqrt calc.rem` (NOT `min % **`); `gradient.linear` (NOT `linear-gradient`); `1h` is invalid → `duration(hours: 1)`.
- `..args` is the **arguments** type → `args.pos()`, `args.named()` (not an array).
- Functions are pure; document state needs `state`/`counter`, not variables.
- Types: length `10pt 2cm 1em`, ratio `50%`, fraction `1fr` (grid/table/stack only), angle `90deg`, color `red rgb("#0178A4")`, gradient `gradient.linear(red, blue)`, stroke `1pt + red`, alignment `center top + right`. `int` where length expected = error.
- Mistakes: missing `#` renders literally; `#let x = 5; x + 1` renders "x + 1" (the `;` ends the code expr — use `#(x + 1)`); named args without declared defaults error; loop bodies yielding ints → "cannot join integer with integer"; definitions before use (no hoisting).

## 3. Math mode (highest-failure area)

Enter: `$x^2$` inline; `$ x^2 $` (space at **both** ends) = block. `$...$` works in headings, tables, code (`#let e = $x^2$`).

**Identifiers**: single letters/digits are characters. **Any multi-letter run is a variable lookup** — `$xy$`, `$sqrt x$`, `$foo(x)$` → `unknown variable`. ✅ `$x y$` = x·y; `$2 pi r$` = 2πr; `$sin x$` = sin·x. `#let` names resolve: `#let alpha = 1; $alpha$` → 1, but `#let x = 5; $x$` still prints the letter → use `$#x$`.

**Scripts take ONE atom**: group with parens (parens are *absorbed* in scripts):
- `$e^(i Theta + pi)$` ✅ (`e^(i Theta) + pi` puts `+pi` outside)
- `$log_(n+1)(Theta + pi)$` ✅ parens shown + auto-scaled
- `$x_(i, j)^(n + 1)$` ✅
- `$e^x^2$` = e^(x²) — chained scripts nest (valid, not an error); `$x_1^2$` ≡ `$x^2_1$`
- `{ }` are **visible braces** — never use `x_{n+1}` (braces render!); group with parens `x_(n+1)`
- `$a^b c$` → c NOT in exponent.

**Fractions**: `$a/(b + c)$`; `/` is left-assoc: `a/b/c` = (a/b)/c. Parens around numerator/denominator vanish: `$(x+1)/2$` shows no parens (`((x+1))/2` keeps one). `(partial u)/(partial x)` ✅ (`\partial` ❌). `$a//b$` is a *comment*, not division. `frac(a, b)` explicit form.

**Symbols**: bare names work (`alpha pi sum integral partial nabla theta Gamma`), shorthands (`!= -> => <=> := <= >= dots`), modifiers (`arrow.r.long gt.eq.not phi.alt dots.v`), `RR NN ZZ QQ CC` blackboard, `bb(x) cal(L) frak(g) mono(x) bold(x) upright(x)`, Greek via Unicode also fine. `dot` (NOT `cdot`), `oo` (NOT `infty`), `dif` = upright differential d. `bar` is the `|` glyph — for \bar{x} use `overline(x)` or `accent(x, macron)`; accents that work: `hat(x) tilde(x) vec(x) dot(x)`.

**Functions/operators**: `sin cos log exp lim max min det` are upright op-elements; `$sin(x + y)$` = sin of (x+y), but `$sin x + y$` = (sin x) + y. `sqrt(x) root(n, x)` (index FIRST) `abs(x) floor(x) ceil(x) binom(n, k) op("foo")`.

**Delimiters**: `( ) [ ] { }` auto-scale when matched. `lr(...)` forces it; `abs(x)`/`norm(x)` for bars — **plain `|x|` does NOT scale**; `\|` is a literal pipe escape.

**Strings in math** = upright text: `$a "is natural"$`. Spacing: `thin med thick quad wide`; or `#h(1em)`.

**Code in math**: `$x = #(2*3)$` → x = 6; `$#x$`; `$#sym.alpha$` ≡ `alpha`. **`math.eval` does NOT exist** → `#eval("x^2", mode: "math")` (mode `"math"` mandatory; default is code mode). Beware `$#eval("1+2")$` → renders 3.

**Display math**: numbering via `#set math.equation(numbering: "(1)")`; label+ref `<eq>` / `@eq`; alignment: one `$ .. $` block with `\` row breaks and `&` points (`x &= 1 && y &= 2`); `mat(a, b; c, d)` (rows by `;`), `vec(a, b, c)` (1D — no `;`), `cases(a &= 1, b &= 2)`; `underbrace(a + b)_("result")`; `cancel(x)`; `stretch(arrow.r.long)^"over"`; `attach(x, t:, b:, tl:, bl:)`; `limits(x)`/`scripts(x)` force display/inline limits on `sum integral`.

**LaTeX commands in math fail** (backslash escapes one char → `unknown variable`): write `alpha`, `1/2`, `sum_(i=0)^n i`, `lr(`, `"text"`, `RR`, `dif x`, `->`, `dots.c`, `underline(x)`, `(x + 1)/x`.

## 4. Layout

- `box` = inline; `block` = block-level (`block(breakable: true)` for multi-page); `place(top + right, dx: 1cm)` = absolute; **floats**: `place(bottom, float: true)` — there is NO `float()` function in 0.13 (it's the number type!).
- `#v(1fr)` push down, `#h(1fr)` right-align, `#v(1fr)`+`#v(1fr)` center; `h(0pt, weak: true)` kills surrounding space.
- `pad(x:, y:)` — `pad(inset:)` does NOT exist (inset lives on box/block). `grid(columns: (1fr, 2fr))` uniform vs `table` per-cell (span/stroke/alignment). `columns(n)` text flow; `#stack(dir: ltr, spacing: 4pt)`.
- `#align(center)[..]`; `#rotate(90deg)[..]`; `#image("fig.png", width: 80%)` inside `#figure(..., caption: [...])`.
- Mistakes: `box(width: 10)` → error (needs `10pt`/`10%`); `1fr` outside flex containers → error; `#set page(...)` inside blocks/containers → error (top-level only); `place` mid-paragraph breaks the line (wrap in `box`); `measure()`/`here()`/`locate()` outside `context` → "can only be used when context is known".

## 5. Styling (set / show)

```typst
#set text(11pt, fill: rgb("#222"), font: ("Libertinus Serif", "Noto Sans"))
#set page(paper: "a4", margin: 2cm, numbering: "1")
#set heading(numbering: "1.")  #set par(justify: true, leading: 0.65em)
#show heading: set text(navy)          // show-set: props on one element type
#show heading: it => block[#emph(it.body)]  // transform (fields: it.body, it.level)
#show "Project": smallcaps             // selectors: text, regex, <label>, where(level: 1)
#show: template.with(title: [X])       // whole-document (place at TOP)
```

- `#set` only on **element functions** (`#set calc.min(...)` → error); set/show affect only content **after** them in source; scope = enclosing block.
- Prefer `show X: set text(...)` (overridable) over `set text` inside show functions.
- `#text(fill: red, 18pt)[one-shot]`; gradients: `#text(fill: gradient.linear(red, blue))`.
- Running header (context is mandatory): `#set page(header: context { counter(page).display() })`; "Page X of Y" → `numbering: "1 / 1"`.
- `#context counter(heading).get()`, `#counter(heading).update(1)` (0.13: single value; 0.14+: `update(level:, value:)`), `#state("k", def).update(v)` + read in context, `#query(<label>)`, `#metadata(42) <m>`.

## 6. Documents & bibliography

```typst
#bibliography("refs.bib", style: "apa", full: true)  // BibLaTeX or .yml Hayagriva
See @humphrey97 and #cite(<humphrey97>, form: "prose").   // cite AFTER content
#include "chapter1.typ"    // raw content (body text)
#import "lib.typ": fn      // definitions; NO output
#set document(title: "…", author: "…")
```

Mistakes: `@nokey` → "unknown citation"; `full: true` needed to list uncited works; bibliography placed before content renders nothing useful; `#include` a file with `#set`/`#show` rules → those rules **leak** into the whole document (scope them inside blocks or use import + template fn); relative paths resolve against the **project root**, not the file's dir (fix: `--root .`).

## 7. Packages (versions verified 2026-08-08 — always re-verify at typst.app/universe)

Import syntax: `#import "@preview/name:0.1.0": *` — the **exact version is mandatory** (no ranges, no "latest"). Error `package @preview/x:0.1.0 not found` = wrong pin/typo/case/offline. Local installs: `%APPDATA%\typst\packages\local\name\ver` (Roaming); cache `%LOCALAPPDATA%` (Local); `typst info` prints both.

**DEAD packages (404 — do not use):** `arrows`, `vega`, `chart`, `preprint`, `simple`, `artify`, `ieee-conf`, `thesis`, `academic`, `emojify`, `grify`, `circo`, `metropolis`. `hydra` is **running headers** (not drawing). Emoji is **built-in** since 0.13: `#emoji.face` (`#import emoji: face`).

```typst
// CeTZ diagrams — pin 0.4.2 for Typst 0.13; 0.5.2 needs Typst ≥ 0.14
#import "@preview/cetz:0.4.2"
#cetz.canvas({                       // code block, NOT [content]
  import cetz.draw: *                // draw fns are NOT top-level
  line((0, 0), (3, 2), mark: (end: ">"))
  circle((1.5, 1), radius: 1cm, fill: blue.lighten(80%))
  content((3, 3), [label], anchor: "bottom-left")  // 0.4.x: content(); 0.5+: text()
})
// 1 unit = 1cm by default; canvas(length: 5cm) rescales; polar (30deg, 2); relative (+1, 0)

// Commutative diagrams & flowcharts — fletcher
#import "@preview/fletcher:0.5.8": diagram, node, edge, shapes
#diagram(cell-size: 15mm, $ G edge(f, ->) edge("d", pi, ->>) & im(f) \ $)
#diagram(node((0, 0), [Start]), edge("-|>"), node((0, 1), [Process], shape: shapes.diamond))
// 0.5.x: NO flow(), NO `A -- B`/`=>`; string labels only as named arg label:

// Plotting — cetz-plot (needs cetz ≥ 0.5 → Typst ≥ 0.14) or matplotlib → PNG
// (for 0.13 or complex stats: python matplotlib → #image("plot.png", width: 100%) is the right call)

// Vega-Lite → nulite (vega is dead); data must be inline, size via render()
#import "@preview/nulite:0.1.0": render
#render(width: 100%, height: 100%, json("spec.json"))

// Slides — touying (recommended) or polylux
#import "@preview/touying:0.7.4": *
#import themes.simple: *             // themes is a submodule, NOT a package
#show: simple-theme.with(aspect-ratio: "16-9")
= Title slide          // = level-1 heading
== Slide one           // == level-2 = each slide
#pause                 // own line
#import "@preview/polylux:0.4.0": *   // 0.4 removed #pause → #show: later; no === separators

// Code blocks — codly
#import "@preview/codly:1.3.0": *
#show: codly-init.with()             // forget this → codly does nothing

// QR codes — cades (grify is dead)
#import "@preview/cades:0.3.1": qr-code
#qr-code("https://typst.app", width: 3cm)

// Templates — apply via show rule or nothing happens
#import "@preview/charged-ieee:0.1.4": ieee
#show: ieee.with(title: [...], authors: ((name: "…", email: "…"),))  // authors: NOT author:
#import "@preview/modern-cv:0.10.0": *   // needs Roboto/Source Sans Pro/FontAwesome fonts
#show: resume.with(author: (firstname: "J", lastname: "S"))
```

## 8. CLI

```sh
typst compile --root . main.typ        # --root fixes #image/#include/#bibliography paths
typst watch main.typ
typst compile main.typ out-{0p}.png --format png --ppi 300   # {0p} for multi-page; --ppi or blurry
typst fonts                            # verify font discovery before debugging fallbacks
typst query main.typ "heading" --field body --one
typst init @preview/name:version
# env: TYPST_FONT_PATHS, TYPST_ROOT; --input k=v → sys.inputs.k
# use forward slashes in paths (0.15 bans backslashes); tinymist = LSP, typst-fmt = formatter
```

## 9. Debugging

`#repr(x)` inspect elements, `#type(x)` inspect type, `#context text.size` active styles, `typst query` instead of eyeballing PDFs.

Error → cause: "can only be used when context is known" → wrap in `#context`; "expected …, found string/int" → wrong type (units, colors as values); "unknown variable: X" → missing `#` or multi-letter math run or undefined name; "cannot join integer with integer" → side-effect loop needs trailing `none`; "unexpected argument"/"argument is positional" → named-vs-default mismatch; "module 'math' does not contain 'eval'" → use `#eval(.., mode: "math")`; "only element functions can be used in set rules" → `#set` needs an element; "unknown font family" → silent fallback, check `typst fonts`; "text is not locatable" → query headings/labels/metadata, not text.

## 10. Rules of thumb

1. Strings render literally; content `[...]` parses. Math needs content.
2. `*` = strong, `_` = emph, `\`+space = linebreak, `//` = comment. `$...$` is the only LaTeX survivor.
3. Multi-letter math = variable lookup; group scripts/fractions with parens; `{}` never groups.
4. One `#` per expression in markup, none inside code blocks.
5. Named params need defaults; `..args` → `.pos()`.
6. Units on every length (`10pt` not `10`); `and/or/not`, `calc.*`, `gradient.linear`.
7. `context` unlocks measure/here/counters/state/query.
8. set/show apply to content after them; show-everything templates go at the top.
9. Pin package versions exactly; distrust old tutorials — verify on typst.app/universe.
10. Version-sensitivity: verify symbols/functions against the 0.13 docs table (0.14+ added `frac(style:)`, `math.scr`, `equation(alt:)`, `title`; 0.15 added `path` type, `typst eval`).
