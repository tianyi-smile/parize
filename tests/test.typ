#import "../lib.typ": *
#set block(stroke: red)
#show : par-indent.with(use-par-leading: true)
#set par(first-line-indent: (amount: 2em, all: true))
#lorem(20)
+ 1111
+ 2222
11111111

\

#block[??????]
#lorem(20)
#block[??????]

#linebreak()
#block[??????]
#lorem(20)