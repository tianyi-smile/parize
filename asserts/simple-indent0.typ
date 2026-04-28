#import "../src/parize.typ": (
  par-indent, parize-blank, parize-block, parize-block-label, parize-par-above-flag, parize-par-below-flag,
)
// #import "@preview/layout-ltd:0.1.0": *
// #show: layout-limiter.with(max-iterations: 4)


#[
  #set page(width: 15cm, margin: 1cm, height: auto)
  #show: par-indent.with(include-elem: (list, enum, terms, math.equation))
  #let test-unindent = [
    #lorem(2)
    + #lorem(2)
    + #lorem(2)
    #lorem(2)

    $
      a^2 + b^2 = c^2
    $
    #lorem(2)
  ]
  #let test-indent = [
    #lorem(2)
    + #lorem(2)
    + #lorem(2)

    #lorem(2)

    $
      a^2 + b^2 = c^2
    $

    #lorem(2)
  ]
  #table(
    columns: (1fr, 1fr),
    [
      #set par(first-line-indent: (amount: 2em, all: false))
      #test-unindent

      #set par(first-line-indent: (amount: 2em, all: true))
      #test-unindent
    ],
    [
      #set par(first-line-indent: (amount: 2em, all: false))
      #test-indent

      #set par(first-line-indent: (amount: 2em, all: true))
      #test-indent
    ],
  )
]

#[

]




#[

  #import "../../itemize/0.2.0/lib.typ" as el
  // // #import "@preview/itemize:0.2.0" as el
  #show: el.default-enum-list.with(
    body-format: (
      whole: (stroke: red),
      inner: (stroke: blue),
    ),
    auto-label-width: "all",
  )
  #show: el.config.auto-detect-tight
  #show: el.config.ref.with(full: true)

  #set enum(numbering: "(1).(a)")

  // TODO: use-par-leading 中的元素应该均是 include-elem 中的元素
  // #show math.equation: set block(below: 2em)
  #show: par-indent.with(
    include-elem: (),
    // include-elem: (list, enum, terms, math.equation),
    use-par-leading: (
      // true
      // text-block-leading: (enum, list),
      // block-text-leading: (enum, list, ),
      // block-block-leading: (enum,list, ),
      apply-elem: "all",
      // apply-elem: (list, enum, terms, math.equation),
      // apply-elem: (enum, terms, math.equation),
    ),
  )
  // 1111

  #set par(first-line-indent: 2em)

  // #show grid.where(label: label("__cdl-enum-grid-ID__")): set text(fill: red)

  #block(below: 0pt)[???]
  1111111
  // #set enum(spacing: 2em)
  // #set list(spacing: 2em)
  1111111
  // #enum([1], [2])
  #parize-block(block(stroke: red)[#lorem(2)])
  #align(center, [?????DDD])
  3333333
  // 11111
  #v(2em, weak: true)
  1111111
  #block(stroke: red)[#lorem(2)]#parize-block-label
  #line(length: 100%)
  11111111

  #block(stroke: red)[#lorem(2)]
  #block(stroke: red)[#lorem(2)]
  12222222
  #state("").update("")
  //
  //
  // + 111
  // + 111
  // // - 11111
  // 111
  // + #lorem(2)
  //   111
  //   // - 11111
  //   + 2222
  //   + 2222222
  //   11111
  // + #lorem(2)
  // + 2222
  // 11111
  // - 1111
  // - 222
  #set par(first-line-indent: (amount: 2em, all: true), spacing: 2em)
  33333333
  222
  + 222222
    + 3333
    + 333 <item:a>
  + 2222222
    101. 33333 4444
  #lorem(3)
  #block(stroke: red)[#lorem(2)]
  1
  - 333 @item:a
  - 22
  - 44444444
    - 3333333333
    #lorem(3)
  #parize-blank#context [#lorem(30)]

  #block(stroke: red)[#lorem(2)]
  #block(stroke: red)[#lorem(2)]
  #line()
  1111
  $ a + b $
  111111
  - 1 $vec(1, 1, 1, 1, 1)$

    #lorem(20)
  - 222
  1

  / aab: #lorem(2)
  / acddd: #lorem(3)
  222222
  $
    a + b
  $
  1111122
  #parize-par-above-flag
  #context [
    #parize-par-above-flag
    12222333
    #block([!!!!!])]
  #parize-par-below-flag
  3333333333
]


