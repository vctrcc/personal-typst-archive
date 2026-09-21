---
name: typst-unlimited
description: Exhaustive Typst (0.13) skill for maximum-capability models. Everything from the large tier plus full mistake catalogs, deep dives into internals, reasoning workflows, and the complete verified snippet library.
---

# Typst — Unlimited Skill (Typst 0.13)

Maximum-depth reference. Everything here was verified against the typst 0.13.1 compiler (downloadable binaries) and the official docs; package versions verified against typst.app/universe on 2026-08-08. Version deltas for 0.14/0.15 are flagged inline. Sections are ordered: foundations → language → math → layout → styling → introspection → documents → packages → CLI → debugging → deep dives → workflows → appendix.

---

## 0. Foundations: how Typst actually works

### 0.1 The three modes

Typst has three syntactic modes; you can enter any from any:

| New mode | Syntax | Example |
|---|---|---|
| Code | prefix with `#` | `Number: #(1 + 2)` |
| Math | surround with `$..$` | `$-x$ is the opposite of $x$` |
| Markup | surround with `[..]` | `#let name = [*Typst!*]` |

Rules:
- Inside code mode, no `#` needed (but a leading `#` before an expression is tolerated/no-op at expression start).
- `$..$` works in code mode too (`#let e = $x^2$`).
- `[...]` content blocks are the bridge from code back to markup; inside them, `#` and `$` work again.
- Everything you write evaluates to **content** — a tree of elements (headings, paragraphs, text nodes, equations, …). Elements have **fields** (`it.body`, `it.level`, `content.fields()`, `.at("body")`, `.has("body")`, `.func()`).

### 0.2 String vs content — the master trap

- `"..."` is a **string**: plain data. It is NEVER parsed, NEVER formatted. `"$x^2$"` is five characters of text.
- `[...]` is **content**: markup is parsed — math activates, `*`/`_` style, `#` evaluates.
- Wherever content is expected, strings and `none` are accepted and rendered literally (docs: "Wherever content is expected, you can also pass a string or none").
- Verified: `#box("Super text $A!=B$")` → `repr` shows `box(body: [Super text $A!=B$])` — a single text node, NO equation. `#box([Super text $A!=B$])` → `equation(block: false, body: sequence([A],[≠],[B]))` — real math.
- Content joins: `[a] + [b]`; `3 * [a]` repeats; `none` joins as nothing; `[a] + "b"` works (string coerces).
- **Decision rule**: strings for data (paths, bib keys, labels, values); content for anything to be rendered/parsed. When in doubt: `[...]`.

### 0.3 Typst ≠ LaTeX ≠ Markdown

The ONLY LaTeX habit that survives in Typst is `$...$`. Everything else silently degrades:
- In **markup**, LaTeX commands render as literal/garbled text because backslash is an escape for ONE character: `\frac{1}{2}` → `\f` (form-feed control char!) + `rac{1}{2}`; `\textbf{}` → `\t` (tab) + literal; `\section{}` → `\s` escape + literal. **No error is raised.**
- In **math**, the same pattern produces errors like `unknown variable: rac` (escape ate `\f`, remainder `rac` becomes a variable lookup).
- Markdown: `**bold**` → warning "no text within stars" + literal; `*text*` = **strong** in Typst (swapped!); `# heading` → error (`#` is code mode); `## heading` → error (`the character '#' is not valid in code`); `<br>` → literal; `| a | b |` → literal.
- `~` (nbsp) carries over from LaTeX; `~` in math is the tilde symbol.

---

## 1. Markup mode

### 1.1 Syntax table

| Element | Syntax | Element fn |
|---|---|---|
| paragraph break | blank line | `parbreak` |
| line break | `\` followed by space or end-of-line | `linebreak` |
| strong (bold) | `*text*` (word boundaries only) | `strong` |
| emph (italic) | `_text_` (word boundaries only) | `emph` |
| heading | `= H1` `== H2` `=== H3` `==== H4` | `heading(level: n)` |
| bullet list | `- item` (indent 2 spaces = nest; blank line = loose list) | `list` |
| numbered list | `+ item` | `enum` |
| term list | `/ Term: description` | `terms` |
| raw code | `` `code` `` / ```lang fences | `raw` |
| link | bare `https://…` (auto-links) / `#link("url")[text]` | `link` |
| label | `<intro>` (attach to headings/figures/equations) | `label` |
| reference | `@intro` | `ref` |
| math | `$x^2$` | `math.equation` |
| smartquote | `'single'` `"double"` | `smartquote` |
| symbol shorthand | `~` nbsp `---` em dash `--` en dash `...` ellipsis `-?` soft hyphen | `sym` |
| escape | `\$ \# \* \_ \= \- \+ \~ \; \ ` `\\` → literal char | — |
| unicode escape | `\u{1f600}` | — |
| comment | `// line` / `/* block */` (works in all three modes) | — |

### 1.2 Escapes, in detail

- Backslash escapes exactly ONE following character: `\$` `\#` `\*` `\_` `\=` `\-` `\+` `\~` `\;` `\ ` `\\` all produce their literal character.
- `\u{1f600}` inserts a Unicode codepoint (also works in strings).
- `\` followed by a space OR a newline = line break.
- **`\\` is an escaped backslash — it renders a literal `\` glyph, it is NOT a newline.** This is the single most common LaTeX-reflex bug. (Verified: `sequence([a],[ ],[\\],[ ],[b])`.)
- `\` before an ordinary letter silently drops the backslash (`\q` → `q`); before control chars (`\f`, `\t`, `\b`) it produces control characters that eat surrounding text. There is no warning.

### 1.3 Identifiers

- Letters, digits, `-`, `_`; must start with a letter or `_`. Unicode identifiers allowed (`_schön`, `π`).
- Kebab-case is the convention: `top-edge`, `number-align`.
- In **math mode**, identifiers cannot contain `_` or `-` — `x_bar` parses as x with subscript `bar`; `foo-x` parses as `foo - x`.

### 1.4 Markup pitfalls (exhaustive)

| ❌ | What happens | ✅ |
|---|---|---|
| `\\` for newline | literal `\` glyph | `\` + space |
| `\frac{1}{2}` | `\f` form-feed + `rac{1}{2}` garbage | `$1/2$` |
| `\textbf{x}` `\emph{x}` | `\t` tab + literal | `*x*` `_x_` |
| `**bold**` | warning "no text within stars", literal | `*bold*` |
| `# heading` | error `expected expression` (`#` = code) | `= heading` |
| `## heading` | error `the character '#' is not valid in code` (2nd `#` re-enters code mode) | `== heading` |
| `<br>` `<b>` `<div>` | literal text (no HTML parser) | `\` break; `#text(weight: "bold")` |
| `-item` (no space) | literal | `- item` |
| `-` at line start mid-paragraph | breaks the paragraph | keep list markers at line starts |
| `% comment` | `%` is literal | `//` |
| `\label{foo}` `\ref{foo}` `\cite{foo}` | literal text | `<foo>` `@foo` `@foo` |
| `\begin{itemize}` | literal; `\b` = backspace eats text | `- item` |
| `1. item` numbered | actually WORKS (enum by number) | `+ item` preferred |
| escaping ordinary letters `\q` | silently drops the backslash | escape only special chars |

### 1.5 Markup tips

- Nested lists: 2-space indent. Loose (spaced) list: blank line between items.
- `*emph _nested_ inside*` nests fine.
- Terms can be styled: `/ *term*: description`.
- Write markup in markup mode; reserve code mode for values. Inside functions/loops you can't use markup syntax directly — build with `[`content blocks`]` or element functions (`#heading[..]`).

---

## 2. Scripting mode

### 2.1 Expressions and bindings

```typst
#let x = 5                       // binding
#(1 + 2)                         // parenthesized compound expression
#let name = none                 // #let without value = none
#let (a, b) = (1, 2)             // destructuring arrays
#let (first, .., last) = (1, 2, 3, 4)  // rest destructuring
#let (key: v) = (key: "val")     // dict destructuring
(a, b) = (b, a)                  // swap (assignment to existing bindings)
```

- Everything is an expression; `if`/`for`/`while`/assignment all yield values.
- Assignment `=` / `+=` / `-=` / `*=` / `/=` works on existing bindings; `=` NEVER declares.
- Reassignment is allowed on `let`-bound variables, but functions capture bindings **by value at definition** (purity) — changes inside a function don't leak out. For cross-document state use `state`/`counter`.
- No hoisting: variables must be defined before use (`unknown variable` otherwise); block-scoped.

### 2.2 Operators (complete)

Precedence high→low: unary `-` `+` → `*` `/` → `+` `-` → comparisons `==` `!=` `<` `<=` `>` `>=` `in` `not in` → `not` → `and` → `or` → assignment.

| LaTeX/Python habit | Typst |
|---|---|
| `&&` `\|\|` `!` | `and` `or` `not` |
| `%` modulo | `calc.rem(a, b)`; integer division `calc.quo`; `calc.euclid` for euclidean |
| `**` power | `calc.pow(a, b)` |
| `//` floor div | `calc.quo` |
| `1/0` | error `cannot divide by zero` — guard |
| `+` on arrays | NOT supported — spread: `(..a, ..b)` |
| `"2" + 2` | error `cannot add string and integer` — convert explicitly |
| `min` `max` `sqrt` `abs` globals | `calc.min` `calc.max` `calc.sqrt` `calc.abs` `calc.floor` `calc.ceil` `calc.round` |

### 2.3 Conditionals and loops

```typst
#if c [..] else if d {..} else [..]     // expression: yields branch value
#let v = if x > 0 { "pos" } else { "neg" }
#for x in (1, 2, 3) { .. }              // arrays
#for x in "abc" { .. }                  // strings
#for (k, v) in (a: 1) { .. }            // dicts (efficient; no temp array)
#for i in range(3) { .. }               // range(3) = (0, 1, 2); range(1, 10, 2) steps
#while cond { .. }
#break #continue                        // loops only
#return x                               // functions only
```

### 2.4 Code blocks: the join semantics

`{ stmt; stmt }` — statements separated by `;` or newlines. **The block joins every statement's value** (bindings yield `none`, which joins as nothing). The last statement's value is the block's value.

Consequences:
- `#while i < 3 { i += 1 }` → error `cannot join integer with integer` (loop iterations each yield an int). Fix: end the block with `none`, or `#let _ = ...` to discard, or produce content.
- `#{ let x = 1; x + 2 }` → renders `3`.
- `#let f(x) = { if x < 0 { return 0 }; x }` — early return idiom.

### 2.5 eval

`#eval("1 + 1")` → 2 (code mode default). `#eval("x^2", mode: "math")` → math content. `#eval("= Heading", mode: "markup")` → content. `scope:` supplies variables: `#eval("x + 1", scope: (x: 2))`. Compile-time and pure — cannot see layout. **`math.eval` does not exist** (verified error `module 'math' does not contain 'eval'`).

### 2.6 Modules

```typst
#import "lib.typ"                  // binds module by filename
#import "lib.typ": a, b as c       // select items
#import "lib.typ": *               // everything (can shadow builtins!)
#import "lib.typ" as mod           // renamed binding
#include "chapter.typ"             // pastes raw content (evaluates to content)
```

- `.typ` extension required in both.
- `#import` pastes nothing into the output — it evaluates the file and makes bindings.
- `#include` is for body text/chapters; `#import` for definitions. `#include` a file full of functions = nothing visible.
- Circular imports error; keep the dependency graph a DAG.
- ⚠️ Show/set rules inside an `#include`d file **apply to the rest of the parent document** — it's literally pasted in. Scope them by wrapping the include in `#[...]` blocks or better: `#import` a template function and `#show: fn.with(...)`.
- A `#let` in lib.typ is not shared mutable state across files — each module evaluates in its own scope. Use `state`/`counter` for shared document state.

### 2.7 Scripting pitfalls (exhaustive)

| ❌ | What happens | ✅ |
|---|---|---|
| `let x = 5` in markup | literal text "let x = 5" | `#let x = 5` |
| `rect(width: 1cm)` in markup | literal text | `#rect(...)` |
| `#let x = 5; x + 1` | renders "x + 1" — `;` ends the code expr | `#(x + 1)` or `#{ let x = 5; x + 1 }` |
| `#let i = 0#while ...` one line | parse error `expected semicolon or line break` | newline between statements |
| `#if x` without body block | error — `if` needs `[..]`/`{..}` body | `#if x [..]` |
| `#if x && y` / `#!x` | unknown operators | `and`/`not` |
| `#(1 % 2)` | error | `calc.rem(1, 2)` |
| `#min(1, 2)` | unknown variable: min | `calc.min(1, 2)` |
| `#(1h)` | invalid number suffix: h | `duration(hours: 1)` |
| `x = 5` where x unbound | unknown variable (assignment ≠ declaration) | `#let x = 5` |
| loop body yields ints | cannot join integer with integer | trailing `none` or content |
| `#break` outside loop | error | loops only |
| `#"abc".len()` | works! hash + string + method | fine |
| `#(1, 2)` vs `#1, 2` | array vs `1` then literal ", 2" | parens for compound exprs |
| `#return` at top level | error | inside functions only |

