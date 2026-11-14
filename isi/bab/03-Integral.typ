
// BAB 3: Integral

#import "@preview/lilaq:0.6.0" as lq
#import "@preview/mannot:0.4.0": *
#import "@preview/cetz:0.5.2"
#import "@preview/quadrille:0.1.0": *
#import "@preview/cetz-plot:0.1.4": plot
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "../template.typ": *

#bab(
  // Judul
  "Integral",

  // Deskripsi
  "Memahami konsep integral, aturan dasar, integral tentu, dan penerapannya.",

  // Gambar
  "assets/bab3/cover.jpg",
  "Di balik hamparan bintang dan nebula, terdapat kumpulan bagian-bagian kecil yang membentuk keseluruhan. Namun, bagaimana kita dapat menghitung dan memahami akumulasi tersebut secara matematis?",
  "\"Webb brings cosmic lenses into focus\" Oleh NASA's James Webb Space Telescope, CC BY 4.0",

  // Kata kunci
  kata-kunci: ("Tak Tentu", "Interval", "Riemann", "Antiturunan", "Akumulasi")
)

// #tujuan[
//   // Setelah mempelajari bab ini, Anda diharapkan untuk mampu menemukan konsep dan penerapan melalui penyelesaian masalah tentang integral tak tentu, dan integral tentu.
// ]
#tujuan[
  Anda akan mempelajari:
  #v(-.8em)
  #badges(
    badge[Konsep Integral sebagai Akumulasi],
    badge[Antiturunan & Integral Tak Tentu],
    badge[Aturan Dasar Integral],
    badge[Jumlah Riemann],
    badge[Teorema Dasar Kalkulus],
    badge[Integral Tentu & Sifatnya],
    badge[Luas Daerah],
    badge[Penerapan Integral]
  )

  Bab ini tidak mencakup:
  #v(-.8em)
  #badges(
    badge(warna: cmyk_border, [Integral Substitusi]),
    badge(warna: cmyk_border, [Integral Parsial]),
    badge(warna: cmyk_border, [Integral Trigonometri]),
    badge(warna: cmyk_border, [Volume Benda Putar]),
    badge(warna: cmyk_border, [Integral Lipat Dua])
  )
]

#mengapa(judul: [Mengapa harus belajar Integral?], [
  Sadar atau tidak, dunia tempat kita tinggal tidak pernah benar-benar terbagi menjadi kotak-kotak yang rapi. Segala hal di sekitar kita bergerak, berubah, dan menumpuk tanpa jeda.

  Coba perhatikan air hujan di luar jendela. Satu tetes terasa sepele, tetapi tetes demi tetes yang terus mengalir sanggup mengisi ember hingga penuh. Begitu pula kecepatanmu saat bepergian, yang berubah setiap detik: melambat saat macet, melaju saat jalanan senggang.

  Lantas, bagaimana mengukur total dari sesuatu yang terus berubah? Di sinilah Integral berperan, yaitu cara matematika mengumpulkan potongan-potongan momen yang sangat kecil menjadi satu gambaran utuh.
])

== Apa itu Integral?

Bella dan Chandra sedang menguji sepeda di lintasan sekolah. Chandra bertugas mengendarai sepeda, sedangkan Bella mengamati dan mencatat perubahan kecepatannya. Mereka ingin mengetahui seberapa jauh sepeda tersebut bergerak selama 90 detik.

Mereka teringat pelajaran IPA pada saat kelas V SD tentang cara menghitung jarak menggunakan rumus:

#align(center)[
  #eq-highlight[
    $ s = v times t $
  ]
]

Dengan $s$ sebagai jarak, $v$ sebagai kecepatan, dan $t$ sebagai waktu.

Rumus tersebut dapat digunakan jika kecepatan tetap atau jika kecepatan rata-rata sepanjang perjalanan diketahui. Namun, Bella dan Chandra menghadapi suatu masalah: kecepatan sepeda terus berubah. Sepeda yang awalnya bergerak perlahan semakin cepat, kemudian melambat kembali.

Bagaimana mereka dapat memperkirakan jarak tempuhnya jika kecepatan tidak selalu sama?

Bella kemudian membagi waktu perjalanan menjadi beberapa interval. Pada setiap interval, ia mencatat kecepatan rata-rata sepeda, lalu menggunakan data tersebut untuk memperkirakan jarak yang ditempuh.

Mari kita amati grafik pertama yang dibuat Bella pada @grafik-bela-lama. Pada grafik ini, waktu dibagi menjadi interval 10 detik.

#figure(
  caption: figure.caption(position: top)[Grafik Batang buatan Bella],
  [
    #show: lq.show_(
      lq.tick-label.with(kind: "x"),
      it => box(
        width: 0pt,
        align(right, rotate(-45deg, reflow: true, it))
      ),
    )

    #let v-bella1 = (1, 3, 3.5, 4, 3.5, 3, 2.5, 2, 1)
    
    #lq.diagram(
      xaxis: (
        ticks: ($0-10$, $10-20$, $20-30$, $30-40$, $40-50$, $50-60$, $60-70$, $70-80$, $80-90$)
          .enumerate(),
        subticks: none,
      ),
      ylim: (0, 5),
      width: 15cm,
      height: 5cm,
      xlabel: [Interval (setiap $10$ detik)],
      ylabel: [Kecepatan ($"m/s"$)],
      lq.bar(
        width: 40%,
        fill: cmyk_purple.lighten(70%),
        range(9),
        v-bella1,
      ),
      ..v-bella1.enumerate().map(((i, v)) => lq.place(
        i, v + .5,
        box(fill: white, inset: 2pt, radius: 2pt)[$#str(v).replace(".", ",")$],
        align: center + horizon,
      )),
    )
  ]
)<grafik-bela-lama>

Setiap batang mewakili satu interval waktu. Dengan mengalikan kecepatan rata-rata dan lama interval, mereka dapat memperkirakan jarak yang ditempuh selama interval tersebut. Jika seluruh perkiraan dijumlahkan, mereka memperoleh perkiraan jarak total perjalanan.

Pada grafik @grafik-bela-lama, lebar setiap batang adalah $Delta t = 10$ detik dan ada $9$ batang. Jarak pada setiap interval adalah kecepatan dikali lama interval, sehingga jarak total dapat diperkirakan dengan menjumlahkan semuanya dengan notasi sigma@wp-summation sebagai berikut: 

$ s approx sum_(i=1)^9 v_i Delta t $

Dengan membaca tinggi setiap batang, diperoleh:

$
  s &approx (1 + 3 + "3,5" + 4 + "3,5" + 3 + "2,5" + 2 + 1) times 10 \
  &= "23,5" times 10 \
  &= 235 "m"
$

Jadi, perkiraan jarak yang ditempuh sepeda selama 90 detik adalah $235 "m"$.

Namun, bagaimana jika interval waktunya diperkecil lagi? Misal saja menjadi 5 detik?

#figure(
  caption: figure.caption(position: top)[Revisi Grafik Batang buatan Bella],
  [
    #show: lq.show_(
      lq.tick-label.with(kind: "x"),
      it => box(
        width: 0pt,
        align(right, rotate(-45deg, reflow: true, it))
      ),
    )

    #let v-bella2 = (1, 2.5, 3, 3, 3.5, 3.5, 4, 4, 3.5, 4, 3, 2.5, 2.5, 2, 2, 1.5, 1, 1)
    
    #lq.diagram(
      xaxis: (
        ticks: ($0-5$, $5-10$, $10-15$, $15-20$, $20-25$, $25-30$, $30-35$, $35-40$, $40-45$, $45-50$, $50-55$, $55-60$, $60-65$, $65-70$, $70-75$, $75-80$, $80-85$, $85-90$)
          .enumerate(),
        subticks: none,
      ),
      ylim: (0, 5),
      width: 15cm,
      height: 5cm,
      xlabel: [Interval (setiap $5$ detik)],
      ylabel: [Kecepatan ($"m/s"$)],
      lq.bar(
        width: 60%,
        fill: cmyk_purple.lighten(70%),
        range(18),
        v-bella2
      ),
      ..v-bella2.enumerate().map(((i, v)) => lq.place(
        i, v + .5,
        box(fill: white, inset: 2pt, radius: 2pt)[$#str(v).replace(".", ",")$],
        align: center + horizon,
      )),
    )
  ]
)

Perhatikan bahwa grafik kedua memberikan gambaran perubahan kecepatan yang lebih terperinci. Dengan interval yang lebih kecil, perkiraan jarak pada setiap interval dapat menggambarkan perjalanan dengan lebih baik.

Sekarang lebar setiap batang adalah $Delta t = 5$ detik dan ada $18$ batang. Rumusnya sama, hanya jumlah suku dan $Delta t$ yang berubah.

$ s approx sum_(i=1)^18 v_i Delta t = (v_1 + v_2 + dots.c + v_18) times 5 $

Perhatikan lagi bahwa grafik ini memberikan gambaran perubahan kecepatan yang lebih terperinci. Akan tetapi, jika interval terus diperkecil, jumlah perhitungan yang diperlukan juga semakin banyak.

Lantas, adakah cara matematis untuk menangani besaran yang terus berubah dan menghitung akumulasinya tanpa harus menjumlahkan begitu banyak bagian secara manual? Sebelum itu kita coba bantu Bella dan Chandra terlebih dahulu.

#eksplor(pecah: false)[
  Bella telah merevisi grafiknya dengan membagi waktu perjalanan menjadi interval 5 detik. Sekarang, mari kita bantu Bella dan Chandra memperkirakan jarak yang ditempuh sepeda selama 90 detik!

  Kita sudah mengetahui bahwa jarak dapat dihitung menggunakan rumus:

  $ s = v times t $

  Misalnya, pada interval 0–5 detik, kecepatan sepeda tercatat sebesar $"1 m/s"$. Dengan menganggap kecepatan tersebut mewakili seluruh interval, jarak yang ditempuh dapat diperkirakan sebagai berikut.
  
  $ s = 1 times 5 = 5 $

  Nah, bagaimana dengan interval lainnya?

  Coba selesaikan pertanyaan berikut!
  + Berapa perkiraan jarak yang ditempuh sepeda pada interval 5–10 detik jika kecepatannya $"2,5 m/s"$?
  + Bagaimana cara menghitung perkiraan jarak total dengan memanfaatkan seluruh batang pada grafik?
  + Jika interval waktu diperkecil lagi menjadi 1 detik, apa keuntungan dan kesulitan yang mungkin muncul?
  
]

Menghitung jarak tempuh dengan menjumlahkan setiap interval memang bisa dilakukan. Namun, semakin kecil interval waktu yang digunakan, semakin banyak pula perhitungan yang harus kita lakukan. Selain itu, hasil yang diperoleh masih berupa perkiraan karena kecepatan di setiap interval dianggap mewakili seluruh interval tersebut.

Lantas, adakah cara yang lebih sistematis untuk menghitung jarak tempuh tanpa harus menjumlahkan begitu banyak bagian satu per satu? Tentu saja ada! Dalam matematika, kita mengenal sebuah konsep yang memungkinkan kita menghitung akumulasi suatu besaran yang terus berubah, yaitu integral.

=== Definisi
// Integral merupakan konsep matematika yang digunakan untuk menghitung akumulasi atau jumlah keseluruhan dari bagian-bagian kecil.

// Dalam pembelajaran ini, integral akan digunakan untuk menghitung berbagai bentuk fungsi, luas daerah, dan nilai suatu besaran pada interval tertentu.

// Integral merupakan salah satu cabang dari ilmu kalkulus yang digunakan untuk mengukur jumlah atau akumulasi dari sesuatu dalam sebuah domain tertentu. Integral juga bisa dianggap sebagai "kebalikan" dari operasi diferensial sehingga disebut juga "anti turunan". Secara sederhana, penjumlahan kontinu yang terdiri dari anti turunan disebut dengan "integral".

Pada cerita sebelumnya, kita telah membantu Bella dan Chandra memperkirakan jarak tempuh sepeda dengan menjumlahkan jarak pada setiap interval waktu. Dari kegiatan tersebut, kita mulai mengenal gagasan penting dalam kalkulus, yaitu menghitung akumulasi dari suatu besaran yang berubah.

Namun, integral tidak hanya berkaitan dengan perhitungan jarak atau luas daerah. Integral juga memiliki hubungan erat dengan materi yang telah kita pelajari sebelumnya, yaitu turunan.

Ingat kembali bahwa turunan digunakan untuk mengetahui bagaimana suatu besaran berubah dengan melihat kemiringannya. Sebagai contoh, jika kita mengetahui fungsi posisi suatu benda, turunannya dapat memberikan fungsi kecepatan benda tersebut. Sebaliknya, jika fungsi kecepatan diketahui, kita dapat mencari fungsi posisi melalui proses yang disebut antiturunan.

Proses mencari antiturunan merupakan salah satu bentuk integral. Di sisi lain, integral juga dapat digunakan untuk menghitung akumulasi suatu besaran dalam interval tertentu, seperti jarak tempuh ketika kecepatan berubah atau luas daerah di bawah kurva.

Dengan demikian, integral dapat dipahami melalui dua gagasan yang saling berkaitan:

+ Integral tak tentu, yaitu proses mencari antiturunan suatu fungsi.
+ Integral tentu, yaitu proses menghitung akumulasi suatu besaran pada interval tertentu.

Kedua gagasan tersebut merupakan bagian penting dari kalkulus. Meskipun memiliki bentuk dan tujuan yang berbeda, keduanya saling berhubungan melalui sebuah teorema yang disebut *Teorema Dasar Kalkulus*.@wp-fundamental-theorem-calculus

== Integral Tak Tentu

Pada bab sebelumnya, kita telah mempelajari turunan sebagai salah satu cara untuk mengetahui laju perubahan suatu fungsi. Namun, pernahkah kamu berpikir tentang pertanyaan sebaliknya?

