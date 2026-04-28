#import "../lib.typ": *
#set page(width: 12cm, margin: 1cm, height: auto)
#set par(first-line-indent: (amount: 2em, all: true), spacing: 1.5em)


#[
  #set block(stroke: red) // debug
  #show: par-indent
  #let theorem(doc) = {
    let number = context counter(figure.where(kind: "thm")).display("1.")
    figure(
      kind: "thm",
      supplement: "Theorem",
      block(
        stroke: (left: 4pt + blue, rest: 1pt + blue),
        inset: 5pt,
        width: 100%,
        {
          parize-par-above-flag // `parize-par-above-flag` is used to prevent the first paragraph from being indented.
          set align(left)
          [
            #set text(size: 1.5em, fill: blue)
            #strong[Theorem #number]
          ]
          h(.65em, weak: true)
          doc
        },
      ),
    )
  }

  #theorem[
    #lorem(10)
    $
      a^2 + b^2 = c^2
    $

    #lorem(2)
  ]
  #lorem(2) no-indent // Here, paragraph is not indented due to `par-indent` applying to the element `figure`.

  #theorem[
    #lorem(2)
    $
      a^2 + b^2 = c^2
    $
    #lorem(2)
  ]

  #lorem(2) indent
]
