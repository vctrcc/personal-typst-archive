# LELEC2348 Gen 1 Formulaire Analysis

## Purpose

This report analyzes the recurring writing, layout, annotation, and component patterns in:

- `courses/LELEC2348_Information_Theory_And_Coding/formulaire.typ`

It compares those patterns with:

- `templates/template_formulaire_gen2.typ`

The objective is not to copy the Gen 1 implementation. LELEC2348 is the source of truth for the successful writing style and human workflow; Gen 2 should preserve that workflow through cleaner, reusable components.

This report also records the design rationale clarified after the initial audit:

- short helper names are intentional productivity tools;
- descriptive helper names are equally important for discovery and clarity;
- box-body tint communicates breakability;
- box colors communicate purpose;
- pills are flexible annotations, not merely fixed exam markers;
- nested sub-boxes require their own parallel component system;
- metadata should support generated collections of selected cards;
- math annotations need fine positional control rather than only semantic colors.

---

## 1. Source hierarchy

When designing or using the Gen 2 formulaire system, apply these sources in order:

1. Course sources determine technical correctness, notation, and scope.
2. The LELEC2348 formulaire determines the target writing style, density, visual logic, and practical authoring workflow.
3. The Gen 2 template determines the implementation API and reusable components.

Old LELEC2348 implementation techniques such as repeated manual colors, `place`, and locally redefined boxes should not be copied when Gen 2 can express the same intent cleanly.

---

## 2. Character of the LELEC2348 writing style

The document's strongest recurring style is a dense, exam-oriented sequence of semantic boxes containing:

- formula-first explanations;
- definitions close to their first use;
- assumptions beside affected formulas;
- compact aligned derivations;
- short interpretations and conclusions;
- annotated algebraic terms;
- edge cases and equality conditions;
- repeatable solution procedures;
- explicit exam checks and common failure modes.

It is not textbook prose. It compresses wording while retaining enough reasoning to reconstruct a solution under pressure.

A representative content sequence is:

1. state the definition or governing relation;
2. identify assumptions and symbols;
3. expose the reusable derivation step;
4. state the conclusion or usable bound;
5. add a check, special case, or warning where useful.

This sequence should remain a writing convention rather than becoming one rigid component.

---

## 3. Gen 1 box system

### 3.1 Observed usage

Approximate active uses in the LELEC2348 formulaire are:

| Helper | Approximate uses | Typical purpose |
|---|---:|---|
| `fbox` | 88 | Compact definition, identity, or core result |
| `subdefbox` | 46 | Nested reminder, theorem, local definition, or distinction |
| `tbox` | 27 | Explanation, example, demonstration, or derivation |
| `fbbox` | 8 | Breakable main theory box with tinted body |
| `exerbox` | 7 | Exercise material or exercise-session container |
| `ebox` | 6 | Exam question, trap, or detailed exam solution |

Representative areas include:

- compact information-theory results around lines 135–311;
- rate-distortion exercises around lines 347–535;
- channel coding and coding-theorem material around lines 715–2846;
- exercise-session structures around lines 3100–3434;
- security exercises and exam solutions around lines 4097–4639.

### 3.2 Intended visual logic

The Gen 1 system was not an arbitrary collection of colors:

- **Green** was the main theory/result family.
- **Blue** was generally used for exercises and examples.
- **Red** was reserved for exams or unusually important material.
- **Light blue** identified nested definition/sub-box material.
- **White body** indicated a non-breakable box.
- **Tinted body** indicated a breakable box.

The body tint is therefore an interaction cue: if a tinted box becomes long, the reader knows that it may continue in the next column or page. This is useful in a dense multi-column document.

### 3.3 `fbox` and `fbbox`

The relationship between these names is intentional:

- `fbox`: principal green box with white body; non-breakable;
- `fbbox`: corresponding green box with tinted body; breakable;
- the additional `b` means **breakable**.

This allows a writer to switch rapidly between the two while editing:

