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

/// Identifies the public formulaire API generation shown in page furniture.
/// Use this value when an assist file needs to display or check the template generation.
/// ```typst
/// Formulaire generation: #FORMULAIRE_GEN
/// ```
#let FORMULAIRE_GEN = "Gen 2"

// ============================================================================
// THEME
// ============================================================================

/// Provides the complete color theme used by the template.
/// Base fields include `ink`, `muted`, `line`, and the named accent colors. Card fields
/// follow `<kind>_title`, `<kind>_tint`, and `<kind>_border`; the remaining fields style
/// equations, diagrams, nested cards, and punch-preview marks.
/// Read fields directly when building course-specific components; prefer semantic helpers
/// when the color represents meaning rather than decoration.
/// ```typst
/// #text(fill: colors.blue)[A themed course note]
/// ```
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

/// Maps stable semantic tone names to theme colors.
/// Fields are `definition`, `important`, `indicator`, `category`, `danger`, `success`,
/// `info`, `warning`, and `context`. These keys are accepted by `semantic` and other
/// APIs with a `tone` parameter.
/// ```typst
/// #text(fill: semantic_colors.important)[Key result]
/// ```
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

/// Defines the palettes for top-level card kinds.
/// Each kind has `title`, `tint`, `border`, and `accent` paints. An optional `body` paint
/// overrides the usual white non-breakable or tinted breakable body; the `todo` palette
/// uses this override. Built-in fields are `result`, `theory`, `exercise`, `example`,
/// `proof`, `exam`, `warning`, and `todo`.
/// ```typst
/// #rect(fill: box_palettes.result.tint, stroke: box_palettes.result.border)[Result]
/// ```
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

/// Defines the palettes available to nested `sub_box` cards.
/// Every palette contains `title`, `tint`, `border`, and `accent` paints. Fields are
/// `definition`, `reminder`, `theorem`, `example`, `warning`, and `extra`; custom nested
/// components can reuse any field as a complete palette.
/// ```typst
/// #sub_box("Aside", palette: sub_box_palettes.extra)[Optional detail]
/// ```
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

/// Maps built-in pill names to their visual styles.
/// Each field contains a displayed `label`, background `fill`, and text `ink`. Unknown
/// pill names do not use this map and instead derive a style from the caller's fallback
/// accent. Built-ins include `exam`, `warn`, `important`, `extra`, `definition`, `proof`,
/// and `optional`.
/// ```typst
/// #text(fill: tag_styles.exam.ink)[#tag_styles.exam.label]
/// ```
#let tag_styles = (
  exam: (label: "EXAM", fill: colors.exam_title, ink: colors.red),
  warn: (label: "WARN", fill: colors.warning_title, ink: colors.orange),
  important: (label: "IMPORTANT", fill: colors.theory_title, ink: colors.blue),
  extra: (label: "EXTRA", fill: colors.warning_title, ink: colors.orange),
  definition: (label: "DEF", fill: colors.exam_title, ink: colors.red),
  proof: (label: "PROOF", fill: colors.proof_title, ink: colors.purple),
  optional: (label: "OPTIONAL", fill: colors.diagram_title, ink: colors.muted),
)

/// Stores the supported page-layout presets used by `formulaire`.
/// The `vertical` and `horizontal` fields each define `flipped`, `columns`, `margin`,
/// `gutter`, `text_size`, and `header_size`. `formulaire` validates the selected layout
/// and applies the corresponding record to A4 pages, columns, and edge text.
/// ```typst
/// The horizontal preset uses #layout_configs.horizontal.columns columns.
/// ```
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

/// Styles inline content with a stable semantic meaning.
/// - `body`: Content to style.
/// - `tone`: Key from `semantic_colors`; defaults to `"info"`.
/// - `weight`: Typst text weight; defaults to `"bold"`.
/// - `fill`: Explicit paint override; `none` resolves the selected tone.
/// ```typst
/// #semantic(tone: "important")[Remember this identity.]
/// ```
#let semantic(body, tone: "info", weight: "bold", fill: none) = text(
  fill: if fill == none { _semantic_color(tone) } else { fill },
  weight: weight,
  body,
)

