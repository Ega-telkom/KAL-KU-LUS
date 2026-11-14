#import "@preview/bulb:0.2.1": dither
#import "@preview/ccicons:1.0.1": *

#let cmyk_text = cmyk(0%, 0%, 0%, 100%)
#let cmyk_white = cmyk(0%, 0%, 0%, 0%)
#let cmyk_border = cmyk(0%, 0%, 0%, 33%)
#let cmyk_purple = cmyk(0%, 100%, 20%, 0%)
#let cmyk_blue = cmyk(100%, 30%, 0%, 0%)

// ===== PENGATURAN =====
#let spine = 8mm         // GANTI sesuai info tebal punggung dari percetakan
#let show-guides = true     // set false sebelum export final untuk cetak
#let show-spine-text = true // aktifkan hanya kalau tebal punggung sudah pasti
#let spine-top = .5cm
// ======================

#let bleed = 4mm
#let lebar-a4 = 210mm
#let tinggi-a4 = 297mm
#let lebar-total = 2 * lebar-a4 + spine + 2 * bleed
#let tinggi-total = tinggi-a4 + 2 * bleed

#let m-left = 2cm
#let m-right = 2cm
#let m-top = 3cm

#set page(width: lebar-total, height: tinggi-total, margin: 0pt)
#set text(lang: "id")
#set text(region: "id")

#let gambar-y = 16cm

// COVER BELAKANG
#place(top + left, dx: bleed, dy: bleed)[
  #box(width: lebar-a4, height: tinggi-a4)[
    #pad(left: m-left, right: m-right, top: m-top)[
      #set par(justify: true)
      #text(size: 11.5pt, font: "Noto Sans", fill: cmyk_text)[
        Buku modul ini disusun secara sistematis untuk memenuhi tugas Penilaian Sumatif Akhir Jenjang (PSAJ) Kelas XII Tahun 2026. Berfokus pada salah satu pilar utama matematika, modul ini menghadirkan pembahasan menyeluruh mengenai Kalkulus, mulai dari konsep dasar limit, turunan, hingga integral, yang dirancang khusus untuk mempermudah pemahaman siswa tingkat akhir.

        Kalkulus bukan sekadar sekumpulan rumus, melainkan sebuah cabang matematika mendalam yang menjembatani pemahaman kita terhadap dinamika perubahan di dunia nyata. Melalui sajian materi yang terstruktur dan sederhana, contoh soal yang relevan, serta latihan terukur.

        == Legal
        #v(.5em)
        Karya ini dilindungi dibawah lisensi CC BY-SA 4.0 #cc-by-sa. Lisensi ini berlaku untuk konten asli dari handout ini dan tidak berlaku untuk materi pihak ketiga, yang disebutkan dan dicantumkan sumbernya secara terpisah. 
        Pelajari lebih lanjut: #underline[https://creativecommons.org/licenses/by-sa/4.0/ ]
      ]
    ]
    #pad(left: m-left, right: m-right, top: m-top)[
      #v(20em)
      #text(size: 11.5pt, font: "Noto Sans")[
        Gambar diatas merupakan karya fotografi John Cameron diambil dari unsplash.com (Lisensi Unsplash) dan dimodifikasi dengan efek _halftone_ ungu dan biru.
      ]
    ]
  ]
]

// COVER DEPAN (digeser sejauh lebar punggung)
#place(top + left, dx: bleed + lebar-a4 + spine, dy: bleed)[
  #box(width: lebar-a4, height: tinggi-a4)[
    #place(top + left, dy: -0.2cm)[
      #set par(leading: 0.1em)
      #text(size: 145pt, weight: "bold", font: "IBM Plex Sans", fill: cmyk_purple)[
        KAL-\
        KU-\
        LUS\ 
        #place(bottom + left, dx: 9.5cm)[
          #text(size: 11.5pt, font: "Noto Sans", weight: "regular")[_\*in a nutshell_ 🥜]
        ]
      ]
    ]

    #v(9cm)

    #pad(left: m-left, right: m-right, top: m-top)[
      #v(6em)
      #set text(fill: cmyk_text)
      #text(size: 11.5pt, font: "Noto Sans")[
        Handout Buku Matematika untuk Kelas XII SMK
      ]
      #v(26em)
      #text(size: 12pt, font: "Noto Sans")[
        _Disusun oleh:_\
        Cynthia Linda Rizkiana \ 
        Danendra Eganatha Syahsamaauren \ 
        Fadhil Rekh Saputra
      ]
    ]
  ]
]

// GAMBAR (membentang penuh, termasuk punggung)
#place(top + left, dx: 0pt, dy: gambar-y)[
  #image(
    dither(
      read("assets/cover.jpg", encoding: none),
      palette: (cmyk_white, cmyk_purple, cmyk_blue),
      method: "cluster4",
      size: 800
    ),
    width: lebar-total,
    height: 6cm)
]

// TEKS PUNGGUNG (opsional)
#if show-spine-text [
  #place(top + left, dx: bleed + lebar-a4, dy: bleed + spine-top)[
    #box(width: spine, height: tinggi-a4 - spine-top)[
      #align(top + center)[
        #rotate(90deg, reflow: true)[
          #text(size: 10pt, font: "Noto Sans", fill: cmyk_purple)[
            Handout PSAJ Matematika untuk kelas XII
          ]
        ]
      ]
    ]
  ]
]

#if show-spine-text [
  #place(top + left, dx: bleed + lebar-a4, dy: bleed + spine-top)[
    #box(width: spine, height: tinggi-a4 - 1cm)[
      #align(bottom + center)[
        #rotate(90deg, reflow: true)[
          #text(size: 10pt, font: "Noto Sans", fill: cmyk_purple)[
            KAL-KU-LUS: _In a nutshell_
          ]
        ]
      ]
    ]
  ]
]

// GARIS PANDU PUNGGUNG (matikan sebelum cetak)
#if show-guides [
  #place(top + left, dx: bleed + lebar-a4, dy: 0pt)[
    #line(angle: 90deg, length: tinggi-total, stroke: (paint: red, dash: "dashed"))
  ]
  #place(top + left, dx: bleed + lebar-a4 + spine, dy: 0pt)[
    #line(angle: 90deg, length: tinggi-total, stroke: (paint: red, dash: "dashed"))
  ]
]