Jika kita mengetahui hasil turunan suatu fungsi, apakah kita dapat menemukan fungsi asalnya?

Mari kita ingat kembali salah satu aturan turunan yang telah dipelajari.

Misalnya, kita memiliki fungsi:

$ f(x) = x^2 $

Jika fungsi tersebut diturunkan, kita memperoleh:

$ f'(x) = 2x $

Sekarang, bayangkan jika kita hanya mengetahui hasil turunannya, yaitu $2x$, tetapi tidak mengetahui fungsi asalnya. Dapatkah kita menemukan fungsi yang jika diturunkan akan menghasilkan $2x$?

Coba pikirkan sejenak sebelum melanjutkan ke pembahasan berikutnya.

Pertanyaan semacam inilah yang akan kita pelajari melalui integral tak tentu. Jika turunan membawa kita dari suatu fungsi menuju laju perubahannya, integral tak tentu membantu kita menelusuri kembali fungsi yang menghasilkan turunan tersebut.

=== Pengertian Antiturunan

Mari kita kembali ke permasalahan sepeda Bella dan Chandra. Misalkan $s(t)$ adalah posisi sepeda (jarak dari garis start) pada waktu $t$, dan $v(t)$ adalah kecepatannya. Kecepatan adalah turunan dari posisi:

$ s'(t) = v(t) $

Pada saat itu Chandra kebetulan memiliki Spidometer terpasang di sepedanya dan hanya menampilkan $v(t)$. Bagaimana jika kita ingin tahu posisi sepeda hanya dari data kecepatan spidometer Chandra? Kita perlu "membalik" turunan, yaitu mencari fungsi yang jika diturunkan menghasilkan $v(t)$. Fungsi inilah yang disebut *antiturunan*.

Sebagai contoh, jika posisi sepeda $s(t) = t^2$ meter, maka kecepatannya $v(t) = 2t "m/s"$. Sebaliknya, jika spidometer menunjukkan $v(t) = 2t$, kita dapat menebak bahwa posisinya adalah $s(t) = t^2$.

Gagasan ini berlaku untuk fungsi apa pun, bukan hanya posisi dan kecepatan. Secara umum, antiturunan didefinisikan sebagai berikut.

Fungsi $F(x)$ disebut antiturunan dari $f(x)$ jika turunan $F(x)$ adalah $f(x)$.

#align(center)[
  #eq-highlight[
    $ F'(x) = f(x) $
  ]
]

#info[
  Huruf besar $F$ adalah fungsi asal (hasil antiturunan), sedangkan huruf kecil $f$ adalah hasil turunannya. Pada contoh sepeda, $F$ adalah $s$ dan $f$ adalah $v$.
]

Kita sudah tahu bahwa turunan dari $x^2$ adalah $2x$. Artinya, $x^2$ adalah antiturunan dari $2x$. Namun, apakah $x^2$ satu-satunya antiturunan $2x$? Coba perhatikan @fungsi-beda-tapi-turunan-sama berikut.

#figure(
  table(
    columns: (6cm, 6cm),
    inset: 10pt,
    fill: (col, row) => if row == 0 { cmyk_purple.lighten(88%) } else { none },
    align: center,

    [*Fungsi*], [*Turunannya*],

    [$x^2$], [$2x$],
    [$x^2 + 5$], [$2x$],
    [$x^2 - pi$], [$2x$],
    [$x^2 + 100000$], [$2x$],
    [$dots.v$], [$dots.v$],
    [$x^2 + C$], [$2x$],
  ),
  caption: [Fungsi berbeda dengan turunan yang sama]
)<fungsi-beda-tapi-turunan-sama>

Keempat fungsi tersebut berbeda, tetapi turunannya sama. Hal ini terjadi karena turunan dari suatu konstanta adalah nol, sehingga menambah atau mengurangi konstanta tidak mengubah turunan. Dengan demikian, $x^2$, $x^2 + 5$, $x^2 - pi$, dan seterusnya semuanya adalah antiturunan dari $2x$.

Pada cerita sepeda, ini masuk akal. Bayangkan dua sepeda dengan posisi $s(t) = t^2$ dan $s(t) = t^2 + 5$. Sepeda kedua mulai $5$ m di depan sepeda pertama, karena $s(0) = 5$. Keduanya bergerak dengan kecepatan yang sama, $v(t) = 2t$, sehingga jarak di antara mereka selalu $5$ m.

Ingat, turunan hanya mengukur seberapa cepat posisi berubah*, bukan *dari mana posisi itu dimulai. Karena itu, posisi awal yang berbeda menghasilkan kecepatan yang sama. Sebaliknya, jika kita hanya tahu $v(t) = 2t$, kita tidak dapat mengetahui posisi awal sepeda, sehingga ada banyak fungsi posisi yang mungkin.

Semua kemungkinan tersebut dapat diwakili dengan satu bentuk, yaitu menambahkan konstanta $C$ yang nilainya bebas.

#align(center)[
  #figure(
    caption: figure.caption(position: top)[Turunan dan antiturunan saling berkebalikan],
    gap: 1em,
    [
      #grid(
        columns: (4.6cm, 1.4cm, 4.6cm, 1.4cm, 4.6cm),
        rows: (auto, 1cm),
        column-gutter: 1pt,
        align: center + horizon,
        kotak-smart-art[$x^2$], panah, kotak-smart-art[$2x$], panah, kotak-smart-art[$x^2 + C$],
        [], label[Turunan], [], label[Antiturunan], [],
      )
    ]
  )
]

Perhatikan bahwa dari $x^2$ ke $2x$ kita hanya memperoleh satu hasil, tetapi dari $2x$ kembali ke fungsi asal kita memperoleh satu keluarga fungsi yang banyak, yaitu $x^2 + C$.

#eksplor[
  Tentukan satu fungsi yang turunannya adalah fungsi berikut. Caranya: tebak fungsi asalnya, lalu periksa dengan menurunkannya kembali.

  + $3x^2$
  + $4x^3$
  + $2x$
  + $5$

  Perhatikan pangkat pada soal dan pangkat pada jawabanmu. Pola apa yang kamu lihat?

  Petunjuk: menurunkan $x^n$ menghasilkan $n x^(n-1)$, yaitu pangkat turun satu dan pangkat lama menjadi pengali. Sekarang balik langkahnya. Pada soal $3x^2$, pangkat $2$ berasal dari pangkat berapa, dan apakah angka $3$ cocok sebagai pengali? Untuk soal $5$, ingat bahwa $5 = 5x^0$.
]

Dengan tebak dan periksa, kamu sudah dapat mencari antiturunan sendiri. Pada subbab berikutnya, kumpulan antiturunan tersebut dituliskan dengan notasi integral.

=== Notasi Integral & Konstanta Integrasi

#let bmark = mark.with(color: cmyk_blue)
#let pmark = mark.with(color: cmyk_purple)

Pada subbab sebelumnya kita melihat bahwa $2x$ memiliki banyak antiturunan: $x^2$, $x^2 + 5$, $x^2 - pi$, dan seterusnya. Proses mencari antiturunan ini disebut integrasi, dan hasilnya dinyatakan dalam bentuk integral tak tentu.

_"Mengapa disebut 'tak tentu'?"_ Karena hasilnya bukan satu fungsi yang pasti, melainkan sekumpulan fungsi dengan nilai $C$ yang belum ditentukan. Kita juga tidak diberi batas integrasi yang menentukan satu nilai. Sebaliknya, integral tentu memakai batas bawah dan batas atas, sehingga hasilnya satu nilai yang pasti.

Secara umum, integral tak tentu dituliskan sebagai berikut.

#eq-numbered[
  $ \ \ 
    pmark(integral, #<not-integral>) bmark(f(x), #<not-integran>), dif x = bmark(F(x), #<not-Fx>) + pmark(C, #<not-C>) 
    #{
      annot(<not-integral>, pos: left, dx: -1em, dy: -1em, annot-text-props: (size: .9em))[integral]
      annot(<not-integran>, pos: top + left, dy: -1.5em, leader-connect: "elbow", annot-text-props: (size: .9em))[integran]
      // annot(<not-dx>, pos: top, dy: -1.3em, annot-text-props: (size: .9em))[(3)]
      annot(<not-Fx>, pos: top + right, dy: -1.5em, leader-connect: "elbow", annot-text-props: (size: .9em))[antiturunan $f(x)$]
      annot(<not-C>, pos: bottom + right, dx: 1em, annot-text-props: (size: .9em))[konstanta]
    }
  $
]<integral>

Setiap bagian pada @integral, dalam notasi tersebut memiliki makna tersendiri.

+ $integral$ disebut tanda integral, yang menunjukkan operasi integrasi.
+ $f(x)$ disebut integran, yaitu fungsi yang akan diintegralkan.
+ $dif x$ menunjukkan bahwa integrasi dilakukan terhadap variabel $x$. Nanti pada integral tentu, $dif x$ berperan seperti lebar $Delta x$ pada batang-batang Riemann.
+ $F(x)$ merupakan salah satu antiturunan dari $f(x)$.
+ $C$ adalah konstanta integrasi yang dapat berupa bilangan real.

Ingat bahwa $C$ boleh bilangan riil apa pun, dan setiap nilai $C$ menghasilkan satu antiturunan dari $2x$. Kalau beberapa di antaranya kita gambar, hasilnya seperti pada @keluarga-integral-c!

#let kc-keluarga = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (6, 5), axis-style: "school-book",
    x-tick-step: 1, y-tick-step: 2,
    x-min: -3, x-max: 3.3, y-min: -3, y-max: 7,
    {
      for c in (-2, -1, 0, 1, 2) {
        let col = if c == 0 { cmyk_purple } else { cmyk_blue }
        let dash = if c == 0 { "solid" } else { "dashed" }
        plot.add(x => x * x + c, domain: (-3, 2.2), style: (stroke: (paint: col, dash: dash)))
        // garis singgung di x = 1: kemiringannya sama (= 2) untuk semua C
        plot.add(x => 2 * x - 1 + c, domain: (0, 1.8), style: (stroke: cmyk_vermil + 1pt))
        // titik singgung di x = 1
        plot.add(((1, 1 + c),),
          style: (stroke: none),
          mark: "o", mark-size: .2,
          mark-style: (fill: cmyk_vermil, stroke: white + 1pt))
      }
      plot.annotate({
        for c in (-2, -1, 0, 1, 2) {
          content((2.4, 4.9 + c), $C = #c$, anchor: "west")
        }
      })
    },
  )
})

#figure(
  caption: figure.caption(position: top)[Keluarga kurva $y = x^2 + C$. Garis oranye (#garis-singgung(paint: cmyk_vermil)) adalah garis singgung di $x = 1$: kemiringannya sama untuk setiap $C$.],
  kc-keluarga,
)<keluarga-integral-c>

Setiap nilai $C$ menggeser parabola ke atas atau ke bawah. Bentuknya sama, dan kemiringan di setiap $x$ juga sama, itulah sebabnya turunannya sama.

#funfact[
  Grafik pada @keluarga-integral-c memang sengaja hanya menampilkan lima kurva ($C = -2$ sampai $2$). Padahal $C$ boleh bilangan riil apa pun, termasuk $0,5$, $-1,37$, $pi$, dst. Kalau semuanya digambar, kurva akan menumpuk rapat dan memenuhi seluruh bidang. Meski begitu, setiap titik pada bidang dilalui tepat satu kurva. Itulah sebabnya satu titik saja cukup untuk menentukan nilai $C$, seperti pada soal nilai awal nanti.
]

Maka, integral tak tentu dari $2x$ dapat dituliskan sebagai berikut.

#eq-numbered[
  $ integral 2x, dif x = x^2 + C $
]

Kita dapat memeriksanya dengan menurunkan hasilnya: turunan $x^2 + C$ adalah $2x$, sama dengan integrannya.

== Aturan Dasar Integral

=== Aturan Pangkat

Pada kegiatan eksplor mencari antiturunan tadi, kamu menemukan bahwa pangkat jawaban selalu lebih besar satu daripada pangkat soal. Sekarang kita buktikan pola tersebut secara umum, sekaligus mencari tahu mengapa ada pembaginya.

#mengapa(judul: [Mengapa aturannya seperti itu?], [
  Sebagai contoh konkret, turunan $x^4$ adalah $4x^3$. Agar hasilnya tepat $x^3$, kita bagi $x^4$ dengan $4$. Dengan demikian, $frac(x^4, 4)$ adalah antiturunan dari $x^3$.

  Kita mulai dari turunan $x^(n+1)$:
  
  $ frac(dif, dif x) x^(n+1) = (n+1) x^n $
  
  Hasilnya mengandung faktor tambahan $(n+1)$, padahal kita hanya menginginkan $x^n$. Faktor itu dapat dihilangkan dengan membagi $x^(n+1)$ dengan $(n+1)$:
  
  $ frac(dif, dif x) (frac(x^(n+1), n+1)) = frac(1, cancel(n+1)) dot cancel((n+1)) x^n = x^n $
])

Karena $C$ juga antiturunan dari nol, hasil akhirnya ditambah konstanta integrasi. Inilah aturan pangkat: pangkat ditambah satu, lalu dibagi dengan pangkat yang baru.

#side-by-side(
  [
    Untuk fungsi berbentuk $x^n$, pangkat $n$ ditambah satu. Selanjutnya, $x$ dipangkatkan dengan hasil tersebut, lalu dibagi dengan pangkat barunya.

    Aturan ini berlaku untuk semua bilangan riil $n$ kecuali $-1$.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $
          integral x^n dif x &= frac(x^(n+1), n+1) + C \
        $
      ]
      $ n != -1 $
    ]
  ],
)

