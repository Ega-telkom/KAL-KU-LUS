
// BAB 1: Limit

#import "../template.typ": *
#import "@preview/quadrille:0.1.0": *
#import "@preview/mannot:0.4.0": *
#import "@preview/cetz:0.5.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/equate:0.3.3": *

#bab(
  // Judul
  "Limit", 

  // Deskripsi
  "Bagaimana kita dapat mendekati suatu nilai, tanpa harus mencapainya.",

  // Gambar
  "assets/bab1/cover.jpg",
  "Visi NASA untuk membawa manusia menjelajahi segala sudut alam semesta yang mencerminkan gagasan perjalanan antariksa berkecepatan tinggi. Namun, adakah batas maksimal untuk seberapa cepat sebuah pesawat luar angkasa bisa melaju?",
  "NASA, karya digital milik Les Bossinas, domain publik",

  // Kata kunci
  kata-kunci: ("Limit Fungsi", "Kekontinuan", "L'Hôpital"),
)

#tujuan[
  Anda akan mempelajari:
  #v(-.8em)
  #badges(
    badge[Konsep & Definisi Limit],
    badge[Kekontinuan Fungsi],
    badge[Sifat Limit],
    badge[Limit Tak Hingga],
    badge[Menghitung limit dengan aljabar],
    badge[Alur menghitung limit],
    badge[Penerapan Limit]
  )

  Bab ini tidak mencakup:
  #v(-.8em)
  #badges(
    badge(warna: cmyk_border, [Limit Trigonometri]),
    badge(warna: cmyk_border, [Limit Eksponen & Logaritma]),
    badge(warna: cmyk_border, [Limit Barisan & Deret]),
    badge(warna: cmyk_border, [Definisi Formal])
  )  
]

#mengapa(judul: [Mengapa harus belajar Limit?], [
  // #meander.reflow({
  //   import meander: *

  //   // placed(top + right, gambar-compact(lebar: 12em,
  //   //   image("../assets/bab1/desain-interior.jpg"),
  //   //   caption: [Perencanaan desain interior],
  //   //   sumber: "unsplash.com, Kredit: Sven Mieke, Lisensi: Lisensi Unsplash",
  //   // ))

  //   container()
  //   content[

  //   ]
  // })

  Sadar atau tidak, dunia tempat kita tinggal itu penuh dengan batasan. Kita tidak pernah bisa mengukur panjang benda dengan ketelitian 100%.

  Coba saja dekatkan jarimu setipis mungkin ke cangkir kopi panas tanpa menyentuhnya, kamu bisa merasakan suhunya makin tinggi, tetapi jarimu tidak benar-benar menempel. Tapi menariknya, segala sesuatu di alam terus berubah dan bergerak mendekati batas-batas tersebut. Di sinilah Limit berperan. Yaitu memberikan cara bagaimana matematika memahami apa yang terjadi saat kita melangkah sedekat mungkin ke suatu titik batas, meskipun kita tidak pernah benar-benar menyentuhnya.

])

== Apa itu Limit?

Bayangkan ada dua orang kawan bernama Abyan dan Dylan yang sedang berjalan di jalan yang lurus dan miring. Mereka berjanji untuk bertemu di titik $39$. Abyan berjalan dari sebelah kiri, dan Dylan berjalan dari sebelah kanan. Sambil berjalan, mereka juga mencatat ketinggian jalan yang sedang mereka pijak saat melangkah semakin dekat ke titik pertemuan.

#align(center)[
  #figure(
    table(
      columns: 8,
      inset: 10pt,
      fill: (col, _) => if col == 0 { cmyk_purple.lighten(90%) } else { none },
      align: (col, _) => if col == 0 { left } else { center },
      [*Lokasi* $(x)$], [$38,00$], [$38,80$], [$38,99$], [$39,00$], [$39,10$], [$39,20$], [$40,00$],
      [*Tinggi* $f(x)$],[$1$], [$1,59$], [$1,599$], [$???$], [$1,6001$], [$1,601$], [$1,900$],
    ),
    caption: [Lokasi dan ketinggian jalan (dalam meter)]
  )
]

- Coba tebak berapa tinggi jalan pada saat Abyan dan Dylan bertemu di titik $39$?

Dapat diamati bahwa tinggi jalan terlihat semakin mendekati ke nilai tertentu pada titik $39$. Terlihat Abbyan yang berjalan dari kiri merasa tinggi jalan semakin tinggi, tetapi untuk Dylan yang berjalan dari kanan merasa jalan terasa semakin menurun. Coba bayangkan kalau tinggi jalan dinyatakan dalam sebuah fungsi $f(x)$ dengan $x$ menyatakan titik lokasi mereka. Jadi kita sedang mencari $f(39)$.

Meskipun nilai asli dari $f(39)$ tidak diketahui di tabel, tetapi kita dapat melihat perilaku angka di sekelilingnya:

- Dari kiri (Abbyan), saat $x$ mendekati nilai $39$, nilai $f(x)$ akan menyerap naik ($1,59 -> 1,599 -> 1,5999 -> 1,59999 -> ...$)

- Dari kanan (Dylan), saat $x$ mendekati nilai $39$, nilai $f(x)$ akan menurun ($1,90 -> 1,601 -> 1,6001 -> 1,60001 -> ...$)

Terlihat dari kedua pernyataan diatas, mau dari arah kiri atau kanan, nilai dari $f(x)$ akan terus menyusut ke satu nilai dan nilai itu ialah $1,6$. Nilai tersebut biasa disebut dengan *nilai limit*.@matematika-lanjut-xii-2025

#v(1em)
#figure(
    caption: figure.caption(position: top)[Ilustrasi limit fungsi $f(x)$ saat $x$ mendekati $39$ dari kiri dan kanan],
    [
      #v(10pt)
      // ===== BARIS ATAS: anotasi arah pendekatan =====
      #align(center)[
        #diagram(
          edge((-4,0), (-2,0), "-", stroke: 1pt + cmyk_blue),
          node((-2,0), text(fill: cmyk_blue)[Abyan], stroke: none),
          edge((-2,0), (-0.3,0), "-|>", stroke: 1pt + cmyk_blue),
          node((0,0), $f(39) = 1\,6$, stroke: none),
          edge((0.3,0), (2,0), "<|-", stroke: 1pt + cmyk_blue),
          node((2,0), text(fill: cmyk_blue)[Dylan], stroke: none),
          edge((2,0), (4,0), "-", stroke: 1pt + cmyk_blue),
        )
      ]
      
      // ===== BARIS BAWAH: garis bilangan =====
      #let lbl(atas, bawah) = align(center)[
        #set text(size: 8pt)
        #atas \
        #bawah
      ]
      
      #align(center)[
        #diagram(
          spacing: (1em, 1.2em),
      
          edge((-5,0), (5,0), "<|-|>", stroke: 1pt + cmyk_purple),
          edge((0,-0.7), (0,0.4), stroke: 1pt + cmyk_purple),
      
          edge((-4.4,-0.28), (-4.4,0.15), stroke: 1pt + cmyk_purple),
          edge((-3,-0.28), (-3,0.15), stroke: 1pt + cmyk_purple),
          edge((-1.8,-0.28), (-1.8,0.15), stroke: 1pt + cmyk_purple),
          edge((-0.9,-0.28), (-0.9,0.15), stroke: 1pt + cmyk_purple),

          edge((-0.4,-0.28), (-0.4,0.15), stroke: 1pt + cmyk_purple),
          edge((0.4,-0.28), (0.4,0.15), stroke: 1pt + cmyk_purple),

          edge((0.9,-0.28), (0.9,0.15), stroke: 1pt + cmyk_purple),
          edge((1.8,-0.28), (1.8,0.15), stroke: 1pt + cmyk_purple),
          edge((3,-0.28), (3,0.15), stroke: 1pt + cmyk_purple),
          edge((4.4,-0.28), (4.4,0.15), stroke: 1pt + cmyk_purple),
      
          node((-4.4,0.9), lbl($f(38,00)=$, $1$), stroke: none),
          node((-3,0.9), lbl($f(38,40)=$, $1\,25$), stroke: none),
          node((-1.8,0.9), lbl($f(38,80)=$, $1\,599$), stroke: none),
          node((-0.9,0.9), lbl($f(38,90)=$, $1\,5999$), stroke: none),
          node((0.9,0.9), lbl($f(39,10)=$, $1\,6001$), stroke: none),
          node((1.8,0.9), lbl($f(39,20)=$, $1\,601$), stroke: none),
          node((3,0.9), lbl($f(39,60)=$, $1\,65$), stroke: none),
          node((4.4,0.9), lbl($f(40,00)=$, $1\,9$), stroke: none),
        )
      ]
    ]
)
#v(2em)

Kamu mesti bertanya _“Kok bisa ya, dapat nilai $1,6$?”_. Untuk mendapat nilai tersebut ada beberapa cara yang dapat kita gunakan:

- Tadi kita telah menerapkan *pendekatan numerik* melalui tabel, dengan menganalisis tren perubahan $1,59 -> 1,599 -> 1,5999 -> 1,59999 -> ...$ otak kita langsung secara alami menebak bahwa target nya adalah $1,6$.

- Tetapi dalam matematika kita tidak boleh hanya menebak-nebak nilai saja. Maka dari itu kita harus menggunakan *metode aljabar*.

Sebelum kita mulai belajar menggunakan metode aljabar, kerjakan latihan soal Eksplor berikut untuk memperkuat intuisi Anda terhadap konsep Limit. Anda diperbolehkan untuk berdiskusi dengan guru maupun teman-mu. 

