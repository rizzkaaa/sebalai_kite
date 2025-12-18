import 'package:cloud_firestore/cloud_firestore.dart';

class SaranModel {
  final String? docId;
  final String idUser;
  final String message;
  final bool isReplyed;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SaranModel({
    this.docId,
    required this.idUser,
    required this.message,
    required this.isReplyed,
    this.createdAt,
    this.updatedAt,
  });

  factory SaranModel.fromJson(Map<String, dynamic> json) {
    return SaranModel(
      idUser: json['idUser'] ?? '-',
      message: json['message'] ?? '-',
      isReplyed: json['isReplyed'] ?? false,
    );
  }

  factory SaranModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SaranModel(
      docId: doc.id,
      idUser: data['idUser'] ?? '-',
      message: data['message'] ?? '-',
      isReplyed: data['isReplyed'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'message': message,
      'isReplyed': isReplyed,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'idUser': idUser,
      'message': message,
      'isReplyed': isReplyed,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