#side-by-side(
  [
    Sebagai contoh, mari kita tentukan integral dari $x^3$.

    Dengan demikian, integral dari $x^3$ adalah $frac(x^4, 4) + C$.
  ],
  [
    #eq-numbered[
      $ 
        \
        integral x^pmark(3, #<int-atr-pangkat-3-1>) dif x 
        &= frac(x^(pmark(3, #<int-atr-pangkat-3-2>)+1), pmark(3, #<int-atr-pangkat-3-3>)+1) + C \
        &= frac(x^4, 4) + C 

        #annot-cetz(
          (<int-atr-pangkat-3-1>, <int-atr-pangkat-3-2>, <int-atr-pangkat-3-3>),
          cetz,
          {
            import cetz.draw: *
        
            set-style(mark: (end: "straight"))
            bezier-through("int-atr-pangkat-3-1.north", (rel: (x: .5, y: .6)), "int-atr-pangkat-3-2.north-west", stroke: cmyk_purple + .7pt)
            bezier-through("int-atr-pangkat-3-1.south", (rel: (x: .2, y: -.5)), "int-atr-pangkat-3-3.south-west", stroke: cmyk_purple + .7pt)
          },
        )
      $
    ]
  ]
)

_"Mengapa $n != -1$?"_, jika $n = -1$, penyebutnya menjadi $n + 1 = 0$ sehingga rumusnya tidak terdefinisi. Secara intuitif, tidak ada pangkat yang turunannya $x^(-1)$, karena turunan $x^0$ adalah $0$. Antiturunan dari $x^(-1)$ adalah fungsi jenis lain, di luar cakupan bab ini.

_"Berlaku untuk pangkat apa saja?"_. Aturan ini tidak terbatas pada pangkat bulat positif. Pangkat nol, negatif, dan pecahan juga dapat dikerjakan dengan cara yang sama.

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 10pt,
    fill: (col, row) => if row == 0 { cmyk_purple.lighten(88%) } else { none },
    align: center + horizon,

    [*Bentuk soal*], [*Ditulis sebagai pangkat*], [*Hasil*],

    [$integral 1 dif x$], [$integral x^0 dif x$], [$x + C$],
    [$integral frac(1, x^2) dif x$], [$integral x^(-2) dif x$], [$-x^(-1) + C = -frac(1, x) + C$],
    [$integral sqrt(x) dif x$], [$integral x^(1/2) dif x$], [$frac(2, 3) x^(3/2) + C$],
  ),
  caption: [Aturan pangkat untuk pangkat nol, negatif, dan pecahan]
)

#info[
  Tips: ubah akar dan pecahan menjadi bentuk pangkat terlebih dahulu, misalnya $sqrt(x) = x^(1/2)$ dan $frac(1, x^2) = x^(-2)$, baru gunakan aturan pangkat.
]

#side-by-side(
  [
    Sebagai contoh, mari kita tentukan integral dari $frac(1, x^2)$.

    Ubah menjadi pangkat negatif, lalu gunakan aturan pangkat. Hasilnya dapat diperiksa dengan menurunkan $-x^(-1)$, yaitu $x^(-2)$.
  ],
  [
    #eq-numbered[
      $
        integral frac(1, x^2) dif x
        &= integral x^(-2) dif x \
        &= frac(x^(-1), -1) + C \
        &= -frac(1, x) + C
      $
    ]
  ]
)

#figure(
  caption: figure.caption(position: top)[Hubungan turunan dan integral pada aturan pangkat],
  gap: 2em,
  diagram(
    node-stroke: cmyk_blue + 1pt,
    node-corner-radius: 4pt,
    node-inset: 10pt,
    spacing: (10em, 0em),
    node((0, 0), $ x^n $, name: <pg-a>, height: 2cm, width: 2cm),
    node((1, 0), $ frac(x^(n+1), n+1) $, height: 2cm, width: 2cm, name: <pg-b>),
    edge(<pg-a>, <pg-b>, "-|>", stroke: cmyk_blue, bend: 35deg, label-side: left, mark-scale: 200%,
      label: [Integral: pangkat $+1$, lalu bagi]),
    edge(<pg-b>, <pg-a>, "-|>", stroke: cmyk_blue, bend: 35deg, label-side: left, mark-scale: 200%,
      label: [Turunan: kalikan pangkat, lalu $-1$]),
  ),
)

=== Aturan Konstanta dan Kelipatan

Fungsi konstan adalah fungsi yang nilainya selalu tetap, tidak bergantung pada perubahan variabel. Untuk mengintegralkan suatu konstanta, kalikan konstanta tersebut dengan variabel integrasinya, kemudian tambahkan konstanta integrasi $C$.

#side-by-side(
  [
    Jika $k$ merupakan konstanta riil dan integrasi dilakukan terhadap $x$, maka integral tak tentunya adalah $\k\x + C$. Hal ini karena turunan dari $\k\x + C$ terhadap $x$ menghasilkan $k$.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $ integral k dif x = \k\x + C $
      ]
    ]
  ],
)

#side-by-side(
  [
    Sebagai contoh, mari kita tentukan integral dari $7$.
    
    Dengan demikian, integral dari $7$ adalah $7x + C$. Kita dapat memeriksa hasilnya dengan menurunkan $7x + C$, yang menghasilkan $7$.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $ 
          integral pmark(7, #<int-atr-kon-7-1>) dif x = pmark(7, #<int-atr-kon-7-2>)x + C 
          #annot-cetz(
            (<int-atr-kon-7-1>, <int-atr-kon-7-2>),
            cetz,
            {
              import cetz.draw: *
          
              set-style(mark: (end: "straight"))
              bezier-through("int-atr-kon-7-1.north", (rel: (x: .5, y: .6)), "int-atr-kon-7-2.north-west", stroke: cmyk_purple + .7pt)
            },
          )
        $
      ]
    ]
  ]
)

Selain konstanta berdiri sendiri, konstanta yang mengalikan suatu fungsi juga dapat dikeluarkan dari integral.

Jika suatu fungsi dikalikan dengan konstanta, konstanta tersebut dapat dikeluarkan dari operasi integral. Dengan demikian, kita cukup mengintegralkan fungsinya terlebih dahulu, kemudian mengalikan hasilnya dengan konstanta tersebut. Jangan lupa menambahkan konstanta integrasi $C$.

#side-by-side(
  [
    Jika $k$ merupakan konstanta real dan $f(x)$ merupakan fungsi yang dapat diintegralkan, maka berlaku aturan berikut.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $ integral k f(x) dif x = k integral f(x) dif x $
      ]
    ]
  ],
)

#mengapa(judul: [Mengapa aturannya seperti itu?],
  [
    Pada turunan, konstanta di depan fungsi tidak berubah saat diturunkan. Misalnya, turunan $5x^2$ adalah $5 dot 2x = 10x$. Secara umum, jika $F'(x) = f(x)$, maka
  
    $ frac(dif, dif x) (k F(x)) = k F'(x) = k f(x) $
    
    Artinya, $k F(x)$ adalah antiturunan dari $k f(x)$. Karena $F(x)$ adalah antiturunan dari $f(x)$, kita dapat menuliskan
    
    $ integral k f(x) dif x = k F(x) + C = k integral f(x) dif x $
    
    Dengan kata lain, konstanta $k$ hanya "menumpang" dan tidak memengaruhi proses mencari antiturunan, sehingga boleh dikeluarkan dulu dan dikalikan kembali di akhir.
  ]
)

#side-by-side(
  [
    Sebagai contoh, mari kita tentukan integral dari $3x^2$. Kita dapat mengeluarkan konstanta $3$ terlebih dahulu, kemudian menerapkan aturan pangkat.
    
    Dengan demikian, integral dari $3x^2$ adalah $x^3 + C$. Kita dapat menggunakan aturan ini untuk menyederhanakan perhitungan integral yang memiliki konstanta pengali.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $ 
          integral pmark(3, #<atr-kk-3-1>)x^2 dif x &= pmark(3, #<atr-kk-3-2>) integral x^2 dif x \
          &= 3 (frac(x^3, 3)) + C \
          &= x^3 + C 

          #annot-cetz(
            (<atr-kk-3-1>, <atr-kk-3-2>),
            cetz,
            {
              import cetz.draw: *
          
              set-style(mark: (end: "straight"))
              bezier-through("atr-kk-3-1.north", (rel: (x: .5, y: .6)), "atr-kk-3-2.north-west", stroke: cmyk_purple + .7pt)
            },
          )
        $
      ] 
    ] 
  ]
)

#info[
  Hanya konstanta yang boleh dikeluarkan. Variabel tidak boleh, misalnya $integral x dot x^2 dif x != x integral x^2 dif x$, karena $x$ bukan konstanta dan ikut berubah saat diintegralkan.
]

=== Penjumlahan dan Pengurangan<int-penj-peng>

Jika suatu fungsi terdiri atas beberapa suku yang dijumlahkan atau dikurangkan, kita dapat mengintegralkan setiap suku secara terpisah. Tanda positif dan negatif pada setiap suku tetap dipertahankan, lalu konstanta integrasi $C$ ditambahkan pada hasil akhirnya.

#side-by-side(
  [
    Integral dari penjumlahan dua fungsi sama dengan jumlah integral masing-masing fungsi.
  ],
  [
    #eq-numbered[
      $ integral (f(x) + g(x)) dif x \
      = integral f(x) dif x + integral g(x) dif x $
    ]
  ],
)

#side-by-side(
  [
    Integral dari selisih dua fungsi sama dengan selisih integral masing-masing fungsi.
  ],
  [
    #eq-numbered[
      $ integral (f(x) - g(x)) dif x \
       = integral f(x) dif x - integral g(x) dif x $
    ]
  ],
)

#mengapa(judul: [Mengapa aturannya seperti itu?],
  [
    Aturan ini mirip sifat distributif pada aljabar: tanda integral "dibagikan" ke setiap suku. Alasannya berasal dari turunan, yang juga dapat dikerjakan suku demi suku:
    
    $ frac(dif, dif x) (F(x) + G(x)) = F'(x) + G'(x) = f(x) + g(x) $
    
    Jadi $F(x) + G(x)$ adalah antiturunan dari $f(x) + g(x)$. Hal yang sama berlaku untuk pengurangan.
  ]
)

#side-by-side(
  [
    Sebagai contoh, mari kita tentukan integral dari $x^2 + 2x - 3$. Kita dapat mengintegralkan setiap suku secara terpisah menggunakan aturan pangkat dan aturan konstanta.
    
    Dengan demikian, integral dari $x^2 + 2x - 3$ adalah $frac(x^3, 3) + x^2 - 3x + C$. Perhatikan bahwa tanda setiap suku tetap dipertahankan dan konstanta integrasi cukup dituliskan satu kali.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $ 
          mark(integral, #<atr-pp-integral>) (pmark(x^2, #<atr-pp-x2>) pmark(+ 2x, #<atr-pp-2x>) pmark(- 3, #<atr-pp-3>)) bmark(dif x, #<atr-pp-dx>) \
          \
          \
          = integral pmark(x^2) bmark(dif x) pmark(+) integral pmark(2x) bmark(dif x) pmark(-) integral pmark(3) bmark(dif x) \ 
          = frac(x^3, 3) + x^2 - 3x + C 

          #annot-cetz(
            (<atr-pp-integral>, <atr-pp-x2>, <atr-pp-2x>, <atr-pp-3>, <atr-pp-dx>),
            cetz,
            {
              import cetz.draw: *
          
              set-style(mark: (end: "straight"))
              bezier-through("atr-pp-integral.north-east", (rel: (x: .3, y: .2)), "atr-pp-x2.north", stroke: cmyk_purple + .7pt)
              bezier-through("atr-pp-integral.north-east", (rel: (x: .3, y: .3)), "atr-pp-2x.north", stroke: cmyk_purple + .7pt)
              bezier-through("atr-pp-integral.north-east", (rel: (x: .3, y: .4)), "atr-pp-3.north", stroke: cmyk_purple + .7pt)
  
              bezier-through("atr-pp-dx.south", (rel: (x: -.3, y: -.5)), "atr-pp-x2.south-east", stroke: cmyk_blue + .7pt)
              bezier-through("atr-pp-dx.south", (rel: (x: -.2, y: -.28)), "atr-pp-2x.south-east", stroke: cmyk_blue + .7pt)
              bezier-through("atr-pp-dx.south", (rel: (x: -.1, y: -.15)), "atr-pp-3.south-east", stroke: cmyk_blue + .7pt)
            },
          )
        $
      ]
    ]
  ]
)

// Agar lebih mudah menyelesaikan soal, perhatikan beberapa aturan dasar berikut.

// Aturan pangkat digunakan ketika fungsi
// yang akan diintegralkan memiliki bentuk pangkat.

// Untuk $n != -1$:

// #align(center)[
//   $ integral x^n dif x
//     = x^(n + 1) / (n + 1) + C $
// ]

// #v(10pt)

// Langkah mengerjakannya:

// + tambahkan $1$ pada pangkat;
// + bagi dengan pangkat yang baru;
// + tambahkan konstanta $C$.

// #contoh[
//   _Contoh 1_

//   Tentukan:

//   $ integral x^3 dif x $

//   _Penyelesaian:_

//   Pangkat $3$ ditambah $1$ menjadi $4$.

//   $ integral x^3 dif x
//   = x^4 / 4 + C $

//   _Jawaban:_

//   $ x^4 / 4 + C $
// ]

// #v(18pt)

// // Dari Ega: Aku saranin penulisan heading ini pake "=="
// // Contoh: "== Apa itu Integral"
// // Alasannya agar buku lebih terstuktur, dan juga gampang ditulis
// === Aturan Konstanta

// Jika $k$ merupakan konstanta, maka:

// #align(center)[
//   $ integral k dif x = k x + C $
// ]

