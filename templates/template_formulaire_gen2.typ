// ============================================================================
// GEN 2 FORMULAIRE — COMPLETE PUBLIC API AND USAGE
// ============================================================================
// QUICK START — this single show rule installs page layout, columns, edge text,
// heading behavior, optional front matter, bibliography behavior, and punch marks.
//
// #import "template_formulaire_gen2.typ": *
// #show: formulaire.with(
//   course: "LELEC2700 - Microwaves", // Prefer "CODE - Course name".
//   authors: [Victor Carballes],       // Content; supports several authors.
//   title: none,                       // Optional partial-formulaire title.
//   layout: "horizontal",             // horizontal: 3 columns; vertical: 2.
// )
//
// = First chapter
// #fbox("Compact result", tags: ("exam", "important"))[...]
// #fbbox("Long breakable result")[...]
//
// DOCUMENT OPTIONS
// ---------------------------------------------------------------------------
// #show: formulaire.with(
//   course: "LELEC2700 - Microwaves",
//   authors: [Victor Carballes],
//   institution: "UCLouvain",
//   title: none,
//   layout: "horizontal",             // "horizontal" or "vertical".
//   hole_punch_preview: false,         // Four red guides on both long edges.
//   front_page: false,                 // Edge text makes it optional.
//   details: [],                       // Front-page scope/notes content.
//   show_outline: true,                // Used only when front_page is true.
//   outline_depth: 2,
//   chapter_new_page: true,            // Level-1 headings after the first.
//   bibliography_new_page: true,       // Any #bibliography(...) element.
// )
//
// `front_page: true` shows course, optional title, authors, institution,
// generation, compilation date, optional details, and optional outline. The
// same page can be emitted manually with #intro_page(...), although the wrapper
// is normally simpler. The header and footer always show the compact edge text.
//
// DOCUMENT STRUCTURE
// ---------------------------------------------------------------------------
// = Chapter                       // Native headings work with page-break logic.
// #part[Chapter]                  // Descriptive level-1 helper.
// #topic[Topic]                   // Level 2; starts a new column by default.
// #topic("Topic", new_column: false)
// #subtopic[Detail]               // Level 3.
// #bibliography("references.yml") // Optional forced page via wrapper setting.
//
// MAIN CARDS — DESCRIPTIVE / SHORT
// ---------------------------------------------------------------------------
// result_box            / fbox       Green, non-breakable, white body.
// breakable_result_box  / fbbox      Green, breakable, tinted body.
// theory_box            / tbox       Blue explanation or derivation.
// exercise_box          / exerbox    Blue exercise or worked method.
// example_box           / xbox       Blue example.
// proof_box             / pbox       Purple proof.
// exam_box              / ebox       Red exam/critical card; EXAM by default.
// warning_box           / wbox       Orange warning card; WARN by default.
// todo_box              / tdbox      Solid bright-red, non-breakable TODO.
// smartbox                           Generic kind/custom-palette entry point.
//
// #smartbox("Custom", kind: "proof", breakable: false)[...]
// #smartbox("Own palette", palette: (
//   title: purple.lighten(75%), tint: purple.lighten(95%),
//   border: purple, accent: purple,
// ))[...]
// Palette fields are title, tint, border, accent, plus optional body. `body`
// overrides the normal white/non-breakable or tint/breakable body rule.
// Built-in kinds: result, theory, exercise, example, proof, exam, warning, todo.
//
// NESTED CARDS — DESCRIPTIVE / SHORT
// ---------------------------------------------------------------------------
// sub_box                / sbox       Generic nested card; accepts kind/palette.
// sub_definition_box     / sbdefbox   Light-blue definition.
// sub_reminder_box       / sbrembox   Light-blue reminder.
// sub_theorem_box        / sbthmbox   Purple theorem; PROOF by default.
// sub_example_box        / sbexbox    Blue nested example.
// sub_warning_box        / sbwarnbox  Orange warning; WARN by default.
// subdefbox                           Extra fast alias for sbdefbox.
//
// CARD PARAMETERS AND SEARCHABLE METADATA
// ---------------------------------------------------------------------------
// Main, generic, and nested cards accept these where their signatures expose
// them (fixed equation/diagram cards omit `breakable` and `palette`):
//   breakable: true/false            Tinted when true; white when false.
//   tag: "exam"                      One visible searchable pill.
//   tags: ("exam", "extra")         Several visible searchable pills.
//   metadata_tags: ("definition",)  Searchable tags without visible pills.
//   palette: (...)                   smartbox/sub_box custom palette.
//   collect: true/false              Include/exclude from card collections.
//   collection_summary: none         Compact replacement body for collection.
//
// Pills are metadata by default. Built-ins: exam, warn, important, extra,
// definition, proof, optional. Unknown names use the card accent, or purple when
// `pill` is called directly without an explicit fill.
// #pill("custom")
// #pill("critical", fill: red, searchable: true)
// #tag("definition", visible: false)
//
// #collect_cards(tag: "definition", title: [Definitions])
// #collect_cards(kind: "proof", title: [Proofs])
// #collect(tag: "exam", compact: true) // Short alias; uses summaries if set.
// Collections duplicate matching cards at their call location.
//
// EQUATIONS, DIAGRAMS, AND INTERNAL SECTIONS
// ---------------------------------------------------------------------------
// #eqbox(title: [Capacity], tags: ("important",))[$ C = max I(X;Y) $]
// #dbox(title: [System])[#flowdiag(([Input], [Channel], [Output]))]
// #bsec[Reusable derivation]       // Underlined card section + separator.
// #bsec("No rule", separator: false, tone: "important")
//
// #flowdiag(
//   ([Source], [Encoder], [Channel], [Decoder]),
//   arrows: ([bits], [codeword], [received]),
//   direction: "right",           // Also "down".
//   spacing: 0.35em,
// )
// flow_diagram is the descriptive name. Use a course assist file with
// Fletcher/CeTZ for branching or complex graphs rather than rebuilding it here.
//
// INLINE SEMANTICS
// ---------------------------------------------------------------------------
// Generic:  #semantic(tone: "important")[text] (also accepts fill/weight).
// Academic: #definition / #def, #important / #imp, #indicator / #ind,
//           #category / #cat.
// Outcomes: #danger, #success, #warning / #warn, #information / #info,
//           #contextual.
// Neutral:  #strong[bold], #small[secondary], #math_note[small green note].
// Tones: definition, important, indicator, category, danger, success, info,
// warning, context. Prefer these stable meanings over ad-hoc colors.
//
// STRUCTURED INLINE LABELS — DESCRIPTIVE / ABBREVIATED
// ---------------------------------------------------------------------------
// label_hypothesis     / lahyp   label_assumption     / laass
// label_condition      / lacond  label_given          / lagiv
// label_method         / lamet   label_step           / lastp
// label_check          / lachk   label_detail         / ladet
// label_extra          / laext   label_special_case   / laspc
// label_conclusion     / laconc  label_interpretation / laint
// label_warning        / lawarn  label_answer         / laans
// Example: #laass[The channel is memoryless.]
//
// MATH NOTATION AND ANNOTATIONS
// ---------------------------------------------------------------------------
// Important Typst parsing rule: separate subscripted function-like symbols from
// their argument list: $ H_b (p) $, $ P_X (x) $, $ D_"KL" (P || Q) $. Do not
// write $ H_b(p) $: Typst can consume b(p) as the subscript atom.
//
// Use identifier-safe aliases directly in math mode:
// $ underNote(H(X), "source entropy", tone: "important") $
// $ overNote(C, "capacity", fill: orange, dx: #(0.4em), dy: #(-0.4em)) $
// Descriptive code-mode names are under_note and over_note.
// dx/dy move the label; body_dx/body_dy move the expression. `size: #none`
// preserves custom label sizing; `tone: #none` preserves custom color; explicit
// fill overrides tone. `affect_layout: #true` reserves normal math space.
// Named code values require `#` injection when called from math mode.
//
// SMALL UTILITIES AND EXPOSED CONFIGURATION
// ---------------------------------------------------------------------------
// #estimate(15)                 // Small "est. 15 min" text.
// #hline()                      // LELEC2348-style internal separator.
// #note_lines(count: 4)         // Dotted writing lines.
// FORMULAIRE_GEN, colors, semantic_colors, box_palettes, sub_box_palettes,
// tag_styles, and layout_configs are exposed for assist files and controlled
// customization. Prefer the public helpers before reading or altering them.
//
// LEGACY
// ---------------------------------------------------------------------------
// Obsolete concatenated names and singular-author signatures live only in
// `template_formulaire_gen2_legacy_wrapper.typ`; import it after this template
// when migrating old documents. Keep new formularies on the API above.
// ============================================================================

