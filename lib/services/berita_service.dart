import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:uts/models/berita_model.dart';

class BeritaService {
  static const String baseUrl = 'assets/data/berita.json';

  Future<List<BeritaModel>> fetchBerita() async {
    try {
      final response = await rootBundle.loadString(baseUrl);
      final data = json.decode(response) as List;
      final result = data.map((json) => BeritaModel.fromJson(json)).toList();

      print('berhasil: $result, ${result.runtimeType}');
      return result;
    } catch (e) {
      throw Exception("Gagal Memuat Data: $e");
    }
  }

  Future<List<BeritaModel>> fetchLatestBerita() async {
    try {
      final allBerita = await fetchBerita();
      allBerita.sort((a, b) => b.id.compareTo(a.id));
      final latest = allBerita.take(3).toList();

      print('berhasil latest: $latest');
      return latest;
    } catch (e) {
      throw Exception("Gagal Memuat Data: $e");
    }
  }
}
