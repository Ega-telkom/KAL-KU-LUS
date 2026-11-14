# KAL-KU-LUS: *In a nutshell*
Tugas PSAJ membuat handout serta menguji kemampuan teknologi Typst.

## Membangun
Pastikan biner `typst` versi 0.15.1 terpasang pada sistem Anda. Pastikan fon berikut terpasang pada sistem Anda:
- Noto Sans
- Computer Modern
- IBM Plex Mono

Atau dapat diletakan pada pohon proyek dengan menggunakan argumen `--font-path <path>`.

Untuk membangun buku menjadi biner `main.pdf` jalankan
```sh
$ typst compile main.typ main.pdf
```

Jika kompiler perlu beberapa dependensi, patuhilah dengan memasang dependensinya. *(Saya sedikit malas mencatat dependensi bukunya)*

## Legal
Konten asli yang dibuat dibuku ini dilisensikan dibawah CC-BY-SA 4.0. Tidak berlaku untuk aset yang dicantumkan sumber/lisensi secara terpisah.
