import 'package:cloud_firestore/cloud_firestore.dart';

class BeritaUploader {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Data berita yang akan diupload
  final List<Map<String, dynamic>> beritaList = [
    {
      "id": 15,
      "judul":
          "Mozaik Dialektika Budaya Meriahkan HUT ke-25 Provinsi Babel di Taman Kota Sungailiat",
      "tanggal": "Sungailiat, 23 November 2025",
      "paragraf": [
        "SEMARAK HUT BABEL - Peringatan HUT ke-25 Provinsi Kepulauan Bangka Belitung digelar melalui acara Mozaik Dialektika Budaya di Taman Kota Sungailiat pada Sabtu (22/11/2025) malam.",
        "Taman Kota Sungailiat menjadi pusat keramaian masyarakat dalam rangka peringatan hari jadi pembentukan Provinsi Babel.",
        "Berbagai pagelaran seni dan atraksi budaya tampil meramaikan panggung, mulai dari pertunjukan tari, atraksi silat, penampilan musik, pembacaan puisi, hingga beragam ekspresi seni lainnya.",
        "Ketua pelaksana kegiatan menegaskan acara ini sebagai pengingat bahwa budaya adalah denyut nadi yang membuat Babel terus hidup, tumbuh, dan bermartabat.",
      ],
      "deskripsi":
          "SEMARAK HUT BABEL - Peringatan HUT ke-25 Provinsi Kepulauan Bangka Belitung digelar melalui acara Mozaik Dialektika Budaya di Taman Kota Sungailiat pada Sabtu (22/11/2025) malam.",
      "image": "assets/images/berita_11.webp",
    },
    {
      "id": 14,
      "judul":
          "Pemerintah Bangka Lestarikan Budaya melalui Festival Sungai Upang",
      "tanggal": "Sungailiat, 26 Oktober 2025",
      "paragraf": [
        "Pemerintah Kabupaten Bangka, Provinsi Kepulauan Bangka Belitung, melestarikan tradisi dan budaya serta menjaga keseimbangan alam melalui Festival Sungai Upang.",
        "Festival Sungai Upang sudah ditetapkan sebagai kalender pariwisata dan diselenggarakan setiap tahun.",
        "Festival ini berlangsung selama tiga hari dengan lomba tradisional seperti lomba Betet, lari Batok kelapa, lomba perahu, panahan tradisional, dan lomba memasak ikan air tawar.",
        "Festival diharapkan lebih meriah dengan melibatkan pemerintah desa, lembaga adat Melayu, dan pihak terkait budaya lokal.",
      ],
      "deskripsi":
          "Pemerintah Kabupaten Bangka, Provinsi Kepulauan Bangka Belitung, melestarikan tradisi dan budaya serta menjaga keseimbangan alam melalui Festival Sungai Upang.",
      "image": "assets/images/berita_12.webp",
    },
    {
      "id": 13,
      "judul": "Festival Tari Campak Meriahkan Peringatan Hari Budaya Bangka",
      "tanggal": "Bangka, 26 Oktober 2025",
      "paragraf": [
        "Dalam rangka memperingati Hari Budaya Bangka, Dinas Kebudayaan menggelar Festival Tari Campak 2025 di Lapangan Merdeka, Sungailiat.",
        "Acara ini diikuti oleh lebih dari 20 sanggar seni tradisional dari berbagai daerah di Pulau Bangka.",
        "Tari Campak dikenal sebagai simbol keceriaan dan kebersamaan masyarakat Melayu Bangka.",
        "Selain pertunjukan tari, festival juga menampilkan pameran kuliner tradisional dan lokakarya tari Campak untuk umum.",
        "Kepala Dinas Kebudayaan berharap acara ini meningkatkan minat generasi muda terhadap seni tari tradisional.",
        "Festival ditutup dengan penampilan kolaborasi antara sanggar lokal dan penari muda.",
      ],
      "deskripsi":
          "Festival tahunan ini menghadirkan penampilan dari berbagai sanggar seni di Pulau Bangka. Tari Campak, simbol keceriaan masyarakat Melayu Bangka, kembali memukau penonton lokal dan wisatawan.",
      "image": "assets/images/tariCampak.png",
    },
    {
      "id": 12,
      "judul":
          "Pj Ketua Dekranasda Maya Kagumi Kreativitas Alumni Sekolah Sekuntum Melati",
      "tanggal": "Kelapa Kampit, 14 Juni 2023",
      "paragraf": [
        "Usai mengunjungi rumah dua orang anak yang teridentifikasi kasus stunting di Desa Senyubuk Kelapa Kampit, Kabupaten Belitung Timur (Kab. Beltim), Penjabat (Pj) Ketua Dewan Kerajinan Nasional Daerah (Dekranasda) Kepulauan Bangka Belitung (Kep. Babel) Maya Suganda Pasaribu, bersama Ketua Dekranasda Kab. Beltim Purwenda, Disperindag Prov. Kep Babel, dan Kab. Beltim, mengunjungi alumni siswi Sekolah Perempuan Sekuntum Melati Desa Mentawak Kecamatan Kelapa Kampit, Kabupaten Beltim Selasa (13/6/2023).",
        "Alumni sekolah Sekuntum Melati ini telah menghasilkan berbagai macam produk, baik itu makanan, minuman, maupun kerajinan seperti tas, kerajinan daur ulang, dan lain sebagainya.",
        "Dalam lawatan itu, salah satu alumni siswi Sekuntum Melati menghadiahkan tas rajutan indah kepada Maya Suganda sebagai bentuk kenang-kenangan.",
        "Kemudian, Pj Ketua Maya bersama rombongan melanjutkan kunjungan ke pelaku usaha 'Raja Dapoer Bolen AZ' yang juga merupakan alumni siswi Sekolah Sekuntum Melati.",
        "\"Sangat kreatif ya. Raja Dapoer Bolen AZ ini menyediakan menu kue pisang bolen, dan soes, dengan menggunakan bahan dasar daun kelor, dan rasanya juga enak,\" katanya.",
        "Maya Suganda yang juga merupakan Pj Ketua TP PKK ini sangat mendukung usaha para pelaku ekonomi ini. Ia berharap agar mereka dapat terus memajukan usahanya.",
        "Selain untuk kesejahteraan, produk mereka juga diharapkan dapat dikenal, bukan hanya di Belitung saja, tapi juga di seluruh Indonesia, bahkan mancanegara.",
      ],
      "deskripsi":
          "Usai mengunjungi rumah dua orang anak yang teridentifikasi kasus stunting di Desa Senyubuk Kelapa Kampit, Kabupaten Belitung Timur (Kab. Beltim), Penjabat (Pj) Ketua Dewan Kerajinan Nasional Daerah (Dekranasda) Kepulauan Bangka Belitung (Kep. Babel) Maya Suganda Pasaribu, bersama Ketua Dekranasda Kab. Beltim Purwenda, Disperindag Prov. Kep Babel, dan Kab. Beltim, mengunjungi alumni siswi Sekolah Perempuan Sekuntum Melati Desa Mentawak Kecamatan Kelapa Kampit, Kabupaten Beltim Selasa (13/6/2023).",
      "image": "assets/images/berita_1.jpeg",
    },
    {
      "id": 11,
      "judul":
          "Gelar Peragaan Busana, Desain Kreatif Kain Tradisional Kepulauan Babel Banggakan Daerah",
      "tanggal": "Jakarta, 23 Mei 2023",
      "paragraf": [
        "Diadakannya peragaan busana menjadi bukti bahwa, kain khas Kepulauan Bangka Belitung (Kep. Babel) memiliki tempat dikancah nasional bahkan internasional.",
        "Kain khas ini juga dapat dijadikan berbagai jenis baik busana formal maupun informal.",
        "Hal itu disampaikan Ketua Dewan Kerajinan Nasional Daerah (Dekranasda) Kep. Babel Maya Suganda Pasaribu ketika ditemui usai Pergelaran Busana Halal Bihalal & Silaturahmi Masyarakat Perantauan Prov. Kep. Babel se-Jabodetabek di Smesco Exhibition Hall, Minggu (21/5/2023).",
        "Berbagai desainer berhasil memperagakan karya-karyanya, antara lain Destiani, Astari, Rereziq Karim, dengan motif kain cual khas Bangka Belitung yang diproduksi secara manual dan ramah lingkungan.",
        "Dengan semakin dikenalnya kain cual di Indonesia hingga di mancanegara, produksi-produk UMKM semakin meningkat.",
      ],
      "deskripsi":
          "Diadakannya peragaan busana menjadi bukti bahwa, kain khas Kepulauan Bangka Belitung (Kep. Babel) memiliki tempat dikancah nasional bahkan internasional.",
      "image": "assets/images/berita_2.jpeg",
    },
    {
      "id": 10,
      "judul":
          "Kampung Adat Gebong Memarong Harus Dilestarikan Sebagai Kekayaan Budaya Daerah",
      "tanggal": "Belinyu, 18 April 2023",
      "paragraf": [
        "Pj. Gubernur Kepulauan Bangka Belitung Suganda Pandapotan Pasaribu mengunjungi Kampung Adat Gebong Memarong.",
        "Kampung Adat Gebong Memarong adalah kumpulan rumah adat yang disatukan menjadi satu kompleks atau suatu desa.",
        "Masyarakat setempat melestarikan budaya Memarong agar tidak punah.",
        "Pj. Gubernur menekankan kampung adat harus dilestarikan sebagai kekayaan budaya daerah dan memiliki nilai ekonomis untuk pariwisata.",
      ],
      "deskripsi":
          "Pj. Gubernur Kepulauan Bangka Belitung Suganda Pandapotan Pasaribu mengunjungi Kampung Adat Gebong Memarong.",
      "image": "assets/images/berita_10.jpeg",
    },
    {
      "id": 9,
      "judul": "Kabasarnas RI Henri Puji Makanan Bangka Enak",
      "tanggal": "Pangkalpinang, 8 Agustus 2022",
      "paragraf": [
        "Sekretaris Daerah (Sekda) Provinsi Kepulauan Bangka Belitung (Kep. Babel) Naziarto bersama Ketua Dharma Wanita Persatuan (DWP) Kep. Babel menyambut kedatangan Kepala Badan Nasional Pencarian dan Pertolongan (Kabasarnas) RI Marsekal Madya TNI Henri Alfiandi.",
        "Sebelum kunjungan ke Kantor SAR Pangkal Pinang, rombongan dijamu dengan makanan khas Bangka: Otak-Otak, Pempek, Mie Koba.",
        "Kabasarnas Henri menyatakan makanannya enak dan sangat terasa terasinya.",
        "Sekda Naziarto mengenalkan kekayaan Bangka Belitung dan mendorong sinergi antar instansi.",
      ],
      "deskripsi":
          "Sekretaris Daerah (Sekda) Provinsi Kepulauan Bangka Belitung (Kep. Babel) Naziarto bersama Ketua Dharma Wanita Persatuan (DWP) Kep. Babel menyambut kedatangan Kepala Badan Nasional Pencarian dan Pertolongan (Kabasarnas) RI Marsekal Madya TNI Henri Alfiandi.",
      "image": "assets/images/berita_7.jpg",
    },
    {
      "id": 8,
      "judul":
          "Pesan Pj Gubernur Babel Ridwan Djamaluddin: Kerajinan Resam Harus Dilestarikan!",
      "tanggal": "Kelapa, 15 Agustus 2022",
      "paragraf": [
        "Menutup kunjungan kerjanya ke Kabupaten Bangka Barat (Babar), Minggu (14/8/2022), Penjabat (Pj) Gubernur Kepulauan Bangka Belitung (Babel) Ridwan Djamaluddin, memenuhi undangan masyarakat Desa Dendang, Kecamatan Kelapa.",
        "Hadirnya Pj Gubernur Ridwan di Sentra UMKM Desa Dendang dimanfaatkan masyarakat setempat menunjukkan buah karya khas desa, yakni produk anyaman resam.",
        "Berbagai produk seperti kopiah, topi, hingga tas wanita dipamerkan.",
        "Pj Gubernur menyampaikan pesan meningkatkan kuantitas dan kualitas produk, menambah inovasi produk, serta terus menjaga kelestarian kerajinan.",
        "Ia juga berjanji menjadikan resam sebagai souvenir resmi di ajang G20 yang akan diadakan di Belitung.",
      ],
      "deskripsi":
          "Menutup kunjungan kerjanya ke Kabupaten Bangka Barat (Babar), Minggu (14/8/2022), Penjabat (Pj) Gubernur Kepulauan Bangka Belitung (Babel) Ridwan Djamaluddin, memenuhi undangan masyarakat Desa Dendang, Kecamatan Kelapa.",
      "image": "assets/images/berita_3.jpg",
    },
    {
      "id": 7,
      "judul": "Puan Maharani Terpesona dengan Keindahan Songket Tenun Babel",
      "tanggal": "Pangkalpinang, 20 Juni 2022",
      "paragraf": [
        "Penjabat (Pj) Ketua Dewan Kerajinan Nasional Daerah (Dekranasda) Provinsi Kepulauan Bangka Belitung (Kep. Babel) Sri Utami Soedarsono, senang karena Ketua Dewan Perwakilan Rakyat Republik Indonesia (DPR RI) Puan Maharani terpesona akan keindahan Songket Tenun Babel.",
        "Puan Maharani jatuh hati dengan Songket Tenun Babel Motif Buah Rukem by Ibu Maslina.",
        "Ia juga membeli batik tulis, syal tenun ATBM, destar, dan sedotan purun dari UMKM Belitung.",
        "Dengan adanya kunjungan seperti ini, produk-produk UMKM yang ada di Kep. Babel semakin dikenal.",
        "Destar Point disiapkan untuk memudahkan wisatawan mencari produk unggulan dari seluruh kabupaten dan kota di Kep. Babel.",
      ],
      "deskripsi":
          "Penjabat (Pj) Ketua Dewan Kerajinan Nasional Daerah (Dekranasda) Provinsi Kepulauan Bangka Belitung (Kep. Babel) Sri Utami Soedarsono, senang karena Ketua Dewan Perwakilan Rakyat Republik Indonesia (DPR RI) Puan Maharani terpesona akan keindahan Songket Tenun Babel.",
      "image": "assets/images/berita_4.jpg",
    },
    {
      "id": 6,
      "judul": "Kuliner Belitung, Potensi Kebangkitan Ekonomi",
      "tanggal": "Tanjung Pandan, 27 Februari 2022",
      "paragraf": [
        "Menteri Pariwisata dan Ekonomi Kreatif RI, Sandiaga Uno berharap momen G20 menjadi salah satu sektor kebangkitan ekonomi di Kepulauan Bangka Belitung (Babel), karena 45 persen kebangkitan ekonomi di Babel ini adalah dari kuliner.",
        "Workshop Kata Kreatif dilaksanakan di Aula Serbaguna Kantor Bupati Belitung untuk meningkatkan kreativitas kabupaten/kota.",
        "Menteri Sandi berharap Belitung dapat menjadi kabupaten kreatif se-Indonesia dan mendorong UMKM kuliner agar mampu mempromosikan keunggulan Babel.",
        "Belitung dinilai memiliki potensi alam dan budaya yang luar biasa, dan kurasi produk kuliner perlu ditingkatkan agar UMKM siap ekspor.",
      ],
      "deskripsi":
          "Menteri Pariwisata dan Ekonomi Kreatif RI, Sandiaga Uno berharap momen G20 menjadi salah satu sektor kebangkitan ekonomi di Kepulauan Bangka Belitung (Babel), karena 45 persen kebangkitan ekonomi di Babel ini adalah dari kuliner.",
      "image": "assets/images/berita_8.jpeg",
    },
    {
      "id": 5,
      "judul": "Pengembangan Ilmu Membatik Akan Mengangkat Potensi Alam Lokal",
      "tanggal": "Manggar, 13 Juni 2021",
      "paragraf": [
        "Melati Erzaldi senang, pengembangan tehnik membatik melalui 'Pelatihan Batik Mangrove'.",
        "Dinas Penanaman Modal Pelayanan Terpadu Satu Pintu dan Perdagangan Kabupaten Belitung Timur mengadakan 'Pelatihan Batik Mangrove' untuk Kelompok Usaha Bersama (KUD) Sanggar Batik 'Mangrove'.",
        "Pewarnaan dari Indigotin bisa dikembangkan dan menjadi bahan utama ragam pewarnaan batik.",
        "Sinergisitas dengan OK OCE juga membantu kewirausahaan di desa terus berkembang.",
      ],
      "deskripsi":
          "Melati Erzaldi senang, pengembangan tehnik membatik melalui 'Pelatihan Batik Mangrove'.",
      "image": "assets/images/berita_5.jpg",
    },
    {
      "id": 4,
      "judul":
          "Mengenali Batu Satam Khas Pulau Belitung, Melati Kunjungi Galeri Firman",
      "tanggal": "Tanjung Pandan, 12 Juni 2021",
      "paragraf": [
        "Setelah beberapa tahun terakhir menjabat Ketua Dewan Kerajinan Nasional Daerah Provinsi Kepulauan Bangka Belitung (Dekranasda Babel), Melati Erzaldi berkesempatan mengunjungi seorang pengrajin cinderamata Batu Satam di Galeri milik Firman Zulkarnaen.",
        "Jenis Batu Satam dan akar bahar merupakan kekayaan alam Babel yang dilindungi.",
        "Meski diminati secara nasional dan internasional, kerajinan ini harus dijaga karena termasuk hasil alam yang mulai langka.",
      ],
      "deskripsi":
          "Setelah beberapa tahun terakhir menjabat Ketua Dewan Kerajinan Nasional Daerah Provinsi Kepulauan Bangka Belitung (Dekranasda Babel), Melati Erzaldi berkesempatan mengunjungi seorang pengrajin cinderamata Batu Satam di Galeri milik Firman Zulkarnaen.",
      "image": "assets/images/berita_6.jpg",
    },
    {
      "id": 3,
      "judul": "Eratkan Silaturahmi Melalui Ragam Kuliner Babel",
      "tanggal": "Pangkalpinang, 19 Januari 2021",
      "paragraf": [
        "Gubernur Kepulauan Bangka Belitung (Babel), Erzaldi Rosman bersama Forkopimda dan pimpinan instansi vertikal eratkan silaturahmi sembari menikmati ragam kuliner Bangka Belitung di Warung Sop Kambing milik Prof. Saparudin.",
        "Melalui silaturahmi, banyak ide dan solusi yang diperoleh.",
        "Gubernur berharap kebersamaan yang terbina terus dipelihara untuk memudahkan koordinasi dan kolaborasi.",
        "Warung ini juga membuka lapangan pekerjaan bagi pemuda di era pandemi Covid-19.",
      ],
      "deskripsi":
          "Gubernur Kepulauan Bangka Belitung (Babel), Erzaldi Rosman bersama Forkopimda dan pimpinan instansi vertikal eratkan silaturahmi sembari menikmati ragam kuliner Bangka Belitung di Warung Sop Kambing milik Prof. Saparudin.",
      "image": "assets/images/berita_9.jpeg",
    },
    {
      "id": 2,
      "judul": "Tradisi Nganggung, Simbol Kebersamaan Masyarakat Bangka",
      "tanggal": "Bangka, 21 Oktober 2024",
      "paragraf": [
        "Tradisi Nganggung merupakan simbol kebersamaan masyarakat Melayu Bangka.",
        "Warga membawa hidangan dari rumah masing-masing menggunakan dulang besar untuk dimakan bersama.",
        "Biasanya diadakan pada perayaan hari besar Islam seperti Maulid Nabi atau Idul Fitri.",
        "Pemerintah daerah terus mendorong pelestarian Nganggung sebagai warisan budaya lokal.",
      ],
      "deskripsi":
          "Tradisi Nganggung merupakan simbol kebersamaan masyarakat Melayu Bangka.",
      "image": "assets/images/tradisiNganggung.png",
    },
    {
      "id": 1,
      "judul": "Upacara Maras Taun, Syukur atas Hasil Panen",
      "tanggal": "Bangka, 21 Oktober 2024",
      "paragraf": [
        "Maras Taun adalah upacara adat masyarakat Bangka Belitung sebagai ungkapan rasa syukur atas hasil panen.",
        "Warga berkumpul di balai desa untuk berdoa bersama dan menampilkan kesenian tradisional.",
        "Ada prosesi simbolik “pembersihan kampung” sebagai harapan agar desa terhindar dari marabahaya.",
        "Tradisi ini memperkuat identitas budaya serta menjadi daya tarik wisata budaya.",
      ],
      "deskripsi":
          "Maras Taun adalah upacara adat masyarakat Bangka Belitung sebagai ungkapan rasa syukur atas hasil panen.",
      "image": "assets/images/marasTaun.png",
    },
  ];

