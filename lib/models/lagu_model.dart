import 'package:uts/models/budaya_model.dart';

class LaguModel extends BudayaModel {
  final String penyanyi;
  final String audio;

  LaguModel({
    required int id,
    required String gambar,
    required String judul,
    required String asalDaerah,
    required this.penyanyi,
    required this.audio,
  }) : super(id: id, gambar: gambar, judul: judul, asalDaerah: asalDaerah);

  factory LaguModel.fromJson(Map<String, dynamic> json) {
    return LaguModel(
      id: json['id'] ?? 0,
      gambar: json['gambar'] ?? '-',
      judul: json['judul'] ?? '-',
      asalDaerah: json['asalDaerah'] ?? '-',
      penyanyi: json['penyanyi'] ?? '-',
      audio: json['audio'] ?? '-',
    );
  }
}
