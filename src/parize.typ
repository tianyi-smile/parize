
/// Internal label for vertical block markers.
#let v-block-label = label("__cdl_v_block_flag__")

/// Internal label for `parize` block markers (used for `parize-block`, `parize-par-above-flag`, `parize-par-below-flag).
#let parize-block-label = label("__cdl_parize_block_flag__")

/// If you do not want certain elements to be processed by `par-indent`, you can use this label to mark them.
#let prevent-recursion-label = label("__cdl_prevent-label__")

/// A marker placed below a paragraph to signal that the following block should be
/// spaced with `par.leading` (no empty line between them).
#let parize-par-below-flag = [#block(below: auto, above: 0pt, width: 0pt, height: 0pt, none)#parize-block-label]

/// A marker placed above a paragraph to signal that the preceding block should be
/// spaced with `par.leading` (no empty line between them).
#let parize-par-above-flag = [#block(below: 0pt, above: auto, width: 0pt, height: 0pt, none)#parize-block-label]

/// Wraps content in a block that is recognized by the `parize` system (for `Paragraph Spacing`). `block`, `pad`, `grid`, `stack` are not supported for `Paragraph Spacing` feature; if yout want, then wrap them in `parize-block`; in addition, add `block` to `apply-elem` (or `block-text-leading`, `block-block-leading` and `text-block-leading`) to enable `Paragraph Spacing` for `parize-block`. Example:
/// ```typst
/// #show: par-indent.with(use-par-leading: (apply-elem: (block, /*other block-level elements*/)))
/// #let pad-wrapper = pad(y: 1em, lorem(2))
/// #lorem(2)
/// #parize-block(width: 100%, [#pad-wrapper])
/// #parize-block(width: 100%, [#pad-wrapper])
/// #lorem(2)
/// ```
/// - body (content): The content to wrap.
/// - ..block-args (any): Additional arguments passed to the underlying `block`.
///
/// -> content
#let parize-block(body, ..block-args) = {
  [#block(..block-args, body)#parize-block-label]
}

/// layout constructor
#let func-layout = [#layout(_ => none)].func()

/// Elements that can be block‑level via a `block: true` attribute.
#let block-attributes-elem = (
  math.equation,
  raw,
  quote,
)

/// Block‑level elements that are eligible for `par.leading` spacing.
///
/// Basic elements (`grid`, `stack`, `pad`) are excluded; `block` is only
/// considered when it carries the `parize‑block`.
/// If Typst ≥ 0.14, `title` is also included.
#let leading-elem = (
  (
    //
    figure,
    //
    heading,
    //
    table,
    //
    // grid, // basic elem
    // stack,  // basic elem
    //
    block, // only for parize-block
    //
    columns,
    func-layout,
    //
    move,
    // pad, // basic elem
    //
    repeat,
    //
    rotate,
    scale,
    skew,
    //
    outline,
    //
    circle,
    ellipse,
    rect,
    square,
    //
    curve,
    image,
    line,
    polygon,
    //
    list,
    enum,
    terms,
  )
    + block-attributes-elem
    + if sys.version >= version(0, 14, 0) { (title,) }
)

/// Create a vertical spacing block with a special label for detection.
///
/// This function creates an invisible block element with the `v-block-label` that can be
/// used to inject vertical spacing (above/below) into the document flow. The block is
/// zero-sized but affects spacing through its `above` and `below` properties.
/// - below (length): Spacing below the block (default: 0pt)
/// - above (length): Spacing above the block (default: 0pt)
/// - debug-body (content): Optional debug content to display (default: none)
/// -> content: A labeled block element that affects vertical spacing
#let v-block(below: 0pt, above: 0pt, debug-body: none) = {
  return [#block(
      above: above,
      below: below,
      height: 0pt,
      width: 0pt,
      debug-body,
    )#v-block-label]
}

/// Selector for block elements marked with the parize-block-label.
///
/// This selector identifies block elements that have been processed by the parize system
/// and marked with the `parize-block-label`. These blocks are treated specially in
/// paragraph spacing calculations.
#let sel-parize-block = selector(block.where(label: parize-block-label))

/// State variable to track nested usage of `par-indent`.
#let nested-state = state("__cdl_nested_state__", false)

