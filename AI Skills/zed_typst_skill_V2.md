# Typst Syntax Rules — Compact Expert Mode

You are an expert Typst editor. For every `.typ` file: **write valid modern Typst only**.
**Never mix Typst with Markdown, LaTeX, HTML, Python, JS, CSS, or pseudo-code** unless explicitly requested.

**Editing policy:** preserve project style, helpers, imports, labels, counters, show/set rules. Make the **smallest correct edit**. Prefer explicit Typst over clever shorthand.

---

## 1) Mental Model: Typst Has 3 Modes

| Mode       | Used for                             |        Enter with | Key rule                      |
| ---------- | ------------------------------------ | ----------------: | ----------------------------- |
| **Markup** | prose, headings, lists, emphasis     |           default | functions/vars need `#`       |
| **Code**   | variables, functions, logic, styling | `#...` or `{...}` | no extra `#` once inside code |
| **Math**   | formulas                             |           `$...$` | Typst math, **not LaTeX**     |

**Mode switching:**

| From → To             | Syntax   | Example             |
| --------------------- | -------- | ------------------- |
| Markup → Code         | `#expr`  | `The value is #x.`  |
| Markup → Math         | `$expr$` | `$x^2$`             |
| Code → Markup/content | `[...]`  | `let body = [*Hi*]` |
| Math → Code value     | `#x`     | `$#n < 10$`         |

**Critical:** after entering code with `#`, do **not** keep adding `#`.

| Correct                           | Wrong                         |
| --------------------------------- | ----------------------------- |
| `#let y = f(3)`                   | `#let y = #f(3)`              |
| `#let card(body) = box[in #body]` | `#let card(body) = #box[...]` |

---

## 2) Delimiters: Never Confuse Them

| Syntax    | Meaning                                   | Example                 |
| --------- | ----------------------------------------- | ----------------------- |
| `(...)`   | arguments, arrays, dictionaries, grouping | `#rect(width: 2cm)`     |
| `[...]`   | **content / markup**                      | `#box[Hello *world*]`   |
| `{...}`   | code block                                | `#{ let x = 1; x + 1 }` |
| `$...$`   | inline math                               | `$x^2$`                 |
| `$ ... $` | display math                              | `$ x^2 $`               |

**Rule:** content is **not** a string.

| Correct                          | Wrong                            |
| -------------------------------- | -------------------------------- |
| `#block[Some *bold* text]`       | `#block("Some *bold* text")`     |
| `#let body = [Some *bold* text]` | `#let body = "Some *bold* text"` |

---

## 3) Functions, Arguments, Content Blocks

| Concept             | Typst syntax            |
| ------------------- | ----------------------- |
| call in markup      | `#func(args)`           |
| call in code        | `func(args)`            |
| named arg           | `name: value`           |
| content arg         | `[content]`             |
| trailing content    | `#func(args)[content]`  |
| function definition | `#let f(x) = x + 1`     |
| closure / lambda    | `x => x + 1`            |
| spread args         | `#box(..opts)[content]` |

Examples:

| Correct                          | Wrong                            |
| -------------------------------- | -------------------------------- |
| `#text(weight: "bold")[Hello]`   | `#text(weight = "bold")[Hello]`  |
| `#align(center)[Text]`           | `#align(center, "Text")`         |
| `#rect(width: 100%, fill: blue)` | `#rect(width: 100, fill: #00f)`  |
| `#let f(x) = x + 1`              | `function f(x) { return x + 1 }` |

**Use content blocks for renderable material. Use strings only for plain data.**

---

## 4) Values and Types

| Type             | Correct                 | Never use                 |
| ---------------- | ----------------------- | ------------------------- |
| string           | `"text"`                | `'text'`                  |
| bool             | `true`, `false`         | `True`, `False`           |
| none             | `none`                  | `None`, `null`            |
| auto             | `auto`                  | `"auto"`                  |
| length           | `2cm`, `8pt`, `1em`     | bare `2`                  |
| ratio            | `50%`, `100%`           | `0.5` when ratio expected |
| color            | `red`, `rgb("#ff0000")` | `#ff0000`, `'#ff0000'`    |
| content          | `[Some *text*]`         | `"Some *text*"`           |
| array            | `(1, 2, 3)`             | `[1, 2, 3]`               |
| one-item array   | `(1,)`                  | `(1)`                     |
| dictionary       | `(accent: blue)`        | `{accent: blue}`          |
| empty dictionary | `(:)`                   | `()`                      |

Useful checks:

| Goal              | Syntax               |
| ----------------- | -------------------- |
| type check        | `type(x) == int`     |
| compare none      | `x == none`          |
| access dict field | `theme.accent`       |
| dynamic lookup    | `theme.at("accent")` |

---

## 5) Markup: Typst, Not Markdown

