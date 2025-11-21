import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/widgets/card_berita.dart';

class BeritaContent extends StatelessWidget {
  final List<Map<String, dynamic>> listBerita = [
    {
      'tanggal': 'Berita Hari Ini',
      'item': [
        {
          'id': 1,
          'judul':
              "Festival Tari Campak Meriahkan Peringatan Hari Budaya Bangka",
          'image': "assets/images/tari/tari-campak.jpg",
          'deskripsi':
              "Festival tahunan ini menghadirkan penampilan dari berbagai sanggar seni di Pulau Bangka. Tari Campak, simbol keceriaan masyarakat Melayu Bangka, kembali memukau penonton lokal dan wisatawan.",
        },
      ],
    },
    {
      'tanggal': '21 Oktober 2025',
      'item': [
        {
          'id': 2,
          'judul': "Tradisi Nganggung, Simbol Kebersamaan Masyarakat Bangka",
          'image': "assets/images/tradisiNganggung.png",
          'deskripsi':
              "Festival tahunan ini menghadirkan penampilan dari berbagai sanggar seni di Pulau Bangka. Tari Campak, simbol keceriaan masyarakat Melayu Bangka, kembali memukau penonton lokal dan wisatawan.",
        },
        {
          'id': 3,
          'judul': "Upacara Maras Taun, Syukur atas Hasil Panen",
          'image': "assets/images/marasTaun.png",
          'deskripsi':
              "Tradisi tahunan ini digelar untuk mengungkapkan rasa syukur kepada Tuhan atas hasil bumi yang melimpah dan memohon keberkahan di tahun berikutnya.",
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: listBerita.map((grupBerita) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  grupBerita['tanggal']!,
                  style: GoogleFonts.judson(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF77426A)
                  ),
                ),
                Column(
                  children: (grupBerita['item'] as List).map((item) {
                    return CardBerita(berita: item);
                  }).toList(),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
