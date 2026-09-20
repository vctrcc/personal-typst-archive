#let block_colors = (
	note: rgb("#ecd9ff"),
	trick: rgb("#e5ffbe"),
	warning: rgb("#ffd9d9"),
	extra: rgb("#d9f0ff"),
)

#let conf(
	title: none,
  course: none,
	authors: (),
	abstract: [],
	doc,
) = {
  set page(
    numbering: "1",
  	header: context {
      // 1. Get all headings before the current position query(selector(heading).before(here()))
	   let all_before = query(selector(heading).before(here(), inclusive: true))
      
      // 2. Procedurally resolve the active hierarchy
      // We start with no active headings. For each level (1 to 3), we look for 
      // the last heading of that level that appeared *after* the parent level's location.
      let breadcrumbs = ()
      let search_pool = all_before

      for level in range(1, 4) {
        let candidates = search_pool.filter(h => h.level == level)

        if candidates.len() > 0 {
          let best = candidates.last()
          breadcrumbs.push(best)

          let pos = search_pool.position(h => h.location() == best.location())
          if pos != none {
            search_pool = search_pool.slice(pos + 1)
          }
        } else {
          // If a parent level is missing (e.g., jumping from H1 to H3), stop or skip.
          // Usually, we stop the breadcrumb trail here.
          break
        }
      }

      // 3. Render if we have headings
      if breadcrumbs.len() > 0 {
        set text(size: 9pt)
        grid(
          columns: 1fr,
          row-gutter: 6pt,
          align(center)[
            #breadcrumbs.map(h => {
              let num = if h.numbering != none {
                numbering(h.numbering, ..counter(heading).at(h.location()))
              } else { "" }
              
              // Visual hierarchy: Current section is dark/bold, parents are grey
              if h == breadcrumbs.last() {
                text(fill: black, weight: "semibold")[#num #h.body]
              } else {
                text(fill: luma(120))[#num #h.body]
              }
            }).join(
              // Clean separator with spacing
              h(6pt) + text(fill: luma(180))[#sym.chevron.r] + h(6pt)
            )
          ],
          line(length: 100%, stroke: 0.5pt + luma(200))
        )
      }
    }
  )
  set heading(numbering: "1.a.1")
  set math.equation(numbering: "(1)")

  set par(
    first-line-indent: 1em,
    spacing: 0.65em,
    justify: true,
  )

	// conf: a reusable document header macro.
	// Parameters:
	// - title: the document title (defaults to `none`).
	// - authors: an array of author objects. Each author is expected to have
	//   `name`, `affiliation`, and `email` fields.
	// - abstract: a list or inline content for the abstract section.
	// - doc: the main document body (passed through at the end).

  // Big course code
  if course != none {
    set align(center)
    text(20pt, course)
  }

	// Center the title and author block at the top of the page.
	set align(center)
	// Render the title with a larger font size.
	text(17pt, title)

  // Date of last compilation of document
  set align(center)
  text(10pt, "Last Compiled: " + datetime.today().display("[year]-[month]-[day]"))

  // Render the authors title
  set align(center)
  text(14pt, "Authors")
	// Calculate how many columns to use for the author grid. Limit to 3 cols.
	let count = authors.len()
	let ncols = calc.min(count, 3)

	// Place authors into a responsive grid with up to `ncols` columns.
	// Each author cell shows name, affiliation and an email link.
	// Compact normalizer: map records to strings, keep existing strings.
		let author_strings = authors.map(a =>
			if ("name" in a) {
				let s = a.at("name", default: "Unnamed")
				if a.at("affiliation", default: "") != "" { s = s + " \n " + a.at("affiliation", default: "") }
				if a.at("email", default: "") != ""       { s = s + " \n " + a.at("email", default: "") }
				s
			} else { a }
		)

  grid(
    columns: (1fr,) * ncols,
    row-gutter: 24pt,
    ..author_strings.map(s => [ #s ]),
  )


	// Print the abstract section below the authors. `par(justify: false)`
	// keeps the abstract left-aligned and prevents full justification.
	par(justify: false)[
		*Abstract* \
		#abstract
	]

  // Table of contents
  outline()

	// Reset alignment for the main document body and insert `doc`.
	set align(left)
	doc
}

// Generic block function
#let note_block(block_color, body, title: none) = {
	let color = block_color
	let color_type = block_colors.keys().find(k => block_colors.at(k) == color)
    let title_used = str(if title == none { color_type } else { title })
	title_used = upper(title_used).first() + title_used.slice(1, title_used.len())

	block(
		fill: color,
		inset: 8pt,
		radius: 4pt,
		[*#title_used* : #body]
	)
}

// Todo block
#let todo_block() = {
	block(
		fill: rgb("#FF0000"),
		inset: 8pt,
		radius: 4pt,
		[*#"TODO"* : There is work to do here! ]
	)
}

// Definiton block (side strip, ligthly darker background)
#let def_block(content, color: eastern) = block(
  fill: luma(245),
  stroke: (left: 2pt + color),
  inset: (x: 10pt, y: 8pt),
  radius: 2pt,
  width: 100%
)[#text(style: "italic", size: 10pt, content)]