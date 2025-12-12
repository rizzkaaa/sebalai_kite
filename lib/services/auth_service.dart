import 'dart:io';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts/screens/auth_screen.dart';
import 'package:uts/screens/user_profile_screen.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _userRef = FirebaseFirestore.instance.collection('users');

  Future<String?> register(
    String username,
    String email,
    String password,
  ) async {
    final userCheck = await _userRef
        .where("username", isEqualTo: username)
        .limit(1)
        .get();

    if (userCheck.docs.isNotEmpty) {
      return "Username sudah digunakan";
    }

    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _userRef.doc(cred.user!.uid).set({
        "username": username,
        "email": email,
        "photo": "",
        "role": "user",
      });
      print("Register berhasil");
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "Email sudah digunakan";
      } else if (e.code == 'invalid-email') {
        return "Email tidak valid";
      } else {
        return e.message;
      }
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Email belum terdaftar";
      } else if (e.code == 'wrong-password') {
        return "Password salah";
      } else {
        return "Login gagal: ${e.message}";
      }
    }
  }

  Future<DocumentSnapshot> getProfile() async {
    final uid = _auth.currentUser!.uid;

    final doc = await _userRef.doc(uid).get();
    final role = doc["role"];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', uid);
    await prefs.setString('userLevel', role);

    return doc;
  }

  Future<void> updateProfile({
    required String username,
    required String email,
    String? oldPassword,
    String? newPassword,
  }) async {
    final user = _auth.currentUser;

    if (user == null) throw Exception("User belum login");

    if (email != user.email) {
      await user.verifyBeforeUpdateEmail(email);
    }

    if (newPassword != null && newPassword.isNotEmpty) {
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword ?? "",
      );

      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);
    }

    await _userRef.doc(user.uid).update({"username": username, "email": email});
  }

  Future<String?> uploadPhoto(File image) async {
    try {
    final uid = _auth.currentUser!.uid;
    
    final bytes = await image.readAsBytes();
    
    final base64Image = base64Encode(bytes);
    
    await _userRef.doc(uid).update({
      "photo": base64Image,
    });
    print("✅ Photo saved to Firestore!");
    return base64Image;
  } catch (e) {
    print("❌ UPLOAD ERROR: $e");
    return null;
  }
  }

  Future<void> logout() => _auth.signOut();

  Widget toAccountPage() {
    final user = _auth.currentUser;
    if (user != null) {
      return const UserProfileScreen();
    } else {
      return const AuthScreen();
    }
  }
}
