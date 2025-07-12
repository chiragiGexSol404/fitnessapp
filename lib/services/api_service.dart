import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/user_model.dart';
import '../models/login_model.dart';

class ApiService {
  static const Duration _timeout = Duration(seconds: 30);

  Future<LoginModel> login(LoginRequest loginRequest) async {
    try {
      final response = await http
          .post(
            Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(loginRequest.toJson()),
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        return LoginModel.fromJson(json.decode(response.body));
      } else {
        final errorResponse = response.body;
        return LoginModel(errorMessage: errorResponse);
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  Future<List<User>> getUsers() async {
    try {
      final response = await http
          .get(
            Uri.parse('${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((user) => User.fromJson(user)).toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  // Get single user
  Future<User> getUser(int id) async {
    try {
      final response = await http
          .get(
            Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/$id',
            ),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }

  // Add new user
  Future<User> addUser(User user) async {
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(user.toJson()),
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding user: $e');
    }
  }

  // Update user
  Future<User> updateUser(User user) async {
    try {
      print("updateUser == ${user.toJson()}");
      final response = await http
          .put(
            Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/${user.id}',
            ),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(user.toJson()),
          )
          .timeout(_timeout);

      print("response body == ${response.body}");
      print("response statusCode == ${response.statusCode}");
      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  // Delete user
  Future<void> deleteUser(int id) async {
    try {
      final response = await http
          .delete(
            Uri.parse(
              '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/$id',
            ),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(_timeout);

      if (response.statusCode != 200) {
        throw Exception('Failed to delete user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }
}
