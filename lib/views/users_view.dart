import 'package:fitnessapp/controllers/auth_controller.dart';
import 'package:fitnessapp/controllers/user_controller.dart';
import 'package:fitnessapp/models/user_model.dart';
import 'package:fitnessapp/util/app_color.dart';
import 'package:fitnessapp/util/app_string.dart';
import 'package:fitnessapp/views/add_edit_user_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersView extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final AuthController authController = Get.put(AuthController());

  UsersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: _buildAppBarWidget(),
      body: SafeArea(child: _buildBodyWidget()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addUser,
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.whiteColor,
        icon: const Icon(Icons.add),
        label: Text(AppString.addUser, style: GoogleFonts.poppins()),
      ),
    );
  }

  Obx _buildBodyWidget() {
    return Obx(() {
      if (userController.isLoading.value) {
        return _buildLoadingState();
      } else if (userController.error.value.isNotEmpty) {
        return _buildErrorState();
      } else if (userController.users.isEmpty) {
        return _buildEmptyState();
      } else {
        return RefreshIndicator(
          onRefresh: () async => await userController.fetchUsers(),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 16, bottom: 80),
            itemCount: userController.users.length,
            itemBuilder: (context, index) {
              final user = userController.users[index];
              return AnimatedUserCard(
                user: user,
                index: index,
                onTap: () => _showUserDetails(user),
                onEdit: () => _editUser(user),
                onDelete: () => userController.deleteUser(user.id!),
              );
            },
          ),
        );
      }
    });
  }

  _buildAppBarWidget() {
    return AppBar(
      title: Text(
        AppString.usersManagement,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: AppColor.whiteColor,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.primaryColor,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: AppColor.whiteColor),
          onPressed: () async {
            authController.logout();
            Get.offNamed("/login");
          },
        ),
      ],
    );
  }

  _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColor.primaryColor),
          const SizedBox(height: 20),
          Text(
            AppString.loadingUsers,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: AppColor.redColor.withAlpha(100),
          ),
          const SizedBox(height: 16),
          Text(
            AppString.errorLoadingUsers,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              userController.error.value,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: AppColor.greyColor),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => userController.fetchUsers(),
            icon: const Icon(Icons.refresh),
            label: Text(AppString.retry, style: GoogleFonts.poppins()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              foregroundColor: AppColor.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 80,
            color: AppColor.greyColor.withAlpha(100),
          ),
          const SizedBox(height: 16),
          Text(
            AppString.noUsersFound,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppString.addFirstUser,
            style: GoogleFonts.poppins(color: AppColor.greyColor),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _addUser,
            icon: const Icon(Icons.add),
            label: Text(
              AppString.addUser,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.blueColorShaed300,
              foregroundColor: AppColor.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showUserDetails(User user) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue.shade100,
                    child: Icon(Icons.person, color: AppColor.primaryColor),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.username,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.email,
                          style: GoogleFonts.poppins(color: AppColor.greyColor),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.back();
                        _editUser(user);
                      },
                      icon: const Icon(Icons.edit),
                      label: Text(AppString.edit, style: GoogleFonts.poppins()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        foregroundColor: AppColor.whiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.back();
                        _confirmDelete(user);
                      },
                      icon: const Icon(Icons.delete),
                      label: Text(
                        AppString.delete,
                        style: GoogleFonts.poppins(),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.lightredColor,
                        foregroundColor: AppColor.rgbRedColorlight,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addUser() =>
      Get.to(() => AddEditUserView(isEditing: false, user: null));

  void _editUser(User user) =>
      Get.to(() => AddEditUserView(isEditing: true, user: user));

  void _confirmDelete(User user) {
    Get.dialog(
      AlertDialog(
        title: Text(AppString.deleteUser, style: GoogleFonts.poppins()),
        content: Text(
          '${AppString.confirmDelete} ${user.username}?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(AppString.cancel, style: GoogleFonts.poppins()),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              userController.deleteUser(user.id!);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
            ),
            child: Text(AppString.delete, style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }
}

class AnimatedUserCard extends StatelessWidget {
  final User user;
  final int index;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AnimatedUserCard({
    super.key,
    required this.user,
    required this.index,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Hero(
            tag: 'user_${user.id}',
            child: Card(
              elevation: 8,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade50, AppColor.whiteColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: _buildAvatar(),
                  title: Text(
                    user.displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.email,
                            size: 16,
                            color: AppColor.greyColor,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              user.email,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 16,
                            color: AppColor.greyColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            user.username,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Obx(
                    () =>
                        userController.isDeletingUser.value &&
                            userController.deletingUserId.value == user.id
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  onTap: onTap,
                ),
              ),
            ),
          ),
        )
        .animate(delay: Duration(milliseconds: index * 100))
        .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOutCubic)
        .fadeIn(duration: 600.ms, curve: Curves.easeOutCubic);
  }

  _buildAvatar() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.primaryColor,
            AppColor.primaryColor,
            const Color.fromRGBO(25, 118, 210, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withAlpha(77),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          user.initials,
          style: const TextStyle(
            color: AppColor.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(AppString.deleteUser, style: GoogleFonts.poppins()),
        content: Text(
          '${AppString.confirmDelete} ${user.displayName}?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(AppString.cancel, style: GoogleFonts.poppins()),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              onDelete?.call();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.redColor,
              foregroundColor: AppColor.whiteColor,
            ),
            child: Text(AppString.delete, style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }
}
