#import "@preview/lucide:0.1.0": *
#import "@preview/meander:0.4.4"
#import "@preview/cetz:0.5.2": canvas, draw, decorations
#import "@preview/cetz-plot:0.1.4": plot
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/tiaoma:0.3.0"
#import "@preview/headcount:0.1.1": *
// #import "@preview/hy-dro-gen:0.1.2" as hy

#let cmyk_text = cmyk(0%, 0%, 0%, 100%)
#let cmyk_border = cmyk(0%, 0%, 0%, 33%)
// #let cmyk_purple = cmyk(0%, 100%, 50%, 42%)
// #let cmyk_blue = cmyk(84%, 29%, 0%, 1%)
#let cmyk_purple = cmyk(0%, 100%, 20%, 0%)
#let cmyk_blue = cmyk(100%, 30%, 0%, 0%)
#let cmyk_vermil  = cmyk(0%, 80%, 100%, 0%)
#let cmyk_green = cmyk(97%, 0%, 75%, 10%)

// State bagian buku
#let main-content = state("main-content", false)

#let handout(title: "", author: (), keywords: (), body) = {
  set document(
    keywords: keywords,
    title: title,
    author: author,
    date: datetime.today()
  )
  set text(lang: "id")
  set text(region: "id")
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 2.8cm, inside: 2.4cm, outside: 2cm),
    binding: left,
    numbering: "i",
    footer: context {
      let pg = counter(page).display()
      let ganjil = calc.rem(here().page(), 2) == 1

      line(length: 100%, stroke: 0.4pt + cmyk_border)
      v(-10pt)
      if ganjil [
        #text(size: 9pt)[#document.title]
        #h(1fr)
        #text(size: 9pt)[#pg]
      ] else [
        #text(size: 9pt)[#pg]
        #h(1fr)
        #text(size: 9pt)[#document.title]
      ]
    },
    header: context {
      let is-main = main-content.get()
    
      if is-main {
        let is-opener = query(heading.where(level: 1))
          .any(h => h.location().page() == here().page())
    
        let before = query(heading.where(level: 1).before(here()))
    
        if not is-opener and before.len() > 0 {
          let last-bab = before.last()
          let no = counter(heading).at(last-bab.location()).first()
          let content = [Bab #no: #last-bab.body]
          let odd = calc.rem(here().page(), 2) == 1
    
          if odd [
            #h(1fr)
            #text(size: 9pt)[#content]
          ] else [
            #text(size: 9pt)[#content]
            #h(1fr)
          ]
    
          v(-10pt)
          line(length: 100%, stroke: 0.4pt + cmyk_border)
        }
      }
    }
  )
  set text(font: "Noto Sans", size: 11.5pt, fill: cmyk_text, weight: 350, hyphenate: true)
  set par(justify: true, leading: 0.76em, first-line-indent: 0pt, spacing: 1.7em)
  set figure(
    numbering: dependent-numbering("1.1"),
  )

  show ref: it => {
    let el = it.element

    if el != none and el.func() == math.equation {
      let bab = counter(heading.where(level: 1))
        .at(el.location())
        .first()
  
      let n = counter(math.equation).at(el.location())
      let nomor = numbering("1.1", bab, ..n)
  
      link(el.location(), [Persamaan #nomor])
    } else {
      it
    }
  }
  set math.equation(numbering: none)
  show math.equation: set text(font: "New Computer Modern Math")
  show math.equation: set block(breakable: true)
  show figure.where(kind: table): set block(breakable: true)
  // show heading.where(level: 2): it => context {
  //   if main-content.get(){
  //     set par(leading: 0.5em)
  //     block(width: 100%, above: 28pt, below: 8pt)[
  //       #grid(
  //         columns: (auto, auto),
  //         gutter: 8pt,
  //         align: top,
  //         box(
  //           stroke: cmyk_purple,
  //           radius: 4pt,
  //           inset: (x: 6pt, y: 6pt),
  //         )[
  //           #text(size: 14pt, weight: "bold", fill: cmyk_purple, font: "IBM Plex Sans")[#counter(heading).display("1.1")]
  //         ],
  //         text(size: 24pt, weight: "bold", fill: cmyk_purple, baseline: 2pt)[#it.body]
  //       )
  //     ]
  //     v(10pt)
  //   } else {
  //     it
  //   }
  // }
  
  // show heading.where(level: 3): it => context {
  //   if main-content.get(){
  //     let counts = counter(heading).get()
  //     set par(leading: 0.5em)
  //     block(width: 100%, above: 28pt, below: 4pt)[
  //       #grid(
  //         columns: (auto, auto),
  //         gutter: 8pt,
  //         align: top,
  //         box(
  //           stroke: cmyk_purple,
  //           radius: 4pt,
  //           inset: (x: 6pt, y: 6pt),
  //         )[
  //           #text(size: 10pt, weight: "bold", fill: cmyk_purple, font: "IBM Plex Sans")[#counter(heading).display("1.1")]
  //         ],
  //         text(size: 16pt, weight: "bold", baseline: 3pt)[#it.body]
  //       )
  //     ]
  //     v(10pt)
  //   } else {
  //     it
  //   }
  // }
  
  show figure.caption: it => [
    #set text(size: 10pt)
    #text(fill: cmyk_purple, weight: "bold")[
      #it.supplement #context it.counter.display(it.numbering):
    ] #it.body
  ]

  set outline.entry(fill: line(length: 100%, stroke: 1pt + cmyk_border))

  show outline.entry.where(level: 1): it => {
    if it.element.func() == heading {
      v(0.5em)
      text(weight: "bold", size: 14pt, fill: cmyk_purple)[#it]
    } else {
      it
    }
  }
  set table(stroke: 0.6pt + cmyk_purple.lighten(50%))
  set list(indent: 16pt)

  show cite: set text(fill: cmyk_purple, weight: 450)
  show cite: super

  body
}

#let main-heading-2(it) = {
  set par(leading: 0.5em)
  block(width: 100%, above: 28pt, below: 8pt)[
    #grid(
      columns: (auto, auto),
      gutter: 8pt,
      align: top,
      box(stroke: cmyk_purple, radius: 4pt, inset: (x: 6pt, y: 6pt))[
        #text(size: 14pt, weight: "bold", fill: cmyk_purple, font: "IBM Plex Sans")[
          #context counter(heading).display("1.1")
        ]
      ],
      text(size: 24pt, weight: "bold", fill: cmyk_purple, baseline: 2pt)[#it.body],
    )
  ]
  v(10pt)
}

#let main-heading-3(it) = {
  set par(leading: 0.5em)
  block(width: 100%, above: 28pt, below: 4pt)[
    #grid(
      columns: (auto, auto),
      gutter: 8pt,
      align: top,
      box(stroke: cmyk_purple, radius: 4pt, inset: (x: 6pt, y: 6pt))[
        #text(size: 10pt, weight: "bold", fill: cmyk_purple, font: "IBM Plex Sans")[
          #context counter(heading).display("1.1")
        ]
      ],
      text(size: 16pt, weight: "bold", baseline: 3pt)[#it.body],
    )
  ]
  v(10pt)
}

#let main-body(body) = {
  set heading(numbering: "1.1.1")
  show heading.where(level: 2): main-heading-2
  show heading.where(level: 3): main-heading-3
  main-content.update(true)
  body
  main-content.update(false)
}

#let numeric-page(body) = {
  set page(numbering: "1")
  [#metadata(none) <awal-isi>]
  counter(page).update(1)
  body
}

