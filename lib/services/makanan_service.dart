import 'dart:convert';
import 'package:uts/models/makanan_model.dart';
import 'package:flutter/services.dart';

class MakananService {
  static const String baseUrl = 'assets/data/makanan.json';

  Future<List<MakananModel>> fetchMakanan() async {
    try {
      final response = await rootBundle.loadString(baseUrl);
      final data = json.decode(response) as List;
      final result = data.map((json) => MakananModel.fromJson(json)).toList();

      print('berhasil: $result, ${result.runtimeType}');
      return result;
    } catch (e) {
      throw Exception("Gagal Memuat Data: $e");
    }
  }
}
