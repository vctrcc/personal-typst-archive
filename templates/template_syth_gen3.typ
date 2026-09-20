#let TEMPLATE_GEN = "Gen 2 Synthesis"

// ==============================================================
// UTILITY FUNCTIONS
// ==============================================================

// ------------------------------
// Quick TODO block
// ------------------------------

// Basic TODO block, with possibility for explanation\
// > exp: optional explanation text
#let todo_block(exp: none) = {
  block(
    width: 100%,
    fill: rgb("#ffaaa8"),
    stroke: rgb("#ff1a1a") + 2pt,
    inset: 8pt,
    radius: 4pt,
    [#align(center)[
      #text(size: 13pt, fill: rgb("#000000"))[*TO DO*]\
      #text(size: 8pt,  fill: rgb("#a50303"))[#exp]]
    ]
  )
}

// ------------------------------
// Named box (generic)
// ------------------------------

// Generic named box with coloured title strip on the left
#let named_box(title, color, body) = {
  // Sets the name vertically on the left side of the box, with a darker gamma compared to the colour of the text
  // uses 2 inbriked blocks to achieve the effect
  let stroke_param = color.darken(10%) + 1.5pt

  let outer_box = block(
		fill: color.lighten(30%),
    stroke: stroke_param,
		inset: 0pt,
		radius: 4pt,
    width: 100%,
		[
      // Title block
      #block(
        fill: color,
        inset:  (top: 5pt, right: 9pt, bottom: 5pt, left: 9pt),
        radius: (top-left: 4pt, top-right: 4pt),
        stroke: (left: stroke_param, top: stroke_param, right: stroke_param, bottom: none),
        width: 100%,
        align(top)[
          #text(size: 13pt, fill: color.saturate(80%).darken(30%))[*#title*]
        ]
      )
      #v(-10pt)
      // Body block
      #block(
        inset: (top: 4pt, right: 6pt, bottom: 6pt, left: 6pt),
        width: 100%,
        align(top)[
          #text()[#h(1em)#body]
        ]
      )
    ]
	)

  [
    #metadata((box-type: title.split(" ").first(), box: outer_box))
    #outer_box
  ]
}

// ------------------------------
// Special boxes (Info/Note/etc.)
// ------------------------------
#let __sp_bx_wrp(ot: none, tt, color, text_body) = {
  let title = if ot != none { " - " + ot } else { "" }
  named_box(tt + title, color, text_body)
}

// Palette for special boxes
#let sp_bx_clrs = (
  "Info": rgb("#d0ebff"),      // pastel blue
  "Note": rgb("#fff4cc"),      // pastel yellow
  "Trick": rgb("#d4ffd4"),     // pastel green
  "Extra": rgb("#ecd9ff"),     // pastel purple
  "Warning": rgb("#ffdddd"),   // pastel red
  "Critical": rgb("#ffaaaa"),  // deeper pastel red
)

#let info_bx(title: none, text_body) = __sp_bx_wrp(ot: title, "Info", sp_bx_clrs.Info, text_body)
#let note_bx(title: none, text_body) = __sp_bx_wrp(ot: title, "Note", sp_bx_clrs.Note, text_body)
#let trick_bx(title: none, text_body) = __sp_bx_wrp(ot: title, "Trick", sp_bx_clrs.Trick, text_body)
#let extra_bx(title: none, text_body) = __sp_bx_wrp(ot: title, "Extra", sp_bx_clrs.Extra, text_body)
#let warning_bx(title: none, text_body) = __sp_bx_wrp(ot: title, "Warning", sp_bx_clrs.Warning, text_body)
#let critical_bx(title: none, text_body) = __sp_bx_wrp(ot: title, "Critical", sp_bx_clrs.Critical, text_body)