/// Highlights content with the definition semantic tone.
/// - `body`: Inline content to emphasize as a definition.
/// ```typst
/// #definition[Channel capacity] is the maximum mutual information.
/// ```
#let definition(body) = semantic(body, tone: "definition")
/// Highlights content with the important semantic tone.
/// - `body`: Inline content that deserves primary emphasis.
/// ```typst
/// #important[Normalize before comparing the spectra.]
/// ```
#let important(body) = semantic(body, tone: "important")
/// Highlights content with the indicator semantic tone.
/// - `body`: Inline content that signals a condition or marker.
/// ```typst
/// #indicator[Memoryless channel]
/// ```
#let indicator(body) = semantic(body, tone: "indicator")
/// Marks content as a category using semibold semantic styling.
/// - `body`: Inline category name or classification.
/// ```typst
/// #category[Continuous-time model]
/// ```
#let category(body) = semantic(body, tone: "category", weight: "semibold")
/// Emphasizes dangerous, invalid, or critical content.
/// - `body`: Inline warning content.
/// ```typst
/// #danger[Do not divide by a zero probability.]
/// ```
#let danger(body) = semantic(body, tone: "danger")
/// Emphasizes a successful check or valid outcome.
/// - `body`: Inline success content.
/// ```typst
/// #success[The units are consistent.]
/// ```
#let success(body) = semantic(body, tone: "success")
/// Highlights informational content with the info tone.
/// - `body`: Inline explanatory content.
/// ```typst
/// #information[Assume base-2 logarithms.]
/// ```
#let information(body) = semantic(body, tone: "info")
/// Highlights cautionary content with the warning tone.
/// - `body`: Inline content requiring attention.
/// ```typst
/// #warning[Check the sign convention.]
/// ```
#let warning(body) = semantic(body, tone: "warning")
/// Styles supporting context with the contextual semantic tone.
/// - `body`: Inline contextual or interpretive content.
/// ```typst
/// #contextual[For a stationary source only.]
/// ```
#let contextual(body) = semantic(body, tone: "context")

#let def = definition
#let imp = important
#let ind = indicator
#let cat = category
#let info = information
#let warn = warning
/// Applies neutral bold emphasis without a semantic color.
/// - `body`: Inline content to embolden.
/// ```typst
/// #strong[Final answer]
/// ```
#let strong(body) = text(weight: "bold", body)
/// Renders secondary content at `0.82em` in the muted theme color.
/// - `body`: Inline supporting content.
/// ```typst
/// #small[Valid for the linear regime.]
/// ```
#let small(body) = text(size: 0.82em, fill: colors.muted, body)
/// Renders a compact green note suited to nearby mathematical content.
/// - `body`: Note content; it is styled at `0.82em`.
/// ```typst
/// $ C = B log(1 + "SNR") $ #math_note[bits per second]
/// ```
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

