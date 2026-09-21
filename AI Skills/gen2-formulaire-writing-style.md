---
name: gen2-formulaire-writing-style
description: Write or revise dense, exam-oriented course formularies in the LELEC2348 style while strictly using the current Gen 2 formulaire template API. Use for formula sheets, summaries, worked methods, exam notes, and course-local Typst helpers.
---

# Gen 2 Formulaire Writing Style

Use this skill when writing or revising a formulaire based on `template_formulaire_gen2.typ`. Produce a compact reference that remains understandable and reliable under exam pressure.

## Source hierarchy

Apply these sources in order:

1. **Course sources** determine technical correctness, scope, notation, and exam expectations.
2. `../courses/LELEC2348_Information_Theory_And_Coding/formulaire.typ` determines writing style, density, organization, and presentation.
3. `../templates/template_formulaire_gen2.typ` determines available syntax, helpers, tags, colors, layout, and visual components.

Never copy a stylistic pattern when it conflicts with course content. Never copy old LELEC2348 implementation details when the Gen 2 template provides an equivalent helper.

## Before writing

1. Read the target chapter and its course sources far enough to verify assumptions and notation.
2. Inspect the current Gen 2 template API; do not rely on remembered signatures.
3. Inspect representative LELEC2348 sections, especially worked exercises and exam solutions.
4. Search the target document and any adjacent assist file for existing local helpers.
5. Preserve established notation unless it is inconsistent; resolve conflicts explicitly rather than silently alternating symbols.

## Writing style

Write like the LELEC2348 formulaire:

- Lead with definitions, governing formulas, and usable conclusions.
- Use short, complete explanations—not textbook prose and not cryptic fragments.
- Put assumptions and validity conditions immediately beside the affected formula.
- Define symbols and units near their first important use.
- Keep derivations only when they expose a reusable step, proof idea, or exam method.
- Prefer aligned equations when the relationship between steps matters.
- Use small structural labels such as **Assumption**, **Method**, **Check**, **Special case**, and **Conclusion**.
- Include edge cases, equality conditions, failure conditions, sign or unit checks, and common traps when useful.
- Make examples teach a procedure rather than merely substitute numbers.
- Keep one concept or recognizable question per box; split unrelated material.

A useful default sequence is:

1. core definition or result;
2. assumptions and interpretation;
3. compact derivation or solution procedure;
4. conclusion, check, or warning.

Not every topic needs every step.

## Use the template API

Use either the descriptive API or its fast authoring shortcuts:

| Purpose | Descriptive / shortcut |
|---|---|
| Compact green result, non-breakable | `result_box` / `fbox` |
| Green result, breakable and tinted | `breakable_result_box` / `fbbox` |
| Blue explanation or derivation | `theory_box` / `tbox` |
| Worked method or exercise | `exercise_box` / `exerbox` |
| Example or proof | `example_box` / `xbox`; `proof_box` / `pbox` |
| Exam-focused block | `exam_box` / `ebox` |
| Warning or unfinished work | `warning_box` / `wbox`; `todo_box` / `tdbox` |
| Nested definition/detail | `sub_definition_box` / `sbdefbox` / `subdefbox` |
| Equation or diagram | `equation_box` / `eqbox`; `diagram_box` / `dbox` |
| Internal card section | `box_section` / `bsec` |

A white card body signals non-breakable content; a tinted body signals a breakable card. Preserve this distinction when changing box types.

Use `tag: "exam"` for one pill or `tags: ("exam", "important")` for several. Every pill emits searchable metadata by default. Use `metadata_tags: ("definition",)` for searchable categories that should not display a pill. Tags describe relevance independently from the card kind, so a theorem may carry `exam` and an exercise may carry `extra`.

Use semantic emphasis consistently:

- `def` / `definition`: definition or newly introduced term;
- `imp`: central result to retain;
- `ind`: indicator, condition, or criterion;
- `cat`: category or classification;
- `danger` / `warn`: invalid outcome, trap, or limitation;
- `success`: valid or achieved outcome;
- `info` / `contextual`: explanation or interpretation;
- `strong`: neutral structural emphasis;
- `small`: secondary information.

Emphasize the shortest meaningful phrase. Do not color whole paragraphs or create ad hoc color meanings.

```typst
#fbox("Mutual information", tag: "exam")[
  #def[Definition:]
  $ I(X;Y) = H(X) - H(X|Y) = H(Y) - H(Y|X) $

  #imp[Key bound:] $0 <= I(X;Y) <= min(H(X), H(Y))$.
  Equality $I(X;Y)=0$ holds iff $X$ and $Y$ are independent.
]
```

