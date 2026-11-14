
// BAB 2: Turunan

#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.4": plot
#import "@preview/mannot:0.4.0": *
#import "@preview/quadrille:0.1.0": *
#import "@preview/lilaq:0.6.0" as lq
#import "../template.typ": *

#bab(
  // Judul
  "Turunan",

  // Deskripsi
  "Konsep dalam kalkulus yang digunakan untuk mengukur laju perubahan suatu besaran terhadap besaran lainnya pada suatu saat.",

  // Gambar
  "assets/bab2/cover.jpg",
  "Dalam perjalanan kembali ke Bumi, Falcon 9 harus mengatur kecepatannya agar dapat mendarat dengan tepat. Namun, bagaimana kita mengetahui laju perubahan gerak roket pada setiap saat?",
  "\"First stage of Falcon 9 rocket\" Oleh Official SpaceX Photos, CC BY-NC 2.0",

  // Kata kunci
  kata-kunci: ("Garis Singgung", "Titik Stasioner", "Gradien", "Binomial")
)

// #tujuan[
//   Setelah mempelajari bab ini, Anda diharapkan mampu memahami konsep dan aturan turunan, menentukan turunan suatu fungsi, serta menerapkannya untuk menyelesaikan berbagai permasalahan dalam kehidupan sehari-hari.
// ]

#tujuan[
  Anda akan mempelajari:
  #v(-.8em)
  #badges(
    badge[Konsep & Definisi Turunan],
    badge[Asal Mula Aturan Turunan],
    badge[Aturan Turunan],
    badge[Turunan Trigonometri Dasar],
    badge[Analisis Perilaku Fungsi],
    badge[Penerapan Turunan]
  )

  Bab ini tidak mencakup:
  #v(-.8em)
  #badges(
    badge(warna: cmyk_border, [Turunan Eksponen & Logaritma]),
    badge(warna: cmyk_border, [Turunan Trigonometri Lanjutan]),
    badge(warna: cmyk_border, [Turunan Implisit]),
    badge(warna: cmyk_border, [Turunan Parsial])
  )
]

#mengapa(judul: [Mengapa harus belajar Turunan?], [
  Sadar atau tidak, banyak hal di sekitar kita mengalami perubahan. 
  Kecepatan kendaraan berubah, jumlah produksi sebuah pabrik berubah, keuntungan sebuah perusahaan berubah, ketinggian sebuah benda berubah. Bahkan suhu, jumlah penduduk, dan pertumbuhan suatu populasi juga berubah. Turunan dapat digunakan untuk mencari perubahan itu!
])

== Apa itu Turunan?

#meander.reflow({
  import meander: *

  placed(top + right, gambar-compact(
  image("../assets/bab2/atlet-berlari.jpg"),
    caption: [Atlet Berlari],
    sumber: "unsplash.com, Kredit: Jonathan Chng, Lisensi: Lisensi Unsplash"
  ))

  container()
  content[
    Pada suatu pagi, seorang atlet sedang menjalani latihan lari di lintasan atletik. Pelatihnya ingin mengetahui seberapa cepat atlet tersebut bergerak tepat pada detik ke-2.

    Kita dapat menghitung jarak yang ditempuh dan membaginya dengan waktu perjalanan untuk memperoleh kecepatan rata-rata. Misalnya, seseorang menempuh jarak $6$ meter dalam waktu $2$ detik, sehingga kecepatan rata-ratanya adalah $3$ meter per detik. Namun, nilai tersebut belum menjelaskan apakah ia berlari dengan kecepatan tetap atau mengalami perubahan kecepatan selama perjalanan.
    
    Bahkan, dua pelari dapat memiliki kecepatan rata-rata yang sama, tetapi kecepatan mereka pada waktu tertentu bisa berbeda. Mari kita analisis perbedaan kecepatan kedua pelari melalui grafik berikut:
  ]
})

// [VISUAL 2: Dua ilustrasi gerak yang sama-sama menempuh jarak 6 meter dalam 2 detik. Ilustrasi pertama menunjukkan gerak dengan kecepatan tetap; ilustrasi kedua menunjukkan pelari yang awalnya lambat lalu semakin cepat. Sertakan label kecepatan rata-rata yang sama.]

#side-by-side(
  [
    #figure(
      caption: figure.caption(position: top)[Kecepatan Pelari 1],
      gap: 1em,
      [
        #let x = lq.linspace(0, 2)
        #lq.diagram(
          lq.plot(
            x, x => x * 3, 
            stroke: 1pt + cmyk_purple,
            mark: none
          ),
          xlabel: [Waktu (s)],
          ylabel: [Posisi (m)],
        )
      ]
    )<grafik-akselerasi-1>
  ],
  [
    #figure(
      caption: figure.caption(position: top)[Kecepatan Pelari 2],
      gap: 1em,
      [
        #let x = lq.linspace(0, 2)
        #lq.diagram(
          lq.plot(
            x, x => calc.pow(x, 2) * 1.5, 
            stroke: 1pt + cmyk_purple,
            mark: none
          ),
          xlabel: [Waktu (detik)],
          ylabel: [Posisi (m)],
        )
      ]
    )<grafik-akselerasi-2>
  ]
)

Pada @grafik-akselerasi-1, pelari 1 bergerak dengan kecepatan tetap. Sementara itu, @grafik-akselerasi-2 menggambarkan pelari 2 yang awalnya bergerak perlahan, kemudian semakin cepat. Meskipun pola geraknya berbeda, kedua pelari sama-sama menempuh jarak $6$ meter dalam waktu $2$ detik. Oleh karena itu, kecepatan rata-rata ($overline(v)$) mereka sama, yaitu:

$ overline(v) = 6 / 2 = 3 "m/s" $

Dari bentuk grafik saja, kita dapat melihat bahwa kedua pelari memiliki pola gerak yang berbeda. Meskipun keduanya menempuh jarak yang sama dalam waktu $2$ detik, tetapi kecepatan mereka pada setiap saat belum tentu sama.

Kamu baru saja menemukan petunjuk penting tentang turunan! Kita tidak hanya ingin mengetahui kecepatan rata-rata selama perjalanan, tetapi juga ingin mengetahui seberapa cepat posisi berubah pada suatu saat tertentu.

Lalu, bagaimana cara memperkirakan kecepatan tepat pada detik ke-$2$ jika kita hanya mengetahui posisi pelari pada beberapa waktu tertentu?

Dengan demikian, kita perlu membedakan dua hal: seberapa cepat seseorang bergerak secara rata-rata selama suatu perjalanan dan seberapa cepat ia bergerak tepat pada satu saat. Untuk mendapatkan gambaran yang lebih baik, kita perlu mengamati geraknya dalam selang waktu yang lebih pendek.

Bayangkan posisi pelari dapat dicatat menggunakan kamera atau sensor canggih pada beberapa waktu tertentu. Kita tidak harus mengukur seluruh lintasan secara terus-menerus. Kita dapat memilih dua waktu, menghitung perubahan posisi di antaranya, lalu membaginya dengan selang waktu tersebut. Hasilnya adalah kecepatan rata-rata pada selang itu.

// VISUAL 3: Diagram sederhana berupa garis waktu dengan beberapa penanda, misalnya \(t=1\), \(t=1{,}5\), \(t=1{,}9\), dan \(t=2\). Tunjukkan bahwa semua pengamatan berakhir pada waktu yang sama, yaitu detik ke-2, sementara waktu awal semakin mendekat ke detik tersebut.]

#figure(
  caption: [Selang waktu menuju $t=2$. Semakin pendek garis, semakin kecil selang waktunya.],
  [
    #cetz.canvas(length: 1cm, {
    import cetz.draw: *
  
    let xe = 16
    let sc = 12
    let sc = 12
    let rows = (
      ([Awal: $1"s"$], 1),
      ([Awal: $1,5"s"$], .5),
      ([Awal: $1,9"s"$], .1),
      ([Awal: $1,99"s"$], .01),
    )
  
    for (i, (label, h)) in rows.enumerate() {
      let y = -i * .8
      let len = h * sc
      let x1 = xe - 0.2
      let x0 = x1 - len
      content((0, y), label, anchor: "west") 
      line((x0, y), (x1, y), stroke: (paint: cmyk_purple, thickness: 1pt, cap: "round"))
      circle((x0, y), radius: 0.08, fill: cmyk_purple, stroke: none)
      // label: kalau pendek, taruh di kiri titik supaya tidak menabrak garis t = 2
      content((x0, y - 0.4), [$#str(h).replace(".", ",")s$],
        anchor: if len < 2 { "east" } else { "north" })
    }
  
    // garis waktu akhir
    line((xe, 0.4), (xe, -3.2), stroke: (paint: cmyk_blue, thickness: 1pt, dash: "dashed"))
    content((xe, 1), [Waktu akhir \ $t = 2$], anchor: "east")
  })
  ]
)

Sebelumnya Anda telah melihat grafik kecepatan kedua pelari. Perhatikan pelari 1 tidak memiliki kuadrat dan memiliki kecepatan linier:

$ s(t)=t dot 3 $

Sedangkan pelari 2 yang mula-mula pelan menjadi cepat, dan perilaku itu ternyata merupakan fungsi dari:

$ s(t)=t^2 dot 1,5 $

dengan $t$ menyatakan waktu dalam detik dan $s(t)$ menyatakan posisi dalam meter. Menurut model tersebut, posisi kedua pelari pada detik ke-$2$ adalah $6$ meter. Sekarang, kita akan membandingkan kecepatan rata-rata pelari 2 dari beberapa selang waktu yang semuanya berakhir pada detik ke-$2$. Waktu awalnya akan kita pilih semakin dekat ke detik tersebut.

#figure(
  caption: [Kecepatan rata-rata $overline(v)$ pelari 2 pada saat selang waktu $2-t$ mengecil],
  [
    #table(
      columns: (1fr, 1fr, 1fr, 1.3fr),
      inset: 10pt,
      fill: (col, row) => {
        if row == 0 {
          cmyk_purple.lighten(90%)
        } else {
          none
        }
      },
      align: center,
      table.header(
        [$t$],
        [$s(t)$],
        [$2-t$],
        [$overline(v)$],
      ),
      [$1$],     [$1,5$],        [$1$],     [$4,5$],
      [$1,5$],   [$3,375$],      [$0,5$],   [$5,25$],
      [$1,9$],   [$5,415$],      [$0,1$],   [$5,85$],
      [$1,99$],  [$5,94015$],    [$0,01$],  [$5,985$],
      [$1,999$], [$5,9940015$],  [$0,001$], [$5,9985$],
    )
  ]
)<tur-kecepatan-rr-pelari>

Kecepatan rata-rata pada setiap baris diperoleh dari perubahan posisi dibagi selang waktu. Karena semua pengamatan berakhir pada detik ke-2, posisi akhirnya selalu $6$ meter. Misalnya, untuk selang waktu dari detik ke-$1$ sampai detik ke-$2$, kecepatan rata-ratanya adalah $(4-1)/(2-1)=6 "m/s"$.

Perhatikan perubahan nilai pada @tur-kecepatan-rr-pelari. Ketika waktu awal semakin dekat ke detik ke-$2$, selang waktu semakin pendek. Nilai kecepatan rata-rata pun semakin mendekati $6 "m/s"$.

Perilaku pendekatan selang waktu itu kita dapat visualisasikan dengan garis kemiringan sederhana seperti berikut:

// [VISUAL 4: Grafik posisi terhadap waktu untuk \(s(t)=t^2\). Tandai titik \((2,4)\) dan beberapa titik sebelumnya. Hubungkan setiap titik awal dengan titik \((2,4)\) menggunakan garis secan yang berbeda. Tampilkan bahwa semakin dekat titik awal ke titik \((2,4)\), semakin dekat kemiringan garis secan menuju kemiringan garis singgung pada titik tersebut.]

