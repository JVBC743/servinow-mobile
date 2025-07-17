import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  Map<String, dynamic>? _usuario;

  bool get isAuthenticated => _token != null;
  String? get token => _token;
  Map<String, dynamic>? get usuario => _usuario;

  Future<void> login(String email, String senha) async {
    const url = 'http://SEU_BACKEND/api/login'; // ajuste aqui

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
        body: {
          'email': email,
          'senha': senha, // corresponde ao nome da coluna no banco
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['token'] != null) {
        _token = data['token'];
        _usuario = data['usuario'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        await prefs.setString('usuario', jsonEncode(_usuario));

        notifyListeners();
      } else {
        throw Exception(data['message'] ?? 'Erro ao fazer login');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    _token = null;
    _usuario = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('usuario');
    notifyListeners();
  }

  Future<void> carregarUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    final usuarioStr = prefs.getString('usuario');

    if (_token != null && usuarioStr != null) {
      _usuario = jsonDecode(usuarioStr);
    }

    notifyListeners();
  }
}
