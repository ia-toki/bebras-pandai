# Taskforce Pemutakhiran Data `Bebras Task` untuk Aplikasi `Bebras Pandai`

Kami masih memerlukan bantuan tenaga manual untuk memasukkan data sesuai format yang dapat dibaca Aplikasi `Bebras Pandai`. Berikut penjelasannya.

<br>

## Peran / Role

Pada **Taskforce Pemutakhiran Data `Bebras Task`** ini dibagi menjadi 3 peran utama, yaitu:

### Perintis
<img src="https://3.bp.blogspot.com/-DtJ8QgmGQt0/VBRvqdOsUeI/AAAAAAAAH7U/IOO3WwBbZuk/s1600/sangga-perintis.jpg" width=48> <br>
Bertugas untuk mengunggah gambar yang diperlukan pada soal `Bebras Task`. Juga bertugas untuk mengekspor dan mengkategorisasi `Bebras Task` dari Moodle. <br>

Persyaratan:
- Dapat mengakses Moodle https://tantanganbebras.ipb.ac.id
- Mengerti cara mengoperasikan `git`

Silahkan membaca penjelasan SOP berikut untuk detail tugas: <br>
1. [B. Mengekspor `Bebras Task` dari Moodle](#b-mengekspor-bebras-task-dari-moodle)
1. [C. Mengunggah Gambar](#c-mengunggah-gambar)

### Pendobrak
<img src="https://3.bp.blogspot.com/-EAtwR7PfSyI/VBRvp-aSsJI/AAAAAAAAH7Q/paIqdSF-5LA/s1600/sangga-pendobrak.jpg" width=48> <br>
Bertugas untuk mengupdate data `Bebras Task`. <br>
Data `Bebras Task` tersebut akan berupa file `json` dengan schema:
```
_version_        = version schema metadata, dapat diabaikan
id               = ID `Bebras Task`
title            = Judul `Bebras Task`
country          = Kode Negara pembuat `Bebras Task`
source           = Kode sumber `Bebras Task`
type             = Tipe `Bebras Task`, sekarang hanya mendukung: "MULTIPLE_CHOICE", "SHORT_ANSWER"
description
  content        = Isi dari deskripsi `Bebras Task` berupa HTML
question 
  options        =
    [id]         =
    [content]    =
  content        = Isi dari pertanyaan `Bebras Task` berupa HTML
answer
  correct_answer = 
  explanation
    content      = Isi dari penjelasan `Bebras Task` berupa HTML
    aspect
      label      = "INFORMATIKA" sebagai default value
      content    = Isi dari tambahan penjelasan `Bebras Task` berupa HTML
keywords
  [words]        =
  [website]      =
```
Contoh file bisa Anda temukan di [data/bebras_task/penegak/2016/2016-BE-01.json](https://github.com/ia-toki/bebras-pandai/tree/main/data/bebras_task/penegak/2016/2016-BE-01.json) <br>

Persyaratan:
- Mengerti cara mengoperasikan `git`
- Mengerti `html`
- Mengerti `json`

Silahkan membaca penjelasan SOP berikut untuk detail tugas: <br>
1. [D. Mengupdate Data `Bebras Task`](#d-mengupdate-data-bebras-task)
1. opsional: [G. Update Manual Database Server](#g-update-manual-database-server)

### Pencoba
<img src="https://3.bp.blogspot.com/-DxhSPTtvO4I/VBRvpojEq8I/AAAAAAAAH7Y/7Y5O2yNyHNc/s1600/sangga-pencoba.jpg" width=48> <br>
Bertugas untuk meninjau PR yang dibuat oleh tim [Pendobrak](#pendobrak) & mengecek apakah data `Bebras Task` yang baru sudah sesuai tampilan. <br>

Persyaratan:
- Dapat mengakses Moodle https://tantanganbebras.ipb.ac.id
- Bonus: Mengerti cara mengoperasikan `git`
- Bonus: Bisa menjalankan `python`

Silahkan membaca penjelasan SOP berikut untuk detail tugas: <br>
1. [E. Mereview PR Data `Bebras Task`](#e-mereview-pr-data-bebras-task)
1. [F. Meninjau Tampilan `Bebras Task` di Aplikasi](#f-meninjau-tampilan-bebras-task-di-aplikasi)
1. opsional: [G. Update Manual Database Server](#g-update-manual-database-server)

<br>


## Detail SOP

### A. Persiapan
1. Clone repository `bebras-pandai` <br>
    Dengan asumsi `git` sudah terinstall di komputer Anda, silahkan jalankan perintah berikut
    ```
    git clone git@github.com:ia-toki/bebras-pandai.git
    ```
1. Mendapatkan akses Moodle
1. Bergabung dengan group??

### B. Mengekspor `Bebras Task` dari Moodle
```
  TIDAK TAU ¯\_(ツ)_/¯ ?
```

### C. Mengunggah Gambar
1. Unggah gambar ke [data/bebras_task_asset](https://github.com/ia-toki/bebras-pandai/tree/main/data/bebras_task_asset) menggunakan `git`
1. Untuk memudahkan mengakses kembali gambar yang sudah diunggah, tolong ikuti format berikut
    ```
    <kategori>/<tahun>/<kode task>_<urutan file>.png
    ```

### D. Mengupdate Data `Bebras Task`
1. Unggah data ke [data/bebras_task](https://github.com/ia-toki/bebras-pandai/tree/main/data/bebras_task) menggunakan `git`
1. Umumkan di group tautan PR yang baru saja dibuat

### E. Mereview PR Data `Bebras Task`
1. Review PR yang dilakukan oleh tim [Pendobrak](#pendobrak)

### F. Meninjau Tampilan `Bebras Task` di Aplikasi
1. Download aplikasi `Bebras Pandai`
    - Playstore: https://play.google.com/apps/internaltest/4701290915075958318 
    - Appstore: ?
1. Jalankan aplikasi & daftarkan akun Anda
1. Umumkan ke group email yang Anda pakai, admin akan menambahkan Anda untuk dapat mengakses Latihan-latihan tester
1. Jalankan latihan tersebut dan teliti jika ada tampilan yang tidak sesuai
1. Bandingkan dengan versi Moodle-nya apakah terdapat perbedaan yang signifikan
1. Update Laporan Rekapitulasi di https://docs.google.com/document/d/1uFyNsDrUoYEfUgM2VnpAx_kuzc6RDBbKFMQL5j-KxRk/edit
1. Unggah screenshot ke folder [GDrive](https://drive.google.com/drive/u/2/folders/1FgTUMxzdG2seKMlTSEG5J8LZQIwJ4PWu) sebagai referensi

### G. Update Manual Database Server
1. Download `google-service-account.json` (hubungi [@atnanahidiw](https://github.com/atnanahidiw) untuk mendapatkannya)
1. Jalankan perintah berikut untuk mengupdate environment variable
    ```
    export FIREBASE_SECRET_KEY_JSON=`cat /path/ke/google-service-account.json`
    ```
1. Install `python` dependency
    ```
    pip install -r utils/scripts/requirements.txt
    ```
1. Jalankan script python berikut
    ```
    python utils/scripts/update_bebras_task_collection.py
    ```