// ------------------------------
// Math boxes (definitions, lemmas, theorems, ...)
// ------------------------------
#let __mth_bx_wrp(num: none, nme: none, typ, color, math_body) = {
  let outer_box = block(
  fill: luma(245),
  stroke: (left: 3pt + color),
  radius: 4pt,
  width: 100%,
    [
      // Mark box with metadata
      #metadata(("box-type": typ))
      // Top block with title
      #block(
        fill: luma(235),
        stroke: (left: 3pt + color),
        inset: (top: 7pt, right: 8pt, bottom: 4pt, left: 8pt),
        radius: (top-left: 4pt, top-right: 4pt),
        width: 100%,
        align(top)[
          #text(size: 13pt, fill: color.saturate(80%).darken(30%))[
            #let numbering = if num != none { num + " " } else { "" }
            #let name_title = if nme != none { "- " + nme } else { "" }
            *#typ #numbering*#name_title
          ]
        ]
      )
      #v(-10pt)
      // Math body block
      #block(
        inset: (top: 4pt, right: 8pt, bottom: 8pt, left: 8pt),
        width: 100%,
        align(top,text(style: "italic")[
          #h(1em)#math_body
        ])
      )
    ]
  )

  [
    #metadata((box-type: typ, box: outer_box))
    #outer_box
  ]
}

// Palette for math boxes
#let mth_clrs = (
  "Definition": rgb("#80b8d8"),   // pastel blue
  "Lemma": rgb("#e6bcd3"),        // pastel purple-pink
  "Theorem": rgb("#80ceb9"),      // pastel teal/green
  "Example": rgb("#f8f2a0"),      // pastel yellow
  "Proof": rgb("#f2cf80"),        // pastel orange
  "Explanation": rgb("#aadaf4"),  // pastel sky blue
)

#let definition_bx(num: none, name: none, math_body) = __mth_bx_wrp(num: num, nme: name, "Definition", mth_clrs.Definition, math_body)
#let lemma_bx(num: none, name: none, math_body) = __mth_bx_wrp(num: num, nme: name, "Lemma", mth_clrs.Lemma, math_body)
#let theorem_bx(num: none, name: none, math_body) = __mth_bx_wrp(num: num, nme: name, "Theorem", mth_clrs.Theorem, math_body)
#let example_bx(num: none, name: none, math_body) = __mth_bx_wrp(num: num, nme: name, "Example", mth_clrs.Example, math_body)
#let proof_bx(num: none, name: none, math_body) = __mth_bx_wrp(num: num, nme: name, "Proof", mth_clrs.Proof, math_body)
#let explanation_bx(num: none, name: none, math_body) = __mth_bx_wrp(num: num, nme: name, "Explanation", mth_clrs.Explanation, math_body)

// ------------------------------
// Layout utilities (object grid)
// ------------------------------

// Generic object array function to layout objects in a grid
//
// Format like a generic grid but with automatic handling of last partial row centering
#let object_array(ncols: 2, body_array) = {
  let n = body_array.len()
  if n == 0 { return none }

  let full_rows = calc.floor(n / ncols)
  let rem = calc.rem(n, ncols)

  let gutter = 10pt
  let colw = (100% - gutter * (ncols - 1)) / ncols

  let full_count = full_rows * ncols
  let main = body_array.slice(0, full_count)
  let tail = body_array.slice(full_count, n)

  block(width: 100%)[
    // full rows
    #grid(columns: (1fr,) * ncols, gutter: gutter, ..main)

    // last partial row (centered, same column width as above)
    #if rem != 0 {
      let inner_w = colw * rem + gutter * (rem - 1)
      align(center)[
        #block(width: inner_w)[
          #grid(columns: (1fr,) * rem, gutter: gutter, ..tail)
        ]
      ]
    }
  ]
}

// ------------------------------
// Image arrays with references
// ------------------------------