/// Prefixes a statement with a green “Hypothesis” label.
/// - `body`: Hypothesis content placed after the label.
/// ```typst
/// #label_hypothesis[The source is stationary.]
/// ```
#let label_hypothesis(body) = _statement_label("Hypothesis", body, tone: "indicator")
/// Prefixes a statement with a green “Assumption” label.
/// - `body`: Assumption content placed after the label.
/// ```typst
/// #label_assumption[The channel is memoryless.]
/// ```
#let label_assumption(body) = _statement_label("Assumption", body, tone: "indicator")
/// Prefixes a statement with a green “Condition” label.
/// - `body`: Condition content placed after the label.
/// ```typst
/// #label_condition[$p > 0$ is required.]
/// ```
#let label_condition(body) = _statement_label("Condition", body, tone: "indicator")
/// Prefixes known data with a blue “Given” label.
/// - `body`: Given information placed after the label.
/// ```typst
/// #label_given[$f_s = 8 " kHz"$.]
/// ```
#let label_given(body) = _statement_label("Given", body, tone: "info")
/// Prefixes an approach with a blue “Method” label.
/// - `body`: Method description placed after the label.
/// ```typst
/// #label_method[Apply Parseval's identity.]
/// ```
#let label_method(body) = _statement_label("Method", body, tone: "info")
/// Prefixes procedural content with a neutral “Step” label.
/// - `body`: Step content placed after the label.
/// ```typst
/// #label_step[Normalize the probability mass function.]
/// ```
#let label_step(body) = _statement_label("Step", body)
/// Prefixes verification content with a green “Check” label.
/// - `body`: Check or validation placed after the label.
/// ```typst
/// #label_check[The probabilities sum to one.]
/// ```
#let label_check(body) = _statement_label("Check", body, tone: "success")
/// Prefixes supporting information with a contextual “Detail” label.
/// - `body`: Detail content placed after the label.
/// ```typst
/// #label_detail[The logarithm uses base 2.]
/// ```
#let label_detail(body) = _statement_label("Detail", body, tone: "context")
/// Prefixes optional supplementary content with an orange “Extra” label.
/// - `body`: Extra content placed after the label.
/// ```typst
/// #label_extra[Derive the continuous-limit form.]
/// ```
#let label_extra(body) = _statement_label("Extra", body, tone: "warning")
/// Prefixes a restricted result with a contextual “Special case” label.
/// - `body`: Special-case content placed after the label.
/// ```typst
/// #label_special_case[For equiprobable symbols, $H(X) = log M$.]
/// ```
#let label_special_case(body) = _statement_label("Special case", body, tone: "context")
/// Prefixes a result with a blue “Conclusion” label.
/// - `body`: Concluding content placed after the label.
/// ```typst
/// #label_conclusion[The estimator is unbiased.]
/// ```
#let label_conclusion(body) = _statement_label("Conclusion", body, tone: "important")
/// Prefixes explanatory meaning with a contextual “Interpretation” label.
/// - `body`: Interpretation placed after the label.
/// ```typst
/// #label_interpretation[Entropy measures average uncertainty.]
/// ```
#let label_interpretation(body) = _statement_label("Interpretation", body, tone: "context")
/// Prefixes cautionary content with an orange “Warning” label.
/// - `body`: Warning content placed after the label.
/// ```typst
/// #label_warning[This approximation fails near cutoff.]
/// ```
#let label_warning(body) = _statement_label("Warning", body, tone: "warning")
/// Prefixes a final response with a blue “Answer” label.
/// - `body`: Answer content placed after the label.
/// ```typst
/// #label_answer[$C = 1 " bit/use"$.]
/// ```
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

/// Renders a compact uppercase metadata pill.
/// - `label`: Pill name; built-in names use `tag_styles`.
/// - `fill`: Custom background paint. With `none`, the built-in or fallback style is used.
/// - `ink`: Optional text paint override; custom fills default to white text.
/// - `searchable`: Emits searchable pill metadata when `true` (the default).
/// Unknown names derive a purple fallback style unless `fill` is supplied.
/// ```typst
/// #pill("critical", fill: red, searchable: true)
/// ```
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

/// Attaches searchable metadata and optionally displays a matching pill.
/// - `name`: Case-insensitive tag stored in lowercase.
/// - `visible`: Shows the pill when `true`; hidden tags remain searchable.
/// - `fill`: Optional custom pill background.
/// ```typst
/// #tag("definition", visible: false)
/// ```
#let tag(name, visible: true, fill: none) = {
  [#metadata((type: "tag", tag: lower(name))) <formulaire-pill>]
  if visible { pill(name, fill: fill, searchable: false) }
}

/// Displays a compact muted duration estimate in minutes.
/// - `minutes`: Number or content shown before `min`.
/// - `label`: Prefix text; defaults to `"est."`.
/// ```typst
/// #estimate(15)
/// ```
#let estimate(minutes, label: "est.") = text(size: 0.78em, fill: colors.muted)[#label #minutes min]
/// Draws a thin full-width neutral separator line.
/// It takes no parameters and follows the compact formulaire visual style.
/// ```typst
/// #hline()
/// ```
#let hline() = line(length: 100%, stroke: 0.2pt + luma(150))

