import 'package:uts/models/budaya_model.dart';

class TariModel extends BudayaModel {
  String deskripsi;

  TariModel({
    required int id,
    required String judul,
    required String gambar,
    required String asalDaerah,
    required this.deskripsi,
  }) : super(id: id, judul: judul, gambar: gambar, asalDaerah: asalDaerah);

  factory TariModel.fromJson(Map<String, dynamic> json) {
    return TariModel(
      id: json['id'] ?? 0,
      judul: json['judul'] ?? '-',
      gambar: json['image'] ?? '-',
      asalDaerah: json['asal'] ?? '-',
      deskripsi: json['deskripsi'] ?? '-',
    );
  }
}