#let FORMULAIRE_GEN = "Gen 2"

// ============================================================================
// THEME
// ============================================================================

#let colors = (
  ink: rgb("#1f2937"),
  muted: rgb("#6b7280"),
  line: rgb("#d1d5db"),

  red: rgb("#b91c1c"),
  blue: rgb("#1d4ed8"),
  green: rgb("#15803d"),
  purple: rgb("#7e22ce"),
  orange: rgb("#c2410c"),

  result_title: green.lighten(40%).desaturate(60%),
  result_tint: green.lighten(96%),
  result_border: luma(50%),

  theory_title: blue.lighten(40%).desaturate(60%),
  theory_tint: blue.lighten(96%),
  theory_border: luma(50%),

  exercise_title: blue.lighten(40%).desaturate(60%),
  exercise_tint: blue.lighten(93%),
  exercise_border: luma(50%),

  example_title: blue.lighten(40%).desaturate(60%),
  example_tint: blue.lighten(96%),
  example_border: luma(50%),

  proof_title: purple.lighten(40%).desaturate(60%),
  proof_tint: purple.lighten(96%),
  proof_border: luma(50%),

  exam_title: red.lighten(40%).desaturate(60%),
  exam_tint: red.lighten(96%),
  exam_border: luma(50%),

  warning_title: orange.lighten(40%).desaturate(60%),
  warning_tint: orange.lighten(96%),
  warning_border: luma(50%),

  todo_title: red,
  todo_tint: red,
  todo_border: red,

  diagram_title: rgb("#f0f1f4"),

  sub_title: color.aqua.lighten(40%).desaturate(60%),
  sub_tint: color.aqua.lighten(96%),
  sub_border: luma(60%),

  equation_body: rgb("#f2f7ff"),
  diagram_body: rgb("#fcfcfd"),
  punch_fill: rgb("#ef4444"),
  punch_stroke: rgb("#b91c1c"),
)

