#import "../lib.typ": *

#set page(width: 12cm, margin: 1cm, height: auto)

#[

  #show "Test figure": set text(fill: red) // debug
  #show "par-spacing": set text(fill: blue) // debug
  #show "par-leading": set text(fill: green) // debug

  #set par(first-line-indent: (amount: 2em, all: false), spacing: 1.5em)
  #table(
    columns: (1fr,) * 2,
    [
      #show: par-indent.with(
        include-elem: (block,),
        use-par-leading: (
          block-text-leading: (block,),
          text-block-leading: (block, figure),
        ),
      )

      #show figure: it => it.body

      // `par-indent` receives `figure.body`, so it applies to `block`'s rules

      #lorem(6) par-leading
      #figure()[
        #parize-par-above-flag
        Test figure
        #parize-par-below-flag
      ]<fig:test1>
      unindented + par-leading #lorem(2)

      Ref test: @fig:test1.

      #lorem(5) par-spacing

      #figure()[
        #parize-par-above-flag
        Test figure
        #parize-par-below-flag
      ]

      indented + par-spacing #lorem(2)

    ],
    [
      #show figure: it => it.body

      #show: par-indent.with(
        include-elem: (block,),
        use-par-leading: (
          block-text-leading: (block,),
          text-block-leading: (block, figure),
        ),
      )

      // `par-indent` recognizes `figure` as a block-level element, so it applies to `figure`'s rules

      #lorem(6) par-leading
      #figure()[
        #parize-par-above-flag
        Test figure
        #parize-par-below-flag
      ]<fig:test2>
      unindented + par-spacing #lorem(2)

      Ref test: @fig:test2.

      #lorem(5) par-spacing

      #figure()[
        #parize-par-above-flag
        Test figure
        #parize-par-below-flag
      ]

      unindented + par-spacing #lorem(5)
    ],
  )
]
