import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TimContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDFDFD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text(
                'Meet Our Team',
                style: GoogleFonts.niconne(
                  fontSize: 29,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              SizedBox(height: 14),

              // Deskripsi
              Text(
                'Kami adalah sekelompok mahasiswa yang bekerja sama dalam satu tujuan — '
                    'menyediakan proyek ini dengan semangat belajar, kerja sama, dan tanggung jawab bersama.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.7,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              SizedBox(height: 28),

              // Garis pembatas
              Container(
                height: 1,
                width: double.infinity,
                color: Color(0xFFD9D9D9),
              ),
              SizedBox(height: 28),
              
              Center(
                child: Text(
                  'Team Sebalai Kite',
                  style: GoogleFonts.niconne(
                    fontSize: 29,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
              SizedBox(height: 40),
              
              Row(
                children: [
                  // Kartu 1 - Alya
                  Expanded(
                    child: TimCard(
                      name: 'Alya Zilyanti',
                      color: Color(0xFFCEA5CE),
                      imagePath: 'assets/images/av1.jpeg',
                      email: 'alyazilyanti3@gmail.com',
                      phone: '+62 812-1078-0544',
                      game: '07_Layaya',
                    ),
                  ),
                  SizedBox(width: 15),

                  // Kartu 2 - Rizka
                  Expanded(
                    child: TimCard(
                      name: 'Rizka L. R',
                      color: Color(0xFFFFC0E0),
                      imagePath: 'assets/images/av2.jpeg',
                      email: 'rizkalaylaramadhani@gmail.com',
                      phone: '+62 857-6692-7491',
                      game: 'munbaebae',
                    ),
                  ),
                  SizedBox(width: 15),

                  // Kartu 3 - Sella
                  Expanded(
                    child: TimCard(
                      name: 'Sella A. S',
                      color: Color(0xFFCEA5CE),
                      imagePath: 'assets/images/av3.jpeg',
                      email: 'sellaallisyasalsabila@gmail.com',
                      phone: '+62 831-7580-3222',
                      game: 'selamatic',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),

              // Garis pembatas
              Container(
                height: 1,
                width: double.infinity,
                color: Color(0xFFD9D9D9),
              ),
              SizedBox(height: 28),
              
              Text(
                'Our Motivation',
                style: GoogleFonts.niconne(
                  fontSize: 29,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              SizedBox(height: 14),

              // Deskripsi Motivasi
              Text(
                'Kami ingin mengenalkan dan melestarikan budaya Bangsa dengan cara yang lebih modern dan menarik. '
                    'Lewat aplikasi ini, kami berharap generasi muda bisa lebih bangga dan terlibat pada budaya daerahnya sendiri.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.7,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimCard extends StatelessWidget {
  final String name;
  final Color color;
  final String imagePath;
  final String email;
  final String phone;
  final String game;

  TimCard({
    required this.name,
    required this.color,
    required this.imagePath,
    required this.email,
    required this.phone,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // Kotak kartu bagian bawah
        Container(
          margin: EdgeInsets.only(top: 45),
          padding: EdgeInsets.fromLTRB(12, 55, 12, 20),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Nama
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12),

              // Kotak Email
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Icon(Icons.email_outlined, size: 13, color: color),
                    SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        email,
                        style: TextStyle(
                          fontSize: 9,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7),

              // Kotak Phone
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Icon(Icons.phone_outlined, size: 13, color: color),
                    SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        phone,
                        style: TextStyle(
                          fontSize: 9,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7),

              // Kotak Game
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Icon(Icons.videogame_asset_outlined, size: 13, color: color),
                    SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        game,
                        style: TextStyle(
                          fontSize: 9,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Foto profil di atas
        Positioned(
          top: 0,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [color.withOpacity(0.9), color.withOpacity(0.4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 42,
                backgroundImage: AssetImage(imagePath),
                backgroundColor: Colors.grey[200],
              ),
            ),
          ),
        ),
      ],
    );
  }
}