#let semantic_colors = (
  definition: colors.red,
  important: colors.blue,
  indicator: colors.green,
  category: colors.purple,
  danger: colors.red,
  success: colors.green,
  info: colors.blue,
  warning: colors.orange,
  "context": colors.purple,
)

#let box_palettes = (
  result: (
    title: colors.result_title,
    tint: colors.result_tint,
    border: colors.result_border,
    accent: colors.green,
  ),
  theory: (
    title: colors.theory_title,
    tint: colors.theory_tint,
    border: colors.theory_border,
    accent: colors.blue,
  ),
  exercise: (
    title: colors.exercise_title,
    tint: colors.exercise_tint,
    border: colors.exercise_border,
    accent: colors.blue,
  ),
  example: (
    title: colors.example_title,
    tint: colors.example_tint,
    border: colors.example_border,
    accent: colors.blue,
  ),
  proof: (
    title: colors.proof_title,
    tint: colors.proof_tint,
    border: colors.proof_border,
    accent: colors.purple,
  ),
  exam: (
    title: colors.exam_title,
    tint: colors.exam_tint,
    border: colors.exam_border,
    accent: colors.red,
  ),
  warning: (
    title: colors.warning_title,
    tint: colors.warning_tint,
    border: colors.warning_border,
    accent: colors.orange,
  ),
  todo: (
    title: colors.todo_title,
    tint: colors.todo_tint,
    body: colors.todo_tint,
    border: colors.todo_border,
    accent: colors.red,
  ),
)

#let sub_box_palettes = (
  definition: (
    title: colors.sub_title,
    tint: colors.sub_tint,
    border: colors.sub_border,
    accent: colors.blue,
  ),
  reminder: (
    title: colors.sub_title,
    tint: colors.sub_tint,
    border: colors.sub_border,
    accent: colors.blue,
  ),
  theorem: (
    title: colors.proof_title,
    tint: colors.proof_tint,
    border: colors.proof_border,
    accent: colors.purple,
  ),
  example: (
    title: colors.example_title,
    tint: colors.example_tint,
    border: colors.example_border,
    accent: colors.blue,
  ),
  warning: (
    title: colors.warning_title,
    tint: colors.warning_tint,
    border: colors.warning_border,
    accent: colors.orange,
  ),
  extra: (
    title: colors.warning_title,
    tint: colors.warning_tint,
    border: colors.warning_border,
    accent: colors.orange,
  ),
)

#let tag_styles = (
  exam: (label: "EXAM", fill: colors.exam_title, ink: colors.red),
  warn: (label: "WARN", fill: colors.warning_title, ink: colors.orange),
  important: (label: "IMPORTANT", fill: colors.theory_title, ink: colors.blue),
  extra: (label: "EXTRA", fill: colors.warning_title, ink: colors.orange),
  definition: (label: "DEF", fill: colors.exam_title, ink: colors.red),
  proof: (label: "PROOF", fill: colors.proof_title, ink: colors.purple),
  optional: (label: "OPTIONAL", fill: colors.diagram_title, ink: colors.muted),
)

#let layout_configs = (
  vertical: (
    flipped: false,
    columns: 2,
    margin: 0.55cm,
    gutter: 0.30cm,
    text_size: 9.0pt,
    header_size: 6.8pt,
  ),
  horizontal: (
    flipped: true,
    columns: 3,
    margin: 0.50cm,
    gutter: 0.22cm,
    text_size: 8.5pt,
    header_size: 6.5pt,
  ),
)

// ============================================================================
// PRIVATE CONFIGURATION AND RENDERING PRIMITIVES
// ============================================================================