/// Tuple of all native block‑level elements (exclude `block`) recognized by Typst.
#let block-level-elem = (
  (
    //
    figure,
    heading,
    //
    table,
    grid,
    //
    // block, //
    //
    align,
    columns,
    func-layout,
    // v,
    //
    move,
    pad,
    // place,
    //
    repeat,
    //
    rotate,
    scale,
    skew,
    stack,
    //
    outline,
    //
    circle,
    ellipse,
    rect,
    square,
    //
    curve,
    image,
    line,
    polygon,
    //
    enum,
    list,
    terms,
  )
    + block-attributes-elem
    + if sys.version >= version(0, 14, 0) { (title,) }
)

/// Selector for block-level elements (exclude `block`)
#let block-level-sel = block-level-elem.map(e => if e in block-attributes-elem { e.where(block: true) } else if e
  == figure {
  e.where(placement: none)
} else {
  selector(e)
})

/// Selector for all block-level elements (exclude `block`)
#let all-block-level-sel = block-level-sel.fold(selector, (acc, sel) => { acc.or(sel) })

/// ParType
#let ParType = (
  native: -3,
  default: -2,
  parbreak: -1,
  block: 0,
  non-tight-list-parbreak: 1,
)

/// ParType state
/// - data: par-type (ParType), below (tract the below spacing of block-level elements), tight (track the tightness of lists)
/// - backup: backup data (used for `place` and `figure.placement != none`)
#let par-type-state = state("__cdl_par_type__", (data: (par-type: ParType.native), backup: ())); 

/// Update par-type state
#let update-dic(dic: (:), backup: false) = it => {
  if backup == auto {
    // recover, used for `place` and `figure.placement != none`
    it.data = it.backup.pop()
  } else {
    if backup == true {
      // restore, used for `place` and `figure.placement != none`
      it.backup.push(it.data)
      it.data = (par-type: ParType.native)
    } else {
      it.data = dic
    }
  }
  return it
}

/// For `parbreak` and `v`
#let update-parbreak = it => {
  if it.data.par-type == ParType.native {
    return it
  }
  if it.data.at("tight", default: none) == false {
    it.data = (par-type: ParType.non-tight-list-parbreak)
  } else {
    it.data = (par-type: ParType.parbreak)
  }
  return it
}

/// Verify the arguments
#let verify-args(exclude-elem, include-elem, use-par-leading) = {
  assert(
    type(exclude-elem) == array,
    message: "The value of `exclude-elem` should be an array; but find: " + repr(exclude-elem) + ".",
  )
  assert(
    type(include-elem) == array,
    message: "The value of `include-elem` should be an array; but find: " + repr(include-elem) + ".",
  )

  let assert-elem(elems, supported-elems) = if type(elems) == array {
    let unsuppted-elem = none
    let result = for e in elems {
      if e == layout {
        e = func-layout
      }
      if e not in supported-elems {
        unsuppted-elem = e
        false
        break
      }
    }
    (result == none, unsuppted-elem)
  } else {
    (elems == "all", auto)
  }

  let _exclude-elem = ()
  let _include-elem = ()
  if include-elem != () {
    assert(
      exclude-elem == (),
      message: "The value of `exclude-elem` should be `()` when `include-elem` is not an empty array.",
    )

    let (is-legal, illegal-e) = assert-elem(include-elem, block-level-elem + (block,))
    assert(is-legal, message: "The value of `include-elem` contains an unsupported element: " + repr(illegal-e) + ".")

    _include-elem = include-elem.map(e => if e == layout {
      func-layout
    } else { e })
  } else {
    let (is-legal, illegal-e) = assert-elem(exclude-elem, block-level-elem + (block,))
    assert(is-legal, message: "The value of `exclude-elem` contains an unsupported element: " + repr(illegal-e) + ".")
    _exclude-elem = exclude-elem.map(e => if e == layout {
      func-layout
    } else { e })
  }


  let block-text-leading = ()
  let text-block-leading = ()
  let block-block-leading = ()
  let apply-elem = ()

  if type(use-par-leading) == dictionary {
    let parse-par-leading = use-par-leading
    block-text-leading = parse-par-leading.remove("block-text-leading", default: ())
    block-block-leading = parse-par-leading.remove("block-block-leading", default: ())
    text-block-leading = parse-par-leading.remove("text-block-leading", default: ())
    apply-elem = parse-par-leading.remove("apply-elem", default: ())
    for (elems, name) in (
      (block-text-leading, "block-text-leading"),
      (block-block-leading, "block-block-leading"),
      (text-block-leading, "text-block-leading"),
      (apply-elem, "apply-elem"),
    ) {
      let (is-legal, illegal-e) = assert-elem(elems, leading-elem)
      assert(
        is-legal,
        message: if illegal-e == auto {
          "The value of " + repr(name) + " should be an array or a string \"all\"; but find: " + repr(elems) + "."
        } else {
          "Find unpported block-level element in " + repr(name) + ": " + repr(illegal-e) + "."
        },
      )
    }
    assert(
      parse-par-leading == (:),
      message: "
          The key value should be: `block-text-leading`, `block-block-leading`, `text-block-leading`, and `apply-elem`; but find: "
        + parse-par-leading.keys().join(", ", last: " and ")
        + ".",
    )
  } else {
    assert(
      type(use-par-leading) == bool,
      message: "The value of `use-par-leading` should be a `bool` or a `dictionary`; but find: "
        + repr(use-par-leading)
        + ".",
    )

    if use-par-leading == true {
      block-text-leading = (list, enum, terms)
    }
  }


  if apply-elem == "all" {
    apply-elem = leading-elem
    block-block-leading = ()
    text-block-leading = ()
    block-text-leading = ()
  } else {
    if block-block-leading == "all" {
      block-block-leading = leading-elem
    }
    if text-block-leading == "all" {
      text-block-leading = leading-elem
    }
    if block-text-leading == "all" {
      block-text-leading = leading-elem
    }
  }


  return (
    exclude-elem: _exclude-elem,
    include-elem: _include-elem,
    block-block-elem: block-block-leading,
    text-block-elem: text-block-leading,
    block-text-elem: block-text-leading,
    apply-elem: apply-elem,
  )
}