#eksplor[  
  1. Misalkan saja fungsi $h: RR -> RR$ didefiniskan oleh $h(x) = -3$. Coba isi bagian yang diberi tanda $?$ tabel di bawah...

  #align(center)[
    #figure(
      table(
        columns: (auto, ..(1fr,) * 11),
        inset: 10pt,
        fill: (col, _) => if col == 0 { cmyk_purple.lighten(90%) } else { none },
        align: (col, _) => if col == 0 { left } else { center },
        [$x$], [$1$], [$1,9$], [$1,99$], [$1,999$], [$dots.c$], [$2$], [$dots.c$], [$2,001$], [$2,01$], [$2,1$], [$2,2$],
        [$h(x)$], [$-3$], [$?$], [$-3$], [$?$], [$dots.c$], [$?$], [$dots.c$], [$-3$], [$?$], [$-3$], [$-3$]
      ),
      caption: [Nilai $h(x)$ mendekati nilai $2$]
    ) <Lat1.2>
  ]

  2. Misalkan fungsi $p: RR -> RR$ didefinisikan oleh $p(x) = x + 3$. Coba isi bagian yang diberi tanda $?$ tabel di bawah...

  #align(center)[
    #figure(
      table(
        columns: (auto, ..(1fr,) * 11),
        inset: 10pt,
        fill: (col, _) => if col == 0 { cmyk_purple.lighten(90%) } else { none },
        align: (col, _) => if col == 0 { left } else { center },
        [$x$], [$1$], [$1,9$], [$1,99$], [$1,999$], [$dots.c$], [$2$], [$dots.c$], [$2,001$], [$2,01$], [$2,1$], [$2,2$],
        [$p(x)$], [$?$], [$?$], [$4,99$], [$?$], [$dots.c$], [$?$], [$dots.c$], [$5,001$], [$?$], [$5,1$], [$?$]
      ),
      caption: [Nilai $p(x)$ mendekati nilai $2$]
    )
  ]

  Catatan: 
  - Simbol $RR$ melambangkan himpunan bilangan ril (semua jenis angka nyata: bulat, desimal, pecahan, positif, maupun negatif).
  - Bagian titik-titik ($...$) hanya penanda bahwa pola angka terus mendekati target, tidak perlu Anda isi.
]

Jika Anda berhasil melengkapi tabel dan menjawab pertanyaan di atas, selamat! Anda baru saja memahami konsep dasar limit melalui *pendekatan numerik*. Dengan melihat pola angka yang makin mendekati suatu titik, Anda telah membangun fondasi intuisi yang kuat sebelum nantinya masuk ke *metode aljabar* yang jauh lebih praktis!

=== Definisi

Dari tabel sebelumnya, kita telah mengamati bagaimana nilai fungsi berubah ketika $x$ semakin dekat ke suatu titik. Namun, apakah nilai yang didekati selalu sama, baik ketika kita bergerak dari kiri maupun dari kanan? Untuk menjawabnya, kita perlu memahami konsep limit.

Limit merupakan salah satu materi dalam kalkulus yang berfungsi sebagai dasar bagi turunan dan integral. Konsep limit digunakan untuk memahami perilaku suatu fungsi ketika variabel mendekati nilai tertentu, baik dari kiri maupun dari kanan. Meskipun terlihat abstrak, limit sangat fundamental dalam dunia matematika modern karena membantu menjelaskan perubahan, kontinuitas, dan kecepatan laju suatu fungsi. @wp-limit @teknokrat-limit

#info[
    #meander.reflow({
    import meander: *

    placed(top + right, 
    boundary:
      contour.margin(
      left: 0.5cm,
      bottom: 0.5cm,
    ),
      tautan-qr(
        url: "https://youtu.be/HEbMs2zYoDw?si=JvRCrgE7z-3gwon0",
        label: [Pindai QR untuk melihat Video penjelasan!\ (Kredit: Sinau Math)]
      )
    )

    container()
    content[
      Masih ingat dengan Abyan dan Dylan? Mereka sedang berjalan mendekati titik $x=39$ dari arah berlawanan, sambil mencatat ketinggian jalan yang mereka pijak.
      
      Bayangkan Tanisha bertanya kepada Abyan, "Ketika kamu semakin dekat ke $x=39$, ketinggian jalan yang kamu pijak mendekati berapa?"
      
      Perhatikan, Tanisha bertanya tentang nilai yang *didekati*, bukan nilai tepat pada titik tersebut. Inilah gagasan dasar limit. Jika dituliskan $lim_(x -> 39) f(x) = 1,6$, artinya nilai $f(x)$ mendekati $1,6$ ketika $x$ mendekati $39$. Namun, ini tidak otomatis berarti $f(39)=1,6$. Nilai fungsi tepat di titik tersebut bisa berbeda, bahkan mungkin tidak terdefinisi!
    ]
  })
]

Secara sederhana, limit menggambarkan bagaimana nilai fungsi mendekati suatu angka $L$ saat variabel $x$ mendekati titik $c$. Oleh karena itu, kita mengenal limit dari dua arah: limit kiri dan limit kanan.

- Limit dari kanan ditandai dengan tanda plus ($+$) di atas angka. Ini artinya kita mengamati nilai $f(x)$ saat $x$ mendekati $c$ dari angka-angka yang lebih besar (misal: $1,2 -> 1,01 -> 1,001 -> 1,0001$).

  #eq-numbered[
    $ lim_(x -> c^+) f(x) = L_1 $ <kanan>
  ]

- Limit dari kiri ditandai dengan tanda minus ($-$) di atas angka. Ini artinya kita mengamati nilai $f(x)$ saat $x$ mendekati $c$ dari angka-angka yang lebih kecil (misal: $0,9 -> 0,99 -> 0,999 -> 0,9999$).

  #eq-numbered[
    $ lim_(x -> c^-) f(x) = L_2 $ <kiri>
  ]

#v(1em)
#figure(
  caption: figure.caption(position: top)[Ilustrasi pergerakan $x$ mendekati $c$ dari kiri ($-$) dan kanan ($+$)],
  [
    #v(10pt)
    #align(center)[
      #diagram(
        // Garis bilangan utama
        edge((-5, 0), (5, 0), "<|-|>", stroke: 1pt + cmyk_purple),
        
        // Titik c di tengah
        edge((0, -0.1), (0, 0.1), stroke: 1.5pt + cmyk_purple),
        node((0, -0.4), [$c$]),
        
        // Panah mendekati dari kiri
        edge((-5, 0.5), (-0.3, 0.5), "-|>", stroke: 1.2pt + cmyk_blue),
        node((-2.8, 0.8), text(size: 9pt)[$x -> c^-$]),
        
        // Panah mendekati dari kanan
        edge((5, 0.5), (0.3, 0.5), "-|>", stroke: 1.2pt + cmyk_blue),
        node((2.8, 0.8), text(size: 9pt)[$x -> c^+$]),
      )
    ]
  ]
)
#v(2em)

Nilai $f(x)$ dapat dibuat sedekat mungkin ke $L$ dengan membuat $x$ cukup dekat ke $c$, tetapi $x != c$. Setelah memeriksa kedua sisi, kita bisa menarik kesimpulan akhir yang disebut Limit Umum, atau Limit dua arah (ditulis tanpa tanda $+$/$-$).

Limit Umum memperlihatkan jika kedua Limit dari arah kanan dan kiri akan menghasilkan nilai $L$ yang sama. Maka dari itu dapat ditulis sebagai berikut.

#eq-numbered[
  $ lim_(x -> c) f(x) = L $ <limit>
]

Catatan: 
- Jika limit kiri dan limit kanan menghasilkan angka yang sama persis ($L_1 = L_2 = L$). Maka nilai Limit dikatakan ada.
- Jika limit kiri dan limit kanan menghasilkan angka yang berbeda ($L_1 != L_2$). Maka nilai Limit dikatakan tidak ada.

#mengapa(judul: [Mengapa limit harus dibedakan dari kanan dan kiri?], [
  #meander.reflow({
    import meander: *

    placed(top + right, gambar-compact(lebar: 17em,
      image("../assets/bab1/cetina-bridge.jpg"),
      caption: [Konstruksi Jembatan Cetina di Kroasia],
      sumber: "www.youtube.com, Kredit: EdoStuff Aviation"
    ))

    container()
    content[
      Di matematika dan dunia nyata, tidak semua kondisi berjalan mulus dan tersambung. Ada kalanya suatu kejadian mengalami "lompatan" secara mendadak.
      
      Bayangkan saja Anda membangun jembatan dari dua sisi tebing. Jika ujung jembatan dari sisi kiri dan kanan tidak bertemu di titik yang sama, jembatannya tidak bisa dipakai (limitnya Tidak Ada).
    ]
  })
])

Secara garis besar, kunci utama dari konsep limit adalah konsistensi dari kedua arah. Suatu fungsi hanya memiliki nilai limit jika perilaku nilai dari arah kiri ($x -> c^-$) dan arah kanan ($x -> c^+$) sepakat menuju ke satu titik target yang sama persis ($L$). Apabila terjadi perbedaan hasil atau ujung kurva tidak saling bertemu, maka syarat keberadaan limit tidak terpenuhi dan nilai limit dinyatakan tidak ada.

Agar gambaran ini menjadi lebih jelas, mari kita amati bagaimana bentuk-bentuk perilaku limit ini terpancar langsung pada visualisasi grafik fungsi. Pada bagian selanjutnya, kita akan membedah berbagai bentuk kurva, mulai dari grafik yang tersambung mulus, berlubang, terputus mendadak, hingga perilaku ekstrem lainnya, untuk mengidentifikasi keberadaan limit secara visual.

// TODO: PERBAIKI INKONSISTENSI
== Kapan Limit Ada & Tidak Ada?

Amatilah perilaku grafik di bawah ini secara baik-baik. Visualisasi ini akan membantu kita mengidentifikasi kapan suatu nilai limit dikatakan ada atau tidak ada.

=== Limit Ada
#columns(2, gutter: 20pt)[
  
  Grafik pada *@grafik-fungsi-kontinu* menunjukkan fungsi yang mulus dan tidak terputus, seperti $f(x) = x^2$. Saat $x$ mendekati $2$, nilai fungsi juga mendekati $4$. Karena itu, limitnya adalah $lim_(x -> 2) f(x) = 4$.

  #figure(
    caption: [Grafik Fungsi $f(x)=x^2$],
    [
      #graph(
        x: (-6, 6), y: (-6, 6), scale: 0.67cm,
        x-step: 2,
        y-step: 2,
        fn(x => calc.pow(x, 2), [$ f(x)=x^2 $], stroke: cmyk_purple),
        points((2, 4), stroke: cmyk_purple),
        vline(2, stroke: cmyk_blue),
        hline(4, stroke: cmyk_blue)
      )
    ]
  ) <grafik-fungsi-kontinu>

  Grafik pada *@grafik-fungsi-lubang* Ketika $x$ mendekati $2$ dari kiri, nilai fungsi $f(x) = x$ mendekati $2$. Begitu pula ketika $x$ mendekati $2$ dari kanan, nilai fungsi $f(x) = -x + 4$ juga mendekati $2$. Karena kedua arah mendekati nilai yang sama, limit fungsi tersebut ada, yaitu

  #align(center)[
    $ lim_(x -> 2) f(x) = 2 $
  ]
  
  Meskipun terdapat lubang pada titik $(2, 2)$, hal tersebut tidak membuat limitnya tidak ada. Lingkaran kosong menunjukkan bahwa fungsi tidak terdefinisi tepat pada $x = 2$, tetapi nilai fungsi di sekitar titik tersebut tetap mendekati $2$.

  Lubang ini muncul karena kedua bagian fungsi hanya berlaku untuk $x < 2$ dan $x > 2$, sehingga tidak ada yang mendefinisikan nilai fungsi tepat saat $x = 2$. Meskipun grafiknya tampak tersambung dari kedua arah, titik $(2, 2)$ tetap tidak termasuk dalam grafik. Akibatnya, limitnya tetap ada, tetapi nilai fungsi di titik tersebut tidak terdefinisi.

  #figure(
    caption: "Grafik Fungsi dengan Lubang",
    [
      #graph(
        x: (-4, 4), y: (-4, 4), scale: 1cm,
        x-step: 1,
        y-step: 1,
        fn(x => 1 * x, domain: (-10, 2), stroke: cmyk_purple, [
          $ f(x) := cases(
            x & " jika" x < 2,
            -x + 4 & " jika" x >2,
          ) $
        ]),
        fn(x => -x + 4, domain: (2, 6), stroke: cmyk_purple),
        points((2, 2), mark: "circle", stroke: cmyk_purple),
        hline(2, stroke: cmyk_blue),
        vline(2, stroke: cmyk_blue)
      )
    ]
  ) <grafik-fungsi-lubang>
]

