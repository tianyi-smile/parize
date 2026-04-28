#import "../lib.typ": *
#set page(width: 12cm, margin: 1cm, height: auto)
#set par(first-line-indent: (amount: 2em, all: true), spacing: 1.5em)

#[
  #show: par-indent.with(use-par-leading: (apply-elem: (block /*other block-level elements*/,)))
  #let pad-wrapper = pad(y: 1em, lorem(2))
  #table(
    columns: (1fr,) * 2,
    [
      #set block(stroke: red) // debug
      #lorem(2)
      #pad-wrapper
      #pad-wrapper
      #lorem(2)

      #lorem(2)
      #parize-block(width: 100%, [#pad-wrapper])
      #parize-block(width: 100%, [#pad-wrapper])
      #lorem(2)
    ],
    [
      #set block(stroke: red) // debug
      #lorem(2)

      #pad-wrapper

      #pad-wrapper

      #lorem(2)

      #lorem(2)

      #parize-block(width: 100%, [#pad-wrapper])
      
      #parize-block(width: 100%, [#pad-wrapper])

      #lorem(2)
    ],
  )
]
