#import "../../templates/template_formulaire_gen2.typ": *

#show: formulaire.with(
  course: "LELEC2796 - Wireless Communcations",
  authors: [Victor Carballes],
  layout: "horizontal", // Use "vertical" for portrait A4 with two columns.
  front_page: false,
)

= Test

#bibliography(
  "./lelec2796_bib.bib",
  title: [References],
  full: true,
)
