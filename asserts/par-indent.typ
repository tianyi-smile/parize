#import "../lib.typ": *
#set par(first-line-indent: (amount: 2em, all: false))
#show: par-indent
#set page(width: 12cm, margin: 1cm, height: auto)
#set block(stroke: red) // debug
= Heading

Paragraph content // indented
= Heading
Paragraph content  // unindented

#block([
  #lorem(12) // unindented (for lists, theorem environments, etc.)

  #lorem(5)
])

// In slide presentations, such as proof steps across multiple slides,
// you might want the first slide's paragraph unindented but subsequent ones indented:
#block([
  #parize-par-above-flag
  Proof. #lorem(12) // unindented

  #lorem(5)
])

#block([
  #parize-par-above-flag

  Following #lorem(12) // indented

  #lorem(5)
])