// #contoh[
//   _Contoh 2_

//   Tentukan:

//   $ integral 7 dif x $

//   _Penyelesaian:_

//   $ integral 7 dif x = 7 x + C $

//   _Jawaban:_

//   $ 7 x + C $
// ]

// #v(18pt)

// // Dari Ega: Aku saranin penulisan heading ini pake "=="
// // Contoh: "== Apa itu Integral"
// // Alasannya agar buku lebih terstuktur, dan juga gampang ditulis
// === Aturan Kelipatan Konstanta

// Konstanta yang berada di depan fungsi
// dapat dikeluarkan dari integral.

// $ integral k f(x) dif x
// = k integral f(x) dif x $

// #contoh[
//   _Contoh 3_

//   Tentukan:

//   $ integral 5 x^2 dif x $

//   _Penyelesaian:_

//   $ integral 5 x^2 dif x
//   = 5 integral x^2 dif x $

//   $ = 5 (x^3 / 3) + C $

//   _Jawaban:_

//   $ 5 x^3 / 3 + C $
// ]

// #v(18pt)

// // Dari Ega: Aku saranin penulisan heading ini pake "=="
// // Contoh: "== Apa itu Integral"
// // Alasannya agar buku lebih terstuktur, dan juga gampang ditulis
// === Penjumlahan dan Pengurangan 

// Integral dari beberapa suku dapat dikerjakan
// dengan memisahkan setiap suku.

// $ integral (f(x) plus g(x)) dif x
// = integral f(x) dif x
// + integral g(x) dif x $

// $ integral (f(x) minus g(x)) dif x
// = integral f(x) dif x
// - integral g(x) dif x $

// #contoh[
//   _Contoh 4_

//   Tentukan:

//   $ integral (3 x^2 + 4 x - 5) dif x $

//   _Penyelesaian:_

//   Pisahkan setiap suku:

//   $ integral 3 x^2 dif x
//   + integral 4 x dif x
//   - integral 5 dif x $

//   Kemudian:

//   $ = x^3 + 2 x^2 - 5 x + C $

//   _Jawaban:_

//   $ x^3 + 2 x^2 - 5 x + C $
// ]

// Dari Ega: Aku saranin penulisan heading ini pake "=="
// Contoh: "== Apa itu Integral"
// Alasannya agar buku lebih terstuktur, dan juga gampang ditulis
== Integral Tentu

// === Makna Integral Tentu

=== Jumlah Riemann

Anda masih ingat kembali grafik batang buatan Bella? Setiap batang memiliki lebar $Delta t$ (lama interval) dan tinggi $v(t_i)$ (kecepatan pada interval ke-$i$). Jarak pada satu interval adalah $v(t_i) Delta t$, sehingga jarak total adalah jumlah dari seluruh batang.

#eq-numbered[
  $ s approx sum_(i=1)^n v(t_i) Delta t $
]

Bentuk penjumlahan ini disebut jumlah Riemann.@wp-reimann-sum Pada grafik pertama $Delta t = 10$ detik, pada grafik kedua $Delta t = 5$ detik. Semakin kecil $Delta t$ (semakin besar $n$), semakin baik perkiraannya.

Sampai di sini, kita masih menjumlahkan batang dengan memilih $n$ satu per satu. Dengan $n = 9$ ($Delta t = 10$ detik) kita memperoleh $235$ m, lalu dengan $n = 18$ ($Delta t = 5$ detik) kita memperoleh 237,5 m. Hasilnya berubah setiap kali $n$ diganti.

Padahal yang kita inginkan bukan perkiraan untuk satu $n$ tertentu, melainkan jarak sebenarnya, yaitu nilai yang didekati ketika $n$ makin besar. Mencoba $n = 100$, $n = 1000$, dan seterusnya tentu tidak akan pernah selesai.

Nah, di sinilah limit dari bab sebelumnya berperan! Limit tidak menghitung satu per satu, tetapi bertanya: _"ke mana hasil penjumlahan ini mendekat jika $n$ dibuat sebesar-besarnya?"_ Karena $Delta t = frac(b - a, n)$, membesarkan $n$ sama saja dengan mengecilkan $Delta t$. Hal ini dituliskan sebagai berikut.

#eq-numbered[
  $ s = lim_(n -> infinity) sum_(i=1)^n v(t_i) Delta t = integral_a^b v(t) dif t $
]

Bentuk di ruas kanan inilah *integral tentu*. Tanda $integral$ adalah huruf "S" yang memanjang, singkatan dari _"sum"_ (jumlah).

#side-by-side(
  [
    Integral tentu dituliskan dengan batas bawah $a$ dan batas atas $b$ yang menunjukkan interval tempat akumulasi dihitung.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $ integral_a^b f(x) dif x $
      ]
    ]
  ],
)

Berbeda dari integral tak tentu yang menghasilkan keluarga antiturunan, integral tentu memiliki batas bawah dan batas atas. Sama seperti Bella yang menetapkan pengamatannya dari detik ke-$0$ sampai detik ke-$90$, rentang yang dihitung sudah ditentukan. Karena itu, hasilnya *satu nilai tertentu*, misalnya jarak tempuh atau luas bertanda di bawah kurva.

#let bl-v(t) = 1 + 2.6 * calc.sin(calc.pi * t / 90)

#let bl-riemann(n) = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (4, 3), axis-style: "school-book",
    x-tick-step: 30, y-tick-step: 1,
    x-label: [$t "(s)"$], y-label: [$v "(m/s)"$],
    x-min: -5, x-max: 95, y-min: -0.5, y-max: 5,
    {
      let dx = 90 / n
      for i in range(n) {
        let x0 = i * dx
        let h = bl-v(x0)
        plot.add-fill-between(
          ((x0, h), (x0 + dx, h)),
          ((x0, 0), (x0 + dx, 0)),
          style: (
            fill: cmyk_blue.lighten(80%),
            stroke: if n <= 18 { cmyk_blue } else { none },
          ),
        )
      }
      plot.add(bl-v, domain: (0, 90), style: (stroke: cmyk_purple + 1.5pt))
    },
  )
})

#figure(
  caption: figure.caption(position: top)[Jumlah Riemann dengan $n = 9$, $18$, dan $45$ batang ($Delta t = 10$, $5$, dan $2$ detik)],
  gap: 2em,
  grid(columns: 3, gutter: 1.5em, bl-riemann(9), bl-riemann(18), bl-riemann(45)),
)


=== Teorema Dasar Kalkulus

Sama seperti posisi awal sepeda yang tidak memengaruhi jarak tempuh, konstanta $C$ saling menghilangkan pada $F(b) - F(a)$. Menjumlahkan batang tak hingga banyaknya tentu tidak praktis. Untungnya ada jalan pintas.

Misalkan $s(t)$ adalah fungsi posisi sepeda, sehingga turunannya $s'(t) = v(t)$. Artinya, $s(t)$ adalah antiturunan dari $v(t)$.

Jarak yang ditempuh sepeda dari $t = a$ sampai $t = b$ (dengan $a < b$, misalnya $a = 0$ dan $b = 90$) dapat dihitung dengan dua cara:

+ Dari kecepatan: menjumlahkan batang-batang kecil $v(t) dif t$, yaitu integral tentu $integral_a^b v(t) dif t$.
+ Dari posisi: posisi akhir dikurangi posisi awal, yaitu $s(b) - s(a)$.

Keduanya mengukur jarak yang sama, sehingga nilainya harus sama:

$ integral_a^b v(t) dif t = s(b) - s(a) $

Inilah inti *Teorema Dasar Kalkulus*,@wp-fundamental-theorem-calculus yang berlaku umum untuk fungsi apa pun.

#side-by-side(
  [
    Jika $F'(x) = f(x)$, maka integral tentu $f(x)$ pada $[a, b]$ sama dengan selisih antiturunan di batas atas dan batas bawah.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $ integral_a^b f(x) dif x = F(b) - F(a) $
      ]
    ]
  ],
)

Konstanta $C$ tidak diperlukan karena akan saling menghilangkan:
$(F(b) + C) - (F(a) + C) = F(b) - F(a)$.

=== Menghitung Integral Tentu

// Sebelumnya, kita telah mempelajari berbagai aturan untuk menentukan antiturunan suatu fungsi. Aturan tersebut ternyata dapat membantu kita menghitung integral tentu tanpa harus menjumlahkan setiap bagian kecil satu per satu. Hubungan ini dijelaskan melalui sebuah prinsip yang disebut Teorema Dasar Kalkulus.

// #side-by-side(
//   [
//     Jika $F(x)$ merupakan antiturunan dari $f(x)$, sehingga $F'(x)=f(x)$, maka integral tentu dari $f(x)$ pada interval $[a,b]$ dapat dihitung dengan mencari selisih nilai antiturunannya pada batas atas dan batas bawah.
//   ],
//   [
//     #align(horizon)[
//       #eq-numbered[
//         $ integral_a^b f(x) \d\x = F(b) - F(a) $
//       ]
//     ]
//   ],
// )

// Perhatikan bahwa kita tidak perlu menambahkan konstanta integrasi $C$ ketika menghitung integral tentu. Hal ini karena konstanta yang sama akan saling menghilangkan ketika nilai antiturunan pada kedua batas dikurangkan.

#contoh[
  Tentukan nilai dari integral tentu berikut.
  #eq-numbered[
    $ integral_0^2 (2x+1) dif x $
  ] 
]

#penyelesaian[
  Pertama, tentukan antiturunan dari $2x+1$ menggunakan aturan integral yang telah dipelajari.
  
  $ F(x) = x^2+x $
  
  Selanjutnya, hitung nilai antiturunan pada batas atas, yaitu $x=2$, kemudian kurangi dengan nilainya pada batas bawah, yaitu $x=0$.
  
  $ 
    integral_0^2 (2x+1) dif x &= F(2)-F(0) \
    & = (2^2+2)-(0^2+0) \
    & = 6-0 \
    & = 6 
  $
]


Dengan demikian, nilai integral tentu tersebut adalah $6$.

Dari contoh ini, kita dapat melihat bahwa integral tentu dihitung dengan mengevaluasi antiturunan pada kedua batas interval, kemudian menghitung selisihnya. Selanjutnya, kita akan mempelajari sifat-sifat integral tentu yang dapat membantu menyederhanakan perhitungan.

=== Sifat-Sifat Integral Tentu

Integral tentu memiliki beberapa sifat yang dapat membantu kita menyederhanakan perhitungan. Dengan memahami sifat-sifat berikut, kita tidak perlu selalu menghitung integral dari awal.

#side-by-side(
  [
    *1. Batas integrasi sama*

    Jika batas bawah dan batas atas bernilai sama, tidak ada interval yang dihitung sehingga nilai integralnya adalah nol.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $ integral_a^a f(x) dif x = 0 $
      ]
    ]
  ],
)

#side-by-side(
  [
    *2. Pertukaran batas integrasi*

    Jika posisi batas bawah dan batas atas ditukar, nilai integral berubah tanda. Artinya, integral dengan arah batas yang berlawanan menghasilkan nilai yang berlawanan pula.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $ integral_a^b f(x) dif x = - integral_b^a f(x) dif x $
      ]
    ]
  ],
)

#side-by-side(
  [
    *3. Penjumlahan dan pengurangan*

    Integral dari penjumlahan atau pengurangan dua fungsi dapat dihitung dengan mengintegralkan setiap fungsi secara terpisah. Cara ini sama dengan @int-penj-peng (Penjumlahan & Pengurangan) Tanda penjumlahan atau pengurangan tetap dipertahankan.
  ],
  [
    #eq-numbered[
      $ 
        integral_a^b (f(x) + g(x)) dif x \ 
         = integral_a^b f(x) dif x + integral_a^b g(x) dif x \ 
    
         integral_a^b (f(x) - g(x)) dif x \
         = integral_a^b f(x) dif x - integral_a^b g(x) dif x \  
      $
    ]
  ],
)

#side-by-side(
  [
    *4. Pemisahan interval*

    Jika suatu interval dibagi menjadi dua bagian, integral pada seluruh interval sama dengan jumlah integral pada masing-masing bagian. Sifat ini dapat digunakan untuk menghitung akumulasi secara bertahap.
  ],
  [
    #align(horizon)[
      #eq-numbered[
        $ 
          integral_a^b f(x) dif x \
           = integral_a^c f(x) dif x + integral_c^b f(x) dif x 
        $
      ]
    ]
  ],
)

== Luas Daerah

Kita telah mempelajari bahwa integral tentu dapat digunakan untuk menghitung akumulasi suatu besaran pada interval tertentu. Namun, integral tentu juga memiliki hubungan erat dengan luas daerah pada grafik fungsi. Untuk memahaminya, mari kita mulai dari bentuk yang sederhana.

#let rm-f(x) = calc.cos(x)
#let (rm-a, rm-d) = (0, 2 * calc.pi - 0)
#let (rm-b, rm-c) = (calc.pi / 2, 3 * calc.pi / 2)

#let riemann(n) = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (4, 3.5), axis-style: "school-book",
    x-tick-step: none, y-tick-step: none,
    x-min: -1, x-max: 7, y-min: -1.2, y-max: 1.2,
    {
      plot.add(rm-f, domain: (-1, 7), style: (stroke: cmyk_purple + 1.5pt))
      let dx = (rm-d - rm-a) / n
      for i in range(n) {
        let x0 = rm-a + i * dx
        plot.add-fill-between(
          ((x0, rm-f(x0)), (x0 + dx, rm-f(x0))),
          ((x0, 0), (x0 + dx, 0)),
          style: (fill: cmyk_blue.lighten(80%), stroke: cmyk_blue),
        )
      }
    },
  )
})

