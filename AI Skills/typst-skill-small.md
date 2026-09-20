---
name: typst-small
description: Core Typst essentials for ultra-small models. Modes, string-vs-content, markup, scripting, math, top mistakes, compile.
---

# Typst Core (small model edition)

**Three modes**: markup (default) | math `$..$` | code `#expr` or `{..}`. `[...]` = content block (parsed markup inside code; no `#` needed inside).

**"..." vs [...]**: strings are literal data, NEVER parsed. `#box("Super text $A!=B$")` prints `$A!=B$` literally. `#box([Super text $A!=B$])` renders real math. Anything to be formatted (math, bold) must be `[...]`.

**Markup**: blank line = paragraph · `\` (backslash+space) = line break · `= H1 == H2 === H3` headings · `- item` bullet, `+ item` numbered, `/ Term: desc` lists · `*strong*` `_emph_` (swapped vs Markdown!) · `` `raw` `` · `https://` auto-link · `<label>` + `@ref` · `//` comment · `\$` `\#` escapes.

**Scripting**: `#let x = 5` · `#set text(11pt)` (defaults from here on) · `#show heading: set text(navy)` · `#show heading: it => block[#emph(it.body)]` (transform) · `#if c [..] else [..]` · `#for i in range(3) [..]` · `#let f(a, b: 1) = ...` — named args need defaults; call `#f(1, b: 2)`. No `&&`/`!`/`%` — use `and`/`not` (write `#(not x)` in markup)/`calc.rem`. `@ref` works on labeled headings/figures/equations, not plain text.

**Math**: `$x^2$` inline; `$ x^2 $` (space both ends) = centered block. Multi-letter = variable lookup: `$xy$` errors, `$x y$` = x·y. Scripts take ONE atom — group with parens: `$e^(i Theta + pi)$`, `$x_(i, j)$`. `{ }` are VISIBLE braces; never `x_{n+1}`. Fractions: `$a/(b + c)$`, `$(partial u)/(partial x)$`. Symbols by name: `alpha pi sum_(i=0)^n`. Strings in math = upright text: `$a "is text"$`.

**Layout**: `#set page(paper: "a4", margin: 2cm, numbering: "1")` · `#box[inline]` / `#block(breakable: true)[block]` / `#place(top + right)[overlay]` · `#grid(columns: (1fr, 2fr))` · `#v(1fr)` `#h(1fr)` spacing. Lengths need units: `10pt`, `50%`; `1fr` only in flex containers (grid/table/`v`/`h`).

**Top mistakes**:
| ❌ | ✅ |
|---|---|
| `\\` newline | `\` + space |
| `\frac` `\textbf` | `$1/2$`, `*bold*` |
| `**bold**` | `*bold*` |
| `#box(width: 10)` | `10pt` / `10%` |
| `math.eval` | `#eval("x^2", mode: "math")` |
| `min()` `1h` | `calc.min`, `duration(hours: 1)` |

**Compile**: `typst compile --root . main.typ` — paths resolve from the root, not the file's folder.