```typst
#fbox("Result")[...]
#fbbox("Longer result")[...]
```

Gen 2 should preserve this fast swap, even if descriptive names are also available.

### 3.4 Current Gen 2 mismatch

The current template maps:

```typst
#let fbox = fixedbox
#let fbbox = theorybox
#let tbox = theorybox
```

This preserves compilation but does not fully preserve Gen 1 semantics:

- `fbbox` and `tbox` become identical;
- the green theory family and blue explanatory family are no longer distinct;
- tint is not systematically tied to breakability across every box kind.

This should be treated as a design mismatch, not merely cosmetic variation.

---

## 4. Recommended dual API

The template should deliberately support two public naming layers.

### 4.1 Descriptive API

The descriptive API is for discovery, teaching, readability, and complicated documents. Proposed names:

```typst
result_box
breakable_result_box
theory_box
exercise_box
example_box
proof_box
exam_box
warning_box
todo_box
sub_box
equation_box
diagram_box
```

Naming can be finalized later, but each descriptive name should communicate purpose or behavior clearly.

### 4.2 Shortcut API

The shortcut API is for experienced human authors working quickly. It should remain compact:

```typst
fbox
fbbox
tbox
exerbox
examplebox
proofbox
ebox
warnbox
todobox
subdefbox
sbdefbox
eqbox
diagBox
```

Not every descriptive helper needs an arbitrarily shortened alias. Shortcuts should be included where they materially improve frequent writing.

### 4.3 Aliases are intentional, not accidental duplication

Multiple names pointing to the same implementation are acceptable when they serve two distinct authoring modes:

- short names optimize typing speed once the style is learned;
- descriptive names optimize readability and onboarding.

The template should document one canonical semantic meaning for each implementation. Aliases must not silently acquire different behavior.

### 4.4 Legacy wrapper

Historical names and signatures that are no longer part of the preferred API should be moved into a separate file explicitly named as a wrapper, for example:

```text
template_formulaire_gen2_legacy_wrapper.typ
```

Conceptual usage:

```typst
#import "template_formulaire_gen2.typ": *
#import "template_formulaire_gen2_legacy_wrapper.typ": *
```

The wrapper should only reconnect old names to current implementations. It should not copy rendering logic, colors, or layout code.

A staged migration is appropriate:

1. introduce and document the clean dual API;
2. retain current aliases temporarily;
3. migrate active formularies;
4. move obsolete names and old signatures to the legacy wrapper;
5. keep math-mode aliases that solve real Typst syntax constraints.

---

## 5. Box architecture

### 5.1 Private panel primitive

Most box types share:

- radius;
- border width;
- title layout;
- body inset;
- optional body tint;
- optional pills;
- breakability;
- metadata emission.

A private panel primitive should centralize these mechanics. Conceptually:

```typst
_panel(
  title,
  body,
  palette,
  breakable,
  pills,
  metadata,
  nested: false,
)
```

This primitive should not become the normal author-facing API. It exists to keep the implementation consistent.

The default radius and geometry can remain shared constants. Exposing every visual property on every box would make ordinary use unnecessarily noisy.

### 5.2 Smart box

The generic box entry point remains useful if it supports palettes correctly.

Proposed role:

```typst
#smartbox(
  "Title",
  kind: "theory",
  breakable: true,
  tags: ("exam",),
)[Body]
```

Requirements:

- validate unknown kind names instead of silently falling back to theory;
- accept a registered palette name;
- optionally accept a palette dictionary for assist-file extensions;
- connect breakability to body tint by default;
- emit structured metadata;
- support multiple pills;
- render through the same private panel primitive as named boxes.

A custom palette could be passed through a separate argument to avoid making `kind` polymorphic:

```typst
#smartbox(
  "Title",
  palette: custom_palette,
  breakable: true,
)[Body]
```

### 5.3 Breakability as a visible property

All major box families should support a `breakable` parameter. The body appearance should follow it unless explicitly overridden:

```typst
#theory_box("Short result", breakable: false)[...]
#theory_box("Long derivation", breakable: true)[...]
```

