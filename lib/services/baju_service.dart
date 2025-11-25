import 'dart:convert';
import 'package:uts/models/baju_model.dart';
import 'package:flutter/services.dart';

class BajuService {
  static const String baseUrl = 'assets/data/baju.json';

  Future<List<BajuModel>> fetchBaju() async {
    try {
      final response = await rootBundle.loadString(baseUrl);
      final data = json.decode(response) as List;
      final result = data.map((json) => BajuModel.fromJson(json)).toList();

      print('berhasil: $result, ${result.runtimeType}');
      return result;
    } catch (e) {
      throw Exception("Gagal Memuat Data: $e");
    }
  }
}
