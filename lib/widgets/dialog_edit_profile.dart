import 'package:flutter/material.dart';
import 'package:uts/models/user_model.dart';
import 'package:uts/services/auth_service.dart';
import 'package:uts/widgets/text_form_field_edit.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;
import 'package:google_fonts/google_fonts.dart';

class DialogEditProfile extends StatelessWidget {
  final UserModel userData;
  final VoidCallback loadProfile;

  DialogEditProfile({
    super.key,
    required this.userData,
    required this.loadProfile,
  });
  
  final AuthService _service = AuthService();

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    usernameController.text = userData.username;
    emailController.text = userData.email;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
                                      color: Colors.black45.withOpacity(0.5),
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
                                      color: Colors.black45.withOpacity(0.5),
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
                                        oldPassword: oldPasswordController.text,
                                        newPassword: newPasswordController.text,
                                      );

                                      Navigator.pop(context);
                                      loadProfile();

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
  }
}