#let kotak(isi, ikon: none, judul: none, pecah: true) = {
  let garis = 0.8pt + cmyk_border
  let r = 8pt
  let atas = 12pt   // samakan dengan inset top di pecah: false
  let bawah = 16pt  // samakan dengan inset bottom di pecah: false

  let header = if ikon != none or judul != none [
    #grid(
      columns: (auto, 1fr),
      gutter: 0.5em,
      align: horizon,
      if ikon != none [#lucide-icon(ikon, size: 1.2em, fill: cmyk_purple)],
      if judul != none [#text(weight: "bold", fill: cmyk_purple)[#judul]],
    )
  ]

  if not pecah {
    block(
      width: 100%, above: 12pt, below: 12pt,
      inset: (left: 16pt, right: 16pt, top: 12pt, bottom: 16pt),
      stroke: garis, radius: r, breakable: false,
    )[#header #isi]
  } else {
    let m = 2pt  // margin clip supaya stroke tidak terpotong

    block(width: 100%, above: 12pt, below: 12pt, breakable: true, {
      // tutup atas: setengah atas lengkungan
      block(
        width: 100%, height: r, above: 0pt, below: 0pt,
        sticky: true, breakable: false,
        move(dx: -m, dy: -m, block(
          width: 100% + 2 * m, height: r + m, clip: true,
          place(top + left, dx: m, dy: m, block(
            width: 100% - 2 * m, height: 2 * r,
            stroke: garis, radius: r,
          )),
        )),
      )
      // isi: kiri-kanan saja, boleh pecah
      block(
        width: 100%, above: 0pt, below: 0pt, breakable: true,
        inset: (left: 16pt, right: 16pt, top: atas - r, bottom: bawah - r),
        stroke: (left: garis, right: garis),
      )[#header #isi]
      // tutup bawah: setengah bawah lengkungan
      block(
        width: 100%, height: r, above: 0pt, below: 0pt, breakable: false,
        move(dx: -m, block(
          width: 100% + 2 * m, height: r + m, clip: true,
          place(top + left, dx: m, dy: -r, block(
            width: 100% - 2 * m, height: 2 * r,
            stroke: garis, radius: r,
          )),
        )),
      )
    })
  }
}

// #let kotak(isi, ikon: none, judul: none) = block(
//   width: 100%,
//   above: 12pt,
//   below: 12pt,
//   inset: (left: 16pt, right: 16pt, top: 12pt, bottom: 16pt),
//   stroke: 0.8pt + cmyk_border,
//   radius: 8pt,
//   breakable: false,
// )[
//   #if ikon != none or judul != none [
//     #grid(
//       columns: (auto, 1fr),
//       gutter: 0.4em,
//       align: horizon,
//       if ikon != none [
//         #lucide-icon(ikon, size: 1.2em, fill: cmyk_purple)
//       ],
//       if judul != none [
//         #text(weight: "bold", fill: cmyk_purple)[#judul]
//       ],
//     )
//   ]
//   #isi
// ]

#let mengapa(judul: [Mengapa...], isi) = kotak(
  isi, 
  ikon: "message-circle-question-mark", 
  judul: judul
)

#let info(isi) = kotak(
  isi,
  ikon: "info", 
  judul: "Info",
)

#let funfact(isi, pecah: true) = kotak(
  isi,
  ikon: "badge-question-mark", 
  judul: "Fakta Menarik!",
  pecah: pecah,
)

#let tujuan(isi) = kotak(
  isi, 
  ikon: "goal", 
  judul: "Tujuan"
)

#let teorema(isi) = kotak(
  isi,
  ikon: "sigma", 
  judul: "Teorema", 
)

#let contoh(isi) = kotak(
  isi,
  ikon: "list-checks", 
  judul: "Contoh",
)

#let penyelesaian(judul: [Penyelesaian], isi) = kotak(
  isi,
  ikon: "list-checks",
  judul: judul
)

#let latihan(isi) = kotak(
  isi, 
  ikon: "message-circle-question-mark", 
  judul: "Latihan", 
)

#let eksplor(isi, pecah: false) = kotak(
  isi,
  ikon: "telescope", 
  judul: "Eksplor", 
  pecah: pecah
)

#let badge(teks, warna: cmyk_purple) = box(
  stroke: warna + .8pt,
  radius: 999pt,
  inset: (x: 6pt, y: 6pt),
)[
  #text(size: 8pt, weight: 500, fill: warna)[#teks]
]

#let tautan-qr(
  url: "",
  label: "Pindai QR untuk pelajari lebih lanjut",
) = context {
  let qr = tiaoma.barcode(
    url,
    "QRCode",
    options: (
      scale: 2.0,
      fg-color: cmyk_purple,
      output-options: (
        barcode-dotty-mode: true,
      ),
      dot-size: 1.0,
    ),
  )

  let qr-size = measure(qr)

  box(
    width: qr-size.width + 20pt,
    stroke: 0.6pt + cmyk_purple,
    radius: 6pt,
    inset: 10pt,
  )[
    #align(center)[
      #qr
      #text(size: 8pt, fill: cmyk_purple)[
        #label
      ]
    ]
  ]
}

#let eq-numbering = (n) => {
  let bab = counter(heading.where(level: 1))
    .at(here())
    .first()

  numbering("(1.1)", bab, n)
}

#let eq-numbered(body) = math.equation(
  block: true,
  numbering: eq-numbering,
  body,
)

#let badges-row(items) = items.map(badge).join(h(6pt))
#let badges(..items) = [
  #set par(justify: false, leading: 0.6em)
  #items.pos().join(h(4pt))
]

#show heading.where(level: 1): it => { it }

#let c-soal = counter("soal")

// #let bab(
//   judul,
//   deskripsi,
//   gambar,
//   deskr_gambar,
//   sumbr_gambar,
//   kata-kunci: (),
// ) = {
//   show heading.where(level: 1): it => context {
//     c-soal.update(0)
//     pagebreak(to: "even", weak: true)

//     main-content.update(true) 
//     // Reset hitungan (x.x) pada figure dan persamaan
//     counter(figure.where(kind: image)).update(0)
//     counter(figure.where(kind: table)).update(0)
//     counter(math.equation).update(0)

//     // buat box detail ini tidak ikut flow, tetapi tepat di pinggir kiri halaman, dan box ini akan berisi angka untuk bab, dan daftar isi sekilas.
//     box(width: 4em, height: 2em, fill: cmyk_purple)

//     // margin kiri = box detail + 1em
//     grid(
//       columns: (auto, 1fr),
//       gutter: 14pt,
//       align: horizon,
//       box(
//         stroke: cmyk_purple,
//         radius: 8pt,
//         inset: (x: 16pt, y: 10pt),
//       )[
//         #text(
//           size: 28pt,
//           weight: "bold",
//           fill: cmyk_purple,
//           font: "IBM Plex Sans",
//         )[
//           #counter(heading).display()
//         ]
//       ],
//       text(
//         size: 42pt,
//         fill: cmyk_purple,
//         weight: "bold",
//       )[
//         #it.body
//       ],
//     )

//     v(1em)

//     text(
//       size: 12pt,
//       weight: 350,
//     )[
//       #deskripsi
//     ]
    
//     v(1.5em)

//     show figure.caption: set align(left)

//     // For some reason penulisan kalau aku enter menyisakan spasi di tampilan bukunya...
//     figure(
//       gap: 2em,
//       caption: figure.caption(position: bottom)[#set text(weight: 350)
//         #deskr_gambar
//       ],
//       [
//         #image(
//           gambar,
//           width: 100%,
//           height: 50%,
//         )
//       ],
//     )
    
//     v(0.4em)
    
//     text(size: 8pt, weight: "regular")[
//       Sumber: #sumbr_gambar
//     ]

//     v(1fr)
    
//     stack(
//       spacing: 1em,
//       text(
//         size: 12pt,
//         weight: 350,
//         font: "Noto Sans",
//       )[
//         Kata Kunci:
//       ],
//       if kata-kunci.len() > 0 {
//         badges-row(kata-kunci)
//       },
//     )