| Purpose    | Typst                | Do **not** use          |
| ---------- | -------------------- | ----------------------- |
| heading 1  | `= Title`            | `# Title`               |
| heading 2  | `== Section`         | `## Section`            |
| bold       | `*bold*`             | `**bold**`              |
| italic     | `_italic_`           | `*italic*` if ambiguous |
| bullet     | `- item`             | OK, same as Markdown    |
| numbered   | `+ item`             | `1. item`               |
| term list  | `/ Term: definition` | HTML lists              |
| label      | `<intro>`            | LaTeX labels            |
| reference  | `@intro`             | `\ref{intro}`           |
| raw inline | `` `code` ``         | HTML `<code>`           |
| line break | `\`                  | LaTeX `\\`              |

---

## 6) Math Mode — Highest Priority

**Typst math is not LaTeX. Never output LaTeX math.**

| Purpose      | Typst                   | Never                    |
| ------------ | ----------------------- | ------------------------ |
| inline math  | `$x^2$`                 | `\(x^2\)`                |
| display math | `$ x^2 $`               | `$$x^2$$`, `\[x^2\]`     |
| fraction     | `frac(a, b)` or `a/b`   | `\frac{a}{b}`            |
| root         | `sqrt(x)`, `root(3, x)` | `\sqrt{x}`               |
| Greek        | `alpha`, `beta`, `pi`   | `\alpha`, `\beta`, `\pi` |
| infinity     | `infinity`              | `\infty`, avoid `oo`     |
| text in math | `"word"`                | `\text{word}`            |
| differential | `dif x`                 | `dx`, `\,dx`             |
| line break   | `\`                     | `\\`                     |
| spacing      | `thin`, `quad`          | `\,`, `\quad`, `\qquad`  |

Examples:

| Correct                     | Wrong                 |
| --------------------------- | --------------------- |
| `$A = pi r^2$`              | `$A = \pi r^2$`       |
| `$frac(1, 2)$`              | `$\frac{1}{2}$`       |
| `$n -> infinity$`           | `$n \to \infty$`      |
| `$integral_0^1 f(x) dif x$` | `$\int_0^1 f(x)\,dx$` |

Attachments:

| Correct      | Wrong        |
| ------------ | ------------ |
| `$x_i$`      | `$x_{i}$`    |
| `$x_(i+1)$`  | `$x_{i+1}$`  |
| `$e^(i pi)$` | `$e^{i\pi}$` |

**Subscripted function notation:** put a space before the argument list. Write `$H_b (p)$`, `$P_X (x)$`, or `$D_"KL" (P || Q)`, not `$H_b(p)$`. Since `_` consumes one atom, the unspaced form can parse `b(p)` as the subscript itself: `H_(b(p))`.

Multi-line aligned math:

| Correct Typst                     |
| --------------------------------- |
| `$`                               |
| `X[k] &= E[k] + W_N^k O[k] \`     |
| `X[k + N/2] &= E[k] - W_N^k O[k]` |
| `$`                               |

**Important:** use `#` inside math **only** to inject code values.

| Correct                       | Wrong           |
| ----------------------------- | --------------- |
| `#let n = 5` then `$#n < 10$` | `$#frac(a, b)$` |
| `$frac(a, b)$`                | `$\frac{a}{b}$` |

---

## 7) LaTeX → Typst Conversion Table

| LaTeX / wrong                            | Typst / correct               |
| ---------------------------------------- | ----------------------------- |
| `$$...$$`                                | `$ ... $`                     |
| `\[...\]`                                | `$ ... $`                     |
| `\(...\)`                                | `$...$`                       |
| `\frac{a}{b}`                            | `frac(a, b)` or `a/b`         |
| `\tfrac{a}{b}`                           | `a/b`                         |
| `\sqrt{x}`                               | `sqrt(x)`                     |
| `\alpha`, `\beta`, `\gamma`              | `alpha`, `beta`, `gamma`      |
| `\pi`, `\infty`                          | `pi`, `infinity`              |
| `\mathbb{R}`, `\mathbb{N}`, `\mathbb{Z}` | `RR`, `NN`, `ZZ`              |
| `\mathcal{C}`                            | `cal(C)`                      |
| `\mathbf{x}`                             | `bold(x)`                     |
| `\vec{x}`                                | `arrow(x)` or `vec(x)`        |
| `\text{word}`                            | `"word"`                      |
| `\left(` / `\right)`                     | `lr((...))` or normal `(...)` |
| `\bigl(` / `\bigr)`                      | `lr((...))` or normal `(...)` |
| `\quad`, `\qquad`, `\,`                  | `quad`, `quad quad`, `thin`   |
| `\dots`, `\cdots`                        | `dots`, `dots.c`              |
| `\\` inside equation                     | `\`                           |

---

## 8) Set, Show, Selectors

| Tool           | Purpose                          | Pattern                                   |
| -------------- | -------------------------------- | ----------------------------------------- |
| `#set`         | default styling from here onward | `#set text(size: 11pt)`                   |
| scoped `#set`  | style only inside block          | `#[#set text(red) ...]`                   |
| show-set       | simple restyling                 | `#show heading: set text(weight: "bold")` |
| show-transform | rewrite matched content          | `#show "TODO": text(fill: red)[TODO]`     |
| selector       | target elements                  | `heading.where(level: 1)`                 |