Default convention:

- `breakable: false` → white body;
- `breakable: true` → lightly tinted body using the box palette.

The shortcut pair remains valuable:

```typst
#fbox("Short result")[...]
#fbbox("Long result")[...]
```

These should point to the same semantic family with different breakability defaults.

### 5.4 Box color families

The five most important recurring semantic colors are:

| Color | Primary purpose |
|---|---|
| Green | Main theory, result, valid condition, success |
| Blue | Exercise, example, information, explanation |
| Red | Exam, critical result, danger, failure |
| Purple | Category, context, interpretation |
| Orange | Warning, qualification, extra/caution material |

These colors should be standardized in the theme and reused by:

- card palettes;
- inline semantic helpers;
- pills;
- box sections;
- labels;
- math annotations.

A color may support multiple related meanings, but helper names should keep those meanings explicit. For example, `def` and `danger` may both use red while retaining different semantics.

---

## 6. Box pills and tags

### 6.1 Pills are independent of box kind

A theorem, exercise, example, or theory result may independently be:

- exam-relevant;
- important;
- a warning;
- extra material;
- a definition;
- optional;
- course-specific.

Therefore, pill labels must not be coupled exclusively to box kinds.

Examples:

```typst
#theory_box("Data processing inequality", tags: ("exam",))[...]
#exercise_box("Optional derivation", tags: ("extra",))[...]
#example_box("Boundary case", tags: ("important", "warn"))[...]
```

### 6.2 Tag style dictionary

The built-in tag dictionary should include at least:

```text
exam
warn
important
extra
definition
proof
optional
```

Each entry can define:

- displayed label;
- fill color;
- text color;
- metadata key or normalized tag value.

Unknown strings should remain valid as custom pills using a documented fallback style.

### 6.3 Singular versus plural API

Because multiple pills are useful, the canonical argument should probably be plural:

```typst
tags: ("exam", "important")
```

For typing convenience, a single string can also be accepted:

```typst
tag: "exam"
```

The implementation should normalize both forms internally. The final API should avoid ambiguous precedence if both are supplied.

---

## 7. Searchable card metadata

### 7.1 Objective

Cards should emit hidden structured metadata so that a document can generate collections such as:

- all definitions;
- all exam-tagged cards;
- all warnings;
- all extra exercises;
- all proof boxes;
- all cards matching a course-specific tag.

The collection should reproduce matching cards in source order as one contiguous list.

Conceptual usage:

```typst
#collect_cards(tag: "definition")
#collect_cards(tag: "exam", title: [Exam material])
#collect_cards(kind: "proof")
```

Shortcut possibilities can be considered after the main API stabilizes.

### 7.2 Required metadata record

Each card should emit a record containing at least:

```text
kind
semantic family
title
body
breakability
tags
source identity or location
```

Potential optional fields:

```text
summary
course chapter
importance
collection eligibility
custom palette key
```

### 7.3 Rendering architecture

Metadata collection must avoid recursively collecting the cards generated by the collection itself.

A safe architecture is:

1. public box helper constructs a card record;
2. it emits hidden metadata for that record;
3. a private renderer renders the card;
4. `collect_cards` queries matching original metadata;
5. it calls the private renderer directly with metadata emission disabled.

Conceptually:

```typst
_render_card(record, emit_metadata: false)
```

This prevents generated collections from creating new searchable copies and destabilizing Typst introspection.

### 7.4 Duplication risks

Duplicating arbitrary card bodies can have side effects:

- labels may be defined twice;
- counters may advance twice;
- citations may be repeated;
- contextual calculations may evaluate at a new location;
- large cards may make the collection impractical;
- diagrams may rely on local state or resources.

Possible controls:

```typst
collect: true
collection_body: none
collection_summary: none
```

A robust design could use this precedence:

1. use `collection_body` when explicitly supplied;
2. otherwise use `collection_summary` in compact mode;
3. otherwise duplicate the full body when allowed.