/// Creates an underlined subsection heading inside a card.
/// - `title`: Heading content.
/// - `separator`: Draws a horizontal rule above the heading; defaults to `true`.
/// - `tone`: Optional semantic color name; `none` uses the standard ink color.
/// ```typst
/// #box_section("Boundary cases", separator: false, tone: "important")
/// ```
#let box_section(title, separator: true, tone: none) = {
  let fill = if tone == none { colors.ink } else { _semantic_color(tone) }
  block(width: 100%)[
    #if separator [#hline()#v(0.25em)]
    #text(fill: fill, weight: "bold")[#underline[#title]]
  ]
}
#let bsec = box_section

/// Produces dotted writing lines for handwritten additions.
/// - `count`: Number of lines; defaults to `3` and must be suitable for `range`.
/// Each line spans the available width and includes compact vertical spacing.
/// ```typst
/// #note_lines(count: 4)
/// ```
#let note_lines(count: 3) = [
  #for _ in range(count) [
    #line(length: 100%, stroke: (paint: colors.line, thickness: 0.25pt, dash: "dotted"))
    #v(0.35em)
  ]
]

// ============================================================================
// PUBLIC MAIN CARD SYSTEM
// ============================================================================

/// Builds a top-level card from a built-in kind or custom palette.
/// - `title`, `body`: Card heading and body content.
/// - `kind`: Palette key in `box_palettes`; defaults to `"theory"`.
/// - `breakable`: Allows page/column breaks and uses the tinted body when `true`.
/// - `tag`: Optional single visible pill; `tags` supplies additional visible pills.
/// - `metadata_tags`: Searchable tags that do not render as pills.
/// - `palette`: Optional record with `title`, `tint`, `border`, `accent`, and optional
///   `body`; when set, it overrides the palette selected by `kind`.
/// - `collect`: Emits collection metadata by default. `collection_summary` can replace
///   the body when a matching `collect_cards` call uses `compact: true`.
/// ```typst
/// #smartbox("Key idea", kind: "proof", tags: ("important",))[Justify the bound.]
/// ```
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

/// Creates a green result card with a white, non-breakable body by default.
/// - `title`, `body`: Result heading and content.
/// - `breakable`: Enables splitting and switches to the tinted body when `true`.
/// - `tag` / `tags`: One or several visible searchable pills.
/// - `metadata_tags`: Additional hidden searchable tags.
/// - `collect`: Includes the card in collections by default.
/// - `collection_summary`: Optional body used by compact collections.
/// ```typst
/// #result_box("Capacity", tags: ("important",))[$ C = max_(p(x)) I(X;Y) $]
/// ```
#let result_box(title, body, breakable: false, tag: none, tags: (), metadata_tags: (), collect: true, collection_summary: none) = _card(
  title, body, kind: "result", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

/// Creates a green result card that may split across pages or columns.
/// Its body uses the result tint rather than the non-breakable white default.
/// - `title`, `body`: Result heading and content.
/// - `tag` / `tags`: Visible searchable pills; `metadata_tags` adds hidden tags.
/// - `collect`: Includes the card in collections; defaults to `true`.
/// - `collection_summary`: Optional replacement body for compact collections.
/// ```typst
/// #breakable_result_box("Long derivation", metadata_tags: ("derivation",))[
///   Derivation steps may continue in the next column.
/// ]
/// ```
#let breakable_result_box(title, body, tag: none, tags: (), metadata_tags: (), collect: true, collection_summary: none) = result_box(
  title, body, breakable: true, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

/// Creates a blue theory or derivation card.
/// - `title`, `body`: Card heading and explanatory content.
/// - `breakable`: Defaults to `true`, allowing splits and using a tinted body.
/// - `tag` / `tags`: Visible searchable pills; `metadata_tags` adds hidden tags.
/// - `collect`: Emits collection metadata by default.
/// - `collection_summary`: Optional compact-collection replacement for `body`.
/// ```typst
/// #theory_box("Sampling theorem", tag: "important")[State the bandwidth condition.]
/// ```
#let theory_box(title, body, breakable: true, tag: none, tags: (), metadata_tags: (), collect: true, collection_summary: none) = _card(
  title, body, kind: "theory", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

