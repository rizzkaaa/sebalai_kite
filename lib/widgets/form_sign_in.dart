import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uts/controllers/auth_controller.dart';
import 'package:uts/screens/user_profile_screen.dart';

class FormSignIn extends StatefulWidget {
  const FormSignIn({super.key});

  @override
  State<FormSignIn> createState() => _FormSignInState();
}

class _FormSignInState extends State<FormSignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginController = context.watch<AuthController>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                label: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text("Email"),
                ),
                labelStyle: GoogleFonts.montserrat(
                  color: Color(0xFF6F05D2),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                filled: true,
                fillColor: Colors.white54,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF6F05D2), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF6F05D2), width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email tidak boleh kosong";
                }
                if (!value.contains('@')) {
                  return "Masukkan email yang valid";
                }
                return null;
              },
              style: GoogleFonts.montserrat(
                color: Colors.black45,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 40),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                label: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text("Password"),
                ),
                labelStyle: GoogleFonts.montserrat(
                  color: Color(0xFF6F05D2),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                filled: true,
                fillColor: Colors.white54,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF6F05D2), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF6F05D2), width: 2),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.black45,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password tidak boleh kosong";
                }
                if (value.length < 6) {
                  return "Minimal 6 karakter";
                }
                return null;
              },
              style: GoogleFonts.montserrat(
                color: Colors.black45,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loginController.isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;

                        final success = await loginController.login(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );

                        if (success) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UserProfileScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(loginController.error!)),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF600F8F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: loginController.isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Masuk",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