//     v(1em)
//   }

//   heading(level: 1)[#judul]
//   pagebreak()
// }

// ===== Halaman pembuka bab (box detail di kiri) =====
// Butuh dari dokumenmu: cmyk_purple, c-soal, main-content, badges-row

// ===== Halaman pembuka bab (box detail di kiri) =====
// Butuh dari dokumenmu: cmyk_purple, c-soal, main-content, badges-row

#let bab(
  judul,
  deskripsi,
  gambar,
  deskr_gambar,
  sumbr_gambar,
  kata-kunci: (),
  isi: auto, // "isi sekilas" di kolom kiri. auto = ambil dari heading level 2 bab ini
) = {
  // --- Geometri: semua ukuran halaman pembuka diatur di sini ---
  let kol-w = 5.3cm // lebar kolom detail kiri = posisi garis vertikal
  let img-y = 10.5cm // jarak atas pita gambar
  let img-h = 9.1cm // tinggi pita gambar
  let teks-x = kol-w + 1cm // awal teks kolom kanan
  let tepi = 2.4cm // margin kanan & bawah
  let isi-maks = 8 // batas item isi sekilas (agar tidak menabrak gambar)
  let garis = 0.9pt
  let angka-skala = 0.9 // 1.0 = ukuran awal; kecilin lagi kalau masih kebesaran
  let angka-y = 0.4cm // geser angka bab ke bawah dari tepi atas
  let jarak-judul = 0.4cm // jarak judul ke deskripsi bab

  show heading.where(level: 1): it => context {
    c-soal.update(0)
    pagebreak(to: "even", weak: true)

    // main-content.update(true)
    // Reset hitungan (x.x) pada figure dan persamaan
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(math.equation).update(0)

    let loc = it.location()
    let no = counter(heading).at(loc).first()

    // Isi sekilas: heading level 2 sampai bab berikutnya
    let daftar = if isi == auto {
      query(
        selector(heading.where(level: 2))
          .after(loc)
          .before(selector(heading.where(level: 1)).after(loc, inclusive: false)),
      ).map(h => h.body)
    } else { isi }
    daftar = daftar.slice(0, calc.min(daftar.len(), isi-maks))

    // Angka bab: outline raksasa, ukuran menyesuaikan jumlah digit
    let angka = {
      let mk(s) = text(
        size: s,
        font: ("Noto Sans"),
        fill: rgb("#0000"), // transparan = outline saja
        stroke: 0.8pt + cmyk_purple,
        str(no),
      )
      let w = measure(mk(300pt)).width
      mk(calc.min(340pt, 300pt * ((kol-w + 0.3cm) / w)) * angka-skala)
    }
    let angka-w = measure(angka).width

    page(margin: 0pt, header: none, footer: none, {
      // Garis vertikal, terputus oleh pita gambar
      place(top + left, dx: kol-w, rect(width: garis, height: img-y, fill: cmyk_purple, stroke: none))
      place(top + left, dx: kol-w, dy: img-y + img-h, rect(width: garis, height: 100% - img-y - img-h, fill: cmyk_purple, stroke: none))

      // Angka bab, menempel di garis, kepotong tepi halaman
      place(top + left, dx: kol-w - angka-w, dy: angka-y, angka)

      // Judul + deskripsi
      place(top + left, dx: teks-x, dy: 5.6cm, box(width: 100% - teks-x - tepi, {
        // spacing 0 + edge ketat: jarak antar teks = persis jarak-judul
        set par(spacing: 0pt)
        text(size: 40pt, weight: "bold", font: "Noto Sans", bottom-edge: "baseline", fill: cmyk_purple)[#it.body]
        v(2em)
        text(size: 12pt, weight: 350, font: "Noto Sans", top-edge: "cap-height")[#deskripsi]
      }))

      // Pita gambar full-bleed + caption figure (Gambar x.x) + sumber
      place(top + left, dy: img-y, box(width: 100%, {
        show figure.caption: set align(left)
        show figure.caption: it => pad(left: teks-x, right: tepi, text(size: 11pt, weight: 350, font: "Noto Sans", it))
        figure(
          kind: image,
          gap: 0.7cm,
          caption: figure.caption(position: bottom)[#deskr_gambar],
          box(width: 100%, height: img-h, clip: true, image(gambar, width: 100%, height: 100%, fit: "cover")),
        )
        v(-0.4em) // rapatkan sumber ke caption
        pad(left: teks-x, right: tepi, text(size: 8pt, weight: "regular", font: "Noto Sans")[Sumber: #sumbr_gambar])
      }))

      if kata-kunci.len() > 0 {
        place(bottom + left, dx: .9cm, dy: -tepi, box(width: kol-w - 1.1cm - 0.5cm, {
          set par(leading: 0.5em, spacing: 0pt)
          text(size: 12pt, weight: 350, font: "Noto Sans")[Kata Kunci:]
          v(1.2em)
          kata-kunci.map(k => box(badges-row((k,)))).join(h(0.4em))
        }))
      }
    })
  }

  heading(level: 1)[#judul]
  pagebreak(weak: true)
}

#let c-soal = counter("soal")
#set heading(numbering: "1.1.1")

#let gambar-compact(
  gambar,
  caption: none,
  sumber: none,
  lebar: 16em,
  sisi: right,
  sisi-caption: left,
  gap: 8pt,
  gap-caption: 10pt,
) = {
  let inset = if sisi == right {
    (left: gap, bottom: 8pt)
  } else {
    (right: gap, bottom: 8pt)
  }

  let cap-align = if sisi-caption == "kiri" or sisi-caption == left {
      left
    } else if sisi-caption == "tengah" or sisi-caption == center {
      center
    } else if sisi-caption == "kanan" or sisi-caption == right {
      right
    } else {
      left
    }

  box(width: lebar, inset: inset)[
    #show figure.caption: it => block(width: 100%)[
      #set align(cap-align)
      #it
    ]

    #figure(
      gap: gap-caption,
      block(
        width: 100%,
        clip: true,
        radius: 4pt,
        gambar,
      ),
      caption: caption,
    )

    #if sumber != none {
      v(-0.7em)
      text(size: 8pt, weight: "regular")[
        Sumber: #sumber
      ]
    }
  ]
}

#let soal-pg(teks, opsi) = {
  c-soal.step()
  context {
    let n = c-soal.get().first()

    grid(
      columns: (1em, 1fr),
      column-gutter: 8pt,
      align: (x, y) => if x == 0 {
        right + top
      } else {
        left + top
      },

      [#text(number-width: "tabular")[#n.]],
      [#teks],

      [],
      [
        #v(8pt)
        #set enum(
          numbering: "A.",
          indent: 0pt,
          body-indent: .5em,
          number-align: start,
        )
        #for o in opsi [+ #o]
      ],
    )
  }
}

#let kotak-breakable(
  body,
  fill: none,
  border: 0.8pt + cmyk_border,
  radius: 8pt,
  inset: 12pt,
  above: 0pt,
  below: 0pt,
) = {
  // Bagian atas: stroke dan rounded corners hanya di atas.
  block(
    width: 100%,
    height: 2 * radius,
    fill: fill,
    stroke: (
      top: border,
      left: border,
      right: border,
      rest: none,
    ),
    radius: (
      top-left: radius,
      top-right: radius,
      bottom-left: 0pt,
      bottom-right: 0pt,
    ),
    above: above,
    below: 0pt,
  )

  // Isi utama: hanya stroke kiri dan kanan.
  // Block ini dapat terpotong ke halaman berikutnya.
  block(
    width: 100%,
    breakable: true,
    fill: fill,
    stroke: (x: border, rest: none),
    inset: (left: 16pt, right: 16pt),
    above: 0pt,
    below: 0pt,
  )[
    #body
  ]

  // Bagian bawah: stroke dan rounded corners hanya di bawah.
  block(
    width: 100%,
    height: 2 * radius,
    fill: fill,
    stroke: (
      bottom: border,
      left: border,
      right: border,
      rest: none,
    ),
    radius: (
      top-left: 0pt,
      top-right: 0pt,
      bottom-left: radius,
      bottom-right: radius,
    ),
    above: 0pt,
    below: below,
  )
}

// #let side-by-side(
//   body1, body2,
//   gutter: 12pt,
//   columns: (50%, 50%)
// ) = {
//   grid(
//     columns: columns,
//     gutter: gutter,

//     inset: (x, y) => if x == 0 {
//       (right: gutter / 2)
//     } else {
//       (left: gutter / 0.7)
//     },
    
//     [ #body1 ],
  
//     [ #body2 ],

//     grid.vline(x: 1, stroke: cmyk_border + 0.5pt),
//   )
// }

#let side-by-side(
  body1, body2,
  gutter: 12pt,
  columns: (1fr, 1fr),
  divider: true,
) = {
  grid(
    columns: columns,
    column-gutter: 0pt,

    inset: (x, y) => if x == 0 {
      (right: gutter / 1)
    } else {
      (left: gutter / 1)
    },

    [#body1],
    [#body2],

    if divider == true {
      grid.vline(x: 1, stroke: cmyk_border + 0.5pt)
    }
  )
}

#let eq-highlight(body) = box(
  fill: cmyk_purple.lighten(85%),
  radius: 4pt,
  inset: 8pt,
  width: auto,
  align(center, body),
)

#let garis(length: 1.5em, ..opts) = box(
  height: 0.7em,
  width: length,
  align(horizon, line(
    length: 100%,
    stroke: (paint: black, thickness: 1pt) + opts.named(),
  )),
)

