import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/widgets/form_sign_in.dart';

class SignInScreen extends StatelessWidget {
  final Function(bool) changePage;
  const SignInScreen({super.key, required this.changePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => changePage(false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Registrasi",
                        style: GoogleFonts.junge(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Image.asset(
                'assets/images/decorasi_signin.png',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                "SELAMAT\nDATANG!",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  height: 1,
                ),
              ),
              SizedBox(height: 20),
              FormSignIn(),
            ],
          ),
        ),
      ),
    );
  }
}
