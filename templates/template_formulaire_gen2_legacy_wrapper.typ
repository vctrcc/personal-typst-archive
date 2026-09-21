// ============================================================================
// GEN 2 FORMULAIRE — LEGACY WRAPPER
// ============================================================================
// Import this after the main template only when an older document needs names
// or signatures that are no longer part of the normal Gen 2 API:
//
// #import "template_formulaire_gen2.typ": *
// #import "template_formulaire_gen2_legacy_wrapper.typ": *
//
// This file contains aliases and signature adapters only. Rendering remains in
// `template_formulaire_gen2.typ`.
// ============================================================================

#import "template_formulaire_gen2.typ": (
  result_box,
  theory_box,
  exercise_box,
  example_box,
  proof_box,
  exam_box,
  warning_box,
  todo_box,
  sub_box,
  diagram_box,
  definition,
  intro_page,
  formulaire,
)

// Former concatenated descriptive names.
#let fixedbox = result_box
#let theorybox = theory_box
#let exercisebox = exercise_box
#let examplebox = example_box
#let proofbox = proof_box
#let exambox = exam_box
#let warningbox = warning_box
#let todobox = todo_box
#let subbox = sub_box

// Former definition spelling.
#let defn = definition

// Former singular-author document-wrapper signature. Use this explicitly as
// `#show: legacy_formulaire.with(...)` when migrating an old document.
#let legacy_formulaire(
  title: none,
  course: "Course",
  author: "Your Name",
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
) = formulaire(
  title: title,
  course: course,
  authors: author,
  institution: institution,
  layout: layout,
  hole_punch_preview: hole_punch_preview,
  front_page: front_page,
  details: details,
  show_outline: show_outline,
  outline_depth: outline_depth,
  chapter_new_page: chapter_new_page,
  bibliography_new_page: bibliography_new_page,
  body,
)

// Former singular-author front-page signature.
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

// Former diagram helpers.
#let diagMath(body) = text(size: 11pt)[#body]
#let diagBox(body, title: none, tag: none, tags: ()) = diagram_box(
  body,
  title: title,
  tag: tag,
  tags: tags,
)
