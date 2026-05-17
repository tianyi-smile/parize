#import "@preview/touying:0.7.3": *
#import themes.university: *
#import "../lib.typ": *

#show: university-theme.with(config-page(margin: 1cm, width: 15cm, height: auto))
#set par(first-line-indent: (amount: 2em, all: false))


#let par-indent-slide(body, ..args) = {
  slide(
    {
      show: par-indent
      parize-par-above-flag
      body
    },
    ..args,
  )
}

#par-indent-slide[
  *Proof*. #lorem(6) // no-indent

  StepI. #lorem(5) .... // indent
]

#par-indent-slide[

  StepN. #lorem(5) .... // indent

  Final. #lorem(5) .... // indent
]