For initial implementation, full duplication can be supported with clear documentation. A later compact-summary mode would be valuable for definition indexes.

### 7.5 Filters

Useful filters include:

```typst
tag
kind
chapter
predicate
```

The first implementation only needs `tag` and `kind`. An arbitrary predicate can be added later if Typst's introspection ergonomics justify it.

---

## 8. Box sections

### 8.1 Evidence

LELEC2348 repeatedly combines:

```typst
#hline()
#underline[*Part (b) — Probability analysis*] \
```

These local headings organize:

- problem parts;
- assumptions;
- derivation stages;
- methods;
- checks;
- interpretations;
- conclusions.

The pattern is frequent enough to justify a reusable helper.

### 8.2 Proposed API

Descriptive name:

```typst
#box_section("Probability analysis")
```

Shortcut:

```typst
#bsec("Probability analysis")
```

Suggested parameters:

```typst
#box_section(
  title,
  separator: true,
  tone: none,
  spacing: auto,
)
```

Expected behavior:

- optionally insert a compact separator;
- render a compact structural title;
- use neutral styling by default;
- allow a semantic tone without requiring manual colors;
- avoid forcing a page or column break;
- work consistently inside all main and nested boxes.

Example:

```typst
#ebox("June 2022 — Security")[
  #bsec("Given", separator: false)
  The channel is memoryless with erasure probability $epsilon$.

  #bsec("Probability analysis")
  ...

  #bsec("Conclusion", tone: "important")
  #imp[The minimum valid block length is $n=178$.]
]
```

---

## 9. Structured labels

### 9.1 Objective

Small inline labels can standardize common transitions without requiring each author to manually choose bolding, punctuation, and semantic colors.

Desired categories include:

- hypothesis;
- assumption;
- condition;
- given;
- method;
- step;
- check;
- detail;
- extra;
- special case;
- conclusion;
- interpretation;
- warning;
- answer.

### 9.2 Naming direction

Bare `label` is too generic and risks confusion with Typst labels and references.

The descriptive functions should follow the requested `label_x` family, for example:

```typst
#label_assumption[The channel is memoryless.]
#label_check[The probability must lie in $[0,1]$.]
#label_extra[This case is outside the exam scope.]
```

Shortcut aliases should follow a compact `la...` convention. The exact contraction remains to be finalized. Possible forms include:

```typst
#laassumption[...]
#lacheck[...]
#laextra[...]
```

or abbreviated suffixes:

```typst
#laass[...]
#lachk[...]
#laext[...]
```

A generic implementation can back both layers:

```typst
#statement_label("assumption")[...]
```

The public convenience helpers then map to the generic implementation.

### 9.3 Avoid excessive abstraction

These helpers should remain compact inline prefixes, not become large callout boxes. A likely rendering is:

```text
Assumption: The channel is memoryless.
```

The label text receives semantic styling; the body remains normal text.

---

## 10. Nested sub-box system

### 10.1 Why sub-boxes need a parallel implementation

Nested cards have different constraints from top-level cards:

- smaller insets and title typography;
- reduced border weight;
- less vertical spacing;
- safe behavior inside already tinted parents;
- predictable break behavior;
- reduced visual dominance;
- avoidance of excessive nesting depth.

They should reuse theme values and metadata conventions but render through a nested panel variant.

### 10.2 Kinds

Suggested nested kinds include:

```text
definition
reminder
theorem
property
example
warning
extra
proof
```

### 10.3 API

Generic descriptive entry point:

```typst
#sub_box("Core reminders", kind: "reminder")[...]
```

Shortcuts can include:

```typst
#sbdefbox("Definition")[...]
#sbrembox("Core reminders")[...]
#sbthmbox("Theorem")[...]
#sbexbox("Local example")[...]
#sbwarnbox("Caution")[...]
```

The exact shortcut set should be limited to frequently used kinds. Creating aliases for every theoretical possibility would make the API harder to remember.

### 10.4 Breakability

