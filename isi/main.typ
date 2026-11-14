#import "template.typ": *
#import "@preview/glossy:0.9.2": *
#import "@preview/lucide:0.1.0": *
#import "@preview/ccicons:1.0.1": *

#show: handout.with(
  title: [KAL-KU-LUS: _In a nutshell_, Handout PSAJ Matematika XII],
  keywords: (
    "Limit",
    "Turunan",
    "Integral"
  ),
  author: (
    "Cynthia Linda Rizkiana", 
    "Danendra Eganatha Syahsamaauren",
    "Fadhil Rekh Saputra"
  )
)
#show: init-glossary.with(yaml("glosarium.yml"))

= Tentang Buku Ini
#v(1em)

Karya ini dilindungi dibawah lisensi Creative Commons BY-SA 4.0.
#cc-by-sa

Apa yang boleh Anda lakukan:
- *Membagikan:* menyalin dan menyebarkan buku ini dalam format apa pun.
- *Mengadaptasi:* mengubah, menerjemahkan, atau membuat turunan, termasuk untuk keperluan komersial.

Dengan syarat:
- *Atribusi:* cantumkan nama penulis, tautan lisensi, dan tandai jika ada perubahan.
- *ShareAlike:* hasil adaptasi harus memakai lisensi yang sama (CC BY-SA 4.0).

Ringkasan ini bukan pengganti teks lisensi lengkap. Lisensi ini berlaku untuk konten asli dari handout ini dan tidak berlaku untuk materi pihak ketiga, yang disebutkan dan dicantumkan sumbernya secara terpisah. Pelajari lebih lanjut: #underline[#link("https://creativecommons.org/licenses/by-sa/4.0/")]

*Penulis*
- Cynthia Linda Rizkiana
- Danendra Eganatha Syahsamaauren
- Fadhil Rekh Saputra

*Editor & Desainer*
- Danendra Eganatha Syahsamaauren

#v(1fr)

#let detail-hlm = context {
  let pembuka = counter(page).at(<awal-isi>).first() - 1
  let isi = counter(page).final().first()
  [#numbering("i", pembuka), #isi hlm.]
}

#context[
  Buku ini diciptakan dan di-_compile_ menggunakan Typst #sys.version. Menggunakan fon IBM Plex Sans, Noto Sans, dan Computer Modern, sama-sama dengan lisensi _SIL Open Font_. #detail-hlm, #page.width.mm() \u{00D7} #page.height.mm()mm.
]

#pagebreak()

= Kata Pengantar
#v(1em)
#context [
  Puji syukur ke hadirat Tuhan Yang Maha Esa atas rahmat dan karunia-Nya sehingga *#document.title* ini dapat diselesaikan dengan baik.
  
  Handout ini disusun sebagai bagian dari pelaksanaan Penilaian Sumatif Akhir Jenjang pada mata pelajaran Matematika. Penyusunan handout ini menjadi salah satu bentuk upaya untuk mengembangkan pemahaman terhadap materi kalkulus sekaligus menuangkan kembali konsep-konsep yang telah dipelajari ke dalam sebuah bahan pembelajaran yang sistematis dan mudah dipahami.
  
  Materi dalam handout ini berfokus pada konsep-konsep dasar kalkulus, khususnya limit, turunan, dan integral. Setiap materi disajikan secara bertahap, mulai dari pemahaman konsep, sifat dan rumus, contoh soal, hingga penerapannya dalam berbagai permasalahan. Dengan penyajian tersebut, handout ini diharapkan tidak hanya menjadi bahan untuk memahami konsep secara teoritis, tetapi juga membantu pembaca melihat keterkaitan kalkulus dengan berbagai permasalahan yang dapat dijumpai dalam pembelajaran maupun kehidupan sehari-hari.
  
  Handout ini ditujukan bagi peserta didik kelas XII SMK serta dapat digunakan oleh siapa saja yang ingin mempelajari kembali konsep dasar kalkulus. Bagi guru, handout ini juga dapat menjadi salah satu bahan pendamping dalam kegiatan pembelajaran dan pengayaan materi.
  
  // Nama pembimbing siapa ya?
  Dalam proses penyusunannya, penulis memperoleh arahan, dukungan, dan bimbingan dari berbagai pihak. Oleh karena itu, penulis menyampaikan terima kasih kepada guru pembimbing serta SMK Telkom Purwokerto yang telah memberikan kesempatan dan dukungan dalam penyelesaian handout ini.
  
  Penulis menyadari bahwa handout ini masih memiliki kekurangan, baik dalam penyajian materi maupun dalam penyusunannya. Oleh karena itu, kritik dan saran yang membangun sangat diharapkan sebagai bahan evaluasi dan penyempurnaan di masa mendatang.
  
  Akhir kata, semoga *#document.title* dapat memberikan manfaat bagi pembaca dan menjadi salah satu sarana untuk mengenal, memahami, serta mengaplikasikan konsep-konsep kalkulus dengan lebih mudah, terstruktur, dan bermakna.
  
  - Tim Penyusun
]
#pagebreak()

