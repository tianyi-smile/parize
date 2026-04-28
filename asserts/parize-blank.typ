#import "../lib.typ": *
#set page(width: 12cm, margin: 1cm, height: auto)
#set par(first-line-indent: (amount: 2em, all: true), spacing: 1.5em)

#[
  #set block(stroke: red) // debug
  #show: par-indent

  #table(
    columns: (1fr,) * 2,
    [
      #block(lorem(2))
      #context [#text.size] // incorrect
      #lorem(2)

    ],
    [
      #block(lorem(2))
      #parize-blank #context [#text.size] // correct
      #lorem(2)
    ],
  )
]