#figure(
  caption: figure.caption(position: top)[Perubahan kemiringan garis biru (#garis-sekan(paint: cmyk_blue)) penghubung dua titik ketika selang waktu semakin pendek dan mendekati $t=2$ detik.],
  gap: 1em,
  [
    #let s(t) = 1.5 * calc.pow(t, 2)
    #let t0 = 2
    #let fmt(x) = str(calc.round(x, digits: 2)).replace(".", ",")
    
    #let secant(h) = {
      let (ta, ya) = (t0 - h, s(t0 - h))   // titik kiri (bergerak)
      let yb = s(t0)                        // titik kanan (tetap)
      let v = (yb - ya) / h
    
      stack(dir: ttb, spacing: .6em,
        cetz.canvas({
          import cetz.draw: *
          set-style(axes: (stroke: cmyk_border + .8pt))
    
          plot.plot(
            size: (4.3, 4), axis-style: "school-book",
            x-label: $t$, y-label: $s$,
            x-tick-step: none, y-tick-step: none,
            x-min: -0.3, x-max: 2, y-min: -1, y-max: 6,
            {
              plot.add(s, domain: (0, 3.5), style: (stroke: cmyk_purple + 1pt))
              plot.add(t => yb + 6 * (t - t0), domain: (0.8, 2.4),
                style: (stroke: (paint: cmyk_vermil, dash: "dashed", thickness: 1pt)))
              plot.add(t => yb + v * (t - t0), domain: (0, 3.2),
                style: (stroke: cmyk_blue + 1pt))
              plot.add(((ta, ya), (t0, yb)), mark: "o", mark-size: .2,
                mark-style: (fill: cmyk_blue, stroke: white),
                style: (stroke: none))

              plot.annotate({
                if h >= 0.5 {
                  content((ta, ya + .7), $A$)
                  content((ta + h, yb + .7), $B$)
                } else if h > 0 {
                  content((ta + h / 2, ya + 1.4), $A -> B$)
                } else {
                  content((ta, ya + .9), $A = B$)
                }
              })
    
              plot.annotate(background: true, {
                let st = (dash: "dashed", paint: black)
                line((ta, 0), (ta, ya), stroke: st)
                line((t0, 0), (t0, yb), stroke: st)
                line((0, yb), (t0, yb), stroke: st)
              })
    
              plot.annotate({
                content((t0, -.5), $2$, anchor: "north", padding: .1)
                content((0, yb), $6$, anchor: "east", padding: .1)
                if h >= 0.5 {
                  content((ta, -.5), [$ta$], anchor: "north", padding: .1)
                }
              })
            },
          )
        }),
        align(center)[Selang $#fmt(h)s$ \ $overline(v) = #fmt(v) "m/s"$],
      )
    }
    
    #grid(
      columns: 3, gutter: 2em,
      secant(1), secant(.5), secant(.1),
    )
  ]
)

Kemiringan garis yang menghubungkan dua titik pada kurva menunjukkan perubahan posisi selama selang waktu di antara kedua titik tersebut. Ketika titik awal $A$ semakin mendekati titik akhir $B$, garis biru (#garis(paint: cmyk_blue)) tersebut berubah kemiringan mendekati kemiringan garis oranye (#garis(paint: cmyk_vermil, dash: "densely-dashed")). Pola ini memberikan petunjuk tentang bagaimana kita dapat memperkirakan laju perubahan pada suatu saat tertentu.

Pada awalnya, kedua pelari memiliki kecepatan rata-rata yang sama selama $2$ detik, yaitu $3 "m/s"$. Namun, ketika kita mempersempit selang pengamatan yang berakhir pada detik ke-$2$, perbedaannya mulai terlihat.

Pada pelari 1 yang bergerak dengan kecepatan tetap, kecepatan rata-ratanya selalu $3 "m/s"$, berapa pun selang waktu yang kita pilih. Sebaliknya, pada pelari 2 yang semakin cepat, kecepatan rata-ratanya meningkat, dari $4,5 "m/s"$ menjadi $5,25 "m/s"$, kemudian $5,85 "m/s"$.

Dalam pengamatan ini, $overline(v)$ menyatakan kecepatan rata-rata selama suatu selang waktu itu. Semakin pendek selang pengamatan yang berakhir pada detik ke-2, semakin dekat nilainya dengan kecepatan pelari pada saat tersebut.

Lalu, bagaimana kita dapat menentukan kecepatan tepat pada detik ke-2? Inilah pertanyaan yang akan kita jawab melalui konsep turunan.

Kita tidak dapat begitu saja memasukkan selang waktu nol ke dalam perhitungan kecepatan rata-rata, karena pembaginya juga menjadi nol. Sebaliknya, kita mempelajari apa yang terjadi ketika selang waktu semakin kecil dan mendekati nol. Gagasan tersebut menghubungkan pembahasan ini dengan konsep limit yang telah dipelajari pada bab sebelumnya.

#eksplor[

  Kita sebelumnya sudah membangun intuisi terhadap konsep turunan, coba renungkan, dan jawab pertanyaan dibawah berdasarkan intuisi Anda:
  
  + Apa yang terjadi pada kecepatan rata-rata ketika selang waktunya semakin pendek?
  + Berdasarkan tabel, berapa perkiraan kecepatan pelari tepat pada detik ke-2?
  + Apa yang ditunjukkan oleh perubahan kemiringan garis pada grafik?
  + Mengapa kita perlu menggunakan gagasan limit untuk mempelajari kecepatan pada suatu saat?
]


Pengamatan ini memberi petunjuk bahwa kita dapat memperkirakan kecepatan pada suatu saat dengan melihat perubahan posisi dalam selang waktu yang semakin kecil. Gagasan inilah yang akan kita kembangkan untuk memahami turunan.

// Turunan merupakan konsep dalam kalkulus yang digunakan untuk mengetahui seberapa cepat suatu fungsi berubah terhadap perubahan variabelnya.

// Jika suatu fungsi dinyatakan sebagai: 

// $
//   y=f(x)
// $

// maka turunan fungsi $f(x)$ terhadap $x$ dapat ditulis sebagai 

// $
//   f'(x)
// $

// Turunan juga dapat digunakan untuk mengetahui kemiringan kurva pada suatu titik, menentukan apakah suatu fungsi naik atau turun, serta mencari nilai maksimum dan minimum.

=== Garis Singgung

Dari eksplorasi sebelumnya, kita melihat bahwa semakin pendek selang waktu pengamatan, kecepatan rata-rata pelari, semakin mendekati kecepatan pada suatu saat tertentu. Bagaimana gagasan ini dapat diterapkan pada fungsi matematika secara umum?

Misalkan hubungan antara dua variabel dinyatakan sebagai:

#eq-numbered[
 $ y = f(x) $ 
]

Di sini, nilai $y$ bergantung pada $x$. Ketika $x$ berubah, nilai fungsinya tentu ikut menyesuaikan.

Sekarang, coba kita geser nilai $x$ sedikit sejauh $h$, sehingga posisinya menjadi $x + h$. Akibat geseran ini, nilai fungsi berubah dari $f(x)$ menjadi $f(x+h)$. Selisih atau respon perubahannya dapat dituliskan sebagai:

#eq-numbered[
 $ f(x+h) - f(x) $ 
]

Untuk melihat seberapa besar perubahan fungsi jika dibandingkan dengan besar geserannya, kita membagi perubahan hasil tersebut dengan jarak geserannya $h$. Hasil pembagian ini disebut laju perubahan rata-rata:

#eq-numbered[
  $ (f(x+h) - f(x)) / h $
]

Namun, angka ini baru menggambarkan rata-rata perubahan sepanjang rentang $h$, bukan laju perubahan tepat di satu titik. Supaya kita bisa mengetahui laju perubahan sesaatnya, kita perlu mengamati apa yang terjadi jika geseran $h$ tersebut dibuat sempit, dan sesempit mungkin hingga mendekati nol.

Misalkan $y=f(x)$ menyatakan suatu fungsi. Kita ingin mengetahui bagaimana nilai fungsi berubah ketika nilai $x$ berubah sedikit.

Untuk mengamatinya, kita dapat menggeser nilai $x$ sebesar $h$, sehingga posisinya menjadi $x+h$. Akibatnya, nilai fungsi berubah dari $f(x)$ menjadi $f(x+h)$.

#figure(
  caption: figure.caption(position: top)[Garis sekan berwarna biru (#garis-sekan(paint: cmyk_blue)) ketika titik $P$ dan $Q$ bertemu akan membentuk garis seperti tangen/singgung yang berwarna oranye (#garis(paint: cmyk_vermil, dash: "dashed"))],
  gap: 1em,
  [
    #grid(
      columns: 3, gutter: 2em,
      secant(2.6, guide-tangen: true, guide: true, point: true, lbl: $h$ + " besar"),
      secant(.6, guide-tangen: true, guide: true, point: true, lbl: $h$ + " mengecil"),
      secant(0, guide: true, point: true, lbl: $h -> 0$),
    )
  ]
)<garis-sekan-menjadi-tangen>

Pada @garis-sekan-menjadi-tangen, terlihat bahwa $h$ adalah jarak horizontal pada sumbu $x$, sedangkan $Delta y$ menyatakan perubahan vertikal nilai fungsinya, yaitu:

#eq-numbered[
  $ Delta y = f(x+h) - f(x) $
]

Perbandingan antara perubahan nilai fungsi $Delta y$ dengan perubahan variabelnya $h$ memberikan kemiringan garis sekan yang menghubungkan titik $P$ dan $Q$:

#eq-numbered[
  $ (Delta y)/h = (f(x+h) - f(x))/h $
]

Sekarang, perhatikan apa yang terjadi saat kita mengecilkan $h$ hingga mendekati nol ($h -> 0$). Titik $Q$ akan bergerak menyusuri kurva mendekati titik $P$. Garis sekan pun perlahan memutar hingga akhirnya berubah menjadi garis singgung/tangen tepat saat titik $P$ dan $Q$ bertumpuk ($P = Q$).

Gagasan inilah yang menjadi dasar konsep turunan. Laju perubahan sesaat di titik $P$ tersebut dinotasikan sebagai $f'(x)$, yang didefinisikan sebagai nilai limit dari perbandingan tersebut saat $h -> 0$.

// #contoh[
//   Diketahui:

//   $
//     f(x)=x^2
//   $
  
//   Tentukan persamaan garis singgung pada $x=2$.

//   $
//     f′(x)=2x\
//     f′(2)=4
//   $

//   Titik singgung:

//   $
//     (2,f(2))=(2,4)
//   $

//   Maka

//   $
//     y−4=4(x−2)\
//     y= 4x-4
//   $
// ]

=== Definisi Turunan

Proses mengecilkan $h$ hingga mendekati nol ini secara matematis dinyatakan menggunakan konsep limit. Laju perubahan sesaat yang kita kenal sebagai turunan dari fungsi $f(x)$ didefinisikan sebagai:

#eq-numbered[
  #eq-highlight[
    $ f'(x) = lim_(h -> 0) (f(x+h)-f(x))/h $
  ]
]

#info[
  Perhatikan bahwa $h$ tidak langsung dibuat sama dengan nol. Kita mencari nilai yang didekati pecahan tersebut ketika $h$ semakin mendekati nol. Dengan demikian, turunan menggambarkan laju perubahan fungsi pada nilai $x$ yang sedang diamati.
]

Dengan demikian, nilai $f'(x)$ menggambarkan laju perubahan presisi fungsi tepat pada titik $x$ yang sedang kita amati.

#funfact()[
  #meander.reflow({
    import meander: *
  
    placed(top + right, gambar-compact(
    image("../assets/bab2/mobil_bergerak.jpg"),
      caption: [Jepretan Mobil saat Bergerak],
      sumber: "unsplash.com, Kredit: Alex York, Lisensi: Lisensi Unsplash"
    ))
  
    container()
    content[
      Coba perhatikan gambar mobil di samping. Menurutmu, berapa kecepatan mobil tersebut?

      Dari satu foto saja, kita tidak bisa mengetahui kecepatannya karena foto tidak memiliki selang waktu. Namun, jika kita melihat video, mobil tersebut terlihat bergerak. Mengapa? Karena video pada dasarnya adalah sekumpulan foto yang ditangkap dalam selang waktu sangat singkat, misalnya $1/60$ detik antar-foto.
      
      Dari perubahan posisi antar-foto inilah kita dapat melihat pergerakan. Saat selang waktunya dipersempit hingga mendekati nol, kita mendapatkan kecepatan sesaat, konsep turunan ibarat menjadi "kamera pembeku waktu".

    ]
  })
]

// TODO tim: tambahkan contoh soal turunan dari definisi (limit),
// lalu lanjut ke aturan-aturan turunan di bawah.

#let bmark = mark.with(color: cmyk_blue)
#let pmark = mark.with(color: cmyk_purple)
#let gmark = mark.with(color: cmyk_green)
#let vmark = mark.with(color: cmyk_vermil)

== Aturan-Aturan Turunan

Definisi turunan memberikan dasar untuk menghitung laju perubahan suatu fungsi. Namun, menghitung turunan setiap fungsi menggunakan definisi limit secara langsung dapat memerlukan proses yang panjang.

Untuk mempermudah perhitungan, kita dapat menggunakan aturan-aturan turunan. Aturan ini membantu kita menentukan turunan berbagai bentuk fungsi tanpa harus mengulangi proses limit dari awal.

// Kalau setiap turunan harus dihitung menggunakan definisi limit, tentu akan memakan waktu cukup lama. Untungnya, terdapat beberapa aturan turunan yang dapat digunakan untuk mempermudah perhitungan.

=== Aturan Fungsi Konstan

#side-by-side(
  [
    Fungsi konstan adalah fungsi yang nilainya tetap, meskipun nilai variabel $x$ berubah. Karena tidak terjadi perubahan nilai fungsi, turunannya selalu nol.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        #eq-highlight[
          $
            f(x) = c quad => quad f'(x) = 0
          $
        ]
      ]
    ]
  ]
)

#side-by-side(
  [
    Jika $f(x)=c$, dengan $c$ suatu konstanta, maka $f'(x)=0$. Contohnya seperti disamping
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $
          f(x)&=3 \
          f'(x)&=0
        $
      ]
    ]
  ]
)