= Daftar Isi
#outline(title: none)
#pagebreak()

= Daftar Gambar
#v(1em)
#outline(title: none, target: figure.where(kind: image))
#pagebreak()

= Daftar Tabel
#v(1em)
#outline(title: none, target: figure.where(kind: table))
#pagebreak()

= Sebelum Mulai
#v(1em)
#context[
  Selamat datang di *#document.title*. _Handout_ ini membahas tiga pilar utama kalkulus, yaitu limit, turunan, dan integral, dengan pendekatan intuitif: setiap rumus disertai alasan di baliknya, bukan sekadar cara pakainya.
]

Sesuai judulnya yang memuat frasa _"In a nutshell"_, materi di dalamnya disusun ringkas dan tidak melebar ke topik-topik kalkulus yang jarang ditemui. Fokusnya tertuju pada konsep serta teknik yang paling sering muncul di kelas XII, tanpa pembuktian formal maupun topik lanjutan tingkat perkuliahan, seperti definisi limit $epsilon$–$delta$, deret tak hingga, atau kalkulus peubah banyak.

Agar pembahasan lebih mudah diikuti, pastikan kamu sudah akrab dengan beberapa bekal dasar berikut:
- aljabar dasar: menjabarkan perkalian kurung, memfaktorkan, menyederhanakan pecahan aljabar, dan menyelesaikan persamaan kuadrat;
- sifat pangkat dan akar, termasuk pangkat negatif serta pangkat pecahan (akar sebagai pangkat $1/2$);
- fungsi: notasi $f(x)$, komposisi fungsi, dan membaca grafik (garis lurus, parabola, dan kubik);
- persamaan garis lurus dan gradien;
- pertidaksamaan sederhana dan penulisan interval;
- sudut dalam satuan radian serta nilai dan sifat dasar sinus dan kosinus.

Jika ada materi yang terlupa, luangkan waktu sejenak untuk mengulasnya kembali. Tenang saja, pengingat singkat tetap disisipkan pada bagian-bagian yang sering membingungkan. Satu saran lagi: cobalah mengerjakan contoh soal sendiri sebelum melihat penyelesaiannya.

Selamat belajar! :D
#pagebreak()

