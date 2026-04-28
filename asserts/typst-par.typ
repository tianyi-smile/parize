#set par(first-line-indent: (amount: 2em, all: true))
#set page(width: 15cm, margin: 1cm, height: auto)
#block(stroke: red)[
  #lorem(5)

  #[
    #set text(size: 2em)
    #context (h(-par.first-line-indent.amount))#lorem(5)
  ]
  #lorem(6)
]

#block(stroke: red)[
  #lorem(5)
  
  #[
    #set text(size: 2em)
    #context (h(-par.first-line-indent.amount))#lorem(5)
  ]

  #lorem(6) 
]