/// Creates a blue exercise or worked-method card.
/// - `title`, `body`: Exercise heading and content.
/// - `breakable`: Defaults to `true`, allowing splits and using a tinted body.
/// - `tag` / `tags`: Visible searchable pills.
/// - `metadata_tags`: Hidden tags; defaults to `("exercise",)`.
/// - `collect`: Includes the card in collections by default.
/// - `collection_summary`: Optional body used by compact collections.
/// ```typst
/// #exercise_box("Matched filter", tags: ("exam",))[Determine the impulse response.]
/// ```
#let exercise_box(title, body, breakable: true, tag: none, tags: (), metadata_tags: ("exercise",), collect: true, collection_summary: none) = _card(
  title, body, kind: "exercise", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

/// Creates a blue example card.
/// - `title`, `body`: Example heading and worked content.
/// - `breakable`: Defaults to `true`, allowing splits and using a tinted body.
/// - `tag` / `tags`: Visible searchable pills.
/// - `metadata_tags`: Hidden tags; defaults to `("example",)`.
/// - `collect`: Includes the card in collections by default.
/// - `collection_summary`: Optional body used by compact collections.
/// ```typst
/// #example_box("Binary source")[For $p = 1/2$, $H_b (p) = 1$.]
/// ```
#let example_box(title, body, breakable: true, tag: none, tags: (), metadata_tags: ("example",), collect: true, collection_summary: none) = _card(
  title, body, kind: "example", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

/// Creates a purple proof card.
/// - `title`, `body`: Proof heading and argument.
/// - `breakable`: Defaults to `true`, allowing long proofs to split.
/// - `tag` / `tags`: Visible searchable pills.
/// - `metadata_tags`: Hidden tags; defaults to `("proof",)`.
/// - `collect`: Includes the proof in collections by default.
/// - `collection_summary`: Optional concise proof body for compact collections.
/// ```typst
/// #proof_box("Converse", collection_summary: [Follows from data processing.])[
///   Apply the data-processing inequality to the Markov chain.
/// ]
/// ```
#let proof_box(title, body, breakable: true, tag: none, tags: (), metadata_tags: ("proof",), collect: true, collection_summary: none) = _card(
  title, body, kind: "proof", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

/// Creates a red exam or critical card with a visible `EXAM` pill by default.
/// - `title`, `body`: Card heading and exam-relevant content.
/// - `breakable`: Defaults to `true`, allowing splits and using a tinted body.
/// - `tag` / `tags`: Visible searchable pills; `tags` defaults to `("exam",)`.
/// - `metadata_tags`: Additional hidden searchable tags.
/// - `collect`: Includes the card in collections by default.
/// - `collection_summary`: Optional body used by compact collections.
/// ```typst
/// #exam_box("Common question")[Derive the matched-filter signal-to-noise ratio.]
/// ```
#let exam_box(title, body, breakable: true, tag: none, tags: ("exam",), metadata_tags: (), collect: true, collection_summary: none) = _card(
  title, body, kind: "exam", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

/// Creates an orange warning card with a visible `WARN` pill by default.
/// - `title`, `body`: Warning heading and cautionary content.
/// - `breakable`: Defaults to `true`, allowing splits and using a tinted body.
/// - `tag` / `tags`: Visible searchable pills; `tags` defaults to `("warn",)`.
/// - `metadata_tags`: Additional hidden searchable tags.
/// - `collect`: Includes the card in collections by default.
/// - `collection_summary`: Optional body used by compact collections.
/// ```typst
/// #warning_box("Convention")[Confirm the Fourier-transform sign before use.]
/// ```
#let warning_box(title, body, breakable: true, tag: none, tags: ("warn",), metadata_tags: (), collect: true, collection_summary: none) = _card(
  title, body, kind: "warning", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

