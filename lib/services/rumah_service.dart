import 'dart:convert';
import 'package:uts/models/rumah_model.dart';
import 'package:flutter/services.dart';

class RumahService {
  static const String baseUrl = 'assets/data/rumah.json';

  Future<List<RumahModel>> fetchRumah() async {
    try {
      final response = await rootBundle.loadString(baseUrl);
      final data = json.decode(response) as List;
      final result = data.map((json) => RumahModel.fromJson(json)).toList();

      print('berhasil: $result, ${result.runtimeType}');
      return result;
    } catch (e) {
      throw Exception("Gagal Memuat Data: $e");
    }
  }
}