#let kurva-bertanda = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border + .8pt))
  plot.plot(
    size: (5, 4), axis-style: "school-book",
    x-tick-step: none, y-tick-step: none,
    x-min: -1, x-max: 7, y-min: -1.2, y-max: 1.2,
    {
      let fill-area(dom, col) = plot.add-fill-between(
        rm-f, x => 0, domain: dom,
        style: (fill: col.lighten(80%), stroke: none),
      )
      fill-area((rm-a, rm-b), cmyk_blue)
      fill-area((rm-b, rm-c), cmyk_vermil)
      fill-area((rm-c, rm-d), cmyk_blue)

      plot.add(rm-f, domain: (-1, 7), style: (stroke: cmyk_purple + 1.5pt))

      plot.annotate({
        content((0.8, 0.3), $A_1$)
        content((calc.pi, -0.4), $A_2$)
        content((5.7, 0.3), $A_3$)
        line((0, -1.20), (rm-d, -1.20))
        for (x, l) in ((rm-a, $a$), (rm-b, $b$), (rm-c, $c$), (rm-d, $d$)) {
          line((x, -1.12), (x, -1.28))
          content((x, -1.45), l)
        }
      })
    },
  )
})



=== Hubungan Integral Tentu dengan Luas

#let lh-segitiga = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (6, 6), axis-style: "school-book",
    x-tick-step: none, y-tick-step: none,
    x-ticks: ((1, [$1$]), (2, [$2$]), (3, [$3$]), (4, [$4$])),
    y-ticks: ((1, [$1$]), (2, [$2$]), (3, [$3$]), (4, [$4$])),
    x-min: -1, x-max: 4, y-min: -1, y-max: 4,
    {
      plot.add-fill-between(
        x => x, x => 0, domain: (0, 4),
        style: (fill: cmyk_purple.lighten(80%), stroke: none),
      )
      plot.add(x => x, domain: (0, 4), style: (stroke: cmyk_purple + 1.5pt))
    },
  )
})

#side-by-side(
  [
    #figure(
      caption: [Grafik fungsi $f(x)=x$ dengan interval $0 <= x <= 4$],
      [
        #lh-segitiga
      ]
    )
  ],
  [
    Perhatikan grafik fungsi $f(x)=x$ disamping, pada interval $0 <= x <= 4$. Daerah yang dibatasi kurva, sumbu-$x$, dan kedua batas interval membentuk sebuah segitiga. Karena kita sudah mengenal rumus luas segitiga, luasnya dapat dihitung dengan cara biasa.
    
    Alas segitiga memiliki panjang $4$ satuan dan tingginya juga $4$ satuan.
    $
      L &= frac(1, 2) times a times t \
      &= frac(1, 2) times 4 times 4 \
      &= 8
    $
  ],
)

Sekarang hitung luas yang sama dengan integral tentu. Daerahnya dimulai dari $x = 0$ dan berakhir di $x = 4$, sehingga batas bawahnya $a = 0$ dan batas atasnya $b = 4$. Karena $f(x) = x$ tidak negatif pada interval tersebut, nilai integralnya sama dengan luas daerah di bawah kurva.

Pertama, cari antiturunan $f(x) = x$ dengan aturan pangkat:

$ F(x) = frac(x^2, 2) $

Kita dapat memeriksanya: turunan $frac(x^2, 2)$ adalah $x$. Selanjutnya, hitung $F(b) - F(a)$ dengan $b = 4$ dan $a = 0$:

$
  integral_0^4 x dif x &= pmark([frac(x^2, 2)]_0^4, #<notasi-evaluasi>) \
  &= frac(4^2, 2) - frac(0^2, 2) \
  &= 8 - 0 = 8

  #annot(<notasi-evaluasi>, pos: top + right, dy: -1em, dx: -5em)[Notasi Evaluasi]
$

Kedua cara menghasilkan nilai yang sama, yaitu $8$ satuan luas. Ini bukan kebetulan. Perhatikan bahwa $F(x) = frac(x^2, 2)$ adalah luas segitiga dengan alas $x$ dan tinggi $x$:

$ frac(1, 2) dot x dot x = frac(x^2, 2) $

Artinya, $F(x)$ adalah luas daerah dari $0$ sampai $x$. Jika $x$ digeser sedikit sebesar $dif x$, luas bertambah satu pita tipis setinggi kurva, yaitu $x$. Jadi laju pertambahan luas sama dengan tinggi kurva, dan itulah arti $F'(x) = f(x)$: *antiturunan dari tinggi kurva adalah luas di bawahnya*.

=== Luas di Bawah Kurva

Untuk bentuk yang lebih rumit, kita kembali ke gagasan Bella. Sebelumnya ia memperkirakan jarak dengan menjumlahkan batang kecil, sekarang kita memperkirakan luas dengan cara yang sama.

#figure(
  table(
    columns: (1fr, 1fr),
    inset: 10pt,
    fill: (col, row) => if row == 0 { cmyk_purple.lighten(88%) } else { none },
    align: center,
    table.header(
      [*Cerita sepeda*], [*Luas di bawah kurva*],
    ),
    [Kecepatan $v(t)$], [Tinggi kurva $f(x)$],
    [Waktu $t$], [Posisi $x$],
    [Lebar batang $Delta t$], [Lebar batang $Delta x$],
    [Jarak = $v_i Delta t$ dijumlahkan], [Luas = $f(x_i) Delta x$ dijumlahkan],
  ),
  caption: figure.caption(position: top)[Padanan antara cerita sepeda dan luas di bawah kurva]
)

Sebagai contoh, perhatikan $f(x) = x^2$ pada interval $[0, 3]$. Notasi $[a, b]$ disebut interval tertutup, yaitu semua nilai $x$ dari $a$ sampai $b$, termasuk kedua ujungnya. Pada @x2-03-reimann, $a = 0$ adalah tepi kiri daerah dan $b = 3$ adalah tepi kanannya. Daerah yang kita cari luasnya berada di antara kurva dan sumbu-$x$ pada interval tersebut.

// --- definisi grafik (taruh bersama #let grafik lain di awal seksi Luas Daerah) ---
#let lk-f(x) = calc.pow(x, 2)

#let lk-riemann(n) = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (4.5, 3.5), axis-style: "school-book",
    x-tick-step: none, y-tick-step: none,
    x-min: -0.5, x-max: 3, y-min: 0, y-max: 10,
    {
      let dx = 3 / n
      for i in range(n) {
        let x0 = i * dx
        plot.add-fill-between(
          ((x0, lk-f(x0)), (x0 + dx, lk-f(x0))),   // tinggi di tepi kiri
          ((x0, 0), (x0 + dx, 0)),
          style: (
            fill: cmyk_blue.lighten(80%),
            stroke: cmyk_blue,
          ),
        )
      }
      plot.add(lk-f, domain: (0, 3.4), style: (stroke: cmyk_purple + 1.5pt))
      plot.annotate({
        line((0, -1.5), (3, -1.5))
        for (x, l) in ((0, $a$), (3, $b$)) {
          line((x, -1), (x, -2))
          content((x, -2.8), l)
        }
      })
    },
  )
})

#figure(
  caption: figure.caption(position: top)[Pendekatan luas di bawah $y = x^2$ pada $[0, 3]$ dengan $n = 3$, $6$, dan $12$ persegi panjang],
  gap: 2em,
  grid(columns: 3, gutter: 1.5em, lk-riemann(3), lk-riemann(6), lk-riemann(12)),
)<x2-03-reimann>

Lebar setiap persegi panjang adalah $Delta x = frac(b - a, n)$ dan tingginya adalah nilai kurva di tepi kiri persegi panjang, yaitu $f(x_i)$. Karena kurva ini selalu naik, semua persegi panjang harus selalu berada di bawah kurva, sehingga jumlah luasnya selalu kurang dari luas sebenarnya.

#eq-numbered[
  $ L approx sum_(i=1)^n f(x_i) Delta x $
]

Semakin banyak persegi panjang, perkiraannya semakin baik:

#figure(
  table(
    columns: 3,
    inset: 10pt,
    fill: (col, row) => if row == 0 { cmyk_purple.lighten(88%) } else { none },
    align: center,
    table.header(
      [*Banyak batang* $n$], [*Lebar* $Delta x$], [*Jumlah luas*],
    ),
    [$3$], [$1$], [$5$],
    [$6$], [$"0,5"$], [$"6,875"$],
    [$12$], [$"0,25"$], [$"7,90625"$],
    [$n -> infinity$], [$Delta x -> 0$], [luas sebenarnya!],
  ),
  caption: figure.caption(position: top)[Jumlah luas persegi panjang untuk $y = x^2$ pada $[0, 3]$]
)

Sama seperti cerita sepeda, kita menggunakan limit untuk $n$ yang membesar tanpa batas. Nilai yang didekati inilah luas sebenarnya, dan bentuknya adalah integral tentu. Untuk fungsi yang $f(x) >= 0$ pada $[a, b]$ (kurvanya tidak turun ke bawah sumbu-$x$), luas daerah di bawah kurva adalah:

#eq-numbered[
  $ L = lim_(n -> infinity) sum_(i=1)^n f(x_i) Delta x = integral_a^b f(x) dif x quad (f(x) >= 0) $
]

Perhatikan dua syarat pada rumus tersebut:

+ Batas $a$ dan $b$. Tanpa batas kiri dan kanan, daerahnya bisa memanjang terus-menerus sehingga luasnya dapat menjadi tak terhingga. Dengan interval $[a, b]$, daerahnya terbatas dan luasnya dapat dihitung.
+ Syarat $f(x) >= 0$. Jika kurva turun di bawah sumbu-$x$, bagian itu memberi kontribusi negatif pada integral, sehingga hasilnya tidak lagi sama dengan luas daerah. Kasus ini kita bahas pada subbab berikutnya.

#contoh[
  Tentukan luas daerah di bawah kurva $y = x^2$ dari $x = 0$ sampai $x = 3$.
  
  $
    L &= integral_0^3 x^2 dif x \
    &= [frac(x^3, 3)]_0^3 \
    &= frac(27, 3) - 0 = 9
  $
]

Jadi, luas daerahnya adalah $9$ satuan luas. Angka inilah yang didekati oleh tabel di atas: $5$, lalu $"6,875"$, lalu $"7,90625"$, dan seterusnya semakin mendekati $9$.

#mengapa(judul: [Bagaimana dengan tepi lain?], [
  Pada bab ini tinggi batang diambil di tepi kiri, tetapi tepi tengah atau kanan juga boleh. Untuk $y = x^2$ pada $[0, 3]$ dengan $n = 3$:

  - kiri: $5$ (kurang dari $9$)
  - tengah: $"8,75"$
  - kanan: $14$ (lebih dari $9$)

  Hasilnya berbeda untuk $n$ kecil, tetapi semuanya menuju $9$ saat $n$ membesar terus-menerus.
])

=== Luas Bertanda

Bagaimana jika kurva berada di bawah sumbu-$x$? Pada daerah tersebut $f(x_i) < 0$, sehingga tinggi persegi panjang bernilai negatif dan luasnya $f(x_i) Delta x$ juga negatif. Persegi panjangnya terlihat "menggantung" ke bawah dari sumbu-$x$. Rumus $sum f(x_i) Delta x$ tidak perlu diubah, tanda negatif-nya muncul dengan sendirinya.

// --- definisi grafik (taruh bersama #let grafik lain) ---
#let bs-riemann = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (5, 4), axis-style: "school-book",
    x-tick-step: none, y-tick-step: none,
    x-min: -1, x-max: 7, y-min: -1.2, y-max: 1.2,
    {
      let n = 12
      let dx = (rm-d - rm-a) / n
      for i in range(n) {
        let x0 = rm-a + i * dx
        let h = rm-f(x0)  // tinggi di tepi kiri
        let col = if h >= 0 { cmyk_blue } else { cmyk_vermil }
        plot.add-fill-between(
          ((x0, h), (x0 + dx, h)),
          ((x0, 0), (x0 + dx, 0)),
          style: (fill: col.lighten(80%), stroke: col),
        )
      }
      plot.add(rm-f, domain: (-1, 7), style: (stroke: cmyk_purple + 1.5pt))
    },
  )
})

#side-by-side(
  [
    #figure(
      caption: figure.caption(position: top)[Persegi panjang di atas sumbu-$x$ (biru) bernilai positif, di bawah sumbu-$x$ (merah) bernilai negatif],
      bs-riemann,
    )
  ],
  [
    Karena tinggi setiap persegi panjang dikunci di sisi kirinya, persegi panjang tidak pernah pas dengan kurva. Persegi panjang sedikit menonjol keluar ketika kurva bergerak mendekati sumbu-$x$ (kurva di atas sumbu yang turun, atau kurva di bawah sumbu yang naik), dan kurang dari kurva ketika kurva bergerak menjauhi sumbu-$x$. Persegi panjang yang melewati titik potong sumbu-$x$ bahkan bisa berbeda tanda dengan sebagian kurvanya. Semua ini hanya kesalahan perkiraan (_error_) yang mengecil ketika $n$ membesar.
  ]
)

// --- definisi grafik ---
#let bs-xy = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (5, 5), axis-style: "school-book",
    x-tick-step: 1, y-tick-step: 1,
    x-min: -1.5, x-max: 1.5, y-min: -1.5, y-max: 1.5,
    {
      let n = 4
      let dx = 2 / n
      for i in range(n) {
        let x0 = -1 + i * dx
        let h = x0  // f(x) = x, tinggi di sisi kiri
        let col = if h >= 0 { cmyk_blue } else { cmyk_vermil }
        plot.add-fill-between(
          ((x0, h), (x0 + dx, h)),
          ((x0, 0), (x0 + dx, 0)),
          style: (fill: col.lighten(80%), stroke: col),
        )
      }
      plot.add(x => x, domain: (-1.5, 1.5), style: (stroke: cmyk_purple + 1.5pt))
    },
  )
})

