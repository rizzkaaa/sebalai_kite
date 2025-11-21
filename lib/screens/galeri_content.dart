import 'package:flutter/material.dart';

class GaleriContent extends StatefulWidget {
  @override
  _GaleriContentState createState() => _GaleriContentState();
}

class _GaleriContentState extends State<GaleriContent> {
  List<Map<String, dynamic>> dataGaleri = [
    {
      'gambar': 'assets/images/dokumentasi1.jpeg',
      'judul': 'Dokumentasi Tari Sepen',
      'tanggal': '29 Okt 2025',
    },
    {
      'gambar': 'assets/images/dokumentasi2.jpeg',
      'judul': 'Pawai HUT RI Menampilkan Tari Campak',
      'tanggal': '21 Agu 2025',
    },
    {
      'gambar': 'assets/images/dokumentasi3.png',
      'judul': 'Latihan Kompetisi Tari Budaya Bangka',
      'tanggal': '30 Jul 2025',
    },
  ];

  void _tampilkanDialogUpload() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogUploadGambar(onUpload: _tambahGambarBaru);
      },
    );
  }

  void _tambahGambarBaru(String pathGambar, String deskripsi) {
    setState(() {
      dataGaleri.insert(0, {
        'gambar': pathGambar,
        'judul': deskripsi,
        'tanggal': _getTanggalSekarang(),
      });
    });
    _tampilkanAlertSukses();
  }

  String _getTanggalSekarang() {
    final sekarang = DateTime.now();
    final bulan = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return '${sekarang.day} ${bulan[sekarang.month]} ${sekarang.year}';
  }

  void _tampilkanAlertSukses() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle, color: Colors.green, size: 50),
              ),
              SizedBox(height: 20),
              Text(
                'Berhasil!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Gambar berhasil diupload ke galeri',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFF8B7FB8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _tampilkanDialogUpload,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Color(0xFFB8A7D9), width: 1.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.folder_outlined,
                          color: Color(0xFFB8A7D9),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'upload gambar',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFB8A7D9),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Column(
                  children: [
                    for (int i = 0; i < dataGaleri.length; i += 2)
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: KartuGaleri(data: dataGaleri[i])),
                              SizedBox(width: 12),
                              Expanded(
                                child: i + 1 < dataGaleri.length
                                    ? KartuGaleri(data: dataGaleri[i + 1])
                                    : SizedBox(),
                              ),
                            ],
                          ),
                          if (i + 2 < dataGaleri.length) SizedBox(height: 12),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KartuGaleri extends StatelessWidget {
  final Map<String, dynamic> data;

  const KartuGaleri({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              data['gambar'],
              width: double.infinity,
              height: 130,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 130,
                  color: Colors.grey[300],
                  child: Icon(Icons.image, size: 40, color: Colors.grey),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['judul'] ?? 'Tanpa Judul',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333),
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  data['tanggal'] ?? '',
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DialogUploadGambar extends StatefulWidget {
  final Function(String, String) onUpload;

  const DialogUploadGambar({required this.onUpload});

  @override
  _DialogUploadGambarState createState() => _DialogUploadGambarState();
}

class _DialogUploadGambarState extends State<DialogUploadGambar> {
  final TextEditingController _deskripsiController = TextEditingController();
  String? _pathGambarDipilih;

  final List<String> _gambarTersedia = [
    'assets/images/nganggung.jpeg',
    'assets/images/perang ketupat.jpg',
    'assets/images/tradisi peh cun.jpeg',
  ];

  void _tampilkanPilihanGambar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Pilih Gambar',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _gambarTersedia.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _pathGambarDipilih = _gambarTersedia[index];
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        _gambarTersedia[index],
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _prosesUpload() {
    if (_pathGambarDipilih == null) {
      _tampilkanPesan('Pilih gambar dulu ya!');
      return;
    }
    if (_deskripsiController.text.trim().isEmpty) {
      _tampilkanPesan('Tulis deskripsi dulu ya!');
      return;
    }
    widget.onUpload(_pathGambarDipilih!, _deskripsiController.text.trim());
    Navigator.of(context).pop();
  }

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.pinkAccent[100],
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload Gambar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Deskripsi',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _deskripsiController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tulis deskripsi gambar...',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey[400]),
                ),
                style: TextStyle(fontSize: 13),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Lampirkan File',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: _tampilkanPilihanGambar,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: _pathGambarDipilih == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 40,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Klik untuk pilih gambar',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          _pathGambarDipilih!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _prosesUpload,
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xFF8B7FB8),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Upload',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _deskripsiController.dispose();
    super.dispose();
  }
}
