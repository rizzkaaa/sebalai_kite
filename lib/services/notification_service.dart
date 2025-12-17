import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? get userId => _auth.currentUser?.uid;

  Stream<int> getCountUnRead() {
    if (userId == null) return Stream.value(0);

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Stream<List<Map<String, dynamic>>> getNotif() {
    if (userId == null) {
      print("user tidak ada");
      return Stream.value([]);
    }

    print(userId);
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .orderBy('time', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
          List<Map<String, dynamic>> notifications = [];

          for (var doc in snapshot.docs) {
            final data = doc.data();
            print(data);
            final notifDoc = await _firestore
                .collection('notification')
                .doc(data['notifID'])
                .get();

            if (notifDoc.exists) {
              notifications.add({
                'id': doc.id,
                'isRead': data['isRead'] ?? false,
                'time': data['time'],
                ...notifDoc.data()!,
              });
            }
            print(notifDoc.exists);
          }

          print(notifications);
          return notifications;
        });
  }

  Future<void> markAllAsRead() async {
    if (userId == null) return;

    final batch = _firestore.batch();

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .where('isRead', isEqualTo: false)
        .get();

    for (var doc in snapshot.docs) {
      batch.update(doc.reference, {'isRead': true});
    }

    await batch.commit();
  }

  Future<void> createNotification({
    required String title,
    required String message,
    String? beritaID,
  }) async {
    final notifRef = _firestore.collection('notification').doc();

    await notifRef.set({
      'title': title,
      'message': message,
      'beritaID': beritaID ?? '',
    });

    final usersSnapshot = await _firestore.collection('users').get();

    final batch = _firestore.batch();

    for (var userDoc in usersSnapshot.docs) {
      final userNotifRef = _firestore
          .collection('users')
          .doc(userDoc.id)
          .collection('notifications')
          .doc(notifRef.id);

      batch.set(userNotifRef, {
        'notifID': notifRef.id,
        'isRead': false,
        'time': FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();
  }

  Future<void> createPersonalNotif(String userID, String type) async {
    String? notifID;
    final String welcome = "hDS35w3BI2Cr440zSlVk";
    final String feedback = "qxjNU8sX1tgFwVGLLru3";
    final String warning = "nW5VxQ24QjT5WZSbJRQl";

    if (type == 'welcome') {
      notifID = welcome;
    } else if (type == 'feedback') {
      notifID = feedback;
    } else if (type == 'warning') {
      notifID = warning;
    } else {
      print('type tidak valid');
      return;
    }

    print(notifID);
    print(userID);
    try {
      await _firestore
          .collection('users')
          .doc(userID)
          .collection('notifications')
          .add({
            'notifID': notifID,
            'isRead': false,
            'time': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteNotification(String notifID) async {
    if (userId == null) return;

    print(notifID);
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .doc(notifID)
        .delete();
  }
}
