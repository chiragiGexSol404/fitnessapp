import 'package:fitnessapp/componet/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiService _apiService = ApiService();

  final RxList<User> users = <User>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isAddingUser = false.obs;
  final RxBool isUpdatingUser = false.obs;
  final RxBool isDeletingUser = false.obs;
  final RxString error = ''.obs;
  final RxInt deletingUserId = 0.obs;

  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    fetchUsers();
  }

  void _initializeAnimations() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: animationController,
            curve: Curves.elasticOut,
          ),
        );

    animationController.forward();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      error.value = '';

      final fetchedUsers = await _apiService.getUsers();
      users.value = fetchedUsers;

      animationController.reset();
      animationController.forward();
    } catch (e) {
      error.value = e.toString();
      AppSnackbar.error('Failed to fetch users', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addUser(User user) async {
    try {
      isAddingUser.value = true;
      error.value = '';

      final newUser = await _apiService.addUser(user);

      users.add(newUser);

      Get.back();
      AppSnackbar.success("Success", "User added successfully!");
    } catch (e) {
      error.value = e.toString();
      AppSnackbar.error('Failed to add user', e.toString());
    } finally {
      isAddingUser.value = false;
    }
  }

  Future<void> updateUser(User user) async {
    try {
      isUpdatingUser.value = true;
      error.value = '';

      final updatedUser = await _apiService.updateUser(user);

      final index = users.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        users[index] = updatedUser;
      }
      print("User updated successfully");
      Get.back();
      AppSnackbar.success('Success', 'User updated successfully!');
    } catch (e) {
      error.value = e.toString();
      AppSnackbar.error('Failed to update user', e.toString());
    } finally {
      isUpdatingUser.value = false;
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      isDeletingUser.value = true;
      deletingUserId.value = id;
      error.value = '';

      await _apiService.deleteUser(id);

      users.removeWhere((user) => user.id == id);

      AppSnackbar.success('Success', 'User deleted successfully!');
    } catch (e) {
      error.value = e.toString();
      AppSnackbar.error('Failed to delete user', e.toString());
    } finally {
      isDeletingUser.value = false;
      deletingUserId.value = 0;
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
