import 'package:flutter/material.dart';
import 'package:uts/models/tari_model.dart';
import 'package:uts/services/tari_service.dart';
import 'package:uts/screens/detail_tari.dart';
import 'package:uts/widgets/card_tari_rumah.dart';

class TariContent extends StatefulWidget {
  const TariContent({super.key});

  @override
  State<TariContent> createState() => _TariContentState();
}

class _TariContentState extends State<TariContent> {
  final TariService service = TariService();

  List<TariModel> listTari = [];
  List<bool> likedList = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await service.fetchTari();

    setState(() {
      listTari = data;
      likedList = List.generate(listTari.length, (_) => false);
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: listTari.asMap().entries.map((entry) {
            final index = entry.key;
            final tari = entry.value;

            return CardTariRumah(
              item: {
                'id': tari.id,
                'judul': tari.judul,
                'image': tari.gambar,
                'asal': tari.asalDaerah,
                'deskripsi': tari.deskripsi,
              },
              liked: likedList[index],
              onLike: () {
                setState(() {
                  likedList[index] = !likedList[index];
                });
              },
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailTari(idTari: tari.id),
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