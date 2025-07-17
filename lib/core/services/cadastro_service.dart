import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class CadastroService {
  // Retorna true se o cadastro foi bem sucedido, false caso contrário
  static Future<bool> cadastrar(Map<String, dynamic> dados) async {
    final response = await ApiService.post('/register', dados);

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['token'];
      final usuario = data['usuario'];

      if (token != null && usuario != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('usuario', json.encode(usuario));
      }

      return true;
    } else {
      final data = json.decode(response.body);
      final errorMsg = data['message'] ?? 'Erro desconhecido no cadastro';
      throw Exception(errorMsg);
    }
  }
}