The original `subdefbox` was intended to be non-breakable. That should remain the default for compact nested statements.

If a breakable nested box is permitted, it should visibly use a tinted body according to the same global rule. Long nested boxes may indicate that the material should instead become a top-level card.

---

## 11. Math annotation analysis

### 11.1 Why the current helpers are insufficient

The current `underNote` and `overNote` helpers standardize:

- brace creation;
- label size;
- semantic color;
- horizontal label offset;
- vertical label offset.

However, dense equations expose several different spacing problems:

1. the label may collide with neighboring terms;
2. the label may be visually too high or too low;
3. the brace and label may cause excessive line height;
4. the annotated expression may sit poorly relative to the equation baseline;
5. labels placed outside normal layout may require reserved space after the equation;
6. a pre-styled content label may be overwritten by helper styling.

The original manual `place` patterns existed because they gave direct control over these cases.

### 11.2 Preserve direct controls

The helper should expose explicit controls rather than hiding layout behind a small set of tones.

Candidate parameters:

```typst
underNote(
  expression,
  annotation,
  dx: 0em,
  dy: 0em,
  size: 7.5pt,
  tone: none,
  fill: none,
  reserve: 0em,
  expression_dy: 0em,
)
```

Potential meanings:

- `dx`: horizontal annotation displacement;
- `dy`: vertical annotation displacement;
- `size`: default annotation size;
- `tone`: semantic color lookup;
- `fill`: exact color override;
- `reserve`: additional vertical layout space where an overlaid label would otherwise collide;
- `expression_dy`: controlled movement of the annotated expression/brace unit if feasible without corrupting math alignment.

The exact Typst implementation must be prototyped because `place`, `move`, math layout, and reserved space do not behave identically.

### 11.3 Tone and fill precedence

A special `tone: "custom"` is unnecessary if an explicit `fill` parameter exists. A clearer rule is:

1. if `fill` is provided, use it;
2. else if `tone` is provided, resolve the semantic tone;
3. else inherit the annotation content's styling.

Passing both a semantic tone and explicit fill should either:

- make `fill` win, with documentation; or
- assert that only one may be supplied.

For human convenience, explicit fill winning is probably less frustrating.

Examples:

```typst
$ underNote(H(X), "source entropy", tone: "important") $
$ underNote(C, "capacity", fill: #orange.darken(20%)) $
$ underNote(R, [#text(fill: purple)[Code rate]], tone: #none, fill: #none, size: #none) $
```

### 11.4 Meaning of `tone: none`

`tone: none` in code mode—or `tone: #none` when called directly in math mode—should mean:

- do not impose a semantic color;
- inherit normal surrounding text color;
- preserve explicit styling inside content annotations.

The helper may still supply a default size. If preserving every aspect of pre-styled content is important, `size: none` should disable the size wrapper as well.

Possible rule:

```text
size: 7.5pt  → apply a default text size
size: none   → do not wrap the label in a size override
size: #none  → the same value when passed directly in math mode
```

### 11.5 Presets and manual control

Most annotations used a small number of recurring offsets. The API can provide optional presets without removing direct control:

```typst
preset: "normal"
preset: "tight"
preset: "raised"
preset: "lowered"
```

Explicit `dx` and `dy` should override the selected preset.

Presets are secondary. The direct numerical controls are the essential feature.

### 11.6 Naming

Keep `underNote` and `overNote` as the human-facing math-mode helpers. Their camelCase spelling avoids underscores being interpreted as math subscripts.

Code-mode implementations can remain private:

```typst
_under_note
_over_note
```

---

## 12. Inline semantic helpers

### 12.1 Existing useful meanings

The five-color system supports two complementary groups.

Academic roles:

```typst
def
imp
ind
cat
```

Outcome and explanation roles:

```typst
danger
success
info
warn
contextual
```

Neutral typography:

```typst
strong
small
```

These should remain available even when some pairs share a color. Semantic names help the author preserve meaning and make future restyling possible.

