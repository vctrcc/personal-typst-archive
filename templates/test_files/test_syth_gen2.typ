#import "template_syth_gen2.typ": *
#show: conf.with(
  title: [
    Towards Improved Modelling
  ],
  course: "LELEC4555: Advanced Topics in Synthesis",
  authors: (
    (
      name: "Theresa Tungsten",
      affiliation: "Artos Institute",
      email: "theresa.tungsten@artos.edu"
    ),
    (
      name: "Eugene Deklan",
      affiliation: "Honduras State",
      email: "eugene.deklan@honduras.edu"
    ),
  ),
  abstract: lorem(80),
  background_images: (
    (image: "images/background1.png", width: 100%),
    (image: "images/background2.png", width: 100%),
    (image: "images/background2.png", width: 100%),
    (image: "images/background2.png", width: 100%),
    (image: "images/background2.png", width: 100%)
  ),
)

= The First Chapter
#lorem(200)
== A Section
#lorem(150)
=== A Subsection
#lorem(100)

= Another Chapter
#lorem(200)
== Another Section
#lorem(150)
=== Another Subsection
#lorem(100)
==== A Subsubsection
#lorem(80)
===== A Paragraph Heading
#lorem(60)
====== A Subparagraph Heading
#lorem(40)
======= A Subsubparagraph Heading
#lorem(20)

= Formatting Tests
#lorem(200)

== Text Styling
This section demonstrates *bold text*, _italic text_, and `code formatting`.
You can also combine them like *_bold italic_* if needed.

#lorem(100)

== Lists and Citations
- First item
- Second item
  - Nested item
  - Another nested
- Third item

1. Numbered first
2. Numbered second
3. Numbered third

#lorem(80)

= Tables and Data
#lorem(150)

== Sample Table
#table(
  columns: 3,
  [Header 1], [Header 2], [Header 3],
  [Row 1 Col 1], [Row 1 Col 2], [Row 1 Col 3],
  [Row 2 Col 1], [Row 2 Col 2], [Row 2 Col 3],
)

#lorem(120)

= Code Examples
#lorem(200)

== Programming Samples

#todo_block()
#todo_block(exp: "Add programming sample code here.")

#lorem(40)

#lorem(40)

#named_box(lorem(5), rgb("#ecd9ff"), [
  #lorem(50)

  #lorem(500)
])

#info_bx(lorem(30))
#info_bx(title: lorem(3),lorem(30))
#lorem(20)
#warning_bx(lorem(30))
#warning_bx(title: lorem(3),lorem(30))
#lorem(20)
#critical_bx(lorem(30))
#critical_bx(title: lorem(3),lorem(30))
#lorem(20)

#definition_bx(
  num: none,
  name: lorem(7),
  [
    A *definition box* is used to highlight important definitions within the text.
    It typically contains key terms and their explanations.
  ]
)
#lemma_bx(num: "1.1.2", name: lorem(5), [#lorem(40)])
#theorem_bx(num: none, name: lorem(5), [#lorem(40)])
#example_bx(num: "a.b.1", name: lorem(5), [#lorem(500)])
#proof_bx(num: none, name: lorem(5), [#lorem(40)])
#explanation_bx(num: none, name: lorem(5), [#lorem(40)])

#image_array(
  (
    (image: "images/background1.png", caption: "Sample Image 1", width: 80%),
    (image: "images/background2.png", caption: "Sample Image 2"),
    (image: "images/background2.png", caption: "Sample Image 3"),
  ),
  main_caption: [Overview of the electromagnetic fields],
  ncols: 2,
)
#image_array(
  (
    (image: "images/background1.png", caption: "Sample Image 1", width: 80%),
    (image: "images/background2.png", caption: "Sample Image 2"),
  ),
  main_caption: [Overview of the electromagnetic fields],
  ncols: 2,
)

#object_array(
  (
    figure(
      image("images/background1.png"),
      caption: [#lorem(30)]
    ),
    figure(
      image("images/background2.png"),
      caption: [Sample Image 2]
    ),
    figure(
      image("images/background2.png"),
      caption: [Sample Image 3]
    ),
    figure(
      image("images/background2.png"),
      caption: [Sample Image 3]
    ),
    figure(
      image("images/background2.png"),
      caption: [Sample Image 3]
    )
  )
)

#image_array(
  (
    (image: "images/background1.png", caption: "Sample Image 1", width: 80%),
    (image: "images/background2.png", caption: "Sample Image 2"),
  ),
  main_caption: [Overview of the electromagnetic fields],
  ncols: 2,
)

#image_array(
  (
    (image: "images/background1.png", caption: "Sample Image 1", width: 80%),
    (image: "images/background2.png", caption: "Sample Image 2"),
  ),
  main_caption: [Overview of the electromagnetic fields],
  ncols: 2,
)