#pagebreak()

=== Limit Tidak Ada
#columns(2, gutter: 20pt)[

  Grafik pada *@grafik-fungsi-loncatan* menunjukkan fungsi yang mengalami loncatan. Saat $x$ mendekati $0$ dari kiri dan kanan, nilai fungsi mendekati angka yang berbeda. Karena kedua sisi tidak menuju nilai yang sama, limitnya tidak ada.

  #figure(
    caption: "Grafik Fungsi dengan Loncatan",
    [
      #graph(
        x: (-4, 4),
        y: (-4, 4),
        scale: 1cm,
        x-step: 2,
        y-step: 2,
      
        // Garis kiri dan kanan
        fn(x => -1, domain: (-4, 0), stroke: cmyk_purple),
        fn(x => 1, domain: (0, 4), stroke: cmyk_purple),
      
        // Titik ujung kosong
        points((0, -1), mark: "circle", stroke: cmyk_purple),
        points((0, 1), mark: "circle", stroke: cmyk_purple, [
          $ f(x) = x/(|x|) $
        ]),
      )
    ]
  ) <grafik-fungsi-loncatan>

  Grafik pada *@grafik-fungsi-infinity* menunjukkan fungsi $f(x) = 1 / x^2$. Ketika $x$ semakin mendekati $0$, nilai fungsi semakin besar tanpa batas, baik dari kiri maupun kanan. Dengan demikian, fungsi ini tidak memiliki limit berupa bilangan real yang berhingga.

  Meskipun pada grafik kurva tampak seolah-olah akan menyentuh sumbu-$y$, pada kenyataannya kurva tersebut hanya terus mendekatinya tanpa pernah menyentuh sama sekali. Hal ini makin menegaskan bahwa nilai fungsi terus membesar tanpa batas, sehingga limitnya tidak ada.

  #figure(
    caption: "Grafik Fungsi Menuju Tak Hingga",
    [
      #graph(
        x: (-8, 8), y: (-8, 8), scale: 0.5cm,
        x-step: 2,
        y-step: 2,
        fn(x => if x != 0 { (1/calc.pow(x, 2)) }, [
          $ f(x) = 1/x^2 $
        ], stroke: cmyk_purple),
      )
    ]
  ) <grafik-fungsi-infinity>

  Grafik pada *@grafik-fungsi-osilasi* fungsi $f(x) = sin(1 / x)$ yang terus berayun naik dan turun semakin cepat saat $x$ mendekati $0$. Nilainya tidak menetap pada satu angka tertentu. Oleh karena itu, limit fungsi ini tidak ada.

  #figure(
    caption: [Grafik Fungsi yang Berosilasi],
    [
      #graph(
        x: (-2, 2), y: (-2, 2), scale: 2cm,
        x-step: 1,
        y-step: 1,
        fn(x => if x != 0 { calc.sin(1/x) }, [$display(f(x) = sin(1/x))$], samples: 10000, stroke: cmyk_purple),
      )
    ]
  ) <grafik-fungsi-osilasi>
]

=== Kekontinuan Fungsi

Sebelumnya, ada grafik yang garisnya tampak tersambung, dan ada pula yang memiliki lubang. Secara intuitif, fungsi dikatakan *kontinu* di suatu titik jika grafiknya tidak terputus pada titik tersebut.

Secara matematis, suatu fungsi dikatakan kontinu di $x = c$ apabila memenuhi tiga syarat berikut.

+ Nilai fungsi $f(c)$ terdefinisi.
+ $lim_(x -> c) f(x)$ ada.
+ $lim_(x -> c) f(x) = f(c)$.

Jika salah satu syarat tersebut tidak terpenuhi, fungsi tidak kontinu di titik tersebut.

#eksplor[
  Buka GeoGebra, Desmos, atau aplikasi kalkulator grafik
  lainnya. Masukkan fungsi-fungsi berikut secara bergantian
  dan amati perilakunya ketika $x$ mendekati $0$.

  1. $f(x) = x^2 + 2$
  2. $f(x) = 12/x^2$
  3. $f(x) = (x+4)/(|x+4|)$

  *Amati dan Jawab*

  - Untuk setiap fungsi, berapa nilai yang didekati $f(x)$ ketika $x$ mendekati 0 dari kiri ($x -> 0^-$)?
  - Untuk setiap fungsi, berapa nilai yang didekati $f(x)$ ketika $x$ mendekati 0 dari kanan ($x -> 0^+$)?
  - Fungsi mana saja yang memiliki limit (limit dua arah/umum) di $x = 0$? Jelaskan alasanmu berdasarkan pengamatan grafik!

  Ingat, perhatikan perilaku fungsi di sekitar $x = 0$,
  bukan hanya nilai fungsi tepat di titik tersebut.
]

Melalui berbagai grafik, kita telah belajar mengenali apakah suatu limit ada dan memperkirakan nilai yang didekati fungsi. Namun, bagaimana jika kita ingin menentukan nilai limit secara lebih tepat tanpa bergantung pada grafik atau tabel?

Untuk menjawab pertanyaan tersebut, kita akan mempelajari sifat-sifat limit. Sifat-sifat ini memberikan aturan yang membantu kita menghitung limit suatu fungsi dengan memanfaatkan limit fungsi-fungsi yang lebih sederhana.

// Perlu diperbaiki
// #info[
//   Tahukah Kamu? Mengapa Notasi Limit Tidak Memakai Tanda $+$ atau $-$?

//   Saat kamu melihat penulisan $lim_(x -> c) f(x)$ tanpa tanda $+$/$-$, itu dinamakan limit dua arah (limit umum). Penulisan ini digunakan karena kita sedang melihat kecenderungan nilai fungsi dari kedua sisi sekaligus (kiri dan kanan).

//   Nilai $\lim_{x \to c} f(x)$ ADA hanya jika hasil limit dari kiri dan kanan menuju ke angka yang sama persis ($\lim_{x \to c^-} f(x) = \lim_{x \to c^+} f(x)$). Jika dari kiri dan kanan menuju ke angka yang berbeda, maka limit umum tersebut ditulis Tidak Ada.
// ]

// TODO: PERLU DIRAPIKAN SEDIKIT, BANYAK LOREM IPSUM SEBAGAI CONTOH!
== Sifat-Sifat Limit

Setelah memahami kapan suatu limit ada atau tidak ada, sekarang kita akan mempelajari cara menghitungnya. Untuk fungsi yang lebih sederhana, kita dapat menggunakan tabel atau grafik untuk memperkirakan nilai limit. Namun, bagaimana jika kita ingin mendapatkan hasil yang lebih tepat?

Kita dapat memanfaatkan sifat-sifat limit. Sifat-sifat ini memungkinkan kita menghitung limit suatu fungsi dengan memecahnya menjadi beberapa bagian yang lebih sederhana.

Misalkan diketahui:

#eq-numbered[
  $ lim_(x -> c) f(x) = L quad text("dan") quad lim_(x -> c) g(x) = M $
]<ex:limit-L-M>

Jika kedua limit pada @ex:limit-L-M tersebut ada, berlaku sifat-sifat berikut.

=== Limit Konstanta
#side-by-side(
  [
    Saat nilai $x$ bergerak mendekati suatu titik $c$ dari arah kiri maupun dari arah kanan, nilai $f(x)$ tidak mengalami perubahan dan selalu bernilai $k$. Karena limit kiri dan limit kanan menghasilkan nilai yang identik, nilai limit fungsi tersebut di titik $c$ adalah $k$.

  ],
  [
    #align(horizon)[
      #eq-numbered[
        #eq-highlight[
          $ lim_(x -> c) k = k $ 
        ]
      ]
    ]
  ]
)

#side-by-side(
  [
    Sebagai contoh $k=5$. Maka dari itu nilai fungsi selalu $5$, sehingga ketika $x$ mendekati $2$, nilai fungsi tetap mendekati $5$.
  ],
  [
    #align(horizon)[
      $ lim_(x -> 2) 5 = 5 $
    ]
  ]
)

// TODO: PERBAIKI BAGIAN INI!!!!!!
=== Limit Fungsi Identitas
#side-by-side(
  [
    Fungsi identitas $f(x) = x$ adalah fungsi yang nilai keluarannya selalu identik dengan nilai masukannya. Maka limit dari $x$ ketika $x$ mendekati $c$ adalah $c$ itu sendiri.
    
  ],
  [
    #align(horizon)[
      #eq-numbered[
        #eq-highlight[
          $ lim_(x -> c) x = c $
        ]
      ]
    ]
  ]
)

#side-by-side(
  [
    Sifat ini merupakan salah satu teorema dasar limit yang digunakan sebagai fondasi dalam menyelesaikan operasi limit fungsi yang lebih kompleks.
  ],
  [
    #align(horizon)[
      $ lim_(x -> 3) x = 3 $
    ]
  ]
)

=== Limit Perkalian dengan Konstanta
#side-by-side(
  [
    Konstanta yang mengalikan suatu fungsi bisa dikeluarkan ke depan tanda limit. Jadi, kamu cukup hitung nilai limit fungsinya terlebih dahulu, lalu kalikan hasilnya dengan konstanta tersebut.
  ],
  [
    #eq-numbered[
      #eq-highlight[
       $ lim_(x -> c) \kf(x) = \kL $ 
      ]
    ]
  ]
)

#side-by-side(
  [
    Sebagai contoh, semisal $k = 3$:
  ],
  [
    #align(horizon)[
      $ 
        lim_(x -> 2) 3x & = 3 dot 2\
        & = 6
      $
    ]  
  ]
)

