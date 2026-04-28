#import "../lib.typ": *

#[
  #set page(width: 15cm, margin: 1cm, height: auto)
  #set par(first-line-indent: (amount: 2em, all: false))
  #show: par-indent.with(
    include-elem: (list, enum, terms, math.equation),
    use-par-leading: true,
  )
  #table(
    columns: (1fr,) * 3,
    [
      #lorem(2)
      + #lorem(2)
      + #lorem(2)
      #lorem(2)
      - #lorem(2)
      + #lorem(2)
      + #lorem(2)
      #lorem(2)
    ],
    [
      #lorem(2)

      + #lorem(2)
      + #lorem(2)
      #lorem(2)

      - #lorem(2)
      + #lorem(2)
      + #lorem(2)
      
      #lorem(2)
    ],
    [
      #lorem(2)

      + #lorem(2)
      + #lorem(2)

      #lorem(2)

      - #lorem(2)
      + #lorem(2)

      + #lorem(2)

      #lorem(2)
    ],
  )
]
