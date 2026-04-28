#import "../lib.typ": *
#set page(width: 15cm, margin: 1cm, height: auto)
#set par(first-line-indent: (amount: 2em, all: true), spacing: 1.5em)

#set block(stroke: red)// debug
#let test = [
  #table(
    columns: 4,
    [
      #lorem(2)
      $
        a^2 + b^2 = c^2
      $
      #lorem(2)
    ],
    [
      #lorem(2)

      $
        a^2 + b^2 = c^2
      $

      #lorem(2)],
    [
      #block[#lorem(2)]
      $
        a^2 + b^2 = c^2
      $
      #block[#lorem(2)] // not processed
      #lorem(2)
      + #lorem(2)
      - #lorem(2)
      #lorem(2)
    ],
    [
      #block[#lorem(2)]

      $
        a^2 + b^2 = c^2
      $
      #block[#lorem(2)]
      #lorem(2)

      + #lorem(2)

      - #lorem(2)

      #lorem(2)
    ],
  )
]


#[
  `apply-elem: "all"`
  #show: par-indent.with(use-par-leading: (apply-elem: "all"))

  #test
]


#[
  `block-text-leading: (list, enum, terms, math.equation)`
  #show: par-indent.with(use-par-leading: (block-text-leading: (list, enum, terms, math.equation)))

  #test
]

#[
  `block-block-leading: (list, enum, terms, math.equation)`
  #show: par-indent.with(use-par-leading: (block-block-leading: (list, enum, terms, math.equation)))

  #test
]

#[
  `text-block-leading: (list, enum, terms, math.equation)`
  #show: par-indent.with(use-par-leading: (text-block-leading: (list, enum, terms, math.equation)))

  #test
]
