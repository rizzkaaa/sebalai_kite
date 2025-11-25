import 'package:uts/models/budaya_model.dart';

class BajuModel extends BudayaModel {
  final String deskripsi;

  BajuModel({
    required int id,
    required String gambar,
    required String judul,
    required String asalDaerah,
    required this.deskripsi,
  }) : super(id: id, gambar: gambar, judul: judul, asalDaerah: asalDaerah);

  factory BajuModel.fromJson(Map<String, dynamic> json) {
    return BajuModel(
      id: json['id'] ?? 0,
      gambar: json['image'] ?? '-',
      judul: json['judul'] ?? '-',
      asalDaerah: json['asalDaerah'] ?? '-',
      deskripsi: json['deskripsi'] ?? '-',
    );
  }
}