#let garis-singgung(
  length: 1.5em,
  paint: black,
  thickness: 1pt,
  titik: 0.2em,
) = box(
  height: 0.7em,
  width: length,
  {
    align(horizon, line(
      length: 100%,
      stroke: (paint: paint, thickness: thickness),
    ))
    place(center + horizon, circle(
      radius: titik,
      fill: paint,
      stroke: white + 0.8pt,
    ))
  },
)

#let garis-sekan(
  length: 1.5em,
  paint: black,
  thickness: 1pt,
  titik: 0.2em,
) = box(
  height: 0.7em,
  width: length,
  {
    align(horizon, line(
      length: 100%,
      stroke: (paint: paint, thickness: thickness),
    ))
    place(left + horizon, circle(
      radius: titik,
      fill: paint,
      stroke: white + 0.8pt,
    ))
    place(right + horizon, circle(
      radius: titik,
      fill: paint,
      stroke: white + 0.8pt,
    ))
  },
)

#let kekotak(length: 0.85em, ..opts) = box(
  width: length,
  radius: 1.5pt,
  height: 0.85em,
  baseline: 0.05em, // sesuaikan agar kotak sejajar dengan teks
  ..opts.named(),
)

#let secant(
  h, lbl: none,
  point: false,
  guide: false,
  fn: x => 0.25 * calc.pow(x, 2) + 1,   // fungsi
  dfn: x => x / 2,                      // turunannya (dipakai saat h == 0)
  x0: 1,
  xr: (-0.5, 4.5),                      // rentang sumbu x
  yr: (-0.8, 6),                        // rentang sumbu y
  guide-tangen: false,
  sd: auto,
) = canvas({
  import draw: *
  set-style(axes: (stroke: cmyk_border + .8pt))
  let (xmin, xmax) = xr
  let (ymin, ymax) = yr
  let xb = xmax + .1                    // posisi bracket Δy
  let (y0, y1) = (fn(x0), fn(x0 + h))
  let flat = calc.abs(y1 - y0) < 1e-9
  let m = if h == 0 { dfn(x0) } else { (y1 - y0) / h }
  let sdom = if sd == auto { (xmin - .5, xmax) } else { sd }

  plot.plot(
    size: (4.3, 4), axis-style: "school-book",
    x-tick-step: none, y-tick-step: none,
    x-min: xmin, x-max: xmax, y-min: ymin, y-max: ymax,
    {
      // garis potong dulu (tebal kalau datar), kurva di atasnya, supaya keduanya terlihat saat berimpit
      plot.add(fn, domain: (xmin, xmax), style: (stroke: cmyk_purple + 1pt))
      if guide-tangen and h != 0 {
        plot.add(x => y0 + dfn(x0) * (x - x0), domain: sdom,
          style: (stroke: (paint: cmyk_vermil, dash: "dashed", thickness: 1pt)))
      }
      plot.annotate(background: true, {
        let (xa, xb) = sdom
        let secant-line(x) = y0 + m * (x - x0)
        line(
          (xa, secant-line(xa)), (xb, secant-line(xb)),
          stroke: cmyk_blue + 1pt,
          mark: (start: "straight", end: "straight", scale: 1.2),
        )
      })

      plot.add(
        if h == 0 { ((x0, y0),) } else { ((x0, y0), (x0 + h, y1)) },
        mark: "o", mark-size: .2, mark-style: (fill: cmyk_blue, stroke: white),
        style: (stroke: cmyk_blue),
      )

      plot.annotate({
        if point == true {
          if h >= 0.5 {
            content((x0, y0 + .7), $P$)
            content((x0 + h, y1 + .7), $Q$)
          } else if h > 0 {
            content((x0 + h / 2, y0 + .7), $Q -> P$)
          } else {
            content((x0, y0 + .9), $P = Q$)
          }
        }
      })

      plot.annotate(background: true, {
        let st = (dash: "dashed", paint: black)
        if guide == true {
          line((x0, 0), (x0, y0), stroke: st)
          if h != 0 {
            line((x0 + h, 0), (x0 + h, y1), stroke: st)
            if not flat {   // kalau datar, garis ini berimpit dengan kurva
              line((xb, y1), (x0 + h, y1), stroke: st)
              line((xb, y0), (x0, y0), stroke: st)
            }
          }
        }
      })

      plot.annotate({
        if guide == true {
          if h == 0 {
            content((x0, -0.5), $x = x+h$, anchor: "west")
          } else {
            content((x0, -0.28), $x$, anchor: "north", padding: .05)
            content((x0 + h, -0.5), $x + h$, anchor: "west", padding: .05)
            line((x0, -1.2), (x0 + h, -1.2), mark: (start: "|", end: "|"))
            content((x0 + h / 2, -1.7), $h$)
            if flat {
              content((xb, y0 + .5), $Delta y = 0$, anchor: "east")
            } else {
              line((xb, y0 - .02), (xb, y1 + .02), mark: (start: "|", end: "|"))
              content((xmax + 1, (y0 + y1) / 2), $Delta y$, anchor: "east")
            }
          }
        }
        if lbl != none {
          content(((xmin + xmax) / 2, ymax - .5), lbl)
        }
      })
    },
  )
})

