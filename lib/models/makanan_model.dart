import 'package:uts/models/budaya_model.dart';

class MakananModel extends BudayaModel {
  String deskripsi;
  String resep;

  MakananModel({
    required int id,
    required String gambar,
    required String judul,
    required String asalDaerah,
    required this.deskripsi,
    required this.resep,
  }) : super(id: id, gambar: gambar, judul: judul, asalDaerah: asalDaerah);

  factory MakananModel.fromJson(Map<String, dynamic> json) {
    return MakananModel(
      id: json['id'] ?? 0,
      gambar: json['image'] ?? '-',
      judul: json['judul'] ?? '-',
      asalDaerah: json['asalDaerah'] ?? '-',
      deskripsi: json['deskripsi'] ?? '-',
      resep: json['resep'] ?? '-',
    );
  }
}