#let _layout_config(layout) = {
  let cfg = layout_configs.at(layout, default: none)
  assert(cfg != none, message: "layout must be either horizontal or vertical")
  cfg
}

#let _semantic_color(tone) = {
  let fill = semantic_colors.at(tone, default: none)
  assert(fill != none, message: "unknown semantic tone")
  fill
}

#let _resolve_palette(kind, custom: none, nested: false) = {
  if custom != none {
    custom
  } else {
    let palettes = if nested { sub_box_palettes } else { box_palettes }
    let result = palettes.at(kind, default: none)
    assert(result != none, message: "unknown box kind")
    result
  }
}

#let _normalize_tags(tag: none, tags: ()) = {
  let result = if tags == none {
    ()
  } else if type(tags) == str {
    (tags,)
  } else {
    tags
  }
  assert(type(result) == array, message: "tags must be a string or array")
  if tag != none { result.push(tag) }
  result.map(value => {
    assert(type(value) == str, message: "each tag must be a string")
    lower(value)
  })
}

#let _pill_style(name, fallback: colors.purple) = {
  let key = lower(name)
  tag_styles.at(key, default: (
    label: upper(name),
    fill: fallback.lighten(75%).desaturate(20%),
    ink: fallback,
  ))
}

#let _pill_visual(name, fallback: colors.purple, ink: none) = {
  let style = _pill_style(name, fallback: fallback)
  let text_ink = if ink == none { style.ink } else { ink }
  box(
    inset: (x: 3.5pt, y: 1pt),
    radius: 2pt,
    fill: style.fill,
    stroke: 0.3pt + text_ink.transparentize(55%),
  )[
    #text(size: 6.5pt, fill: text_ink, weight: "bold")[#style.label]
  ]
}

#let _render_pills(tags, fallback: colors.purple, emit_metadata: true) = {
  for (index, name) in tags.enumerate() {
    if index > 0 { h(0.25em) }
    if emit_metadata { [#metadata((type: "pill", tag: name)) <formulaire-pill>] }
    _pill_visual(name, fallback: fallback)
  }
}

#let _panel_title(title, tags: (), accent: colors.purple, emit_metadata: true) = box(width: 100%)[
  #text(fill: colors.ink, weight: "bold")[#title]
  #if tags.len() > 0 [
    #h(1fr)
    #_render_pills(tags, fallback: accent, emit_metadata: emit_metadata)
  ]
]

#let _panel(
  title,
  body,
  palette,
  breakable: true,
  tags: (),
  nested: false,
  body_align: left,
  emit_pill_metadata: true,
) = {
  let radius = if nested { 2pt } else { 2pt }
  let forced_body = palette.at("body", default: none)
  let body_fill = if forced_body != none {
    forced_body
  } else if breakable {
    palette.tint
  } else {
    white
  }
  let body_inset = if nested { 4pt } else { 5pt }
  let border_width = if nested { 0.3pt } else { 0.45pt }
  let outer = block(
    width: 100%,
    breakable: breakable,
    radius: radius,
    stroke: border_width + palette.border,
    fill: body_fill,
    inset: 0pt,
  )[
    #block(width: 100%, fill: palette.title, inset: (x: body_inset, y: 3pt))[
      #_panel_title(
        title,
        tags: tags,
        accent: palette.accent,
        emit_metadata: emit_pill_metadata,
      )
    ]
    #block(width: 100%, fill: body_fill, inset: body_inset)[
      #align(body_align)[#body]
    ]
  ]

  if nested {
    [#v(0.25em)#outer#v(0.25em)]
  } else {
    outer
  }
}

#let _card_record(
  title,
  body,
  kind,
  palette,
  breakable,
  tags,
  pills,
  nested,
  collection_summary,
) = (
  type: "formulaire-card",
  title: title,
  body: body,
  kind: kind,
  palette: palette,
  breakable: breakable,
  tags: tags,
  pills: pills,
  nested: nested,
  collection_summary: collection_summary,
)

#let _render_card(record, emit_pill_metadata: true) = _panel(
  record.title,
  record.body,
  record.palette,
  breakable: record.breakable,
  tags: record.pills,
  nested: record.nested,
  emit_pill_metadata: emit_pill_metadata,
)

