// ============================================================================
// GEN 2 FORMULAIRE — USAGE AND FEATURE REFERENCE
// ============================================================================
// Compact, importable Typst template with no external package dependencies.
//
// MINIMAL SETUP
// ---------------------------------------------------------------------------
// #import "tmplt_formulaire_gen2.typ": *
//
// #show: formulaire.with(
//   course: "LELEC2700 - Microwaves",
//   authors: [John Doe],
// )
//
// Write the document normally after the show rule:
//
// = First chapter
// #fbox("Essential relation")[$ c = lambda f $]
//
// = Second chapter
// This level-one heading starts on a new page by default.
//
// COMPLETE SETUP
// ---------------------------------------------------------------------------
// #show: formulaire.with(
//   // Main identity. Include both the code and full course name.
//   course: "LELEC2700 - Microwaves",
//   authors: [John Doe and Jane Doe],
//   institution: "UCLouvain",
//
//   // Optional scope for a partial formulaire. Leave as `none` for the full
//   // course, e.g. title: "Part 1 - Transmission Lines".
//   title: none,
//
//   // "horizontal": landscape A4, three columns (default).
//   // "vertical": portrait A4, two columns.
//   layout: "horizontal",
//
//   // Debug-only print preview: overlay four dotted 6 mm punch holes on both
//   // long edges of every page. Disable before final export.
//   hole_punch_preview: false,
//
//   // Optional introductory page containing the course, optional title,
//   // authors, institution, template generation, and compilation date.
//   front_page: false,
//   details: [Short description or scope notes.],
//
//   // Only applies when `front_page` is true.
//   show_outline: true,
//   outline_depth: 2,
//
//   // Start every numbered level-one heading after the first on a new page.
//   chapter_new_page: true,
//
//   // Start Typst bibliography elements on a new page independently.
//   bibliography_new_page: true,
// )
//
// PAGE EDGES
// ---------------------------------------------------------------------------
// Every page has a compact, aligned header and footer containing:
// - authors and institution;
// - course and optional partial title;
// - formulaire generation, compilation date, and page number.
// A front page is therefore optional rather than required for identification.
//
// SECTIONS AND AUTOMATIC BREAKS
// ---------------------------------------------------------------------------
// = Chapter                         // Level 1; new page after the first.
// == Topic                          // Level 2; normal heading.
// === Subtopic                      // Level 3; normal heading.
// #part[Chapter]                    // Helper equivalent to a level-1 heading.
// #topic[Topic]                     // Level 2 preceded by a weak column break.
// #subtopic[Subtopic]               // Helper equivalent to level 3.
//
// INTRO PAGE AS A STANDALONE HELPER
// ---------------------------------------------------------------------------
// Normally use `front_page: true` in `formulaire.with`. For manual placement:
//
// #intro_page(
//   course: "LELEC2700 - Microwaves",
//   title: "Part 1 - Transmission Lines",
//   authors: [John Doe],
//   institution: "UCLouvain",
//   details: [Optional scope information.],
//   show_outline: true,
//   outline_depth: 2,
// )
//
// `first_page` remains available as a backwards-compatible singular-author
// alias for `intro_page`.
//
// CONTENT BOXES
// ---------------------------------------------------------------------------
// #fixedbox("Title")[Content]       // Theory card that cannot split.
// #theorybox("Title")[Content]      // Breakable theory card.
// #exercisebox("Title")[Content]    // Blue exercise card.
// #examplebox("Title")[Content]     // Orange example card.
// #proofbox("Title")[Content]       // Green proof card.
// #exambox("Title")[Content]        // Red card with an EXAM tag.
// #warningbox("Title")[Content]     // Yellow card with a WARN tag.
// #todobox("Title")[Content]        // Grey card with a TODO tag.
// #subbox("Title")[Content]         // Nested definition/detail card.
//
// Every box accepts an optional semantic title tag:
// #fbox("Exam formula", tag: "exam")[Content] // Red EXAM tag.
// #tbox("Pitfall", tag: "warn")[Content]      // Orange WARN tag.
// This also works with subbox, eqbox, diagram_box, and all aliases below.
//
// Generic form for custom card behavior:
// #smartbox("Title", kind: "example", breakable: true, tag_name: "KEY")[Body]
// Kinds: "theory", "exercise", "example", "proof", "exam", "warning",
// and "todo".
//
// LEGACY BOX NAMES FROM formulaire_fixed.typ
// ---------------------------------------------------------------------------
// #fbox("Title")[Content]           // Alias for fixedbox.
// #fbbox("Title")[Content]          // Alias for theorybox.
// #tbox("Title")[Content]           // Alias for theorybox.
// #ebox("Title")[Content]           // Alias for exambox.
// #exerbox("Title")[Content]        // Alias for exercisebox.
// #subdefbox("Title")[Content]      // Alias for subbox.
//
// INLINE SEMANTIC HELPERS
// ---------------------------------------------------------------------------
// #defn[Definition]                 // Bold red definition.
// #def[Definition]                  // Legacy alias for defn.
// #imp[Important result]            // Bold blue emphasis.
// #ind[Indicator or condition]      // Bold green emphasis.
// #cat[Category]                    // Semibold purple category.
// #danger[Invalid or unsafe]        // Bold red negative outcome.
// #success[Valid or achieved]       // Bold green positive outcome.
// #info[Explanatory quantity]       // Bold blue information.
// #warn[Caution or limitation]      // Bold orange warning.
// #contextual[Observed context]     // Bold purple interpretation.
// #semantic(tone: "warning")[Text] // Generic palette-backed form.
// #strong[Ordinary bold text]
// #small[Muted secondary text]
// #math_note[Compact green mathematical note.]
//
// EQUATIONS, DIAGRAMS, TAGS, AND NOTES
// ---------------------------------------------------------------------------
// #eqbox(label: [KEY EQUATION])[
//   $ Z_"in" = Z_0 (Z_L + j Z_0 tan(beta l))/(Z_0 + j Z_L tan(beta l)) $
// ]
//
// Standardized brace annotations for use directly in math mode:
// $ underNote(H(X), "Source entropy") $
// $ overNote(C, "Capacity", tone: "warning") $
// Defaults are 7.5 pt, centered, `dy: 0em` below an underbrace, and
// `dy: -0.6em` above an overbrace. Both accept `dx`, `dy`, `size`, and `tone`.
// The camelCase aliases are required in math mode; snake_case names remain
// available from code mode.
//
// #diagram_box(title: [Signal flow])[
//   Diagram content or an imported drawing.
// ]
//
// #pill("EXAM")                     // Small coloured label.
// #tag("important")                // Visible pill plus metadata.
// #tag("search-only", visible: false) // Invisible metadata marker.
// #estimate(15)                     // Muted "est. 15 min" text.
// #hline()                          // Thin full-width separator.
// #note_lines(count: 4)             // Dotted writing lines.
// #diagMath[$ E = eta H $]          // Legacy 11 pt diagram math.
// #diagBox[Diagram content]          // Legacy diagram-box alias.
//
// BIBLIOGRAPHY
// ---------------------------------------------------------------------------
// #bibliography(
//   "references.bib",
//   title: [References],
//   full: true,
// )
//
// It starts on a new page when `bibliography_new_page` is true. This setting
// is independent from `chapter_new_page`.
// ============================================================================