// --- teks ---

#side-by-side(
  [
    #figure(
      caption: figure.caption(position: top)[Jumlah Riemann $y = x$ pada $[-1, 1]$ dengan $n = 4$],
      bs-xy,
    )
  ],
  [
    Sekarang perhatikan contoh yang lebih sederhana, yaitu kurva baru $y = x$ pada $[-1, 1]$. Tinggi setiap persegi panjang diambil di sisi kirinya.
    
    Pada gambar ini $Delta x = 0,5$ dan tinggi batangnya $-1$, $-0,5$, $0$, dan $0,5$. Jumlahnya:
    
    $ (-1 - 0,5 + 0 + 0,5) times 0,5 = -0,5 $
    
    Sesuai baris $n = 4$ pada @jumlah-persegi-yx berikut.
  ]
)

#figure(
  table(
    columns: 3,
    inset: 10pt,
    fill: (col, row) => if row == 0 { cmyk_purple.lighten(88%) } else { none },
    align: center,

    [*Banyak batang* $n$], [*Lebar* $Delta x$], [*Jumlah*],

    [$2$], [$1$], [$-1$],
    [$4$], [$"0,5"$], [$-"0,5"$],
    [$8$], [$"0,25"$], [$-"0,25"$],
    [$n -> infinity$], [$Delta x -> 0$], [$0$],
  ),
  caption: figure.caption(position: top)[Jumlah persegi panjang untuk $y = x$ pada $[-1, 1]$]
)<jumlah-persegi-yx>

Jumlahnya negatif di awal, lalu mendekati $0$ karena bagian negatif dan bagian positif saling meniadakan. Nilai yang didekati inilah integral tentu, yang disebut *luas bertanda*.

Sekarang kembali ke kurva sebelumnya. Dengan batang yang makin banyak, persegi panjang tadi menjadi daerah penuh seperti @luas-kurva-bertanda berikut:

#figure(
  caption: figure.caption(position: top)[Daerah di atas (positif) dan di bawah (negatif) sumbu-$x$],
  kurva-bertanda,
)<luas-kurva-bertanda>

Daerah $A_1$ dan $A_3$ berada di atas sumbu-$x$, sedangkan $A_2$ berada di bawahnya. Kita definisikan $A_1$, $A_2$, dan $A_3$ sebagai *luas geometris* masing-masing daerah, sehingga ketiganya bernilai positif. Karena daerah di bawah sumbu-$x$ memberi kontribusi negatif:

$ integral_b^c f(x) dif x = -A_2 $

Dengan sifat pemisahan interval, nilai integral tentu seluruh interval menjadi luas bertanda:

#eq-numbered[
  $ integral_a^d f(x) dif x = A_1 - A_2 + A_3 $
]

Sementara itu, luas geometris total tidak memperhatikan tanda:

#eq-numbered[
  $ L = A_1 + A_2 + A_3 $
]

Untuk menghitung $L$, pisahkan interval di titik potong kurva dengan sumbu-$x$ (di sini $b$ dan $c$), lalu beri tanda negatif pada bagian di bawah sumbu-$x$ agar hasilnya positif:

$ L = integral_a^b f(x) dif x - integral_b^c f(x) dif x + integral_c^d f(x) dif x $

#info[
  Catatan penting: nilai integral tentu dan luas geometris total hanya sama jika $f(x) >= 0$ pada seluruh interval.
]

=== Luas di Antara Dua Kurva

Sejauh ini batas bawah daerahnya selalu sumbu-$x$. Bagaimana jika batas bawahnya juga sebuah kurva? Perhatikan daerah di antara kurva $y = f(x)$ di atas dan $y = g(x)$ di bawah pada interval $[a, b]$, dengan $f(x) >= g(x)$.

// --- definisi grafik ---
#let lu-f(x) = 2.5 + calc.sin(x)
#let lu-g(x) = 0.5 + 0.1 * x
#let (lu-a, lu-b) = (0.5, 5)

#let lu-pita = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (6, 4), axis-style: "school-book",
    x-tick-step: none, y-tick-step: none,
    x-min: -0.3, x-max: 5.6, y-min: -1, y-max: 4,
    {
      plot.add-fill-between(
        lu-f, lu-g, domain: (lu-a, lu-b),
        style: (fill: cmyk_purple.lighten(80%), stroke: none),
      )
      // satu pita tipis
      let (x0, dx) = (2.5, 0.5)
      plot.add-fill-between(
        ((x0, lu-f(x0)), (x0 + dx, lu-f(x0))),
        ((x0, lu-g(x0)), (x0 + dx, lu-g(x0))),
        style: (fill: cmyk_purple.lighten(60%), stroke: cmyk_purple),
      )
      plot.add(lu-f, domain: (0, 5.5), style: (stroke: cmyk_purple + 1.5pt))
      plot.add(lu-g, domain: (0, 5.5), style: (stroke: cmyk_blue + 1.5pt))
      plot.annotate({
        content((5.6, lu-f(5.5)), $f$, anchor: "west")
        content((5.6, lu-g(5.5)), $g$, anchor: "west")
        content((x0 + dx / 2, 3.6), $Delta x$)
        content((3.4, 2.8), $f(x_i) - g(x_i)$, anchor: "west")
        for (x, l) in ((lu-a, $a$), (lu-b, $b$)) {
          line((x, 0), (x, lu-f(x)), stroke: (dash: "dashed", paint: cmyk_border))
          line((x, -0.55), (4, -0.55))
          line((x, -0.4), (x, -0.7))
          content((x, -1), l)
        }
      })
    },
  )
})

#let lu-banyak-pita(n) = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (6, 4), axis-style: "school-book",
    x-tick-step: none, y-tick-step: none,
    x-min: -0.3, x-max: 5.6, y-min: -1, y-max: 4,
    {
      let dx = (lu-b - lu-a) / n
      for i in range(n) {
        let x0 = lu-a + i * dx
        plot.add-fill-between(
          ((x0, lu-f(x0)), (x0 + dx, lu-f(x0))),
          ((x0, lu-g(x0)), (x0 + dx, lu-g(x0))),
          style: (fill: cmyk_purple.lighten(80%), stroke: cmyk_purple),
        )
      }
      plot.add(lu-f, domain: (0, 5.5), style: (stroke: cmyk_purple + 1.5pt))
      plot.add(lu-g, domain: (0, 5.5), style: (stroke: cmyk_blue + 1.5pt))
      plot.annotate({
        content((5.6, lu-f(5.5)), $f$, anchor: "west")
        content((5.6, lu-g(5.5)), $g$, anchor: "west")
        for (x, l) in ((lu-a, $a$), (lu-b, $b$)) {
          line((x, -0.55), (4, -0.55))
          line((x, -0.4), (x, -0.7))
          content((x, -1), l)
        }
      })
    },
  )
})

#figure(
  caption: figure.caption(position: top)[Daerah di antara $f$ dan $g$ pada $[a, b]$. Kiri: satu pita tipis berlebar $Delta x$. Kanan: pita-pita diperbanyak ($n = 8$) lalu dijumlahkan.],
  gap: 2em,
  grid(columns: 2, gutter: 1.5em, lu-pita, lu-banyak-pita(8)),
)

Kita memakai gagasan yang sama seperti pada subbab sebelumnya: bagi daerah menjadi pita-pita tipis, lalu jumlahkan. Lebar setiap pita adalah $Delta x$. Bedanya, tinggi pita bukan lagi $f(x_i)$ (yang diukur dari sumbu-$x$), melainkan jarak dari kurva bawah ke kurva atas, yaitu $f(x_i) - g(x_i)$. Jadi luas satu pita adalah $(f(x_i) - g(x_i)) Delta x$.

Jika pita diperbanyak tanpa batas, jumlahnya menjadi integral tentu:

#eq-numbered[
  $ L = lim_(n -> infinity) sum_(i=1)^n (f(x_i) - g(x_i)) Delta x = integral_a^b (f(x) - g(x)) dif x $
]

// *Alasan lain: pengurangan luas*

Rumus tersebut juga masuk akal dari sisi lain. Daerah di antara kedua kurva adalah luas di bawah $f$ dikurangi luas di bawah $g$.

// --- tiga panel ---
#let lu-panel(mode) = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (3.8, 3), axis-style: "school-book",
    x-tick-step: none, y-tick-step: none,
    x-min: -0.3, x-max: 5.4, y-min: -0.5, y-max: 4,
    {
      if mode == "f" {
        plot.add-fill-between(
          lu-f, x => 0, domain: (lu-a, lu-b),
          style: (fill: cmyk_blue.lighten(80%), stroke: none),
        )
      } else if mode == "g" {
        plot.add-fill-between(
          lu-g, x => 0, domain: (lu-a, lu-b),
          style: (fill: cmyk_blue.lighten(80%), stroke: none),
        )
      } else {
        plot.add-fill-between(
          lu-f, lu-g, domain: (lu-a, lu-b),
          style: (fill: cmyk_purple.lighten(80%), stroke: none),
        )
      }
      plot.add(lu-f, domain: (0, 5.5), style: (stroke: cmyk_purple + 1pt))
      plot.add(lu-g, domain: (0, 5.5), style: (stroke: cmyk_blue + 1pt))
    },
  )
})

#figure(
  caption: figure.caption(position: top)[Luas di bawah $f$ dikurangi luas di bawah $g$ menghasilkan luas di antara kurva],
  gap: 2em,
  grid(
    columns: (3.6cm, 2cm, 3.6cm, 2cm, 3.6cm),
    align: center + horizon,
    row-gutter: 1em,
    lu-panel("f"), $-$, lu-panel("g"), $=$, lu-panel("selisih"),
    text(size: 0.85em)[Luas di bawah $f$], [], text(size: 0.85em)[Luas di bawah $g$], [], text(size: 0.85em)[Luas di antara kurva],
  ),
)

Hal ini sejalan dengan sifat pengurangan integral tentu:

$ integral_a^b (f(x) - g(x)) dif x = integral_a^b f(x) dif x - integral_a^b g(x) dif x $

Karena yang diukur adalah jarak antara dua kurva, rumus ini tetap berlaku walaupun kurvanya berada di bawah sumbu-$x$, selama $f(x) >= g(x)$.

// *Contoh pemanasan*

#contoh[
  Tentukan luas daerah yang dibatasi $y = 2$ dan $y = x$ pada $[0, 2]$. Daerahnya berbentuk segitiga siku-siku, sehingga kita dapat memeriksa hasilnya dengan rumus geometri.

  #let lu-pemanasan = cetz.canvas({
    import cetz.draw: *
    set-style(axes: (stroke: cmyk_border))
    plot.plot(
      size: (4, 4), axis-style: "school-book",
      x-tick-step: 1, y-tick-step: 1,
      x-min: -0.5, x-max: 3, y-min: -0.5, y-max: 3,
      {
        plot.add-fill-between(
          x => 2, x => x, domain: (0, 2),
          style: (fill: cmyk_purple.lighten(80%), stroke: none),
        )
        plot.add(x => 2, domain: (0, 3), style: (stroke: cmyk_purple + 1.5pt))
        plot.add(x => x, domain: (0, 3), style: (stroke: cmyk_blue + 1.5pt))
        plot.annotate({
          content((2.7, 1.7), $y = 2$)
          content((2.2, 2.9), $y = x$)
        })
      },
    )
  })

  #figure(
    caption: figure.caption(position: top)[Daerah di antara $y = 2$ dan $y = x$ pada $[0, 2]$],
    lu-pemanasan,
  )

  #side-by-side(
    [
      *Dengan geometri:*
  
      // Alas dan tinggi segitiga masing-masing $2$ satuan.
  
      $ L = frac(1, 2) times 2 times 2 = 2 $
    ],
    [
      *Dengan integral:*
  
      // Kurva atas $f(x) = 2$, kurva bawah $g(x) = x$.
  
      $
        L &= integral_0^2 (2 - x) dif x \
        &= [2x - frac(x^2, 2)]_0^2 \
        &= (4 - 2) - 0 = 2
      $
    ],
  )
]

Kedua cara menghasilkan nilai yang sama, jadi rumusnya dapat dipercaya untuk kurva yang melengkung.

#contoh[
  Tentukan luas daerah yang dibatasi oleh $y = x$ dan $y = x^2$.
  
  #let lu-contoh = cetz.canvas({
    import cetz.draw: *
    set-style(axes: (stroke: cmyk_border))
    plot.plot(
      size: (5, 4), axis-style: "school-book",
      x-tick-step: 1, y-tick-step: 1,
      x-min: -0.5, x-max: 1.5, y-min: -0.5, y-max: 1.5,
      {
        plot.add-fill-between(
          x => x, x => calc.pow(x, 2), domain: (0, 1),
          style: (fill: cmyk_purple.lighten(80%), stroke: none),
        )
        plot.add(x => x, domain: (-0.5, 1.5), style: (stroke: cmyk_purple + 1.5pt))
        plot.add(x => calc.pow(x, 2), domain: (-0.5, 1.2), style: (stroke: cmyk_blue + 1.5pt))
        plot.annotate({
          content((0.3, 0.75), $y = x$)
          content((1.3, 0.9), $y = x^2$)
        })
      },
    )
  })
  
  #figure(
    caption: figure.caption(position: top)[Daerah di antara $y = x$ dan $y = x^2$],
    lu-contoh,
  )
  
  *Langkah 1: cari batas integrasi.* Daerah ini dimulai dan berakhir di titik kedua kurva berpotongan, yaitu saat nilai $y$ keduanya sama:
  
  $ x = x^2 arrow.double x(x - 1) = 0 arrow.double x = 0 "atau" x = 1 $
  
  Jadi $a = 0$ dan $b = 1$.
  
  *Langkah 2: tentukan kurva atas.* Ambil satu titik uji di dalam interval, misalnya $x = "0,5"$. Nilai $y = x$ adalah $"0,5"$, sedangkan $y = x^2$ adalah $"0,25"$. Karena $"0,5" > "0,25"$, kurva atasnya adalah $f(x) = x$ dan kurva bawahnya $g(x) = x^2$.
  
  *Langkah 3: integralkan selisihnya.*
  
  $
    L &= integral_0^1 (x - x^2) dif x \
    &= [frac(x^2, 2) - frac(x^3, 3)]_0^1 \
    &= (frac(1, 2) - frac(1, 3)) - 0 = frac(1, 6)
  $
]

