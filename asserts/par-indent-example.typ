#import "../lib.typ": *
#set page(width: 12cm, margin: 1cm, height: auto)
#set par(first-line-indent: (amount: 2em, all: true))
#set block(stroke: red) // debug
#[
  #show: par-indent.with(exclude-elem: (heading, table))

  exclude-elem: `heading`, `table`

  #table(
    columns: 2,
    [
      = heading
      #lorem(2) indented
      + #lorem(2)
      + #lorem(2)
      #lorem(2) unindented
      #table(
        columns: 2,
        [1], [2],
      )
      #lorem(2) indented
      #block()[#lorem(2)]
      #lorem(2) unindented
    ],
    [
      = heading

      #lorem(2) indented
      + #lorem(2)
      + #lorem(2)

      #lorem(2) indented
      #table(
        columns: 2,
        [1], [2],
      )

      #lorem(2) indented
      #block()[#lorem(2)]

      #lorem(2) indented
    ],
  )
]

#[
  #show: par-indent.with(include-elem: (heading, table))

  include-elem: `heading`, `table`

  #table(
    columns: 2,
    [
      = heading
      #lorem(2) unindented
      + #lorem(2)
      + #lorem(2)
      #lorem(2) indented
      #table(
        columns: 2,
        [1], [2],
      )
      #lorem(2) unindented
      #block()[#lorem(2)]
      #lorem(2) indented
    ],
    [
      = heading

      #lorem(2) indented
      + #lorem(2)
      + #lorem(2)

      #lorem(2) indented
      #table(
        columns: 2,
        [1], [2],
      )

      #lorem(2) indented
      #block()[#lorem(2)]
      #lorem(2) indented
    ],
  )
]