/// Creates a solid red TODO card that is non-breakable by default.
/// - `title`, `body`: Task heading and unfinished content.
/// - `breakable`: Defaults to `false`; the palette keeps the body red either way.
/// - `tag` / `tags`: Optional visible searchable pills.
/// - `metadata_tags`: Hidden tags; defaults to `("todo",)`.
/// - `collect`: Includes the card in collections by default.
/// - `collection_summary`: Optional body used by compact collections.
/// ```typst
/// #todo_box("Complete proof", collect: false)[Check the equality condition.]
/// ```
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

/// Builds a compact nested card from a built-in kind or custom palette.
/// - `title`, `body`: Nested-card heading and body content.
/// - `kind`: Key in `sub_box_palettes`; defaults to `"definition"`.
/// - `breakable`: Defaults to `false`; breakable cards use the palette tint.
/// - `tag` / `tags`: Visible searchable pills; `metadata_tags` adds hidden tags.
/// - `palette`: Optional record with `title`, `tint`, `border`, `accent`, and optional
///   `body`, overriding the palette selected by `kind`.
/// - `collect`: Emits collection metadata by default. `collection_summary` supplies an
///   optional replacement body when a collection is rendered compactly.
/// ```typst
/// #sub_box("Local lemma", kind: "theorem", tags: ("proof",))[State the lemma.]
/// ```
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

/// Creates a light-blue nested definition card.
/// - `title`, `body`: Definition heading and content.
/// - `breakable`: Defaults to `false`; set `true` for a tinted splittable body.
/// - `tag` / `tags`: Visible pills; `metadata_tags` defaults to `("definition",)`.
/// - `collect`: Includes the card in collections by default.
/// - `collection_summary`: Optional replacement body for compact collections.
/// ```typst
/// #sub_definition_box("Entropy")[Average uncertainty of a random variable.]
/// ```
#let sub_definition_box(title, body, breakable: false, tag: none, tags: (), metadata_tags: ("definition",), collect: true, collection_summary: none) = sub_box(
  title, body, kind: "definition", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

/// Creates a light-blue nested reminder card.
/// - `title`, `body`: Reminder heading and content.
/// - `breakable`: Defaults to `false`; set `true` for a tinted splittable body.
/// - `tag` / `tags`: Visible pills; `metadata_tags` defaults to `("reminder",)`.
/// - `collect`: Includes the card in collections by default.
/// - `collection_summary`: Optional replacement body for compact collections.
/// ```typst
/// #sub_reminder_box("Units")[Convert decibels before using a linear formula.]
/// ```
#let sub_reminder_box(title, body, breakable: false, tag: none, tags: (), metadata_tags: ("reminder",), collect: true, collection_summary: none) = sub_box(
  title, body, kind: "reminder", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

/// Creates a purple nested theorem card with a visible `PROOF` pill.
/// - `title`, `body`: Theorem heading and statement or proof content.
/// - `breakable`: Defaults to `false`; set `true` to permit splitting.
/// - `tag` / `tags`: Visible pills; `tags` defaults to `("proof",)`.
/// - `metadata_tags`: Hidden tags; defaults to `("theorem",)`.
/// - `collect`: Includes the card in collections by default.
/// - `collection_summary`: Optional replacement body for compact collections.
/// ```typst
/// #sub_theorem_box("Source coding")[The expected length is bounded by entropy.]
/// ```
#let sub_theorem_box(title, body, breakable: false, tag: none, tags: ("proof",), metadata_tags: ("theorem",), collect: true, collection_summary: none) = sub_box(
  title, body, kind: "theorem", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

/// Creates a blue nested example card.
/// - `title`, `body`: Example heading and worked content.
/// - `breakable`: Defaults to `false`; set `true` to permit splitting.
/// - `tag` / `tags`: Visible pills; `metadata_tags` defaults to `("example",)`.
/// - `collect`: Includes the card in collections by default.
/// - `collection_summary`: Optional replacement body for compact collections.
/// ```typst
/// #sub_example_box("Fair bit")[$H_b (1/2) = 1$.]
/// ```
#let sub_example_box(title, body, breakable: false, tag: none, tags: (), metadata_tags: ("example",), collect: true, collection_summary: none) = sub_box(
  title, body, kind: "example", breakable: breakable, tag: tag, tags: tags,
  metadata_tags: metadata_tags, collect: collect, collection_summary: collection_summary,
)

