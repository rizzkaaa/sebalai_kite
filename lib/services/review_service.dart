import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uts/models/review_model.dart';
import 'package:uts/services/notification_service.dart';

class ReviewService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NotificationService notifService = NotificationService();

  Future<String> createReview(ReviewModel review) async {
    try {
      final docRef = await _firestore.collection('review').add({
        ...review.toMap(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      print('✅ Review berhasil ditambahkan dengan ID: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      print('❌ Error create review: $e');
      rethrow;
    }
  }

  Future<List<ReviewModel>> getReviewByIDTari(int idTari) async {
    try {
      final snapshot = await _firestore
          .collection('review')
          .where('idTari', isEqualTo: idTari)
          .orderBy('createdAt', descending: true)
          .get();

      print('INI PANJANG DATA: ${snapshot.docs.length}');
      print('INI ID TARI: $idTari');
      return snapshot.docs
          .map((doc) => ReviewModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('❌ Error get all Review: $e');
      rethrow;
    }
  }

  Future<bool> hasReviewed(String idUser, int idTari) async {
    final snapshot = await _firestore
        .collection('review')
        .where('idUser', isEqualTo: idUser)
        .where('idTari', isEqualTo: idTari)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<void> deleteReview(String docId, String userID) async {
    print(userID);
    try {
      await _firestore.collection('review').doc(docId).delete();
      print('✅ Review berhasil dihapus');
      await notifService.createPersonalNotif(userID, 'warning');
    } catch (e) {
      print('❌ Error delete Review: $e');
      rethrow;
    }
  }
}