=== Limit Penjumlahan & Pengurangan
#side-by-side(
  [
    Limit dari penjumlahan atau pengurangan dua fungsi sama dengan penjumlahan atau pengurangan limit masing-masing fungsi.
  ],
  [
    #eq-numbered[
      #eq-highlight[
        $ 
          lim_(x -> c) [f(x) plus.minus g(x)] \
          = [lim_(x -> c)f(x)] plus.minus [lim_(x -> c)g(x)] \
          = L plus.minus M 
        $ 
      ]
    ]
  ]
)

#side-by-side(
  [
    Intinya, operasi limit bisa 'didistribusikan' atau dipecah masuk ke masing-masing fungsi di dalam kurung.
  ],
  [
    $ 
      lim_(x -> 2) (x^2 + 3x) & = lim_(x -> 2)x^2 + lim_(x -> 2)3x \
      & = 2^2 + 3(2) \
      & = 10
    $
  ]
)

=== Limit Perkalian
#side-by-side(
  [
    Limit dari hasil kali dua fungsi adalah hasil kali dari limit masing-masing fungsinya. Dengan kata lain, tanda limit dapat dimasukkan dan dihitung secara terpisah pada tiap fungsi sebelum akhirnya dikalikan.
  ],
  [
    #eq-numbered[
      #eq-highlight[
        $ 
          lim_(x -> c) [f(x) g(x)] \
          = [lim_(x -> c)f(x)] dot [lim_(x -> c)g(x)] \
          = L M
        $ 
      ]
    ]
  ]
)

#side-by-side(
  [
    Jadi, operasi limit bisa langsung diterapkan ke masing-masing faktor perkalian di dalam kurung.
  ],
  [
    $ 
      lim_(x -> 2) (x + 1) (x + 3) & = (2 + 1) (2 + 3) \
      & = 3 dot 5 \
      & = 15
    $
  ]
)

=== Limit Pembagian
#side-by-side(
  [
    Limit dari pembagian dua fungsi sama dengan hasil bagi limit masing-masing fungsi, dengan syarat limit penyebut tidak sama dengan nol.
  ],
  [
    #eq-numbered[
      #eq-highlight[
        $ 
          lim_(x -> c) f(x) / g(x)
          &= (lim_(x -> c) f(x)) / (lim_(x -> c) g(x)) \
          &= L / M 
          quad M eq.not 0 
        $ 
      ]
    ]
  ]
)

#side-by-side(
  [
      Catatan:
    - Penyebut $M != 0$ karena pembagian dengan nol tidak terdefinisi.
  ],
  [
    $ 
      lim_(x -> 2) (x + 1) / (x + 3) & = (2 + 1) / (2 + 3)\
      & = 3 / 5
    $
  ]
)

=== Limit Pangkat
#side-by-side(
  [
    Limit dari suatu fungsi yang dipangkatkan dengan bilangan bulat positif sama dengan limit fungsi tersebut yang dipangkatkan dengan bilangan yang sama.
  ],
  [
    #eq-numbered[
      #eq-highlight[
        $ lim_(x -> c) [f(x)]^n = L^n $
      ]
    ]
  ]
)

#side-by-side(
  [
    Disini, tanda limit bisa 'masuk' ke dalam kurung sebelum fungsinya dipangkatkan.
  ],
  [
    $ 
      lim_(x -> 1) (x + 1)^3 & = (2 + 1)^3 \
      & = 27
    $
  ]
)

=== Limit Akar
#side-by-side(
  [
    Untuk akar berderajat genap, nilai fungsi di sekitar titik yang dituju harus berada dalam domain akar real, dan limit radikannya tidak negatif.
  ],
  [
    #eq-numbered[
      #eq-highlight[
        $ lim_(x -> c) root(n, f(x))  = root(n, L) $ 
      ]
    ]
  ]
)

#side-by-side(
  [
    Terlihat disini, bahwa tanda limit bisa 'masuk' ke bawah tanda akar.
  ],
  [
    $ 
      lim_(x -> 4) sqrt(x + 5) & = sqrt(4 + 5) \
      & = sqrt(9) \
      & = 3
    $
  ]
)

Sifat-sifat tersebut membantu kita menghitung berbagai limit secara lebih praktis. Akan tetapi, kita tetap perlu memperhatikan syarat setiap sifat agar tidak salah dalam menentukan hasilnya.

// #teorema[
//   Jika $lim_(x->a) f(x) = L$ dan $lim_(x->a) g(x) = M$, maka:
//   + $lim_(x->a) [f(x) plus.minus g(x)] = L plus.minus M$
//   + $lim_(x->a) [f(x) dot g(x)] = L dot M$
//   + $lim_(x->a) [f(x)/g(x)] = L/M$, asalkan $M != 0$
// ]

#let bmark = mark.with(color: cmyk_blue)
#let pmark = mark.with(color: cmyk_purple)

== Menghitung Limit dengan Aljabar

Sebelumnya, kita telah mempelajari sifat-sifat limit yang membantu
kita menentukan nilai limit suatu fungsi. Sekarang, kita akan
menggunakannya untuk menyelesaikan berbagai persoalan limit
dengan pendekatan aljabar.

=== Substitusi Langsung

Cara paling sederhana untuk menghitung limit adalah dengan
memasukkan nilai yang didekati oleh $x$ ke dalam fungsi.
Cara ini disebut *substitusi langsung*.

Sebagai contoh, perhatikan limit berikut.

#eq-numbered[
  $ lim_(x -> 2) (x^2 + 3x - 1) $
]

Dengan memasukkan $x = 2$ ke dalam fungsi, diperoleh

#eq-numbered[
  $
    lim_(x -> pmark(2, #<lim-sub-two-0>)) (x^2 + 3x - 1) &= pmark(2, #<lim-sub-two-1>)^2 + 3 pmark((2), #<lim-sub-two-2>) - 1 )\
    \
    &= 4 + 6 - 1 \
    &= #markrect([$quad 9$], outset: 3pt) \

    #annot-cetz(
      (<lim-sub-two-0>, <lim-sub-two-1>, <lim-sub-two-2>),
      cetz,
      {
        import cetz.draw: *
    
        set-style(mark: (end: "straight"))
        bezier-through("lim-sub-two-0.south-east", (rel: (x: 1, y: -.3)), "lim-sub-two-1.south-west", stroke: cmyk_purple + 0.7pt)
        bezier-through("lim-sub-two-0.south-east", (rel: (x: 1, y: -.35)), "lim-sub-two-2.south-west", stroke: cmyk_purple + 0.7pt)
      },
    )
  $
]

Jadi, nilai limit tersebut adalah $9$.

Substitusi langsung dapat digunakan apabila nilai yang dimasukkan menghasilkan suatu nilai yang terdefinisi.

=== Bentuk Tak Tentu

Terkadang tidak semua limit dapat diselesaikan dengan subtitusi langsung. Coba perhatikan limit berikut:

#eq-numbered[
  $ lim_(x -> 2) (x^2 - 4)/(x - 2) $
]

Jika kita langsung memasukkan $x = 2$, diperoleh

#eq-numbered[
  $ (2^2 - 4)/(2 - 2) = pmark(0/0) $
]

Oh, tidak! kita mendapatkan bentuk $0/0$! Pembagian dengan nol tidak terdefinisi dalam dunia matematika. Jadi, kita belum berhasil menentukan nilai limitnya.

Bentuk $0/0$ disebut *bentuk tak tentu*. Bentuk ini tidak berarti nilai limitnya adalah nol, ataupun berarti limitnya pasti tidak ada. Kita perlu menyelidiki bentuk fungsi tersebut lebih lanjut untuk menentukan nilai limitnya. Selain $0/0$, terdapat beberapa bentuk lain yang disebut bentuk tak tentu, antara lain:

$ oo/oo, quad 0 dot oo, quad oo - oo,
quad 1^oo, quad 0^0, quad oo^0 $

// Bentuk-bentuk tersebut disebut tak tentu karena kita tidak
// dapat langsung menentukan nilai limit hanya dari bentuknya.
// Hasil akhirnya bergantung pada fungsi yang dihitung.

Salah satu cara yang dapat digunakan adalah pemfaktoran, pemfaktoran, maupun menggunakan teorema L'Hôpital.

=== Menghitung Limit dengan Pemfaktoran

Pemfaktoran dilakukan dengan menguraikan suatu bentuk aljabar
menjadi perkalian faktor-faktornya. Jika terdapat faktor yang
sama pada pembilang dan penyebut, faktor tersebut dapat
disederhanakan.


Kita lanjutkan contoh sebelumnya.

#eq-numbered[
  $ lim_(x -> 2) (x^2 - 4)/(x - 2) $
]


#side-by-side(
  [
    Karena $x^2 - 4$ merupakan bentuk selisih dua kuadrat, kita dapat memfaktorkannya menjadi
    
    Bayangkan saja $x^2$ dibongkar dan menjadi dua $x$, Dan untuk mendapatkan $-4$ kita perlu berfikir untuk membongkarnya juga, bahwa untuk mendapatkan hasil itu pasti hasil perkalian dari $-2 dot 2$
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $ 
          pmark(x^2, #<lim-fac-x-0>) bmark(- 4, #<lim-fac-four-0>)
          = (pmark(x, #<lim-fac-x-1>) bmark(- 2, #<lim-fac-two-0>))(pmark(x, #<lim-fac-x-2>) bmark(+ 2, #<lim-fac-two-1>))
          #annot-cetz(
            (<lim-fac-x-0>, <lim-fac-four-0>, <lim-fac-x-1>, <lim-fac-x-2>, <lim-fac-two-0>, <lim-fac-two-1>),
            cetz,
            {
              import cetz.draw: *
          
              set-style(mark: (end: "straight"))
              bezier-through("lim-fac-x-0.north-east", (rel: (x: 1, y: 0.2)), "lim-fac-x-1.north", stroke: cmyk_purple + 0.7pt)
              bezier-through("lim-fac-x-0.north-east", (rel: (x: 1, y: .4)), "lim-fac-x-2.north", stroke: cmyk_purple + 0.7pt)
          
              bezier-through("lim-fac-four-0.south-east", (rel: (x: 1, y: -.2)), "lim-fac-two-0.south", stroke: cmyk_blue + 0.7pt)
              bezier-through("lim-fac-four-0.south-east", (rel: (x: 1, y: -.4)), "lim-fac-two-1.south", stroke: cmyk_blue + 0.7pt)
            },
          )
        $
      ]
    ]
  ]
)


