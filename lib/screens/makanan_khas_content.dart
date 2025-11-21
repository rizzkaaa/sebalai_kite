import 'package:flutter/material.dart';
import 'package:uts/screens/detail_makan.dart';
import 'package:uts/widgets/card_baju_makan.dart';

class MakananKhasContent extends StatefulWidget {
  @override
  _MakananKhasContentState createState() => _MakananKhasContentState();
}

class _MakananKhasContentState extends State<MakananKhasContent> {
  final List<Map<String, dynamic>> listMakanan = [
    {
      'id': 1,
      'judul': 'Lempah Kuning',
      'image': 'assets/images/lempahKuning.jpeg',
      'deskripsi':
          'Lempah Kuning adalah masakan tradisional khas Bangka Belitung yang terkenal dengan cita rasa asam pedas segar dan khas. Nama "Lempah" berasal dari bahasa lokal yang berarti berkuah, sedangkan "kuning" dari warna kuahnya yang cerah karena penggunaan kunyit.',
      'resep': '''Resep Lempah Kuning Khas Bangka Belitung

Bahan Utama:
- 500 gram ikan (biasanya ikan tongkol, kakap, atau ikan laut segar)
- 1 liter air
- 2 lembar daun jeruk
- 1 batang serai, memarkan
- 1 potong nanas (untuk rasa asam kecil, opsional, untuk rasa asam segar)
- 2 buah asam kandis atau 1 sdm air asam jawa
- Garam dan gula secukupnya

Bumbu Halus:
- 5 siung bawang merah
- 3 siung bawang putih
- 3 cm kunyit (atau 1 sdt bubuk kunyit, jika lebih berwarna)
- 5 buah cabai merah keriting (sesuaikan tingkat pedasnya)
- 3 buah kemiri, sangrai
- 1 cm terasi bakar (opsional)
- Sedikit terasi bakar (optional, khas Bangka Bangsei)

Cara Memasak:
1. Haluskan semua bumbu hingga lembut (bisa diuleg atau blender).
2. Tumis bumbu halus dengan sedikit minyak hingga harum dan matang.
3. Masukkan serai dan daun jeruk, aduk sebentar hingga wangi.
4. Tuangkan air (sekitar 1 liter) biarkan mendidih.
5. Tambahkan asam kandis atau nanas, garam, dan gula secukupnya.
6. Masukkan ikan, masak dengan api sedang hingga ikan matang dan kuah sedikit meresap.
7. Koreksi rasa, pastikan ada keseimbangan pedas, asam, dan gurih.
8. Angkat dan sajikan selagi hangat dengan nasi putih.''',
    },
    {
      'id': 2,
      'judul': 'Mie Bangka',
      'image': 'assets/images/mieBangka.jpeg',
      'deskripsi':
          'Mie Bangka adalah kuliner legendaris dari Pulau Bangka yang terkenal dengan mie kuning kenyal, disajikan dengan topping ayam cincang, tauge, bakso, dan kuah kaldu gurih. Ciri khasnya adalah penggunaan minyak bawang putih dan kecap asin khas Bangka, membuat cita rasanya gurih dan wangi.',
      'resep': '''Resep Mie Bangka Khas Bangka Belitung

Untuk Mie:
- 200 gram mie basah (mie kuning)
- 1 sdm minyak bawang putih
- 1 sdt kecap asin

Untuk Topping Ayam:
- 150 gram dada ayam cincang
- 2 siung bawang putih (haluskan)
- 1 sdm kecap asin
- 1 sdm kecap manis
- Garam, lada, gula secukupnya

Untuk Kuah:
- 500 ml air kaldu ayam
- 2 siung bawang putih (geprek)
- Daun bawang & seledri

Cara Membuat:
1. Rebus mie hingga matang, tiriskan. Campur dengan minyak bawang putih dan kecap asin.
2. Tumis bawang putih, masukkan ayam cincang, tambahkan kecap asin, kecap manis, garam, dan gula. Tumis hingga matang.
3. Rebus air kaldu, tambahkan daun bawang dan bawang putih geprek.
4. Sajikan mie, tambahkan ayam tumis di atasnya, siram dengan kuah, dan beri pelengkap seperti tauge & bakso.''',
    },
    {
      'id': 3,
      'judul': 'Lakso Bangka',
      'image': 'assets/images/lakso.jpeg',
      'deskripsi':
          'Lakso adalah makanan khas Bangka yang mirip dengan lontong sayur atau laksa, tapi punya ciri khas tersendiri — kuah santan gurih berwarna kuning, dengan mie tebal berbahan sagu atau tepung beras. Biasanya disajikan dengan taburan bawang goreng, daun seledri, dan sambal pedas. Rasanya gurih, lembut, dan wangi santan berpadu rempah-rempah seperti kunyit dan serai.',
      'resep': '''Resep Lakso Bangka Khas Bangka Belitung

Untuk Lakso:
- 250 gram tepung beras
- 50 gram tepung sagu
- 500 ml air mendidih
- 1 sdt garam

Untuk Kuah:
- 500 ml santan kental
- 2 batang serai (memarkan)
- 3 lembar daun salam
- 1 ruas lengkuas (memarkan)
- 2 sdm minyak goreng

Bumbu Halus:
- 5 butir bawang merah
- 3 siung bawang putih
- 2 cm kunyit
- 1 sdt ketumbar
- 1/2 sdt merica
- Garam & gula secukupnya

Cara Membuat:
1. Campur tepung beras, tepung sagu, dan garam. Tuang air panas sedikit demi sedikit sambil diaduk hingga kalis.
2. Masukkan adonan ke cetakan lakso (bisa pakai plastik segitiga). Rebus di air mendidih hingga mengapung, angkat, tiriskan.
3. Tumis bumbu halus dengan minyak, masukkan daun salam, serai, dan lengkuas.
4. Tambahkan santan, aduk hingga mendidih.
5. Sajikan lakso dengan kuah santan dan taburi bawang goreng.''',
    },
    {
      'id': 4,
      'judul': 'Sambel Lingkung',
      'image': 'assets/images/sambelLingkung.jpeg',
      'deskripsi':
          'Sambal Lingkung adalah abon ikan khas Bangka Belitung — teksturnya halus seperti serundeng tapi terbuat dari ikan laut, biasanya ikan tenggiri atau ikan gabus. Rasanya gurih, pedas, dan kaya rempah. Dulu makanan ini dibuat sebagai bekal tahan lama untuk pelaut atau acara adat.',
      'resep': '''Resep Sambal Lingkung Khas Bangka Belitung

Bahan Utama:
- 500 gram ikan tenggiri (kukus, ambil dagingnya, suwir halus)
- 200 ml santan kental
- 6 siung bawang merah
- 3 siung bawang putih
- 5 buah cabai merah (sesuai selera)
- 1 ruas jahe
- 1 ruas lengkuas
- 1 batang serai (memarkan)
- Garam, gula merah, dan asam jawa secukupnya

Cara Membuat:
1. Haluskan bawang, cabai, jahe, dan lengkuas.
2. Tumis bumbu hingga harum, lalu tambahkan santan dan serai.
3. Masukkan ikan suwir, aduk terus di atas api kecil sampai kering dan berwarna kecokelatan.
4. Aduk terus supaya tidak gosong — prosesnya sekitar 1–1,5 jam.
5. Setelah kering, dinginkan dan simpan di wadah tertutup.''',
    },
  ];

  late List<bool> likedList;
  late List<bool> bookmarkList;

  @override
  void initState() {
    super.initState();
    likedList = List.generate(listMakanan.length, (index) => false);
    bookmarkList = List.generate(listMakanan.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: listMakanan.asMap().entries.map((entry) {
            final index = entry.key;
            final makan = entry.value;
            return CardBajuMakan(
              item: makan,
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
                    builder: (context) => DetailMakan(idMakan: makan['id']),
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