#let kelipatan(
  c: 2,
  fn: x => calc.pow(x, 2),
  dfn: x => 2 * x, // turunan fn
  x0: 1.7, // titik tempat panah dan garis singgung
  xr: (-3.5, 3.5),
  yr: (0, 10),
  len: 0.5, // setengah lebar segmen garis singgung (dalam satuan x), dipendekkan otomatis agar tetap dalam yr
  guide-tangen: true,
  lbl: none,
  lebar: 7.7,
  tinggi: 4,
  c-sumbu: cmyk_border,
  c-asli: cmyk_blue,
  c-kali: cmyk_purple,
  c-panah: cmyk_green,
) = canvas({
  import draw: *

  let (xmin, xmax) = xr
  let (ymin, ymax) = yr
  let sx = x => (x - xmin) / (xmax - xmin) * lebar // x data -> x kanvas
  let sy = y => (y - ymin) / (ymax - ymin) * tinggi // y data -> y kanvas
  let (y0, y1) = (fn(x0), c * fn(x0))
  let (s0, s1) = (dfn(x0), c * dfn(x0))

  // kurva yang dipotong pada rentang y (bagian di luar yr tidak digambar)
  let kurva(f, stroke) = {
    let n = 240
    let bagian = ()
    let sekarang = ()
    let (px, py) = (none, none)
    for k in range(n + 1) {
      let x = xmin + (xmax - xmin) * k / n
      let y = f(x)
      if y >= ymin and y <= ymax {
        if sekarang.len() == 0 and px != none { // masuk rentang: titik potong
          let yb = if py > ymax { ymax } else { ymin }
          sekarang.push((px + (yb - py) / (y - py) * (x - px), yb))
        }
        sekarang.push((x, y))
      } else if sekarang.len() > 0 { // keluar rentang: titik potong
        let yb = if y > ymax { ymax } else { ymin }
        sekarang.push((px + (yb - py) / (y - py) * (x - px), yb))
        bagian.push(sekarang)
        sekarang = ()
      }
      (px, py) = (x, y)
    }
    if sekarang.len() > 0 { bagian.push(sekarang) }
    for b in bagian {
      line(..b.map(p => (sx(p.at(0)), sy(p.at(1)))), stroke: stroke)
    }
  }

  // garis singgung berpanah; panjangnya dibatasi agar tidak keluar dari yr
  let batas(y, s) = if s == 0 { len } else { calc.min(ymax - y, y - ymin) / calc.abs(s) }
  let setengah = calc.min(len, batas(y0, s0), batas(y1, s1))
  let singgung(y, s, col) = {
    let (p1, p2) = (
      (sx(x0 - setengah), sy(y - s * setengah)),
      (sx(x0 + setengah), sy(y + s * setengah)),
    )
    // arah garis, untuk memperpanjang halo
    let (ddx, ddy) = (p2.at(0) - p1.at(0), p2.at(1) - p1.at(1))
    let l = calc.sqrt(ddx * ddx + ddy * ddy)
    let ext = .095   // perpanjangan halo tiap ujung (cm), naikkan kalau kurang
    let q1 = (p1.at(0) - ddx / l * ext, p1.at(1) - ddy / l * ext)
    let q2 = (p2.at(0) + ddx / l * ext, p2.at(1) + ddy / l * ext)

    // halo putih (lebih panjang dan lebih tebal)
    line(q1, q2, stroke: white + 5pt,
      mark: (start: "stealth", end: "stealth", fill: white, stroke: white + 3pt, scale: 1))
    // garis berwarna
    line(p1, p2, stroke: col + 1pt,
      mark: (start: "stealth", end: "stealth", fill: col, scale: 1))
  }

  // 1. sumbu
  let panah-sumbu = (end: "stealth", fill: c-sumbu, scale: .5)
  line((0, sy(0)), (lebar, sy(0)), stroke: c-sumbu + .8pt, mark: panah-sumbu)
  line((sx(0), 0), (sx(0), tinggi), stroke: c-sumbu + .8pt, mark: panah-sumbu)

  // 3. kurva asli (putus-putus) dan kurva c kali lipat
  kurva(fn, (paint: c-asli, dash: "dashed", thickness: 1pt))
  kurva(x => c * fn(x), c-kali + 1pt)

  // 2. garis singgung (di belakang kurva)
  if guide-tangen {
    on-layer(1, {
      singgung(y0, s0, c-asli)
      singgung(y1, s1, c-kali)
    })
  }

  // 5. titik di x0 pada kedua kurva
  on-layer(2, {
    circle((sx(x0), sy(y0)), radius: .1, fill: c-asli, stroke: white + 2pt)
    circle((sx(x0), sy(y1)), radius: .1, fill: c-kali, stroke: white + 2pt)
  })

  // 4. brace tinggi dari fn ke c * fn, dengan label
  let (bx, by0, by1) = (sx(x0), sy(y0), sy(y1))
  decorations.brace(
    (bx + 1.1, by0), (bx + 1.1, by1),   // di kiri titik, dari bawah ke atas
    amplitude: .3, flip: true,
  )
  content((bx + 2.1, (by0 + by1) / 2), text(fill: black, $times #c$),
    anchor: "east", frame: "rect", fill: white, stroke: none, padding: .05)

  if lbl != none { content((lebar / 2, tinggi - .2), lbl) }
})

// Proyeksi miring: sumbu z (kedalaman) mengarah ke kiri-atas,
// sehingga bagian yang "keluar" ke arah pengamat bergeser ke kanan-bawah.
#let kx = -0.5
#let ky = 0.33
#let P(x, y, z) = (x + z * kx, y + z * ky)

// Balok 3D dari rentang x, y, z. `a` = transparansi (0% = solid). Tanpa garis tepi.
#let balok3(x0, x1, y0, y1, z0, z1, col, a: 0%) = {
  import draw: *
  let f(pts, c) = line(..pts.map(p => P(..p)), close: true,
    fill: c.transparentize(a), stroke: none)
  // sisi belakang (digambar dulu, agar tembus pandang terlihat)
  f(((x0, y0, z1), (x1, y0, z1), (x1, y1, z1), (x0, y1, z1)), col.darken(10%))
  f(((x1, y0, z0), (x1, y0, z1), (x1, y1, z1), (x1, y1, z0)), col.darken(10%))
  f(((x0, y0, z0), (x1, y0, z0), (x1, y0, z1), (x0, y0, z1)), col.darken(10%))
  // sisi yang terlihat: depan, atas, kiri
  f(((x0, y0, z0), (x1, y0, z0), (x1, y1, z0), (x0, y1, z0)), col)
  f(((x0, y1, z0), (x1, y1, z0), (x1, y1, z1), (x0, y1, z1)), col.lighten(45%))
  f(((x0, y0, z0), (x0, y0, z1), (x0, y1, z1), (x0, y1, z0)), col.darken(15%))
}

#let kubus-meledak() = canvas(length: 1.25cm, {
  import draw: *

  let biru = rgb(cmyk_blue)
  let kuning = rgb(cmyk_purple)
  let hijau = rgb(cmyk_green)
  let merah = rgb(cmyk_vermil)

  let a = 2 // sisi kubus (x)
  let h = 0.25 // tebal tambahan (h)
  // jarak "ledakan" per sumbu
  let gx = 1
  let gy = 1
  let gz = 1

  // rentang koordinat: tambahan h bergeser menjauh dari kubus
  let xr(t) = if t { (a + gx, a + gx + h) } else { (0, a) }
  let yr(t) = if t { (a + gy, a + gy + h) } else { (0, a) }
  let zr(t) = if t { (-(gz + h), -gz) } else { (0, a) }
  let bagian(tx, ty, tz, col, a: 0%) = balok3(..xr(tx), ..yr(ty), ..zr(tz), col, a: a)

  // kubus utama x^3, tembus pandang
  balok3(0, a, 0, a, 0, a, biru, a: 50%)

  // lempengan atas dan kanan
  bagian(false, true, false, kuning)
  bagian(true, false, false, kuning)

  // tiga batang
  bagian(true, true, false, hijau) // sepanjang z
  bagian(false, true, true, hijau) // sepanjang x
  bagian(true, false, true, hijau) // sepanjang y

  // kubus mungil
  bagian(true, true, true, merah)

  // lempengan depan (terakhir, karena paling dekat ke pengamat)
  bagian(false, false, true, kuning, a: 35%)

  // ukuran x: rusuk kiri-belakang kubus (di sisi kiri tidak ada bagian kuning)
  let bx = a * kx - 0.15
  decorations.brace((bx, a * ky), (bx, a * ky + a), amplitude: 0.25, name: "bx")
  content((bx - 0.6, a * ky + a / 2), text(13pt, $x$))

  // ukuran h: ketebalan lempengan atas, di kolom yang sama
  decorations.brace((bx, a * ky + a + gy), (bx, a * ky + a + gy + h), amplitude: 0.15, name: "bh")
  content((bx - 0.5, a * ky + a + gy + h / 2), text(13pt, $h$))
})

