import 'package:flutter/foundation.dart';
import 'package:uts/services/notification_service.dart';

class NotificationController extends ChangeNotifier {
  final NotificationService _service = NotificationService();

  Stream<int> get countUnRead => _service.getCountUnRead();

  Stream<List<Map<String, dynamic>>> get notifications => _service.getNotif();


  Future<void> markAllAsRead() async {
    await _service.markAllAsRead();
    notifyListeners();
  }

  Future<void> deleteNotification(String notificationId) async {
    await _service.deleteNotification(notificationId);
    notifyListeners();
  }
}