Examples:

| Correct                                               | Wrong                             |
| ----------------------------------------------------- | --------------------------------- |
| `#set page(margin: 2cm)`                              | `set page(margin: 2cm)`           |
| `#set text(font: "Arial")`                            | `#set text(font: Arial)`          |
| `#show heading.where(level: 1): set text(size: 16pt)` | broad destructive heading rewrite |

**Warning:** transformational `#show heading: it => ...` can accidentally remove numbering, spacing, labels, or references. Prefer show-set rules when enough.

---

## 9) Context, Counters, State

**Contextual values depend on document location. Use `#context` when reading them.**

| Concept        | Use for                                               | Read with                     |
| -------------- | ----------------------------------------------------- | ----------------------------- |
| `counter(...)` | pages, headings, figures, equations, custom numbering | `#context counter(...).get()` |
| `state(...)`   | values accumulated through document layout order      | `#context state.get()`        |
| `query(...)`   | finding document elements                             | `#context query(selector)`    |
| style context  | current style at location                             | `#context text.lang`          |

Counters:

| Goal              | Syntax                                    |
| ----------------- | ----------------------------------------- |
| current page      | `#context counter(page).display()`        |
| heading raw value | `#context counter(heading).get()`         |
| custom counter    | `#let ex = counter("example")`            |
| step then display | `#ex.step()` → `#context ex.display("1")` |
| reset/update      | `#counter(page).update(1)`                |

**Counter rule:** `.get()` returns an **array** because counters can have levels: section → subsection → subsubsection.

State:

| Goal          | Syntax                     |
| ------------- | -------------------------- |
| create        | `#let s = state("key", 0)` |
| update        | `#s.update(x => x + 1)`    |
| read here     | `#context s.get()`         |
| read at label | `#context s.at(<label>)`   |
| final value   | `#context s.final()`       |

**State rule:** state updates happen in **layout order**, where the returned content is inserted. Do not use `state` for simple local variables.

---

## 10) Tables, Grid, Figures, Links

| Need            | Use                                   | Avoid                |
| --------------- | ------------------------------------- | -------------------- |
| data table      | `#table(...)`                         | Markdown pipes       |
| visual layout   | `#grid(...)`                          | fake spaces / tables |
| image only      | `#image("file.png")`                  | Markdown image       |
| captioned image | `#figure(image(...), caption: [...])` | HTML                 |
| link            | `#link("url")[text]`                  | `[text](url)`        |

Table:

| Correct                                                |
| ------------------------------------------------------ |
| `#table(columns: 2, table.header[*A*][*B*], [1], [2])` |

Figure:

| Correct                                                           |
| ----------------------------------------------------------------- |
| `#figure(image("fig.png", width: 80%), caption: [Caption]) <fig>` |

---

## 11) Imports

| Goal                  | Syntax                            |
| --------------------- | --------------------------------- |
| import one item       | `#import "utils.typ": helper`     |
| import all            | `#import "theme.typ": *`          |
| import package        | `#import "@preview/pkg:1.0.0": *` |
| include rendered file | `#include "chapter.typ"`          |

**Preserve imports. Do not add packages unless necessary.**

---

## 12) Absolute Pitfalls

| Never do this                | Use this instead              |
| ---------------------------- | ----------------------------- |
| Markdown headings            | Typst `=`, `==`, `===`        |
| Markdown bold `**x**`        | Typst `*x*`                   |
| Markdown pipe tables         | `#table(...)`                 |
| LaTeX math/macros            | Typst math                    |
| `$$...$$`                    | `$ ... $`                     |
| single quotes                | double quotes                 |
| `True`, `False`, `None`      | `true`, `false`, `none`       |
| CSS `#ff0000`                | `rgb("#ff0000")`              |
| content as string            | `[content]`                   |
| counters without context     | `#context counter(...).get()` |
| fake spacing                 | `#h`, `#v`, `#grid`, `#pad`   |
| broad destructive show rules | narrow selectors              |

---

## Final Check Before Every Edit

**Pass only if all are true:**

| Check   | Must be true                                  |
| ------- | --------------------------------------------- |
| Syntax  | valid Typst                                   |
| Mode    | `#` used correctly for markup/code/math       |
| Math    | `$...$` or `$ ... $`, never `$$`              |
| LaTeX   | no LaTeX commands remain                      |
| Content | renderable content uses `[ ]`, not strings    |
| Types   | Typst values: `none`, `auto`, `true`, `false` |
| Layout  | uses Typst layout tools, not fake spaces      |
| Tables  | `#table`, not Markdown                        |
| Context | counters/state read with `#context`           |
| Project | imports, labels, helpers preserved            |
| Scope   | smallest correct edit                         |