  /// Upload semua berita ke Firestore
  Future<void> uploadAllBerita() async {
    try {
      final batch = _firestore.batch();
      final now = Timestamp.now();

      for (var berita in beritaList) {
        // Buat reference dengan auto-generated ID
        final docRef = _firestore.collection('berita').doc();

        // Siapkan data yang akan diupload
        final data = {
          'id': berita['id'],
          'judul': berita['judul'],
          'tanggal': berita['tanggal'],
          'paragraf': berita['paragraf'],
          'deskripsi': berita['deskripsi'],
          'image': berita['image'],
          'createdAt': now, // Timestamp saat upload
          'updatedAt': now,
        };

        batch.set(docRef, data);
      }

      // Commit batch
      await batch.commit();
      print('✅ Berhasil upload ${beritaList.length} berita');
    } catch (e) {
      print('❌ Error saat upload: $e');
      rethrow;
    }
  }

  /// Upload berita satu per satu (alternatif)
  Future<void> uploadBeritaOneByOne() async {
    try {
      final now = Timestamp.now();
      int success = 0;

      for (var berita in beritaList) {
        try {
          await _firestore.collection('berita').add({
            'id': berita['id'],
            'judul': berita['judul'],
            'tanggal': berita['tanggal'],
            'paragraf': berita['paragraf'],
            'deskripsi': berita['deskripsi'],
            'image': berita['image'],
            'createdAt': now,
            'updatedAt': now,
          });

          success++;
          print('✅ Upload berita ${berita['id']}: ${berita['judul']}');
        } catch (e) {
          print('❌ Gagal upload berita ${berita['id']}: $e');
        }
      }

      print(
        'Selesai: $success dari ${beritaList.length} berita berhasil diupload',
      );
    } catch (e) {
      print('❌ Error: $e');
      rethrow;
    }
  }

  /// Hapus semua data berita (untuk testing)
  Future<void> deleteAllBerita() async {
    try {
      final snapshot = await _firestore.collection('berita').get();
      final batch = _firestore.batch();

      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      print('✅ Berhasil hapus ${snapshot.docs.length} berita');
    } catch (e) {
      print('❌ Error saat hapus: $e');
      rethrow;
    }
  }

  /// Cek apakah data sudah ada
  Future<bool> isDataExists() async {
    try {
      final snapshot = await _firestore.collection('berita').limit(1).get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('❌ Error cek data: $e');
      return false;
    }
  }
}

// Cara penggunaan:
void main() async {
  final uploader = BeritaUploader();

  // Cek apakah data sudah ada
  final exists = await uploader.isDataExists();

  if (exists) {
    print('⚠️  Data berita sudah ada di Firestore');
    print('Apakah ingin hapus dan upload ulang? (uncomment kode di bawah)');
    // await uploader.deleteAllBerita();
    // await uploader.uploadAllBerita();
  } else {
    // Upload menggunakan batch (lebih cepat)
    await uploader.uploadAllBerita();

    // Atau upload satu per satu (lebih detail log)
    // await uploader.uploadBeritaOneByOne();
  }
}