#side-by-side(
  [
    Mengapa Turunan Fungsi Konstan Sama dengan Nol?
    
    1. *Interpretasi Geometris:* Grafik $f(x) = c$ berupa garis lurus horizontal. Karena garis horizontal tidak memiliki kemiringan (gradien $= 0$), maka nilai turunannya adalah $0$.
    
    2. *Pembuktian Limit:* Berdasarkan definisi turunan:
    $
      f'(x) &= lim_(h -> 0) (f(x+h) - f(x))/h \
            &= lim_(h -> 0) (c - c)/h \
            &= lim_(h -> 0) 0/h = 0
    $
  ],
  [
    #figure(
      caption: [Grafik $f(x)=3$],
      gap: 1em,
      [
        #graph(
          step: 3,
          x: (-6, 6), y: (-6, 6), scale: .58cm,
          fn(x => 3, stroke: cmyk_purple),
        )
      ]
    )
  ] 
)

=== Aturan Pangkat

#side-by-side(
  [
    Aturan pangkat digunakan untuk menentukan turunan fungsi berbentuk $f(x) = x^n$. Caranya sederhana: pangkat $n$ "diturunkan" menjadi pengali di depan, lalu pangkat dari $x$ dikurangi satu.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        #eq-highlight[
          $ (x^n)' = n x^(n-1) $
        ]
      ]
    ]
  ]
)

#side-by-side(
  [
    Contoh: Jika $f(x) = x^5$, maka turunannya adalah:
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $ 
          f(x) &= x^pmark(5, #<tur-atr-pan-50>)\
          f'(x) &=pmark(5, #<tur-atr-pan-51>) x^(pmark(5, #<tur-atr-pan-52>)-1) \
          &= 5 x^4 
          #annot-cetz(
            (<tur-atr-pan-50>, <tur-atr-pan-51>, <tur-atr-pan-52>),
            cetz,
            {
              import cetz.draw: *
          
              set-style(mark: (end: "straight"))
              bezier-through("tur-atr-pan-50.east", (rel: (x: .2, y: -.2)), "tur-atr-pan-51.north-east", stroke: cmyk_purple + .7pt)
              bezier-through("tur-atr-pan-50.east", (rel: (x: .5, y: -.2)), "tur-atr-pan-52.north-east", stroke: cmyk_purple + .7pt)
            },
          )
        $
      ]
    ]
  ]
)

Kita sudah tahu hasilnya: turunan $x^n$ adalah $n x^(n-1)$. Tapi kenapa pangkat $n$ bisa "melompat" ke depan? Kali ini kita tidak menghafal, kita coba lihat langsung lewat sebuah kubus.

Turunan mengukur seberapa besar $f(x)$ berubah ketika $x$ digeser sedikit sebesar $h$. Sebagai contoh, ambil $f(x) = x^3$, yaitu volume kubus dengan sisi $x$. Apa yang terjadi pada volumenya jika setiap sisi kita perpanjang sebesar $h$, sehingga menjadi $x + h$?

#side-by-side(
  [
    #figure(
      kubus-meledak(),
      caption: figure.caption(position: top)[Kubus lama #kekotak(fill: cmyk_blue) $x^3$ dan bagian tambahannya: lempengan #kekotak(fill: cmyk_purple) $3x^2 h$, batang #kekotak(fill: cmyk_green) $3x h^2$, kubus mungil #kekotak(fill: cmyk_vermil) $h^3$.
      ],
      gap: 2em,
    )
  ],
  [
    Volume barunya adalah gabungan kubus lama dan semua bagian tambahan:

    $ (x+h)^3 = bmark(x^3) + pmark(3x^2 h) + gmark(3x h^2) + vmark(h^3) $
    
    Kita cek satu per satu:
    - $x^3$: kubus lama, tidak berubah.
    - $3x^2 h$: *tiga lempengan* tipis berwarna ungu berukuran $x times x times h$, masing-masing menempel di satu sisi kubus.
    - $3x h^2$: tiga batang kecil berwarna hijau di tepian kubus.
    - $h^3$: satu kubus mungil berwarna oranye di pojok.
  ]
)

Sekarang bayangkan $h$ sangat kecil, ibarat kita dekatkan ke $0$. Misalnya $x = 1$ dan $h = 0,01$:
- #kekotak(fill: cmyk_purple) Lempengan ungu: $3x^2 h = 0,03$
- #kekotak(fill: cmyk_green) Batang Hijau: $3x h^2 = 0,0003$
- #kekotak(fill: cmyk_vermil) Kubus mungil: $h^3 = 0,000001$

Perhatikan, lempengan ungu jauh lebih besar dari yang lain, dan semakin kecil $h$, bagian lain semakin tidak berarti. Itu sebabnya hanya lempengan ungu yang menentukan turunan: $(3x^2 h)/h = 3x^2$.@3b1b-derivatives-through-geometry

Lalu dari mana angka $3$ itu? Ada *3 sisi* tempat lempengan bisa menempel, sedangkan $x^2$ adalah luas satu lempengan. Jadi pangkat yang "turun" sebenarnya adalah *jumlah tempat* kita bisa menambahkan satu lapisan setebal $h$.@3b1b-derivatives-through-geometry

_"Bagaimana kalau bukan pangkat $3$?"_ Kita tidak bisa menggambar kubus berdimensi $n$, tapi idenya bisa dibawa lewat aljabar. Kubus tadi sebenarnya adalah perkalian tiga kurung, satu kurung untuk tiap dimensi (panjang, lebar, tinggi):

$ (x+h)(x+h)(x+h) $

Saat dikalikan, kita memilih satu nilai ($x$ atau $h$) dari setiap kurung. Jika $h$ diambil dari kurung "tinggi" dan $x$ dari dua kurung lainnya, hasilnya $x dot x dot h$, yaitu lempengan di atas kubus. Jika $h$ diambil dari kurung lain, hasilnya lempengan di sisi lain. Ada $3$ pilihan, maka ada $3$ lempengan.

Untuk $n$ umum, polanya sama. Kita punya $n$ buah kurung:

$ (x + h)^n = underbrace((x+h)(x+h) dots.c (x+h), n "buah kurung") $

Setiap suku hasilnya adalah satu kombinasi pilihan, dan suku-suku itu hanya berbeda dalam satu hal: *berapa kali kita memilih $h$*. Karena itulah yang menentukan apakah suatu suku bertahan di limit, kita kelompokkan berdasarkan banyaknya $h$:

+ Tanpa $h$ (pilih $x$ dari semua kurung)
  - Hasil: $x^n$.
  - Habis saat dikurangi $x^n$ di rumus turunan.

+ Tepat satu $h$ (pilih $h$ dari satu kurung, sisanya $x$)
  - Hasil: $h$ bisa datang dari kurung ke-1, ke-2, ..., atau ke-$n$. Ada *$n$ cara*, jadi suku ini adalah $n x^(n-1) h$. Ini "lempengan" versi $n$ dimensi.
  - Setelah dibagi $h$, $h$-nya habis dan suku tetap hidup.

+ Dua $h$ atau lebih (pilih $h$ dari $>= 2$ kurung)
  - Hasil: suku-suku ber-$h^2, h^3, dots.c$ (batang, kubus mungil, dan sejenisnya).
  - Setelah dibagi $h$, masih tersisa faktor $h$, sehingga bernilai $0$ saat $h -> 0$.

#teorema[
  Untuk yang penasaran. Pola pengelompokan ini dikenal sebagai *teorema binomial*. Banyaknya cara memilih $k$ buah $h$ dari $n$ kurung ditulis $binom(n, k)$ (dibaca "$n$ pilih $k$"), sehingga:

  $ (x+h)^n = sum_(k=0)^n binom(n, k) x^(n-k) h^k $

  Untuk $k = 1$ ada $binom(n, 1) = n$ cara, dan itulah angka $n$ di depan $n x^(n-1)$. Pada $n = 3$, koefisiennya $1, 3, 3, 1$, persis banyaknya kubus lama, lempengan, batang, dan kubus mungil pada gambar tadi.
]

Sekarang kita masukkan ketiganya ke definisi turunan:

$
  f'(x) &= lim_(h -> 0) ((x+h)^n - x^n)/h \
        &= lim_(h -> 0) ((cancel(x^n) + n x^(n-1) h + "suku ber-"h^2 + dots.c) - cancel(x^n))/h \
        &= lim_(h -> 0) (n x^(n-1) cancel(h) + "suku ber-"h^2 + dots.c)/cancel(h) \
        &= lim_(h -> 0) (n x^(n-1) + "suku ber-"h + dots.c) \
        &= n x^(n-1)
$

#info[
  Pembuktian di atas hanya untuk $n$ bilangan bulat positif, tetapi rumus $n x^(n-1)$ tetap berlaku untuk pangkat pecahan dan negatif. Ubah dulu bentuknya menjadi pangkat: $sqrt(x) = x^(1/2)$ dan $1/x = x^(-1)$.

  #align(center)[
    $ (sqrt(x))' = 1/2 x^(-1/2) = 1/(2 sqrt(x)) $
    $ (1/x)' = -x^(-2) = -1/x^2 $
  ]
]
=== Kelipatan Konstanta

#side-by-side(
  [
    Jika suatu fungsi dikalikan dengan konstanta, turunannya dapat diperoleh dengan mengalikan konstanta tersebut dengan turunan fungsinya.

    Alasan aljabarnya singkat: konstanta $c$ bisa dikeluarkan dari limit.

    $
      (c f(x))' &= lim_(h -> 0) (c f(x+h) - c f(x))/h \
                &= c lim_(h -> 0) (f(x+h) - f(x))/h \
                &= c f'(x)
    $

    Perhatikan @tur-kelipatan disamping, tinggi setiap titik grafik $2f(x)$ adalah dua kali tinggi $f(x)$, sehingga kemiringannya juga dua kali lipat. Begitu pula untuk konstanta $c$ mana pun: ia cukup "ikut terbawa" saat fungsinya diturunkan.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        #eq-highlight[
          $ (c f(x))' = c f'(x) $
        ]
      ]
    ]

    // TODO: Perlu perbaikan visual, elemen visual terlalu menumpuk!
    #align(center)[
      #figure(
        caption: [Fungsi $f(x)$ (#garis(paint: cmyk_blue, dash: "dashed"))  dan $2f(x)$ (#garis(paint: cmyk_purple)). Di $x$ yang sama, garis singgung ungu (#garis-singgung(paint: cmyk_purple)) $2 times$ lebih curam dari pada garis singgung biru (#garis-singgung(paint: cmyk_blue))],
        gap: 1em,
        [
          #kelipatan() 
        ]
      )<tur-kelipatan>
    ]
  ]
)

#side-by-side(
  [
    Contoh: Jika $f(x) = 4x^3$, turunkan $x^3$ dengan aturan pangkat, lalu biarkan $4$ ikut terbawa.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $
          f(x) &= pmark(4, #<tur-kon-40>) x^3 \
          f'(x) &= pmark(4, #<tur-kon-41>) (3x^2) \
          &= 12x^2
        $
      ]
    ]
  ]
)

#info[
  Konstanta yang mengalikan fungsi ikut terbawa, bukan hilang. Jangan tertukar dengan aturan turunan konstanta, yang berlaku untuk $c$ yang berdiri sendiri.
]

=== Penjumlahan dan Pengurangan

#side-by-side(
  [
    Turunan dari penjumlahan atau pengurangan beberapa fungsi dapat dihitung dengan menjumlahkan atau mengurangkan turunan masing-masing fungsi.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        #eq-highlight[
          $ (f(x) +- g(x))' \ = f'(x) +- g'(x) $
        ]
      ]
    ]
  ]
)

#side-by-side(
  [
    Sebagai contoh, kita turunkan $f(x) = 3x^2 - 5x + 2$ suku demi suku, lalu gabungkan hasilnya. Ingat aturan fungsi konstan? Suku $2$ adalah fungsi konstan, grafiknya garis mendatar dengan kemiringan $0$, sehingga turunannya $0$.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $
          f(x) &= 3x^2 - 5x + 2 \
          f'(x) &= (3x^2)' - (5x)' + (2)' \
          &= 3(2x) - 5(1) + 0 \
          &= 6x - 5
        $
      ]
    ]
  ]
)

=== Aturan Perkalian 

#side-by-side(
  [
    Ketika dua fungsi dikalikan, turunannya bukan hasil kali kedua turunannya. Contohnya, $x dot x = x^2$ turunannya $2x$, padahal $(x)' dot (x)' = 1 dot 1 = 1$. Aturan yang benar: turunkan satu fungsi dan biarkan yang lain, lalu jumlahkan kedua kemungkinannya.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        #eq-highlight[
          $ (f(x)g(x))' \
          = f'(x)g(x)+f(x)g'(x) $
        ]
      ]
    ]
  ]
)

