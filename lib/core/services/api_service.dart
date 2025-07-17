import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl = 'http://localhost/api/v1';

  static Future<http.Response> post(String endpoint, Map<String, dynamic> data,
      {bool useAuth = false}) async {
    final headers = await _buildHeaders(useAuth);
    return await http.post(
      Uri.parse('$_baseUrl$endpoint'),
      body: data,
      headers: headers,
    );
  }

  static Future<http.Response> get(String endpoint, {bool useAuth = false}) async {
    final headers = await _buildHeaders(useAuth);
    return await http.get(Uri.parse('$_baseUrl$endpoint'), headers: headers);
  }

  static Future<Map<String, String>> _buildHeaders(bool useAuth) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return {
      'Accept': 'application/json',
      if (useAuth && token != null) 'Authorization': 'Bearer $token',
    };
  }
}