#let FORMULAIRE_GEN = "Gen 2"

// Compact document identity shown in the page header and footer. `title` is
// optional and identifies a partial formulaire rather than the course itself.
#let edge_text(
  course,
  authors,
  title: none,
  institution: "UCLouvain",
) = block(width: 100%)[
  #grid(
    columns: (1fr, 1.4fr, 1fr),
    align: (left, center, right),
    column-gutter: 0.8em,
    [#institution · Formulaire #FORMULAIRE_GEN · #authors · Compilation #datetime.today().display("[year]-[month]-[day]")],
    [#course#if title != none [ — #title]],
    [page #context counter(page).display()],
  )
]

#let colors = (
  ink: rgb("#1f2937"),
  muted: rgb("#6b7280"),
  line: rgb("#d1d5db"),
  defn: rgb("#b91c1c"),
  important: rgb("#1d4ed8"),
  indicator: rgb("#15803d"),
  category: rgb("#7e22ce"),
  warning: rgb("#c2410c"),
  example_tag: rgb("#b45309"),
  warning_tag: rgb("#a16207"),
  equation_body: rgb("#f2f7ff"),
  diagram_body: rgb("#fcfcfd"),
  punch_fill: rgb("#ef4444"),
  punch_stroke: rgb("#b91c1c"),
  theory_title: rgb("#eaf2ff"),
  theory_body: rgb("#ffffff"),
  theory_border: rgb("#93b4dd"),
  exercise_title: rgb("#eaf7ff"),
  exercise_body: rgb("#f5fbff"),
  exercise_border: rgb("#7aaacb"),
  example_title: rgb("#fff3df"),
  example_body: rgb("#fffaf0"),
  example_border: rgb("#d8a35d"),
  proof_title: rgb("#edf7ed"),
  proof_body: rgb("#fbfffb"),
  proof_border: rgb("#83b883"),
  exam_title: rgb("#ffe9e7"),
  exam_body: rgb("#fffafa"),
  exam_border: rgb("#d26a61"),
  warning_title: rgb("#fff4cd"),
  warning_body: rgb("#fffaf0"),
  warning_border: rgb("#d7a327"),
  todo_title: rgb("#f0f1f4"),
  todo_body: rgb("#fafafa"),
  todo_border: rgb("#a8adb7"),
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

#let layout_config(layout) = {
  let cfg = layout_configs.at(layout, default: none)
  assert(
    cfg != none,
    message: "layout must be either \"horizontal\" or \"vertical\"",
  )
  cfg
}

// Debug overlay for checking whether important content intersects physical
// punch holes. The markers follow the two long edges: left/right in portrait
// and top/bottom in landscape. Their centres use the standard 80 mm spacing.
#let hole_punch_overlay(layout) = {
  // Circle top/left offsets for centres at 28.5, 108.5, 188.5, and 268.5 mm.
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

// Semantic colors observed repeatedly in formulaire_fixed.typ.
#let semantic_colors = (
  definition: colors.defn,
  important: colors.important,
  indicator: colors.indicator,
  category: colors.category,
  danger: colors.defn,
  success: colors.indicator,
  info: colors.important,
  warning: colors.warning,
  "context": colors.category,
)

