import 'package:flutter/material.dart';
import 'package:uts/models/makanan_model.dart';
import 'package:uts/screens/detail_makan.dart';
import 'package:uts/services/makanan_service.dart';
import 'package:uts/widgets/card_baju_makan.dart';

class MakananKhasContent extends StatefulWidget {
  @override
  _MakananKhasContentState createState() => _MakananKhasContentState();
}

class _MakananKhasContentState extends State<MakananKhasContent> {
  final MakananService _service = MakananService();

  List<MakananModel> listMakanan = [];
  List<bool> likedList = [];
  List<bool> bookmarkList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await _service.fetchMakanan();

    setState(() {
      listMakanan = data;
      likedList = List.generate(data.length, (_) => false);
      bookmarkList = List.generate(data.length, (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return listMakanan.isEmpty
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: listMakanan.asMap().entries.map((entry) {
                  final index = entry.key;
                  final makan = entry.value;

                  return CardBajuMakan(
                    item: {
                      'id': makan.id,
                      'judul': makan.judul,
                      'image': makan.gambar,
                      'deskripsi': makan.deskripsi,
                      'resep': makan.resep,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMakan(data: makan),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          );
  }
}