#numeric-page[
  #main-body[
    #include "bab/01-Limit.typ" 
    #include "bab/02-Turunan.typ"
    #include "bab/03-Integral.typ"
  ]
  #pagebreak()
  
  = Glosarium
  #v(1em)
  #glossary(
    theme: (
      ..theme-academic,
      section: (title, body) => body,
    ),
    show-all: true
  )
  #pagebreak()
  
  = Daftar Pustaka
  #v(1em)
  #bibliography("./pustaka.yml", title: none)
  #pagebreak()
  
  = Kunci Jawaban & Penjelasan
  #v(1em)
  
  // Tulis kunci jawaban ABCD dibagian [X]!!!
  == Latihan Soal Limit
  #table(
    columns: (1fr,) * 10,
    fill: (col, row) => {
      if row == 0 {
        cmyk_purple.lighten(90%)
      } else {
        none
      }
    },
    inset: 10pt,
    align: center,
    [*1*], [*2*], [*3*], [*4*], [*5*], [*6*], [*7*], [*8*], [*9*], [*10*],
    [C], [A], [D], [B], [A], [B], [C], [C], [B], [B],
  )
  *Penjelasan:*
  // Tulis penjelasan singkat disini!!!
  1. Berdasarkan perhitungan menggunakan metode substitusi langsung, nilai $(x=2)$ dimasukkan ke dalam fungsi $(x^2+3x-1)$. Hasil perhitungannya adalah $(2^2+3(2)-1=9)$. Jadi, nilai limit dari fungsi tersebut adalah 9.
  
  2. Berdasarkan pengamatan terhadap grafik, ketika $(x)$ mendekati 1 dari arah kiri, nilai fungsi mendekati 4. Ketika $(x)$ mendekati 1 dari arah kanan, nilai fungsi juga mendekati 4. Karena kedua arah menghasilkan nilai yang sama, limit fungsi tersebut adalah 4.
  3. Diketahui bahwa limit kiri fungsi ketika $(x)$ mendekati 2 adalah 3, sedangkan limit kanannya adalah 5. Kedua nilai tersebut berbeda sehingga tidak memenuhi syarat keberadaan limit dua sisi. Oleh karena itu, limit dua sisi fungsi tersebut tidak ada.
  4. Berdasarkan penyelesaian menggunakan pemfaktoran, bentuk $(x^2-9)$ dapat diuraikan menjadi $(x-3)(x+3)$. Setelah faktor yang sama pada pembilang dan penyebut disederhanakan, diperoleh bentuk $(x+3)$. Dengan memasukkan nilai $(x=3)$, hasil limitnya adalah 6.
  5. Berdasarkan pemfaktoran, pembilang $(x^2-1)$ menjadi $(x-1)(x+1)$, sedangkan penyebut $(x^2-3x+2)$ menjadi $(x-1)(x-2)$. Setelah faktor yang sama disederhanakan, diperoleh bentuk pecahan $(x + 1)/(x - 2)$. Dengan memasukkan nilai $(x=1)$, hasil limitnya adalah −2.
  6. Penyelesaian soal ini menggunakan bentuk sekawan untuk menghilangkan akar pada pembilang. Setelah dikalikan dengan bentuk sekawan dan disederhanakan, diperoleh bentuk $1 / (sqrt(x + 5) + 3)$ Dengan memasukkan nilai $(x=4)$, hasil limitnya adalah $(1)/(6)$.
  7. Berdasarkan sifat operasi limit, bentuk $(2f(x)-g(x))$ dapat diselesaikan dengan memasukkan nilai limit yang telah diketahui. Perhitungannya menjadi $(2(2)-(-3)= 4+3= 7)$. Jadi, nilai limit yang diperoleh adalah 7.
  8. Apabila substitusi langsung menghasilkan bentuk $0/0$, hasil tersebut disebut bentuk tak tentu dan belum dapat digunakan sebagai nilai akhir limit. Oleh karena itu, fungsi perlu disederhanakan menggunakan metode yang sesuai, seperti pemfaktoran atau merasionalkan bentuk akar.
  9. Substitusi $x -> infinity$ menghasilkan bentuk $infinity / infinity$ (tak tentu). Bagi pembilang dan penyebut dengan pangkat tertinggi pada penyebut, yaitu $x^2$, sehingga diperoleh $(6 + 1/x)/(2 - 5/x^2)$. Ketika $x -> infinity$, suku $1/x$ dan $5/x^2$ menuju $0$, sehingga hasilnya $6/2 = 3$.
  10. Berdasarkan rumus kecepatan sesaat melalui limit, terlebih dahulu ditentukan nilai $s(3+h)=(3+h)^2=9+6h+h^2$ dan $s(3)=9$. Setelah dimasukkan ke dalam rumus, disederhanakan, dan faktor $h$ dihilangkan, diperoleh bentuk $6 + h$. Ketika $h$ mendekati nol, hasil limitnya adalah 6 m/s.
  
  // Catatan: Ini kunci jawaban kemungkinan sudah benar, tinggal ditambahkan penjelasan
  == Latihan Soal Turunan
  #table(
    columns: (1fr,) * 10,
    fill: (col, row) => {
      if row == 0 {
        cmyk_purple.lighten(90%)
      } else {
        none
      }
    },
    inset: 10pt,
    align: center,
    [*1*], [*2*], [*3*], [*4*], [*5*], [*6*], [*7*], [*8*], [*9*], [*10*],
    [A], [C], [C], [B], [C], [A], [B], [A], [B], [C],
  )

  *Penjelasan :*

  1. Berdasarkan aturan pangkat, setiap suku diturunkan dengan mengalikan koefisien dan pangkat variabel, kemudian mengurangi pangkatnya satu. Turunan dari $3x^4-2x^2+5$ adalah $12x^3-4x$, karena turunan konstanta 5 adalah nol. Jadi, hasil akhirnya adalah $12x^3-4x$.
  
  2. Penyelesaian soal ini menggunakan aturan perkalian karena terdapat dua fungsi yang dikalikan, yaitu $x^2$ dan $(x+1)$. Dengan rumus $(u v)'=u'v+u v'$, diperoleh $2x(x+1)+x^2$. Setelah disederhanakan, hasilnya adalah $3x^2+2x$.
  3. Soal ini menggunakan aturan pembagian karena fungsi berbentuk pecahan dengan pembilang $x^2$ dan penyebut $x+1$. Setelah menggunakan rumus turunan hasil bagi, diperoleh $f'(x)= (x^2+2x)/ (x+1)^2$. Dengan memasukkan $x=1$, hasilnya adalah $3/4$.
  4. Penyelesaian soal ini menggunakan aturan rantai karena terdapat fungsi $2x-1$ di dalam pangkat tiga. Pangkat diturunkan terlebih dahulu, kemudian hasilnya dikalikan dengan turunan bagian dalam yang bernilai 2. Hasil akhirnya adalah $6(2x-1)^2$.
  5. Turunan fungsi trigonometri dapat diperoleh menggunakan rumus dasar turunan sinus dan cosinus. Turunan dari $2sin(x)$ adalah $2cos(x)$, sedangkan turunan dari $-3cos(x)$ adalah $3sin(x)$. Jadi, hasil akhirnya adalah $2cos(x)+3sin(x)$.
  6. Untuk menentukan persamaan garis singgung, terlebih dahulu dicari gradien menggunakan turunan pertama fungsi. Dari $f(x)=x^2+1$, diperoleh gradien sebesar 4 dan titik singgung $(2,5)$. Setelah dimasukkan ke rumus persamaan garis lurus, diperoleh $y=4x-3$.
  7. Berdasarkan pengamatan grafik, fungsi mengalami kenaikan sebelum mencapai titik maksimum lokal di $x=-1$. Setelah melewati titik tersebut, grafik bergerak turun hingga mencapai titik minimum lokal di $x=1$. Oleh karena itu, interval penurunan fungsi adalah $(-1,1)$.
  8. Berdasarkan turunan pertama fungsi keuntungan $P(x)=-x^2+40x-100$, diperoleh $P'(x)=-2x+40$. Dengan menggunakan syarat $P'(x)=0$, didapatkan jumlah produk sebanyak 20 unit. Setelah dimasukkan ke fungsi awal, keuntungan maksimum adalah Rp300.000.
  9. Untuk menentukan titik belok, digunakan turunan kedua dengan menyelesaikan persamaan $f''(x)=0$. Dari fungsi $f(x)=x^3-3x^2+2$, diperoleh $f''(x)=6x-6$, sehingga nilai $x=1$. Setelah dimasukkan ke fungsi awal, diperoleh $y=0$, jadi koordinat titik beloknya adalah $(1,0)$.
  10. Untuk menentukan percepatan, fungsi posisi diturunkan pertama kali untuk mendapatkan kecepatan, kemudian diturunkan kembali untuk mendapatkan percepatan. Dari $s(t)=2t^3+3t^2+10t$, diperoleh fungsi percepatan $a(t)=12t+6$. Dengan memasukkan $t=2$, diperoleh percepatan sebesar 30 m/s².
  
  == Latihan Soal Integral
  #table(
    columns: (1fr,) * 10,
    fill: (col, row) => {
      if row == 0 {
        cmyk_purple.lighten(90%)
      } else {
        none
      }
    },
    inset: 10pt,
    align: center,
    [*1*], [*2*], [*3*], [*4*], [*5*], [*6*], [*7*], [*8*], [*9*], [*10*],
    [B], [A], [B], [D], [C], [A], [C], [D], [B], [A],
  )
  *Penjelasan :*

  1. Diketahui integral $integral x^3 d x $, sehingga digunakan rumus dasar integral dengan menambahkan pangkat satu pada variabel, kemudian membaginya dengan pangkat yang baru. Perhitungannya menjadi $x^(3+1)/(3+1)+C= x^4/4+C $. Jadi, hasil integralnya adalah $x^4/4+C$.
  
  2. Integral dari suatu konstanta diperoleh dengan mengalikan konstanta tersebut dengan variabel $x$, kemudian menambahkan konstanta integrasi. Perhitungannya adalah $integral 8 d x=8x+C$. Jadi, hasil integralnya adalah $8x+C$.
  3. Diketahui $integral 4x^2 d x$, sehingga koefisien 4 tetap digunakan dan pangkat variabel ditambah satu. Perhitungannya menjadi $4 times x^(2+1)/(2+1)+C= 4x^3/3+C$. Jadi, hasil integralnya adalah $4x^3/3+C$.
  4. Untuk menyelesaikan soal ini, setiap suku pada fungsi $x^2+2x-3$ diintegralkan secara terpisah. Hasilnya adalah $x^3/3+x^2-3x+C$, karena pangkat setiap variabel ditambah satu dan kemudian dibagi dengan pangkat barunya. Jadi, hasil integralnya adalah $x^3/3+x^2-3x+C$.
  5. Konstanta integrasi $C$ perlu ditambahkan pada hasil integral tak tentu karena turunan dari suatu konstanta selalu bernilai nol. Hal ini menyebabkan fungsi yang berbeda hanya pada nilai konstantanya dapat memiliki turunan yang sama.
  6. Diketahui $integral_0^2 3x^2 d x$, sehingga terlebih dahulu dicari integral tak tentunya, yaitu $x^3$. Selanjutnya, masukkan batas atas dan batas bawah ke dalam hasil integral sehingga diperoleh $2^3-0^3=8$. Jadi, nilai integral tentu tersebut adalah 8.
  7. Untuk menyelesaikan integral $integral_1^2(2x+1) d x$, terlebih dahulu tentukan integral tak tentunya, yaitu $x^2+x$. Kemudian, masukkan batas atas 2 dan batas bawah 1 sehingga diperoleh $(2^2+2)-(1^2+1)=6-2=4$. Jadi, nilai integral tentu tersebut adalah 4.
  8. Diketahui $integral_0^2 x d x$, sehingga integral tak tentunya adalah $x^2/2$. Setelah memasukkan batas atas dan batas bawah, diperoleh $2^2/2-0^2/2=2-0=2$. Jadi, nilai integral tentu tersebut adalah 2.
  9. Diketahui $integral_(-1)^1x d x$, sehingga integral tak tentunya adalah $x^2/2$. Dengan memasukkan batas atas 1 dan batas bawah −1, diperoleh $1^2/2-(-1)^2/2=1/2-1/2=0$. Jadi, nilai integral tentu tersebut adalah 0.
  10. Diketahui luas daerah $A_1=5$ dan $A_3=4$ berada di atas sumbu-$x$, sedangkan $A_2=2$ berada di bawah sumbu-$x$. Dalam integral tentu, luas daerah di atas sumbu-$x$ bernilai positif, sedangkan luas daerah di bawah sumbu-$x$ bernilai negatif. Dengan demikian, hasilnya adalah $5-2+4=7$, sehingga nilai integral tentu tersebut adalah 7.
]