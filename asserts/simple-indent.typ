#[
  #import "../src/parize.typ": par-indent
  #set page(width: 12cm, margin: 1cm, height: auto)
  #show: par-indent.with(include-elem: (list, enum, terms, math.equation))
  #let test-unindent = [
    #lorem(2)
    + #lorem(2)
    + #lorem(2)
    #lorem(2) unindent

    #lorem(2)

    $
      a^2 + b^2 = c^2
    $
    #lorem(2) unindent

    #lorem(2)
  ]
  #let test-indent = [
    #lorem(2)
    + #lorem(2)
    + #lorem(2)

    #lorem(2) indent

    #lorem(2)

    $
      a^2 + b^2 = c^2
    $

    #lorem(2) indent

    #lorem(2)
  ]
  #table(
    columns: (1fr, 1fr),
    [
      #set par(first-line-indent: (amount: 2em, all: true))
      #test-unindent

      #line(length: 100% + 10pt, start: (-5pt, 0pt))

      #set par(first-line-indent: (amount: 2em, all: false))
      #test-unindent
    ],
    [
      #set par(first-line-indent: (amount: 2em, all: true))
      #test-indent

      #line(length: 100% + 10pt, start: (-5pt, 0pt))

      #set par(first-line-indent: (amount: 2em, all: false))
      #test-indent
    ],
  )
]