#let persegi-panjang-meledak(
  biru: cmyk_blue,
  ungu: cmyk_purple,
  vermil: cmyk_vermil,
) = canvas(length: 1.25cm, {
  import draw: *

  let pj = 4.0 // sisi f(x)
  let lb = 2.5 // sisi g(x)
  let dx = 0.7 // pertambahan lebar: f'(x) h
  let dy = 0.55 // pertambahan tinggi: g'(x) h
  let jr = 0.2 // jarak "ledakan"

  let kotak(x0, y0, w, t, col) = rect((x0, y0), (x0 + w, y0 + t), fill: col.lighten(60%), stroke: none)

  // persegi panjang lama, dua strip, dan sudut kecil
  kotak(0, 0, pj, lb, biru)
  kotak(pj + jr, 0, dx, lb, ungu)
  kotak(0, lb + jr, pj, dy, ungu)
  kotak(pj + jr, lb + jr, dx, dy, vermil)

  content((pj / 2, lb / 2), text(14pt, $f(x) g(x)$))

  // ukuran f(x) dan f'(x) h di bawah
  decorations.brace((pj, -.3), (0, -.3), amplitude: .2, name: "bf")
  content((pj / 2, -1.0), text(13pt, $f(x)$))
  decorations.brace((pj + jr + dx, -.3), (pj + jr, -.3), amplitude: .15, name: "bdf")
  content((pj + jr + dx / 2, -.95), text(13pt, $f'(x) h$))

  // ukuran g(x) dan g'(x) h di kiri
  decorations.brace((-.3, 0), (-.3, lb), amplitude: .2, name: "bg")
  content((-.8, lb / 2), text(13pt, $g(x)$), anchor: "east")
  decorations.brace((-.3, lb + jr), (-.3, lb + jr + dy), amplitude: .15, name: "bdg")
  content((-.75, lb + jr + dy / 2), text(13pt, $g'(x) h$), anchor: "east")
})

#let kotak-smart-art(body) = block(
  width: 3cm, fill: cmyk_purple.lighten(80%), radius: 6pt, inset: (y: 14pt),
  align(center, text(fill: black, size: 14pt, body)),
)

#let panah = polygon(
  fill: cmyk_purple.lighten(80%),
  (0cm, 0.4cm), (1cm, 0.4cm), (1cm, 0cm), (1.8cm, 0.8cm),
  (1cm, 1.6cm), (1cm, 1.2cm), (0cm, 1.2cm),
)

#let label(body) = place(
  top + center, dy: 10pt,
  box(width: 6cm, align(center, text(size: 11.5pt, body))),
)

#let tiga-turunan(
  garis: (-1, 1),
  c1: rgb("#8E44AD"), // f
  c2: rgb("#2E86DE"), // f'
  c3: rgb("#E8590C"), // f''
  warna-sumbu: luma(80),
  sumbu-y: "kiri", // "kiri": di tepi kiri panel; "tengah": di x = 0 (menabrak garis bantu x = 0)
  lebar: 6,
  tinggi: 2.6,
  jarak: 1.2,
) = canvas({
  import draw: *

  let (xmin, xmax) = (-2.2, 2.2)
  let sx = x => (x - xmin) / (xmax - xmin) * lebar // x data -> x kanvas
  let panel = (
    (fn: x => calc.pow(x, 3) - 3 * x, yr: (-4.5, 4.5), col: c1, lbl: $f(x)$),
    (fn: x => 3 * calc.pow(x, 2) - 3, yr: (-4, 12), col: c2, lbl: $f'(x)$),
    (fn: x => 6 * x, yr: (-14, 14), col: c3, lbl: $f''(x)$),
  )
  let bawah(i) = -i * (tinggi + jarak)
  assert(sumbu-y in ("kiri", "tengah"), message: "sumbu-y harus \"kiri\" atau \"tengah\"")
  let xk = -.2 // tepi kiri panel: awal sumbu x, dan acuan label
  let xy = if sumbu-y == "tengah" { sx(0) } else { xk } // posisi sumbu y
  let panah = (end: "stealth", fill: warna-sumbu, scale: .5)

  // garis bantu vertikal (digambar dulu supaya berada di belakang kurva)
  for g in garis {
    line((sx(g), bawah(0) + tinggi), (sx(g), bawah(2)),
      stroke: (paint: gray, dash: "dashed", thickness: .7pt))
    content((sx(g), bawah(2) - .4), text(9pt, $x = #g$))
  }

  for (i, p) in panel.enumerate() {
    let (ymin, ymax) = p.yr
    let sy = y => bawah(i) + (y - ymin) / (ymax - ymin) * tinggi

    // sumbu
    line((xk, sy(0)), (lebar, sy(0)), stroke: warna-sumbu + .8pt, mark: panah)
    line((xy, bawah(i)), (xy, bawah(i) + tinggi), stroke: warna-sumbu + .8pt, mark: panah)

    // kurva
    let n = 80
    let titik = range(n + 1).map(k => {
      let x = xmin + (xmax - xmin) * k / n
      (sx(x), sy((p.fn)(x)))
    })
    line(..titik, stroke: p.col + 1.3pt)

    // titik pada garis bantu
    for g in garis {
      circle((sx(g), sy((p.fn)(g))), radius: .09, fill: p.col, stroke: white + 1pt)
    }

    content((xk - .25, bawah(i) + tinggi / 2), p.lbl, anchor: "east")
  }
  content((lebar + .25, bawah(2) + tinggi / 2), $x$, anchor: "west")
})

#let cekung-singgung(
  c-kiri: rgb("#8E44AD"),
  c-kanan: rgb("#2E86DE"),
  c-singgung: luma(90),
  c-belok: rgb("#E8590C"),
  warna-sumbu: cmyk_border,
  lebar: 6,
  tinggi: 4,
  di-belok: false,
) = canvas({
  import draw: *

  let (xmin, xmax) = (-2.2, 2.2)
  let (ymin, ymax) = (-4.5, 4.5)
  let sx = x => (x - xmin) / (xmax - xmin) * lebar
  let sy = y => (y - ymin) / (ymax - ymin) * tinggi
  let f = x => calc.pow(x, 3) - 3 * x
  let df = x => 3 * calc.pow(x, 2) - 3
  let panah = (end: "stealth", fill: warna-sumbu, scale: .5)

  // sumbu
  line((0, sy(0)), (lebar, sy(0)), stroke: warna-sumbu + .8pt, mark: panah)
  line((sx(0), 0), (sx(0), tinggi), stroke: warna-sumbu + .8pt, mark: panah)
  content((lebar + .25, sy(0)), $x$, anchor: "west")
  content((sx(0), tinggi + .25), $y$, anchor: "south")

  // kurva, dua warna: sebelum dan sesudah titik belok
  let kurva(a, b, col) = {
    let n = 60
    let titik = range(n + 1).map(k => {
      let x = a + (b - a) * k / n
      (sx(x), sy(f(x)))
    })
    line(..titik, stroke: col + 1.4pt)
  }
  kurva(xmin, 0, c-kiri)
  kurva(0, xmax, c-kanan)

  // garis singgung pendek berpanah di dua ujung, dengan titik singgung
  let singgung(x0, col, setengah: .6, dash: none) = {
    let (y0, m) = (f(x0), df(x0))
    line(
      (sx(x0 - setengah), sy(y0 - m * setengah)),
      (sx(x0 + setengah), sy(y0 + m * setengah)),
      stroke: (paint: black, thickness: 1.1pt, dash: dash),
      mark: (start: "stealth", end: "stealth", fill: col, scale: .45),
    )
    circle((sx(x0), sy(y0)), radius: .07, fill: black, stroke: 1pt + white)
  }
  for x0 in (-1.5, -.7, .7, 1.5) { singgung(x0, c-singgung) }
  if di-belok { singgung(0, c-belok, setengah: .6, dash: "dashed") }

  // titik belok
  circle((sx(0), sy(0)), radius: .11, fill: c-belok, stroke: 1pt + white)
  line((sx(.5), sy(1.5)), (sx(.1), sy(.2)), stroke: c-belok + .8pt,
    mark: (end: "stealth", fill: c-belok, scale: .45))
  content((sx(.5), sy(1.7)), text(c-belok)[titik belok], anchor: "south-west")

  // label wilayah: "mulut" terbuka ke bawah di atas, terbuka ke atas di bawah
  content((sx(-1.5), sy(3.9)), text(c-kiri)[cekung ke bawah])
  content((sx(1.5), sy(-3.9)), text(c-kanan)[cekung ke atas])
})

#let grafik-puncak(
  fn, dom, xr, yr, x0,
  sumbu-x: none, sumbu-y: none,
  tanda-x: none, tanda-y: none,
  singgung: none,
  panah-bawah: none,
  titik-lain: (), // BARU: titik tambahan di kurva, tiap elemen (x:, label:, anchor: "south")
  c-kurva: cmyk_purple,
  c-puncak: cmyk_vermil,
  c-panah: cmyk_green,
  c-sumbu: cmyk_border,
  lebar: 6,
  tinggi: 4,
) = canvas({
  import draw: *

  let (xmin, xmax) = xr
  let (ymin, ymax) = yr
  let sx = x => (x - xmin) / (xmax - xmin) * lebar
  let sy = y => (y - ymin) / (ymax - ymin) * tinggi
  let y0 = fn(x0)
  let (px, py) = (sx(x0), sy(y0))
  let panah = (end: "stealth", fill: c-sumbu, scale: .5)

  // sumbu (berpotongan di titik asal data)
  line((sx(xmin), sy(0)), (lebar, sy(0)), stroke: c-sumbu + .8pt, mark: panah)
  line((sx(0), sy(ymin)), (sx(0), tinggi), stroke: c-sumbu + .8pt, mark: panah)
  if sumbu-x != none { content((lebar + .15, sy(0)), sumbu-x, anchor: "west") }
  if sumbu-y != none { content((sx(0), tinggi + .15), sumbu-y, anchor: "south") }

  // garis bantu dari puncak ke kedua sumbu, beserta labelnya
  let bantu = (paint: gray, dash: "dashed", thickness: .7pt)
  line((px, py), (px, sy(0)), stroke: bantu)
  line((px, py), (sx(0), py), stroke: bantu)
  if tanda-x != none { content((px, sy(0) - .15), tanda-x, anchor: "north") }
  if tanda-y != none { content((sx(0) - .15, py), tanda-y, anchor: "east") }

  // kurva
  let n = 200
  line(..range(n + 1).map(k => {
    let x = dom.at(0) + (dom.at(1) - dom.at(0)) * k / n
    (sx(x), sy(fn(x)))
  }), stroke: c-kurva + 1.4pt)

  // BARU: titik tambahan di kurva (mis. pembanding di kiri/kanan puncak)
  for t in titik-lain {
    let (tx, ty) = (sx(t.x), sy(fn(t.x)))
    let ang = t.at("anchor", default: "south")
    let geser = (south: (0, .16), north: (0, -.16), west: (.16, 0), east: (-.16, 0))
    circle((tx, ty), radius: .08, fill: c-kurva, stroke: white + .8pt)
    if t.at("label", default: none) != none {
      let (gx, gy) = geser.at(ang)
      content((tx + gx, ty + gy), t.label, anchor: ang)
    }
  }

  // garis singgung mendatar di puncak
  if singgung != none {
    line((px - 1.5, py), (px + 1.5, py), stroke: c-puncak + 1.1pt,
      mark: (start: "stealth", end: "stealth", fill: c-puncak, scale: .45))
    content((px, py + .2), text(c-puncak, singgung), anchor: "south")
  }

  // panah ke bawah (percepatan)
  if panah-bawah != none {
    let (pj, lb) = (panah-bawah.panjang, panah-bawah.label)
    line((px, py - .15), (px, py - .15 - pj), stroke: c-panah + 1.2pt,
      mark: (end: "stealth", fill: c-panah, scale: .5))
    content((px, py - .15 - pj - .12), text(c-panah, lb), anchor: "north",
      frame: "rect", fill: white, stroke: none, padding: .05)
  }

  // titik puncak
  circle((px, py), radius: .1, fill: c-puncak, stroke: white + .8pt)
})

// h(t) = -5t^2 + 20t + 2: bola dilempar dari 2 m, puncak (2, 22), mendarat di t ≈ 4,1
#let grafik-bola(..opts) = grafik-puncak(
  t => -5 * calc.pow(t, 2) + 20 * t + 2,
  (0, (20 + calc.sqrt(440)) / 10), (0, 4.6), (0, 26), 2,
  sumbu-x: [$t$ (detik)], sumbu-y: [$h$ (meter)],
  tanda-x: $t = 2$, tanda-y: $22$,
  singgung: $v = 0$,
  panah-bawah: (panjang: 1.1, label: $a = -10 "m/s"^2$),
  ..opts,
)