## Formulas and annotations

Use native Typst math and the document's established notation. Never introduce LaTeX commands.

- Group related steps in one aligned display.
- State what a formula computes and when it applies.
- Keep approximations, domains, units, and equality conditions visible.
- Put a space between a subscripted function-like symbol and its arguments: `$H_b (p)$`, `$P_X (x)$`, and `$D_"KL" (P || Q)`. Never write `$H_b(p)$`; Typst can bind `b(p)` into the subscript and visually merge the notation.
- Use `underNote` and `overNote` for short structural explanations instead of rebuilding `underbrace`/`overbrace` with `place`.
- Use `tone` for semantic color and `fill` for an exact color. In math mode, use `tone: #none`, `fill: #none`, and optionally `size: #none` to preserve custom content styling.
- Adjust `dx`/`dy` for the label and `body_dx`/`body_dy` for the expression. In math mode, inject lengths as code, for example `dx: #(0.3em)`.
- Set `affect_layout: #true` in math mode when the annotation should reserve normal layout space; leave the default for overlay-style placement.

```typst
#exerbox("Data processing inequality")[
  #laass[$U -> X -> Y$, hence $I(U;Y|X)=0$.]
  $
    I(U;X,Y) &= I(U;X) + underNote(I(U;Y|X), "zero") \
             &= I(U;Y) + underNote(I(U;X|Y), "non-negative")
  $
  Therefore #imp[$I(U;Y) <= I(U;X)$]: processing cannot increase information.
]
```

Brace labels must be brief. Put longer interpretation in prose below the equation. Use documented abbreviated labels such as `laass`, `lamet`, `lachk`, `laconc`, and `laans`, and use `bsec` for larger subdivisions inside a card.

Use `collect_cards(tag: ..., kind: ..., compact: ...)` to generate a contiguous list of matching cards. Add `collection_summary` when a full card body is unsafe or too large to duplicate.

## Missing functionality: local assist file

Do not redefine template facilities in the main formulaire, and do not modify the shared template during ordinary course work unless the user explicitly requests it.

If required functionality is absent from Gen 2:

1. Create `<main-file-stem>_assist.typ` beside the main formulaire, for example `formulaire_assist.typ` beside `formulaire.typ`.
2. Put course-specific helpers there.
3. Import it from the main formulaire after importing the shared template.
4. Reuse template primitives and semantic colors where possible.
5. Avoid global page or show rules unless strictly necessary and safely scoped.
6. Keep broadly reusable additions as candidates for later promotion to the shared template; do not duplicate them in the main document.

Never locally recreate `fbox`, `tbox`, `ebox`, box tags, semantic emphasis, brace helpers, card metadata, page layout, headers, footers, chapter breaks, or other existing Gen 2 behavior. Use `flow_diagram` / `flowdiag` for simple linear block diagrams; put branching Fletcher/CeTZ diagrams in the assist file.

## Editing workflow

1. Extract the claims, formulas, assumptions, and expected procedures from course sources.
2. Group them by reusable question, not by slide order.
3. Choose boxes by purpose rather than appearance.
4. Write formula-first content with assumptions and interpretation nearby.
5. Add only useful derivations, checks, edge cases, and exam traps.
6. Replace ad hoc styling and manual annotations with Gen 2 helpers.
7. Check notation, units, conditions, and duplicated formulas across the chapter.
8. Compile and inspect column/page breaks, overflow, non-breakable boxes, brace collisions, and bibliography placement.
9. Report unresolved technical uncertainty instead of inventing content.

## Avoid

- reimplementing template helpers or semantic colors;
- copying LELEC2348's old manual `place`, color, or box constructions;
- formulas without purpose or validity conditions;
- long derivations with no reusable reasoning;
- slide prose copied verbatim;
- one box covering an entire lecture;
- excessive tags, nested boxes, or rainbow emphasis;
- unexplained notation changes or approximations;
- examples that omit assumptions, units, or conclusions;
- vague warnings such as “be careful” without naming the failure.

## Completion check

Before finishing, verify that:

- course sources support every technical claim;
- style and density follow LELEC2348;
- all UI and layout constructs come from the current Gen 2 API or a justified assist file;
- major formulas identify purpose, assumptions, symbols, and useful limits;
- examples expose a repeatable method;
- semantic emphasis and tags retain stable meanings;
- subscripted functions use separated argument notation such as `$H_b (p)$`;
- Typst compiles cleanly and the rendered page remains readable.
