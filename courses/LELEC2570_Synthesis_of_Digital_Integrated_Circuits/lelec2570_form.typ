#import "../../templates/template_formulaire_gen2.typ": *

#show: formulaire.with(
  course: "LELEC2570 - Synthesis of digital integrated circuits (Digital ICs)",
  authors: [Victor Carballes],
  layout: "horizontal", // Use "vertical" for portrait A4 with two columns.
  front_page: false,
)

= Test

#bibliography(
  "./lelec2570_bib.bib",
  title: [References],
  full: true,
)
