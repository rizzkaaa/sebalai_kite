import 'package:cloud_firestore/cloud_firestore.dart';

class PengajuanModel {
  final String? docId;
  final String idUser;
  final String reason;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PengajuanModel({
    this.docId,
    required this.idUser,
    required this.reason,
    this.createdAt,
    this.updatedAt,
  });

  factory PengajuanModel.fromJson(Map<String, dynamic> json) {
    return PengajuanModel(
      idUser: json['idUser'] ?? '-',
      reason: json['reason'] ?? '-',
    );
  }

  factory PengajuanModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PengajuanModel(
      docId: doc.id,
      idUser: data['idUser'] ?? '-',
      reason: data['reason'] ?? '-',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'reason': reason,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'idUser': idUser,
      'reason': reason,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
