#import "../lib.typ": *
#set page(width: 12cm, margin: 1cm, height: auto)
#set page(width: 12cm, margin: 1cm, height: auto)
#set par(first-line-indent: (amount: 2em, all: true), spacing: 1.5em)
#set block(stroke: red)
#show: par-indent.with(use-par-leading: (apply-elem: (block, math.equation)))
#[
  #lorem(2)
  #table(
    columns: 2,
    [#lorem(2)], [#lorem(2)],
  )
  #lorem(2) par-leading // uses `par-leading` below
  #parize-par-above-flag // if a block-level element in `context` requires `par-leading`, add `parize-par-above-flag` and include `block` in `apply-elem` (or `block-block-leading`, `text-block-leading`)
  #context [
    #parize-par-above-flag
    ```typst
    #let template(doc) = ...
    ```
    #lorem(2)
    $
      a^2 + b^2 = c^2
    $
  ]
  #parize-par-below-flag // if the last element in `context` is block-level, add `parize-par-below-flag`; include `block` in `apply-elem` (`block-text-leading`) for `par-leading` between it and next paragraph
  #lorem(2) par-leading // uses `par-leading` above
]
#line(length: 100%)
#[
  #lorem(2)
  #table(
    columns: 2,
    [#lorem(2)], [#lorem(2)],
  )

  #lorem(2) indent and par-spacing

  #parize-par-above-flag
  #context [
    #parize-par-above-flag
    ```typst
    #let template(doc) = ...
    ```
    #lorem(2)
    $
      a^2 + b^2 = c^2
    $
  ]
  #parize-par-below-flag

  #lorem(2) indent and par-spacing
]

#line(length: 100%)

#[
  #lorem(2)
  #table(
    columns: 2,
    [#lorem(2)], [#lorem(2)],
  )
  #lorem(2)
  #context [
    #lorem(2) // if the first element in `context` is inline-level and preceded by inline-level, this is fine; usually no `parize-par-above-flag` needed
    $
      a^2 + b^2 = c^2
    $
    #lorem(2) // if the last element in `context` is inline-level, this is fine; usually no `parize-par-below-flag` needed
  ]

  #lorem(2)
]

#line(length: 100%)

#[
  #lorem(2)
  #table(
    columns: 2,
    [#lorem(2)], [#lorem(2)],
  )
  #parize-par-above-flag
  #context [
    #parize-par-above-flag
    #lorem(2)
    $
      a^2 + b^2 = c^2
    $
    #lorem(2) // this case is fine
  ]
  $
    a^2 + b^2 = c^2
  $
]
