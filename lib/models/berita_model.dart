import 'package:cloud_firestore/cloud_firestore.dart';

class BeritaModel {
  final String? docId;
  final int id;
  final String image;
  final String judul;
  final String tanggal;
  final List<String> paragraf;
  final String deskripsi;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BeritaModel({
    this.docId,
    required this.id,
    required this.image,
    required this.judul,
    required this.tanggal,
    required this.paragraf,
    required this.deskripsi,
    this.createdAt,
    this.updatedAt,
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

  factory BeritaModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BeritaModel(
      docId: doc.id,
      id: data['id'] ?? 0,
      image: data['image'] ?? '-',
      judul: data['judul'] ?? '-',
      tanggal: data['tanggal'] ?? '-',
      paragraf: List<String>.from(data['paragraf'] ?? []),
      deskripsi: data['deskripsi'] ?? '-',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'judul': judul,
      'tanggal': tanggal,
      'paragraf': paragraf,
      'deskripsi': deskripsi,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'image': image,
      'judul': judul,
      'tanggal': tanggal,
      'paragraf': paragraf,
      'deskripsi': deskripsi,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