---

## 3. Functions

### 3.1 Definition forms

```typst
#let f(a, b: 1, ..rest) = a + b      // named fn: positional + defaulted named + sink
#let f = (a, b) => a + b             // lambda (parens optional for 1 param: x => x*2)
#let f = x => x * 2
```

- Named parameters MUST have defaults (`b: 1`); they are then callable only by name: `#f(1, b: 2)` ✅, `#f(1, 2)` → `unexpected argument`.
- Positional params are required unless `..`-sunk.
- `..rest` captures an **arguments** object (NOT an array): `rest.pos()` for positional, `rest.named()` for named, `rest.len()`, `rest.at(i)`.

### 3.2 Calling conventions

- Trailing content blocks: `#box[A box]` ≡ `#box([A box])` ≡ `#box(body: [A box])`. Multiple blocks: `#list[A][B]`.
- Empty parens droppable: `#box[A]`.
- Spread: `#f(..arr)` (array → positional), `#f(..dict)` (dict → named), `#f(..args)` (re-pass sink).
- Method calls are required for mutating methods: `arr.push(1)` — `array.push(arr, 1)` errors (`cannot mutate a constant: array`).
- Evaluating vs referencing: `#f` inserts the function value (renders repr); `#f()` calls it. Pass bare `f` where a callback is wanted (`#show heading: f`).

### 3.3 with / where / closures / recursion

- `f.with(b: 5)` → partially applied function; the canonical show-rule/template idiom (`#show: template.with(title: [X])`).
- `f.where(field: v)` → selector for show rules (`#show heading.where(level: 1): ...`).
- Closures capture the enclosing scope; recursion works (verified factorial); functions are pure — same args → same result; no shared mutable state.

### 3.4 Function pitfalls

- `#f` without parens intending a call → renders the function repr.
- `#show heading: heading` → infinite show recursion; transform fields instead: `it => block[#it.body]`.
- `#show "x": "x"` → replacement re-matches → divergence; make replacements differ.
- `#figure(caption: [x])` without body → `missing argument: body`.
- Default args are named-only (see 3.1).
- `..args` isn't an array — `nums.sum()` fails with `type arguments has no method sum`; use `nums.pos().sum()`.

---

## 4. Types & argument expectations

### 4.1 Full type table

| Type | Literal / construction | Notes |
|---|---|---|
| int | `10`, `0xff`, `0b101` | arbitrary precision |
| float | `3.14`, `1e5` | division yields float |
| bool | `true`, `false` | |
| none | `none` | absence; joins as nothing; distinct from `auto` |
| auto | `auto` | "compute a good default" (`box(width: auto)`) |
| str | `"..."` | escapes `\" \\ \n \t \u{..}` |
| content | `[...]` | parsed markup; `.func()`, `.fields()`, `.at()`, `.has()` |
| array | `(1, 2, 3)` | `range(3)`; no `+` |
| dictionary | `(a: 1, b: 2)` | `.keys() .values() .pairs()`; `dict.insert` |
| length | `10pt 2cm 5mm 1in 1em 1ex` | absolute (pt/cm/mm/in) vs relative (em/ex) |
| ratio | `50%` | of container; arithmetic: `100% - 10pt` |
| fraction | `1fr 2fr` | grid/table/stack/flex only |
| angle | `90deg 1rad` | arithmetic: `90deg + 45deg` |
| color | `red rgb("#0178A4") rgb(255,0,0) luma(50) cmyk(...) oklch(...)` | 120+ named colors |
| gradient | `gradient.linear(red, blue, angle: 45deg)` `.radial` `.conic` | |
| symbol | `sym.arrow.r`, `emoji.face` | fields with modifiers |
| label | `<name>` / `label("name")` | |
| stroke | `1pt` `red` `(thickness: 2pt, paint: blue, dash: "dashed")` | |
| alignment | `left center right top bottom horizon` `top + right` | compose with `+` |
| direction | `ltr rtl ttb btt` | bare values, NOT strings |
| datetime | `datetime(year: 2026, month: 8, day: 8)` | `datetime.today()` |
| duration | `duration(hours: 1, minutes: 30)` | NO literal syntax |
| version | `version(0, 13, 0)` | |
| regex | `regex("\w+")` | |
| bytes | `bytes("...")` | |
| function | `f` `(x) => x` | |
| type | `int str content` | `type(value)` introspects |

### 4.2 Argument expectations (verified error messages)

- `text(fill:)` → color | gradient (string → `expected color, gradient, or tiling, found string`).
- `box(width:)/height:` → length | ratio | auto | fraction (int → `expected auto, relative length, or fraction, found integer`).
- `box(inset:)` → length | dict `(x:, y:)`; `pad` takes `x:/y:/rest:` — no `inset:` (`unexpected argument: inset`).
- `page(margin:)` → length | dict `(x:, y:)` | dict `(top:, right:, bottom:, left:)`.
- `rect(fill:)` → paint; `stroke:` → stroke (color coerces).
- `set text(font:)` → string | array (fallback list); `weight:` int | `"bold"` | `"medium"`.
- `grid(columns:)/rows:` → array of length|fraction|auto | int (auto-repeat).
- `place(alignment)`; `float: bool`; `dx/dy` lengths.
- `counter(key)` → element fn | str | int | label.
- `query(selector)` → label | element fn | str selector.

### 4.3 Type pitfalls

