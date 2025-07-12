import 'package:fitnessapp/componet/common_button.dart';
import 'package:fitnessapp/componet/common_textformfiled.dart';
import 'package:fitnessapp/componet/common_validation.dart';
import 'package:fitnessapp/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class AddEditUserView extends StatefulWidget {
  final User? user;
  final bool isEditing;
  const AddEditUserView({super.key, this.user, this.isEditing = false});

  @override
  State<AddEditUserView> createState() => _AddEditUserViewState();
}

class _AddEditUserViewState extends State<AddEditUserView> {
  final _formKey = GlobalKey<FormState>();
  final UserController userController = Get.find<UserController>();

  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(
      text: widget.user?.username ?? '',
    );
    _emailController = TextEditingController(text: widget.user?.email ?? '');
    _passwordController = TextEditingController(
      text: widget.user?.password ?? '',
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      appBar: AppBar(
        foregroundColor: AppColor.whiteColor,
        title: Text(
          widget.isEditing ? 'Edit User' : 'Add User',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            // color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: AppColor.primaryColor),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 24),

            // Username Field
            CommonTextFormField(
              label: 'Username',
              controller: _usernameController,
              prefixIcon: Icons.person,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
                if (value.length < 3) {
                  return 'Username must be at least 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Email Field
            CommonTextFormField(
              label: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email,
              validator: CommonValidation.validateEmail,
            ),
            const SizedBox(height: 20),

            // Password Field
            CommonTextFormField(
              label: 'Password',
              controller: _passwordController,
              isPassword: true,
              prefixIcon: Icons.lock,
              validator: CommonValidation.validatePassword,
            ),
            const SizedBox(height: 40),
            Obx(
              () => CommonButton(
                label: widget.isEditing ? 'Update User' : 'Add User',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _submitForm();
                  }
                },
                color: AppColor.primaryColor,
                isLoading: widget.isEditing
                    ? userController.isUpdatingUser.value
                    : userController.isAddingUser.value,
                icon: widget.isEditing ? Icons.update : Icons.add,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _submitForm() {
    if (_formKey.currentState!.validate()) {
      final user = User(
        id: widget.user?.id,
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (widget.isEditing) {
        userController.updateUser(user);
      } else {
        userController.addUser(user);
      }
    }
  }
}
