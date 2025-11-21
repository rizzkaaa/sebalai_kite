import 'package:flutter/material.dart';
import 'package:uts/widgets/card_tari_rumah.dart';
import 'package:uts/widgets/detail_rumah_pakaian.dart';

class RumahAdatContent extends StatefulWidget {
  const RumahAdatContent({super.key});

  @override
  State<RumahAdatContent> createState() => _RumahAdatContentState();
}

class _RumahAdatContentState extends State<RumahAdatContent> {
  final List<Map<String, dynamic>> listRumahAdat = [
    {
      'id': 1,
      'judul': 'Rumah Limas',
      'image': 'assets/images/rumahLimas.jpeg',
      'asal': 'Bangka Tengah',
      'deskripsi':
          'Rumah Limas adalah rumah adat yang memiliki bentuk bertingkat seperti limas. Arsitekturnya mencerminkan status sosial pemilik dan biasa digunakan untuk acara adat. Terbuat dari kayu dengan ukiran khas, rumah ini menampilkan keindahan dan keanggunan budaya Melayu Bangka.',
    },
    {
      'id': 2,
      'judul': 'Rumah Rakit',
      'image': 'assets/images/rumahRakit.jpeg',
      'asal': 'Bangka Barat',
      'deskripsi':
          'Rumah Rakit merupakan rumah adat unik yang dibangun di atas rakit bambu dan mengapung di air. Rumah ini menjadi simbol kehidupan masyarakat pesisir Bangka yang bergantung pada sungai dan laut, serta menggambarkan adaptasi terhadap lingkungan perairan.',
    },
    {
      'id': 3,
      'judul': 'Rumah Panggung',
      'image': 'assets/images/rumahPanggung.jpeg',
      'asal': 'Belitung (Tanjung Pandan),\nBangka Selatan, dan\nBangka Tengah',
      'deskripsi':
          'Rumah Panggung adalah rumah adat yang dibangun di atas tiang tinggi dari kayu. Desainnya berfungsi untuk melindungi penghuni dari banjir dan binatang buas. Gaya rumah ini menunjukkan kearifan lokal masyarakat Bangka dalam menyesuaikan diri dengan kondisi alam sekitarnya.',
    },
  ];

  late List<bool> likedList;
  late List<bool> bookmarkList;

  @override
  void initState() {
    super.initState();
    likedList = List.generate(listRumahAdat.length, (index) => false);
    bookmarkList = List.generate(listRumahAdat.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: listRumahAdat.asMap().entries.map((entry) {
            final index = entry.key;
            final rumah = entry.value;

            return CardTariRumah(
              item: rumah,
              liked: likedList[index],
              onLike: () {
                setState(() {
                  likedList[index] = !likedList[index];
                });
              },
              action: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setStateDialog) {
                        return DetailRumahPakaian(
                          item: rumah,
                          liked: likedList[index],
                          bookmarked: bookmarkList[index],
                          onLike: () {
                            setStateDialog(() {
                              likedList[index] = !likedList[index];
                            });
                            setState(() {});
                          },
                          onBookmark: () {
                            setStateDialog(() {
                              bookmarkList[index] = !bookmarkList[index];
                            });
                            setState(() {});
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
