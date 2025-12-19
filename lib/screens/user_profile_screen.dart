import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:uts/controllers/auth_controller.dart';
import 'package:uts/models/user_model.dart';
import 'package:uts/screens/form_pengajuan.dart';
import 'package:uts/screens/home_screen.dart';
import 'package:uts/services/auth_service.dart';
import 'package:uts/services/pengajuan_service.dart';
import 'package:uts/widgets/dialog_confirm.dart';
import 'package:uts/widgets/footer.dart';
import 'package:uts/widgets/dialog_edit_profile.dart';
import 'package:uts/widgets/icon_action_appbar.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final AuthService _service = AuthService();
  final PengajuanService _pengajuanService = PengajuanService();
  UserModel? userData;

  bool isLoading = true;
  String? error;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _showCameraIcon = false;
  bool isUserInPengajuan = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final user = await _service.getProfile();
      final exists = await _pengajuanService.isUserInPengajuan(user.docId!);

      setState(() {
        if (exists) {
          isUserInPengajuan = true;
          print('User sudah punya pengajuan');
        } else {
          isUserInPengajuan = false;
          print('User belum punya pengajuan');
        }
        userData = user;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  void _editProfileForm() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogEditProfile(
          userData: userData!,
          loadProfile: _loadProfile,
        );
      },
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return DialogConfirm(
          title: "Konfirmasi Keluar",
          deskripsi: "Anda yakin ingin keluar?",
          onPressed: () async {
            await _service.logout();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          },
        );
      },
    );
  }

  void _confirmDeleteAcc() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return DialogConfirm(
          title: "Ajukan Hapus Akun",
          deskripsi: "Anda yakin ingin mengajukan penghapusan akun?",
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormPengajuan(idUser: userData!.docId!),
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage() async {
    print("klik!");

    PermissionStatus status = await Permission.photos.request();
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }

    print(status);

    if (!status.isGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Izin akses galeri ditolak')));
      return;
    }

    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
      imageQuality: 60,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileSize = await file.length();

      print("📁 File size: ${fileSize / 1024} KB");

      if (fileSize > 500 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gambar terlalu besar, pilih gambar lain')),
        );
        return;
      }

      setState(() {
        _image = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final uploadPhotoController = context.watch<AuthController>();

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Text("Error: $error");
    }

    if (userData == null) {
      return const Text("Data tidak ditemukan");
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipPath(
                    clipper: WaveClipperTwo(),
                    child: Container(
                      height: 280,
                      width: double.infinity,
                      color: Color(0xFFC4B0E9),
                    ),
                  ),
                ),

                Positioned(
                  top: 0,
                  left: 10,
                  right: 10,
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconActionAppbar(
                          icon: Icons.reply_rounded,
                          tooltip: "kembali",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
                              ),
                            );
                          },
                        ),
                        Row(
                          children: [
                            userData!.isActive
                                ? isUserInPengajuan
                                      ? IconActionAppbar(
                                          tooltip: "hapus akun",
                                          icon: Icons.auto_delete_rounded,
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) {
                                                return DialogConfirm(
                                                  title: "Pemberitahuan",
                                                  deskripsi:
                                                      "Akun anda sedang dalam proses penghapusan.",
                                                  onPressed: () =>
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen(),
                                                        ),
                                                      ),
                                                );
                                              },
                                            );
                                          },
                                        )
                                      : IconActionAppbar(
                                          tooltip: "hapus akun",
                                          icon: Icons.delete_forever_rounded,
                                          onPressed: _confirmDeleteAcc,
                                        )
                                : SizedBox(),
                            IconActionAppbar(
                              tooltip: "keluar",
                              icon: Icons.logout_rounded,
                              onPressed: _confirmLogout,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: -45,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showCameraIcon = !_showCameraIcon;
                      });
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 15,
                                spreadRadius: 2,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                (userData!.photo.toString().isNotEmpty)
                                ? _service.getImageProvider(userData!.photo)
                                : AssetImage(
                                        'assets/images/default-profile.png',
                                      )
                                      as ImageProvider,
                          ),
                        ),

                        AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: _showCameraIcon ? 1 : 0,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ),

                        AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: _showCameraIcon ? 1 : 0,
                          child: AnimatedScale(
                            duration: Duration(milliseconds: 300),
                            scale: _showCameraIcon ? 1 : 0,
                            curve: Curves.easeOutBack,
                            child: IgnorePointer(
                              ignoring: !_showCameraIcon,
                              child: Container(
                                width: 37,
                                height: 37,
                                decoration: BoxDecoration(
                                  color: Color(0xFFB1DC99),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    print("klik kamera!");

                                    await _pickImage();

                                    if (_image != null) {
                                      await uploadPhotoController.uploadPhoto(
                                        _image!,
                                      );
                                      await _loadProfile();
                                      setState(() {
                                        _showCameraIcon = false;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 80),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: GoogleFonts.josefinSans(
                      color: Color(0xFF847F7F),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "${userData!.username}  ${userData!.role == 'admin' ? '(admin)' : ''}",
                    style: GoogleFonts.josefinSans(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Divider(color: Color(0xFFE0E0E0), thickness: 1),
                  SizedBox(height: 20),

                  Text(
                    'Email',
                    style: GoogleFonts.josefinSans(
                      color: Color(0xFF847F7F),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    userData!.email,
                    style: GoogleFonts.josefinSans(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Divider(color: Color(0xFFE0E0E0), thickness: 1),
                  SizedBox(height: 20),

                  Text(
                    'Password',
                    style: GoogleFonts.josefinSans(
                      color: Color(0xFF847F7F),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '●●●●●●●●●●',
                    style: GoogleFonts.josefinSans(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Divider(color: Color(0xFFE0E0E0), thickness: 1),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _editProfileForm,
        backgroundColor: Color(0xFFF4A9C2),
        child: Icon(Icons.edit, color: Colors.white, size: 30),
      ),

      bottomNavigationBar: Footer(color: Color(0xFFC4B0E9)),
    );
  }
}