### 12.2 Short and descriptive aliases

Where useful, verbose forms can accompany the short forms:

```typst
def       / definition
imp       / important
ind       / indicator
cat       / category
warn      / warning
info      / information
```

The descriptive API should not require replacing the efficient short style used throughout LELEC2348.

### 12.3 Avoid uncontrolled color helpers

Exact arbitrary colors remain possible through ordinary Typst. The template should standardize recurring semantic roles rather than wrap every named color.

---

## 13. Exercise and exam organization

### 13.1 Exercise pattern

A successful recurring exercise structure is:

1. concise core reminders;
2. problem title;
3. assumptions and data;
4. formula or method;
5. calculation;
6. conclusion or check.

Representative examples occur around lines 3103–3424.

The current Gen 2 components are sufficient when combined with:

- `exercise_box` / `exerbox`;
- nested reminder boxes;
- `box_section` / `bsec`;
- semantic labels;
- `underNote` / `overNote`.

A rigid `exercise_solution` function is not recommended because exercises vary too much.

### 13.2 Exam pattern

Exam boxes commonly contain:

- given information;
- named events or variables;
- part-by-part reasoning;
- bounds and constraints;
- a highlighted final answer;
- interpretation or failure conditions.

The pill system should allow exam relevance to be independent from box family:

```typst
#theory_box("Coding theorem", tags: "exam")[...]
#exercise_box("Past exam application", tags: ("exam", "important"))[...]
```

A red exam box remains appropriate when the entire card is fundamentally an exam question.

---

## 14. Diagrams

### 14.1 Current use

LELEC2348 mixes:

- imported images;
- mathematical arrow chains;
- Fletcher diagrams;
- CeTZ diagrams;
- custom plots;
- table-based layouts;
- large locally defined diagrams.

The existing `diagram_box` only frames content. It does not make diagram construction faster.

### 14.2 Target use case

The shared template should make simple block diagrams quick:

```text
Source → Encoder → Channel → Decoder → Destination
```

The intended diagrams are not complex graph drawings. They are compact exam-reference pipelines and transformations.

### 14.3 Proposed built-in linear flow helper

A dependency-free helper could support linear horizontal or vertical flows:

```typst
#flow_diagram(
  ([Source], [Encoder], [Channel], [Decoder]),
  direction: "right",
)
```

Possible advanced form:

```typst
#flow_diagram(
  (
    (node: [Source], arrow: [$X$]),
    (node: [Encoder], arrow: [$M$]),
    (node: [Channel], arrow: [$Y$]),
    (node: [Decoder]),
  ),
  direction: "right",
)
```

Configuration could include:

```text
node fill
node stroke
arrow label
arrow style
spacing
direction
compact mode
```

A shortcut such as `flowdiag` may be appropriate if the helper proves common.

### 14.4 Scope boundary

The shared helper should initially support only:

- linear chains;
- preconfigured rectangular nodes;
- rightward or downward arrows;
- optional arrow labels;
- consistent compact styling;
- wrapping in `diagram_box` when desired.

Branches, loops, arbitrary coordinates, Tanner graphs, and communication-network diagrams should remain in a course assist file using Fletcher or CeTZ.

This keeps the template dependency-free and makes the common case fast.

### 14.5 Math-based versus graphical arrows

A simple built-in flow can use normal Typst layout and mathematical arrows. It does not need a full graph package if:

- nodes are laid out in a grid or stack;
- arrows are preconfigured content elements;
- branching is out of scope.

A prototype should verify behavior in narrow two- and three-column layouts before fixing the API.

---

## 15. Section and page structure

LELEC2348 uses level-one headings as major compartments and includes manual page breaks in several places. Gen 2 correctly centralizes:

- optional new pages before later level-one chapters;
- independent bibliography page breaks;
- optional front page;
- portrait/two-column and landscape/three-column layouts.

The helper names should remain secondary to normal Typst headings. A human author should be able to write:

```typst
= Channel Coding
```

without requiring a custom chapter command.