#let semantic_color(tone) = {
  let fill = semantic_colors.at(tone, default: none)
  assert(fill != none, message: "unknown semantic tone: " + tone)
  fill
}

#let semantic(body, tone: "info", weight: "bold") = text(
  fill: semantic_color(tone),
  weight: weight,
  body,
)

// Descriptive helpers for new documents.
#let danger(body) = semantic(body, tone: "danger")
#let success(body) = semantic(body, tone: "success")
#let info(body) = semantic(body, tone: "info")
#let warn(body) = semantic(body, tone: "warning")
#let contextual(body) = semantic(body, tone: "context")

// Established names retained for compatibility.
#let defn(body) = semantic(body, tone: "definition")
#let imp(body) = semantic(body, tone: "important")
#let ind(body) = semantic(body, tone: "indicator")
#let cat(body) = semantic(body, tone: "category", weight: "semibold")
#let strong(body) = text(weight: "bold", body)
#let small(body) = text(size: 0.82em, fill: colors.muted, body)

#let pill(label, fill: colors.category, ink: white) = box(
  inset: (x: 3pt, y: 0.8pt),
  radius: 1.5pt,
  fill: fill,
)[#text(size: 6.2pt, fill: ink, weight: "bold")[#label]]

// Visible or invisible metadata tag. Useful for marking important content.
#let tag(name, visible: true, fill: colors.category) = {
  metadata((tag: name))
  if visible { pill(name, fill: fill) }
}

#let estimate(minutes, label: "est.") = text(size: 0.78em, fill: colors.muted)[#label #minutes min]
#let hline() = line(length: 100%, stroke: 0.25pt + colors.line)
#let note_lines(count: 3) = [
  #for _ in range(count) [
    #line(length: 100%, stroke: (paint: colors.line, thickness: 0.25pt, dash: "dotted"))
    #v(0.35em)
  ]
]

