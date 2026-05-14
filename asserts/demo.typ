// #import "@preview/parize:0.2.0": *

#import "../lib.typ": *

#set page(margin: 1cm, height: auto, width: 25cm)
#set par(justify: true)


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
      include-elem: (heading, math.equation, list, enum, terms, ), // Enable paragraph indentation control for heading, math.equation, list, enum and terms
      use-par-leading: true, // Enable paragraph spacing control for list, enum and terms
    )
    #set heading(numbering: "1.")
    = Heading

    *Indented* #lorem(10)

    _Equation Test_. #lorem(8)
    $
      a^2 + b^2 = c^2
    $
    *Unindented* #lorem(10)  // This paragraph remains unindented (no parbreak before equation)

    #lorem(2)

    $
      a^2 + b^2 = c^2
    $

    *Indented* #lorem(10)

    _Tight Lists Test_. #lorem(10)
    + #lorem(2)
    + #lorem(2)
    *Unindented and par-leading* #lorem(8)  // Unindented with paragraph-leading spacing

    = Heading
    *Unindented* #lorem(10)

    + #lorem(2)
    + #lorem(2)

    *Indented* #lorem(10)

    _Non-tight Lists Test_. #lorem(2)

    - #lorem(2)

    - #lorem(2)
    *Unindented* #lorem(2)  // Paragraph following lists without empty line
    ```
  ],
  [
    #show strong: set text(fill: red, size: 1.2em) // debug
    #set block(stroke: red) // debug
    #set par(first-line-indent: (amount: 2em, all: true))
    #show: par-indent.with(
      include-elem: (heading, math.equation, list, enum, terms), // Enable paragraph indentation control for heading, math.equation, list, enum and terms
      use-par-leading: true, // Enable paragraph spacing control for list, enum and terms
    )


    #set heading(numbering: "1.")

    = Heading

    *Indented* #lorem(10)

    _Equation Test_. #lorem(8)
    $
      a^2 + b^2 = c^2
    $
    *Unindented* #lorem(10)  // This paragraph remains unindented (no parbreak before equation)

    #lorem(2)

    $
      a^2 + b^2 = c^2
    $

    *Indented* #lorem(10)

    _Tight Lists Test_. #lorem(10)
    + #lorem(2)
    + #lorem(2)
    *Unindented and par-leading* #lorem(8)  // Unindented with paragraph-leading spacing

    = Heading
    *Unindented* #lorem(10)

    + #lorem(2)
    + #lorem(2)

    *Indented* #lorem(10)

    _Non-tight Lists Test_. #lorem(2)

    - #lorem(2)

    - #lorem(2)
    *Unindented* #lorem(2)  // Paragraph following lists without empty line
  ],
)
