import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String? docId;
  final String idUser;
  final int idTari;
  final double rating;
  final String deskripsi;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ReviewModel({
    this.docId,
    required this.idUser,
    required this.idTari,
    required this.rating,
    required this.deskripsi,
    this.createdAt,
    this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      idUser: json['idUser'] ?? '-',
      idTari: json['idTari'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      deskripsi: json['deskripsi'] ?? '-',
    );
  }

  factory ReviewModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ReviewModel(
      docId: doc.id,
      idUser: data['idUser'] ?? '-',
      idTari: data['idTari'] ?? 0,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      deskripsi: data['deskripsi'] ?? '-',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'idTari': idTari,
      'rating': rating,
      'deskripsi': deskripsi,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'idUser': idUser,
      'idTari': idTari,
      'rating': rating,
      'deskripsi': deskripsi,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
