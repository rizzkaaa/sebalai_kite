import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uts/models/berita_model.dart';

class BeritaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createBerita(BeritaModel berita) async {
    try {
      final docRef = await _firestore.collection('berita').add({
        ...berita.toMap(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      print('✅ Berita berhasil ditambahkan dengan ID: ${docRef.id}');
      return docRef.id;
      
    } catch (e) {
      print('❌ Error create berita: $e');
      rethrow;
    }
  }

  Future<List<BeritaModel>> getAllBerita() async {
    try {
      final snapshot = await _firestore
          .collection('berita')
          .orderBy('createdAt', descending: true)
          .get();
      
      return snapshot.docs
          .map((doc) => BeritaModel.fromFirestore(doc))
          .toList();
          
    } catch (e) {
      print('❌ Error get all berita: $e');
      rethrow;
    }
  }

  Future<List<BeritaModel>> getLatestBerita() async {
    try {
      final snapshot = await _firestore
          .collection('berita')
          .orderBy('createdAt', descending: true)
          .limit(3)
          .get();
      
      return snapshot.docs
          .map((doc) => BeritaModel.fromFirestore(doc))
          .toList();
          
    } catch (e) {
      print('❌ Error get all berita: $e');
      rethrow;
    }
  }
  
  Future<List<BeritaModel>> searchBeritaByJudul(String query) async {
    try {
      if (query.isEmpty) {
        return await getLatestBerita();
      }

      final snapshot = await _firestore
          .collection('berita')
          .orderBy('createdAt', descending: true)
          .get();
      
      final results = snapshot.docs
          .map((doc) => BeritaModel.fromFirestore(doc))
          .where((berita) => berita.judul
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      
      return results;
          
    } catch (e) {
      print('❌ Error search berita: $e');
      rethrow;
    }
  }
  
  Future<void> updateBerita(String docId, BeritaModel berita) async {
    try {
      await _firestore.collection('berita').doc(docId).update({
        ...berita.toFirestore(),
      });
      
      print('✅ Berita berhasil diupdate');
      
    } catch (e) {
      print('❌ Error update berita: $e');
      rethrow;
    }
  }

  Future<void> deleteBerita(String docId) async {
    try {
      await _firestore.collection('berita').doc(docId).delete();
      print('✅ Berita berhasil dihapus');
      
    } catch (e) {
      print('❌ Error delete berita: $e');
      rethrow;
    }
  }

}