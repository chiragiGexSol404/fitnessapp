import 'package:fitnessapp/componet/app_snackbar.dart';
import 'package:fitnessapp/sharedPref/app_sharedPref.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import '../services/api_service.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();
  AppSharedPref? appSharedPref;

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxString token = ''.obs;
  final RxBool isLoggedIn = false.obs;

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      error.value = '';
      final loginRequest = LoginRequest(username: username, password: password);
      final loginResponse = await _apiService.login(loginRequest);
      token.value = loginResponse.token ?? "";
      isLoggedIn.value = true;
      if (loginResponse.token?.isNotEmpty == true) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("login", true);
        AppSnackbar.success('Success', 'Login successful!');
        Get.offNamed('/users');
      } else {
        AppSnackbar.error(
          'Error',
          loginResponse.errorMessage.isNotEmpty
              ? loginResponse.errorMessage
              : 'Login failed. Please try again.',
        );
      }
    } catch (e) {
      error.value = e.toString();
      AppSnackbar.error('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    token.value = '';
    await appSharedPref?.clear();
    Get.offAllNamed('/login');
  }
}