// Image array with captions and main caption
//
// Format the images_with_captions parameter as an array (parenthesis) of tuples:
//   (image: "path/to/image.png", caption: "Caption text", width: 50%, height: auto, label: none, align: horizon, alt: "")
#let image_array(main_caption: none, ncols: 2, images_with_captions) = {
  block()
  // Build the super figure
  figure(
    supplement: [Figures],
    caption: if main_caption != none {
      [#main_caption]
    } else { none },
    // Create a block in the figure to hold the image array
    block(
      width: 100%,
      // Make the object array inside
      object_array(
        ncols: ncols,
        // Map each image_with_caption to a sub-figure
        images_with_captions.map(img_params => [
            #let img_source  = img_params.image
            #let img_caption = img_params.at("caption", default: "")
            #let img_width   = img_params.at("width", default: auto)
            #let img_height  = img_params.at("height", default: auto)
            #let img_label   = img_params.at("label", default: none)
            #let img_align   = img_params.at("align", default: horizon)
            #let img_alt     = img_params.at("alt", default: "")
            #align(img_align)[#figure(
              kind: "sub_figure",
              supplement: [Fig],
              numbering: (x) => numbering("1.a ", // Set the figure numbering
                counter(figure.where(kind: image)).get().at(0),
                images_with_captions.position(prm => prm == img_params) + 1
              ),
              image(img_source, fit: "contain", width: img_width, height: img_height, alt: img_alt),
              caption: img_caption
            )#img_label]
          ]
        )
      )
    )
  )
  block()
}

// ------------------------------
// Automatic content grouper
// ------------------------------

// This function fetches all boxes of a given type and stacks them with a given gap
#let auto_box_fetcher(box-type, gap: 2pt) = {
  context {
    let hits = query(metadata)
      .filter(m => type(m.value) == dictionary)
      .filter(m => m.value.box-type == box-type)
      .map(m => m.value.at("box", default: none))
    stack(dir: ttb, spacing: gap, ..hits)
  }
}

// ==============================================================
// MAIN HELPERS: BACKGROUND / AUTHORS / TITLE PAGE
// ==============================================================

#let background_image_opacity = 25%

// ------------------------------
// Background image compositor
// ------------------------------
// Take a list of image tuples and set them for the background
#let __background_image_assembler(
  background_images: ()
) = {
  // We are a array of images
  let num_imgs = background_images.len()
  if num_imgs == 0 {return none}

  // Find the way to maximize the area usage, considering square images
  // Meaning, nrows * ncols ~= num_imgs, with ncols =< nrows and ncols - nrows minimal
  // We must first get the page aspect ratio
  let page_gutter_size = 30pt
  let aspect_ratio = (page.width + page_gutter_size*2) / (page.height + page_gutter_size*2)
  let ncols = calc.ceil(calc.log(num_imgs * aspect_ratio, base: 2))
  let nrows = calc.ceil(num_imgs / ncols)

  // Slice the images into main and tail
  let main_imgs = background_images.slice(0, ncols * (nrows - 1))
  let tail_imgs = background_images.slice(ncols * (nrows - 1), num_imgs)

  // Build the grid of images
  place(top,
  block(
    inset: page_gutter_size,
  )[
    #grid(
      gutter: 3pt,
      columns: (1fr,) * ncols,
      ..main_imgs.map(img =>
        align(center + horizon, image(
          img.image,
          fit: "contain",
          width: img.at("width", default: auto)
        ))
      )
    )
    #align(center)[
      #block(
        outset: (top: 0pt),
        width: calc.min(100%, (100% / ncols) * tail_imgs.len() * calc.sqrt(2)),
        grid(
          gutter: 3pt,
          columns: (1fr,) * tail_imgs.len(),
          ..tail_imgs.map(img => align(center + horizon, image(
            img.image,
            fit: "contain",
            width: img.at("width", default: auto)
          )))
        )
      )
    ]
    // Give the effect of opacity by placing a semi-transparent white rectangle over the images
    #place(
      top + left,
      rect(
        width: 100%,
        height: 100%,
        fill: rgb(255, 255, 255, 100% - background_image_opacity)
      )
    )
  ])
}