The current `topic` helper is asymmetric because it inserts a weak column break while `part` and `subtopic` are plain heading wrappers. This behavior should either be:

- documented prominently;
- exposed as `new_column: true`; or
- moved to a distinct helper such as `column_topic`.

---

## 16. Author metadata

The canonical document setting should be plural:

```typst
authors: [Victor Carballes]
```

The singular `author` argument creates ambiguity and inconsistent content/string defaults.

Recommended migration:

- use `authors` in `formulaire` and `intro_page`;
- keep singular `author` only in the legacy wrapper;
- avoid silently accepting both in the canonical API.

---

## 17. Public versus private API

The current wildcard import exposes implementation details such as:

```text
colors
layout_configs
layout_config
box_palettes
palette
box_tag_styles
box_tag
card_title
brace_annotation
hole_punch_overlay
```

Some theme dictionaries may intentionally be public extension points, but rendering internals should be marked private by convention.

Recommended organization:

### Stable public configuration

```text
default_theme
semantic tones
box palettes
tag styles
```

### Private implementation

```text
_layout_config
_panel
_panel_title
_render_pill
_render_card
_brace_annotation
_hole_punch_overlay
```

An underscore is only a convention in an imported Typst module, but it clearly communicates that a binding is not stable API.

---

## 18. Recommended source-file order

Because humans read the top of the file more frequently, the top should provide a concise usage map before implementation details.

Recommended order:

1. compact usage and feature reference;
2. public API index, showing descriptive and shortcut names together;
3. generation constant and stable public theme configuration;
4. private configuration resolution;
5. private rendering primitives;
6. public inline semantics and labels;
7. public pills, tags, and small components;
8. public main card system;
9. public nested card system;
10. equation, diagram, and flow helpers;
11. math annotations;
12. structural helpers and introduction page;
13. metadata collectors;
14. main `formulaire` wrapper;
15. temporary compatibility aliases, with obsolete compatibility moved to the legacy wrapper.

The implementation must still respect Typst's definition-before-use requirements. The top-level API index can document later definitions without attempting to call them.

---

## 19. Gen 2 capability assessment

### Already sufficient

Gen 2 already provides adequate support for:

- portrait and landscape column layouts;
- headers, footers, and page numbers;
- optional front page and outline;
- chapter and bibliography page-break policies;
- main theory, exercise, example, proof, exam, warning, and TODO boxes;
- arbitrary pills and built-in exam/warning pill mappings;
- core semantic emphasis;
- equations and diagram framing;
- note lines, separators, and estimates;
- basic brace annotations;
- hole-punch preview.

### Present but requiring redesign or clarification

- box aliases and color-family semantics;
- tint as an explicit breakability signal;
- `smartbox` validation and custom palettes;
- singular/plural author handling;
- visual tags versus searchable metadata;
- annotation styling precedence and positional controls;
- nested box kinds and shortcuts;
- `topic` column-break behavior;
- distinction between public configuration and internals.

### Missing and worth adding

- `box_section` with `bsec` shortcut;
- structured `label_x` helpers and selected shortcuts;
- searchable structured card metadata;
- card collection by tag or kind;
- a private shared panel primitive;
- a dependency-free simple linear flow-diagram helper;
- a separate legacy wrapper file.

### Deliberately outside the shared template

- complex course-specific diagrams;
- arbitrary graph layouts;
- large plotting systems;
- rigid universal exam-solution schemas;
- course-specific notation helpers;
- custom algorithms used by only one course.

Those belong in a `<main-file-stem>_assist.typ` file beside the course formulaire.

---

## 20. Recommended implementation phases

### Phase 1 — Preserve and clarify the existing design

1. Add `box_section` and `bsec`.
2. Restore tint as the default visual signal for breakable boxes.
3. Restore distinct green main-theory and blue exercise/example families.
4. Keep both descriptive and shortcut APIs.
5. Validate unknown `smartbox` kinds.
6. Normalize `authors` in the canonical API.