#side-by-side(
  [
    Contohnya, turunkan $y = x^2 (x+3)$. Ambil $f(x) = x^2$ dan $g(x) = x+3$, sehingga $f'(x) = 2x$ dan $g'(x) = 1$. Cek: jika dikalikan dulu, $y = x^3 + 3x^2$, turunannya juga $3x^2 + 6x$.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $
          y' &= f'(x)g(x) + f(x)g'(x) \
             \
             &= pmark(2x, #<tur-atr-per-2x>)(pmark(x, #<tur-atr-per-x>)pmark(+3, #<tur-atr-per-3>)) + x^2(1) \
             &= pmark(2x^2) pmark(+ 6x) + x^2 \
             &= 3x^2 + 6x

          #annot-cetz(
            (<tur-atr-per-2x>, <tur-atr-per-x>, <tur-atr-per-3>),
            cetz,
            {
              import cetz.draw: *
          
              set-style(mark: (end: "straight"))
              bezier-through("tur-atr-per-2x.north", (rel: (x: .2, y: .2)), "tur-atr-per-x.north", stroke: cmyk_purple + .7pt)
              bezier-through("tur-atr-per-2x.north", (rel: (x: .2, y: .3)), "tur-atr-per-3.north", stroke: cmyk_purple + .7pt)
            },
          )
        $
      ]
    ]
  ]
)

_"Dari mana asal mula rumus ini?"_ Seperti pada kubus tadi, kita bisa melihatnya dari bentuk. Bayangkan persegi panjang dengan sisi $f(x)$ dan $g(x)$, sehingga luasnya $f(x)g(x)$. Saat $x$ bergeser sebesar $h$, kedua sisinya bertambah kira-kira sebesar $f'(x)h$ dan $g'(x)h$.

#figure(
  persegi-panjang-meledak(),
  gap: 2em,
  caption: figure.caption(position: top)[Luas $f(x) g(x)$ #kekotak(fill: cmyk_blue.lighten(30%)) bertambah dua strip #kekotak(fill: cmyk_purple.lighten(30%)) dan sudut kecil #kekotak(fill: cmyk_vermil.lighten(30%)). Sudut kecil bernilai $f'(x) g'(x) h^2$ sehingga lenyap saat $h -> 0$.
  ],
)

Pertambahan luasnya adalah dua strip ungu dan sudut oranye. Setelah dibagi $h$, strip-strip itu menjadi $f'(x)g(x)$ dan $f(x)g'(x)$, sedangkan sudut oranye masih menyisakan faktor $h$ sehingga lenyap saat $h -> 0$. Dua suku yang tersisa itulah isi aturan perkalian.

=== Aturan Pembagian

#side-by-side(
  [
    Jika suatu fungsi berbentuk hasil bagi dua fungsi, turunannya dapat dihitung menggunakan aturan pembagian, dengan syarat penyebut tidak bernilai nol.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        #eq-highlight[
          $ (f(x)/g(x))' \ =
            (f'(x)g(x)-f(x)g'(x))/(g(x))^2 
          $
        ]
      ]
    ]
  ]
)

#side-by-side(
  [
    Contohnya, turunkan $y = x^2/(x+1)$. Ambil $f(x) = x^2$ dan $g(x) = x+1$, sehingga $f'(x) = 2x$ dan $g'(x) = 1$:

    $
      g'(x) &= (x)’ + (1)’ \
            &= 1 + 0 \
            &= 1 
    $

    - $(x)' = 1$ berasal dari aturan pangkat. Karena $x = x^1$ maka $(x)' = 1x^0 = 1$.
    - $(1)' = 0$ berasal dari aturan fungsi konstan
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $
          y' &= (f'(x)g(x) - f(x)g'(x))/(g(x))^2 \
             &= (2x(x+1) - x^2(1))/(x+1)^2 \
             &= (2x^2 + 2x - x^2)/(x+1)^2 \
             &= (x^2 + 2x)/(x+1)^2
        $
      ]
    ]
  ]
)

// #info[
//   *Cara mengingat.* Mirip aturan perkalian, tetapi ada tanda minus dan penyebutnya dikuadratkan. (Atas = pembilang, bawah = penyebut.)

//   $ ("Turunan atas" times "bawah" - "atas" times "Turunan bawah")/"Bawah kuadrat" $

//   Hati-hati dengan urutannya: selalu mulai dari turunan pembilang. Jika tertukar, hasilnya berlawanan tanda.
// ]

=== Aturan Rantai

#side-by-side(
  [
    Beberapa fungsi terbentuk dari suatu fungsi yang dimasukkan ke dalam fungsi lainnya. Fungsi $g$ disebut fungsi dalam, dan $f$ disebut fungsi luar. Untuk menurunkan fungsi seperti ini, kita menggunakan aturan rantai.

    
  ],
  [
    Jika $y=f(g(x))$, maka:
    #align(horizon)[
      #eq-numbered[
        #eq-highlight[
          $ y'=f'(g(x))g'(x) $
        ]
      ]
    ]
  ]
)

Perhatikan bahwa $f'(g(x))$ artinya: turunkan $f$ lebih dulu, lalu masukkan $g(x)$ ke dalam hasilnya. Singkatnya, turunkan bagian luar (biarkan yang dalam), lalu kalikan dengan turunan bagian dalam.

#side-by-side(
  [
    Contohnya, turunkan $y = (2x+1)^3$. Fungsi dalamnya $g(x) = 2x+1$ dan fungsi luarnya $f(x) = x^3$, sehingga $f'(x) = 3x^2$ dan $g'(x) = 2$. Cek: jika dijabarkan, $y = 8x^3 + 12x^2 + 6x + 1$ dengan turunan $24x^2 + 24x + 6$, sama dengan hasil di samping.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $
          y' &= f'(g(x))g'(x) \
             &= 3(2x+1)^2 dot 2 \
             &= 6(2x+1)^2
        $
      ]
    ]
  ]
)

#info[
  Jangan lupa faktor turunan bagian dalam. Menurunkan $(2x+1)^3$ menjadi $3(2x+1)^2$ saja *salah*, karena belum dikalikan $g'(x) = 2$.
]

#side-by-side(
  [
    Dengan kata lain, turunkan fungsi bagian luar terlebih dahulu, kemudian kalikan dengan turunan fungsi bagian dalam.
  ],
  [
    Sebagai contoh,
    #align(horizon)[
      #eq-numbered[
        $ 
          y&=(3x+1)^4 \
          y'&=4(3x+1)^3 times 3 \
          y'&=12(3x+1)^3 
        $
      ]
    ]
  ]
)

// Aturan rantai digunakan ketika suatu fungsi terdiri atas fungsi di dalam fungsi. 

// Jika:

// $
//   f(x)=g(h(x))
// $

// maka:

// $
//   f'(x)= g'(h(x)) h'(x)
// $
// _
// Sederhananya: Turunkan fungsi luas, kemudian kalikan dengan turunan fungsi dalam._

// Contoh:

// $
//   f(x) = (2x+1)^3
// $

// Turunan fungsi luar:

// $
//   3(2x+1)^2
// $


// Turunan fungsi dalam:

// $
//   2
// $

// Maka:

// $
//   f'(x)= 6(2x+1)^2
// $

== Turunan Trigonometri

Aturan turunan yang telah kita pelajari berlaku untuk fungsi aljabar, sedangkan konsep tersebut juga berlaku pada fungsi trigonometri. Agar materi tidak terlalu padat, handout ini hanya membahas dua fungsi trigonometri dasar, yaitu sinus dan kosinus. Fungsi trigonometri lainnya tidak dibahas. Kedua fungsi ini memiliki grafik yang berulang, dan menariknya, turunan keduanya ternyata juga berupa fungsi trigonometri. Kita akan melihat hubungannya melalui grafik serta contoh sederhana tanpa pembuktian rumus. Pada pembahasan ini, sudut dinyatakan dalam radian karena rumus turunannya hanya berlaku dalam satuan radian.

=== Turunan Sinus

Fungsi sinus $f(x) = sin(x)$ memiliki grafik bergelombang yang terus berulang. Ketika mengamati grafiknya, kita dapat melihat bahwa kurva tidak selalu bergerak ke arah yang sama. Pada satu bagian, kurva menanjak; pada bagian lain, kurva menurun.

#figure(
  caption: [#garis(paint: cmyk_purple, length: 2em) Garis ungu: $sin(x)$. #garis(paint: cmyk_blue, dash: "densely-dashed", length: 2em) Garis biru: $cos(x)$.
  ],
  gap: 1em,
  [
    #graph(
      x: (-3 * calc.pi, 3 * calc.pi), y: (-2, 2), scale: .8799cm,
      x-step: calc.pi / 2,
      x-format: "pi",
      fn(x => calc.sin(x), stroke: cmyk_purple),
      fn(x => calc.cos(x), stroke: (dash: "dashed", paint: cmyk_blue)),
    )
  ]
)

Perhatikan hubungan kedua grafik tersebut. Ketika grafik sinus (#garis(paint: cmyk_purple)) sedang menanjak, nilai kosinus (#garis(paint: cmyk_blue, dash: "densely-dashed")) bernilai positif. Ketika grafik sinus  mencapai puncak atau lembah, nilai kosinus bernilai nol karena kemiringan grafik sinus pada titik tersebut adalah nol. Sebaliknya, ketika grafik sinus menurun, nilai kosinus bernilai negatif. Pengamatan tersebut kita dapat simpulkan pada @tur-sin-kos berikut:

#figure(
  caption: [Bukti bahwa turunan $sin(x)$ adalah $cos(x)$],
  [
    #align(center)[
      #table(
        columns: (1fr, 3em, 3em, 3em, 3em, 3em, 3em, 3em, 3em, 3em),
        inset: 10pt,
        align: (col, row) => {
          if col == 0 {
            right
          } else {
            center
          }
        },
        fill: (col, row) => {
          if col == 0 {
            cmyk_purple.lighten(90%)
          } else {
            none
          }
        },
        [$x$], [$dots.c$], [$-(3pi)/2$], [$-pi$], [$-pi/2$], [$0$], [$pi/2$], [$pi$], [$(3pi)/2$], [$dots.c$],
        [*Kemiringan* $sin(x)$], [$dots.c$], [$0$], [$-1$], [$0$], [$1$], [$0$], [$-1$], [$0$], [$dots.c$],
        [*Nilai* $cos(x)$], [$dots.c$], [$0$], [$-1$], [$0$], [$1$], [$0$], [$-1$], [$0$], [$dots.c$],
      )
    ]
  ]
)<tur-sin-kos>

Pengamatan ini menunjukkan bahwa nilai kosinus berkaitan dengan kemiringan grafik sinus pada setiap nilai $x$. Secara matematis, hubungan tersebut dinyatakan melalui aturan turunan berikut.

$ (dif sin(x))/(dif x) = cos(x) $

#side-by-side(
  [
    Perlu diingat bahwa rumus ini berlaku ketika sudut $x$ dinyatakan dalam radian. 
  ],
  [
    Sebagai contoh, jika

    $ f(x) = 3 sin(x) $
  ]
)

#side-by-side(
  [
    maka, menggunakan aturan kelipatan konstanta, diperoleh:
  ],
  [
    #align(horizon)[
      $ f'(x) = 3 cos(x) $
    ]
  ]
)

=== Turunan Kosinus

Pada bagian sebelumnya, kita telah melihat bahwa turunan fungsi sinus berkaitan dengan fungsi kosinus. Sekarang, bagaimana dengan fungsi kosinus itu sendiri?

Perhatikan grafik fungsi kosinus $f(x) = cos(x)$. Pada awal kurva, grafik bergerak menurun hingga mencapai titik terendah. Setelah itu, grafik kembali meningkat. Perubahan arah ini menunjukkan bahwa kemiringan grafik kosinus tidak selalu sama.

#figure(
  caption: [#garis(paint: cmyk_purple, length: 2em) Garis ungu: $cos(x)$. #garis(paint: cmyk_blue, dash: "densely-dashed", length: 2em) Garis biru: $-sin(x)$.
  ],
  gap: 1em,
  [
    #graph(
      x: (-3 * calc.pi, 3 * calc.pi), y: (-2, 2), scale: .8799cm,
      x-step: calc.pi / 2,
      x-format: "pi",
      fn(x => calc.cos(x), stroke: cmyk_purple),
      fn(x => -calc.sin(x), stroke: (dash: "dashed", paint: cmyk_blue)),
    )
  ]
)