// ------------------------------
// Author grid layout
// ------------------------------
// Author grid function to layout authors in n columns
#let __author_grid_generator(
  authors: (),
  ncols: 3
) = {
  // Convert author data into formatted strings
  let author_strings = authors.map(a =>
    if ("name" in a) {
      let s = a.at("name", default: "Unnamed")
      if a.at("affiliation", default: "") != "" { s = s + " \n " + a.at("affiliation", default: "") }
      if a.at("email", default: "") != ""       { s = s + " \n " + a.at("email", default: "") }
      s
    } else { a }
  )

  let total = author_strings.len()
  let rows = ()
  let i = 0

  // Split authors into rows of ncols each
  while i < total {
    let row = author_strings.slice(i, calc.min(i + ncols, total))
    rows.push(
      if row.len() == ncols {
        // Full row: use fractional columns for even distribution
        grid(columns: (1fr,) * ncols, align: center, ..row.map(s => [ #s ]))
      } else {
        // Partial row: center using auto-sized columns
        align(center, grid(columns: (auto,) * row.len(), align: center, column-gutter: 2em, ..row.map(s => [ #s ])))
      }
    )
    i += ncols
  }

  // Stack all rows vertically with spacing
  stack(spacing: 24pt, ..rows)
}

// ------------------------------
// Title page assembler
// ------------------------------
#let __title_page_assembler(
  title: none,
  course: none,
  authors: (),
  abstract: [],
) = {
  align(center)[
    #text(22pt, course)

    // Render the title with a larger font size.
    #text(17pt, title)

    // Date of last compilation of document
    #text(10pt, "Last Compiled: " + datetime.today().display("[year]-[month]-[day]"))
    #text(8pt, "\n(" + TEMPLATE_GEN + ")")

    // Render the authors title
    #text(14pt, [*Authors*])
    #__author_grid_generator(authors: authors)

    // Print the abstract section below the authors. `par(justify: false)`
    // keeps the abstract left-aligned and prevents full justification.
    #text(14pt, [*Abstract*])
    #par(justify: false)[
      #abstract
    ]

    // Table of contents
    #outline()
  ]
}

// ==============================================================
// HEADER / FOOTER HELPERS
// ==============================================================

// Basic separation bar
#let separation_bar() = {
  line(length: 100%, stroke: 0.7pt + luma(0))
}

// ------------------------------
// Header generator
// ------------------------------
#let __section_header(max_level: 3) = context {
  // All headings up to and including the current position.
  let hs = query(selector(heading).before(here(), inclusive: true))

  // active.at(level-1) stores the currently "active" heading for that level.
  let active = (none,) * max_level

  // Single pass: update the active heading for the seen level, clear deeper levels.
  for h in hs {
    if h.level <= max_level {
      active.at(h.level - 1) = h
      for k in range(h.level, max_level) { active.at(k) = none }
    }
  }

  let crumbs = active.filter(x => x != none)
  if crumbs.len() == 0 { return none }

  set text(size: 9pt)

  align(center)[
    // Render each crumb; last one highlighted.
    #crumbs.map(h => {
      let nums = counter(heading).at(h.location())
      let num = if h.numbering != none { numbering(h.numbering, ..nums) } else { "" }
      if h == crumbs.last() {
        text(fill: black, weight: "semibold")[#num #h.body]
      } else {
        text(fill: luma(120))[#num #h.body]
      }
    }).join(
      h(6pt) + text(fill: luma(180))[#sym.chevron.r] + h(6pt)
    )
  ]
}

// ------------------------------
// Footer generator
// ------------------------------
#let __section_footer() = {
  context {
    // Simple footer with page number centered
    separation_bar()
    align(center)[
      #text(11pt, str(counter(page).at(here()).first()) + " / " + str(counter(page).final().first()))
    ]
  }
}

// ==============================================================
// TIME ESTIMATION & HEADING STYLES
// ==============================================================

// TIME ESTIMATION
#let TIME = (
  per_par: 0.3,
  per_fig: 0.6,
  per_tab: 1.0,
  per_eq: 0.15,
  min: 0.1,
)
// ------------------------------
// Heading style configuration
// ------------------------------
#let HEADING_STYLES = (
  "1": (page_break: true, top_line: false, top_thickness: 0.3pt, top_color: luma(100), bottom_line: false),
  "2": (top_line: true, top_thickness: 0.3pt, top_color: luma(100), bottom_line: false),
  "3": (top_line: true, top_thickness: 0.3pt, top_color: luma(100), bottom_line: false),
)

// ------------------------------
// Helpers: query/range utilities
// ------------------------------
// Helper: Query range between two locations
#let __qrange(sel, start, end_loc: none) = if end_loc != none {
  query(sel.after(start).before(end_loc))
} else {
  query(sel.after(start))
}

