import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uts/services/notification_service.dart';

class SaranService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final NotificationService notifService = NotificationService();

  String? get userId => _auth.currentUser?.uid;

  Stream<int> getCountUnRead() {
    if (userId == null) return Stream.value(0);

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('saran')
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Stream<List<Map<String, dynamic>>> getSaran() {
    if (userId == null) {
      print("user tidak ada");
      return Stream.value([]);
    }

    print(userId);
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('saran')
        .orderBy('time', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
          List<Map<String, dynamic>> saran = [];
          print(snapshot.docs);

          for (var doc in snapshot.docs) {
            final data = doc.data();
            print('data $data');
            final saranDoc = await _firestore
                .collection('saran')
                .doc(data['idSaran'])
                .get();

            if (saranDoc.exists) {
              saran.add({
                'id': doc.id,
                'isRead': data['isRead'] ?? false,
                'time': data['time'],
                ...saranDoc.data()!,
              });
            }
            print('cek ${saranDoc.exists}');
          }

          print('saran: $saran');
          return saran;
        });
  }

  Future<void> markAllAsRead() async {
    if (userId == null) return;

    final batch = _firestore.batch();

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('saran')
        .where('isRead', isEqualTo: false)
        .get();

    for (var doc in snapshot.docs) {
      batch.update(doc.reference, {'isRead': true});
    }

    await batch.commit();
  }

  Future<void> createSaran(String idUser, String message) async {
    final saranRef = _firestore.collection('saran').doc();

    await saranRef.set({
      'idUser': idUser,
      'message': message,
      'isReplyed': false,
      'createdAt': FieldValue.serverTimestamp(),
    });

    final adminSnapshot = await _firestore
        .collection('users')
        .where('role', isEqualTo: 'admin')
        .get();

    final batch = _firestore.batch();

    for (var adminDoc in adminSnapshot.docs) {
      final adminSaranRef = _firestore
          .collection('users')
          .doc(adminDoc.id)
          .collection('saran')
          .doc(saranRef.id);

      batch.set(adminSaranRef, {
        'idSaran': saranRef.id,
        'isRead': false,
        'time': FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();
  }

  Future<void> replySaran(String saranID, String userID) async {
    print(saranID);
    await _firestore
        .collection('saran')
        .doc(saranID)
        .update({'isReplyed': true});
    await notifService.createPersonalNotif(userID, 'feedback');

  }

  Future<void> deleteSaran(String saranID) async {
    if (userId == null) return;

    print(saranID);
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('saran')
        .doc(saranID)
        .delete();
  }
}