### Phase 2 — Tags and metadata

1. Expand the tag style dictionary.
2. Support multiple pills.
3. Emit structured hidden metadata from cards.
4. Add a non-recursive card renderer.
5. Implement collection by tag and kind.
6. Test duplicate labels, counters, citations, and contextual content.

### Phase 3 — Nested components and labels

1. Implement the nested sub-box renderer.
2. Add a small set of frequently used nested kinds.
3. Add `label_x` helpers.
4. Finalize shortcut spellings based on real authoring tests.

### Phase 4 — Math annotations

1. Prototype `place`-based and layout-reserving variants.
2. Add explicit `fill` with documented precedence over `tone`.
3. Make `tone: none` preserve content color.
4. Support disabling the default size wrapper.
5. Add reserve/offset controls that address actual equation collisions.
6. Keep direct numerical controls even if presets are added.

### Phase 5 — Diagrams and compatibility

1. Prototype a built-in linear flow helper in narrow columns.
2. Keep complex graphs in assist files.
3. Add the legacy wrapper.
4. Migrate one active formulaire as a practical compatibility test.
5. Move obsolete aliases from the main file only after migration succeeds.

---

## 21. Confirmed design decisions and implementation status

### Label shortcuts

Highly abbreviated names were selected and are documented beside the descriptive forms:

```typst
label_assumption / laass
label_check      / lachk
label_extra      / laext
label_conclusion / laconc
label_answer     / laans
```

The main template also includes the hypothesis, condition, given, method, step, detail, special-case, interpretation, and warning families.

### Tag collection semantics

Every visible pill emits searchable metadata by default. Cards store their complete normalized tag list in card metadata. `metadata_tags` adds searchable categories without displaying pills; this is used by default for semantic kinds such as nested definitions. A pill can opt out with `searchable: false` when it is deliberately decorative.

### Full-card duplication

`collect_cards` duplicates the full body by default. Cards may supply `collection_summary` for compact or safer duplication, and `collect: false` excludes a card entirely. Collected cards are rendered through the private renderer without emitting new card metadata, preventing recursive collection.

### Breakable variants

The main green family preserves the fast `fbox`/`fbbox` swap. Every descriptive main and nested box also exposes `breakable:`. Additional short pairs are not created until actual writing demonstrates a need.

### Diagram dependency policy

The shared template remains dependency-free for now. `flow_diagram` / `flowdiag` implements compact rightward or downward linear chains with optional arrow labels. Branches, loops, Tanner graphs, and coordinate-heavy diagrams remain course-assist-file responsibilities using Fletcher or CeTZ.

### Legacy wrapper

Obsolete concatenated descriptive names, `defn`, the singular-author `first_page`, and old diagram names are connected through `template_formulaire_gen2_legacy_wrapper.typ`. The wrapper contains aliases and adapters only; it does not duplicate rendering logic.

### Implemented annotation behavior

`underNote` and `overNote` now expose independent label and expression offsets, semantic tones, exact fills, optional size inheritance, and layout-affecting versus overlaid notes. Explicit `fill` takes precedence over `tone`; with both unset, custom content styling is preserved.

---

## 22. Final recommendation

Gen 2 already contains most of the required visual vocabulary. It does not need a wholesale redesign. It needs a careful refinement that preserves the successful human workflow of Gen 1:

- retain fast short names;
- provide clear descriptive names;
- make breakability visible through tint;
- preserve the green/blue/red/purple/orange semantic families;
- make pills independent and searchable;
- add `box_section`/`bsec` for the most common missing structure;
- give brace annotations enough direct positional and styling control;
- treat nested boxes as a smaller parallel system;
- add simple linear diagram construction without trying to replace graph packages;
- isolate obsolete signatures in a legacy wrapper;
- keep course-specific extensions in assist files.

The most important principle is that the template is primarily written by a human. Its API should optimize frequent authoring without sacrificing discoverability. Concise aliases and descriptive functions are therefore complementary, not competing, interfaces.