#[
  #import "../../itemize/0.2.0/lib.typ" as el
  #show: el.default-enum-list.with(
    body-format: (
      whole: (stroke: red),
    ),
  )
  #show: el.config.auto-detect-tight

  #show: par-indent.with(
    // include-elem: (list, enum, terms, math.equation),
    use-par-leading: (
      // true
      // text-block-leading: (enum, list),
      // block-text-leading: (enum, list, ),
      // block-block-leading: (enum,list, ),
      apply-elem: "all",
      // apply-elem: (list, enum, terms, math.equation),
      // apply-elem: (enum, list),
    ),
  )
  1111

  #line(length: 100%)
  + 3333
  - 333333
  - 33333333
  - 2222222
  2222222222



  1
  ????
  - 1111111
  44444
  + 22222
  + 2222
  22222
]

#[
  #set par(first-line-indent: (amount: 2em, all: false))
  #set block(stroke: red) // debug
  #table(
    columns: 2,
    [
      #align(left, [#lorem(2) (no red border)])
      #lorem(2) (indent)
    ],
    [
      #block([#lorem(2)])
      #lorem(2) (no-indent)
    ],
  )
]


#[
  #set par(first-line-indent: (amount: 2em, all: false))
  #show: par-indent.with(use-par-leading: (apply-elem: "all"))

  = 标题

  段落内容

  = 标题
  段落内容
  #block([
    #parize-par-above-flag
    #lorem(10) // no-indent

    #lorem(10)
  ])

]

// #[
//   #set par(first-line-indent: (amount: 2em, all: false))
//   #show: par-indent.with(use-par-leading: (apply-elem: "all"))
//   #set page(height: 160pt, width: 150pt)
//   #lorem(15)

//   #figure(
//     rect(width: 100%, height: 50pt),
//     placement: auto,
//     caption: [A rectangle],
//   )
//   #block[!!!!!!!!!!!]
//   #place.flush()
//   This text appears after the figure.
// ]

// #[
//   #set page(height: 160pt, width: 150pt)
//   #import "../../itemize/0.2.0/lib.typ" as el
//   // // #import "@preview/itemize:0.2.0" as el
//   #show: el.default-enum-list.with(
//     body-format: (
//       whole: (stroke: red),
//       inner: (stroke: blue),
//     ),
//     // auto-label-width: "all",
//   )
//   3333
//   #set figure(placement: auto)
//   + //#place.flush()
//     // 22444
//     // #quote(block: true)[?????? $vec(1,1,1)$]
//     // #figure(
//     //   rect(width: 100%, height: 20pt, fill: red),
//     //   placement: top,
//     //   caption: [A rectangle],
//     // )
//     // #block[!!!!!!!!!!! $vec(1, 1, 1,)$ #lorem(5)]
//     // 22222222222
//     // #block[!!!!!!!!!!!]
//     #place.flush()
//     This text appears after the figure.
// ]

#[

  #set figure(placement: auto)
  #set block(stroke: red)
  // #set quote(block: true)
  #set quote(block: true)

  #set par(first-line-indent: (amount: 2em, all: false))
  #show: par-indent.with(use-par-leading: (apply-elem: "all"))

  111111



  #repr([
    #set quote(block: true)
    22

    333

    555
  ])

  #lorem(2)
  #figure(
    // placement: none,
    [#square(fill: blue, size: 4cm)],
    caption: [Somewhere in the middle.],
  )

  #block([????????????])
  222222222222222
  #place.flush()
  22222

  #lorem(30) // A several page text document.
  #block(stroke: red)[
    #lorem(2)
  ]
  #v(1em)
  // #block(stroke: red)[
  //   #lorem(2)
  // ]
  11111111
  #par[!!!!]
  #align([!!!!])
  This text comes after that block.

  // #pagebreak()

  #lorem(30) // A several page text document.
  // #block(stroke: red)[
  //   #lorem(2)
  // ]
  #v(1em)
  // #align([!!!!])
  This text comes after that block.

  #show quote.where(block: true): set block(spacing: auto)
  #quote([!!!!!!])
  // #block[?????]
  #lorem(2)
  111111
  #{ place.flush().func() }

  #block[
    #quote([!!!!!!])

    1111111
  ]
  111111

  #place(float: true, top)[???????? #rect(fill: red) 333333333]

  #lorem(2)
  兼容包 增强 Enhance
]



#pagebreak()

#[

  #show: par-indent.with(include-elem: (list, enum))
  #show par: block.with(stroke: red)
  #set par(first-line-indent: (amount: 2em, all: true))

  #lorem(2)

  #[
    #set text(size: 2em)
    + #lorem(2)
    #context (h(-par.first-line-indent.amount)) #lorem(2)
  ]
  #lorem(2)

  #[
    #set text(size: 2em)
    #context (h(-par.first-line-indent.amount)) #lorem(2)
  ]

  #lorem(2)

  #block[
    #set text(size: 2em)
    #lorem(2)

    #lorem(2)
  ]
  11111

  #parize-block[
    #set text(size: 2em)
    #lorem(2)

    #lorem(2)
  ]
  11111
]