Jadi, luas daerahnya adalah $frac(1, 6)$ satuan luas.

#info[
  Urutan sangatlah penting! Selalu kurangkan kurva bawah dari kurva atas, yaitu $f - g$. Jika terbalik, hasilnya negatif (pada contoh ini $-frac(1, 6)$), padahal luas daerah tidak pernah negatif.
]

Jika kurva atas dan bawah bertukar tempat di tengah interval, pisahkan integralnya di titik potong tersebut, lalu pada tiap bagian kurangkan kurva bawah dari kurva atas.

== Penerapan Integral

Integral digunakan untuk menyelesaikan berbagai permasalahan, misalnya di bidang berikut.

#let pn-vt = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (6, 4), axis-style: "school-book",
    x-tick-step: 1, y-tick-step: 3,
    x-label: [$t$ (s)], y-label: [$v$ (m/s)],
    x-min: -0.5, x-max: 6.5, y-min: -1, y-max: 10,
    {
      plot.add-fill-between(
        t => 6 * t - t * t, t => 0, domain: (0, 6),
        style: (fill: cmyk_blue.lighten(80%), stroke: none),
      )
      plot.add(t => 6 * t - t * t, domain: (0, 6), style: (stroke: cmyk_purple + 1.5pt))
    },
  )
})

#let pn-mc = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (6, 4), axis-style: "school-book",
    x-tick-step: 5, y-tick-step: 10,
    x-label: [$x$ (unit)], y-label: [$C'(x)$],
    x-min: -2, x-max: 29, y-min: -5, y-max: 63,
    {
      plot.add-fill-between(
        x => 2 * x + 4, x => 0, domain: (10, 20),
        style: (fill: cmyk_blue.lighten(80%), stroke: none),
      )
      plot.add(x => 2 * x + 4, domain: (0, 25), style: (stroke: cmyk_purple + 1.5pt))
    },
  )
})

#let pn-arch = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (6, 5), axis-style: "school-book",
    x-tick-step: 1, y-tick-step: 2,
    x-label: [$x$ (m)], y-label: [$y$ (m)],
    x-min: -3.6, x-max: 3.6, y-min: -2, y-max: 5,
    {
      plot.add-fill-between(
        x => 4 - x * x, x => 0, domain: (-2, 2),
        style: (fill: cmyk_blue.lighten(80%), stroke: none),
      )
      plot.add(x => 4 - x * x, domain: (-2, 2), style: (stroke: cmyk_purple + 1.5pt))
    },
  )
})

=== Transportasi

#side-by-side(
  [
    Jarak tempuh dihitung dari fungsi kecepatan terhadap waktu. Penerapannya mencakup analisis pergerakan kendaraan, navigasi berbasis GPS, dan simulasi lalu lintas. @ATIKURRAHMAN_2025

    Fungsi $v(t)$ adalah kecepatan kendaraan pada waktu $t$, dan $[t_1, t_2]$ adalah durasi perjalanan.

    $ s = integral_(t_1)^(t_2) v(t) dif t $

    Contoh: untuk $v(t) = 6t - t^2$ m/s, jarak tempuh 6 detik pertama adalah $integral_0^6 (6t - t^2) dif t = 36$ m, yaitu luas daerah di bawah grafik.
  ],
  [
    #align(horizon)[
      #figure(pn-vt, gap: 1em, caption: [Jarak = luas di bawah grafik $v$-$t$])
    ]
  ],
)

=== Ekonomi

#side-by-side(
  [
    Biaya total diperoleh dari biaya marjinal, dan pendapatan total dari pendapatan marjinal. Penerapannya mencakup perencanaan produksi, penganggaran, dan ekonomi digital. @ATIKURRAHMAN_2025

    $ integral R'(x) dif x quad "dan" quad integral C'(x) dif x $

    Contoh: jika biaya marjinal $C'(x) = 2x + 4$ (ribu rupiah per unit), tambahan biaya untuk menaikkan produksi dari 10 ke 20 unit adalah $integral_10^20 (2x + 4) dif x = 340$ ribu rupiah.
  ],
  [
    #align(horizon)[
      #figure(pn-mc, gap: 1em, caption: [Tambahan biaya = luas di bawah kurva biaya marjinal])
    ]
  ],
)

=== Arsitektur Bangunan

#side-by-side(
  [
    Estimasi material pada struktur seperti jembatan, atap, atau terowongan membutuhkan luas dan volume yang presisi. Bentuk lengkung sering dimodelkan dengan parabola.

    Misalkan penampang lengkung berbentuk $y = 4 - x^2$ dengan $-2 <= x <= 2$ (meter). Luas penampangnya:

    $ L = integral_(-2)^2 (4 - x^2) dif x = frac(32, 3) "m"^2 $

    Jika panjang struktur $10$ m, volumenya adalah luas penampang dikali panjang, yaitu $frac(320, 3) approx 106,7 "m"^3$.
  ],
  [
    #align(horizon)[
      #figure(pn-arch, gap: 1em, caption: [Penampang lengkung parabola])
    ]
  ],
)

Untuk bentuk tiga dimensi yang lebih umum, digunakan integral lipat dua, yaitu integral dalam kalkulus multivariabel yang menghitung volume dari fungsi tinggi $f(x, y)$ di atas daerah $R$. @irwan_Kasse_Darmiani_Jalil_2021

$ V = integral integral_R f(x, y) dif A $

Selain itu, integral juga digunakan untuk menghitung akumulasi populasi, emisi karbon, dosis farmasi, teori peluang, termodinamika, dan masih banyak bidang lainnya.@ATIKURRAHMAN_2025 @PETRA2025 @wp-integral

== Contoh Soal dan Pembahasan

#let cs-xy = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (5, 5), axis-style: "school-book",
    x-tick-step: none, y-tick-step: none,
    x-ticks: ((-1, [$-1$]), (1, [$1$])),
    y-ticks: ((-1, [$-1$]), (1, [$1$])),
    x-min: -1, x-max: 1, y-min: -1, y-max: 1,
    {
      plot.add-fill-between(
        x => x, x => 0, domain: (0, 1),
        style: (fill: cmyk_blue.lighten(80%), stroke: none),
      )
      plot.add-fill-between(
        x => x, x => 0, domain: (-1, 0),
        style: (fill: cmyk_vermil.lighten(80%), stroke: none),
      )
      plot.add(x => x, domain: (-1, 1), style: (stroke: cmyk_purple + 1.5pt))
    },
  )
})

#let cs-parabola = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (5, 5), axis-style: "school-book",
    x-tick-step: 1, y-tick-step: 1,
    x-min: -0.5, x-max: 3, y-min: -1.5, y-max: 3,
    {
      plot.add-fill-between(
        x => calc.pow(x, 2) - 1, x => 0, domain: (0, 1),
        style: (fill: cmyk_vermil.lighten(80%), stroke: none),
      )
      plot.add-fill-between(
        x => calc.pow(x, 2) - 1, x => 0, domain: (1, 2),
        style: (fill: cmyk_blue.lighten(80%), stroke: none),
      )
      plot.add(x => calc.pow(x, 2) - 1, domain: (-0.3, 2.3), style: (stroke: cmyk_purple + 1.5pt))
      plot.annotate({
        content((0.5, -0.45), $A_1$)
        content((1.6, 0.6), $A_2$)
      })
    },
  )
})

#let ni-keluarga = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (6, 5), axis-style: "school-book",
    x-tick-step: 1, y-tick-step: 2,
    x-min: -1.3, x-max: 2.3, y-min: -3, y-max: 13,
    {
      for c in (-2, 0, 2, 6) {
        plot.add(x => 3 * x * x - 2 * x + c, domain: (-1.2, 2.2),
          style: (stroke: (paint: cmyk_blue, dash: "dashed")))
      }
      plot.add(x => 3 * x * x - 2 * x + 4, domain: (-1.2, 2.2),
        style: (stroke: cmyk_purple + 1.8pt))
      plot.add(((1, 5),),
        style: (stroke: none),
        mark: "o", mark-size: .2,
        mark-style: (fill: cmyk_purple, stroke: white + 1pt))
      plot.annotate({
        rect((1.05, 2.8), (1.7, 5), fill: white, stroke: none)
        content((.9, 4), $(1, 5)$, anchor: "west", stroke: none)
      })
    },
  )
})

Pada bagian sebelumnya, kita telah mempelajari integral tak tentu, integral tentu, dan hubungannya dengan luas daerah. Kita juga telah melihat bagaimana integral dapat dipakai untuk menyelesaikan persoalan sehari-hari.

Pada bagian ini, kita akan menggabungkan beberapa konsep tersebut melalui lima kelompok soal: mencari antiturunan, menentukan kurva dari titik tertentu, menghitung integral tentu, menghitung luas daerah, dan menyelesaikan masalah nyata.

=== Integral Tak Tentu

Tentukan hasil integral tak tentu dari $3x^2 + 4x - 5$.

#penyelesaian(judul: [1. Pisahkan setiap suku], [
  Gunakan aturan penjumlahan, pengurangan, dan kelipatan konstanta untuk mengintegralkan setiap suku secara terpisah.

  $ integral (3x^2 + 4x - 5) dif x = 3 integral x^2 dif x + 4 integral x dif x - integral 5 dif x $
])

#penyelesaian(judul: [2. Integralkan dan sederhanakan], [
  Gunakan aturan pangkat dan aturan konstanta, lalu tambahkan konstanta integrasi $C$ satu kali di akhir.

  $
    &= 3 frac(x^3, 3) + 4 frac(x^2, 2) - 5x + C \
    &= #markrect([$quad x^3 + 2x^2 - 5x + C$], outset: 3pt)
  $
])

Jadi, hasil integral tak tentu tersebut adalah $x^3 + 2x^2 - 5x + C$.

=== Soal Nilai Awal

Gradien garis singgung suatu kurva di setiap titik adalah $f'(x) = 6x - 2$, dan kurva tersebut melalui titik $(1, 5)$. Tentukan persamaan kurvanya.

#penyelesaian(judul: [1. Integralkan untuk mendapat keluarga kurva], [
  $ f(x) = integral (6x - 2) dif x = #markrect([$quad 3x^2 - 2x + C$], outset: 3pt) $ 
])

#penyelesaian(judul: [2. Tentukan $C$ dari titik yang dilalui], [
  Titik $(1, 5)$ memilih satu kurva dari keluarga antiturunan. Substitusikan $x = 1$ dan $f(1) = 5$.

  $
    f(1) = 3 - 2 + C &= 5 \
    C &= #markrect([$quad 4$], outset: 3pt)
  $
])

Jadi, persamaan kurvanya adalah $f(x) = 3x^2 - 2x + 4$.

Pada gambar berikut, kurva ungu adalah satu-satunya anggota keluarga $y = 3x^2 - 2x + C$ yang melalui titik $(1, 5)$.

#figure(
  caption: figure.caption(position: top)[Keluarga kurva $y = 3x^2 - 2x + C$ dan kurva yang melalui $(1, 5)$],
  ni-keluarga,
)

=== Integral Tentu

Tentukan nilai integral tentu berikut.

$ integral_1^3 (3x^2 - 2x + 1) dif x $

#penyelesaian(judul: [1. Tentukan antiturunan], [
  Gunakan aturan pangkat dan konstanta pada setiap suku.

  $ F(x) = x^3 - x^2 + x $
])

#penyelesaian(judul: [2. Substitusikan batas atas dan batas bawah], [
  Gunakan Teorema Dasar Kalkulus: $F(b) - F(a)$ dengan $b = 3$ dan $a = 1$.

  $
    integral_1^3 (3x^2 - 2x + 1) dif x
    &= [x^3 - x^2 + x]_1^3 \
    &= (3^3 - 3^2 + 3) - (1^3 - 1^2 + 1) \
    &= 21 - 1 \
    &= #markrect([$quad 20$], outset: 3pt)
  $
])

Jadi, nilai integral tentu tersebut adalah $20$.

=== Luas Daerah dan Luas Bertanda

// *Soal 1*

Perhatikan grafik fungsi $y = x$ pada interval $-1 <= x <= 1$ berikut.

#figure(
  caption: figure.caption(position: top)[Grafik fungsi $y = x$ pada interval $-1 <= x <= 1$],
  cs-xy,
)

Tentukan nilai integral tentu dan luas geometris total pada interval tersebut.

#penyelesaian(judul: [1. Hitung integral tentu (luas bertanda)], [
  Daerah di bawah sumbu-$x$ memberi kontribusi negatif, sehingga kedua daerah dapat saling meniadakan.

  $
    integral_(-1)^1 x dif x
    &= [frac(x^2, 2)]_(-1)^1 \
    &= frac(1^2, 2) - frac((-1)^2, 2) = 0
  $

  Nilai $0$ tidak berarti tidak ada daerah yang berluas. Terdapat dua daerah, masing-masing di atas dan di bawah sumbu-$x$.
])