Ketika grafik kosinus (#garis(paint: cmyk_purple)) menurun, nilai turunannya (#garis(paint: cmyk_blue, dash: "densely-dashed")) negatif. Ketika grafik mencapai titik maksimum atau minimum, nilai turunannya nol karena garis singgungnya mendatar. Sebaliknya, ketika grafik kosinus meningkat, nilai turunannya positif. Pengamatan tersebut kita dapat simpulkan pada @tur-kos-minsin berikut:

#figure(
  caption: [Bukti bahwa turunan $cos(x)$ adalah $-sin(x)$],
  [
    #align(center)[
      #table(
        columns: (1fr, 3em, 3em, 3em, 3em, 3em, 3em, 3em, 3em, 3em),
        inset: 10pt,
        align: (col, row) => {
          if col == 0 {
            right
          } else {
            center
          }
        },
        fill: (col, row) => {
          if col == 0 {
            cmyk_purple.lighten(90%)
          } else {
            none
          }
        },
        [$x$], [$dots.c$], [$-(3pi)/2$], [$-pi$], [$-pi/2$], [$0$], [$pi/2$], [$pi$], [$(3pi)/2$], [$dots.c$],
        [*Kemiringan* $cos(x)$], [$dots.c$], [$-1$], [$0$], [$1$], [$0$], [$-1$], [$0$], [$1$], [$dots.c$],
        [*Nilai* $-sin(x)$], [$dots.c$], [$-1$], [$0$], [$1$], [$0$], [$-1$], [$0$], [$1$], [$dots.c$],
      )
    ]
  ]
)<tur-kos-minsin>

Perhatikan bahwa grafik $y = -sin(x)$ mengikuti perubahan kemiringan tersebut. Tanda negatif diperlukan agar nilainya sesuai dengan arah perubahan grafik kosinus.

Hubungan ini dinyatakan dalam aturan turunan berikut.

$ (dif cos(x))/(dif x) = -sin(x) $

#side-by-side(
  [
    Dengan demikian, turunan fungsi kosinus adalah negatif sinus. Seperti pada turunan sinus, rumus ini berlaku ketika sudut $x$ dinyatakan dalam radian.
  ],
  [
    Sebagai contoh, jika
    $ f(x) = 2 cos(x) $
  ]
)

#side-by-side(
  [
    maka, menggunakan aturan kelipatan konstanta, diperoleh
  ],
  [
    Sebagai contoh, jika
    $ f'(x) = -2 sin(x) $
  ]
)

// Sepertinya kita tidak perlu mengajarkan trigonometri secara detail? Karena tidak ada dalam cakupan tugas PSAJ
// #align(center)[
//   #figure(
//     table(
//       columns: (1fr, 1fr),
//       inset: 17pt,
//       fill: (col, row) => {
//         if row == 0 {
//           cmyk_purple.lighten(90%)
//         } else {
//           none
//         }
//       },
//       align: left,

//       [*Fungsi*], [*Turunan*],

//       [$f(x)=sin x$],
//       [$f′(x)=cos x$],

//       [$f(x)=cos x$],
//       [$f′(x)=−sin x$],

//       [$f(x)=tan x$],
//       [$f′(x)=sec^2 x$],

//       [$f(x)=cot x$],
//       [$f'(x) =csc^2 x$],

//       [$f(x)=sec x$],
//       [$f'(x)= sec x tan x$],

//       [$f(x)=csc x$],
//       [$f'(x)= -csc x cot x$],
//     ),
//     caption: [Turunan Fungsi Trigonometri]
//   )
// ]

// #v(16pt)

// Contoh

// $
//   f(x)= 3 sin x +2 cos x
// $

// Maka:

// $
//   f'(x)= 3 cos x - 2 sin x 
// $

// === Turunan Fungsi Eksponensial\

// Untuk fungsi eksponensial:

// $
//   f(x)= e^x
// $

// maka:

// $
//   f'(x)= e^x
// $

// Sedangkan jika:

// $
//   f'(x)= a^x ln a
// $

// Untuk fungsi eksponensial yang berbentuk $e^(f(x))$, gunakan aturan rantai:

// $
//   d/(d x) e^(f(x)) = e^(f(x)) f'(x)
// $
// \

== Analisis Perilaku Fungsi

// #meander.reflow({
//   import meander: *

//   placed(horizon + right, gambar-compact(
//   image("../assets/bab2/grafik-trading.jpg"),
//     caption: [Grafik saham kripto],
//     sumber: "unsplash.com, Kredit: Aedrian Salazar, Lisensi: Lisensi Unsplash"
//   ))

//   container()
//   content[
//     Turunan tidak hanya digunakan untuk menghitung laju perubahan suatu fungsi. Informasi dari turunan juga dapat membantu kita memahami perilaku grafik, seperti kapan suatu fungsi meningkat atau menurun, serta bagaimana bentuk grafik berubah.
//   ]
// })

Turunan tidak hanya digunakan untuk menghitung laju perubahan suatu fungsi. Informasi dari turunan juga dapat membantu kita memahami perilaku grafik, seperti kapan suatu fungsi meningkat atau menurun, serta bagaimana bentuk grafik berubah.

=== Fungsi Naik dan Fungsi Turun

Pernahkah kamu melihat grafik keuntungan sebuah usaha? Pada awalnya, semakin banyak produk yang terjual, keuntungan semakin besar. Namun, setelah mencapai jumlah tertentu, keuntungan dapat kembali menurun karena biaya produksi atau faktor lainnya.

Pada grafik seperti ini, ada bagian yang naik dan ada bagian yang turun. Turunan dapat membantu kita menentukan keduanya.

Keadaan ketika suatu fungsi mencapai nilai tertinggi disebut maksimum, sedangkan keadaan ketika fungsi mencapai nilai terendah disebut minimum.

Turunan dapat membantu kita menemukan titik tersebut.

#side-by-side(
  [
    #figure(
      caption: [Grafik $f(x)=x^3-3x$],
      gap: 1em,
      [
        #graph(
          x: (-4, 4), y: (-4, 4), scale: .8799cm,
          fn(x => calc.pow(x, 3) - (3 * x), stroke: cmyk_purple),
        )
      ]
    )
  ],
  [
    Perhatikan sebuah grafik fungsi dari kiri ke kanan, ketika nilai $x$ semakin bertambah ke kanan. Pada bagian tertentu, grafik dapat bergerak naik. Namun, pada bagian lainnya, grafik justru bergerak turun.

    Suatu fungsi dikatakan *naik* pada suatu interval jika nilai fungsi semakin besar ketika nilai $x$ bertambah. Sebaliknya, fungsi dikatakan *turun* jika nilai fungsi semakin kecil ketika nilai $x$ bertambah.

    Lalu, bagaimana turunan membantu kita menentukan kedua perilaku tersebut?
  ]
)

Ingat bahwa turunan menyatakan kemiringan garis singgung pada grafik. Jika nilai turunan positif, grafik cenderung terlihat menanjak. Jika nilai turunan negatif, grafik cenderung menurun kebawah.

Secara matematis, pada suatu interval berlaku:

- Jika $f'(x) > 0$, fungsi naik.
- Jika $f'(x) < 0$, fungsi turun.

Dengan demikian, kita dapat menggunakan tanda turunan untuk menentukan interval naik dan turun tanpa harus mengamati grafik satu per satu.

Sebagai contoh, tinjau kembali fungsi tadi:

$ f(x) = x^3 - 3x $

Turunan pertamanya adalah

$ f'(x) = 3x^2 - 3 $

Untuk menentukan interval naik dan turun, kita perlu tahu di mana tanda $f'(x)$ berganti. Tanda turunan hanya bisa berganti dari positif ke negatif (atau sebaliknya) melalui titik tempat turunannya bernilai $0$, yaitu ketika garis singgungnya mendatar. Jadi kita cari dulu titik-titik itu:

$
  3x^2 - 3 &= 0 \
  3x^2 &= 3 \
  x^2 &= 1 \
  x &= -1 or x = 1
$


Perhatikan bahwa $x^2 = 1$ punya dua jawaban, karena $(-1)^2 = 1$ dan $1^2 = 1$.

Kedua nilai tersebut membagi garis bilangan menjadi tiga interval. Karena tanda tidak berganti di dalam interval, cukup ambil satu titik uji di tiap interval lalu hitung $f'$ di titik itu.

#figure(
  caption: [Tanda $f'(x)$ dan perilaku $f(x) = x^3 - 3x$ pada tiap interval.],
  [
    #table(
      columns: (1fr, 1fr, 1fr, 1fr),
      inset: 10pt,
      fill: (col, row) => if row == 0 { cmyk_purple.lighten(90%) } else { none },
      align: center,
      table.header([*Interval* $x$], [*Uji nilai* $x$], [$f'(x)$], [*Perilaku fungsi*]),
      [$x < -1$], [$-2$], [$3(4) - 3 = 9 > 0$], [Naik],
      [$-1 < x < 1$], [$0$], [$3(0) - 3 = -3 < 0$], [Turun],
      [$x > 1$], [$2$], [$3(4) - 3 = 9 > 0$], [Naik],
    )
  ]
)

Dari tabel tersebut, perilaku fungsi dapat ditulis dengan notasi interval, jadi fungsi naik dapat ditulis seperti $(-infinity, -1)$ dan $(1, infinity)$, serta turun pada interval $(-1, 1)$. @wp-interval-math

Perlu diingat, tanda turunan nol belum cukup untuk menentukan apakah suatu titik merupakan maksimum atau minimum. Untuk memahaminya, kita akan membahas titik stasioner pada bagian berikutnya.

// #contoh[
//   Diketahui:

//   $
//     f(x)=x^2−4x+3
//   $

//   Turunannya:

//   $
//     f′(x)=2x−4
//   $

//   Fungsi turun ketika:

//   $
//     2x−4<0
//   $

//   Fungsi naik ketika:

//   $
//     2x−4>0\
//     x>2
//   $

//   Jadi:

//   Fungsi turun ketika $x<2 $

//   Fungsi naik ketika $x>2$
// ]

=== Titik Stasioner

Pada bagian sebelumnya, kita telah menggunakan turunan untuk menentukan interval fungsi naik dan fungsi turun. 

Masih ingat garis singgung? Di bagian grafik yang menanjak atau menurun, garis singgungnya miring. Tetapi di beberapa titik, kasusnya berbeda: garis singgungnya mendatar.

Bayangkan sebuah mobil yang melaju, lalu berhenti di lampu merah. Misalkan $f(t)$ adalah posisi mobil pada waktu $t$, sehingga $f'(t)$ adalah kecepatannya. Saat mobil berhenti, kecepatannya nol, $f'(t) = 0$, dan posisinya tidak berubah sama sekali. Keadaan "diam sesaat" inilah yang disebut *stasioner*.

Setelah lampu hijau, mobil bisa melanjutkan ke arah yang sama, atau berbalik arah. Keduanya sama-sama diawali kecepatan nol, tetapi akibatnya berbeda. Itulah yang akan kita bedakan di bagian ini dan bagian berikutnya.

#side-by-side(
  [
    #figure(
      caption: [Grafik $f(x)=x^3-3x$ dengan anotasi titik maksimum dan minimum serta garis singgung oranye (#garis-singgung(paint: cmyk_vermil))],
      gap: 1em,
      [
        #graph(
          x: (-4, 4), y: (-4, 4), scale: .8799cm,
          points((1, -2), stroke: cmyk_vermil),
          points((-1, 2), stroke: cmyk_vermil),
          segment((0, 2), (1, 2), extend: true, stroke: (dash: "solid", paint: cmyk_vermil)),
          segment((0, -2), (1, -2), extend: true, stroke: (dash: "solid", paint: cmyk_vermil)),
          fn(x => calc.pow(x, 3) - (3 * x), stroke: cmyk_purple),
        )
      ]
    )
  ],
  [ 
    Perhatikan bahwa di antara kedua interval tersebut, grafik dapat memiliki titik tempat kurva berhenti menanjak atau menurun sebelum melanjutkan arah perubahannya.

    Pada titik-titik tersebut, garis singgung grafik mendatar sehingga gradiennya bernilai nol. Titik pada grafik yang memenuhi kondisi ini disebut *titik stasioner*.

    Secara matematis, titik stasioner suatu fungsi yang dapat diturunkan dapat dicari dengan memenuhi syarat

    $ f'(x) = 0 $
  ]
)

Untuk menentukan titik stasioner, kita dapat mengikuti langkah berikut.

+ Tentukan turunan pertama fungsi, yaitu $f'(x)$.
+ Selesaikan persamaan $f'(x) = 0$ untuk memperoleh nilai $x$.
+ Substitusikan setiap nilai $x$ ke fungsi awal untuk memperoleh koordinat $y$.

Sebagai contoh, kita gunakan kembali $f(x) = x^3 - 3x$. Pada bagian sebelumnya kita sudah memperoleh $f'(x) = 3x^2 - 3$, yang bernilai $0$ di $x = -1$ dan $x = 1$. Itu berarti langkah 1 dan 2 sudah selesai, tinggal langkah 3: substitusikan nilai $x$ tersebut ke fungsi awal $f$ (bukan ke $f'$, karena $f'$ di titik itu pasti $0$ dan itu bukan tinggi grafiknya).

$
  f(-1) &= (-1)^3 - 3(-1) = 2 \
  f(1) &= 1^3 - 3(1) = -2
$

Jadi titik stasionernya adalah $(-1, 2)$ dan $(1, -2)$, yaitu dua titik ungu pada gambar.

// Pada bagian berikutnya, kita akan mempelajari cara membedakan titik stasioner yang merupakan maksimum dan minimum.

// #contoh[
//   Misalkan keuntungan suatu usaha dinyatakan dengan

