class IndonesiaProvince {
  String provinceName;
  String valueProvince;
  bool isActive;

  IndonesiaProvince({
    required this.provinceName,
    required this.valueProvince,
    this.isActive = true,
  });

  String userAsString() {
    return this.provinceName;
  }
}

List<IndonesiaProvince> provinceList = [
  IndonesiaProvince(provinceName: "Bali", valueProvince: "bali", isActive: true,),
  IndonesiaProvince(provinceName: "Banten", valueProvince: "banten", isActive: true,),
  IndonesiaProvince(provinceName: "Nanggroe Aceh Darussalam", valueProvince: "nanggroe_aceh_darussalam", isActive: true,),
  IndonesiaProvince(provinceName: "Sumatera Utara", valueProvince: "sumatera_utara", isActive: true,),
  IndonesiaProvince(provinceName: "Sumatera Selatan", valueProvince: "sumatera_selatan", isActive: true,),
  IndonesiaProvince(provinceName: "Sumatera Barat", valueProvince: "sumatera_barat", isActive: true,),
  IndonesiaProvince(provinceName: "Bengkulu", valueProvince: "bengkulu", isActive: true,),
  IndonesiaProvince(provinceName: "Riau", valueProvince: "riau", isActive: true,),
  IndonesiaProvince(provinceName: "Kepulauan Riau", valueProvince: "kepulauan_riau", isActive: true,),
  IndonesiaProvince(provinceName: "Jambi", valueProvince: "jambi", isActive: true,),
  IndonesiaProvince(provinceName: "Lampung", valueProvince: "lampung", isActive: true,),
  IndonesiaProvince(provinceName: "Bangka Belitung", valueProvince: "bangka_belitung", isActive: true,),
  IndonesiaProvince(provinceName: "Kalimantan Barat", valueProvince: "kalimantan_barat", isActive: true,),
  IndonesiaProvince(provinceName: "Kalimantan Timur", valueProvince: "kalimantan_timur", isActive: true,),
  IndonesiaProvince(provinceName: "Kalimantan Selatan", valueProvince: "kalimantan_selatan", isActive: true,),
  IndonesiaProvince(provinceName: "Kalimantan Tengah", valueProvince: "kalimantan_tengah", isActive: true,),
  IndonesiaProvince(provinceName: "Kalimantan Utara", valueProvince: "kalimantan_utara", isActive: true,),
  IndonesiaProvince(provinceName: "DKI Jakarta", valueProvince: "dki_jakarta", isActive: true,),
  IndonesiaProvince(provinceName: "Jawa Barat", valueProvince: "jawa_barat", isActive: true,),
  IndonesiaProvince(provinceName: "Jawa Tengah", valueProvince: "jawa_tengah", isActive: true,),
  IndonesiaProvince(provinceName: "DI Yogyakarta", valueProvince: "daerah_istimewa_yogyakarta", isActive: true,),
  IndonesiaProvince(provinceName: "Jawa Timur", valueProvince: "jawa_timur", isActive: true,),
  IndonesiaProvince(provinceName: "Nusa Tenggara Timur", valueProvince: "nusa_tenggara_timur", isActive: true,),
  IndonesiaProvince(provinceName: "Nusa Tenggara Barat", valueProvince: "nusa_tenggara_barat", isActive: true,),
  IndonesiaProvince(provinceName: "Gorontalo", valueProvince: "gorontalo", isActive: true,),
  IndonesiaProvince(provinceName: "Sulawesi Barat", valueProvince: "sulawesi_barat", isActive: true,),
  IndonesiaProvince(provinceName: "Sulawesi Tengah", valueProvince: "sulawesi_tengah", isActive: true,),
  IndonesiaProvince(provinceName: "Sulawesi Utara", valueProvince: "sulawesi_utara", isActive: true,),
  IndonesiaProvince(provinceName: "Sulawesi Tenggara", valueProvince: "sulawesi_tenggara", isActive: true,),
  IndonesiaProvince(provinceName: "Sulawesi Selatan", valueProvince: "sulawesi_selatan", isActive: true,),
  IndonesiaProvince(provinceName: "Maluku Utara", valueProvince: "maluku_utara", isActive: true,),
  IndonesiaProvince(provinceName: "Maluku", valueProvince: "maluku", isActive: true,),
  IndonesiaProvince(provinceName: "Papua Barat", valueProvince: "papua_barat", isActive: true,),
  IndonesiaProvince(provinceName: "Papua", valueProvince: "papua", isActive: true,),
  IndonesiaProvince(provinceName: "Papua Tengah", valueProvince: "papua_tengah", isActive: true,),
  IndonesiaProvince(provinceName: "Papua Pegunungan", valueProvince: "papua_pegunungan", isActive: true,),
  IndonesiaProvince(provinceName: "Papua Selatan", valueProvince: "papua_selatan", isActive: true,),
  IndonesiaProvince(provinceName: "Papua Barat Daya", valueProvince: "papua_barat_daya", isActive: true,),
];