/// Creates an orange nested warning card with a visible `WARN` pill.
/// - `title`, `body`: Warning heading and cautionary content.
/// - `breakable`: Defaults to `false`; set `true` to permit splitting.
/// - `tag` / `tags`: Visible pills; `tags` defaults to `("warn",)`.
/// - `metadata_tags`: Additional hidden searchable tags.
/// - `collect`: Includes the card in collections by default.
/// - `collection_summary`: Optional replacement body for compact collections.
/// ```typst
/// #sub_warning_box("Domain")[The logarithm requires a positive argument.]
/// ```
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

/// Places a centered equation in a fixed, non-breakable blue card.
/// - `body`: Equation or mathematical content.
/// - `title`: Optional heading; takes precedence over `label`.
/// - `label`: Fallback heading when `title` is `none`; otherwise the heading is “Equation”.
///   This parameter is display content, not a Typst reference label.
/// - `tag` / `tags`: One or several visible searchable pills.
/// - `metadata_tags`: Hidden tags; defaults to `("equation",)`.
/// - `collect`: Emits collection metadata by default; `collection_summary` can replace
///   the equation body in compact collections.
/// ```typst
/// #equation_box(title: [Capacity], tags: ("important",))[$ C = max_(p(x)) I(X;Y) $]
/// ```
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

/// Places centered diagram content in a fixed, non-breakable neutral card.
/// - `body`: Diagram, image, or flow content.
/// - `title`: Optional heading; defaults to “Diagram”.
/// - `tag` / `tags`: One or several visible searchable pills.
/// - `metadata_tags`: Hidden tags; defaults to `("diagram",)`.
/// - `collect`: Emits collection metadata by default; `collection_summary` can replace
///   the diagram body in compact collections.
/// ```typst
/// #diagram_box(title: [Link])[#flow_diagram(([Source], [Channel], [Sink]))]
/// ```
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

/// Builds a compact linear flow from boxed nodes and optional arrow labels.
/// - `nodes`: Non-empty array of content nodes.
/// - `arrows`: `none`, an empty array, or one label per gap between nodes.
/// - `direction`: `"right"` (default) or `"down"`.
/// - `spacing`: Gap between flow items; defaults to `0.35em`.
/// - `node_fill`: Node background paint.
/// - `node_stroke`: Node-border paint.
/// Assertions reject empty nodes, unsupported directions, and mismatched arrow counts.
/// Use a dedicated diagram package for branching graphs; this helper is intentionally linear.
/// ```typst
/// #flow_diagram(
///   ([Source], [Encoder], [Channel]),
///   arrows: ([bits], [codeword]),
///   direction: "right",
/// )
/// ```
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

/// Draws an underbrace with a movable annotation.
/// - `expression`: Mathematical content under the brace.
/// - `annotation`: Label content below the brace.
/// - `dx`, `dy`: Move only the annotation; both default to `0em`.
/// - `body_dx`, `body_dy`: Move the braced expression independently.
/// - `size`: Annotation text size; `none` preserves custom sizing.
/// - `tone`: Optional key in `semantic_colors`; `none` preserves custom color.
/// - `fill`: Explicit annotation paint that takes precedence over `tone`.
/// - `affect_layout`: When `false` (default), places the label without reserving its
///   normal math space; `true` uses a layout-affecting move.
/// In math-mode calls, inject named code values such as `#none` and lengths with `#`.
/// ```typst
/// #under_note($H_b (p)$, [binary entropy], tone: "important")
/// ```
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

/// Draws an overbrace with a movable annotation.
/// - `expression`: Mathematical content under the overbrace.
/// - `annotation`: Label content above the brace.
/// - `dx`, `dy`: Move only the annotation; `dy` defaults to `-0.6em`.
/// - `body_dx`, `body_dy`: Move the braced expression independently.
/// - `size`: Annotation text size; `none` preserves custom sizing.
/// - `tone`: Optional key in `semantic_colors`; `none` preserves custom color.
/// - `fill`: Explicit annotation paint that takes precedence over `tone`.
/// - `affect_layout`: When `false` (default), places the label without reserving its
///   normal math space; `true` uses a layout-affecting move.
/// In math-mode calls, inject named code values such as `#none` and lengths with `#`.
/// ```typst
/// #over_note($C$, [capacity], fill: orange, dx: 0.4em)
/// ```
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