// P(x) = -x^2 + 40x - 100: puncak (20, 300)
#let grafik-untung(..opts) = grafik-puncak(
  x => -calc.pow(x, 2) + 40 * x - 100,
  (0, 40), (0, 44), (-150, 400), 20,
  sumbu-x: [$x$ (produk)], sumbu-y: [$P$ (ribu rupiah)],
  tanda-x: $x = 20$, tanda-y: $300$,
  singgung: $P'(20) = 0$,
  ..opts,
)

#let grafik-analisis(
  c-bawah: cmyk_purple, // cekung ke bawah (x < 2)
  c-atas: cmyk_blue, // cekung ke atas (x > 2)
  c-titik: cmyk_vermil,
  c-sumbu: cmyk_border,
  lebar: 6.4,
  tinggi: 4.8,
) = canvas({
  import draw: *

  let f = x => calc.pow(x, 3) - 6 * calc.pow(x, 2) + 9 * x + 1
  let (xmin, xmax) = (-.2, 4.4)
  let (ymin, ymax) = (-1.8, 12.8)
  let sx = x => (x - xmin) / (xmax - xmin) * lebar
  let sy = y => (y - ymin) / (ymax - ymin) * tinggi
  let panah = (end: "stealth", fill: c-sumbu, scale: .5)

  // sumbu di dasar dan di kiri
  line((0, 0), (lebar, 0), stroke: c-sumbu + .8pt, mark: panah)
  line((0, 0), (0, tinggi), stroke: c-sumbu + .8pt, mark: panah)
  content((lebar + .15, 0), $x$, anchor: "west")
  content((0, tinggi + .15), $f(x)$, anchor: "south")

  // garis bantu putus-putus dari sumbu-x (x = 1, 2, 3); x = 1 dan 3 diteruskan ke strip
  let bantu = (paint: gray, dash: "dashed", thickness: .7pt)
  let y-strip = 11.6
  line((sx(1), 0), (sx(1), sy(y-strip + .6)), stroke: bantu)
  line((sx(3), 0), (sx(3), sy(y-strip + .6)), stroke: bantu)
  line((sx(2), 0), (sx(2), sy(f(2))), stroke: bantu)
  for x0 in (1, 2, 3) { content((sx(x0), -.1), $#x0$, anchor: "north") }

  // strip naik / turun / naik
  let strip(a, b, teks) = {
    line((sx(a) + .06, sy(y-strip)), (sx(b) - .06, sy(y-strip)), stroke: c-sumbu + .8pt,
      mark: (start: "|", end: "|", scale: .5))
    content(((sx(a) + sx(b)) / 2, sy(y-strip) + .1), text(c-sumbu, size: .9em, teks), anchor: "south")
  }
  strip(xmin + .1, 1, [naik])
  strip(1, 3, [turun])
  strip(3, xmax - .1, [naik])

  // kurva dua warna
  let kurva(a, b, col) = {
    let n = 80
    line(..range(n + 1).map(k => {
      let x = a + (b - a) * k / n
      (sx(x), sy(f(x)))
    }), stroke: col + 1.4pt)
  }
  kurva(xmin, 2, c-bawah)
  kurva(2, xmax, c-atas)

  // titik penting
  let titik(x0, lbl, anc, g) = {
    circle((sx(x0), sy(f(x0))), radius: .1, fill: c-titik, stroke: white + .8pt)
    content((sx(x0) + g.at(0), sy(f(x0)) + g.at(1)), text(c-titik, lbl), anchor: anc,
      frame: "rect", fill: white, stroke: none, padding: .03)
  }
  titik(1, [$(1, 5)$ maks. lokal], "south", (0, .2))
  titik(3, [$(3, 1)$ min. lokal], "north-west", (.12, -.18))
  titik(2, [$(2, 3)$ titik belok], "south-west", (.2, .15))
})

#let taman-diagram(
  c-pagar: cmyk_purple,
  c-tembok: cmyk_border,
  c-taman: cmyk_green,
  lebar: 5,
  tinggi: 2.6,
) = canvas({
  import draw: *

  // tembok berarsir di atas
  let (x0, x1) = (-.7, lebar + .7)
  line((x0, tinggi), (x1, tinggi), stroke: c-tembok + 2.5pt)
  for k in range(int((x1 - x0) / .25)) {
    let xa = x0 + .25 * k
    line((xa, tinggi), (xa + .2, tinggi + .22), stroke: c-tembok + .7pt)
  }
  content((x1, tinggi + .5), text(c-tembok)[tembok], anchor: "east")

  // taman (tanpa garis di sisi tembok) dan pagar tiga sisi
  rect((0, 0), (lebar, tinggi), fill: c-taman.lighten(88%), stroke: none)
  line((0, tinggi), (0, 0), (lebar, 0), (lebar, tinggi), stroke: c-pagar + 2pt)

  // label ukuran
  content((-.25, tinggi / 2), $x$, anchor: "east")
  content((lebar + .25, tinggi / 2), $x$, anchor: "west")
  content((lebar / 2, tinggi - .35), $y$)
  line((.4, tinggi - .35), (lebar / 2 - .3, tinggi - .35), stroke: c-tembok + .6pt, mark: (start: "stealth", fill: c-tembok, scale: .4))
  line((lebar - .4, tinggi - .35), (lebar / 2 + .3, tinggi - .35), stroke: c-tembok + .6pt, mark: (start: "stealth", fill: c-tembok, scale: .4))
  content((lebar / 2, -.4), text(c-pagar)[pagar], anchor: "north")
})

// Tiga taman dengan panjang pagar sama (24 m), x = 3, 6, 9: luas 54, 72, 54 m^2.
#let taman-mini(
  c-pagar: cmyk_purple,
  c-tembok: cmyk_border,
  c-taman: cmyk_green,
  skala: .2,
  jarak: 1.1,
) = canvas({
  import draw: *

  let ukuran = ((3, 18), (6, 12), (9, 6)) // (x, y)
  let total = ukuran.map(u => u.at(1) * skala).sum() + jarak * 2
  let atas = 9 * skala + .1

  // tembok bersama
  line((-.3, atas), (total + .3, atas), stroke: c-tembok + 2.5pt)
  for k in range(int((total + .6) / .25)) {
    let xa = -.3 + .25 * k
    line((xa, atas), (xa + .2, atas + .2), stroke: c-tembok + .7pt)
  }

  let kiri = 0
  for (i, (x, y)) in ukuran.enumerate() {
    let (w, h) = (y * skala, x * skala)
    let sorot = i == 1
    let pt = atas - h
    rect((kiri, pt), (kiri + w, atas), stroke: none,
      fill: if sorot { c-taman.lighten(60%) } else { c-taman.lighten(88%) })
    line((kiri, atas), (kiri, pt), (kiri + w, pt), (kiri + w, atas),
      stroke: (paint: c-pagar, thickness: if sorot { 2.2pt } else { 1.4pt }))
    content((kiri + w / 2, atas - 9 * skala - .15), anchor: "north", align(center)[
      #text(size: .85em)[$x = #x$, $y = #y$] \
      #text(if sorot { c-pagar } else { black }, weight: if sorot { "bold" } else { "regular" })[$L = #(x * y) "m"^2$]
    ])
    kiri += w + jarak
  }
})

