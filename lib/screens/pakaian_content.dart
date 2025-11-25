import 'package:flutter/material.dart';
import 'package:uts/models/baju_model.dart';
import 'package:uts/services/baju_service.dart';
import 'package:uts/widgets/card_baju_makan.dart';
import 'package:uts/widgets/detail_rumah_pakaian.dart';

class BajuAdatContent extends StatefulWidget {
  @override
  _BajuAdatContentState createState() => _BajuAdatContentState();
}

class _BajuAdatContentState extends State<BajuAdatContent> {
  late Future<List<BajuModel>> futureBaju;

  List<bool> likedList = [];
  List<bool> bookmarkList = [];

  @override
  void initState() {
    super.initState();
    futureBaju = BajuService().fetchBaju();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BajuModel>>(
      future: futureBaju,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Gagal memuat data",
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        final listBaju = snapshot.data!;

        if (likedList.isEmpty) {
          likedList = List.generate(listBaju.length, (_) => false);
          bookmarkList = List.generate(listBaju.length, (_) => false);
        }

        return SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: listBaju.asMap().entries.map((entry) {
                final index = entry.key;
                final baju = entry.value;

                return CardBajuMakan(
                  item: {
                    "id": baju.id,
                    "image": baju.gambar,
                    "judul": baju.judul,
                    "deskripsi": baju.deskripsi,
                    "asalDaerah": baju.asalDaerah,
                  },
                  liked: likedList[index],
                  onLike: () {
                    setState(() {
                      likedList[index] = !likedList[index];
                    });
                  },
                  bookmarked: bookmarkList[index],
                  onBookmark: () {
                    setState(() {
                      bookmarkList[index] = !bookmarkList[index];
                    });
                  },
                  action: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setStateDialog) {
                            return DetailRumahPakaian(
                              item: {
                                "id": baju.id,
                                "image": baju.gambar,
                                "judul": baju.judul,
                                "deskripsi": baju.deskripsi,
                                "asalDaerah": baju.asalDaerah,
                              },
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
      },
    );
  }
}
