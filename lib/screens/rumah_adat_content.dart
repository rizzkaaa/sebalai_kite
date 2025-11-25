import 'package:flutter/material.dart';
import 'package:uts/widgets/card_tari_rumah.dart';
import 'package:uts/widgets/detail_rumah_pakaian.dart';
import 'package:uts/services/rumah_service.dart';
import 'package:uts/models/rumah_model.dart';

class RumahAdatContent extends StatefulWidget {
  const RumahAdatContent({super.key});

  @override
  State<RumahAdatContent> createState() => _RumahAdatContentState();
}

class _RumahAdatContentState extends State<RumahAdatContent> {
  final RumahService _service = RumahService();

  List<RumahModel> listRumahAdat = [];
  List<bool> likedList = [];
  List<bool> bookmarkList = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final data = await _service.fetchRumah();
      setState(() {
        listRumahAdat = data;
        likedList = List.generate(data.length, (_) => false);
        bookmarkList = List.generate(data.length, (_) => false);
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: listRumahAdat.asMap().entries.map((entry) {
            final index = entry.key;
            final rumah = entry.value;

            return CardTariRumah(
              item: {
                'id': rumah.id,
                'judul': rumah.judul,
                'image': rumah.gambar,
                'asal': rumah.asalDaerah,
                'deskripsi': rumah.deskripsi,
              },
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
                          item: {
                            'id': rumah.id,
                            'judul': rumah.judul,
                            'image': rumah.gambar,
                            'asal': rumah.asalDaerah,
                            'deskripsi': rumah.deskripsi,
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
  }
}
