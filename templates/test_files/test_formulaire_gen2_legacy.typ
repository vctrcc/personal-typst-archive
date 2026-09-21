#import "../template_formulaire_gen2.typ": *
#import "../template_formulaire_gen2_legacy_wrapper.typ": *

#show: legacy_formulaire.with(
  course: "TEST0000 - Legacy wrapper",
  author: "Legacy Author",
)

= Legacy API

#fixedbox("Fixed result")[Legacy fixed box.]
#theorybox("Theory")[Legacy theory box.]
#exercisebox("Exercise")[Legacy exercise box.]
#examplebox("Example")[Legacy example box.]
#proofbox("Proof")[Legacy proof box.]
#exambox("Exam")[Legacy exam box.]
#warningbox("Warning")[Legacy warning box.]
#todobox("Todo")[Legacy TODO box.]
#subbox("Sub-box")[Legacy nested box.]
#eqbox(label: [Legacy equation])[$H(X) >= 0$]
#diagMath[$X arrow.r Y$]
#diagBox(title: [Legacy diagram])[$X arrow.r Y$]