/// Re-renders cards collected elsewhere in the document, optionally filtering them.
/// - `tag`: Case-insensitive searchable tag filter; `none` accepts every tag.
/// - `kind`: Exact card-kind filter such as `"proof"`; `none` accepts every kind.
/// - `title`: Optional heading displayed above the collected cards.
/// - `compact`: Uses each card's `collection_summary` when available; otherwise keeps
///   its original body. Defaults to `false`.
/// Filters combine with AND when both are supplied. Cards created with `collect: false`
/// are absent. Matches are duplicated at the call location without emitting new pill
/// metadata, so collecting a collection does not recursively grow the result.
/// ```typst
/// #collect_cards(tag: "definition", title: [Definitions], compact: true)
/// ```
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

/// Creates a level-1 heading compatible with formulaire chapter behavior.
/// - `title`: Heading content.
/// Numbering and optional chapter page breaks are controlled by `formulaire`.
/// ```typst
/// #part[Information theory]
/// ```
#let part(title) = heading(level: 1)[#title]

/// Creates a level-2 heading, normally at the start of a new column.
/// - `title`: Heading content.
/// - `new_column`: Issues a weak column break first; defaults to `true`.
/// ```typst
/// #topic("Channel models", new_column: false)
/// ```
#let topic(title, new_column: true) = [
  #if new_column [#colbreak(weak: true)]
  #heading(level: 2)[#title]
]

/// Creates a level-3 heading for a detail within a topic.
/// - `title`: Heading content.
/// ```typst
/// #subtopic[Binary symmetric channel]
/// ```
#let subtopic(title) = heading(level: 3)[#title]

/// Renders the optional standalone front page and then starts the main document.
/// - `title`: Optional formulaire subtitle shown below the course.
/// - `course`: Course name; defaults to `"Course"`.
/// - `authors`: Author content; defaults to `[Your Name]` and may contain several names.
/// - `institution`: Institution text; defaults to `"UCLouvain"`.
/// - `details`: Optional scope or notes content. An empty content block omits its card.
/// - `show_outline`: Includes a card containing the document outline by default.
/// - `outline_depth`: Maximum outline depth; defaults to `2`.
/// The helper begins with a weak page break and ends with a forced page break. Normally
/// `formulaire(front_page: true)` calls it automatically.
/// ```typst
/// #intro_page(
///   course: "LELEC2700 - Microwaves",
///   authors: [A. Student],
///   details: [Core formulas for the final exam.],
/// )
/// ```
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

/// Installs the complete Gen 2 document style around `body`.
/// - `title`: Optional short title shown in edge text and on the front page.
/// - `course`: Course identifier/name; defaults to `"Course"`.
/// - `authors`: Author content used in edge text and front matter.
/// - `institution`: Institution text; defaults to `"UCLouvain"`.
/// - `layout`: `"horizontal"` for landscape three-column output (default), or
///   `"vertical"` for portrait two-column output.
/// - `hole_punch_preview`: Overlays four red punch guides on both long edges.
/// - `front_page`: Calls `intro_page` before `body` when `true`; defaults to `false`.
/// - `details`, `show_outline`, `outline_depth`: Front-page notes and outline options.
/// - `chapter_new_page`: Starts numbered level-1 headings after the first on a weak new
///   page; defaults to `true`.
/// - `bibliography_new_page`: Inserts a weak page break before bibliography elements;
///   defaults to `true`.
/// - `body`: Document content supplied by the show rule.
/// The wrapper configures A4 orientation, margins, columns, typography, heading numbering,
/// repeated edge text, and the bibliography/heading show rules. An invalid layout asserts.
/// ```typst
/// #show: formulaire.with(
///   course: "LELEC2700 - Microwaves",
///   authors: [A. Student],
///   layout: "horizontal",
/// )
/// ```
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
