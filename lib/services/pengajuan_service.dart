import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uts/models/pengajuan_model.dart';

class PengajuanService {
  final _firestore = FirebaseFirestore.instance;

  Stream<int> getCount() {
    return _firestore
        .collection('pengajuan')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Future<List<PengajuanModel>> getAllAjuan() async {
    final snapshot = await _firestore.collection("pengajuan").get();
    return snapshot.docs
        .map((doc) => PengajuanModel.fromFirestore(doc))
        .toList();
  }

  Future<bool> isUserInPengajuan(String idUser) async {
    final snapshot = await _firestore
        .collection('pengajuan')
        .where('idUser', isEqualTo: idUser)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<void> createPengajuan(String idUser, String reason) async {
    final pengajuanRef = _firestore.collection('pengajuan').doc();

    await pengajuanRef.set({
      'idUser': idUser,
      'reason': reason,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deletePengajuan(String idUser) async {
    try {
      final snapshot = await _firestore
          .collection('pengajuan')
          .where('idUser', isEqualTo: idUser)
          .get();

      if (snapshot.docs.isEmpty) return;

      final batch = _firestore.batch();

      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      print('Batch delete pengajuan berhasil');
    } catch (e) {
      print(e);
    }
  }
}
