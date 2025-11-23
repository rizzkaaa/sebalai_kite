import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:uts/models/lagu_model.dart';
import 'package:uts/services/lagu_service.dart';

class MusikContent extends StatefulWidget {
  const MusikContent({super.key});

  @override
  State<MusikContent> createState() => _MusikContentState();
}

class _MusikContentState extends State<MusikContent> {
  final LaguService service = LaguService();
  late Future<List<LaguModel>> dataLagu;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String? currentSong;

  // final List<Map<String, String>> laguList = [
  //   {
  //     'gambar': 'assets/images/yokMiak.jpg',
  //     'judul': 'Yok Miak',
  //     'penyanyi': 'Ria Irawan',
  //     'audio': 'audio/YoMiak.mpeg',
  //   },
  //   {
  //     'gambar': 'assets/images/alam.jpg',
  //     'judul': 'Alam Wisata Pulau Bangka',
  //     'penyanyi': 'Iwan Fals',
  //     'audio': 'audio/alam.mp3',
  //   },
  //   {
  //     'gambar': 'assets/images/zapin.jpg',
  //     'judul': 'Zapin Serumpun Sebalai',
  //     'penyanyi': 'Rita Sugiarto',
  //     'audio': 'audio/zapin.mpeg',
  //   },
  //   {
  //     'gambar': 'assets/images/amoy.jpg',
  //     'judul': 'Amoy Kek Akew',
  //     'penyanyi': 'Arie Suyadi',
  //     'audio': 'audio/amoy.mpeg',
  //   },
  // ];

  late List<bool> likedList;
  bool likedInitialized = false;

  @override
  void initState() {
    super.initState();
    dataLagu = service.fetchLagu();
  }

  Future<void> playAudio(String assetPath) async {
    if (isPlaying && currentSong == assetPath) {
      await _audioPlayer.pause();
      setState(() => isPlaying = false);
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(assetPath));
      setState(() {
        isPlaying = true;
        currentSong = assetPath;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/musik.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Text(
                        'Pilihan Hari Ini',
                        style: GoogleFonts.delaGothicOne(
                          fontSize: 12,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black54, blurRadius: 4),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 10,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 20,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Container(
                  width: 180,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/musik2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),

          FutureBuilder(
            future: dataLagu,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("Tidak ada data"));
              } else {
                final laguList = snapshot.data!;
                if (!likedInitialized) {
                  likedList = List.generate(laguList.length, (_) => false);
                  likedInitialized = true;
                }

                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: laguList.length,
                    itemBuilder: (context, index) {
                      final lagu = laguList[index];
                      final liked = likedList[index];
                      final isThisPlaying =
                          currentSong == lagu.audio && isPlaying;

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(lagu.gambar),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lagu.judul,
                                    style: GoogleFonts.delaGothicOne(
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    lagu.penyanyi,
                                    style: GoogleFonts.dongle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  likedList[index] = !likedList[index];
                                });
                              },
                              icon: Icon(
                                liked ? Icons.favorite : Icons.favorite_border,
                                color: liked ? Colors.red : Colors.grey,
                                size: 28,
                              ),
                            ),
                            IconButton(
                              onPressed: () => playAudio(lagu.audio),
                              icon: Icon(
                                isThisPlaying
                                    ? Icons.pause_circle
                                    : Icons.play_circle,
                                color: Colors.deepPurple,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
