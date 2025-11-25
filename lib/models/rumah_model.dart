import 'package:uts/models/budaya_model.dart';

class RumahModel extends BudayaModel {
  String deskripsi;

  RumahModel({
    required int id,
    required String gambar,
    required String judul,
    required String asalDaerah,
    required this.deskripsi,
  }) : super(id: id, gambar: gambar, judul: judul, asalDaerah: asalDaerah);

  factory RumahModel.fromJson(Map<String, dynamic> json) {
    return RumahModel(
      id: json['id'] ?? 0,
      gambar: json['image'] ?? '-',
      judul: json['judul'] ?? '-',
      asalDaerah: json['asal'] ?? '-',
      deskripsi: json['deskripsi'] ?? '-',
    );
  }
}
