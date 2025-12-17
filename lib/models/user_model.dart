import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? docId;
  final String username;
  final String email;
  final String photo;
  final String role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.docId,
    required this.username,
    required this.email,
    required this.photo,
    required this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '-',
      email: json['email'] ?? '-',
      photo: json['photo'] ?? '-',
      role: json['role'] ?? '-',
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      docId: doc.id,
      username: data['username'] ?? '-',
      email: data['email'] ?? '-',
      photo: data['photo'] ?? '-',
      role: data['role'] ?? '-',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'photo': photo,
      'role': role,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'email': email,
      'photo': photo,
      'role': role,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