//   $
//     P(x)=−x^2+40x−100
//   $

//   dengan $x$ menyatakan jumlah produk yang dijual dan $P(x)$ menyatakan keuntungan dalam ribuan rupiah.

//   Turunan pertama:
//   $P′(x)=−2x+40$

//   Untuk mencari titik stasioner:

//   $
//     P′(x)=0\
//     −2x+40=0\
//     x=20.
//   $

//   Artinya, jumlah produk yang menghasilkan titik kritis adalah 20 produk.

//   Kemudian: 
  
//   $
//     P(20)=−(20)2+40(20)−100\
//     P(20)=300.
//   $
// ]

=== Maksimum dan Minimum

Pada bagian sebelumnya, kita telah menemukan titik stasioner, yaitu titik ketika turunan pertama bernilai nol. Namun, seperti yang telah kita pelajari, tidak semua titik stasioner merupakan maksimum atau minimum.

Lalu, bagaimana kita membedakannya?

#side-by-side(
  [
    #figure(
      caption: [Grafik $f(x)=x^3-3x$ dengan anotasi titik maksimum dan minimum],
      gap: 1em,
      [
        #graph(
          x: (-4, 4), y: (-4, 4), scale: .8799cm,
          points((1, -2), stroke: cmyk_purple),
          points((-1, 2), stroke: cmyk_purple),
          fn(x => calc.pow(x, 3) - (3 * x), stroke: cmyk_purple),
        )
      ]
    )
  ],
  [
    Perhatikan kembali bentuk grafik fungsi di samping. Ketika grafik yang semula naik kemudian berbalik turun, terdapat titik puncak yang disebut *maksimum lokal*. Sebaliknya, ketika grafik yang semula turun kemudian berbalik naik, terdapat titik lembah yang disebut *minimum lokal*.

    Maksimum lokal adalah titik yang nilai fungsinya lebih besar daripada nilai fungsi di titik-titik sekitarnya. Sementara itu, minimum lokal adalah titik yang nilai fungsinya lebih kecil daripada nilai fungsi di titik-titik sekitarnya.
  ]
)

Untuk fungsi yang dapat diturunkan, kita dapat menentukan maksimum dan minimum lokal dengan memeriksa perubahan tanda turunan pertama di sekitar titik stasioner. Perhatikan perubahan berikut.

- Jika tanda turunan berubah dari positif menjadi negatif, fungsi berubah dari naik menjadi turun. Titik tersebut merupakan maksimum lokal.
- Jika tanda turunan berubah dari negatif menjadi positif, fungsi berubah dari turun menjadi naik. Titik tersebut merupakan minimum lokal.
- Jika tanda turunan tidak berubah, titik tersebut bukan maksimum maupun minimum. Contohnya $f(x) = x^3$ di $(0, 0)$.

Sebagai contoh, kita gunakan kembali $f(x) = x^3 - 3x$ dengan $f'(x) = 3x^2 - 3$. Dari pembahasan sebelumnya, kita telah memperoleh titik stasioner pada $x = -1$ dan $x = 1$, serta tanda turunan pada setiap interval.

#figure(
  caption: [Perubahan tanda $f'(x)$ di sekitar titik stasioner dan jenisnya],
  [
    #table(
      columns: (1.1fr, 1fr, 1.5fr),
      inset: 10pt,
      fill: (col, row) => if row == 0 { cmyk_purple.lighten(90%) } else { none },
      align: center,
      table.header(
        [*Titik stasioner*],
        [*Perubahan tanda*],
        [*Kesimpulan*],
      ),
      [$x = -1$], [$+ -> -$], [Maksimum lokal],
      [$x = 1$], [$- -> +$], [Minimum lokal],
    )
  ]
)

Kita juga sudah menghitung $f(-1) = 2$ dan $f(1) = -2$. Dengan demikian:

- Di $x = -1$ terdapat maksimum lokal. Nilai maksimumnya $2$, dan titiknya $(-1, 2)$.
- Di $x = 1$ terdapat minimum lokal. Nilai minimumnya $-2$, dan titiknya $(1, -2)$.

Perlu diperhatikan bahwa maksimum dan minimum lokal hanya membandingkan nilai fungsi di sekitar titik tersebut. Di luar sekitar itu, grafik masih terus naik dan turun lebih jauh. Misalnya $f(3) = 18$ lebih besar daripada maksimum lokal $2$, dan $f(-3) = -18$ lebih kecil daripada minimum lokal $-2$.

// #contoh[
//   Sebuah usaha memiliki fungsi keuntungan:

//   $
//     P(x)=−x^2+40x−100
//   $

//   dengan $x$ menyatakan banyak produk yang terjual dan $P(x)$ menyatakan keuntungan dalam ribuan rupiah. Tentukan jumlah produk yang harus dijual agar keuntungan maksimum.

//   Penyelesaian:

//   *Turunkan fungsi:*

//   $
//     P′(x)=−2x+40
//   $

//   *Untuk mencari titik stationer:*

//   $
//     P′(x)=0\
//     −2x+40=0\
//     x=20
//   $

//   Jadi, jumlah produk yang menghasilkan keuntungan maksimum adalah 20 produk.

//   *Untuk mengetahui besar keuntungannya:*

//   $
//     P(20)=−(20)2+40(20)−100\
//     P(20)=−400+800−100\
//     P(20)=300
//   $

//   Karena satuannya ribuan rupiah, maka keuntungan maksimum adalah:
//   $
//     R p 300.000
//   $

//   *Kesimpulan:*

//   Usaha tersebut memperoleh keuntungan maksimum sebesar Rp300.000 ketika menjual 20 produk.
// ]

=== Turunan Kedua

#meander.reflow({
  import meander: *

  placed(top + right, gambar-compact(
  image("../assets/bab2/ssc_tuatara.jpg"),
    caption: [SSC Tuatara merupakan mobil produksi _sport_ dengan rekor kecepatan tercepat (2021), hingga 455,3 km/h@wp-fastest-prod-car],
    sumber: "commons.wikimedia.org, Kredit: SSCNA, Lisensi: CC BY-SA 4.0"
  ))

  container()
  content[
    Pernahkah kamu terdorong ke sandaran kursi saat mobil tancap gas? Yang menekan punggungmu bukanlah kecepatan, melainkan percepatan, yaitu seberapa cepat kecepatan itu sendiri berubah. Mobil yang melaju stabil pada 300 km/h justru tidak terasa mendorong sama sekali.

    Jika posisi mobil adalah fungsi waktu $f(t)$, turunan pertamanya $f'(t)$ adalah kecepatan. Percepatan adalah laju perubahan kecepatan, sehingga diperoleh dengan menurunkan sekali lagi. Hasilnya disebut turunan kedua.
  ]
})

// #align(center)[
//   $ underbrace(f(t), "posisi") quad limits(->)^"turunkan" quad underbrace(f'(t), "kecepatan") quad limits(->)^"turunkan" quad underbrace(f''(t), "percepatan") $
// ]

#align(center)[
  #figure(
    caption: figure.caption(position: top)[Alur menurunkan turunan],
    gap: 1em,
    [
      // #diagram(
      // 	edge-stroke: 1pt,
      // 	node-corner-radius: 4pt,
      //  spacing: 8em,
      
      // 	node((0,0), [$ F(x) $], stroke: cmyk_purple),
      //  node((1,0), [$ f(x) $], stroke: cmyk_purple),
      //  node((2,0), [$ F(x) + C $], stroke: cmyk_purple),
      
      // 	edge((0,0), "r", "-|>", label: [Turunan]),
      //  edge((1,0), "r", "-|>", label: [Antiturunan])
      // )

      #grid(
        columns: (4.6cm, 1.4cm, 4.6cm, 1.4cm, 4.6cm),
        rows: (auto, 1cm),
        column-gutter: 1pt,
        align: center + horizon,
        kotak-smart-art[$f(x)$ \ #text(size: 11.5pt)[Posisi]], panah, kotak-smart-art[$f(x)'$ \ #text(size: 11.5pt)[Kecepatan]], panah, kotak-smart-art[$f(x)''$ \ #text(size: 11.5pt)[Percepatan]],
        [], label[turunkan], [], label[turunkan], [],
      )
    ]    
  ) 
]

Untuk fungsi umum, jika turunan pertamanya adalah $f'(x)$, maka turunan keduanya dinyatakan sebagai:

$ f''(x) = (f'(x))' $

Artinya, turunan kedua diperoleh dengan menurunkan turunan pertama sekali lagi.

Sebagai contoh, kita gunakan kembali $f(x) = x^3 - 3x$ dengan $f'(x) = 3x^2 - 3$. Turunkan sekali lagi dengan aturan turunan yang sebelumnya kita telah pelajari:

$
  f''(x) &= (3x^2 - 3)' \
         &= 3(2x) - 0 \
         &= 6x
$

Gambar berikut menyusun ketiga fungsi itu sejajar pada sumbu $x$ yang sama.

#figure(
  caption: [
    #garis(paint: cmyk_purple) $f(x)$, #garis(paint: cmyk_blue) $f'(x)$, dan #garis(paint: cmyk_vermil) $f''(x)$. Skala sumbu $y$ tiap panel berbeda.
  ],
  gap: 1em,
  tiga-turunan(c1: cmyk_purple, c2: cmyk_blue, c3: cmyk_vermil, sumbu-y: "tengah"),
)

// BARU: cara membaca gambar, lalu hasil f'' dimaknai
Bacalah dari atas ke bawah dengan memperhatikan garis putus-putus. Di $x = -1$ dan $x = 1$, grafik $f'$ memotong sumbu $x$ (nilainya $0$), dan di titik yang sama grafik $f$ berupa puncak dan lembah. Itulah titik stasioner yang sudah kita kenal. Sekarang perhatikan panel terbawah, yaitu $f''$:

- Di $x = -1$, $f''(-1) = -6 < 0$. Grafik $f'$ sedang menurun (dari positif menjadi negatif), dan $f$ membentuk puncak.
- Di $x = 1$, $f''(1) = 6 > 0$. Grafik $f'$ sedang naik (dari negatif menjadi positif), dan $f$ membentuk lembah.

// UBAH: "cenderung" dihapus karena tandanya pasti menentukan arah f'
Secara umum, jika $f''(x) < 0$ pada suatu interval, maka $f'$ turun pada interval itu. Jika $f''(x) > 0$, maka $f'$ naik. Di sini terlihat bahwa $f''(x)$ adalah turunan dari $f'(x)$, sehingga $f''$ menyatakan kemiringan grafik $f'$.

#funfact(pecah: false)[
  _"Apakah turunan kedua bisa diturunkan lagi?"_ Tentu bisa! Turunan kedua pun boleh diturunkan, dan hasilnya disebut turunan ketiga, lalu keempat, dan seterusnya. Untuk $f(x) = x^3 - 3x$:

  #align(center)[
    $ f(x) quad -> quad f'(x) = 3x^2 - 3 quad -> quad f''(x) = 6x quad -> quad f'''(x) = 6 quad -> quad f^((4))(x) = 0 $
  ]

  Pada fungsi polinomial, pangkatnya turun satu tiap kali diturunkan sampai akhirnya menjadi konstanta, lalu $0$. Notasi umumnya $f^((n))(x)$ untuk turunan ke-$n$.

  Pada mobil tadi, turunan ketiga posisi disebut sentakan (_jerk_): seberapa cepat percepatan berubah. Itulah yang terasa saat pengemudi menginjak gas atau rem secara tiba-tiba.
]

// (tidak berubah, hanya digabung dengan pembuka) Penutup
Informasi ini membantu kita memahami bentuk grafik secara lebih mendalam. Pada bagian berikutnya, kita akan menggunakannya untuk mempelajari kecekungan grafik dan titik belok.

// #contoh[
//   Jika:

// $
//   y=f(x)
// $

// maka:

// $
//   y′=f′(x)
// $

// dan

// $
//   y''=f''(x)
// $

// dengan  

// $
//   f''(x)=d/(d x) [f'(x)]
// $

// ]

=== Kecekungan dan Titik Belok

// BARU: pembuka dari mobil yang sama (percepatan), menjawab "kenapa penting"
Ingat mobil tadi? Saat pengemudi menginjak gas, kecepatan bertambah, sehingga kemiringan grafik posisi makin lama makin besar. Saat menginjak rem, kecepatan berkurang dan kemiringannya makin kecil. Perubahan kemiringan ini terlihat pada grafik sebagai lengkungan.

// UBAH: dua paragraf lama dipadatkan, menyambung ke bagian sebelumnya
Pada bagian sebelumnya kita sudah tahu bahwa $f''(x) > 0$ berarti $f'$ naik. Bentuk grafik yang demikian disebut cekung ke atas, seperti mangkuk yang dapat menampung air. Sebaliknya, jika $f''(x) < 0$, grafik cekung ke bawah, seperti bukit.

- Jika $f''(x) > 0$, grafik cekung ke atas.
- Jika $f''(x) < 0$, grafik cekung ke bawah.