Dengan demikian,
#eq-numbered[
  $ 
    lim_(x -> 2) (cancel((x - 2))(x + 2))/cancel((x - 2)) & = lim_(x -> 2) (x + 2) \
    & = 2 + 2 \
    & = #markrect([$quad 4$], outset: 3pt) \
  $
]

Jadi, nilai limit tersebut adalah $4$.

Perhatikan bahwa penyebut $(x - 2)$ diberi tanda kurung untuk menegaskan bahwa yang dicoret adalah satu paket faktor utuh, bukan hanya variabel $x$ atau angka $2$ secara terpisah.

Perhatikan juga bahwa faktor $x - 2$ dapat disederhanakan karena kita sedang mengamati nilai fungsi ketika $x$ mendekati $2$, bukan harus tepat ketika $x = 2$. Penyederhanaan ini berlaku untuk $x != 2$ di sekitar titik tersebut. Jika saja $x=2$, perhatikan maka hasilnya akan menjadi $0$, dan berujung menjadi $0/0$.

=== Menghitung Limit dengan Rasionalisasi
Bagaimana jika bentuk tak tentu $0/0$ melibatkan akar? Dalam kasus tertentu, kita dapat menggunakan *rasionalisasi*, yaitu mengalikan pembilang dan penyebut dengan bentuk sekawan agar bentuk akar dapat disederhanakan.

Perhatikan contoh berikut.

#eq-numbered[
  $ lim_(x -> 4) (sqrt(x + 5) - 3)/(x - 4) $
]

Substitusi langsung menghasilkan bentuk $0/0$. Untuk mengatasinya, kalikan pembilang dan penyebut dengan $sqrt(x + 5) + 3$, yaitu bentuk sekawan dari $sqrt(x + 5) - 3$.

// TODO: PERLU PERJELAS LEBIH DETAIL?

Bentuk sekawan ini dipilih karena hasil kalinya mengikuti sifat selisih dua kuadrat:

$ (a-b)(a+b)=a^2-b^2 $

Maka dari itu cara membuat sekawan sebagai berikut

#eq-numbered[
  $
    \
    \
    lim_(x -> 4) (sqrt(x + 5) - 3)/(x - 4)
    & = lim_(x -> 4)((pmark(sqrt(x + 5) - 3, #<lim-ras-sqrt-0>))/(x - 4) dot
    (bmark(sqrt(x + 5) + 3, #<lim-ras-sqrt-1>))/(bmark(sqrt(x + 5) + 3, #<lim-ras-sqrt-2>)) quad)
    \
    
    & = lim_(x -> 4)
    ((sqrt(x + 5) - 3)bmark((sqrt(x + 5) + 3)))/
    ((x - 4)bmark((sqrt(x + 5) + 3))) 

    #annot-cetz(
      (<lim-ras-sqrt-0>, <lim-ras-sqrt-1>, <lim-ras-sqrt-2>),
      cetz,
      {
        import cetz.draw: *
    
        set-style(mark: (end: "straight"))
        bezier-through("lim-ras-sqrt-0.north", (rel: (x: 1, y: 0.4)), "lim-ras-sqrt-1.north", stroke: gradient.linear(cmyk_purple, cmyk_blue) + 0.7pt, mark: (stroke: cmyk_blue))
    
        bezier-through("lim-ras-sqrt-1.east", (rel: (x: .4, y: -.2)), "lim-ras-sqrt-2.east", stroke: cmyk_blue + 0.7pt)
    
        content((2.1, .5), [#text([Cari sekawan], fill: gradient.linear(cmyk_purple, cmyk_blue), size: 10pt)], anchor: "south")
      },
    )
  $
]

#side-by-side(
  [
    Sebelum lanjut ke @lim-ras kita perlu mendapatkan pembilang $(x + 5) - 9$:

    Perhatikan tanda akar dihilangkan karena menguadratkan akar mengembalikan bentuk di dalam akar.
  ],
  [
    $ 
      \
      \
      \
      & = (pmark(sqrt(x + 5), #<lim-ras-sqrt-3>) bmark(- 3, #<lim-ras-three-0>))(pmark(sqrt(x + 5), #<lim-ras-sqrt-4>) bmark(+ 3, #<lim-ras-three-1>)) \
      \
      \
      & = (pmark(x + 5)) bmark(- 9)
      #annot-cetz(
        (<lim-ras-sqrt-3>, <lim-ras-sqrt-4>, <lim-ras-three-0>, <lim-ras-three-1>),
        cetz,
        {
          import cetz.draw: *
      
          set-style(mark: (end: "straight"))
          bezier-through("lim-ras-sqrt-3.north", (rel: (x: 1, y: 0.3)), "lim-ras-sqrt-4.north", stroke: cmyk_purple + 0.7pt)
      
          bezier-through("lim-ras-three-0.south", (rel: (x: .4, y: -.2)), "lim-ras-three-1.south", stroke: cmyk_blue + 0.7pt)
      
          content((2, .4), [#text([$cancel((sqrt(x + 5))^2) = x + 5$], fill: cmyk_purple, size: 10pt)], anchor: "south")
      
          content((3, -1), [#text([$(-3)(+3) = -9$], fill: cmyk_blue, size: 10pt)], anchor: "north")
        },
      )
    $
  ]
)

#side-by-side(
  [
    Agar pembilang $(x + 5) - 9$ menjadi $x - 4$:
    
    Catatan: Tanda kurung pada $(x + 5)$ hanya menjadi pemisah visual. Dan dapat dihilangkan.
  ],
  [
    #align(horizon)[
      $
        (x + 5) - 9 & = x + 5 - 9 \
        & = x - 4
      $
    ]
  ]
)

#eq-numbered[
  $
    & = lim_(x -> 4) ((x + 5) - 9) /
    ((x - 4)(sqrt(x + 5) + 3)) \
    
    & = lim_(x -> 4) (cancel(x - 4)) /
    (cancel((x - 4))(sqrt(x + 5) + 3)) \
    
    & = lim_(x -> 4) 1/(sqrt(x + 5) + 3) \
    & = 1/(sqrt(4 + 5) + 3) \
    & = #markrect([$ quad 1/6$], outset: 3pt) \
  $
]<lim-ras>

Tujuan rasionalisasi adalah menyederhanakan bentuk yang mengandung akar dengan mengalikannya menggunakan bentuk sekawan. Pada contoh ini, rasionalisasi menghilangkan akar pada pembilang sehingga diperoleh bentuk $x-4$, yang kemudian dapat disederhanakan dengan faktor $x-4$ pada penyebut. Dengan demikian, nilai limit dapat ditentukan dengan lebih mudah.

=== Limit di Tak Hingga

Sejauh ini, kita membuat $x$ mendekati suatu bilangan. Kita juga bisa bertanya hal lain:

_"Apa yang terjadi pada $f(x)$ ketika $x$ dibuat makin besar tanpa henti, atau ditulis $x -> infinity$?"_ Pertanyaan ini berguna untuk melihat kecenderungan jangka panjang suatu fungsi.

Mari mulai dari yang paling sederhana, yaitu $1/x$. Makin besar $x$, makin kecil nilainya: $1/10 = "0,1"$, $1/1000 = "0,001"$, dan seterusnya. Disini $x$ memang dianggap sangat besar, hingga $oo$, jadi angka berapa pun jika dibagi bilangan raksasa hasilnya pasti mendekati 0. Jadi, untuk setiap $n > 0$.

$ lim_(x -> infinity) 1/x^n = 0 $

Sekarang perhatikan fungsi yang lebih ramai:

$ lim_(x -> infinity) (3x^2 + 5x + 2) / x^2 $

Untuk mengujinya, kita sementara ganti notasi limit dengan dengan $f(x)$:

$ f(x) = (3x^2 + 5x + 2) / x^2 $

Disini $x$ kita coba isi angka puluhan, ratusan, ribuan, dan seterusnya pada @lim-tak-hingga berikut:

#figure(
  caption: [Semakin besar $x$, $f(x)$ merapat ke $3$],
  [
    #table(
      columns: (auto, auto),
      inset: 10pt,
      fill: (col, row) => {
          if row == 0 {
          cmyk_purple.lighten(90%)
        } else {
          none
        }
      },
      align: center + horizon,
      table.header(
        [*Nilai* $x$], [*Nilai* $f(x)$],
      ),
      [$10$], [$3,52$],
      [$100$], [$3,0502$],
      [$1.000$], [$3,005002$],
      [$10.000$], [$3,00050002$],
    )
  ]
)<lim-tak-hingga>
Tabel di atas memperlihatkan bahwa semakin besar nilai $x$, nilai $f(x)$ semakin merapat ke angka $3$. Jika $x$ langsung diganti "tak hingga", pembilang dan penyebut sama-sama menjadi tak hingga, sehingga bentuknya $infinity / infinity$ yang tak tentu. Caranya, bagi pembilang dan penyebut dengan pangkat tertinggi, yaitu $x^2$.

$
  lim_(x -> infinity) (3x^2 + 5x + 2) / x^2
  &= lim_(x -> infinity) (3 + 5/x + 2/x^2) \
  &= 3 + 0 + 0 = 3
$

Secara intuisi, ketika $x$ sangat besar, suku $3x^2$ jauh mengalahkan $5x$ dan $2$, sehingga yang tersisa hanya perbandingan suku terbesarnya.

#figure(
  grafik-tak-hingga(),
  caption: [Makin besar $x$, kurva makin menempel pada garis $y = 3$.],
)

Secara geometris, garis horizontal $y = 3$ ini disebut *asimtot mendatar* (_*horizontal asymptote*_). Secara umum, jika $lim_(x -> infinity) f(x) = L$ (atau $lim_(x -> -infinity) f(x) = L$), maka garis $y = L$ adalah asimtot mendatar dari fungsi tersebut. Kurva akan terus mendekati garis ini tanpa pernah bersentuhan di ujung tak hingga.

Pola ini juga dipakai pada bagian Penerapan Limit: nilai $3$ pada @teknologi-komputer yaitu pada persamaan $lim T(n)/n^2 = 3$ diperoleh dengan cara yang sama. Secara umum, untuk pembilang dan penyebut berbentuk polinomial:

- jika pangkat tertinggi pembilang lebih kecil daripada penyebut, limitnya $0$;
- jika pangkat tertingginya sama, limitnya adalah perbandingan koefisien suku terbesarnya;
- jika pangkat tertinggi pembilang lebih besar, limitnya tidak terhingga (nilainya terus membesar).

Sebagai contoh, tentukan nilai dari

$ lim_(x -> infinity) (4x^2 - 3x + 1) / (2x^2 + 5) $

#penyelesaian[
  Pangkat tertinggi adalah $x^2$. Bagi pembilang dan penyebut dengan $x^2$.

  $
    lim_(x -> infinity) (4x^2 - 3x + 1) / (2x^2 + 5)
    = lim_(x -> infinity) (4 - 3/x + 1/x^2) / (2 + 5/x^2)
  $

  Ketika $x -> infinity$, semua suku yang berbentuk $c/x^n$ menuju $0$.

  $
    = (4 - 0 + 0) / (2 + 0) = 2
  $
]

Nilai limitnya adalah $2$, yaitu perbandingan koefisien $x^2$ pada pembilang dan penyebut.

=== Teorema L'Hôpital<t-lhopital>

#meander.reflow({
  import meander: *

  placed(top + right,
  boundary:
    contour.margin(
    left: 0.5cm,
    bottom: 0.5cm,
  ),
    tautan-qr(
      url: "https://youtu.be/kfF40MiS7zA?si=rkaQxqhg00HqxYZ-",
      label: [Pindai QR untuk melihat Video penjelasan!\ Kredit: 3Blue1Brown]
    )
  )

  container()
  content[
    Pada beberapa persoalan limit, substitusi langsung menghasilkan
    bentuk tak tentu, seperti $0/0$. Sebelumnya, kita telah belajar
    mengatasi bentuk tersebut menggunakan pemfaktoran dan
    rasionalisasi. Namun, terdapat cara lain yang memanfaatkan
    konsep turunan, yaitu *Teorema L'Hôpital*.

    Mengapa bentuk $0/0$ tak tentu? Karena pembilang dan penyebut
    sama-sama menuju $0$ pada saat yang sama, sehingga hasil baginya
    bergantung pada siapa yang menuju $0$ lebih cepat, seperti dua
    pelari yang sama-sama menuju garis finis. Ukuran "seberapa cepat"
    suatu fungsi berubah inilah yang disebut turunan, dan konsepnya
    dibahas di Bab 2. Teorema L'Hôpital memanfaatkan gagasan itu:
    bandingkan kecepatan berubah pembilang dan penyebut.
  ]
})

