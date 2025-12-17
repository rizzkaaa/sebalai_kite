import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:uts/controllers/auth_controller.dart';
import 'package:uts/models/user_model.dart';
import 'package:uts/screens/home_screen.dart';
import 'package:uts/services/auth_service.dart';
import 'package:uts/widgets/footer.dart';
import 'package:uts/widgets/icon_action_appbar.dart';
import 'package:uts/widgets/text_form_field_edit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final AuthService _service = AuthService();
  UserModel? userData;

  bool isLoading = true;
  String? error;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _showCameraIcon = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final user = await _service.getProfile();
      setState(() {
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
    final formKey = GlobalKey<FormState>();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final newPasswordController = TextEditingController();
    final oldPasswordController = TextEditingController();

    usernameController.text = userData!.username;
    emailController.text = userData!.email;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),

          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB64BC9), Color(0xFFFFAFF4)],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Edit Profil",
                      style: GoogleFonts.lora(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          TextFormFieldEdit(
                            controller: usernameController,
                            label: 'Username',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Username tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                          TextFormFieldEdit(
                            controller: emailController,
                            label: 'Email',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email tidak boleh kosong";
                              }
                              if (!value.contains('@')) {
                                return "Masukkan email yang valid";
                              }
                              return null;
                            },
                          ),
                          TextFormFieldEdit(
                            controller: newPasswordController,
                            label: "Password Baru",
                            validator: (value) {
                              if (value != null &&
                                  value.isNotEmpty &&
                                  value.length < 6) {
                                return "Minimal 6 karakter";
                              }
                              return null;
                            },
                          ),
                          TextFormFieldEdit(
                            controller: oldPasswordController,
                            label: "Password Lama",
                            validator: (value) {
                              if (newPasswordController.text.isNotEmpty &&
                                  (value == null || value.isEmpty)) {
                                return "Masukan Password yang Benar";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 45,
                                    decoration: inset.BoxDecoration(
                                      color: Color(0xFFFFAFF4),
                                      boxShadow: [
                                        inset.BoxShadow(
                                          color: Colors.black45.withOpacity(
                                            0.5,
                                          ),
                                          blurRadius: 2,
                                          offset: Offset(3, -3),
                                          inset: true,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Batal",
                                          style: GoogleFonts.judson(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Container(
                                    height: 45,
                                    decoration: inset.BoxDecoration(
                                      color: Color(0xFFB64BC9),
                                      boxShadow: [
                                        inset.BoxShadow(
                                          color: Colors.black45.withOpacity(
                                            0.5,
                                          ),
                                          blurRadius: 2,
                                          offset: Offset(3, -3),
                                          inset: true,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (!formKey.currentState!.validate())
                                          return;

                                        try {
                                          await _service.updateProfile(
                                            username: usernameController.text
                                                .trim(),
                                            email: emailController.text.trim(),
                                            oldPassword:
                                                oldPasswordController.text,
                                            newPassword:
                                                newPasswordController.text,
                                          );

                                          Navigator.pop(context);
                                          _loadProfile();

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Profil berhasil diperbarui",
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text("Gagal update: $e"),
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Simpan",
                                          style: GoogleFonts.judson(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            height: 230,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFAFF4), Color(0xFFB64BC9)],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Konfimasi Keluar",
                    style: GoogleFonts.lora(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "Anda yakin ingin keluar?",
                      style: GoogleFonts.josefinSans(
                        color: Color(0xFFB64BC9),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        "Batal",
                        style: GoogleFonts.josefinSans(
                          color: Color(0xFFFFAFF4),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _service.logout();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFAFF4),
                      ),
                      child: Text(
                        "Okay!",
                        style: GoogleFonts.josefinSans(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
                              ),
                            );
                          },
                        ),
                        IconActionAppbar(
                          icon: Icons.logout_rounded,
                          onPressed: _confirmLogout,
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
                    userData!.username,
                    style: GoogleFonts.josefinSans(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Divider(color: Color(0xFFE0E0E0), thickness: 1),
                  SizedBox(height: 20),

                  // Email
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

                  // Telepon
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