#let box_palettes = (
  theory: (
    title: colors.theory_title,
    body: colors.theory_body,
    border: colors.theory_border,
    tag: colors.important,
  ),
  exercise: (
    title: colors.exercise_title,
    body: colors.exercise_body,
    border: colors.exercise_border,
    tag: colors.important,
  ),
  example: (
    title: colors.example_title,
    body: colors.example_body,
    border: colors.example_border,
    tag: colors.example_tag,
  ),
  proof: (
    title: colors.proof_title,
    body: colors.proof_body,
    border: colors.proof_border,
    tag: colors.indicator,
  ),
  exam: (
    title: colors.exam_title,
    body: colors.exam_body,
    border: colors.exam_border,
    tag: colors.defn,
  ),
  warning: (
    title: colors.warning_title,
    body: colors.warning_body,
    border: colors.warning_border,
    tag: colors.warning_tag,
  ),
  todo: (
    title: colors.todo_title,
    body: colors.todo_body,
    border: colors.todo_border,
    tag: colors.muted,
  ),
)

#let palette(kind) = box_palettes.at(kind, default: box_palettes.theory)

#let box_tag_styles = (
  exam: (label: "EXAM", fill: colors.defn),
  warn: (label: "WARN", fill: colors.warning),
)

#let box_tag(tag_name, fallback_color: colors.category) = {
  let key = if type(tag_name) == str { lower(tag_name) } else { none }
  let style = if key != none {
    box_tag_styles.at(key, default: none)
  } else {
    none
  }

  if style != none {
    pill(style.label, fill: style.fill)
  } else {
    pill(tag_name, fill: fallback_color)
  }
}

#let card_title(title, tag_name: none, tag_color: colors.category) = box(width: 100%)[
  #text(fill: colors.ink, weight: "bold")[#title]
  #if tag_name != none [#h(1fr)#box_tag(tag_name, fallback_color: tag_color)]
]

#let smartbox(title, body, kind: "theory", breakable: true, tag_name: none) = {
  let c = palette(kind)
  block(
    width: 100%,
    breakable: breakable,
    radius: 2pt,
    stroke: 0.45pt + c.border,
    fill: c.body,
    inset: 0pt,
  )[
    #block(width: 100%, fill: c.title, inset: (x: 5pt, y: 3pt))[
      #card_title(title, tag_name: tag_name, tag_color: c.tag)
    ]
    #block(width: 100%, fill: c.body, inset: 5pt)[#body]
  ]
}

// Box types from the notes. `tag` may be "exam", "warn", or a custom label.
#let fixedbox(title, body, tag: none) = smartbox(title, body, kind: "theory", breakable: false, tag_name: tag)
#let theorybox(title, body, tag: none) = smartbox(title, body, kind: "theory", tag_name: tag)
#let exercisebox(title, body, tag: none) = smartbox(title, body, kind: "exercise", tag_name: tag)
#let examplebox(title, body, tag: none) = smartbox(title, body, kind: "example", tag_name: tag)
#let proofbox(title, body, tag: none) = smartbox(title, body, kind: "proof", tag_name: tag)
#let exambox(title, body, tag: "exam") = smartbox(title, body, kind: "exam", tag_name: tag)
#let warningbox(title, body, tag: "warn") = smartbox(title, body, kind: "warning", tag_name: tag)
#let todobox(title, body, tag: "TODO") = smartbox(title, body, kind: "todo", tag_name: tag)

#let subbox(title, body, tag: none) = [
  #v(0.25em)
  #block(
    width: 100%,
    breakable: true,
    inset: 4pt,
    radius: 2pt,
    stroke: 0.3pt + colors.theory_border,
    fill: white,
  )[
    #card_title(title, tag_name: tag, tag_color: colors.category)
    #hline()
    #body
  ]
  #v(0.25em)
]

#let eqbox(body, label: none, tag: none) = block(
  width: 100%,
  breakable: false,
  inset: 4pt,
  radius: 2pt,
  stroke: 0.45pt + colors.important,
  fill: colors.equation_body,
)[
  #if label != none or tag != none [
    #box(width: 100%)[
      #if label != none [#text(size: 6.5pt, fill: colors.muted, weight: "bold")[#label]]
      #if tag != none [#h(1fr)#box_tag(tag, fallback_color: colors.important)]
    ]
    #v(0.15em)
  ]
  #align(center)[#body]
]

#let diagram_box(body, title: none, tag: none) = block(
  width: 100%,
  breakable: false,
  inset: 4pt,
  radius: 2pt,
  stroke: 0.35pt + colors.line,
  fill: colors.diagram_body,
)[
  #if title != none or tag != none [
    #box(width: 100%)[
      #if title != none [#small[#title]]
      #if tag != none [#h(1fr)#box_tag(tag)]
    ]
    #v(0.2em)
  ]
  #align(center)[#body]
]