| ❌ | Error | ✅ |
|---|---|---|
| `box(width: 10)` | expected auto, relative length, or fraction, found integer | `10pt` / `10%` |
| `text(fill: "red")` | expected color, gradient, or tiling, found string | `red` |
| `set page(margin: 10)` | length expected | `10mm` |
| `rect(width: 1fr)` | expected relative length or auto, found fraction | `100%` |
| `#(1h)` | invalid number suffix: h | `duration(hours: 1)` |
| `#linear(red, blue)` / `#linear-gradient(...)` | unknown variable | `gradient.linear(...)` |
| `#min(1, 2)` | unknown variable | `calc.min` |
| `stack(dir: "ltr")` | expected direction, found string | `dir: ltr` |
| `#str([content])` | error (content can't cast to str) | `repr(...)` |
| `"5" + 3` | cannot add string and integer | `int("5") + 3` |
| `(1, 2) + (3, 4)` | arrays don't add | `(..(1,2), ..(3,4))` |
| `box(width: none)` | none is not a size | `auto` |
| `#set heading(weight: "bold")` | unexpected argument: weight (a text param!) | `#set text(weight: "bold")` |

---

## 5. Math mode — complete reference

### 5.1 Entering math

- `$x^2$` inline; `$ x^2 $` (space at BOTH ends) = block (centered). Verified: `query math.equation --field block` → `$a=b$` → false; `$ a=b $` → true; `$ a=b$` → false (a lone edge space stays inside the body as math spacing).
- Math works in headings, table cells, footnotes, and code (`#let e = $x^2$`).
- Block equations don't break across pages by default; `#show math.equation: set block(breakable: true)` changes that.
- Escapes: `\$` `\#` `\^` `\{` `\}` `\\` render literal; `\` + space = line break; `//` and `/* */` are comments (so `$a//b$` is a comment, NOT division).
- Literal dollar in markup: `\$` or `#sym.dollar`.
- **Strings in math are never parsed**: `"x^2"` in a string stays text; `$"a"$` renders upright text `a` (0.13 fixed single-letter upright rendering).
- **`math.eval` does not exist** → `#eval("x^2", mode: "math")`.

### 5.2 Identifiers and variables

| Input | Meaning |
|---|---|
| `$x$` `$2$` `$2x$` | math characters; `2x` = implied multiplication |
| `$xy$` `$sqrt x$` `$foo(x)$` | **variable lookup** → `unknown variable: xy` (ERROR) |
| `$x y$` | x·y (whitespace = multiplication) |
| `$2 pi r$` | 2πr |
| `$alpha$` | symbol α (multi-letter symbol table) |
| `#let alpha = 1; $alpha$` | 1 (user binding wins over symbol) |
| `#let x = 5; $x$` | the LETTER x (single letters never look up!) |
| `#let x = 5; $#x$` | 5 |
| `$x = #(2*3)$` | x = 6 |
| `$"text"$` | upright text |
| `$"10 m/s"$` | upright "10 m/s" (use strings for units with letters!) |

- Math identifiers can't contain `_` or `-`. `x_bar` = x with subscript "bar". `foo-x` = foo minus x.
- Code scope shadows math scope: `#let pi = 5; $pi$` → 5.

### 5.3 Scripts and grouping (the most error-prone area)

**`^` and `_` take exactly ONE atom.** Group multi-atom arguments with round parens — parens inside scripts are absorbed (never shown):

| ❌ | ✅ | Why |
|---|---|---|
| `$e^(i Theta) + pi$` | `$e^(i Theta + pi)$` | `+ pi` fell outside the exponent |
| `$log_(n+1) (Theta+pi)$` | same — parens shown + auto-scaled | parens after an op are NOT absorbed; both render `lr((Θ+π))` |
| `$x_{n+1}$` | `$x_(n+1)$` | `{ }` are VISIBLE braces in Typst — no `{}` grouping exists |
| `$a^b c$` (want a^(bc)) | `$a^(b c)$` | `^` binds one atom only |
| `$x_1_2$` | `$x_(1, 2)$` | chains nest right-assoc: x_(1_2) |

**Chained scripts NEST (right-assoc) — they are NOT errors:**
- `$e^x^2$` = e^(x²) (verified: `attach(base: [e], t: attach(base: [x], t: [2]))`).
- `$x_1^2_3$` nests: `attach(base: x, t: attach(base: 2, b: 3), b: 1)`.
- `$x_1^2$` ≡ `$x^2_1$` — order irrelevant (both `attach(base: [x], t: [2], b: [1])`).
- `$x_ 1$` (space after `_`) is VALID = x₁ (trivia is ignored).
- **Subscripted function notation needs a separating space before arguments:** `$H_b (p)$`, `$P_X (x)$`, `$D_"KL" (P || Q)`. Without it, `$H_b(p)$` can parse as `H_(b(p))` because `b(p)` is a single call-shaped atom consumed by `_`; it is not reliably `H_b` followed by `(p)`.
- Scripts bind tighter than `/`: `$a_1/b_2$` = a₁/b₂.
- Primes: `$f'$`, `$f''$`; `$a'''_b$` works.
- Corner attachments: `attach(base, t:, b:, tl:, bl:, tr:, br:)`.
- `$S_1.plus.a$` → error `unknown symbol modifier: a` — `.plus` after a scripted base misparses; use `attach` or parens.

**Parens semantics (verified):** `(...)` group AND display; they are auto-removed ONLY (a) around a fraction's numerator/denominator, (b) around a radicand, (c) around a script argument.
- `$f(x) = (x + 1)/x$` → (x+1) removed.
- `$1/((x+1))$` → one pair shown. `$x + (y)$` → parens KEPT. `$[x]^2$` → brackets KEPT + auto-scaled.

### 5.4 Fractions

- `/` = fraction, **left-associative**: `$a/b/c$` = (a/b)/c; `$a/(b/c)$` groups.
- `$a/(b + c)$` ✅; `$(partial u)/(partial x)$` ✅ (the derivative idiom).
- `frac(a, b)` explicit function form (args not auto-unparenthesized). `frac(style:)` param is 0.14+ only.
- Precedence: scripts/numbers bind tighter — `1/f(x)`, `1/n!`, `5!/2`, `1.2/3.7`, `zeta(x)/2` all work.
- `$10 m/s$` fine; `$10 m/speed$` → `unknown variable: speed` → `$10 m/"speed"$`.

### 5.5 Math calls

- `name(` directly after an identifier (no space) parses as a call; a space ⇒ implicit multiplication + parens, not a call.
- Args parse in math mode; `;` merges preceding comma-args into an array (2D args for `mat`); named args and `..` spread work.
- Callee IS a function (math fns, user `#let`): real call.
- Callee is an op or single letter (`sin`, `f`): **no error** — callee displays, args wrapped in auto-scaled `lr(...)` parens (`$sin(x)$` → op(sin) + lr((x)); `$f(x, y)$` → f(x, y)).
- Undefined multi-letter callee → hard error.
- `$sin x + y$` = (sin x) + y; `$sin(x + y)$` = sin(x+y).
- Custom operators: `op("lim", limits: #true)_x`; `op("foo", limits: #false)`.
- `#` inside math = code evaluation: `$x = #calc.pow(2, 3)$` → x = 8; `$#rect(...)/x$` embeds content.

### 5.6 Implicit multiplication

- Whitespace between atoms = multiplication: `$a b$`, `$2 pi r$`, `$2x$`, `$sin x$`, `$a b_1$`.
- `$xy$` (no space, two letters) = variable lookup error — space REQUIRED for multi-letter.

### 5.7 Symbols & shorthands

**Bare names (math mode)**: `alpha beta gamma delta epsilon zeta eta theta iota kappa lambda mu nu xi omicron pi rho sigma tau upsilon phi chi psi omega` + capitals (`Gamma Delta Theta Lambda Xi Pi Sigma Phi Psi Omega`); variants via `.alt` (`phi.alt`, `theta.alt`); Hebrew `aleph beth gimel daleth`; `partial` (∂) `nabla`/`gradient` (∇) `sum` (∑) `product` (∏) `integral` (∫) `union` (∪) `inter` (∩ 0.13+; `sect` deprecated) `subset` `oo` (∞) `approx` (≈) `propto` `therefore` `because` `forall` `exists` `in` `not in` `sub` `sup` `cap`? (no — `union`/`inter`) `dots` (…) `hat` `bar` (the | glyph!) `vec` `dot` `dif` `Div` `RR NN ZZ QQ CC` (blackboard)…

**Shorthands (verified list)**: `...`(…) `-`(−) `*`(∗) `~`(∼ tilde-op) `!=`(≠) `:=`(≔) `::=`(⩴) `=:`(≕) `<<`(≪) `<<<`(⋘) `>>`(≫) `>>>`(⋙) `<=`(≤) `>=`(≥) `->`(→) `-->`(⟶) `|->`(↦) `>->`(↣) `->>`(↠) `<-`(←) `<--`(⟵) `<-<`(↢) `<<-`(↞) `<->`(↔) `<-->`(⟷) `~>`(⇝) `~~>`(⟿) `<~`(⇜) `<~~`(⟺) `=>`(⇒) `|=>`(⤇) `==>`(⟹) `<==`(⟸) `<=>`(⇔) `<==>`(⟺) `[|`(⟦) `|]`(⟧) `||`(‖).
- **`==` is NOT a shorthand** — renders two `=` glyphs (verified). Identity = `eq.triple` or Unicode `≡`.
- Modifiers: `arrow.r.long`, `gt.eq.not`, `lt.eq.slant`, `phi.alt`, `dots.v`, `dots.c`, `dots.h`, `dots.down`, `dots.up`; order irrelevant.
- `@` in math is just the `at` symbol (not "circled"); circled glyphs on 0.13: `dot.circle` (⊙), `plus.circle`, `times.circle`, `ast.circle` — the `.o` family (`times.o`, `plus.o`, `ast.o`, `dot.o`) is 0.14+ (each has a `.circle` 0.13 equivalent; `compose.o` has no 0.13 equivalent at all). `ast.circle` is deprecated in 0.14 → `convolve.o`.
- Greek via Unicode works: `θ` ≡ `theta`; but modifiers only by name (`theta.alt`).
- ⚠️ **Symbol-table drift**: only `times.o` is genuinely absent in 0.13 (use `times.circle`); `inter`, `sect` (deprecated), `numero`, `eq.triple.not`, `smt`, `lat`, `mapsto`, `asymp`, `interleave` were all ADDED in 0.13.0 and exist. Removed in 0.13.0: `ohm`, `kelvin`, `degree.c`, `degree.f` (use `Omega`, `upright(K)`, `upright(°C)`). Verify against the version's table rather than assuming newer docs are wrong.

### 5.8 Functions, accents, styles

- **Accents**: `hat(x)` `tilde(x)` `dot(x)` `vec(x)` `grave(x)` `acute(x)` `arrow(x)` `harpoon(x)` — all produce `accent` elements. Generic: `accent(base, accent)` with `macron` `breve` `caron` `circumflex` `check` etc.
- **`bar` is the `|` glyph, NOT an accent**: `$bar(x)$` renders `|(x)` (verified). For \bar{x}: `overline(x)` or `accent(x, macron)`.
- **Styles**: `upright(x)` `italic(x)` `bold(x)` `serif(x)` `sans(x)` `frak(x)` `mono(x)` `bb(x)` `cal(x)` (all verified). **NO `tt`/`rm`/`it`/`scr` in 0.13** (`scr` is 0.14+).
- **Operators (op elements)**: `arccos arcsin arctan arg cos cosh cot coth csc csch ctg deg det dim exp gcd lcm hom id im inf ker lg lim liminf limsup ln log max min mod Pr sec sech sin sinc sinh sup tan tanh tg tr` — rendered upright automatically, accept scripts: `lim_(x -> 0)`.
- **`sum`/`product`/`integral`/`union` are SYMBOLS not functions** — no parens needed; limits auto-place (below/above in display, side in inline): `$sum_(i=0)^n i$` ✅. Force with `limits(x)`/`scripts(x)`: `$limits(sum)_0^n$` ✅.
- `sqrt(x)` — parens REQUIRED (`$sqrt x$` renders literal "sqrt" then x); `root(n, x)` index-first: `root(3, x)` = ∛x.
- `abs(x)` `norm(x)` `floor(x)` `ceil(x)` `round(x)` `mid(|)` — all auto-scaling lr variants.
- `binom(n, k)`; `cancel(x)` (length, inverted, cross, angle, stroke); `display(x)` `inline(x)` `script(x)` `sscript(x)`; `stretch(arrow.r.long)^"text"`.

### 5.9 Delimiters

- Matched `( ) [ ] { }` auto-scale by default. `lr(...)` forces; `lr(size: 1em)` disables auto-scaling.
- **Plain `|x|` does NOT auto-scale** (verified — no lr wrapper). Use `abs(x)` or `lr(|x|)`.
- `\|` = escaped literal pipe (no scaling).
- `[ ]` in math = delimiters (also group fractions like parens).

### 5.10 Spacing & text in math

- `thin` (0.17em) `med` `thick` `quad` (1em) `wide`; also `#h(1em)` from code. No `hspace`/`space` functions in 0.13 math.
- Strings: `$a "is natural"$` — upright, math-mode spacing; multi-word strings keep internal spaces.
- `text(...)` works inside math calls: `$text(fill: #maroon, 2 a b)$`.
- `dif` for differentials: `$integral_0^oo e^(-x^2) dif x$` — upright d + thin spacing.

### 5.11 Display math, numbering, alignment

```typst
#set math.equation(numbering: "(1)", supplement: [Eq.])
$ a = b $ <eq1>        // labeled block equation
See @eq1.              // renders (1)
$ x &= 1 && y &= 2 \ z &= 3 $   // alignment: & alternates right/left columns; && = two points
$mat(1, 2; 3, 4)$      // rows by ;
$vec(a, b, c)$         // 1D — NO ;
$cases(a &= 1, b &= 2)$
$lr(|x/2|)$            // auto-height norm
$underbrace(a + b)_("result")$
```

- `mat` params: `delim`, `align`, `augment`, `gap`, `row-gap`, `column-gap`; `#set math.mat(delim: "[")`.
- `cases` params: `delim`, `reverse`, `gap`.
- No `\tag`, no environments, no `equation*` — numbering is global via set rule; `#set math.equation(numbering: none)` disables; unnumbered = `$ x $`.
- `&` in markup is a literal character — special ONLY inside math.

### 5.12 Complete 0.13 math module (from source)

**Elements**: `equation text lr mid attach stretch scripts limits accent underline overline underbrace overbrace underbracket overbracket underparen overparen undershell overshell cancel frac binom vec mat cases root class op primes`.
**Functions**: `abs norm round sqrt upright bold italic serif sans cal frak mono bb display inline script sscript` (+ `floor ceil` with the lr family).
**Operators (op)**: `arccos arcsin arctan arg cos cosh cot coth csc csch ctg deg det dim exp gcd lcm hom id im inf ker lg lim liminf limsup ln log max min mod Pr sec sech sin sinc sinh sup tan tanh tg tr`.
**Spacing**: `thin med thick quad wide`.
**Symbols**: full `sym` table + `dif` `Dif`.
**Does NOT exist in 0.13**: `math.eval math.solve math.tt math.rm math.it math.scr math.hspace math.hfill math.highlight math.expr math.ident math.invert math.grad math.shr` (as FUNCTIONS; note `math.space`, `math.and/or/not`, `math.sum`, `math.product`, `math.diff`, `math.div`, `math.max/min` DO resolve on 0.13 — they are symbols/operators, not functions).

### 5.13 Exhaustive math mistakes catalog (all verified on 0.13.1)

| ❌ | ✅ | Why |
|---|---|---|
| `\frac{1}{2}` | `$1/2$` or `$frac(1, 2)$` | `\f` escape → `unknown variable: rac` |
| `\alpha` `\theta` | `alpha` `theta` | `\a` escape → `unknown variable: lpha` |
| `\sum_{i=0}^n` | `sum_(i=0)^n` | `\s` escape → error; sum is a symbol |
| `\text{hi}` | `"hi"` | `\t` escape → error |
| `\cdot` | `dot` (or `dot.op`) | `cdot` → unknown variable |
| `\infty` | `oo` | |
| `\le` `\ge` `\ne` | `<=` `>=` `!=` | |
| `\to` `\implies` `\iff` | `->` `=>` `<=>` | |
| `\cdots` `\ldots` | `dots.c` `dots.h` | |
| `\mathbb{R}` `\mathcal{L}` `\mathfrak{g}` | `RR` `cal(L)` `frak(g)` | |
| `\mathrm{d}x` | `dif x` | |
| `\bar{x}` | `overline(x)` / `accent(x, macron)` | `bar` = the `\|` glyph |
| `\hat{x}` `\tilde{x}` `\dot{x}` `\vec{x}` | `hat(x)` `tilde(x)` `dot(x)` `vec(x)` | these ARE functions |
| `\cup` `\cap` `\notin` | `union` `inter` `in.not` | |
| `==` identity | `eq.triple` or `≡` | `==` prints two glyphs |
| `\|x\|` | `norm(x)` / `lr(|x|)` | `\|` = literal pipe |
| `\left( \right)` | automatic scaling; `lr(...)` | |
| `\{x\}` scaled | `lr({...})` or `{...}` | escaped braces = literal, unscaled |
| `\left|...\right|` | `abs(...)` | |
| `\lfloor \rfloor` | `floor(...)` `ceil(...)` | |
| `\,` `\;` `\quad` | `thin` `thick` `quad` | |
| `\operatorname{foo}` | `op("foo")` | |
| `\mod` | `mod` | |
| `$xy$` x·y | `$x y$` | multi-letter = variable lookup |
| `$2x$` | fine = 2·x | number+letter implied mult |
| `#let x = 5; $x$` | `$#x$` | single letters never look up |
| `$unknownthing(x)$` | define or quote | undefined multi-letter call errors |
| `$sin x + y$` = sin(x+y) | `$sin(x + y)$` | op binds to x only |
| `$H_b(p)$` meaning H sub b at p | `$H_b (p)$` | no space lets `_` consume the call `b(p)` |
| `$10 m/speed$` | `$10 m/"speed"$` | multi-letter denom lookup |
| `$e^(i Theta) + pi$` | `$e^(i Theta + pi)$` | `^` takes one atom |
| `$x_ 1$` | valid = x₁ | trivia ignored |
| `$x_(i, j)$` wanting parens | parens absorbed — that's correct | |
| `$x_{n+1}$` | `$x_(n+1)$` | braces are visible |
| `$e^x^2$` fearing error | VALID = e^(x²) | right-assoc nesting |
| `$a/b/c$` = a/(b/c) | = (a/b)/c — group with parens | left-assoc |
| `$(x + 1)/2$` wanting parens | parens removed — normal | unparen only the fraction's group |
| `$1/((x+1))$` vs `$1/(x+1)$` | keeps one pair vs none | nest to force |
| `$a//b$` division | `$a/b$` or `$a div b$` | `//` = comment |
| `$sqrt x$` | `$sqrt(x)$` | bare sqrt displays literally |
| `root(x, n)` | `root(n, x)` | index FIRST |
| `$vec(a, b; c, d)$` | `mat(a, b; c, d)` | vec is 1D |
| `$cases(1, 2; 3, 4)$` | `cases(1, 2, 3, 4)` | cases is 1D (comma) |
| `mat(1, 2; 3, 4)` | ✓ correct | `;` separates rows |
| `#math.eval("1+2")` | `#eval("1+2")` | doesn't exist |
| `#box("Super text $A!=B$")` | `#box([Super text $A!=B$])` | strings aren't parsed |
| `$x²$` superscript | `$x^2$` | `²` is a character |
| `$x = "10"$` want 10 | `$x = #10$` | strings = upright text |
| `%` comments in math | `//` `/* */` | `%` is literal |
| `\emph{}` `\textbf{}` in math | `italic(x)` `bold(x)` | |
| `\begin{align}` | one `$` with `\` + `&` | no environments |
| `\tag{}` | `#set math.equation(numbering: "(1)")` | |
| `\label{}+`\ref{}` | `<eq1>` `@eq1` | |
| `\cite{key}` | `@key` + `#bibliography(...)` | |
| `$$..$$` | `$ .. $` (space both ends) | `$$` closes immediately |
| `\,` literal comma | `thin` | |
| `\u{}` in strings | works in math too | |

### 5.14 Cross-language conversion (LaTeX → Typst) — full table

| LaTeX | Typst | LaTeX form in Typst |
|---|---|---|
| `\documentclass{article}` | no boilerplate; `#set page(...)`; templates: `#import "tpl.typ": tpl` + `#show: tpl.with(...)` | literal text (no error!) |
| `\usepackage{amsmath}` | nothing needed; packages: `#import "@preview/name:0.1.0"` | literal text |
| `\section{}` `\subsection{}` | `= H1` `== H2` | literal text |
| `\textbf{}` `\emph{}` | `*strong*` `_emph_`; math `bold(x)` `italic(x)` | markup: literal; math: error |
| `\texttt{}` | `` `raw` `` / `mono(x)` | literal / error |
| `\textsc{}` | `#smallcaps[x]` | literal |
| `\\` | `\` + space | `\\` = literal backslash |
| `\newpage` | `#pagebreak()` | literal |
| `\noindent` | `#par(first-line-indent: 0em)` | literal |
| `\hspace{}` | `#h(1cm)`; math `thin/med/thick/quad/wide` | literal |
| `\label{}` `\ref{}` | `<x>` `@x` | literal |
| `\cite{}` | `@key` + bibliography; `#cite(<k>, form: "prose")` | literal |
| `\url{}` | bare URL or `#link("url")[text]` | literal |
| `\begin{itemize}` `\item` | `- item` (indent to nest) | literal |
| `\begin{enumerate}` | `+ item` | literal |
| `\begin{description}` | `/ Term: Description` | literal |
| `\begin{tabular}` | `#table(...)` / `#grid(...)` | literal |
| `\begin{figure}` | `#figure(...)` | literal |
| `\begin{equation}` | `$ x $` + `#set math.equation(numbering: ...)` | literal |
| `\begin{align}` | `$ x &= y \ z &= w $` | literal |
| `\newcommand{}` | `#let f = ...` / `#let f(x) = ...` | literal |
| `\renewcommand` | `#show ...: ...` | literal |
| `\include{}` `\input{}` | `#include "ch.typ"` | literal |
| `%` comment | `//` `/* */` | literal (markup AND math) |
| `\frac` | `a/b`, `a/(b+c)`, `frac(a,b)` | error `unknown variable: rac` |
| `\alpha` … | `alpha` … or `#sym.alpha` | `unknown variable: lpha` |
| `\sum_{i=0}^n` | `sum_(i=0)^n` | `unknown variable: um` |
| `\int_0^1` | `integral_0^1` | `unknown variable: ntegral` |
| `\lim_{x\to 0}` | `lim_(x -> 0)` | `unknown variable: im` |
| `\text{}` | `"..."` | `unknown variable: ext` |
| `\mathrm{d}x` | `dif x` | `unknown variable: athrm` |
| `\left( \right)` | automatic; `lr(...)` | `unknown variable: eft` |
| `\{ \}` grouping | `( )` (may vanish); `{ }` = visible braces | `\{` = literal brace |
| `\sqrt{x}` | `sqrt(x)` | error |
| `\sqrt[n]{x}` | `root(n, x)` | — |
| `\cdot` | `dot` | `unknown variable: cdot` |
| `\times` `\div` | `times` `div` ✓ | work! |
| `\infty` | `oo` (also `infinity`) | error |
| `\le \ge \ne` | `<=` `>=` `!=` | error |
| `\equiv` | `eq.triple` | `==` = two glyphs |
| `\to \rightarrow` `\Rightarrow` `\Leftrightarrow` | `->` `=>` `<=>` | error |
| `\mathbb{R}` | `RR` / `bb(R)` | error |
| `\mathcal{L}` `\mathfrak{g}` | `cal(L)` `frak(g)` | error |
| `\mathbf{x}` `\mathrm{x}` | `bold(x)` `upright(x)` | error |
| `\hat \tilde \dot \vec` | `hat(x)` `tilde(x)` `dot(x)` `vec(x)` | error |
| `\bar{x}` | `overline(x)` / `accent(x, macron)` | `bar` = `\|` glyph |
| `\underbrace{a}_{b}` | `underbrace(a)_(b)` | error |
| `\cancel{x}` | `cancel(x)` | error |
| `\binom{n}{k}` | `binom(n, k)` | error |
| `\|x\|` | `norm(x)` / `lr(|x|)` | literal pipe, no scale |
| `\left|...\right|` | `abs(...)` | error |
| `\lfloor \rfloor` | `floor(...)` `ceil(...)` | error |
| `\,` `\;` `\quad` | `thin` `thick` `quad` | literal |
| `\operatorname{foo}` | `op("foo")` | error |
| `\cdots` `\ldots` | `dots.c` `dots.h` | error |

### 5.15 Cross-language conversion (Markdown → Typst) — full table

| Markdown | Typst | Markdown form in Typst |
|---|---|---|
| `**bold**` | `*strong*` | empty strongs + warning + literal |
| `*italic*` | `_emph_` | `*text*` = STRONG (swapped!) |
| `_italic_` | `_emph_` ✓ | works (emph) |
| `# heading` | `= heading` | error `expected expression` |
| `- item` | `- item` ✓ | works identically |
| `1. item` | `+ item` (or `1. item` ✓) | works |
| `[link](url)` | `#link("url")[text]` | content block + auto-detected url link |
| `![img](path)` | `#image("path")` | literal |
| `<b>bold</b>` | `#text(weight: "bold")[bold]` | `<b>` = label syntax → warning |
| `\| a \| b \|` | `#table(...)` | literal pipes |
| `` `code` `` | `` `code` `` ✓ | raw works |
| `> quote` | `#quote[...]` | `>` literal |
| `~strike~` | `#strike[...]` | `~` = nbsp |
| `---` hr | `#line(length: 100%)` | `---` = em dash |
| fences ``` ``` | fences ✓ | works |

**Unicode**: typing `α θ λ ≠ ≤ ≥ → ⇒ ∑ ∫ — ✓` directly works everywhere (no inputenc needed). Gotchas: `²` `³` are plain characters (use `x^2`); `−` (U+2212) vs `-`; homoglyphs `λ/Λ`, `∂/δ`; prefer named symbols in math for correct classes/spacing.

---

## 6. Layout

### 6.1 The container hierarchy

- **box** — inline container: stays in the text line; params `inset`, `outset`, `width`, `height`, `clip`, `baseline`, `radius`; NEVER breaks across pages; text wraps within.
- **block** — block-level container: own paragraph; params `breakable` (multi-page), `above`/`below` (vertical space), `sticky`, `inset`, `outset`, `width`, `height`, `fill`, `stroke`, `radius`. `#block(breakable: true)[long text]`.
- **place** — absolute positioning relative to parent container (or page at top level): `#place(top + right, dx: 1cm, dy: 0pt)[overlay]`. Inserts an invisible block-level marker (can break paragraphs — wrap in `box` + `sym.wj` mid-paragraph).
- **Floats** (0.13 — there is NO `float()` function; `float` is the number type): `#place(bottom, float: true, clearance: 6pt)[floating note]`. `place.flush()` forces queued floats out. Column-spanning: `place(top + center, scope: "parent", float: true)`.
- **v / h** — vertical/horizontal spacing: `#v(2em)`, `#v(1fr)` (flexible — center content with `#v(1fr)` + content + `#v(1fr)`), `#h(1fr)` (right-align), `weak: true` to allow collapse, `h(0pt, weak: true)` destroys surrounding space.
- **pad** — padding: `pad(x: 10pt, y: 5pt)` / `pad(10pt)` / `pad(rest: 2em)` — NO `inset:` param (`unexpected argument: inset`; inset lives on box/block).
- **align** — `#align(center)[..]`, `#align(top + right)`, `#align(horizon)`.
- **grid** — uniform cells: `grid(columns: (1fr, 2fr), rows: auto, [a], [b], [c], [d])`; int shorthand `columns: 2` = 2 equal columns.
- **table** — per-cell control: `table(columns: 2, stroke: 0.5pt, [a], [b], [c], [d])`; spans (`colspan`), alignment, stroke per cell. Use grid unless you need per-cell features (table is slower).
- **columns(n)** — multi-column text flow; `colbreak()`.
- **stack** — flex container: `stack(dir: ltr, spacing: 4pt, ..items)` (0.12+).
- **rotate/scale/skew/move** — transform elements: `#rotate(90deg)[text]`, `#scale(0.5)`, `#skew(20deg)`, `#move(dx: 1pt)`.

### 6.2 context, measure, here, layout

```typst
#context { let w = measure([Hello]).width; [measured width: #w] }
#context here().page()                       // current page number
#context layout(size => [width #size.width]) // container size
#context measure([text]).height
```

- These are only available inside `#context { }` — otherwise `can only be used when context is known` (0.13 removed `style()` and `measure(styles:)` in favor of `context`).
- Contextual expressions resolve per-placement: the same expression in different locations sees different values (feature, not bug).

### 6.3 Layout pitfalls

| ❌ | ✅ |
|---|---|
| `#float(...)` | `#place(align, float: true, ...)` (no float fn in 0.13) |
| `#rect(width: 1fr)` | `#rect(width: 100%)` (fr only meaningful in flex containers; `box(width: 1fr)` compiles — box accepts fractions) |
| `#pad(inset: 10pt)` | `#pad(x: 10pt, y: 10pt)` |
| `place` mid-paragraph | `#box(place(...))` + `sym.wj` |
| `measure(...)` bare | `#context { measure(...) }` |
| `#stack(dir: "ltr")` | `#stack(dir: ltr)` |
| negative margin | `#pad(x: -20pt)[...]` |
| `box(breakable: ...)` | unknown param — boxes don't break; use block |
| `table` everywhere | `grid` for uniform layouts |
| `columns(2)` with spanning content | `place(scope: "parent", float: true)` |
| `#v(2em)` inside placed overlay | relative to parent container |

---

## 7. Styling: set and show rules

### 7.1 set rules

- `#set text(size: 11pt, font: "Libertinus Serif", fill: rgb("#222"), weight: "bold", style: "italic", lang: "en", tracking: 0.02em, fallback: true, baseline: 0.8em, top-edge: "ascender")`.
- `#set par(justify: true, leading: 0.65em, first-line-indent: 1.8em, hanging-indent: ..., spacing: 1.2em)`.
- `#set page(paper: "a4", margin: 2cm, columns: 1, numbering: "1", header: ..., footer: ..., background: ..., fill: ...)`.
- `#set heading(numbering: "1.")`; `#set list(marker: [--])`; `#set enum(numbering: "I.")`; `#set figure(numbering: "1.", supplement: [Fig.])`.
- **Only element functions are settable** (`#set lorem(20)` → "only element functions can be used in set rules"; `#set calc.min(...)` likewise).
- Only *settable* parameters (declared with `Settable` in the docs) work.
- Scope: from the rule to the end of the enclosing block/file; content BEFORE the rule is unaffected. `#set text(..) if cond` = conditional.
- `#set page(...)` cannot live inside containers ("page configuration is not allowed inside of containers").

### 7.2 show rules

**Selectors**: element fn (`#show heading:`), text (`#show "Project":`), regex (`#show regex("\w+"):`), label (`#show <intro>:`), `where` (`#show heading.where(level: 1):`), everything (`#show: body => ...`).

**RHS forms**:
- set rule: `#show heading: set text(navy)` — show-set; stays overridable by later set rules (preferred over set-inside-show).
- function transform: `#show heading: it => block[#emph(it.body)]` — receives the element, returns content; field access `it.body`, `it.level`, `it.numbering`.
- string: `#show "badly": "great"` — literal replacement (danger: re-match loops).
- content: `#show <intro>: [fixed text]`.
- function application: `#show: template.with(title: [X])` — whole-document.
- declaration style: `#show: smallcaps` — applies to the rest of the scope.

**Semantics**:
- Set rules apply first, then show rules. Multiple show rules chain; among same-specificity rules, the one declared closest to the content wins.
- Show rules only affect content AFTER them in source order (verified: `@ref` to a heading whose numbering set rule comes later fails with "cannot reference heading without numbering").
- Recursion: `#show heading: heading` (re-emitting the same element) → infinite recursion. Transform fields instead. `#show "a": "a"` → divergence.
- 0.13: `#show par: ...` only affects "proper paragraphs" (paragraph break = blank line).
- `#show page: ...` is unsupported (0.15 warns).

### 7.3 Styling functions & colors

- `#text(fill: blue, 18pt)[styled]`; `#text(style: "italic", weight: 700)`; `#text(fill: gradient.linear(red, blue))[gradient]`.
- Colors: 120+ named (`red`, `navy`, `maroon`, ...), `rgb("#0178A4")`, `rgb(0-255, 0-255, 0-255)`, `luma(50)`, `oklch(...)`, `cmyk(...)`; `color.transparentize(50%)`, `.lighten()`, `.darken()`.
- Gradients: `gradient.linear(red, blue, angle: 45deg)`, `gradient.radial`, `gradient.conic` (0.11+ names; `linear-gradient` is dead).
- Numbering patterns: `"1."` `"I."` `"(a)"` `"1 / 1"` (page x of y) `"1.2"` (hierarchical) `"1.1.1"`; function: `numbering((n) => ...)`.
- Block-scoped styling: `#[{ #set text(red) this is red }]`.
- Fonts: `#set text(font: ("Libertinus Serif", "Noto Sans"), fallback: true)`; check discovery with `typst fonts`; unknown fonts → silent fallback warning.
- `#show math.equation: set text(font: "New Computer Modern Math")` for math fonts.

### 7.4 Styling pitfalls

| ❌ | ✅ |
|---|---|
| `#set lorem(20)` | only element functions |
| `#set text(fill: "red")` | `red` / `rgb(...)` |
| `#set heading(weight: "bold")` | weight is a text param: `#set text(weight: "bold")` |
| set rule after content | rules apply from position onward — place before |
| `#show heading: block(above: 1.4em)` (no set) | `#show heading: set block(above: 1.4em, below: 1em)` |
| `#show heading: it => heading(it)` | infinite recursion — use `it.body` |
| `#show: template` at file end | show-everything affects only content after — put at TOP |
| `#show regex(".*"): it => [x]` | replaces generated content too — keep regexes targeted |
| `#[{ #set text(red) }]` empty block | wrap the CONTENT inside the block |

---

## 8. Introspection: counter, state, query, metadata, locate

### 8.1 counter

- `counter(heading)`, `counter(page)`, `counter(figure)`, `counter("custom-name")`.
- `.get()` → current value (requires context); `.at(<label>)`; `.step()`; `.update(n)` (0.13: single value — `update(level:, value:)` and tuples are 0.14+); `.display("1.")`.
- Reset pattern: `#counter(heading).update(1)` before a new chapter with `#set heading(numbering: "1.1")` — deeper levels auto-derive.
- Page numbering: `#set page(numbering: "1 / 1")`; headers: `#set page(header: context { counter(page).display() })`.
- 0.13: `counter(page).display()` without arguments uses the page numbering (behavior change).

### 8.2 state

- `#state("name", default)`; `.update(v)` (no context needed); `.get()` (context); `.at(loc)`.
- Update order = document order, NOT source order — reading state in headers where updates are ambiguous produces "document did not converge within five attempts" warnings. Update in body flow only.
- Use for: toggles, question counters, collected values (`state.append`? no — dict/array values; keep state values simple).

### 8.3 query & metadata

- `#context query(heading).len()`; `#context query(<label>)`; `#context query(<label>).first().value` for metadata values.
- `#metadata(42) <m>` — invisible content, queryable; for data extraction (`typst query main.typ "<m>" --field value`).
- Selectors: `query(heading.where(level: 1))`, `query("heading")` (0.13+ string selectors), `query(<label>)`.
- **Plain text elements are not locatable** — `typst query ... "text"` fails with `text is not locatable`; query headings/labels or add metadata.

### 8.4 locate & here

- `#context locate(<label>).position()` / `.page()`; `#context here().page()`.
- All introspection needs `context` (0.13 removed `state.display()`, location args on `counter.at`/`state.at`/`query`, and `style()`).

---

## 9. Documents

### 9.1 Page setup

```typst
#set page(
  paper: "a4",                        // "us-letter", "presentation-16-9", ...
  margin: (x: 2cm, y: 2.5cm),         // or (top:, right:, bottom:, left:)
  columns: 1,
  numbering: "1 / 1",
  header: context { counter(page).display() },
  footer: none,
  background: none,                   // content: watermark pattern
  flipped: false,                     // NOT flip (0.13: flip errors)
)
#pagebreak()  #colbreak()
```

- One set page at the top; changing margins mid-document forces a page break (documented limitation; use negative `pad` for margin dives).
- Watermark: `#set page(background: rotate(45deg)[DRAFT])` or a `tiling` pattern.
- Landscape: `flipped: true` or a paper with width > height; `header-ascent:`/`footer-descent:` ratio params exist; `#pagebreak(to: "odd")` and `pagebreak(weak: true)`/`colbreak(weak: true)` work.

### 9.2 Running headers

```typst
#set page(header: context {
  let sec = query(heading.where(level: 1)).last()
  if sec != none { sec.body } else { none }
})
```

First-page-special: `#set page(header: context { if counter(page).get().first() == 1 { none } else { ... } })`.

### 9.3 Bibliography

```typst
#bibliography("refs.bib")                    // BibLaTeX
#bibliography("refs.yml")                    // Hayagriva (native)
#bibliography(("a.bib", "b.bib"))            // multiple files
#set bibliography(title: "References", style: "apa", full: true)
// citing:
See @humphrey97 and also @smith2020.
#cite(<humphrey97>, form: "prose")           // "Humphrey et al."
#footnote[@key]                              // footnote citation
```

- `full: true` REQUIRED to list uncited works. `style`: default `"ieee"`; dozens built in (`apa`, `mla`, `chicago-author-date`, `nature`, `vancouver`, `american-physics-society`, `gb-7714-2015-numeric`, ...); custom CSL via path.
- Unknown key → `label '<key>' does not exist in the document` on 0.13 (red in web app, error in CLI).
- 0.15+: multiple bibliographies with `target:`/`group:`; 0.13 uses "closest following bibliography" auto-assignment only.
- `#bibliography(bibliography(sources: [...]))` with inline entry dicts does NOT exist — `sources` takes paths/bytes/arrays.

### 9.4 Multi-file projects

```typst
// main.typ
#import "defs.typ": *
#include "chapters/intro.typ"
#include "chapters/methods.typ"
#bibliography("refs.bib", full: true)
```

- `#include` = raw content (chapters); `#import` = definitions (helpers). Extension required.
- Show/set rules in included files leak document-wide — scope or use template functions.
- No shared mutable globals across files — use `state`.
- Circular imports error.

### 9.5 Document metadata

`#set document(title: "…", author: "…", keywords: (...))` (0.13 has `description`; the `title` element is 0.14+). Extracted via `typst query main.typ "<title>" --field text` etc.

---

## 10. Packages & ecosystem

### 10.1 Package system mechanics

- `#import "@preview/name:0.1.0"` (binds module `name`), `: *` (all items), `: a, b` (items), `as x` (rename), `#import "@local/name:0.1.0": *`.
- **Exact version is mandatory** — no ranges, no "latest": `#import "@preview/cetz"` is a hard error.
- `package @preview/x:0.1.0 not found` = wrong pin / typo / case mismatch / offline first fetch.
- Case-sensitive. First use downloads to cache; offline afterwards.
- Locations: cache `%LOCALAPPDATA%\typst\packages\preview\{name}\{ver}` (Local); local installs `%LOCALAPPDATA%\typst\packages\local\{name}\{ver}` (empirically verified on 0.13.1 — some docs say `%APPDATA%`; the "searched at ..." error message prints the real path). Linux: `$XDG_CACHE_HOME`/`~/.cache` and `$XDG_DATA_HOME`/`~/.local/share`; macOS: `~/Library/Caches` and `~/Library/Application Support`. `typst info` is 0.14+.
- Publishing = PR to github.com/typst/packages; manifest `typst.toml`: `name`, `version`, `entrypoint`, `authors`, `license`, `description`, `compiler` (min Typst version), `exclude`, optional `[template]` (title, category).
- Transitive deps pin exact versions; two cetz versions in one document = two independent modules (fletcher 0.5.8 pins cetz 0.3.4).
- `#import "@preview/x:0.1.0": *` can shadow builtins — prefer renaming (`as x: ...`) or specific items.

### 10.2 DEAD packages (verified 404 on 2026-08-08 — never recommend)

`arrows`, `vega`, `chart`, `preprint`, `simple`, `artify`, `ieee-conf`, `thesis`, `academic`, `emojify`, `grify`, `circo`, `metropolis`, `typst-package` (publishing CLI repo). Replacements: fletcher/commute/tiptoe/xarrow (arrows), nulite (vega-lite), cetz-plot/primaviz/lilaq (charts), preprintx/diprint/clean-math-paper (papers), built-in `emoji` module (emojis, 0.13+), cades/zebra/tiaoma (QR), circuiteria/zap (circuits), metropolyst (metropolis for touying).

**hydra** is running headers, NOT a drawing library: `#import "@preview/hydra:0.6.3": hydra` + `hydra(1)`/`hydra(2)` inside `#set page(header: context {...})`.

### 10.3 CeTZ (drawing; verified compiled on 0.13.1 with cetz 0.4.2)

```typst
#import "@preview/cetz:0.4.2"          // 0.5.x requires Typst >= 0.14; pin 0.4.2 for 0.13
#cetz.canvas({                          // code block, NOT [content]
  import cetz.draw: *                   // MUST be inside the canvas body
  line((0, 0), (3, 2), stroke: 1.5pt + red, mark: (end: ">"))
  circle((1.5, 1), radius: 1cm, fill: blue.lighten(80%))
  rect((0, 0), (2, 1), fill: green, radius: 2pt)
  polygon((0, 3), (1, 4), (2, 3))
  bezier((0, 0), (1, 2), (2, -1), (3, 0))
  content((3, 3), [label], anchor: "south-west")   // 0.4.x name; renamed text() in 0.5.x
  circle((30deg, 2), radius: 2pt)       // polar coordinate (angle, radius)
  line((+1, 0), (0, 0))                 // relative to last position
  grid((0, 0), (5, 5), step: 1, stroke: gray)
  group(name: "g", { circle((0, 0), radius: .5) })  // named groups
})
```

- Canvas auto-grows; 1 unit = 1cm default (`length: 5cm` rescales; ratio relative to parent). Options: `x-min/x-max/y-min/y-max` (clamping), `origin`, `clip`, `background`, `name`, `debug`.
- Coordinates: `(x, y)` floats/lengths, polar `(angle, radius)`, relative `(+dx, -dy)`, named element refs `(name)` / `("a.north", ...)`, canvas anchors `"center"`, `"north-east"`, `"origin"`, `"south-west"` (0.4.x compass set; 0.5.x adds border anchors like `"bottom-left"`).
- `mark: (start: ..., end: ">", fill: ...)` dict for arrowheads (0.2/0.3+ API; old `mark: ">"` string styles are dead).
- Modules: `cetz.draw`, `cetz.tree`, `cetz.angle`, `cetz.state`, `cetz.math`.
- Docs are "work in progress"; the universe page example is authoritative. Any tutorial predating late 2024 (cetz 0.3.x) likely uses removed syntax.
- **Mistakes**: `#canvas([...])` with content (needs code block); draw fns undefined (missing `import cetz.draw: *` inside body); wrong unit types; mixing cetz versions.

### 10.4 cetz-plot (plotting; needs cetz ≥ 0.5 → Typst ≥ 0.14)

```typst
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.4": plot, chart
#cetz.canvas({
  import cetz.draw: *
  plot.plot(x: (0, 10), y: (0, 10), {
    plot.add(plot.line(((0, 0), (2, 4), (4, 3), (8, 7)), stroke: blue))
    plot.add(plot.points(((1, 1), (5, 5), (9, 2)), mark: (end: "x")))
  })
})
```

- `chart.bar`, `chart.pie`, `chart.process`, `chart.cycle` for charts.
- Cannot pair cetz-plot 0.1.4 with cetz 0.4.2 (version conflict). On Typst 0.13: hand-rolled axes or matplotlib fallback.
- Old bundled `cetz.axis`/`cetz.plot` (cetz 0.2/0.3 era) is gone.

### 10.5 fletcher (commutative diagrams & flowcharts; verified compiled 0.5.8)

```typst
#import "@preview/fletcher:0.5.8": diagram, node, edge, shapes

// Math-mode commutative diagram: & separates columns, \ rows
#diagram(cell-size: 15mm, $
  G edge(f, ->) edge("d", pi, ->>) & im(f) \
  G slash ker(f) edge("ur", tilde(f), "hook-->")
$)

// Content-mode flowchart
#diagram(
  node-stroke: 1pt,
  node((0, 0), [Start], corner-radius: 2pt, extrude: (0, 3)),
  edge("-|>"),
  node((0, 1), align(center)[Process], shape: shapes.diamond),
  edge("d,r,u,l", "-|>", [Yes], label-pos: 0.1),
)
```

- `diagram` args: `node-stroke`, `node-fill`, `edge-stroke`, `cell-size`, `spacing`, `axes`, `debug`.
- `node(position, label, shape:, radius:, width:, height:, corner-radius:, extrude:, enclose:, layer:, inset:)`; shapes from `fletcher.shapes`: diamond, pill, parallelogram, hexagon, ellipse, octagon, trapezium, cylinder, brace, bracket, paren, stretched-glyph...
- `edge(start?, end?, label?, marks, bend:, corner:, decorations:, vertices:, label-pos:, label-angle:, label-side:, dodge:, shift:, snap-to:, loop-angle:, layer:, stroke:)`.
- Edge mark strings: `->` `-|>` `-->` `<->` `|->` `-o` `-x` `hook-->` `-<|` `||-` crow's foot `n`/`n?`/`n!` brackets `"["` `"]"` (0.5.8+).
- Implicit edges: `edge("-|>")` continues from previous node.
- Feynman-style math edges: `edge("rd", "-<|-")` with `&`.
- `fletcher.hide()` for incremental slide builds; touying has a `fletcher-diagram` wrapper via `touying-reducer`.
- **0.5.0+ breaking**: string labels NOT allowed positionally on `edge()` — content or `label:`. NO `flow()`, NO `A -- B`/`=>` (0.1.x-era syntax).

### 10.6 nulite (Vega-Lite, WASM plugin; `vega` is dead)

```typst
#import "@preview/nulite:0.1.0": render
#render(width: 100%, height: 100%, zoom: 1, json("spec.json"))
```

- Spec width/height IGNORED — pass to `render`. `url` data loading errors — inline data only. No interactivity/tooltips. WASM plugins need Typst ≥ 0.11.1 (fine on 0.13, web app and CLI).

### 10.7 Slides — touying (verified compiled 0.7.4)

```typst
#import "@preview/touying:0.7.4": *
#import themes.simple: *             // theme submodule: simple, metropolis, dewdrop, university, aqua, stargazer
#show: simple-theme.with(aspect-ratio: "16-9")
= Section title slide                // level-1 heading = section slide
== Slide one                         // level-2 heading = each slide
Content...
#pause                               // own line
More content...
```

- Common theme args: `aspect-ratio: "16-9"`/`"4-3"`, `align`, `config-common(handout:, frozen-counters: (...))`, `config-info(title:, subtitle:, author:, date: datetime.today(), institution:, logo: emoji.school)`.
- `#title-slide()`, `#outline-slide()`, `#focus-slide[...]`, `#section-slide[...]`, `#speaker-note[...]` (needs `show-notes-on-second-screen`), `#cols[...][...]`, `#cols(columns: (1fr, 1fr), gutter: 1em, lazy-layout: true)[...][...]`.
- Animation: `#pause` (own line), `#meanwhile`, `#uncover("2-")[...]`, `#only("2-")[...]`, `#alternatives[...][...]`, math pauses inside `$...$`, callback style `#slide(repeat: 3, self => ...)`.
- CeTZ/Fletcher animation wrapper:
  ```typst
  #let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
  #let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)
  ```
  then `(pause,)` tuples inside bodies mark animation steps.
- Export: PDF native; PPTX/HTML via touying-exporter.
- Mistakes: missing `#import themes.<name>: *` → unknown function; `#pause` inline in a paragraph does nothing (own line); show rule after content; old `themes.default` → `themes.simple`.

### 10.8 Slides — polylux (verified compiled 0.4.0)

```typst
#import "@preview/polylux:0.4.0": *
#set page(paper: "presentation-16-9")
#set text(size: 25pt)
#slide[
  #set align(horizon)
  = Very minimalist slides
]
#slide[
  == First slide
  Some static text.
  #uncover(2)[But this appears later!]
]
```

- `#slide[ ... ]` blocks; no separators, no theme machinery.
- Reveal: `#only(n)[...]` (no space reserved) vs `#uncover("n-")[...]` (space reserved); `#show: later` replaces `#pause` (scope-limited; `strand:` for parallel tracks); `#alternatives`, `#list-one-by-one`, `#enum-one-by-one`, `#terms-one-by-one`, `#fit-to-height`, `#side-by-side`.
- `polylux.toolbox` module: progress bars, sections, big/full-width.
- pdfpc integration for speaker notes.
- **0.4.0 removed**: `#pause`, themes, `===` separators, `polylux-init` API. Old 0.2.x tutorials fail. Themes are separate packages (`metropolis-polylux`, `helios-polylux`, `parcio-slides`, `basic`).

### 10.9 codly (code block styling; verified compiled 1.3.0)

```typst
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *     // optional icons/colors
#show: codly-init.with()                        // mandatory — without it codly does nothing
#codly(languages: codly-languages)

// then any fenced block gets styled:
// ```rust
// fn main() { println!("Hello!"); }
// ```
```

- `#codly(number-format: none)` off line numbers; `zebra-fill: none` off striping; `#codly(highlights: ((line: 4, start: 2, end: 8, fill: red), ))`; `#codly(skips: ((5, 32), ))`; `#codly-range(start: 5, end: 10)`; `#codly-offset(5)`; annotations `@<label>:<line>`; `#codly-disable()` / `#no-codly[...]`.

### 10.10 pinit (pin annotations; 0.2.2)

```typst
#import "@preview/pinit:0.2.2": *
A simple #pin(1)highlighted text#pin(2).
#pinit-highlight(1, 2)
#pinit-point-from(2)[It is simple.]
```

- Functions: `pin(name)`, `pinit(callback: (..positions) => ...)`, `pinit-place`, `pinit-rect`, `pinit-highlight`, `pinit-line`, `pinit-line-to`, `pinit-arrow`, `pinit-double-arrow`, `pinit-point-to`, `pinit-point-from`, `simple-arrow`, `double-arrow`, `pinit-fletcher-edge(fletcher-module, ...)`.
- 0.2.0 breaking: `#pinit(pins, func)` → `#pinit(callback: func, ..pins)`.
- Known misalignment issues: add a blank line before `#pinit-xxx`, try `#pinit-xxx()#box()`, tune `dx`/`dy`.

### 10.11 QR codes (cades; `grify` dead)

```typst
#import "@preview/cades:0.3.1": qr-code
#qr-code("https://typst.app", width: 3cm)   // height, color, background, error-correction: "L"|"M"|"Q"|"H"
```

Others: `tiaoma` 0.3.0 (barcodes+QR), `rustycure`, `zebra`.

### 10.12 Templates (official current set)

`charged-ieee` 0.1.4, `modern-cv` 0.10.0, `appreciated-letter`, `badformer`, `cereal-words`, `dashing-dept-news`, `icicle`, `unequivocal-ams`, `wonderous-book`. **Dead**: `preprint`, `simple`, `thesis`, `academic`, `artify`, `ieee-conf` (all 404). Preprint replacements: `preprintx` 0.1.0, `diprint` 0.1.1, `clean-math-paper` 0.2.8, `arkheion`.

```typst
#import "@preview/charged-ieee:0.1.4": ieee
#show: ieee.with(
  title: [A typesetting system],
  abstract: [...],
  authors: ((name: "M. Haug", department: [Co-Founder], organization: [Typst GmbH],
             location: [Berlin], email: "x@typst.app"),),
  index-terms: ("Typesetting",),
  paper-size: "us-letter",
  bibliography: bibliography("refs.bib"),
  figure-supplement: "Figure",
)
```

- Template = arbitrary function; apply with `#show: <fn>.with(...)` or NOTHING happens (the #1 template mistake).
- Param names differ per template: charged-ieee `authors:` array of dicts vs modern-cv `author:` dict with `firstname:`/`lastname:`. Read the template's own universe page.
- modern-cv 0.10.0 needs Roboto + Source Sans Pro + FontAwesome fonts (`--font-path` or system install; silent fallback otherwise).
- `typst init @preview/<name>:<version>` scaffolds; offline fails.

### 10.13 matplotlib fallback (the pragmatic choice)

```sh
python -c "import matplotlib.pyplot as plt; plt.plot([1,2,3]); plt.savefig('plot.png', dpi=300, bbox_inches='tight', transparent=True)"
```

```typst
#figure(image("plot.png", width: 100%), caption: [Loss curves]) <fig-loss>
```

Use when: complex stats (error bars, box plots, log scales, seaborn), Typst 0.13 (cetz-plot incompatible), deterministic output, iteration speed. Don't use when: simple diagrams that should match document fonts (cetz/fletcher text inherits document fonts; matplotlib text won't).

### 10.14 Other verified packages

`theorion` 0.6.0 (theorems/proofs), `numbly` 0.1.0 (heading numbering), `fontawesome` (icons), `codly-languages` 0.1.1, `echarm` 0.4.0 (ECharts WASM), `lilaq` 0.6.0, `gribouille` 0.6.0, `primaviz` 0.8.0, `simple-plot` 1.0.0 (charts), `timeliney` 0.4.0, `gantty` 0.5.1 (Gantt/timelines), `circuiteria`/`zap` (circuits), `tiptoe` 0.4.0, `xarrow` 0.4.0, `commute` 0.3.0, `larrow` 1.2.0 (arrows), `metropolyst` 0.1.0 (touying metropolis), `min-book` 1.5.0, `classicthesis` (theses), `basic-resume` 0.2.9 (ATS CV), `postercise`/`pasquino` (posters).

### 10.15 Package pitfalls mega-list

1. `package @preview/x:0.1.0 not found` — wrong/old version, typo, case, or offline first fetch. Check the universe page.
2. Missing version → hard error.
3. Template imported but never applied — missing `#show: <fn>.with(...)`.
4. cetz 0.5.x on Typst 0.13 → pin `cetz:0.4.2`.
5. cetz draw functions undefined — `import cetz.draw: *` must be inside the canvas body.
6. `#canvas([...])` content block → canvas takes a code block.
7. cetz units — coordinates are floats/lengths/angles in canvas units (1 unit = 1cm default); type errors common.
8. fletcher 0.5+: string labels not positional on `edge()` — content or `label:`.
9. fletcher old API (`flow`, `A -- B`, `=>`) is dead.
10. touying: missing theme import; `#pause` inline; show rule after content.
11. polylux 0.4: `#pause` removed → `#show: later`.
12. Bibliography: not at end / `full: true` missing / `@key` typo → `label '<key>' does not exist in the document`.
13. Paths are FILE-relative on 0.13 (`#include`/`#image` resolve from the containing file) — compile from the project root with `--root .` for the security boundary; 0.15 bans backslashes.
14. PNG blurry — `--ppi 300` (default 144).
15. Fonts missing → silent fallback; `typst fonts`; template fonts (modern-cv) must be installed.
16. Local packages live in `%LOCALAPPDATA%\typst\packages\local` (verified 0.13.1; some docs say Roaming), cache in `%LOCALAPPDATA%\typst\packages\preview` — the "searched at ..." error prints the real path; `typst info` is 0.14+.
17. Show-rule leakage through `#include`.
18. `counter.display`/`state.get` outside `context` — hard error since 0.13.
19. Template param shapes differ per template — read the universe page.
20. Transitive deps: fletcher pins cetz 0.3.4; two cetz versions = two modules.
21. SVG text renders with local fonts; PNG from matplotlib is deterministic.
22. WASM plugins: no URL data loading in specs (nulite), compile-time execution.
23. Emoji: `#emoji.x` needs a color emoji font (Noto Color Emoji/Segoe UI Emoji).
24. `typst query` = JSON by default; `--field` extracts; 0.15 → `typst eval`.

---

## 11. CLI & tooling

```sh
typst compile main.typ                          # main.pdf in cwd
typst compile main.typ out.pdf                  # explicit output
typst compile --root . main.typ                 # THE fix for broken #image/#include paths
typst compile --font-path fonts/ main.typ       # extra font dirs (or TYPST_FONT_PATHS)
typst compile --format png --ppi 300 main.typ out-{0p}.png   # {0p}/{p}/{t} page templates
typst compile --format svg main.typ             # one SVG per page
typst compile --jobs 8 main.typ                 # parallel
typst watch main.typ                            # incremental recompile
typst init @preview/charged-ieee:0.1.4          # scaffold template
typst fonts [--font-path fonts/]                # list discovered fonts
typst query main.typ "heading" --field body --one   # JSON by default; 0.15+: typst eval
# typst info is 0.14+ (prints package path/cache path)
typst update
```

- **Path resolution**: `#image`, `#include`, `#import`, `#bibliography`, `#read` resolve relative to the **containing file's directory** on 0.13 (empirically verified); `--root` defines the security boundary (files outside it → access denied). Run `typst compile --root . main.typ` from the project root to keep everything consistent.
- `--input k=v` → `sys.inputs.k`; env: `TYPST_FONT_PATHS`, `TYPST_IGNORE_SYSTEM_FONTS`, `TYPST_ROOT`, `TYPST_PACKAGE_PATH`, `TYPST_FEATURES` (0.13; only feature: `html` via `--features html`).
- No `typst preview` command — preview = tinymist-based editor extensions.
- Tooling: **tinymist** (LSP; powers the VS Code extension + typst-preview), **typst-fmt** (deterministic formatter), **typstyle** (alternative), **tytanic/typst-test** (package test runner), **touying-exporter** (PPTX/HTML).
- PNG default ppi 144 (blurry); multi-page PNG needs `{p}` template or error. SVG: one file per page, text uses local fonts.
- 0.15: `typst eval` supersedes `typst query`; paths may NOT contain backslashes (forward slashes only, even on Windows); new `path` type resolving relative to the containing file.

---

## 12. Debugging

### 12.1 Toolkit

- `#repr(x)` — inspect element structure (`#repr([some content])`).
- `#type(x)` — inspect value type.
- `#context text.size` — what styles are active at a location.
- `typst query main.typ "heading" --field body` — inspect generated structure without eyeballing PDFs.
- `typst fonts` — font discovery.

### 12.2 Error catalog (error → cause → fix)

| Error | Cause / fix |
|---|---|
| `can only be used when context is known` | `measure`/`here`/`locate`/`counter.get`/`state.get` outside `#context { }` |
| `expected auto, relative length, or fraction, found integer` | units missing: `box(width: 10)` → `10pt`/`10%` |
| `expected color, gradient, or tiling, found string` | `fill: "red"` → `red`/`rgb(...)` |
| `expected content, found function` | function where content expected (e.g. `limits(sum)` with shadowed `sum`) |
| `unknown variable: X` | missing `#`, multi-letter math run, undefined name, use-before-definition |
| `cannot join integer with integer` | block/loop yields non-content → end with `none` |
| `unexpected argument` / `the argument b is positional` | named-without-default / positional-for-default mismatch |
| `type arguments has no method sum` | `..args` is `arguments` → `args.pos().sum()` |
| `module 'math' does not contain 'eval'` | `#eval(src, mode: "math")` |
| `only element functions can be used in set rules` | `#set` on non-element |
| `page configuration is not allowed inside of containers` | `#set page(...)` in a block/function — top-level only |
| `cannot reference text` / `cannot reference link` | `@` on plain text/link — label headings/figures/equations |
| `label '<key>' does not exist in the document` | `@key` typo or missing bib entry |
| `text is not locatable` | `typst query` on text — query headings/labels or add `#metadata` |
| `unknown font family` | font missing → fallback; `typst fonts` |
| `cannot divide by zero` | guard the division |
| `expected direction, found string` | `dir: ltr` not `"ltr"` |
| `unknown symbol modifier` | symbol doesn't exist in this version's table |
| `invalid number suffix: h` | no duration literals → `duration(hours: 1)` |
| `expected expression` | `# heading` (Markdown ATX) — `#` is code mode |
| `package @preview/x:0.1.0 not found` | wrong pin/typo/case/offline — check universe |
| `unknown variable: xy` (math) | multi-letter run — space it: `$x y$` |
| `missing argument: body` | required positional body missing (e.g. `figure(caption:)` alone) |
| `unknown variable: cdot` | `dot` not `cdot` |
| `document did not converge within five attempts` | state updated/read ambiguously (headers) — update in body flow |

### 12.3 Troubleshooting walkthroughs

- **Math prints literally**: content came from a string — `"..."` → `[...]`.
- **Literal "let x = 5" in output**: missing `#`.
- **Bold not working**: you wrote `**text**` (Markdown) — use `*text*`.
- **Show rule has no effect**: placed after the content — move it before; document templates at the very top.
- **Package "doesn't work"**: version too old/new (cetz 0.5.2 on 0.13), missing show rule, or wrong function name.
- **Header empty**: needs `context { ... }` for counters.
- **Include breaks the document**: the included file's set/show rules leak — scope or use a template function.
- **Fractions wrong**: `a/b/c` is (a/b)/c — group with parens; missing parens in scripts.
- **Diagram errors**: cetz canvas needs a code block; `content()` vs `text()` by version; anchors differ by version.
- **Blurry PNG**: `--ppi 300`.
- **Charts too complex**: matplotlib → PNG.

---

## 13. Deep dives

### 13.1 Content model internals

Content is a tree of element nodes. Each element is produced by an element function and carries fields. `content.func()` returns the element function (branch on type in show rules); `content.fields()` lists field names; `.at("body")`/`.has("body")` access. Field access `it.body` works when the field was explicitly set (optional fields from set rules are not directly accessible). `repr()` is the debugger — the web app hovers show the same structure.

### 13.2 Evaluation semantics

- Everything is an expression; there are no statements in the value sense. `#let` inside code blocks yields `none` (joins as nothing) — this is why blocks with bindings render nothing extra.
- Code blocks join ALL statement values: `#{ 1; 2 }` = content "1 2"; `#{ let x = 1; x }` renders "1".
- Function calls with trailing content: the body becomes the last positional arg — this is how `#box[...]` works.
- `eval` is compile-time, pure, and NOT contextual — it cannot see layout; combine with `context` for runtime values.
- Math auto-wrap: math content returned from functions auto-wraps in an `equation` when placed in markup (the "Mathy" trait) — that's why `$#rect(...)/x$` works and `#let e = $x^2$; #e` re-renders as math. A string never auto-wraps.

### 13.3 The show-rule engine

Show rules form a transformation pipeline: set rules first (accumulated defaults), then show rules applied outermost-rule-first per element. Show rules with selectors match elements; `it` receives the matched element with set defaults merged. Rules declared later with equal specificity take precedence. Show-everything (`#show: fn`) wraps the whole remaining document — it receives the full body as its argument, which is why templates use `.with(...)` for configuration and must appear before content. Recursion happens when a rule re-emits the same element type it selects — always transform fields rather than re-calling the element function.

### 13.4 Context and the layout algorithm

Typst is a two-pass-ish system: content is evaluated, then laid out, then introspection (counters, state, query, here, locate) is resolved; context expressions are re-evaluated per placement with layout knowledge (that's why `measure` works only in context). `state` updates are applied in document order; reading a state that updates later in the same pass triggers iterative refinement — hence the "did not converge" warning for ambiguous header reads. Design rule: update state in body flow, read with `.get()`/`.at()` in context, avoid read-write cycles in headers.

### 13.5 Why `float()` doesn't exist (0.13)

Floats were reworked in 0.12: the element function was removed; floating is now a placement mode — `place(align, float: true, clearance: ...)`. The identifier `float` is the number type (e.g. `float("3.5")`). Any old code using `#float(...)` must be rewritten as `#place(..., float: true)`.

### 13.6 Math parsing rules (from the parser)

- `^`/`_` parse one "atom" (parenthesized group, letter, number, symbol, field access).
- Chained scripts nest right-associatively — `e^x^2` = `attach(e, t: attach(x, t: 2))`.
- `unparen`: parens around fraction num/denom, radicands, and script arguments are removed at parse time; everything else keeps them.
- A "math call" requires the identifier to be directly followed by `(` — a space turns it into implicit multiplication + parens.
- `;` inside math call args merges preceding comma-args into a 2D array (rows for `mat`).
- Whitespace between atoms = implicit multiplication; whitespace around `+`/`-`/`=` = spacing, not grouping.
- Multi-letter runs lex as identifiers (variable lookup) — single letters lex as math characters. This asymmetry is the root of most math bugs.

### 13.7 Package resolution & version skew

`#import "@preview/x:0.1.0"` resolves through the cache (`{cache}/typst/packages/preview/{x}/{0.1.0}`), downloading on first use. Local data-dir packages take precedence over cache. Packages pin their OWN transitive `@preview` deps exactly; two different versions of the same package in one document are two distinct modules with independent state — mixing APIs across them (e.g. pinit's `pinit-fletcher-edge` expecting a specific fletcher) breaks silently. Rule: match the versions the docs of each package actually use.

### 13.8 Why agents produce broken Typst (root causes)

1. LaTeX/Markdown reflexes — never error, silently corrupt output. Always write `\frac`-free, `**`-free code.
2. String-vs-content confusion — math/formatting placed in `"..."`.
3. Missing `#` in markup, or `#` inside code blocks.
4. Multi-letter math runs.
5. Missing units/types (`width: 10`, `fill: "red"`, `1fr` outside flex).
6. Version drift — package docs/tutorials from wrong eras.
7. Named-arg-without-default mistakes and `arguments` vs array confusion.
8. Forgetting `context` for introspection.

---

## 14. Reasoning workflows (complex tasks)

### 14.1 Generating a full paper from scratch

1. `#set page(paper: "a4", margin: 2.2cm, numbering: "1")` + `#set text(11pt)` + `#set par(justify: true)` + `#set heading(numbering: "1.")` at the top.
2. Sections: `= Intro` etc. — body in markup mode; math inline `$...$`; display equations `$ ... $ <label>` with `#set math.equation(numbering: "(1)")`.
3. Figures: `#figure(image("fig.png", width: 80%), caption: [...]) <fig-x>` and reference `@fig-x`.
4. Tables: `#table(...)` with `#set table(stroke: 0.5pt)`; or grid for uniform.
5. Citations: `@key` + `#bibliography("refs.bib", style: "apa", full: true)` at the end.
6. Compile with `typst compile --root . main.typ`; verify with `typst query` if needed.

### 14.2 Building a multi-chapter thesis

- `defs.typ`: all `#set` rules + custom functions + `#show` rules (kept out of chapters so they don't leak).
- `chapters/*.typ`: pure body content (headings, text, figures).
- `main.typ`: `#import "defs.typ": *` then `#include` chapters in order, bibliography at end.
- Running headers with current chapter via `context` + `query`.
- Compile from the root: `typst compile --root . main.typ`.

### 14.3 Designing a slide deck

1. Choose touying (`themes.simple` — verified current API).
2. `#import "@preview/touying:0.7.4": *` + `#import themes.simple: *` + `#show: simple-theme.with(aspect-ratio: "16-9")`.
3. Level-1 headings = section slides; level-2 = content slides.
4. `#pause` on its own line for step-by-step reveals.
5. For diagrams: wrap cetz/fletcher with `touying-reducer` for staged animation.

### 14.4 Creating a diagram in cetz

1. Pin the right version (0.4.2 for Typst 0.13).
2. `#cetz.canvas({ import cetz.draw: * ... })` — remember the inner import.
3. Place shapes at `(x, y)` (1 unit = 1cm); name elements to reference their anchors (`circle((0,0), radius: .5, name: "c")` → `"c.north"`).
4. Labels: `content(pos, [text], anchor: "south-west")` (0.4.x).
5. Arrows: `line(..., mark: (end: ">"))`.
6. Compile early, iterate — canvas auto-sizes so layout errors are rare.

### 14.5 Debugging any Typst error

1. Read the location (file:line:col) — 90% of errors are one line away.
2. Categorize: parse (`expected expression`) vs eval (`unknown variable`, type errors) vs layout (`context` errors) vs resolution (`package not found`, `label '<key>' does not exist`).
3. For eval errors: check `#` presence, types/units, named-arg defaults, math identifier runs.
4. For layout: wrap in `context`, check container scope.
5. For packages: verify version against the universe page TODAY (not your memory).
6. Sanity-check the simplest fix first: `[...]` instead of `"..."`.

### 14.6 Choosing the right tool

| Need | Tool |
|---|---|
| text/headings/lists | markup syntax |
| equations | `$...$` native |
| simple figures/tables | `#figure(image(...))`, `#table` |
| simple diagrams/flowcharts | cetz / fletcher |
| plots (lines/bars/scatter) | cetz-plot (0.14+), primaviz, or matplotlib PNG |
| complex stats (seaborn etc.) | matplotlib → PNG |
| slides | touying |
| CV | modern-cv or basic-resume |
| paper (IEEE) | charged-ieee |
| QR | cades |
| code blocks | codly |
| annotated text | pinit |
| running headers | hydra or manual context |

---

### 14.7 Power-user patterns (distilled from real UCLouvain study documents, all compile-verified on 0.13.1)

These are the idioms a power user actually employs across ~900 KB of production study documents (dense formulaire layout, theorem boxes, signal-processing notes, PDE/analysis courses). Patterns are verified; adopt them wholesale for high-quality documents.

### 14.7.1 Math styling via shadowed helpers (the master technique)

```typst
#let imp(body) = text(fill: blue.desaturate(10%).darken(10%), weight: "bold", body)
#let def(term) = text(fill: red, weight: "bold", term)
#let strong(txt) = text(weight: "bold")[#txt]
#let ok(body) = text(fill: green.darken(25%), weight: "bold")[#body]
#let ko(body) = text(fill: red.darken(15%), weight: "bold")[#body]
#let muted(body) = text(fill: luma(40%), size: 0.9em)[#body]
#let hl(x) = text(fill: purple, x)
```

Why this works: in math mode, bare identifiers resolve only to math builtins, symbols, and **user `#let` bindings in lexical scope**. The real `strong` errors with `unknown variable: strong — try adding a hash`. Shadowing `strong`/`imp`/`def`/etc. makes them callable **bare in math**: `$&strong("Name")$`, `$imp(P(A|B) = ...)$`, `$underbrace(H(Y|X), imp("Recursive Separation"))$`. One real doc uses 131 `#place(` injections, 123 `underbrace`, dozens of these helpers. Also verified: `text(fill: #color.purple, W)` works in math (named colors are `color` module fields; the `#` is mandatory), `#text(red)` positional-fill works in markup, and `text(color.green.darken(40%), "Alice")` compiles.

### 14.7.2 Aligned formula tables (the `&` column grid)

```typst
$ &strong("Expected Value")  &quad& EE[X] = sum_(x) x P(x) \
  &strong("Bayes Theorem")   &quad& imp(P(A|B) = (P(B|A)P(A)) / P(B)) \
  &&& quad quad quad quad = H(Y) - H(Y|X) $
```

Mechanics: math blocks are implicit tables — `&` = cell separator, `\` = row break. Leading `&` opens an empty spacer, the name goes in column 2, `&quad&` isolates the `quad` in column 3, the equation starts column 4 → layout `[spacer | NAME | quad | equation]`. Continuation rows re-enter the equation column with `&&&` + manual `quad` padding (eyeball hack — fragile if the name column widens). Variants: `cases("Electrons" &minus.circle : e^- -> Q=-q, "Holes" &plus.circle : h^+ -> Q=+q,)` for labeled case branches (the original docs write `minus.o`/`plus.o` — that's the 0.14 `.o` family; on 0.13 use `.circle`), and the 4-zone physics masterpiece `cases("ZQN"&: -&infinity &< x < -&l_(p 0) &: &0, ...)` aligning every sub-expression column.

### 14.7.3 Annotation devices (margin notes inside math)

- **`underbrace(expr, "label")`** — the primary note device; `\n` inside the string = line break; the label slot accepts ANY content: `underbrace(H(Y|X), imp("Recursive Separation"))`, `underbrace(q (n mu_n + p mu_p), sigma) E`, `underbrace(beta, "phase\nconstant"#footnote([...]))` (footnote inside a label!), `underbrace(a + b)_("result")` with post-subscript, and even `underbrace(expr, label)[e^(V/(2 phi.alt_T))-1]` with bracket content after.
- **`#place` inside math**: `underbrace(H(X), #place(center, dx: -2em)[#text(size: 7.5pt)[Uncertainty on X]])` — `place` escapes math layout, centers under the brace, takes `dx`/`dy` nudges. 131 uses in one doc.
- **Text over relations**: `stretch(=)^"Expand"`, `stretch(->)^(mu_x=0)`, `stretch(<=>)^"Mirror Symmetry"_"180° Chart Rotation"` (sub AND superscript on one stretched relation), `stretch(arrow.b, size: #300%)` (size via `#` interpolation).
- **Derivation-step arrows inside one math block**:
  ```typst
  $ y[m] &= w[m M]\
    &#box(width: 0.8em, $stretch(arrow.b, size: #300%)$) #block([#v(-1em) M-fold Decimation])\
    &= 1/(2 pi) sum_(k=0)^(M-1) integral_(0)^(2 pi) W(e^(j Omega)) e^(j m M Omega) dif Omega $
  ```
  `#block` is legal inside math rows; `#v(-1em)` pulls the note up beside the arrow. Used 19× in one doc for step-by-step FFT derivations.
- **Colored math pills**: `#box(fill: red.lighten(40%), inset: 3pt, radius: 5pt, $+$)` — highlight the single sign difference between two lines.
- **`cases` variants**: `cases(delim: #none, ...)` (no brace), `cases(delim: "|", ...)`, `cases(reverse: #true, ...)` (flipped brace — verified 0.13), nested cases, `cases(... & ...)` alignment inside branches.
- **`mat`**: `mat(1, 2; 3, 4)` rows by `;`; `mat(delim: "|", ...)` determinant bars; `mat(delim: "[", 1, 0, 0, |, 0, 1, 1; ...)` — a bare `|` as an in-row column separator; **trailing `;` tolerated**; `dots.v`/`dots.h`/`dots.down` (diagonal) inside matrices.
- **`#diagMath`/`#diagBox`**: `#let diagMath(bodyMath) = text(size: 11pt)[#bodyMath]` (scale math by wrapping in text) and `#let diagBox(body) = h(0.4em) + block(stroke: 0.05em, inset: 0.5em, body) + h(0.4em)` — inline bordered boxes inside signal-flow chains: `$ underline(u) -> diagBox("Code") stretch(->)^(x) diagBox("Channel") -> ... $`.

### 14.7.4 The metadata-collection pattern (self-describing content)

```typst
#let auto_box_fetcher(box-type, gap: 2pt) = context {
  let hits = query(metadata)
    .filter(m => type(m.value) == dictionary)
    .filter(m => m.value.box-type == box-type)
    .map(m => m.value.at("box", default: none))
  stack(dir: ttb, spacing: gap, ..hits)
}
// emitter side — every box wraps its content:
#let definition-bx(..args) = [#metadata((box-type: "Definition", box: outer_box)) #outer_box]
// consumer side — auto-build an exam-prep section:
== All Definitions
#auto_box_fetcher("Definition")
```

`metadata` renders invisible but is locatable and carries arbitrary dict values. Content self-describes: no bookkeeping, no global state. Compose with ranged selectors for subranges: `selector(metadata.where(value: "par")).after(heading_loc).before(end_loc)`. Paragraph census for reading-time estimates:
```typst
show par: it => { it [#metadata("par")] }   // TWO statements — one-liner is a parse error
```
then count with `__qrange(selector(metadata.where(value: "par")), start, end_loc: end)` — `where` on an element function builds a value-field selector; `.after(start).before(end)` chains into ranges; `__section_end_loc` scans headings for the next sibling-or-parent. ⚠️ `query(selector(table))` fails on 0.13 (`table is not locatable`; locatable since 0.14).

### 14.7.5 Compound selectors & breadcrumb headers

```typst
#set page(header: context {
  let hs = query(selector(heading).before(here(), inclusive: true))
  let active = (none,) * 3
  for h in hs { if h.level <= 3 { active.at(h.level - 1) = h
    for k in range(h.level, 3) { active.at(k) = none } } }
  let crumbs = active.filter(x => x != none)
  if crumbs.len() == 0 { return none }
  crumbs.map(h => {
    let nums = counter(heading).at(h.location())
    let num = if h.numbering != none { numbering(h.numbering, ..nums) } else { "" }
    if h == crumbs.last() { text(fill: black, weight: "semibold")[#num #h.body] }
    else { text(fill: luma(120))[#num #h.body] }
  }).join(h(6pt) + text(fill: luma(180))[#sym.angle.r] + h(6pt))
})
```
`selector(X).before(here(), inclusive: true)` finds all headings before the current position; the per-level active-array algorithm (set slot, clear deeper slots) resolves the nearest enclosing heading per depth; `counter(heading).at(location)` + `numbering(h.numbering, ..nums)` renders in the heading's own scheme. `sym.chevron.r` is 0.14+ — use `sym.angle.r` on 0.13.

### 14.7.6 Show rules & context power moves

- **Show rule returning an array**: `#let heading_formatter(it) = { let result = []; if ... { result += pagebreak() }; result += block[#grid(columns: (1fr, 60pt), it, ...)]; result }` + `#show heading: heading_formatter` — the show engine joins the array. Guard auto-pagebreaks with `it.outlined` so outline-generated headings don't trigger them. Style config keyed by `str(it.level)` with dict defaults.
- **`context` propagates through function calls**: a helper invoked from inside `context { }` can read `page.width`/`page.height` (outside context → hard error).
- **`set page` inside a wrapper function** works on 0.13 — the module pattern: `#let formulaire(title: "Formulaire", course: "COURSE", layout: "horizontal", body) = { let cfg = layout_config(layout); set page(...); set text(...); ...; body }` + `#show: formulaire.with(...)`. One declarative switch fans out a whole layout (landscape 3-col vs portrait 2-col).
- **`flipped:`** (not `flip`) is the correct 0.13 param; `header-ascent:`/`footer-descent:` ratio params exist; `#pagebreak(to: "odd")`, `pagebreak(weak: true)`, `colbreak(weak: true)`.
- **`#show link: underline`** — one-liner alias.

### 14.7.7 Grid/table construction kit

- `(1fr,) * ncols` array repeat; partial-last-row centering with identical column widths: `colw = (100% - gutter * (ncols - 1)) / ncols`; `align(center)[block(width: colw * rem + gutter * (rem - 1))[grid(columns: (1fr,) * rem, ...)]]`.
- `stroke: 1pt + white` + per-cell `fill:` = seamless colored spreadsheet; stroke **functions** `stroke: (x, y) => if y == 0 { (bottom: 0.7pt) } else if x != 0 { (left: 0.7pt) } else { none }` for book-style rules.
- `table.cell(rowspan: 5, fill:, align: center + horizon)` vertical category banners with `#place(dy: 10pt)[#align(center, text(size: 8pt)[...])]` secondary captions.
- `#let sm(x) = [#h(-0.1em) #text(size: 7pt)[$#x$]]` — tiny-math header cells; strings/ints render upright inside `$#x$`, math content renders as math.
- `#let wdqp = 1em` named column-width constants; mixed `(7em, auto, 1fr, wdqp, ...)` specs.
- `#align(center)[#block(width: 110%)[...]]` — let a wide table bleed past the text column.
- Custom figure numbering: `numbering: (x) => numbering("1.a", counter(figure.where(kind: image)).get().at(0), idx + 1)` with `kind: "sub_figure"`; `supplement: [Figures]`.
- Opacity by overlay: `place(top + left, rect(width: 100%, height: 100%, fill: rgb(255, 255, 255, 100% - 25%)))` over a background image grid.
- Box building: per-side `stroke: (left: ..., bottom: none)` dicts; per-corner `radius: (top-left: 4pt, ...)`; `#v(-10pt)` negative-space overlap to fuse a title strip and body; `move(dx: -4pt)` + `width: 100% + 8pt` to indent a nested box; color algebra `color.lighten(40%).desaturate(60%)`; `#let pill(label, fill: colors.category, ink: white) = box(inset: (x: 3pt, y: 0.8pt), radius: 1.5pt, fill: fill)[#text(size: 6.2pt, ...)]` chip component (all named params need defaults).
- Empty `#block()` spacers; `#figure(...)#block()` trailing figure space; `#block(inset: 1em)` indentation blocks.

### 14.7.8 Verified symbol/idiom inventory (0.13.1, compile-proven)

`plus.minus`, `minus.plus`, `inter`, `eq.triple`, `eq.delta`, `backslash` (`A_(backslash {0})` ✓), `\\` = literal backslash (set-minus idiom), `\/` = literal slash, `B_*` renders the `∗` glyph as subscript, `arrow.cw/ccw/b/t`, `integral.double/triple/cont`, `integral_"path"`, `underparen/overparen`, `dots.v/h/down`, `subset.eq`, `perp`, `cancel`, `ast.circle` (0.13; deprecated 0.14 → `convolve.o`), `times.o`/`plus.o` (0.14+; 0.13 = `times.circle`/`plus.circle`), `#text(fill: #color.purple, ...)` in math, `#table` inside math (`$#table(...) -> #table(...)$`), footnotes inside math/underbrace labels/table cells, `#link(...)` inside math, `datetime.today().display("[year]-[month]-[day]")`, `#sym.tilde`, `#sym.wj`, `(none,) * n`, `#text(size: 10pt)[$...$]` scaled math blocks, `#scale(80%, [...])`, function-valued `stroke:` on grid AND table.

### 14.7.9 Anti-patterns seen in the wild (avoid in generated docs)

1. `@fig:label` referencing an undefined label → hard error (dangling label is a compile failure).
2. A stray `}` inside math compiles silently — proofread around braces.
3. Single-element arrays of dicts: `((name: "A"))` collapses to a plain dictionary → `type dictionary has no method map`. Always write `((name: "A"),)`.
4. `#sym.chevron.r`, `times.o`, `query(selector(table))` break on 0.13 — version-check every fancy feature.
5. `#v(-10pt)` title overlaps break when titles wrap to two lines.
6. OCR-style typos in prose (`sminfinityther`, `Prinfinityf`) are invisible to the compiler — keep a lint pass for prose.
7. The `&&& quad quad quad quad=` continuation indent is fragile — keep name columns short or use a real `align` block.
8. `#text(fill: color.purple, ...)` (no `#`) fails in math — always `#color.purple`.
9. `ast.circle` renders but warns on 0.14; upgrade to `convolve.o` when targeting 0.14+.
10. `#show par: it => { it [#metadata("par")] }` on ONE line is a parse error — two statements required.

---

## 15. Version notes (0.13 → 0.14 → 0.15)

- **0.13.0**: `style()`/`measure(styles:)` removed → `context`; `state.display()` removed; `counter.at`/`state.at`/`query` no longer take `location:`; `path`→`curve` deprecated 0.13 / removed 0.14 (visualize); image arg `path:`→`source:`; `par` show rules affect only "proper paragraphs"; removed symbols `ohm`/`kelvin`/`degree.c`/`degree.f`; added `inter`/`sect` (deprecated)/`numero`/`eq.triple.not`/`smt`/`lat`/`mapsto`/`asymp`/`interleave`; `emoji` module added; `lcm` operator added; math single-letter strings render upright; `--features html` experimental. (`float()` was removed in **0.12** — use `place(float: true)`.)
- **0.14.0**: `frac(style:)`; `math.scr`; `equation(alt:)`; `title` element; `counter.update(level:, value:)`; math text shaping; named-arg errors on symbol calls; `sym.chevron.*`; tables/par/enum/list locatable; circled symbols unified to `.o` (`times.o` etc.).
- **0.15.0**: `path` type (explicitly file-relative); backslashes banned in paths; `typst eval` supersedes `query`; `--pretty`; multiple bibliographies (`target:`/`group:`); shadowing warnings for `#import ... : *`. (Watch live-reload HTTP for HTML was 0.13.0.)
- **Docs drift**: only `times.o` is genuinely absent in 0.13 (use `times.circle`); `ast.circle` deprecated in 0.14 (→ `convolve.o`) — always check the version's table.

---

## 16. Rules of thumb (final)

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
11. When debugging, check the string-vs-content trap, the `#` trap, and the version trap first — they cause the majority of failures.
12. If a task exceeds pure-Typst sanity (complex plots, exotic fonts), the matplotlib→PNG fallback is professional practice, not a cop-out.