#let _card(
  title,
  body,
  kind: "theory",
  breakable: true,
  tag: none,
  tags: (),
  metadata_tags: (),
  palette: none,
  nested: false,
  collect: true,
  collection_summary: none,
) = {
  let visible_tags = _normalize_tags(tag: tag, tags: tags)
  let hidden_tags = _normalize_tags(tags: metadata_tags)
  let searchable_tags = visible_tags + hidden_tags
  let selected_palette = _resolve_palette(kind, custom: palette, nested: nested)
  let record = _card_record(
    title,
    body,
    kind,
    selected_palette,
    breakable,
    searchable_tags,
    visible_tags,
    nested,
    collection_summary,
  )

  if collect { [#metadata(record) <formulaire-card>] }
  _render_card(record)
}

#let _brace_annotation(
  annotation,
  dx: 0em,
  dy: 0em,
  size: 7.5pt,
  tone: none,
  fill: none,
  affect_layout: false,
) = {
  let selected_fill = if fill != none {
    fill
  } else if tone != none {
    _semantic_color(tone)
  } else {
    none
  }

  let styled = if size == none and selected_fill == none {
    annotation
  } else if size == none {
    text(fill: selected_fill, annotation)
  } else if selected_fill == none {
    text(size: size, annotation)
  } else {
    text(size: size, fill: selected_fill, annotation)
  }

  if affect_layout {
    move(dx: dx, dy: dy, styled)
  } else {
    place(center, dx: dx, dy: dy, styled)
  }
}

#let _hole_punch_overlay(layout) = {
  let positions = (25.5mm, 105.5mm, 185.5mm, 265.5mm)
  let marker = circle(
    radius: 3mm,
    fill: colors.punch_fill.transparentize(78%),
    stroke: (
      paint: colors.punch_stroke.transparentize(12%),
      thickness: 0.9pt,
      dash: "dotted",
    ),
  )

  if layout == "vertical" {
    for y in positions {
      place(top + left, dx: 9mm, dy: y, marker)
      place(top + right, dx: -9mm, dy: y, marker)
    }
  } else {
    for x in positions {
      place(top + left, dx: x, dy: 9mm, marker)
      place(bottom + left, dx: x, dy: -9mm, marker)
    }
  }
}

#let _edge_text(course, authors, title: none, institution: "UCLouvain") = block(width: 100%)[
  #grid(
    columns: (auto, auto, auto),
    align: (left, center, right),
    column-gutter: 1fr,
    [#institution · Formulaire #FORMULAIRE_GEN · #authors · Compilation #datetime.today().display("[year]-[month]-[day]")],
    [#course#if title != none [ — #title]],
    [Page #context counter(page).display()],
  )
]

// ============================================================================
// PUBLIC INLINE SEMANTICS
// ============================================================================

#let semantic(body, tone: "info", weight: "bold", fill: none) = text(
  fill: if fill == none { _semantic_color(tone) } else { fill },
  weight: weight,
  body,
)

#let definition(body) = semantic(body, tone: "definition")
#let important(body) = semantic(body, tone: "important")
#let indicator(body) = semantic(body, tone: "indicator")
#let category(body) = semantic(body, tone: "category", weight: "semibold")
#let danger(body) = semantic(body, tone: "danger")
#let success(body) = semantic(body, tone: "success")
#let information(body) = semantic(body, tone: "info")
#let warning(body) = semantic(body, tone: "warning")
#let contextual(body) = semantic(body, tone: "context")

#let def = definition
#let imp = important
#let ind = indicator
#let cat = category
#let info = information
#let warn = warning
#let strong(body) = text(weight: "bold", body)
#let small(body) = text(size: 0.82em, fill: colors.muted, body)
#let math_note(body) = text(size: 0.82em, fill: colors.green, body)

// ============================================================================
// PUBLIC LABELS AND SMALL COMPONENTS
// ============================================================================