#figure(
  caption: [Pembilang, penyebut, dan hasil bagi di sekitar $x = 2$],
  table(
    columns: 4,
    inset: 8pt,
    align: center,
    table.header(
      [$x$], [$1","9$], [$1","99$], [$1","999$],
    ),
    fill: (col, row) => if row == 0 { cmyk_purple.lighten(90%) } else { none },
    [$x^2 - 4$], [$-"0,39"$], [$-"0,0399"$], [$-"0,003999"$],
    [$x - 2$], [$-"0,1"$], [$-"0,01"$], [$-"0,001"$],
    [Hasil bagi], [$"3,9"$], [$"3,99"$], [$"3,999"$],
  ),
)

Pembilang dan penyebut sama-sama menuju $0$, tetapi hasil baginya
menuju $4$. Artinya, pembilang mengecil sekitar $4$ kali lebih
cepat daripada penyebut. Perbandingan kecepatan inilah yang
dihitung oleh L'Hôpital.

Secara sederhana, jika limit pembagian dua fungsi menghasilkan
bentuk tak tentu $0/0$ atau $oo/oo$, kita dapat menghitung limit
perbandingan turunannya. Turunkan pembilang dan penyebut
masing-masing, bukan menurunkan hasil baginya sebagai satu
kesatuan.

#eq-numbered[
  $ lim_(x -> c) frac(f(x), g(x))
  = lim_(x -> c) frac(f'(x), g'(x)) $
]

Kesamaan ini hanya berlaku jika bentuknya benar-benar $0/0$ atau
$oo/oo$, dan limit di ruas kanan ada atau menuju tak hingga dengan
tanda tertentu. Pada $lim_(x -> 1) frac(x^2 + 1, x + 1)$, misalnya,
substitusi langsung sudah memberi $2/2 = 1$, sedangkan memaksakan
L'Hôpital memberi $2$ yang salah.

#info[
  Subbab ini memakai konsep turunan yang baru dibahas di Bab 2. Jika kamu belum mempelajarinya, boleh dilewati dulu dan kembali setelah selesai Bab 2. Bagian lain di bab ini tidak bergantung pada subbab @t-lhopital ini.
]

Untuk contoh di sini, cukup ketahui bahwa $f'(x)$ dibaca "turunan $f$", dengan dua aturan: turunan $x^n$ adalah $n x^(n-1)$, dan turunan konstanta adalah $0$.

Sebagai contoh, kita hitung limit berikut dengan menurunkan
pembilang dan penyebut secara terpisah.

$ lim_(x -> 2) frac(x^2 - 4, x - 2) $

$
  &= lim_(x -> 2) frac(2x, 1) \
  &= frac(2(2), 1) \
  &= #markrect([$quad 4$], outset: 3pt)
$

Hasilnya sama dengan metode pemfaktoran yang telah kita pelajari
sebelumnya, dan sesuai dengan tabel tadi: di sekitar $x = 2$,
pembilang berubah $4$ kali lebih cepat daripada penyebut
($2x = 4$ dibandingkan dengan $1$).

Teorema ini juga berlaku untuk bentuk $oo/oo$. Perhatikan limit
yang sama seperti pada subbab limit tak hingga.

$ lim_(x -> oo) frac(3x^2 + 5x + 2, x^2) $

Substitusi menghasilkan bentuk $oo/oo$, sehingga L'Hôpital dapat
dipakai. Setelah diturunkan, bentuknya masih $oo/oo$, jadi langkah
yang sama boleh diulang.

$
  lim_(x -> oo) frac(3x^2 + 5x + 2, x^2)
  &= lim_(x -> oo) frac(6x + 5, 2x) \
  &= lim_(x -> oo) frac(6, 2) \
  &= #markrect([$quad 3$], outset: 3pt)
$

=== Alur Menghitung Limit

// Secara umum, kita dapat mengikuti langkah-langkah berikut
// ketika menghitung limit menggunakan aljabar.

// + Substitusikan nilai yang didekati oleh $x$ ke dalam fungsi.
// + Jika diperoleh nilai yang terdefinisi, gunakan nilai tersebut
//   sebagai hasil limit.
// + Jika diperoleh bentuk tak tentu $0/0$, sederhanakan fungsi
//   menggunakan pemfaktoran atau rasionalisasi, sesuai dengan
//   bentuk soalnya.
// + Setelah fungsi disederhanakan, lakukan substitusi kembali
//   untuk menentukan nilai limitnya.

// TODO: RAPIKAN LAGI
#figure(
  caption: "Alur Menghitung Limit",
  gap: 2em,
  [
    #diagram(
      node-stroke: 1pt + cmyk_purple,
      edge-stroke: 1pt + cmyk_purple,
      edge-corner-radius: 4pt,
      node-corner-radius: 4pt,
      mark-scale: 80%,
      node-inset: 8pt,
      spacing: 1.6em,
      node((0,0), [$ lim_(x -> c)f(x) $]),
      edge("-|>"),
      
      node((0,1), [
        Substitusi $x=c$
      ]),
      
      node((-1,2), [
        Limit Tentu
      ]),
     
      edge("d", "-|>"),
      node((-1,3), [
        Selesai
      ]),
     
      node((1,2), stroke: cmyk_blue, [
        Limit Tak Tentu
      ]),
      edge("d", "-|>", stroke: cmyk_blue),
      
      node((1,3), stroke: cmyk_blue, [
        Rasionalisasi
      ]),
      edge("d", "-|>", stroke: cmyk_blue),

      node((1,4), stroke: cmyk_blue, [
        Substitusi $x=c$
      ]),
      
      node((0,3), stroke: cmyk_blue, [
        Faktorkan
      ]),
     
      edge("d", "-|>", stroke: cmyk_blue),
      node((0,4), stroke: cmyk_blue, [
        Substitusi $x=c$
      ]),
    
      node((2,3), stroke: cmyk_blue,[
        Teorema L'Hôpital
      ]),
     
      edge("d", "-|>", stroke: cmyk_blue),
      node((2,4), stroke: cmyk_blue, [
        Substitusi $x=c$
      ]),
     
      node((1,5),[
        Selesai
      ]),
    
      edge((0,1), "r,d", "-|>", stroke: cmyk_blue),
      edge((0,1), "l,d", "-|>"),
      edge((1,2), "l,d", "-|>", stroke: cmyk_blue),
      edge((1,2), "r,d", "-|>", stroke: cmyk_blue),
      edge((2,4), "d,l", "-|>", stroke: cmyk_blue),
      edge((0,4), "d,r", "-|>", stroke: cmyk_blue),
      edge((1,4), "d", "-|>", stroke: cmyk_blue),
    )
  ]
)<lim-alur>

@lim-alur di atas merupakan alur umum penyelesaian limit untuk $x -> c$. Ingat, bentuk $0/0$ ataupun bentuk limit tak tentu lainnya tidak dapat dijadikan kesimpulan akhir. Kita perlu menyelidiki apakah fungsi dapat disederhanakan atau memerlukan metode lain. 

Perlu dicatat bahwa untuk limit di tak hingga ($x -> oo$), alurnya sedikit berbeda: fokus utama kita bukan lagi merasionalkan atau memfaktorkan pembuat nol, melainkan membagi dengan suku berpangkat tertinggi untuk mengatasi bentuk tak tentu $infinity/infinity$.

// #contoh[
//   Tentukan $lim_(x -> 2) (x^2 - 4)/(x - 2)$.

//   Faktorkan pembilang:
//   $ (x^2-4)/(x-2) &= \
//     &= ((x-2)(x+2))/(x-2) \
//     &= x+2, quad x != 2 
//   $
//   Sehingga
//   $ lim_(x -> 2) (x^2-4)/(x-2) = 2+2 = 4 $
// ]

// === Kekontinuan

// Fungsi $f$ kontinu di $x=a$ jika ketiga syarat berikut dipenuhi:
// + $f(a)$ terdefinisi,
// + $lim_(x->a) f(x)$ ada,
// + $lim_(x->a) f(x) = f(a)$.

// HACK: Pagebreak
// #pagebreak()

== Penerapan Limit

