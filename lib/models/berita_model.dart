class BeritaModel {
  final int id;
  final String image;
  final String judul;
  final String tanggal;
  final List<String> paragraf;
  final String deskripsi;

  BeritaModel({
    required this.id,
    required this.image,
    required this.judul,
    required this.tanggal,
    required this.paragraf,
    required this.deskripsi,
  });

  factory BeritaModel.fromJson(Map<String, dynamic> json) {
    return BeritaModel(
      id: json['id'] ?? 0,
      image: json['image'] ?? '-',
      judul: json['judul'] ?? '-',
      tanggal: json['tanggal'] ?? '-',
      paragraf: List<String>.from(json['paragraf'] ?? []),
      deskripsi: json['deskripsi'] ?? '-',
    );
  }
}