#let _statement_label(name, body, tone: none) = {
  let prefix = if tone == none {
    text(weight: "bold")[#name:]
  } else {
    semantic(tone: tone)[#name:]
  }
  [#prefix #body]
}

#let label_hypothesis(body) = _statement_label("Hypothesis", body, tone: "indicator")
#let label_assumption(body) = _statement_label("Assumption", body, tone: "indicator")
#let label_condition(body) = _statement_label("Condition", body, tone: "indicator")
#let label_given(body) = _statement_label("Given", body, tone: "info")
#let label_method(body) = _statement_label("Method", body, tone: "info")
#let label_step(body) = _statement_label("Step", body)
#let label_check(body) = _statement_label("Check", body, tone: "success")
#let label_detail(body) = _statement_label("Detail", body, tone: "context")
#let label_extra(body) = _statement_label("Extra", body, tone: "warning")
#let label_special_case(body) = _statement_label("Special case", body, tone: "context")
#let label_conclusion(body) = _statement_label("Conclusion", body, tone: "important")
#let label_interpretation(body) = _statement_label("Interpretation", body, tone: "context")
#let label_warning(body) = _statement_label("Warning", body, tone: "warning")
#let label_answer(body) = _statement_label("Answer", body, tone: "important")

#let lahyp = label_hypothesis
#let laass = label_assumption
#let lacond = label_condition
#let lagiv = label_given
#let lamet = label_method
#let lastp = label_step
#let lachk = label_check
#let ladet = label_detail
#let laext = label_extra
#let laspc = label_special_case
#let laconc = label_conclusion
#let laint = label_interpretation
#let lawarn = label_warning
#let laans = label_answer

#let pill(label, fill: none, ink: none, searchable: true) = {
  let fallback = if fill == none { colors.purple } else { fill }
  if searchable { [#metadata((type: "pill", tag: lower(label))) <formulaire-pill>] }
  if fill == none {
    _pill_visual(label, fallback: fallback, ink: ink)
  } else {
    let text_ink = if ink == none { white } else { ink }
    box(
      inset: (x: 3.5pt, y: 1pt),
      radius: 2pt,
      fill: fill,
      stroke: 0.3pt + text_ink.transparentize(55%),
    )[
      #text(size: 6.5pt, fill: text_ink, weight: "bold")[#upper(label)]
    ]
  }
}

#let tag(name, visible: true, fill: none) = {
  [#metadata((type: "tag", tag: lower(name))) <formulaire-pill>]
  if visible { pill(name, fill: fill, searchable: false) }
}

#let estimate(minutes, label: "est.") = text(size: 0.78em, fill: colors.muted)[#label #minutes min]
#let hline() = line(length: 100%, stroke: 0.2pt + luma(150))

#let box_section(title, separator: true, tone: none) = {
  let fill = if tone == none { colors.ink } else { _semantic_color(tone) }
  block(width: 100%)[
    #if separator [#hline()#v(0.25em)]
    #text(fill: fill, weight: "bold")[#underline[#title]]
  ]
}
#let bsec = box_section

#let note_lines(count: 3) = [
  #for _ in range(count) [
    #line(length: 100%, stroke: (paint: colors.line, thickness: 0.25pt, dash: "dotted"))
    #v(0.35em)
  ]
]

// ============================================================================
// PUBLIC MAIN CARD SYSTEM
// ============================================================================

#let smartbox(
  title,
  body,
  kind: "theory",
  breakable: true,
  tag: none,
  tags: (),
  metadata_tags: (),
  palette: none,
  collect: true,
  collection_summary: none,
) = _card(
  title,
  body,
  kind: kind,
  breakable: breakable,
  tag: tag,
  tags: tags,
  metadata_tags: metadata_tags,
  palette: palette,
  collect: collect,
  collection_summary: collection_summary,
)

#let result_box(title, body, breakable: false, tag: none, tags: (), metadata_tags: (), collect: true, collection_summary: none) = _card(
  title, body, kind: "result", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

#let breakable_result_box(title, body, tag: none, tags: (), metadata_tags: (), collect: true, collection_summary: none) = result_box(
  title, body, breakable: true, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

#let theory_box(title, body, breakable: true, tag: none, tags: (), metadata_tags: (), collect: true, collection_summary: none) = _card(
  title, body, kind: "theory", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

#let exercise_box(title, body, breakable: true, tag: none, tags: (), metadata_tags: ("exercise",), collect: true, collection_summary: none) = _card(
  title, body, kind: "exercise", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

#let example_box(title, body, breakable: true, tag: none, tags: (), metadata_tags: ("example",), collect: true, collection_summary: none) = _card(
  title, body, kind: "example", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

#let proof_box(title, body, breakable: true, tag: none, tags: (), metadata_tags: ("proof",), collect: true, collection_summary: none) = _card(
  title, body, kind: "proof", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

#let exam_box(title, body, breakable: true, tag: none, tags: ("exam",), metadata_tags: (), collect: true, collection_summary: none) = _card(
  title, body, kind: "exam", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

#let warning_box(title, body, breakable: true, tag: none, tags: ("warn",), metadata_tags: (), collect: true, collection_summary: none) = _card(
  title, body, kind: "warning", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

#let todo_box(title, body, breakable: false, tag: none, tags: (), metadata_tags: ("todo",), collect: true, collection_summary: none) = _card(
  title, body, kind: "todo", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

// Fast main-card API.
#let fbox = result_box
#let fbbox = breakable_result_box
#let tbox = theory_box
#let exerbox = exercise_box
#let xbox = example_box
#let pbox = proof_box
#let ebox = exam_box
#let wbox = warning_box
#let tdbox = todo_box

// ============================================================================
// PUBLIC NESTED CARD SYSTEM
// ============================================================================

#let sub_box(
  title,
  body,
  kind: "definition",
  breakable: false,
  tag: none,
  tags: (),
  metadata_tags: (),
  palette: none,
  collect: true,
  collection_summary: none,
) = _card(
  title,
  body,
  kind: kind,
  breakable: breakable,
  tag: tag,
  tags: tags,
  metadata_tags: metadata_tags,
  palette: palette,
  nested: true,
  collect: collect,
  collection_summary: collection_summary,
)