// BARU: gambar A, menunjukkan "bagian mana"
Cara mudah mengenalinya: di sekitar titik singgungnya, kurva yang cekung ke atas berada *di atas* garis singgung, sedangkan kurva yang cekung ke bawah berada *di bawah* garis singgung.

#figure(
  caption: [Grafik $f(x) = x^3 - 3x$ dengan garis singgung hitam (#garis-singgung(paint: black)). Di kiri $x = 0$ kurva di bawah garis singgungnya (cekung ke bawah), di kanan $x = 0$ kurva di atas garis singgungnya (cekung ke atas).],
  gap: 1em,
  cekung-singgung(c-kiri: cmyk_purple, c-kanan: cmyk_blue, c-belok: cmyk_vermil, lebar: 10, tinggi: 7),
)

// UBAH: titik belok didefinisikan dari gambar, dengan tautan ke mobil
Pada $x = 0$, kecekungan berubah dari cekung ke bawah menjadi cekung ke atas. Titik tempat perubahan itu terjadi disebut *titik belok*. Pada mobil, itu adalah saat percepatan berganti tanda, misalnya dari menginjak rem menjadi menginjak gas.

// UBAH: tabel dipertahankan sebagai satu-satunya ringkasan; kalimat kembarnya dihapus
#figure(
  caption: [Tanda $f''(x)$ dan kecekungan $f(x)$ pada tiap interval.],
  table(
    columns: (1.1fr, 1fr, 1.4fr),
    align: center,
    inset: 10pt,
    fill: (col, row) => if row == 0 { cmyk_purple.lighten(90%) } else { none },
    table.header([*Interval*], [*Tanda* $f''(x)$], [*Kecekungan*]),
    [$x < 0$], [$-$], [Cekung ke bawah],
    [$x > 0$], [$+$], [Cekung ke atas],
  )
)

// BARU: gambar B, memakai ulang gambar tiga panel
Gambar berikut memakai tiga panel yang sama seperti sebelumnya, kali ini dengan garis putus-putus di $x = 0$. Perhatikan bahwa $f''$ memotong sumbu $x$ tepat di sana (nilainya $0$ dan tandanya berganti), dan $f'$ berada di titik terendahnya, yaitu $f'(0) = -3$. Artinya, di titik belok grafik $f$ sedang paling curam menurun.

#figure(
  caption: [Pada $x = 0$, $f''$ berganti tanda, $f'$ mencapai titik terendah, dan $f$ berubah kecekungan. Skala sumbu $y$ tiap panel berbeda.],
  gap: 1em,
  tiga-turunan(garis: (0,), c1: cmyk_purple, c2: cmyk_blue, c3: cmyk_vermil),
)

Untuk menentukan titik belok, kita dapat mengikuti langkah berikut.

+ Tentukan turunan kedua, yaitu $f''(x)$.
+ Selesaikan persamaan $f''(x) = 0$.
+ Periksa tanda $f''(x)$ di sebelah kiri dan kanan nilai tersebut. Titik belok terjadi jika tandanya berganti.
+ Substitusikan nilai $x$ ke fungsi awal untuk memperoleh koordinat titik belok.

Pada contoh kita, $f''(x) = 6x$ bernilai $0$ di $x = 0$. Dari tabel di atas, tandanya berganti dari negatif menjadi positif, jadi kecekungan memang berubah. Karena $f(0) = 0$, grafik $f(x) = x^3 - 3x$ memiliki titik belok di $(0, 0)$.

Perlu diingat bahwa $f''(x) = 0$ saja tidak cukup. Misalnya $f(x) = x^4$ memiliki $f''(x) = 12x^2$, yang bernilai $0$ di $x = 0$, tetapi tidak pernah negatif. Kecekungannya tetap ke atas di kedua sisi, sehingga di $(0, 0)$ tidak ada titik belok.

// HACK: Pagebreak
#pagebreak()

== Penerapan Turunan

Turunan dapat digunakan untuk memecahkan beberapa masalah seperti berikut:

=== Kecepatan dan Percepatan

Turunan dapat digunakan untuk memahami gerak suatu benda. Jika posisi benda dinyatakan sebagai fungsi waktu, turunan pertama menunjukkan kecepatan, sedangkan turunan kedua menunjukkan percepatan. @aulia-peran-kalkulus-teknologi

Secara matematis, jika posisi benda dinyatakan sebagai $s(t)$, maka:

$ v(t) = s'(t) quad "dan" quad a(t) = v'(t) = s''(t) $

dengan $v(t)$ menyatakan kecepatan (_velocity_) dan $a(t)$ menyatakan percepatan (_acceleration_) pada waktu $t$.

Gerak bola yang dilempar ke atas menunjukkan hubungan keduanya dengan jelas. Di titik tertinggi, bola berhenti sesaat sebelum jatuh, sehingga kecepatannya $0$ (garis singgung mendatar, seperti titik stasioner). Namun, percepatannya tidak ikut menjadi nol, karena gravitasi tetap menarik bola ke bawah.

#figure(
  grafik-bola(),
  caption: [Ketinggian bola $h(t) = -5t^2 + 20t + 2$. Di puncak, kecepatan $0$ tetapi percepatan tetap ke bawah.],
)

Sebuah bola dilempar vertikal ke atas dari ketinggian 2 meter. Ketinggian bola setelah $t$ detik dinyatakan oleh fungsi

$ h(t) = -5t^2 + 20t + 2 $

dengan $h(t)$ dalam meter dan $t$ dalam detik. Abaikan hambatan udara.

Tentukan kapan bola mencapai titik tertinggi, berapa tinggi maksimumnya, dan berapa percepatan bola saat itu.

#penyelesaian(judul: [1. Tentukan waktu titik tertinggi],
  [
    Di titik tertinggi, kecepatan bola nol. Turunkan $h(t)$ untuk mendapat kecepatan, lalu samakan dengan nol.
  
    $ v(t) = h'(t) = -10t + 20 $
  
    $
      -10t + 20 = 0
      \
      t = #markrect([$quad 2$], outset: 3pt)
    $
  
    Jadi, bola mencapai titik tertinggi setelah 2 detik.
  ]
)

#penyelesaian(judul: [2. Tentukan tinggi maksimum],
  [
    Substitusikan $t = 2$ ke $h(t)$.
  
    $
      h(2) = -5(2)^2 + 20(2) + 2
      \
      h(2) = -20 + 40 + 2
      \
      h(2) = #markrect([$quad 22$], outset: 3pt)
    $
  ]
)

#penyelesaian(judul: [3. Tentukan percepatan],
  [
    Turunkan kecepatan sekali lagi.
  
    $ a(t) = h''(t) = #markrect([$quad -10$], outset: 3pt) $
  
    Karena $h''(t) < 0$, titik $t = 2$ memang titik maksimum. Tanda negatif pada percepatan menunjukkan arahnya ke bawah, berlawanan dengan arah positif yang ditetapkan ke atas.
  ]
)
Bola mencapai titik tertinggi $22$ m setelah 2 detik. Pada saat itu kecepatannya $0$, sedangkan percepatannya tetap $-10 "m/s"^2$ (ke bawah).

=== Keuntungan Usaha

Dalam menjalankan usaha, menjual lebih banyak produk belum tentu menghasilkan keuntungan yang lebih besar. Keuntungan juga dipengaruhi oleh biaya produksi dan faktor lainnya. @asyhar-aplikasi-turunan-keuntungan

Karena itu, grafik keuntungan terhadap jumlah produk sering berbentuk lengkungan dengan satu puncak. Mulanya keuntungan naik, lalu setelah melewati titik tertentu justru turun. Puncak itulah keuntungan maksimum, dan di sana garis singgungnya mendatar ($P'(x) = 0$). Dengan demikian, turunan membantu menentukan jumlah produk yang paling menguntungkan untuk dijual.

#figure(
  grafik-untung(),
  caption: [Keuntungan $P(x) = -x^2 + 40x - 100$. Puncaknya berada di $x = 20$ dengan $P = 300$.],
)

Seorang siswa menjalankan usaha makanan ringan. Keuntungan usaha tersebut diperkirakan mengikuti fungsi

$ P(x) = -x^2 + 40x - 100 $

dengan $x$ menyatakan jumlah produk yang terjual dan $P(x)$ menyatakan keuntungan dalam ribuan rupiah.

Tentukan jumlah produk yang perlu terjual agar keuntungan maksimum, serta hitung besar keuntungan tersebut.

#penyelesaian(judul: [1. Tentukan titik stasioner], 
  [
    Turunkan fungsi keuntungan, lalu samakan dengan nol.
  
    $ P'(x) = -2x + 40 $
  
    $
      -2x + 40 &= 0
      \
      2x &= 40
      \
      x &= #markrect([$quad 20$], outset: 3pt)
    $
  ]
)

#penyelesaian(judul: [2. Pastikan keuntungan maksimum], 
  [
    $ P''(x) = -2 $
  
    Karena $P''(x) < 0$, grafik cekung ke bawah, sehingga $x = 20$ merupakan titik maksimum.
  ]
)

#penyelesaian(judul: [3. Hitung keuntungan maksimum], 
  [
    Substitusikan $x = 20$ ke fungsi keuntungan.
  
    $
      P(20) &= -(20)^2 + 40(20) - 100
      \
      P(20) &= -400 + 800 - 100
      \
      P(20) &= #markrect([$quad 300$], outset: 3pt)
    $
  
    Karena keuntungan dinyatakan dalam ribuan rupiah, nilai tersebut setara dengan Rp300.000.
  ]
)

Keuntungan maksimum sebesar Rp300.000 diperoleh ketika 20 produk terjual.

== Contoh Soal dan Pembahasan

Pada bagian sebelumnya, kita telah mempelajari cara menggunakan turunan pertama dan turunan kedua untuk memahami perilaku fungsi. Kita juga telah melihat bagaimana turunan dapat membantu menyelesaikan persoalan dalam kehidupan sehari-hari.

Pada bagian ini, kita akan menggabungkan beberapa konsep tersebut melalui dua contoh soal. Soal pertama menganalisis perilaku sebuah fungsi secara menyeluruh, sedangkan soal kedua mencari ukuran terbaik dari suatu masalah nyata (optimasi).

=== Analisis Perilaku Fungsi

Diketahui fungsi

$
  f(x) = x^3 - 6x^2 + 9x + 1
$

Tentukan:
+ Interval fungsi naik dan turun.
+ Titik maksimum dan minimum lokal.
+ Interval kecekungan dan koordinat titik belok.

#penyelesaian(judul: [1. Tentukan turunan pertama],
  [
    Turunkan fungsi terhadap $x$.
  
    $
      f'(x) = 3x^2 - 12x + 9
    $
  
    Faktorkan persamaan tersebut.
  
    $
      f'(x) = 3(x - 1)(x - 3)
    $
  ]
)

#penyelesaian(judul: [2. Tentukan interval fungsi naik dan turun],
  [
    Cari nilai yang memenuhi $f'(x) = 0$.
  
    $
      3(x - 1)(x - 3) = 0
    $
  
    $
      x = 1 " atau " x = 3
    $
  
    Kedua nilai tersebut membagi garis bilangan menjadi tiga interval. Periksa tanda turunan pertama dengan satu nilai uji di setiap interval, misalnya $x = 0$, $x = 2$, dan $x = 4$.
  
    $
      f'(0) = 9 > 0
      quad
      f'(2) = -3 < 0
      quad
      f'(4) = 9 > 0
    $
  
    Dengan demikian, diperoleh:
  
    #figure(
      caption: [Perilaku Fungsi],
      [
        #table(
          columns: (1.2fr, 1fr, 1.2fr),
          inset: 10pt,
          fill: (col, row) => if row == 0 { cmyk_purple.lighten(90%) } else { none },
          align: center,
          table.header(
            [*Interval*],
            [*Tanda* $f'(x)$],
            [*Perilaku fungsi*],
          ),
          [$x < 1$], [$+$], [Naik],
          [$1 < x < 3$], [$-$], [Turun],
          [$x > 3$], [$+$], [Naik],
        )
      ]
    ) 
    Jadi, fungsi naik pada interval $(-infinity, 1)$ dan $(3, infinity)$, serta turun pada interval $(1, 3)$.
  ]
)

#penyelesaian(judul: [3. Tentukan maksimum dan minimum lokal],
  [
    Dari perubahan tanda turunan pertama, diperoleh:
    - Pada $x = 1$, tanda turunan berubah dari positif menjadi negatif. Jadi, titik tersebut merupakan maksimum lokal.
    - Pada $x = 3$, tanda turunan berubah dari negatif menjadi positif. Jadi, titik tersebut merupakan minimum lokal.
  
    Hitung nilai fungsi pada kedua titik tersebut.
  
    $
      f(1) = 1^3 - 6(1)^2 + 9(1) + 1 = 5
    $
  
    $
      f(3) = 3^3 - 6(3)^2 + 9(3) + 1 = 1
    $
  
    Dengan demikian, maksimum lokal berada di $(1, 5)$ dan minimum lokal berada di $(3, 1)$.
  ]
)

