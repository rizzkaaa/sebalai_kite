import 'dart:convert';
// import 'package:http/http.dart';
import 'package:uts/models/tari_model.dart';
import 'package:flutter/services.dart';

class TariService {
  static const String baseUrl = 'assets/data/tari.json';

  Future<List<TariModel>> fetchTari() async {
    try {
      final response = await rootBundle.loadString(baseUrl);
      final data = json.decode(response) as List;
      final result = data.map((json) => TariModel.fromJson(json)).toList();

      print('Berhasil: $result, ${result.runtimeType}');
      return result;
    } catch (e) {
      throw Exception("Gagal memuat data: $e");
    }
  }
}