/// The `parize` package provides an experimental feature that allows any block-level element in Typst (except `par` and `align`) to be treated as part of a paragraph.
///
/// This method is the primary entry point of the `parize` package. It processes a document
/// to enable paragraph‑level control over block‑element indentation and, optionally,
/// paragraph‑leading spacing between block elements and paragraphs.
///
/// - doc (content): The document content to process.
/// - exclude-elem (array): Block‑level elements to **exclude** from processing (default: `()`).
/// - include-elem (array): Block‑level elements to **include** for processing (default: `()`). If `include-elem` is not empty, `exclude-elem` is ignored.
/// - use-par-leading (dictionary, bool): Controls whether `par.leading` is used for paragraph spacing.
///   - `false` (default): No `par‑leading` spacing is applied.
///   - `true`: Equivalent to `use-par-leading: (block-text-leading: (list, enum, terms))`.
///   - dictionary with the following keys:
///     - `block-text-leading` (array, "all"): specifies which block-level elements to process when there's no empty line between them and the following paragraph
///     - `text-block-leading` (array, "all"): specifies which block-level elements to process when there's no empty line between them and the preceding paragraph
///     - `block-block-leading` (array, "all"): specifies which block-level elements to process when there's no empty line between them and **above** block-level elements (excluding `par`, `align`, `v`)
///     - `apply-elem` (array, "all"): Specifies which block-level elements to process, affecting `block-text-leading`, `text-block-leading`, and `block-block-leading`.
///    - Values for these keys can be:
///     - `array` whose elements are the following block-level elements:
///       - `figure`, `layout`
///       - `list`, `enum`, `terms`
///       - `heading`, `title`, `outline`, `repeat`
///       - `table`, `columns`
///       - `move`, `rotate`, `scale`, `skew`
///       - `circle`, `ellipse`, `rect`, `square`
///       - `curve`, `image`, `line`, `polygon`
///       - `math.equation`, `raw`, `quote`
///       - `block` (for `parize`'s `parize-block`)
///       - Note that: `block`, `pad`, `grid`, `stack` are not supported directly; wrap them in `parize-block`.
///     - `"all"`: applies to all block-level elements listed above
/// -> content: The processed document content.
#let par-indent(doc, exclude-elem: (), include-elem: (), use-par-leading: false) = {
  context {
    if nested-state.get() {
      panic("This method cannot be used in a nested manner.")
    }
  }


  let (exclude-elem, include-elem, block-block-elem, text-block-elem, block-text-elem, apply-elem) = verify-args(
    exclude-elem,
    include-elem,
    use-par-leading,
  )

  let text-block-leading(e) = (
    apply-elem.contains(e) or text-block-elem.contains(e) or e in (list, enum, terms)
  )
  let block-block-leading(e) = (
    apply-elem.contains(e) or block-block-elem.contains(e)
  )
  let block-text-leading(e) = (
    apply-elem.contains(e) or block-text-elem.contains(e)
  )

  let is-parred-elem(e) = if include-elem == () {
    not e in exclude-elem
  } else {
    e in include-elem
  }

  let none-par-type = (par-type: ParType.native)


  show selector(parbreak).or(v): it => {
    it
    par-type-state.update(update-parbreak)
  }

  show block: it => {
    if it.body == auto or it.has("label") and it.label == v-block-label {
      return it
    }
    let is-parize-block = it.has("label") and it.label == parize-block-label
    par-type-state.update(update-dic(dic: none-par-type))

    // paragraph spacing
    if is-parize-block and it.above == auto {
      let is-text-block-leading = text-block-leading(block)
      let is-block-block-leading = block-block-leading(block)
      if is-text-block-leading or is-block-block-leading {
        let (par-type, ..leading-args) = par-type-state.get().data
        if is-text-block-leading {
          if par-type == ParType.default {
            if leading-args.at("below", default: none) == none {
              v-block(above: par.leading)
            }
          }
        }
        if is-block-block-leading {
          if par-type == ParType.block {
            let is-tight-list = leading-args.at("tight", default: none) in (none, true)
            if leading-args.at("below", default: none) == auto and is-tight-list {
              v-block(above: par.leading)
            }
          }
        }
      }
    }

    it

    if is-parize-block and text-block-leading(block) {
      par-type-state.update(update-dic(dic: (par-type: ParType.block, below: it.below)))
    } else {
      if is-parred-elem(block) {
        par-type-state.update(update-dic(dic: (par-type: ParType.block)))
      } else {
        // should need? users may override the element
        par-type-state.update(update-dic(dic: none-par-type))
      }
    }
  }


  show all-block-level-sel: it => {
    if it.has("label") and it.label == prevent-recursion-label {
      // only for pad
      return it
    }

    let e = it.func()

    let is-list = e in (list, enum, terms)

    let tight = if is-list {
      (tight: it.tight)
    } else {
      (:)
    }


    // paragraph spacing
    context if block.above == auto and (if is-list { it.tight } else { true }) {
      let is-text-block-leading = text-block-leading(e)
      let is-block-block-leading = block-block-leading(e)
      if is-text-block-leading or is-block-block-leading {
        let (par-type, ..leading-args) = par-type-state.get().data
        if is-text-block-leading {
          if par-type == ParType.default {
            if leading-args.at("below", default: none) == none {
              v-block(above: par.leading)
            }
          }
        }
        if is-block-block-leading {
          if par-type == ParType.block {
            let is-tight-list = leading-args.at("tight", default: none) in (none, true)
            if leading-args.at("below", default: none) == auto and is-tight-list {
              v-block(above: par.leading)
            }
          }
        }
      }
    }


    if e == figure and it.placement != none {
      par-type-state.update(update-dic(backup: true))
      it
      par-type-state.update(update-dic(backup: auto))
    } else {
      par-type-state.update(update-dic(dic: none-par-type))

      it

      if block-text-leading(e) {
        par-type-state.update(update-dic(dic: (par-type: ParType.block, below: block.below) + tight))
      } else {
        if is-parred-elem(e) {
          par-type-state.update(update-dic(dic: (par-type: ParType.block)))
        } else {
          par-type-state.update(update-dic(dic: none-par-type))
        }
      }
    }
  }

  show place: it => {
    par-type-state.update(update-dic(backup: true))
    it
    par-type-state.update(update-dic(backup: auto))
  }

  show par: it => {
    let (amount, all) = it.first-line-indent
    let (par-type, ..leading-args) = par-type-state.get().data
    let par-leading-block = {
      let is-below-auto = leading-args.at("below", default: none) == auto
      let is-tight-list = leading-args.at("tight", default: none) in (none, true)
      if is-below-auto and is-tight-list {
        v-block(below: par.leading)
      }
    }
    if all {
      if par-type == ParType.block or par-type == ParType.non-tight-list-parbreak {
        par-leading-block
        show pad: set block(
          spacing: auto,
          stroke: none,
          fill: none,
          inset: 0pt,
          outset: 0pt,
          breakable: true,
          height: auto,
          width: auto,
          radius: 0pt,
        )
        let hanging = if text.dir == rtl { (right: it.hanging-indent) } else { (left: it.hanging-indent) }
        [#pad(rest: 0pt, [#h(-it.hanging-indent)#it.body], ..hanging)#prevent-recursion-label]
        // par(first-line-indent: 0pt)[#it.body]
      } else {
        it
      }
    } else {
      if par-type == ParType.parbreak {
        par(first-line-indent: (amount: amount, all: true))[#it.body]
      } else {
        par-leading-block
        it
      }
    }

    par-type-state.update(update-dic(dic: (par-type: ParType.default)))
  }
  nested-state.update(true)

  doc

  nested-state.update(false)
}
