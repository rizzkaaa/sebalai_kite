import 'package:flutter/material.dart';
import 'package:uts/widgets/card_baju_makan.dart';
import 'package:uts/widgets/detail_rumah_pakaian.dart';

class BajuAdatContent extends StatefulWidget {
  @override
  _BajuAdatContentState createState() => _BajuAdatContentState();
}

class _BajuAdatContentState extends State<BajuAdatContent> {
  final List<Map<String, dynamic>> listBajuAdat = [
    {
      'id': 1,
      'image': 'assets/images/bajuPaksian.jpeg',
      'judul': 'Baju Paksian',
      'deskripsi':
          'Baju Paksian merupakan pakaian adat tradisional khas Provinsi Bangka Belitung yang biasanya dikenakan oleh pengantin perempuan pada upacara pernikahan.\n\n'
          'Ciri khas utamanya terletak pada mahkota besar berwarna emas yang disebut Paksian, melambangkan kemuliaan dan keanggunan wanita Melayu Bangka Belitung.\n\n'
          'Busananya terdiri atas baju kebaya panjang berwarna hijau tua atau emas, kain songket dengan motif khas daerah, serta berbagai perhiasan emas seperti kalung, gelang, dan pending.\n\n'
          'Makna filosofinya adalah kemewahan, kehormatan, dan keseimbangan hidup, mencerminkan karakter masyarakat Bangka Belitung yang ramah dan menjunjung tinggi nilai tradisi leluhur.',
      'isFavorite': false,
      'isBookmarked': false,
    },
    {
      'id': 2,
      'image': 'assets/images/bajuKurung Merah.jpeg',
      'judul': 'Baju Kurung\nTanggung (Merah)',
      'deskripsi':
          'Baju Kurung Tanggung merupakan pakaian adat kebanggaan masyarakat Bangka Belitung, dikenakan oleh pria dan wanita dalam berbagai upacara adat dan perayaan resmi, termasuk pernikahan dan acara budaya.\n\n'
          'Warna merah pada baju ini melambangkan keberanian, semangat, dan kekuatan hati masyarakat Melayu Bangka.\n\n'
          'Potongan baju kurung tanggung memiliki lengan tiga perempat (tanggung) dan dipadukan dengan kain songket berwarna senada, penutup kepala khas, serta selendang atau pending di bagian pinggang.\n\n'
          'Selain sebagai simbol keanggunan, busana ini juga mencerminkan identitas sosial dan kebanggaan terhadap warisan budaya daerah.',
      'isFavorite': false,
      'isBookmarked': false,
    },
    {
      'id': 3,
      'image': 'assets/images/BajuKurungBiru.jpeg',
      'judul': 'Baju Kurung\nTanggung (Biru)',
      'deskripsi':
          'Baju Kurung Tanggung berwarna biru sering dipakai oleh pejabat adat, penari, atau peserta upacara resmi di Bangka Belitung.\n\n'
          'Warna biru menggambarkan ketenangan, kesetiaan, dan keharmonisan hidup masyarakat pesisir yang dekat dengan laut.\n\n'
          'Desainnya menonjolkan kesederhanaan namun tetap elegan, dengan detail bordir atau songket di bagian kerah dan tangan.\n\n'
          'Busana ini menjadi simbol kerendahan hati dan kedamaian, sekaligus wujud penghormatan terhadap nilai-nilai budaya Melayu dan semangat persaudaraan antarwarga Bangka Belitung.',
      'isFavorite': false,
      'isBookmarked': false,
    },
    {
      'id': 4,
      'image': 'assets/images/BajuKurungUngu.jpeg',
      'judul': 'Baju Kurung\nTanggung (Ungu)',
      'deskripsi':
          'Baju Kurung Tanggung berwarna ungu adalah variasi modern yang sering digunakan dalam acara pertunjukan budaya, festival, dan kegiatan resmi daerah.\n\n'
          'Warna ungu melambangkan keanggunan, kebijaksanaan, dan wibawa, menjadikannya pilihan favorit bagi generasi muda dalam menampilkan sisi tradisional yang tetap modis.\n\n'
          'Strukturnya tetap mempertahankan bentuk asli baju kurung tanggung dengan potongan lengan sedang, dipadukan dengan kain songket khas Bangka Belitung yang penuh makna.\n\n'
          'Busana ini menggambarkan perpaduan antara tradisi dan modernitas, menunjukkan bahwa budaya Bangka Belitung terus hidup dan berkembang di tengah arus zaman.',
      'isFavorite': false,
      'isBookmarked': false,
    },
  ];

  late List<bool> likedList;
  late List<bool> bookmarkList;

  @override
  void initState() {
    super.initState();
    likedList = List.generate(listBajuAdat.length, (index) => false);
    bookmarkList = List.generate(listBajuAdat.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: listBajuAdat.asMap().entries.map((entry) {
            final index = entry.key;
            final baju = entry.value;

            return CardBajuMakan(
              item: baju,
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
                          item: baju,
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
