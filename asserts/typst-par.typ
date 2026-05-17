#set par(first-line-indent: (amount: 2em, all: true))
#set page(width: 15cm, margin: 1cm, height: auto)


= use `#context (h(-par.first-line-indent.amount))`

#block(stroke: red)[
  #lorem(5)

  #[
    #set text(size: 1.5em)
    #rect()[]
    #context (h(-par.first-line-indent.amount))#lorem(5)
  ]
  #lorem(6)
]

#block(stroke: blue)[
  #lorem(5)

  #[
    #set text(size: 1.5em)
    #rect()[]
    #context (h(-par.first-line-indent.amount))#lorem(5)
  ]

  #lorem(6)
]

= use `par-indent`

#import "..\lib.typ": *

#show: par-indent

#block(stroke: red)[
  #lorem(5)

  #[
    #set text(size: 1.5em)
    #rect()[]
    #lorem(5)
  ]
  #lorem(6)
]

#block(stroke: blue)[
  #lorem(5)

  #[
    #set text(size: 1.5em)
    #rect()[]
    #lorem(5)
  ]

  #lorem(6)
]