#penyelesaian(judul: [4. Tentukan kecekungan dan titik belok],
  [
    Turunkan kembali fungsi untuk memperoleh turunan kedua.
  
    $
      f''(x) = 6x - 12
    $
  
    Tentukan nilai yang memenuhi $f''(x) = 0$.
  
    $
      6x - 12 &= 0
      \
      x &= 2
    $
  
    Periksa tanda turunan kedua pada kedua sisi $x = 2$.
  
    #figure(
      caption: [Perilaku Kecekungan],
      [
        #table(
          columns: (1.2fr, 1fr, 1.4fr),
          align: center,
          inset: 10pt,
          fill: (col, row) => if row == 0 { cmyk_purple.lighten(90%) } else { none },
          table.header(
            [*Interval*],
            [*Tanda* $f''(x)$],
            [*Kecekungan*],
          ),
          [$x < 2$], [$-$], [Cekung ke bawah],
          [$x > 2$], [$+$], [Cekung ke atas],
        )
      ]
    )
  
    Karena kecekungan berubah dari bawah menjadi atas, terdapat titik belok pada $x = 2$.
  
    $
      f(2) = 2^3 - 6(2)^2 + 9(2) + 1 = 3
    $
  
    Jadi, koordinat titik beloknya adalah $(2, 3)$.
  ]
)
  
Fungsi naik pada $(-infinity, 1)$ dan $(3, infinity)$, serta turun pada $(1, 3)$. Fungsi memiliki maksimum lokal di $(1, 5)$, minimum lokal di $(3, 1)$, dan titik belok di $(2, 3)$.

Hasil di atas dapat dilihat langsung pada grafik: kurva naik sampai puncak di $x = 1$, turun sampai lembah di $x = 3$, lalu naik lagi. Titik belok $(2, 3)$ berada tepat di tempat warna kurva berganti.

#figure(
  grafik-analisis(),
  gap: 2em,
  caption: [Grafik $f(x) = x^3 - 6x^2 + 9x + 1$. Bagian ungu (#garis(paint: cmyk_purple)) cekung ke bawah, bagian biru (#garis(paint: cmyk_blue)) cekung ke atas.],
)

=== Optimasi Luas Taman

Sebuah taman berbentuk persegi panjang akan dibangun di samping tembok lurus. Karena tembok digunakan sebagai salah satu sisi taman, pagar hanya diperlukan untuk ketiga sisi lainnya.

Jika tersedia pagar sepanjang 24 meter, tentukan ukuran taman yang menghasilkan luas maksimum.

#figure(
  gap: 1em,
  caption: figure.caption(position: top)[#kekotak(fill: cmyk_green.lighten(70%)) Luas taman, dan #garis(paint: cmyk_purple) Pagar],
  [
    #taman-diagram()
  ]
)

#penyelesaian(judul: [1. Buat model matematika],
  [
    Misalkan:
    - $x$ adalah panjang masing-masing sisi yang tegak lurus terhadap tembok.
    - $y$ adalah panjang sisi yang sejajar dengan tembok.
    
    Karena pagar digunakan untuk dua sisi sepanjang $x$ dan satu sisi sepanjang $y$, diperoleh
    
    $
      2x + y = 24
    $
    
    Sehingga
    
    $
      y = 24 - 2x
    $
    
    Karena panjang sisi harus positif, maka $x > 0$ dan $y > 0$. Dari $y = 24 - 2x > 0$ diperoleh $0 < x < 12$.
    
    Luas persegi panjang adalah panjang dikali lebar.
    
    $
      A = x y
    $
    
    Luas ini bergantung pada dua variabel, padahal turunan bekerja pada satu variabel. Oleh karena itu, substitusikan $y = 24 - 2x$ ke dalam fungsi luas.
    
    $
      A(x) = x(24 - 2x)
    $
    
    $
      A(x) = 24x - 2x^2
    $
  ]
)
#penyelesaian(judul: [2. Tentukan kandidat luas maksimum],
  [
    Turunkan fungsi luas terhadap $x$.
    
    $
      A'(x) = 24 - 4x
    $
    
    Untuk mencari titik stasioner, tetapkan turunan pertama sama dengan nol.
    
    $
      A'(x) &= 0
      \
      24 - 4x &= 0
      \
      x &= 6
    $
    
    Nilai $x = 6$ berada dalam $0 < x < 12$, sehingga memenuhi. Jadi, panjang masing-masing sisi yang tegak lurus terhadap tembok adalah 6 meter.
  ]
)
#penyelesaian(judul: [3. Pastikan luas maksimum],
  [
    Tentukan turunan kedua fungsi luas.
    
    $
      A''(x) = -4
    $
    
    Karena $A''(x) < 0$, fungsi luas cekung ke bawah. Dengan demikian, titik stasioner tersebut menghasilkan luas maksimum.
  ]
)

#penyelesaian(judul: [4. Tentukan ukuran taman dan luasnya], 
  [    
    Substitusikan $x = 6$ ke persamaan panjang pagar.
    
    $
      y = 24 - 2(6) = 12
    $
    
    Luas maksimum diperoleh dengan menghitung
    
    $
      A(6) = 6 times 12 = #markrect([$quad 72$], outset: 3pt)
    $
  ]
)
Dengan pagar yang sama panjang, taman yang terlalu pipih ($x$ kecil) maupun terlalu sempit ($y$ kecil) sama-sama kecil luasnya, sehingga luas terbesar ada di antara keduanya.

#align(center, figure(
  taman-mini(),
  gap: 1em,
  caption: figure.caption(position: top)[Tiga ukuran taman dengan panjang pagar yang sama (24 meter).],
))

#side-by-side(
  [
    Jika luas digambarkan terhadap $x$, hasilnya berupa parabola yang membuka ke bawah. Puncaknya berada di $x = 6$, tempat garis singgung mendatar ($A'(6) = 0$), dan titik $x = 3$ serta $x = 9$ berada di sisi kiri dan kanannya.
  ],
  [
    #figure(
      grafik-taman(),
      caption: [Luas taman $A(x) = 24x - 2x^2$ terhadap $x$.],
    )
  ]
)

== Ringkasan

Turunan merupakan konsep matematika yang digunakan untuk memahami laju perubahan suatu fungsi. Selain membantu menghitung perubahan, turunan juga dapat digunakan untuk menganalisis grafik dan menyelesaikan persoalan dalam kehidupan sehari-hari.

#figure(
  caption: figure.caption(position: top)[Alur menurunkan turunan],
  [
    #grid(
        columns: (4.6cm, 1.4cm, 4.6cm, 1.4cm, 4.6cm),
        rows: (auto, 1cm),
        column-gutter: 1pt,
        align: center + horizon,
        kotak-smart-art[$f(x)$], panah, kotak-smart-art[$f(x)'$], panah, kotak-smart-art[$f(x)^''$],
        [], label[turunkan], [], label[turunkan], [],
    )
  ]
)

// [VISUAL: Peta konsep yang menghubungkan fungsi $f(x)$,
// turunan pertama $f'(x)$, turunan kedua $f''(x)$,
// serta penerapannya dalam analisis fungsi dan kehidupan
// sehari-hari. Gunakan panah untuk menunjukkan hubungan
// antarkonsep.]

Berikut beberapa konsep penting yang telah dipelajari.

#figure(
  caption: [Makna dan kegunaan setiap konsep turunan],
  [
    #table(
      columns: (1.15fr, 1.7fr),
      align: (left, left),
      inset: 10pt,
      fill: (col, row) => {
        if row == 0 {
          cmyk_purple.lighten(90%)
        } else {
          none
        }
      },
      table.header(
        [*Konsep*],
        [*Makna dan kegunaan*],
      ),
      [Turunan pertama $f'(x)$],
      [Menunjukkan kemiringan garis singgung dan membantu
      menganalisis perilaku fungsi.],
    
      [Fungsi naik dan turun],
      [Jika $f'(x)>0$, fungsi naik; jika $f'(x)<0$,
      fungsi turun pada interval tersebut.],
    
      [Titik stasioner],
      [Titik ketika $f'(x)=0$. Tidak selalu merupakan
      maksimum atau minimum.],
    
      [Maksimum dan minimum],
      [Perubahan tanda turunan dari positif ke negatif
      menunjukkan maksimum lokal; dari negatif ke positif
      menunjukkan minimum lokal.],
    
      [Turunan kedua $f''(x)$],
      [Menunjukkan perubahan kemiringan grafik dan
      membantu menganalisis kecekungan serta titik belok.],
    
      [Penerapan turunan],
      [Digunakan untuk menentukan kecepatan, percepatan,
      serta nilai optimum dalam persoalan usaha.]
    )
  ]
)

// HACK: Pagebreak

#pagebreak()

#info[
  *Ingat!*

  + $f'(x)=0$ belum tentu berarti maksimum atau minimum.
  + $f''(x)=0$ belum tentu berarti titik belok.
  + Maksimum dan minimum lokal tidak selalu menjadi
    maksimum dan minimum mutlak.
]

=== Trigonometri

Untuk sudut $x$ dalam radian, turunan sinus dan kosinus
memiliki hubungan berikut.

$ (sin x)' = cos x $

$ (cos x)' = -sin x $

Aturan-aturan perhitungan turunan lainnya dapat dilihat
kembali pada bagian Aturan Turunan Fungsi Aljabar.

#pagebreak()
== Soal Latihan
*Silang ($crossmark$) pada salah satu huruf (A, B, C, atau D)*

#columns(2, gutter: 10pt)[
  #soal-pg(
    [Tentukan turunan pertama dari
    $f(x)=3x^4-2x^2+5$.],
    (
      [$12x^3-4x$],
      [$12x^3-2x$],
      [$3x^3-4x$],
      [$12x^3-4x+5$],
    )
  )

  #soal-pg(
    [Jika $f(x)=x^2(x+1)$, maka $f'(x)$ adalah ...],
    (
      [$2x(x+1)$],
      [$2x^2+x$],
      [$3x^2+2x$],
      [$3x^2+1$],
    )
  )

  #soal-pg(
    [Diketahui $f(x)=x^2/(x+1)$. Nilai $f'(1)$ adalah ...],
    (
      [$1/4$],
      [$1/2$],
      [$3/4$],
      [$3/2$],
    )
  )

  #soal-pg(
    [Turunan pertama dari $f(x)=(2x-1)^3$ adalah ...],
    (
      [$3(2x-1)^2$],
      [$6(2x-1)^2$],
      [$3(2x-1)^3$],
      [$6(2x-1)$],
    )
  )

  // TODO: PERMUDAH SOAL TRIGONOMETRI???
  #soal-pg(
    [Untuk $x$ dalam radian, turunan dari
    $f(x)=2 sin(x)-3 cos(x)$ adalah ...],
    (
      [$2 cos(x)-3 sin(x)$],
      [$-2 cos(x)+3 sin(x)$],
      [$2 cos(x)+3 sin(x)$],
      [$-2 sin(x)-3 cos(x)$],
    )
  )

  #soal-pg(
    [Diketahui $f(x)=x^2+1$. Persamaan garis singgung
    grafik pada $x=2$ adalah ...],
    (
      [$y=4x-3$],
      [$y=4x+3$],
      [$y=2x+1$],
      [$y=2x-3$],
    )
  )

  #soal-pg(
    [
      #graph(
        x: (-4, 4), y: (-4, 4), scale: .8799cm,
        step: 2,
        minor: 2,
        points((1, -2), stroke: cmyk_purple),
        points((-1, 2), stroke: cmyk_purple),
        fn(x => calc.pow(x, 3) - (3 * x), stroke: cmyk_purple),
      )
      Perhatikan grafik tersebut. Pada interval manakah
      fungsi mengalami penurunan?
    ],
    (
      [ $(-infinity,-1)$ ],
      [ $(-1,1)$ ],
      [ $(1,infinity)$ ],
      [Seluruh bilangan riil],
    )
  )

  #soal-pg(
    [Keuntungan suatu usaha dinyatakan oleh
    $P(x)=-x^2+40x-100$, dalam ribuan rupiah, dengan
    $x$ menyatakan jumlah produk terjual. Jumlah produk
    dan keuntungan maksimum yang tepat adalah ...],
    (
      [20 produk dan Rp300.000],
      [40 produk dan Rp300.000],
      [20 produk dan Rp400.000],
      [10 produk dan Rp300.000],
    )
  )

  #soal-pg(
    [Diketahui $f(x)=x^3-3x^2+2$. Koordinat titik
    belok grafik fungsi tersebut adalah ...],
    (
      [$(0,2)$],
      [$(1,0)$],
      [$(2,-2)$],
      [$(1,1)$],
    )
  )

  #soal-pg(
    [Posisi sebuah benda dinyatakan oleh
    $s(t)=2t^3+3t^2+10t$ meter, dengan $t$ dalam detik.
    Besar percepatan benda setelah 2 detik adalah ...],
    (
      [$18 " m/s"^2$],
      [$24 " m/s"^2$],
      [$30 " m/s"^2$],
      [$36 " m/s"^2$],
    )
  )
]