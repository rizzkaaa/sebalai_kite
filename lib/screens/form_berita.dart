import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uts/services/berita_service.dart';
import 'package:uts/widgets/form_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uts/widgets/text_form_field_form_input.dart';

class FormBerita extends StatefulWidget {
  const FormBerita({super.key});

  @override
  State<FormBerita> createState() => _FormBeritaState();
}

class _FormBeritaState extends State<FormBerita> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _jmlParagController = TextEditingController();
  final BeritaService beritaService = BeritaService();
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  bool _showCameraIcon = false;
  int jmlParagraf = 0;

  @override
  void dispose() {
    _judulController.dispose();
    _tanggalController.dispose();
    _deskripsiController.dispose();
    _jmlParagController.dispose();
    super.dispose();
  }

  void handleSubmit() async {
    print("ok");
    // if (isLoading) return;
    // if (!formKey.currentState!.validate()) return;
    // setState(() => isLoading = true);
    // try {
    //   final String message = _messageController.text.trim();
    //   await saranService.createSaran(widget.idUser, message);
    //   if (!mounted) return;
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(const SnackBar(content: Text("Saran berhasil dikirim")));
    //   Navigator.pop(context);
    // } catch (e) {
    //   if (!mounted) return;
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(SnackBar(content: Text("Gagal mengirim saran")));
    // } finally {
    //   if (mounted) {
    //     setState(() => isLoading = false);
    //   }
    // }
  }

  void handleReset() {
    setState(() {
      _judulController.clear();
      _tanggalController.clear();
      _deskripsiController.clear();
      _jmlParagController.clear();
    });
    Navigator.pop(context);
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
    
    return FormInput(
      formKey: formKey,
      titleForm: "Form Berita",
      fieldsInput: Container(
        padding: const EdgeInsets.all(25),
        height: 470,
        decoration: BoxDecoration(
          color: Color(0xFFF3D8E6),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ListView(
          children: [
            Text(
              "Banner Berita:",
              style: GoogleFonts.katibeh(
                color: Color(0xFFC063BE),
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showCameraIcon = !_showCameraIcon;
                });
              },
              child: Stack(
                clipBehavior: Clip.none,

                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEDBDD8).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Color(0xFFAB79AC), width: 3),
                      image: DecorationImage(
                        image: AssetImage('assets/images/default-profile.png'),
                        fit: BoxFit.contain,
                      ),
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
                            border: Border.all(color: Colors.white, width: 3),
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
            TextFormFieldFormInput(
              controller: _judulController,
              label: "Judul Berita:",
            ),
            const SizedBox(height: 20),
            TextFormFieldFormInput(
              controller: _tanggalController,
              label: "Tanggal:",
            ),
            const SizedBox(height: 20),
            TextFormFieldFormInput(
              controller: _deskripsiController,
              label: "Deskripsi:",
              maxLine: 5,
            ),
            const SizedBox(height: 20),
            TextFormFieldFormInput(
              controller: _jmlParagController,
              label: "Jumlah Paragraf:",
              number: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  jmlParagraf = int.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),

            if (jmlParagraf > 0)
              Column(
                children: [
                  Text(
                    "Paragraf",
                    style: GoogleFonts.katibeh(
                      color: Color(0xFFC063BE),
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextFormField(
                    // controller: controller,
                    maxLines: 5,
                    style: TextStyle(color: Color(0xFFAB79AC)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFEDBDD8).withOpacity(0.8),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: Color(0xFFAB79AC),
                          width: 3,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: Color(0xFFAB79AC),
                          width: 3,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      handleReset: handleReset,
      handleSubmit: handleSubmit,
    );
  }
}