#let math_note(body) = text(size: 0.82em, fill: colors.indicator)[#body]

// Compact brace annotations based on the dominant patterns in
// formulaire_fixed.typ. `under_note` labels below the expression, while
// `over_note` labels above it.
#let brace_annotation(
  annotation,
  dx: 0em,
  dy: 0em,
  size: 7.5pt,
  tone: none,
) = {
  let label = if tone == none {
    text(size: size, annotation)
  } else {
    text(size: size, fill: semantic_color(tone), annotation)
  }
  place(center, dx: dx, dy: dy, label)
}

#let under_note(
  expression,
  annotation,
  dx: 0em,
  dy: 0em,
  size: 7.5pt,
  tone: none,
) = math.underbrace(
  expression,
  brace_annotation(annotation, dx: dx, dy: dy, size: size, tone: tone),
)

#let over_note(
  expression,
  annotation,
  dx: 0em,
  dy: -0.6em,
  size: 7.5pt,
  tone: none,
) = math.overbrace(
  expression,
  brace_annotation(annotation, dx: dx, dy: dy, size: size, tone: tone),
)

// Math mode parses underscores as subscripts, so expose identifier-safe aliases.
#let underNote = under_note
#let overNote = over_note

// Section helpers. The main wrapper handles page breaks consistently for
// both `#part[...]` and regular level-one headings (`= Chapter`).
#let part(title) = heading(level: 1)[#title]

#let topic(title) = [
  #colbreak(weak: true)
  #heading(level: 2)[#title]
]

#let subtopic(title) = heading(level: 3)[#title]

// Optional introductory page. It deliberately uses no heading elements, so
// it does not count as the first chapter.
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
      #text(size: 11pt, fill: colors.important, weight: "semibold")[#title]
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
    #fixedbox("About this formulaire")[#details]
  ]

  #if show_outline [
    #v(0.8em)
    #fixedbox("Table of contents")[
      #outline(title: none, depth: outline_depth)
    ]
  ]

  #pagebreak()
]

// Backwards-compatible name used by earlier formulaire documents.
#let first_page(
  title: none,
  course: "Course",
  author: "Your Name",
  institution: "UCLouvain",
  details: [],
  show_outline: true,
  outline_depth: 2,
) = intro_page(
  title: title,
  course: course,
  authors: author,
  institution: institution,
  details: details,
  show_outline: show_outline,
  outline_depth: outline_depth,
)

// Compatibility names used by formulaire_fixed.typ and older formulaires.
// New documents may use either these short names or the descriptive names above.
#let def = defn
#let fbox = fixedbox
#let fbbox = theorybox
#let tbox = theorybox
#let ebox = exambox
#let exerbox = exercisebox
#let subdefbox = subbox
#let diagMath(body) = text(size: 11pt)[#body]
#let diagBox(body, tag: none) = diagram_box(body, tag: tag)

// Main document wrapper. As with the synthesis template's `conf`, the final
// positional parameter receives all document content from the show rule.
#let formulaire(
  title: none,
  course: "Course",
  author: "Your Name",
  authors: none,
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
  let cfg = layout_config(layout)
  let displayed_authors = if authors == none { author } else { authors }
  let page_edge = edge_text(
    course,
    displayed_authors,
    title: title,
    institution: institution,
  )

  set page(
    paper: "a4",
    flipped: cfg.flipped,
    margin: cfg.margin,
    columns: cfg.columns,
    foreground: if hole_punch_preview {
      hole_punch_overlay(layout)
    },
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

  // Start every numbered level-one chapter except the first on a fresh page.
  // The bibliography heading is unnumbered and is controlled separately below.
  show heading.where(level: 1): it => context {
    let chapter = counter(heading).at(it.location()).first()
    if chapter_new_page and it.numbering != none and chapter > 1 {
      pagebreak(weak: true)
    }
    it
  }

  show bibliography: it => {
    if bibliography_new_page {
      pagebreak(weak: true)
    }
    it
  }

  if front_page {
    intro_page(
      title: title,
      course: course,
      authors: displayed_authors,
      institution: institution,
      details: details,
      show_outline: show_outline,
      outline_depth: outline_depth,
    )
  }

  body
}
