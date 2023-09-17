# 🦫 Bebras Pandai

### Repositori ini berisi kumpulan *script* yang digunakan untuk menunjang [Tantangan Bebras Indonesia](#tantangan-bebras-indonesia) & [Gerakan Pandai](#gerakan-pandai)
## Aplikasi
`Bebras Pandai` adalah aplikasi yang dikembangkan oleh [IA-TOKI](https://alumni.toki.id/category/ikatan-alumni/) untuk mendukung pembelajaran *[Computational Thinking](https://bebras.or.id/v3/apa-itu-berpikir-komputasional/)* supaya lebih tersebar luas ke seluruh pelosok Indonesia. 🇮🇩🇮🇩🇮🇩

Silahkan menuju [app](app) untuk mengakses direktori utama aplikasi.

<br>

<div style="display:inline-block">
    <a><img alt="" src="https://github.com/ia-toki/bebras-pandai/raw/docs/readme/docs/assets/bebras-app-demo-removebg-preview.png" style="float:left; width:170px"></a><br />
<!--
    <a href='' style="margin-left:-11px"><img alt="" src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" style="width:200px"></a><br />
    <a href=''><img alt="" src="https://user-images.githubusercontent.com/24459435/172480740-d70aff84-fcb6-4f4a-bbd1-a3e2fa58f3a9.svg" style="width:165px"></a>
-->
</div>

### Pengembangan Perangkat Lunak

#### Struktur Direktori
Kita menggunakan arsitektur *monorepo* di repositori ini. Selain `app` sebagai direktori utama, terdapat bagian-bagian lain untuk mempermudah/mengotomatisasi operasional.
```
.
├── .github              # github related script
├── app                  # main app directory
├── data                 # data for mockup, schema, etc
|   ├── ..
|   ├── materials        # materials metadata like buku bebras, podcast files, presentations, etc
│   └── question_bank    # problem set data
├── docs                 # contains any documentation & its supporting files
|   ├── ..
│   └── assets           # image file et al. used in the documentation
└── utils                # utility tools directory
    ├── ..
    └── scripts          # any script to automate the operational
```

#### Kontribusi
Silahkan menuju [CONTRIBUTING.md](docs/CONTRIBUTING.md) mengenai penjelasan cara berkontribusi.
#### Kontributor
<a href = "https://github.com/ia-toki/bebras-pandai/graphs/contributors">
    <img src = "https://contrib.rocks/image?repo=ia-toki/bebras-pandai"/>
</a>

<br>

## Glosarium

### Tantangan Bebras Indonesia
tautan: https://bebras.or.id/v3/ \
<img src="https://pandai.bebras.or.id/img/bebrasIndo.039c5a0c.png" alt="alt text" width=170>

Tantangan Bebras Indonesia adalah kompetisi yang dilaksanakan secara online dan serentak dengan memberikan soal-soal yang telah dipersiapkan dalam [Workshop Bebras Internasional](https://www.bebras.org/workshops.html), pada periode bebras week di minggu kedua bulan November. \
Tantangan Bebras Indonesia dibagi dalam 4 kategori, yaitu:
- `siKecil`, untuk siswa SD dan yang sederajat kelas 3 atau lebih muda
- `Siaga`, untuk siswa SD dan yang sederajat kelas 4-6
- `Penggalang`, untuk siswa SMP dan yang sederajat
- `Penegak`, untuk siswa SMA dan yang sederajat

> [!NOTE]
> ##### Bagaimana cara ikut serta pada Tantangan Bebras?
> Sekolah mendaftarkan siswanya pada Biro bebras yang daftar dan kontaknya dapat diakses di http://bebras.or.id/v3/bebras-biro/

<br>

### Gerakan Pandai
tautan: https://pandai.bebras.or.id/ \
<img src="https://pandai.bebras.or.id/img/logogerpan.a2d95a8f.png" alt="alt text" style="margin-top:10px; width:150px">

Kegiatan yang dilaksanakan oleh Bebras Indonesia dengan dukungan [google.org](https://www.google.org/) untuk menebarkan dan mengajarkan penguasaan `Computational Thinking` kepada 2 juta siswa, melalui 22.000 guru berbagai mapel di 22 daerah di Indonesia.

<br>

## Lisensi
Karya ini dilisensikan di bawah [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/) \
[![CC BY-NC-SA 4.0](https://licensebuttons.net/i/l/by-nc-sa/transparent/99/99/99/88x31.png)](https://creativecommons.org/licenses/by-nc-sa/4.0/) \
Hal ini berarti Anda bebas untuk menggunakan dan mendistribusikan karya ini, dengan ketentuan:
- `Attribution`: Apabila Anda menggunakan materi-materi pada karya ini, Anda harus memberikan kredit dengan mencantumkan sumber dari materi yang Anda gunakan.
- `NonCommercial`: Anda tidak boleh menggunakan karya ini untuk keperluan komersial, seperti menjual ulang karya ini.
- `ShareAlike`: Apabila Anda mengubah atau membuat turunan dari materi-materi pada karya ini, Anda harus menyebarluaskan kontribusi Anda di bawah lisensi yang sama dengan karya asli.

<br>

## Didukung Oleh

<img src="https://avatars.githubusercontent.com/u/11017218" alt="IA TOKI" width=60>

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Logo_of_Ministry_of_Education_and_Culture_of_Republic_of_Indonesia.svg/800px-Logo_of_Ministry_of_Education_and_Culture_of_Republic_of_Indonesia.svg.png" alt="Kementerian Pendidikan, Kebudayaan, Riset, dan Teknologi Republik Indonesia" width=60>

<img src="https://www.bebras.org/sites/all/themes/bebrasorgtheme/img/vu-logo.png" alt="Bebras Internasinal" width=60>

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Google_org_logo.svg/1260px-Google_org_logo.svg.png" alt="Google.org" width=130>