#penyelesaian(judul: [2. Hitung luas geometris total], [
  *Cara 1: rumus segitiga.* Kedua daerah kebetulan berbentuk segitiga siku-siku, sehingga luasnya dijumlahkan.

  $ L = frac(1, 2) times 1 times 1 + frac(1, 2) times 1 times 1 = #markrect([$quad 1$], outset: 3pt) $

  *Cara 2: integral.* Rumus segitiga hanya bisa dipakai karena $y = x$ kebetulan membentuk segitiga. Cara yang berlaku untuk kurva apa pun adalah memisahkan interval di titik potong sumbu-$x$ (di sini $x = 0$), lalu memberi tanda negatif pada bagian di bawah sumbu-$x$.

  $
    L &= -integral_(-1)^0 x dif x + integral_0^1 x dif x \
    &= -[frac(x^2, 2)]_(-1)^0 + [frac(x^2, 2)]_0^1 \
    &= -(0 - frac(1, 2)) + (frac(1, 2) - 0) = #markrect([$quad 1$], outset: 3pt)
  $
])

Jadi, nilai integral tentunya adalah $0$, sedangkan luas geometris totalnya adalah $1$ satuan luas.

// *Soal 2: bukan segitiga*

Pada Soal 1, daerahnya kebetulan berbentuk segitiga sehingga luasnya dapat dihitung dengan rumus geometri. Sekarang kita coba kurva yang melengkung, sehingga kita memakai cara integral (Cara 2) yang berlaku untuk kurva apa pun.

Tentukan nilai integral tentu dan luas geometris total dari $f(x) = x^2 - 1$ pada $[0, 2]$.

#figure(
  caption: figure.caption(position: top)[Grafik $y = x^2 - 1$ pada $[0, 2]$],
  cs-parabola,
)

#penyelesaian(judul: [1. Cari titik potong dengan sumbu-$x$], [
  $x^2 - 1 = 0$ memberi $x = 1$ atau $x = -1$. Hanya $x = 1$ yang berada pada $[0, 2]$, sehingga daerah dibagi menjadi $[0, 1]$ (di bawah sumbu) dan $[1, 2]$ (di atas sumbu).
])

#penyelesaian(judul: [2. Hitung integral tentu (luas bertanda)], [
  $
    integral_0^2 (x^2 - 1) dif x
    &= [frac(x^3, 3) - x]_0^2 \
    &= (frac(8, 3) - 2) - (0 - 0) = #markrect([$quad 2/3$], outset: 3pt)
  $
])

#penyelesaian(judul: [3. Hitung luas geometris total], [
  Hitung tiap bagian dan beri tanda negatif pada bagian di bawah sumbu-$x$. Pada soal ini $A_1$ dan $A_2$ dinomori dari kiri ke kanan, sehingga berbeda dari penomoran pada subbab Luas Bertanda.

  $
    A_1 &= -integral_0^1 (x^2 - 1) dif x = -(frac(1, 3) - 1) = #markrect([$quad 2/3$], outset: 3pt) \
    A_2 &= integral_1^2 (x^2 - 1) dif x = (frac(8, 3) - 2) - (frac(1, 3) - 1) = frac(4, 3)
  $

  $ L = A_1 + A_2 = 2 $
])

Jadi, nilai integral tentunya $frac(2, 3)$, sedangkan luas geometris totalnya $2$ satuan luas. Perhatikan bahwa $A_2 - A_1 = frac(2, 3)$, sama dengan nilai integral tentu pada langkah 2.

=== Soal Penerapan

Sebuah pabrik memiliki biaya marjinal $B'(x) = 6x + 20$ (ribu rupiah per unit) dan biaya tetap $100$ ribu rupiah. Tentukan fungsi biaya total $B(x)$ dan biaya untuk memproduksi $10$ unit.

#penyelesaian(judul: [1. Cari fungsi biaya total], [
  Biaya total adalah antiturunan dari biaya marjinal.

  $
    B(x) &= integral (6x + 20) dif x \
    &= 3x^2 + 20x + C
  $
])

#penyelesaian(judul: [2. Tentukan $C$ dari biaya tetap], [
  Biaya tetap adalah biaya yang harus dikeluarkan berapa pun jumlah produksinya, termasuk saat belum memproduksi apa pun. Jadi $B(0) = 100$.

  $ B(0) = C = 100 $
])

#penyelesaian(judul: [3. Hitung biaya untuk $10$ unit], [
  Biaya $10$ unit adalah biaya produksi ditambah biaya tetap.

  $ B(10) = 3(10)^2 + 20(10) + 100 = #markrect([$quad 600$], outset: 3pt) $
])

Jadi, $B(x) = 3x^2 + 20x + 100$, dan biaya memproduksi $10$ unit adalah $600$ ribu rupiah.

== Ringkasan

Integral tak tentu digunakan untuk mencari keluarga antiturunan, sedangkan integral tentu digunakan untuk menghitung akumulasi pada interval tertentu.

=== Aturan Integral Tak Tentu

#figure(
  table(
    columns: (auto, 1fr),
    inset: 10pt,
    fill: (col, row) => {
      if row == 0 {
        cmyk_purple.lighten(88%)
      } else {
        none
      }
    },
    align: left,

    [*Aturan*], [*Rumus*],

    [Aturan Pangkat],
    [$ integral x^n dif x
      = frac(x^(n+1), n+1) + C $],

    [Aturan Konstanta],
    [$ integral k dif x = \k\x + C $],

    [Kelipatan Konstanta],
    [$ integral k f(x) dif x
      = k integral f(x) dif x $],

    [Penjumlahan],
    [$ integral (f(x) + g(x)) dif x
      = integral f(x) dif x
      + integral g(x) dif x $],

    [Pengurangan],
    [$ integral (f(x) - g(x)) dif x
      = integral f(x) dif x
      - integral g(x) dif x $],
  ),
  caption: [Aturan dasar integral tak tentu]
)

#info[
  Catatan penting: Aturan pangkat berlaku untuk $n != -1$. Setiap hasil integral tak tentu harus menyertakan konstanta integrasi $C$.
]

=== Integral Tentu

Integral tentu adalah limit jumlah Riemann, dan dihitung dengan Teorema Dasar Kalkulus, yaitu dengan mencari selisih nilai antiturunan pada batas atas dan batas bawah.

#side-by-side(
  [
    *Rumus integral tentu*

    Jika $F'(x) = f(x)$, maka nilai integral tentu dapat dihitung dengan menghitung antiturunan $F(x)$ pada kedua batas integrasi.
  ],
  [
    #align(horizon)[
      $ integral_a^b f(x) dif x = F(b) - F(a) $
    ]
  ],
)

Berbeda dengan integral tak tentu, integral tentu menghasilkan nilai tertentu dan tidak memerlukan penambahan konstanta integrasi $C$ pada hasil akhirnya.

=== Luas Daerah

Integral tentu berkaitan dengan luas daerah di antara kurva dan sumbu-$x$. Namun, perlu dibedakan antara nilai integral tentu dan luas geometris total.

#side-by-side(
  [
    Daerah di atas sumbu-$x$ memberikan kontribusi positif, sedangkan daerah di bawah sumbu-$x$ memberikan kontribusi negatif.
  ],
  [
    $ integral_a^b f(x) dif x $

    $ = A_1 - A_2 + A_3 $
  ],
)

Jika fungsi tidak negatif pada seluruh interval, nilai integral tentu sama dengan luas daerah di bawah kurva. Jika terdapat daerah di bawah sumbu-$x$, luas geometris total harus dihitung dengan menjumlahkan luas setiap daerah tanpa memperhatikan tandanya.

$ L = A_1 + A_2 + A_3 $

=== Kesalahan Umum

#figure(
  table(
    columns: (1fr, 1fr),
    inset: 10pt,
    fill: (col, row) => if row == 0 { cmyk_purple.lighten(88%) } else { none },
    align: left,

    [*Kesalahan*], [*Yang benar*],

    [Lupa $C$: $integral 2x dif x = x^2$],
    [$integral 2x dif x = x^2 + C$],

    [Pangkat lama sebagai pembagi: $integral x^3 dif x = frac(x^4, 3) + C$],
    [$integral x^3 dif x = frac(x^4, 4) + C$],

    [Memakai aturan pangkat untuk $n = -1$, misalnya $integral x^(-1) dif x = frac(x^0, 0) + C$],
    [Aturan pangkat tidak berlaku untuk $n = -1$ karena penyebutnya menjadi $0$. Antiturunan $x^(-1)$ adalah fungsi jenis lain di luar cakupan bab ini.],

    [Menambah $C$ pada integral tentu],
    [Integral tentu bernilai tertentu, $C$ saling menghilangkan.],

    [Batas tertukar: $F(a) - F(b)$],
    [$integral_a^b f(x) dif x = F(b) - F(a)$],

    [Menganggap integral $= 0$ berarti luas $= 0$],
    [Luas bertanda bisa nol, tetapi luas geometris tetap positif.],
  ),
  caption: [Daftar Kesalahan yang sering terjadi]
)

Poin penting dalam bab Integral:

- Integral tak tentu digunakan untuk mencari antiturunan suatu fungsi.
- Konstanta integrasi $C$ mencakup keluarga antiturunan yang memiliki turunan sama.
- Aturan dasar integral membantu menyederhanakan proses perhitungan.
- Integral tentu dihitung dengan mengurangkan nilai antiturunan pada batas bawah dari nilai pada batas atas.
- Integral tentu menghitung luas bertanda, sedangkan luas geometris total tidak bernilai negatif.
- Integral dapat diterapkan untuk menghitung akumulasi besaran, seperti jarak tempuh dan luas daerah.

#pagebreak()

// Dari Ega: latihan berupa 10 PG. Pake template #soal-pg
== Latihan Soal

#let pg-dua-kurva = cetz.canvas({
  import cetz.draw: *
  set-style(axes: (stroke: cmyk_border))
  plot.plot(
    size: (6, 5), axis-style: "school-book",
    x-tick-step: none, y-tick-step: none,
    x-ticks: ((1, [$1$]), (2, [$2$])),
    y-ticks: ((1, [$1$]), (2, [$2$]), (3, [$3$]), (4, [$4$])),
    x-min: -0.5, x-max: 2.7, y-min: -0.5, y-max: 4.8,
    {
      plot.add-fill-between(
        x => 4, x => calc.pow(x, 2), domain: (0, 2),
        style: (fill: cmyk_purple.lighten(70%), stroke: none),
      )
      plot.add(x => 4, domain: (0, 2.5), style: (stroke: cmyk_purple + 1.5pt))
      plot.add(x => calc.pow(x, 2), domain: (0, 2.1), style: (stroke: cmyk_blue + 1.5pt))
      plot.annotate({
        content((2.9, 4.1), $y = 4$)
        content((1.9, 2.0), $y = x^2$)
      })
    },
  )
})

*Silang ($crossmark$) pada salah satu huruf (A, B, C, atau D)*
#columns(2, gutter: 10pt)[
  #soal-pg(
    [Tentukan hasil dari $integral x^3 dif x$.],
    (
      [$x^4 + C$],
      [$frac(x^4, 4) + C$],
      [$3x^2 + C$],
      [$frac(x^3, 3) + C$],
    )
  )

  #soal-pg(
    [Tentukan hasil dari $integral 8 dif x$.],
    (
      [$8x + C$],
      [$8 + C$],
      [$x + 8$],
      [$4x^2 + C$],
    )
  )

  #soal-pg(
    [Tentukan hasil dari $integral 4x^2 dif x$.],
    (
      [$4x^3 + C$],
      [$frac(4x^3, 3) + C$],
      [$2x^2 + C$],
      [$4x + C$],
    )
  )

  #soal-pg(
    [Tentukan hasil dari $integral (x^2 + 2x - 3) dif x$.],
    (
      [$x^3 + x^2 - 3x + C$],
      [$frac(x^3, 3) + 2x^2 - 3x + C$],
      [$frac(x^3, 3) + x^2 - 3 + C$],
      [$frac(x^3, 3) + x^2 - 3x + C$],
    )
  )

  #soal-pg(
    [Mengapa konstanta integrasi $C$ perlu ditambahkan pada hasil integral tak tentu?],
    (
      [Karena $C$ merupakan batas atas integral.],
      [Karena turunan setiap fungsi selalu menghasilkan $C$.],
      [Karena turunan suatu konstanta adalah nol.],
      [Karena $C$ merupakan fungsi yang diintegralkan.],
    )
  )

  #soal-pg(
    [Tentukan nilai dari $integral_0^2 3x^2 dif x$.],
    (
      [$8$],
      [$6$],
      [$4$],
      [$12$],
    )
  )

    #soal-pg(
    [Diketahui $integral_0^3 f(x) dif x = 5$ dan $integral_3^5 f(x) dif x = 2$. Tentukan nilai $integral_0^5 f(x) dif x$.],
    (
      [$3$],
      [$10$],
      [$7$],
      [$2$],
    )
  )

  #soal-pg(
    [Gradien garis singgung suatu kurva adalah $f'(x) = 2x + 1$ dan kurva tersebut melalui titik $(1, 4)$. Tentukan persamaan kurvanya.],
    (
      [$x^2 + x$],
      [$x^2 + x + 4$],
      [$x^2 + x + 3$],
      [$x^2 + x + 2$],
    )
  )

  #soal-pg(
    [Perhatikan gambar berikut.
    #align(center, pg-dua-kurva)
    Luas daerah yang diarsir, yaitu daerah di antara $y = 4$ dan $y = x^2$ pada $[0, 2]$, adalah ....],
    (
      [$8$],
      [$frac(16, 3)$],
      [$frac(8, 3)$],
      [$4$],
    )
  )

  #soal-pg(
    [Perhatikan gambar berikut.
    #align(center, kurva-bertanda)
    Luas geometris daerah $A_1 = 5$, $A_2 = 2$, dan $A_3 = 4$. Nilai $integral_a^d f(x) dif x$ adalah ....],
    (
      [$7$],
      [$11$],
      [$3$],
      [$1$],
    )
  )
]