#let sub_definition_box(title, body, breakable: false, tag: none, tags: (), metadata_tags: ("definition",), collect: true, collection_summary: none) = sub_box(
  title, body, kind: "definition", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

#let sub_reminder_box(title, body, breakable: false, tag: none, tags: (), metadata_tags: ("reminder",), collect: true, collection_summary: none) = sub_box(
  title, body, kind: "reminder", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

#let sub_theorem_box(title, body, breakable: false, tag: none, tags: ("proof",), metadata_tags: ("theorem",), collect: true, collection_summary: none) = sub_box(
  title, body, kind: "theorem", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

#let sub_example_box(title, body, breakable: false, tag: none, tags: (), metadata_tags: ("example",), collect: true, collection_summary: none) = sub_box(
  title, body, kind: "example", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

#let sub_warning_box(title, body, breakable: false, tag: none, tags: ("warn",), metadata_tags: (), collect: true, collection_summary: none) = sub_box(
  title, body, kind: "warning", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

#let sbox = sub_box
#let sbdefbox = sub_definition_box
#let sbrembox = sub_reminder_box
#let sbthmbox = sub_theorem_box
#let sbexbox = sub_example_box
#let sbwarnbox = sub_warning_box
#let subdefbox = sub_definition_box

// ============================================================================
// EQUATIONS, DIAGRAMS, AND SIMPLE FLOWS
// ============================================================================

#let equation_box(body, title: none, label: none, tag: none, tags: (), metadata_tags: ("equation",), collect: true, collection_summary: none) = {
  let display_title = if title != none { title } else if label != none { label } else { [Equation] }
  let visible_tags = _normalize_tags(tag: tag, tags: tags)
  let searchable_tags = visible_tags + _normalize_tags(tags: metadata_tags)
  let palette = (
    title: colors.theory_title,
    tint: colors.equation_body,
    border: colors.blue,
    accent: colors.blue,
  )
  let record = _card_record(
    display_title, align(center)[#body], "equation", palette, false,
    searchable_tags, visible_tags, false, collection_summary,
  )
  if collect { [#metadata(record) <formulaire-card>] }
  _render_card(record)
}

#let diagram_box(body, title: none, tag: none, tags: (), metadata_tags: ("diagram",), collect: true, collection_summary: none) = {
  let display_title = if title == none { [Diagram] } else { title }
  let visible_tags = _normalize_tags(tag: tag, tags: tags)
  let searchable_tags = visible_tags + _normalize_tags(tags: metadata_tags)
  let palette = (
    title: colors.diagram_title,
    tint: colors.diagram_body,
    border: colors.line,
    accent: colors.purple,
  )
  let record = _card_record(
    display_title, align(center)[#body], "diagram", palette, false,
    searchable_tags, visible_tags, false, collection_summary,
  )
  if collect { [#metadata(record) <formulaire-card>] }
  _render_card(record)
}

#let eqbox = equation_box
#let dbox = diagram_box

#let flow_diagram(
  nodes,
  arrows: none,
  direction: "right",
  spacing: 0.35em,
  node_fill: colors.diagram_body,
  node_stroke: colors.theory_border,
) = {
  assert(type(nodes) == array and nodes.len() > 0, message: "nodes must be a non-empty array")
  assert(direction == "right" or direction == "down", message: "direction must be right or down")
  let labels = if arrows == none { () } else { arrows }
  assert(type(labels) == array, message: "arrows must be an array")
  assert(labels.len() == 0 or labels.len() == nodes.len() - 1, message: "arrows must contain one label between each node")

  let items = ()
  for (index, node) in nodes.enumerate() {
    items.push(box(
      inset: (x: 4pt, y: 2.5pt),
      radius: 2pt,
      fill: node_fill,
      stroke: 0.35pt + node_stroke,
    )[#align(center)[#node]])

    if index < nodes.len() - 1 {
      let label = if labels.len() == 0 { none } else { labels.at(index) }
      let arrow = if direction == "right" { sym.arrow.r.long } else { sym.arrow.b }
      items.push(align(center, stack(
        dir: ttb,
        spacing: 0.05em,
        if label == none { [] } else { text(size: 0.72em, fill: colors.muted, label) },
        arrow,
      )))
    }
  }

  align(center, stack(
    dir: if direction == "right" { ltr } else { ttb },
    spacing: spacing,
    ..items,
  ))
}
#let flowdiag = flow_diagram

// ============================================================================
// MATH ANNOTATIONS
// ============================================================================

#let under_note(
  expression,
  annotation,
  dx: 0em,
  dy: 0em,
  body_dx: 0em,
  body_dy: 0em,
  size: 7.5pt,
  tone: none,
  fill: none,
  affect_layout: false,
) = math.underbrace(
  move(dx: body_dx, dy: body_dy, expression),
  _brace_annotation(
    annotation,
    dx: dx,
    dy: dy,
    size: size,
    tone: tone,
    fill: fill,
    affect_layout: affect_layout,
  ),
)

#let over_note(
  expression,
  annotation,
  dx: 0em,
  dy: -0.6em,
  body_dx: 0em,
  body_dy: 0em,
  size: 7.5pt,
  tone: none,
  fill: none,
  affect_layout: false,
) = math.overbrace(
  move(dx: body_dx, dy: body_dy, expression),
  _brace_annotation(
    annotation,
    dx: dx,
    dy: dy,
    size: size,
    tone: tone,
    fill: fill,
    affect_layout: affect_layout,
  ),
)

// Identifier-safe aliases for use in math mode.
#let underNote = under_note
#let overNote = over_note

// ============================================================================
// CARD COLLECTIONS
// ============================================================================

#let collect_cards(
  tag: none,
  kind: none,
  title: none,
  compact: false,
) = context {
  let normalized_tag = if tag == none { none } else { lower(tag) }
  let matches = query(<formulaire-card>).filter(element => {
    let record = element.value
    let tag_match = normalized_tag == none or record.tags.contains(normalized_tag)
    let kind_match = kind == none or record.kind == kind
    tag_match and kind_match
  })

  [
    #if title != none [
      #text(size: 1.15em, weight: "bold")[#title]
      #v(0.4em)
    ]
    #for element in matches {
      let record = element.value
      let collected_body = if compact and record.collection_summary != none {
        record.collection_summary
      } else {
        record.body
      }
      let collected_record = record
      collected_record.body = collected_body
      _render_card(collected_record, emit_pill_metadata: false)
    }
  ]
}
#let collect = collect_cards

