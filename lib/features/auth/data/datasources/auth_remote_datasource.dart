
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import '../repositories/auth_repository_impl.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
    required String accountType,
  });

  Future<void> logout();

  Future<UserModel> getCurrentUser();

  Future<void> forgotPassword({required String email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AuthRemoteDataSourceImpl({required this.client, required this.baseUrl});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
    required String accountType,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'account_type': accountType,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return UserModel.fromJson(jsonData['user']);
      } else if (response.statusCode == 401) {
        throw ServerException('Invalid credentials');
      } else {
        throw ServerException('Login failed');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error occurred');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw ServerException('Logout failed');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error occurred');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    // TODO: Implement getting user from local storage/cache
    throw CacheException('No cached user found');
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/auth/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode != 200) {
        throw ServerException('Failed to send reset email');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error occurred');
    }
  }
}
