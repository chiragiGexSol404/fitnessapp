import 'package:fitnessapp/componet/common_button.dart';
import 'package:fitnessapp/componet/common_textformfiled.dart';
import 'package:fitnessapp/componet/common_validation.dart';
import 'package:fitnessapp/util/app_color.dart';
import 'package:fitnessapp/util/app_image_path.dart';
import 'package:fitnessapp/util/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              SvgPicture.asset(AppImagePath.register, width: 240, height: 240),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CommonTextFormField(
                      label: AppString.fullName,
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: CommonValidation.validateName,
                      prefixIcon: Icons.person_outline,
                      focusNode: nameFocusNode,
                      isFilled: true,
                      isPassword: false,
                      fillColor: AppColor.whiteColor,
                    ),
                    const SizedBox(height: 16),
                    CommonTextFormField(
                      label: AppString.email,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: CommonValidation.validateEmail,
                      prefixIcon: Icons.email_outlined,
                      focusNode: emailFocusNode,
                      isFilled: true,
                      fillColor: AppColor.whiteColor,
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
                      fillColor: AppColor.whiteColor,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: CommonButton(
                        isLoading: false,
                        label: AppString.signUp,
                        color: AppColor.primaryColor,
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          AppString.alreadyHaveAccount,
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offNamed("/login");
                          },
                          child: Text(
                            AppString.signIn,
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
