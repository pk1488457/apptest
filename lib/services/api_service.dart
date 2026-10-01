import 'dart:convert';

import 'package:apptest/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((user) => UserModel.fromJson(user)).toList();
    } 
     else if (response.statusCode == 400) {
      throw Exception("Bad request");
    } 
    else if (response.statusCode == 404) {
      throw Exception("User not found");
    }
    else {
      throw Exception('Failed to load users');
    }
  }

  Future<UserModel> fetchUserById(int id) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users/$id'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body);

      return UserModel.fromJson(data);
    } 
     else if (response.statusCode == 400) {
      throw Exception("Bad request");
    } 
    else if (response.statusCode == 404) {
      throw Exception("User not found");
    }
    else {
      throw Exception('Failed to load user details');
    }
  }
}