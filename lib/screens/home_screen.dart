import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/screens/berita_content.dart';
import 'package:uts/screens/chat_floating_widget.dart';
import 'package:uts/screens/galeri_content.dart';
import 'package:uts/screens/home_content.dart';
import 'package:uts/screens/katalog_content.dart';
import 'package:uts/screens/maps_screen.dart';
import 'package:uts/screens/musik_content.dart';
import 'package:uts/screens/tim_content.dart';
import 'package:uts/services/auth_service.dart';
import 'package:uts/widgets/footer.dart';
import 'package:uts/widgets/icon_action_appbar.dart';
import 'package:uts/widgets/list_tile_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _goToTab(int index) {
    setState(() {
      _tabController.animateTo(index);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 158, 39, 156),
          ),
          backgroundColor: Color(0xFFEBC5EB),
          actions: [
            IconActionAppbar(
              icon: Icons.notifications_none_outlined,
              onPressed: () {},
            ),
            IconActionAppbar(
              icon: Icons.map_outlined,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapsScreen()),
                );
              },
            ),
            IconActionAppbar(
              icon: Icons.person_2_outlined,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _authService.toAccountPage(),
                  ),
                );
              },
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Container(
          color: Color(0xFFEBC5EB),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: Color(0xFFEBC5EB),
                child: Row(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Text(
                                "Welcome,",
                                style: GoogleFonts.lobster(
                                  fontSize: 32,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 3
                                    ..color = const Color(0xFFB832B6),
                                ),
                              ),

                              Text(
                                "Welcome,",
                                style: GoogleFonts.lobster(
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Jelajahi keunikan budaya\n"
                            "Bangka bersama Sebalai\n"
                            "Kite.",
                            style: TextStyle(
                              color: Color.fromARGB(255, 158, 39, 156),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.search,
                              color: Color(0xFFEBC5EB),
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF4A9C2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelStyle: TextStyle(color: Colors.white, fontSize: 9),
                  unselectedLabelStyle: TextStyle(
                    color: Color.fromARGB(255, 158, 39, 156),
                  ),
                  tabs: [
                    Tab(icon: Icon(Icons.home, size: 30), text: 'Beranda'),
                    Tab(icon: Icon(Icons.grid_view, size: 30), text: 'Katalog'),
                    Tab(icon: Icon(Icons.newspaper, size: 30), text: 'Berita'),
                    Tab(
                      icon: Icon(Icons.photo_library, size: 30),
                      text: 'Galeri',
                    ),
                    Tab(icon: Icon(Icons.music_note, size: 30), text: 'Lagu'),
                    Tab(
                      icon: Icon(Icons.supervisor_account, size: 30),
                      text: 'Tim',
                    ),
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    HomeContent(),
                    KatalogContent(),
                    BeritaContent(),
                    GaleriContent(),
                    MusikContent(),
                    TimContent(),
                  ],
                ),
              ),
            ],
          ),
        ),

        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              SizedBox(
                height: 330,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFF4A9C2),
                        Color.fromARGB(255, 221, 185, 221),
                        Color.fromARGB(255, 189, 176, 212),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/Peta.png',
                        fit: BoxFit.contain,
                      ),
                      Text(
                        "Sebalai Kite",
                        style: GoogleFonts.aclonica(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTileDrawer(
                selected: _tabController.index == 0,
                onTap: () => _goToTab(0),
                icon: Icons.home,
                title: 'Beranda',
              ),
              ListTileDrawer(
                selected: _tabController.index == 1,
                onTap: () => _goToTab(1),
                icon: Icons.menu,
                title: 'Katalog',
              ),
              ListTileDrawer(
                selected: _tabController.index == 2,
                onTap: () => _goToTab(2),
                icon: Icons.newspaper,
                title: 'Berita',
              ),
              ListTileDrawer(
                selected: _tabController.index == 3,
                onTap: () => _goToTab(3),
                icon: Icons.photo_library,
                title: 'Galeri',
              ),
              ListTileDrawer(
                selected: _tabController.index == 4,
                onTap: () => _goToTab(4),
                icon: Icons.music_note,
                title: 'Lagu',
              ),
              ListTileDrawer(
                selected: _tabController.index == 5,
                onTap: () => _goToTab(5),
                icon: Icons.supervisor_account_sharp,
                title: 'Tim',
              ),
            ],
          ),
        ),

        floatingActionButton: ChatFloatingWidget(),

        bottomNavigationBar: Footer(color: Color(0xFFF4A9C2)),
      ),
    );
  }
}
