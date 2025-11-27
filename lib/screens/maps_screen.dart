import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:uts/models/budaya_model.dart';
import 'package:uts/services/baju_service.dart';
import 'package:uts/services/makanan_service.dart';
import 'package:uts/services/rumah_service.dart';
import 'package:uts/services/tari_service.dart';
import 'package:uts/widgets/icon_action_appbar.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  bool isOpen = false;
  int indexSelect = -1;

  final TariService tariService = TariService();
  final BajuService bajuService = BajuService();
  final RumahService rumahService = RumahService();
  final MakananService makananService = MakananService();

  final List<BudayaModel> allData = [];
  final List<Map<String, dynamic>> locations = [
    {
      'kabupaten': 'Bangka',
      'ibuKota': 'Sungailiat',
      'latLng': LatLng(-1.858754, 106.116437),
      'link': 'https://maps.app.goo.gl/4GCXTej8UUdjuNnU6',
    },
    {
      'kabupaten': 'Bangka Barat',
      'ibuKota': 'Muntok',
      'latLng': LatLng(-2.051874, 105.187566),
      'link': 'https://maps.app.goo.gl/ao7qnmXZTsFiwqJE9',
    },
    {
      'kabupaten': 'Bangka Tengah',
      'ibuKota': 'Koba',
      'latLng': LatLng(-2.484569, 106.411058),
      'link': 'https://maps.app.goo.gl/RZTyJT8ZP1heF4mj8',
    },
    {
      'kabupaten': 'Bangka Selatan',
      'ibuKota': 'Toboali',
      'latLng': LatLng(-3.001036, 106.464104),
      'link': 'https://maps.app.goo.gl/6J3pDuvUJ7TSQ1i9A',
    },
    {
      'kabupaten': 'Belitung',
      'ibuKota': 'Tanjung Pandan',
      'latLng': LatLng(-2.742177, 107.653051),
      'link': 'https://maps.app.goo.gl/LZBHqLhHLYBtcoNB7',
    },
    {
      'kabupaten': 'Belitung Timur',
      'ibuKota': 'Manggar',
      'latLng': LatLng(-2.871363, 108.278162),
      'link': 'https://maps.app.goo.gl/vCWcFZohWwrvdDmKA',
    },
    {
      'kabupaten': 'Pangkal Pinang',
      'ibuKota': 'Pangkalpinang',
      'latLng': LatLng(-2.131320, 106.116800),
      'link': 'https://maps.app.goo.gl/CdBWQivQ5a4BZvm88',
    },
  ];

  void _fetchData(String daerah) async {
    final tari = await tariService.fetchTari();
    final baju = await bajuService.fetchBaju();
    final rumah = await rumahService.fetchRumah();
    final makanan = await makananService.fetchMakanan();

    final filterTari = tari
        .where(
          (item) =>
              item.asalDaerah == daerah || item.asalDaerah == "Bangka Belitung",
        )
        .toList();

    final filterBaju = baju
        .where(
          (item) =>
              item.asalDaerah == daerah || item.asalDaerah == "Bangka Belitung",
        )
        .toList();

    final filterRumah = rumah
        .where(
          (item) =>
              item.asalDaerah == daerah || item.asalDaerah == "Bangka Belitung",
        )
        .toList();

    final filterMakanan = makanan
        .where(
          (item) =>
              item.asalDaerah == daerah || item.asalDaerah == "Bangka Belitung",
        )
        .toList();

    allData.clear();
    allData.addAll(filterTari);
    allData.addAll(filterBaju);
    allData.addAll(filterRumah);
    allData.addAll(filterMakanan);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final center = LatLng(-2.33, 106.22);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(initialCenter: center, initialZoom: 9),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: locations.asMap().entries.map((entry) {
                  final index = entry.key;
                  final place = entry.value;
                  return Marker(
                    point: place['latLng'] as LatLng,
                    width: 120,
                    height: 120,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          indexSelect = index;
                          _fetchData(place['kabupaten']);
                          isOpen = true;
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) => const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFFF5B92), Color(0xFF684B9E)],
                            ).createShader(rect),
                            child: Icon(
                              indexSelect != index
                                  ? Icons.location_pin
                                  : Icons.share_location,
                              size: indexSelect == index ? 50 : 40,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          Positioned(
            top: 10,
            left: 20,
            child: SafeArea(
              child: IconActionAppbar(
                icon: Icons.reply,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isOpen ? 0 : -height * 0.60,
            curve: Curves.easeInOut,
            left: 0,
            right: 0,
            child: Container(
              height: height * 0.60,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(70)),
              ),
              child: Column(
                children: [
                  const Divider(
                    thickness: 5,
                    color: Color(0xFFCBC2C2),
                    endIndent: 130,
                    indent: 130,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isOpen ? locations[indexSelect]['ibuKota'] : '',
                            style: GoogleFonts.moul(
                              color: Color(0XFFC97DAF),
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            isOpen
                                ? '${locations[indexSelect]['ibuKota'] == 'Pangkalpinang' ? 'Kota' : 'Kabupaten'} ${locations[indexSelect]['kabupaten']}'
                                : '',
                            style: GoogleFonts.namdhinggo(
                              color: Colors.blueGrey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFFC97DAF).withOpacity(0.3),
                            child: IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: locations[indexSelect]['link'],
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Tautan disalin ke clipboard",
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.share_outlined,
                                color: Color(0xFFC97DAF),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            backgroundColor: Color(0xFFC97DAF).withOpacity(0.3),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isOpen = false;
                                  indexSelect = -1;
                                });
                              },
                              icon: Icon(Icons.close, color: Color(0xFFC97DAF)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(thickness: 1, color: Color(0xFFC7B1B1)),

                  Expanded(
                    child: ListView.builder(
                      itemCount: allData.length,
                      itemBuilder: (context, index) {
                        final data = allData[index];
                        return Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          decoration: inset.BoxDecoration(
                            color: index % 2 == 0
                                ? Color(0xFFEBBCDF)
                                : Color(0xFFFFBCD9),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              inset.BoxShadow(
                                color: Colors.black38.withOpacity(0.1),
                                offset: const Offset(6, 6),
                                blurRadius: 5,
                                inset: true,
                              ),
                              inset.BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: const Offset(6, 6),
                                blurRadius: 5,
                                inset: false,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 150,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(data.gambar),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: 130,
                                    child: Text(
                                      data.judul,
                                      style: GoogleFonts.judson(
                                        color: index % 2 == 0
                                            ? Color(0xFFB02D8F)
                                            : Color(0xFFEC3393),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 130,
                                    child: Divider(
                                      thickness: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: 120,
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                      ),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              index % 2 == 1
                                                  ? Color(0xFFF09CBF)
                                                  : Color(0xFFEA90CB),
                                              Colors.white,
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Selengkapnya",
                                            style: TextStyle(
                                              color: index % 2 == 0
                                                  ? Color(0xFFB02D8F)
                                                  : Color(0xFFEC3393),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
