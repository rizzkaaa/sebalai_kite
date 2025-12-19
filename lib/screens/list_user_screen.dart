import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts/models/user_model.dart';
import 'package:uts/screens/list_pengajuan_screen.dart';
import 'package:uts/services/auth_service.dart';
import 'package:uts/services/pengajuan_service.dart';
import 'package:uts/widgets/dialog_confirm.dart';
import 'package:uts/widgets/icon_action_appbar.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({super.key});

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  final AuthService authService = AuthService();
  final PengajuanService pengajuanService = PengajuanService();
  late Future<List<UserModel>> dataUsers;
  String? userID;
  String? userLevel;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getString('userId');
      userLevel = prefs.getString('userLevel');
    });
  }

  void _loadUser() {
    setState(() {
      if (_searchQuery.isEmpty) {
        dataUsers = authService.getAllUsers();
      } else {
        dataUsers = authService.searchUserByEmail(_searchQuery);
      }
    });
  }

  void _refresh() {
    setState(() {
      dataUsers = authService.getAllUsers();
    });
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    setState(() {
      _searchQuery = query;
    });
    _loadUser();
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
    });
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Daftar Pengguna",
          style: GoogleFonts.neuton(color: Color(0xFFC97DAF), fontSize: 25),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: IconActionAppbar(
            tooltip: "kembali",
            icon: Icons.reply,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade400, width: 1),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4A9C2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Cari email...',
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                            onSubmitted: (value) {
                              _performSearch();
                            },
                          ),
                        ),
                        _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                onPressed: _clearSearch,
                              )
                            : Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              ),
                      ],
                    ),
                  ),
                ),

                StreamBuilder<int>(
                  stream: pengajuanService.getCount(),
                  builder: (context, snapshot) {
                    final unreadCount = snapshot.data ?? 0;

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        IconActionAppbar(
                          tooltip: "Daftar Ajuan",
                          icon: Icons.inbox_outlined,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListPengajuanScreen(),
                              ),
                            );
                          },
                        ),
                        if (unreadCount > 0)
                          Positioned(
                            top: -5,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Color(0xFFB832B6),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$unreadCount',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: FutureBuilder(
                future: dataUsers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Tidak ada saran'));
                  }

                  final users = snapshot.data!;

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];

                      return Container(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          left: 8,
                        ),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: inset.BoxDecoration(
                          color: Color(0xFFF8E8ED),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            inset.BoxShadow(
                              color: const Color(0xFF8B8181).withOpacity(0.1),
                              offset: const Offset(2, 2),
                              blurRadius: 5,
                              inset: true,
                            ),
                            inset.BoxShadow(
                              color: const Color(0xFFB4A8A8).withOpacity(0.25),
                              offset: const Offset(-5, -5),
                              blurRadius: 5,
                              inset: true,
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            "${user.username} ${user.docId != userID && user.role == 'admin' ? '(admin)' : ''}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(user.email),
                          leading: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundImage:
                                  (user.photo.toString().isNotEmpty)
                                  ? authService.getImageProvider(user.photo)
                                  : AssetImage(
                                          'assets/images/default-profile.png',
                                        )
                                        as ImageProvider,
                            ),
                          ),
                          trailing: user.docId != userID && user.isActive
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return DialogConfirm(
                                              title: "Konfirmasi",
                                              deskripsi: user.role == 'user'
                                                  ? "Anda yakin ingin menjadikan pengguna ini sebagai admin?"
                                                  : "Anda yakin ingin menjadikan admin ini sebagai pengguna biasa?",
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                await authService.setAdmin(
                                                  user.role == 'user',
                                                  user.docId!,
                                                );
                                                _refresh();
                                              },
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        user.role == 'user'
                                            ? Icons.person_add_rounded
                                            : Icons.person_remove_rounded,
                                        color: Color(0xFFC97DAF),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return DialogConfirm(
                                              title: "Konfirmasi",
                                              deskripsi:
                                                  "Anda yakin ingin menghapus akun pengguna ini?",
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                await authService.deleteAccount(
                                                  user.docId!,
                                                );
                                                _refresh();
                                                await pengajuanService.deletePengajuan(user.docId!);
                                              },
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Color(0xFFC97DAF),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                    ),
                                  ],
                                )
                              : Text(
                                  "${user.docId == userID
                                      ? '(anda)'
                                      : !user.isActive
                                      ? '(inactive)'
                                      : null}",
                                ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