// A(x) = 24x - 2x^2: luas taman, puncak (6, 72), dengan pembanding x = 3 dan x = 9.
#let grafik-taman(..opts) = grafik-puncak(
  x => 24 * x - 2 * calc.pow(x, 2),
  (0, 12), (0, 13), (0, 84), 6,
  sumbu-x: [$x$ (m)], sumbu-y: [$A$ ($"m"^2$)],
  tanda-x: $x = 6$, tanda-y: $72$,
  singgung: $A'(6) = 0$,
  titik-lain: (
    (x: 3, label: $(3, 54)$, anchor: "west"),
    (x: 9, label: $(9, 54)$, anchor: "east"),
  ),
  ..opts,
)

#let grafik-tak-hingga(
  fn: x => 3 + 5 / x + 2 / calc.pow(x, 2),
  dom: (1, 12.5),
  xr: (0, 13.5),
  yr: (0, 11),
  L: 3,
  lbl-fn: $f(x) = (3x^2 + 5x + 2) / x^2$,
  lbl-L: none,
  c-kurva: cmyk_purple,
  c-asimtot: cmyk_blue,
  c-sumbu: cmyk_border,
  lebar: 6,
  tinggi: 3.6,
) = canvas({
  import draw: *

  let (xmin, xmax) = xr
  let (ymin, ymax) = yr
  let sx = x => (x - xmin) / (xmax - xmin) * lebar
  let sy = y => (y - ymin) / (ymax - ymin) * tinggi
  let panah = (end: "stealth", fill: c-sumbu, scale: .5)

  // sumbu
  line((0, 0), (lebar, 0), stroke: c-sumbu + .8pt, mark: panah)
  line((0, 0), (0, tinggi), stroke: c-sumbu + .8pt, mark: panah)
  content((lebar + .15, 0), $x$, anchor: "west")
  content((0, tinggi + .15), $y$, anchor: "south")

  // garis y = L (asimtot mendatar)
  line((0, sy(L)), (lebar, sy(L)), stroke: (paint: c-asimtot, dash: "dashed", thickness: 1pt))
  content((-.15, sy(L)), text(c-asimtot, $#L$), anchor: "east")
  content((lebar - .1, sy(L) - .12), text(c-asimtot, lbl-L), anchor: "north-east")

  // kurva, ujung kanan berpanah: terus berlanjut ke x -> tak hingga
  let n = 160
  line(..range(n + 1).map(k => {
    let x = dom.at(0) + (dom.at(1) - dom.at(0)) * k / n
    (sx(x), sy(fn(x)))
  }), stroke: c-kurva + 1.4pt, mark: (end: "stealth", fill: c-kurva, scale: .5))
  content((sx(dom.at(0) + 1.2), sy(fn(dom.at(0) + 1.2)) + .15), text(c-kurva, lbl-fn), anchor: "south-west")
})