// Helper: Section end location finder
#let __section_end_loc(start_loc) = {
  let hs = query(selector(heading))
  let idx = hs.position(h => h.location() == start_loc)
  if idx == none { return none }

  let lvl = hs.at(idx).level
  for i in range(idx + 1, hs.len()) {
    if hs.at(i).level <= lvl { return hs.at(i).location() }
  }
  none
}

// Helper: number formatting
#let __fmt1(x) = {
  let rounded = calc.round(x * 10) / 10
  str(rounded)
}

// ------------------------------
// Time estimation (heuristic)
// ------------------------------
// Estimate section time based on content types (using a heuristic)
#let __estimate_section_time(heading_loc) = {
  let end_loc = __section_end_loc(heading_loc)

  let pars = __qrange(selector(metadata.where(value: "par")), heading_loc, end_loc: end_loc).len()
  let figs = __qrange(selector(figure), heading_loc, end_loc: end_loc).len()
  let tabs = __qrange(selector(table), heading_loc, end_loc: end_loc).len()
  // Only count display equations (block == true)
  let eqs = __qrange(selector(math.equation), heading_loc, end_loc: end_loc).filter(e => e.block).len()

  let t = pars * TIME.per_par + figs * TIME.per_fig + tabs * TIME.per_tab + eqs * TIME.per_eq
  calc.max(TIME.min, t)
}

// ------------------------------
// Heading formatter
// ------------------------------
// Heading formatter to apply styles based on level
#let heading_formatter(it) = {
  let style = HEADING_STYLES.at(str(it.level), default: (top_line: false, bottom_line: false))
  let result = []

  // Only apply page breaks to outlined headings (skip outline/TOC headings)
  if style.at("page_break", default: false) and it.outlined {
    result += pagebreak()
  }

  if style.at("top_line", default: false) {
    result += line(length: 100%, stroke: style.at("top_thickness", default: 0.5pt) + style.at("top_color", default: black))
  }

  // Add the heading with inline time estimation (only for outlined headings)
  let time =  if it.outlined {
    context {
      let t = __estimate_section_time(it.location())
      text(size: 0.8em, fill: luma(120), style: "italic")[
        (#sym.tilde#__fmt1(t) min)
      ]
    }
  } else { none }

  // Render heading text + time on ONE line using fractional spacing
  result += block[
    #grid(columns: (1fr,60pt), it, if time != none { h(1fr); sym.wj; time })
  ]

  if style.at("bottom_line", default: false) {
    result += line(length: 100%, stroke: style.at("bottom_thickness", default: 0.5pt) + style.at("bottom_color", default: black))
  }

  result
}


// --------------------------
// Main configuration function
// --------------------------
#let conf(
	title: none,
  course: none,
	authors: (),
	abstract: [],
  background_images: (), // List of images to use as background pages, format as ((image: "path", width: 50%), (image: "path2", width: 30%))
  bibliography_sources: "",
	doc,
) = {
  // ------------------------
  // Page setup
  // ------------------------
  set page(
    background: context {
      if counter(page).at(here()).first() <= 1 {
        __background_image_assembler(background_images: background_images)
      }
    },
    margin: (x: 72pt, y: 40pt),

    numbering: "1/1",
    footer: __section_footer(),
    header : __section_header(),
  )
  
  set text(size: 10pt)
  set heading(numbering: "1.1.1")
  set math.equation(numbering: "(1)")
  set par(
    first-line-indent: 1em,
    spacing: 1em,
    justify: true,
  )

  // Inject invisible paragraph markers for time estimation
  show par: it => {
    it
    [#metadata("par") <_par_marker_>]
  }

  // Apply heading styles with lines
  show heading: heading_formatter

  // Hyperlink as underlined
  show link: underline

  // ------------------------
  // Document content
  // ------------------------

  __title_page_assembler(
    title: title,
    course: course,
    authors: authors,
    abstract: abstract,
  )

  doc

  // Bibliography section
  if bibliography_sources != "" {
    bibliography(sources: bibliography_sources)
  }
}
