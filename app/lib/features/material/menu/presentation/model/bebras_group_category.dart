class BebrasGroupCategory {
  final int index;
  final String key;
  final String label;

  const BebrasGroupCategory(
    this.index,
    this.key,
    this.label,
  );
}

List<BebrasGroupCategory> bebrasGroupList = [
  const BebrasGroupCategory(0, 'umum', 'Umum'),
  const BebrasGroupCategory(1, 'sikecil', 'siKecil'),
  const BebrasGroupCategory(2, 'siaga', 'Siaga'),
  const BebrasGroupCategory(3, 'penggalang', 'Penggalang'),
  const BebrasGroupCategory(4, 'penegak', 'Penegak'),
];
