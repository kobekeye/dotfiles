#import "@preview/theorion:0.4.1": *
#show link: it => underline(it)
#let add(a, b) = a + b
#let tt = sym.arrows.tt
#let bb = sym.arrows.bb
#let inf = sym.infinity
#let bf(x) = $bold(upright(#x))$
#let bu = $bf(u)$
#let bv = $bf(v)$
#let bw = $bf(w)$
#let bx = $bf(x)$
#let rank = $"rank"$
#let nullity = $"nullity"$
#let adj = $"adj"$
#let cdots = $dots.h.c$
#let vdots = $dots.v$
#let dmat(..args) = $display(mat(..args))$
#let dvec(..args) = $display(vec(..args))$
#let det(..args) = $display("det"dmat(..args))$
#let detabs(..args) = $display(mat(delim: "|", ..args))$
#let answer = solution.with(title: "Answer")
// #let solution = proof.with(title: "Solution")
#let mynumstyle() = {
  set heading(
    numbering: "§1.1",
    outlined: false
  )
  
  // 使用 show 規則來自定義標題顯示，讓編號變成紅色
  show heading: it => {
    // 獲取編號
    let number = if it.numbering != none {
      numbering(it.numbering, ..counter(heading).at(it.location()))
    }
    
    // 如果有編號，就用紅色顯示編號，然後是正常顏色的標題文字
    if number != none {
      [#text(fill: red)[#number] #it.body]
    } else {
      it.body
    }
  }
}
#let mytitle(object) = {
  // 設定接下來的 heading 樣式
  set heading(
    level: 1, // 只對 level 1 標題生效
    numbering: none, // 如果不想要編號
    outlined: false
  )
  // 設定文字樣式
  set text(
    fill: rgb("#0fadb8"), 
    weight: "bold",       
    size: 17pt            
  )
  set align(center)
  // 產生標題
  heading(object)
}
#let mysubtitle(object) = {
  set heading(
    level: 1, // 只對 level 1 標題生效
    numbering: none, // 如果不想要編號
    outlined: false
  )
  set text(
    fill: rgb("#000000"), 
    weight: "bold",       
    size: 10pt            
  )
  set align(center)
  heading(object)
}
#let myauthor(object) = {
  set heading(
    outlined: false,
    numbering: none
  )
  set text(
    weight: "bold",
    size: 11pt
  )
  set align(center)
  // 攔截所有中文字，將其設定回一般粗細
  show regex("\p{Han}"): set text(weight: "regular")
  heading(object) 
}