import 'package:flutter/foundation.dart';
import 'package:uts/services/saran_service.dart';

class SaranController extends ChangeNotifier {
  final SaranService _service = SaranService();

  Stream<int> get countUnRead => _service.getCountUnRead();

  Stream<List<Map<String, dynamic>>> get saran => _service.getSaran();


  Future<void> markAllAsRead() async {
    await _service.markAllAsRead();
    notifyListeners();
  }

  Future<void> replySaran(String saranId, String userID) async {
    await _service.replySaran(saranId, userID);
    notifyListeners();
  }
  Future<void> deleteSaran(String saranId) async {
    await _service.deleteSaran(saranId);
    notifyListeners();
  }
}