// TODO: PERBAIKI AKURASI
Limit dapat digunakan untuk memecahkan beberapa masalah seperti berikut:

  === Teknologi & Komputer<teknologi-komputer>
  Dalam teknologi komputer, limit digunakan untuk menganalisis efisiensi algoritma, yaitu seberapa besar waktu eksekusi (_Time Complexity_) dan penggunaan memori (_Space Complexity_) bertumbuh ketika ukuran masukan $n$ semakin besar ($n -> infinity$).@qomaruna-limit @aulia-peran-kalkulus-teknologi

  Pertumbuhan ini biasanya dinyatakan dengan notasi _Big-O_. Untuk $n$ yang sangat besar, hanya suku yang tumbuh paling cepat yang menentukan. Misalnya, waktu eksekusi $T(n) = 3n^2 + 5n + 2$:

  $ lim_(n -> infinity) T(n)/n^2 = 3 $

  Karena hasilnya terhingga, kita tulis $T(n) = O(n^2)$. Beberapa kelas yang sering muncul, dari pertumbuhan paling lambat ke paling cepat, adalah $O(1)$, $O(log n)$, $O(n)$, $O(n^2)$, dan $O(2^n)$.

  === Pembelajaran Mesin
  Pada pembelajaran mesin, model dilatih dengan memperkecil fungsi _loss_ (fungsi kerugian), yaitu ukuran seberapa besar kesalahan model, secara berulang. Limit berperan menjelaskan *konvergensi*: nilai bobot dari iterasi ke iterasi mendekati nilai optimum.@qomaruna-limit @aulia-peran-kalkulus-teknologi

  Contohnya, pada _gradient descent_, bobot model diperbarui secara iteratif dengan langkah:

  $ w_(t+1) = w_t - eta nabla L(w_t) $

  - $w_t$ bobot pada iterasi ke-$t$
  - $eta$ laju pembelajaran (_learning rate_)
  - $nabla L(w_t)$ gradien (turunan) fungsi _loss_

  Langkah ini memakai turunan, sedangkan limit menyatakan hasil akhirnya. Jika iterasinya konvergen, $lim_(t -> infinity) w_t = w^*$, yaitu bobot optimum yang memenuhi $nabla L(w^*) = 0$.

  === Reaksi Kimia
  Dalam kimia, limit digunakan untuk menggambarkan reaksi yang mendekati kesetimbangan. Pada reaksi reversibel (dapat balik), reaksi berjalan ke dua arah. Kesetimbangan dicapai ketika laju reaksi maju dan mundur menjadi sama, sehingga konsentrasi zat tidak berubah lagi. Pada model sederhana, konsentrasi zat hanya mendekati nilai tetap seiring waktu, dan pendekatan inilah yang dinyatakan dengan limit.@qomaruna-limit

  $ "N"_2 + 3 "H"_2 harpoons.rtlb 2 "NH"_3 $

  Pada reaksi di atas, ketika sistem mendekati kesetimbangan dinamis, reaksi tetap berlangsung ke dua arah dengan laju yang sama, sehingga konsentrasi reaktan dan produk mendekati nilai tetap. Jika $[A](t)$ adalah konsentrasi suatu zat $A$ pada waktu $t$, maka

  $ lim_(t -> infinity) [A](t) = [A]_"eq" $

  dengan $[A]_"eq"$ konsentrasi $A$ pada kesetimbangan.@qomaruna-limit

Pada akhirnya, limit menjadi fondasi dari turunan, yang digunakan di berbagai bidang seperti ekonomi, pemodelan populasi biologi, dan fisika (kecepatan dan percepatan) untuk menganalisis tingkat perubahan sistem. Penerapan tersebut dibahas lebih lanjut pada pembahasan turunan di bab berikutnya.@qomaruna-limit

== Contoh Soal dan Pembahasan

Dapat diperhatikan bahwa metode yang digunakan dapat berbeda, bergantung pada bentuk fungsi yang diberikan.

=== Substitusi Langsung

Tentukan nilai limit berikut.

$ lim_(x -> -1) (2x^2 - 3x + 4) $

#penyelesaian[
  Fungsi ini terdefinisi di $x = -1$, sehingga kita dapat langsung memasukkan $x = -1$ ke dalam fungsi.

  $
    lim_(x -> -1) (2x^2 - 3x + 4)
    &= 2(-1)^2 - 3(-1) + 4 \
    &= 2 + 3 + 4 \
    &= 9
  $
]

Jadi, nilai limit tersebut adalah $9$.

=== Pemfaktoran

Tentukan nilai limit berikut.

$ lim_(x -> 2) frac(x^2 - 5x + 6, x - 2) $

#penyelesaian(judul: [1. Periksa substitusi langsung], [
  Jika dilakukan substitusi langsung, kita mendapatkan bentuk $0/0$. Oleh karena itu, fungsi perlu disederhanakan dengan pemfaktoran.
])

#penyelesaian(judul: [2. Faktorkan pembilang], [
  Bentuk pemfaktoran umumnya adalah

  $ x^2 + (p + q) x + (p dot q) = (x + p)(x + q) $

  Untuk memfaktorkan $x^2 - 5x + 6$, kita cari dua bilangan $p$ dan $q$ yang memenuhi

  $ p + q = -5, quad p dot q = 6 $

  Pasangan yang memenuhi adalah $p = -2$ dan $q = -3$, sehingga $x^2 - 5x + 6 = (x - 2)(x - 3)$.
])

#penyelesaian(judul: [3. Sederhanakan dan substitusi], [
  $
    lim_(x -> 2) frac(x^2 - 5x + 6, x - 2)
    &= lim_(x -> 2) frac(cancel((x - 2))(x - 3), cancel(x - 2)) \
    &= lim_(x -> 2) (x - 3) \
    &= 2 - 3 \
    &= #markrect([$quad -1$], outset: 3pt)
  $
])

Jadi, nilai limit tersebut adalah $-1$.

=== Pemfaktoran Pembilang dan Penyebut

Tentukan nilai limit berikut.

$ lim_(x -> 1) frac(x^2 - 1, x^2 - 3x + 2) $

#penyelesaian(judul: [1. Periksa substitusi langsung], [
  Substitusi $x = 1$ menghasilkan bentuk $0/0$, sehingga pembilang dan penyebut perlu difaktorkan.
])

#penyelesaian(judul: [2. Faktorkan pembilang dan penyebut], [
  Pembilang difaktorkan dengan rumus selisih dua kuadrat:

  $ a^2 - b^2 = (a - b)(a + b) $

  $ x^2 - 1 = (x - 1)(x + 1) $

  Untuk penyebut, kita cari dua bilangan yang hasil kalinya $+2$ dan jumlahnya $-3$. Bilangan yang memenuhi adalah $-1$ dan $-2$.

  $ x^2 - 3x + 2 = (x - 1)(x - 2) $
])

#penyelesaian(judul: [3. Sederhanakan dan substitusi], [
  $
    lim_(x -> 1) frac(x^2 - 1, x^2 - 3x + 2)
    &= lim_(x -> 1) frac(cancel((x - 1))(x + 1), cancel((x - 1))(x - 2)) \
    &= lim_(x -> 1) frac(x + 1, x - 2) \
    &= frac(1 + 1, 1 - 2) \
    &= #markrect([$quad -2$], outset: 3pt)
  $
])

Jadi, nilai limit tersebut adalah $-2$.

=== Rasionalisasi

Tentukan nilai limit berikut.

$ lim_(x -> 5) frac(sqrt(x + 4) - 3, x - 5) $

#penyelesaian(judul: [1. Periksa substitusi langsung], [
  Substitusi $x = 5$ menghasilkan bentuk $0/0$. Karena terdapat bentuk akar pada pembilang, kita gunakan rasionalisasi, yaitu mengalikan pembilang dan penyebut dengan bentuk sekawannya.
])

#penyelesaian(judul: [2. Kalikan dengan bentuk sekawan], [
  #info[
    Ingat rumus sekawan: $(sqrt(A) - B)(sqrt(A) + B) = A - B^2$. Jadi $(sqrt(x + 4) - 3)(sqrt(x + 4) + 3)$ pada pembilang menjadi $(x + 4) - 3^2 = x - 5$.
  ]

  $
    lim_(x -> 5) frac(sqrt(x + 4) - 3, x - 5)
    &= lim_(x -> 5) frac((sqrt(x + 4) - 3)(sqrt(x + 4) + 3), (x - 5)(sqrt(x + 4) + 3)) \
    &= lim_(x -> 5) frac(x + 4 - 9, (x - 5)(sqrt(x + 4) + 3)) \
    &= lim_(x -> 5) frac(x - 5, (x - 5)(sqrt(x + 4) + 3))
  $
])

#penyelesaian(judul: [3. Sederhanakan dan substitusi], [
  $
    lim_(x -> 5) frac(cancel(x - 5), cancel((x - 5))(sqrt(x + 4) + 3))
    &= lim_(x -> 5) frac(1, sqrt(x + 4) + 3) \
    &= frac(1, sqrt(5 + 4) + 3) \
    &= #markrect([$quad frac(1, 6)$], outset: 3pt)
  $
])

Jadi, nilai limit tersebut adalah $1/6$.

=== Limit Tak Hingga: Pangkat Pembilang Lebih Kecil

Tentukan nilai limit berikut.

$ lim_(x -> infinity) frac(5x + 1, x^2 - 4) $

#penyelesaian(judul: [1. Periksa substitusi langsung], [
  Jika $x -> infinity$, pembilang dan penyebut sama-sama menjadi tak hingga, sehingga bentuknya $infinity / infinity$ (tak tentu). Kita sederhanakan dengan membagi pembilang dan penyebut dengan pangkat tertinggi pada penyebut.
])

#penyelesaian(judul: [2. Bagi dengan pangkat tertinggi], [
  Pangkat tertinggi pada penyebut adalah $x^2$. Bagi setiap suku dengan $x^2$.

  $ frac(5x + 1, x^2 - 4) = frac(5/x + 1/x^2, 1 - 4/x^2) $
])

#penyelesaian(judul: [3. Hitung limit], [
  Ketika $x -> infinity$, semua suku yang berbentuk $c/x^n$ menuju $0$.

  $
    lim_(x -> infinity) frac(5x + 1, x^2 - 4)
    &= lim_(x -> infinity) frac(5/x + 1/x^2, 1 - 4/x^2) \
    &= frac(0 + 0, 1 - 0) \
    &= #markrect([$quad 0$], outset: 3pt)
  $
])

Jadi, nilai limit tersebut adalah $0$.

=== Limit Tak Hingga: Koefisien Negatif

Tentukan nilai limit berikut.

$ lim_(x -> infinity) frac(1 - x^2, 3x^2 + x) $

#penyelesaian(judul: [1. Periksa substitusi langsung], [
  Pembilang dan penyebut sama-sama menuju tak hingga (pembilang menuju $-infinity$), sehingga bentuknya tak tentu. Kita bagi dengan pangkat tertinggi pada penyebut, yaitu $x^2$.
])

