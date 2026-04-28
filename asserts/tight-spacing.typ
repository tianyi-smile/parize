#import "../lib.typ": *
#set page(width: 15.5cm, margin: 1cm, height: auto)
#set par(first-line-indent: (amount: 2em, all: true), spacing: 1.5em)
#show enum: set block(stroke: red) // debug

#show: par-indent.with(use-par-leading: true)
#table(
  columns: 4,
  [
    #lorem(2)
    + #lorem(2)
    + #lorem(2)
    #lorem(2)
  ],
  [
    #lorem(2)
    + #lorem(2)
    + #lorem(2)
    
    #lorem(2)
  ],
  [
    #lorem(2)

    + #lorem(2)
    + #lorem(2)
    #lorem(2)
  ],
  [
    #lorem(2)
    + #lorem(2)
    
    + #lorem(2)
    #lorem(2)
  ],
)