// ============================================================================
// DOCUMENT STRUCTURE
// ============================================================================

#let part(title) = heading(level: 1)[#title]

#let topic(title, new_column: true) = [
  #if new_column [#colbreak(weak: true)]
  #heading(level: 2)[#title]
]

#let subtopic(title) = heading(level: 3)[#title]

#let intro_page(
  title: none,
  course: "Course",
  authors: [Your Name],
  institution: "UCLouvain",
  details: [],
  show_outline: true,
  outline_depth: 2,
) = [
  #pagebreak(weak: true)
  #align(center)[
    #v(1.2em)
    #text(size: 18pt, weight: "bold")[#course]
    #if title != none [
      #v(0.35em)
      #text(size: 11pt, fill: colors.blue, weight: "semibold")[#title]
    ]
    #v(0.8em)
    #text(size: 8pt, fill: colors.muted)[#authors — #institution]
    #v(0.25em)
    #text(size: 7pt, fill: colors.muted)[
      #FORMULAIRE_GEN — Compiled #datetime.today().display("[year]-[month]-[day]")
    ]
  ]

  #if details != [] [
    #v(0.8em)
    #result_box("About this formulaire")[#details]
  ]

  #if show_outline [
    #v(0.8em)
    #result_box("Table of contents")[
      #outline(title: none, depth: outline_depth)
    ]
  ]

  #pagebreak()
]

#let formulaire(
  title: none,
  course: "Course",
  authors: [Your Name],
  institution: "UCLouvain",
  layout: "horizontal",
  hole_punch_preview: false,
  front_page: false,
  details: [],
  show_outline: true,
  outline_depth: 2,
  chapter_new_page: true,
  bibliography_new_page: true,
  body,
) = {
  let cfg = _layout_config(layout)
  let page_edge = _edge_text(
    course,
    authors,
    title: title,
    institution: institution,
  )

  set page(
    paper: "a4",
    flipped: cfg.flipped,
    margin: cfg.margin,
    columns: cfg.columns,
    foreground: if hole_punch_preview { _hole_punch_overlay(layout) },
    header: context [
      #set text(size: cfg.header_size, fill: colors.muted)
      #page_edge
    ],
    footer: context [
      #set text(size: cfg.header_size, fill: colors.muted)
      #page_edge
    ],
  )
  set columns(gutter: cfg.gutter)
  set text(size: cfg.text_size, fill: colors.ink)
  set par(justify: false, leading: 0.50em)
  set block(spacing: 0.45em)
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => context {
    let chapter = counter(heading).at(it.location()).first()
    if chapter_new_page and it.numbering != none and chapter > 1 {
      pagebreak(weak: true)
    }
    it
  }

  show bibliography: it => {
    if bibliography_new_page { pagebreak(weak: true) }
    it
  }

  if front_page {
    intro_page(
      title: title,
      course: course,
      authors: authors,
      institution: institution,
      details: details,
      show_outline: show_outline,
      outline_depth: outline_depth,
    )
  }

  body
}
