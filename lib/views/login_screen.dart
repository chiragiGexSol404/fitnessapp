import 'package:fitnessapp/componet/common_button.dart';
import 'package:fitnessapp/componet/common_textformfiled.dart';
import 'package:fitnessapp/componet/common_validation.dart';
import 'package:fitnessapp/controllers/auth_controller.dart';
import 'package:fitnessapp/util/app_color.dart';
import 'package:fitnessapp/util/app_image_path.dart';
import 'package:fitnessapp/util/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: _buildBody(),
    );
  }

  _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildHeaderWidget(),
            const SizedBox(height: 20),
            _buildFormWidget(),
            const SizedBox(height: 20),
            _buildSignUpWidget(),
          ],
        ),
      ),
    );
  }

  _buildHeaderWidget() {
    return Column(
      children: [
        SvgPicture.asset(AppImagePath.login, width: 220, height: 220),
        const SizedBox(height: 20),
        Text(
          AppString.login,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Welcome back! Please login to your account.",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: AppColor.hintTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  _buildFormWidget() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            CommonTextFormField(
              label: AppString.username,
              controller: usernameController,
              keyboardType: TextInputType.text,
              validator: CommonValidation.validateUsername,
              prefixIcon: Icons.person_outline,
              focusNode: usernameFocusNode,
              isFilled: true,
              fillColor: AppColor.inputFillColor,
            ),
            const SizedBox(height: 16),
            CommonTextFormField(
              label: AppString.password,
              controller: passwordController,
              isPassword: true,
              validator: CommonValidation.validatePassword,
              prefixIcon: Icons.lock_outline,
              focusNode: passwordFocusNode,
              isFilled: true,
              fillColor: AppColor.inputFillColor,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  AppString.forgotPassword,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: CommonButton(
                label: AppString.login,
                color: AppColor.primaryColor,
                isLoading: authController.isLoading.value,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authController.login(
                      usernameController.text,
                      passwordController.text,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildSignUpWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Sign Up",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
