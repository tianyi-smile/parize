// #import "@preview/parize:0.2.0": *

#import "../lib.typ": *

#set page(margin: 1cm, height: auto, width: 25cm)

#table(
  columns: (1fr, 1fr),

  [
    #import "@preview/zebraw:0.6.3": *
    #show: zebraw
    ```typst
    #import "@preview/parize:0.2.0": *
    #set par(first-line-indent: (amount: 2em, all: true))
    #show strong: set text(fill: red, size: 1.2em) // debug
    #set block(stroke: red) // debug
    #show: par-indent.with(
      include-elem: (), // Enable paragraph indentation control for all block-level elements
      use-par-leading: (
        text-block-leading: (math.equation,),
        block-text-leading: (list, enum, terms, math.equation),
      ),
    )

    _Equation Test_. #lorem(8) *par.leading* // no parbreak after
    $
      a^2 + b^2 = c^2
    $
    *Unindented + par.leading* #lorem(10) // Paragraph following equation without empty line

    _Equation Test_. #lorem(8) *par.spacing*

    $
      a^2 + b^2 = c^2
    $

    *Indented + par.spacing* #lorem(10)
    ```
  ],
  [
    #set par(first-line-indent: (amount: 2em, all: true))
    #show strong: set text(fill: red, size: 1.2em) // debug
    #set block(stroke: red) // debug
    #show: par-indent.with(
      use-par-leading: (
        text-block-leading: (math.equation,),
        block-text-leading: (list, enum, terms, math.equation),
      ),
    )
    _Equation Test_. #lorem(8) *par.leading* // no parbreak after
    $
      a^2 + b^2 = c^2
    $
    *Unindented + par.leading* #lorem(10) // Paragraph following equation without empty line


    _Equation Test_. #lorem(8) *par.spacing*

    $
      a^2 + b^2 = c^2
    $

    *Indented + par.spacing* #lorem(10)
  ],
)