#penyelesaian(judul: [2. Bagi dengan pangkat tertinggi], [
  Bagi setiap suku dengan $x^2$. Perhatikan bahwa tanda negatif pada $-x^2$ ikut terbawa.

  $ frac(1 - x^2, 3x^2 + x) = frac(1/x^2 - 1, 3 + 1/x) $
])

#penyelesaian(judul: [3. Hitung limit], [
  $
    lim_(x -> infinity) frac(1 - x^2, 3x^2 + x)
    &= lim_(x -> infinity) frac(1/x^2 - 1, 3 + 1/x) \
    &= frac(0 - 1, 3 + 0) \
    &= #markrect([$-1/3$], outset: 3pt)
  $
])

Jadi, nilai limit tersebut adalah $-1/3$, yaitu perbandingan koefisien $x^2$ pada pembilang dan penyebut, lengkap dengan tandanya.

=== Limit Tak Hingga: Pangkat Pembilang Lebih Besar

Tentukan nilai limit berikut.

$ lim_(x -> infinity) frac(x^3 + 2x, 4x^2 - 1) $

#penyelesaian(judul: [1. Periksa substitusi langsung], [
  Pembilang dan penyebut sama-sama menuju tak hingga, sehingga bentuknya $infinity / infinity$ (tak tentu). Seperti sebelumnya, bagi dengan pangkat tertinggi pada penyebut, yaitu $x^2$.
])

#penyelesaian(judul: [2. Bagi dengan pangkat tertinggi], [
  $ frac(x^3 + 2x, 4x^2 - 1) = frac(x + 2/x, 4 - 1/x^2) $
])

#penyelesaian(judul: [3. Hitung limit], [
  Ketika $x -> infinity$, penyebut mendekati $4 - 0 = 4$. Di pihak lain, pembilang $x + 2/x$ terus membesar tanpa batas karena suku $x$ menuju tak hingga.

  $
    lim_(x -> infinity) frac(x^3 + 2x, 4x^2 - 1)
    &= lim_(x -> infinity) frac(x + 2/x, 4 - 1/x^2) \
    &= frac(infinity, 4) \
    &= #markrect([$infinity$], outset: 3pt)
  $
])

Jadi, nilai limit tersebut tak terhingga ($infinity$): pembilang tumbuh jauh lebih cepat daripada penyebut, sehingga hasil baginya terus membesar.

== Ringkasan

Limit menjelaskan perilaku nilai fungsi $f(x)$ ketika $x$
mendekati suatu titik $c$. Nilai yang didekati fungsi tidak
harus sama dengan nilai fungsi tepat di titik tersebut.

=== Keberadaan Limit

Limit dua sisi ada jika limit kiri dan limit kanan sama-sama
ada dan menghasilkan nilai yang sama.

$ lim_(x -> c^-) f(x) = lim_(x -> c^+) f(x) = L $

Jika kedua limit satu sisi berbeda, atau salah satunya tidak
memiliki limit berhingga, limit dua sisi tidak ada sebagai
bilangan real berhingga.

=== Sifat-Sifat Limit

Misalkan $lim_(x -> c) f(x) = L$ dan
$lim_(x -> c) g(x) = M$. Sifat-sifat berikut dapat digunakan
untuk menghitung limit.

#figure(
  caption: [Tabel sifat-sifat limit],
  [
    #table(
      columns: (1fr, 1fr),
      inset: 10pt,
      align: (left, horizon),
      fill: (col, row) => {
          if row == 0 {
          cmyk_purple.lighten(90%)
        } else {
          none
        }
      },
      table.header(
        [*Sifat*], [*Persamaan*],
      ),
      [Konstanta & fungsi identitas], [$ lim_(x -> c) k = k quad; quad lim_(x -> c) x = c $],
      [Perkalian dengan konstanta], [$ lim_(x -> c) k f(x) = k L $],
      [Penjumlahan dan pengurangan], [$ lim_(x -> c) [f(x) +- g(x)] = L +- M $],
      [Perkalian], [$ lim_(x -> c) [f(x) g(x)] = L M $],
      [Pembagian], [$ lim_(x -> c) frac(f(x), g(x)) = frac(L, M) quad (M != 0) $],
      [Pangkat], [$ lim_(x -> c) [f(x)]^n = L^n $],
    )  
  ]
)

Sifat pangkat dan akar berlaku dengan memperhatikan domain
fungsi dan syarat yang diperlukan.

=== Menghitung Limit dengan Aljabar

Untuk menghitung limit, ikuti langkah-langkah berikut.

+ *Substitusi langsung:* masukkan nilai $x = c$ ke dalam fungsi.
+ *Periksa hasilnya:* jika diperoleh nilai yang terdefinisi,
  nilai tersebut merupakan hasil limit.
+ *Jika muncul bentuk $0/0$:* sederhanakan fungsi menggunakan
  pemfaktoran, rasionalisasi, teorema L'Hôpital, atau cara lainnya.
+ *Jika muncul bentuk $k/0$ dengan $k != 0$:* ini bukan bentuk tak tentu.
  Periksa limit kiri dan kanan; limitnya $infinity$, $-infinity$, atau tidak ada.
+ *Jika $x -> infinity$:* bagi pembilang dan penyebut dengan
  pangkat tertinggi pada penyebut.
+ *Substitusi kembali:* setelah fungsi disederhanakan,
  masukkan kembali nilai $x = c$ untuk menentukan limit.

Ingat, bentuk $0/0$ merupakan bentuk tak tentu, bukan hasil
akhir. Bentuk tersebut tidak otomatis berarti limit tidak ada.

=== Limit di Tak Hingga

Limit di tak hingga menjelaskan perilaku $f(x)$ ketika $x$ membesar tanpa batas ($x -> infinity$). Dasarnya:

$ lim_(x -> infinity) 1/x^n = 0 quad (n > 0) $

Untuk pecahan polinomial, bagi pembilang dan penyebut dengan pangkat tertinggi pada penyebut. Hasilnya bergantung pada perbandingan pangkat tertinggi:

#figure(
  caption: figure.caption(position: top)[Limit di tak hingga untuk pecahan polinomial],
  table(
    columns: (1fr, 1fr),
    inset: 10pt,
    align: (left, horizon),
    fill: (col, row) => if row == 0 { cmyk_purple.lighten(90%) } else { none },
    table.header([*Pangkat tertinggi pembilang*], [*Hasil limit*]),
    [Lebih kecil dari penyebut], [$0$],
    [Sama dengan penyebut], [Perbandingan koefisien suku tertinggi],
    [Lebih besar dari penyebut], [$+infinity$ atau $-infinity$ (tergantung tanda koefisien)],
  ),
)

Jika $lim_(x -> infinity) f(x) = L$, garis $y = L$ disebut asimtot mendatar dari grafik $f$.

#pagebreak()

== Latihan Soal

*Silang ($crossmark$) pada salah satu huruf (A, B, C, atau D)*
#columns(2, gutter: 10pt)[
  #soal-pg(
    [Tentukan nilai dari $lim_(x -> 2) (x^2 + 3x - 1)$.],
    (
      [$7$],
      [$8$],
      [$9$],
      [$11$],
    )
  )

  #soal-pg(
    [
      #graph(
        style: (arrow: 0pt, overhang: 0pt),
        x: (-5, 7),
        y: (-2, 10),
        scale: 0.61cm,
        x-step: 3,
        y-step: 3,
        minor: 3,

        fn(x => x + 3, domain: (-2, 1), stroke: cmyk_purple),
        fn(x => x + 3, domain: (1, 4), stroke: cmyk_blue),
      
        // Titik ujung kosong
        points((1, 4), mark: "circle", stroke: cmyk_vermil),
        points((-2, 1), mark: "circle", stroke: cmyk_purple),
        points((0, 3), stroke: cmyk_purple),
        points((1, 7), stroke: cmyk_blue),
        points((4, 7), mark: "circle", stroke: cmyk_blue),
      )
      Perhatikan grafik fungsi $f(x)$ di atas. Nilai dari $lim_(x -> 1) f(x)$ adalah ...
    ],
    (
      [$4$],
      [$7$],
      [$11$],
      [Limit tidak ada],
    )
  )

  #soal-pg(
    [Jika $lim_(x -> 2^-) f(x) = 3$ dan
    $lim_(x -> 2^+) f(x) = 5$, maka ...],
    (
      [$lim_(x -> 2) f(x) = 3$],
      [$lim_(x -> 2) f(x) = 4$],
      [$lim_(x -> 2) f(x) = 5$],
      [Limit dua sisi tidak ada],
    )
  )

  #soal-pg(
    [Tentukan nilai dari
    $lim_(x -> 3) (x^2 - 9)/(x - 3)$.],
    (
      [$3$],
      [$6$],
      [$9$],
      [Limit tidak ada],
    )
  )

  #soal-pg(
    [Tentukan nilai dari
    $lim_(x -> 1) (x^2 - 1)/(x^2 - 3x + 2)$.],
    (
      [$-2$],
      [$-1$],
      [$1$],
      [$2$],
    )
  )

  #soal-pg(
    [Tentukan nilai dari
    $lim_(x -> 4) (sqrt(x + 5) - 3)/(x - 4)$.],
    (
      [$1/3$],
      [$1/6$],
      [$3$],
      [$6$],
    )
  )

  #soal-pg(
    [Diketahui $lim_(x -> c) f(x) = 2$ dan
    $lim_(x -> c) g(x) = -3$. Nilai
    $lim_(x -> c) [2f(x) - g(x)]$ adalah ...],
    (
      [$1$],
      [$4$],
      [$7$],
      [$-7$],
    )
  )

  #soal-pg(
    [Jika substitusi langsung pada suatu limit menghasilkan
    bentuk $0/0$, langkah yang tepat adalah ...],
    (
      [Langsung menyimpulkan bahwa limitnya nol],
      [Langsung menyimpulkan bahwa limit tidak ada],
      [Menyederhanakan fungsi menggunakan metode yang sesuai],
      [Membagi pembilang dan penyebut dengan nol],
    )
  )

  #soal-pg(
    [Tentukan nilai dari
    $lim_(x -> infinity) (6x^2 + x)/(2x^2 - 5)$.],
    (
      [$0$],
      [$3$],
      [$6$],
      [$infinity$],
    )
  )

  #soal-pg(
    [Posisi suatu benda setelah $t$ detik dinyatakan oleh
    $s(t) = t^2$ meter. Kecepatan sesaat pada $t = 3$
    dapat dihitung dengan
    $lim_(h -> 0) (s(3+h) - s(3))/h$.
    Nilainya adalah ....],
    (
      [$3 "m/s"$],
      [$6 "m/s"$],
      [$9 "m/s"$],
      [$12 "m/s"$],
    )
  )
]