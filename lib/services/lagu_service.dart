import 'dart:convert';
import 'package:uts/models/lagu_model.dart';
import 'package:flutter/services.dart';

class LaguService {
  static const String baseUrl = 'assets/data/lagu.json';

  Future<List<LaguModel>> fetchLagu() async {
    try {
      final response = await rootBundle.loadString(baseUrl);
      final data = json.decode(response) as List;
      final result = data.map((json) => LaguModel.fromJson(json)).toList();

      print('berhasil: $result, ${result.runtimeType}');
      return result;
    } catch (e) {
      throw Exception("Gagal Memuat Data: $e");
    }
  }

  
}
