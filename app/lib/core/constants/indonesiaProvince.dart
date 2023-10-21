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

List<String> provinceList = [
  "Bali",
  "Banten",
  "Nanggroe Aceh Darussalam",
  "Sumatera Utara",
  "Sumatera Selatan",
  "Sumatera Barat",
  "Bengkulu",
  "Riau",
  "Kepulauan Riau",
  "Jambi",
  "Lampung",
  "Bangka Belitung",
  "Kalimantan Barat",
  "Kalimantan Timur",
  "Kalimantan Selatan",
  "Kalimantan Tengah",
  "Kalimantan Utara",
  "DKI Jakarta",
  "Jawa Barat",
  "Jawa Tengah",
  "DI Yogyakarta",
  "Jawa Timur",
  "Nusa Tenggara Timur",
  "Nusa Tenggara Barat",
  "Gorontalo",
  "Sulawesi Barat",
  "Sulawesi Tengah",
  "Sulawesi Utara",
  "Sulawesi Tenggara",
  "Sulawesi Selatan",
  "Maluku Utara",
  "Maluku",
  "Papua Barat",
  "Papua",
  "Papua Tengah",
  "Papua Pegunungan",
  "Papua Selatan",
  "Papua Barat Daya",
];

