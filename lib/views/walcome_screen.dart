import 'package:fitnessapp/util/app_image_path.dart';
import 'package:fitnessapp/util/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <-- Import Animate

class WalcomeScreen extends StatefulWidget {
  const WalcomeScreen({super.key});

  @override
  State<WalcomeScreen> createState() => _WalcomeScreenState();
}

class _WalcomeScreenState extends State<WalcomeScreen> {
  bool isLogin = false;
  void getLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isLogin = preferences.getBool("login") ?? false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getLogin();
    Future.delayed(const Duration(seconds: 3), () async {
      if (isLogin) {
        Get.offNamed("/users");
      } else {
        Get.offNamed("/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImagePath.splash, width: 300, height: 300)
                    .animate()
                    .fadeIn(duration: 1.seconds)
                    .scale(duration: 1.seconds),

                const SizedBox(height: 20),

                Text(
                      AppString.welcome,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    )
                    .animate()
                    .slideY(begin: 1, end: 0, duration: 800.ms)
                    .fadeIn(duration: 800.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
