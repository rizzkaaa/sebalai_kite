import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _useRef = FirebaseFirestore.instance.collection('users');

  Future<QuerySnapshot> getUserByEmailAndPassword(
    String email,
    String password,
  ) async {
    final user = await _useRef
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

    return user;
  }

  Future<QuerySnapshot> getUserByUsernameAndEmail(
    String username,
    String email,
  ) async {
    final user = await _useRef
        .where('username', isEqualTo: username)
        .where('email', isEqualTo: email)
        .get();

    return user;
  }

  Future<void> addUser(
    String username,
    String email,
    String password,
  ) async {
    await _useRef.add({
      'username': username,
      'email': email,
      'password': password,
      'photo': '',
    });
  }
}
