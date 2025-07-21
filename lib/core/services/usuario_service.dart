import 'dart:convert';
import 'api_service.dart';

class UsuarioService {
  static Future<Map<String, dynamic>?> buscarUsuario(int id) async {
    final response = await ApiService.get('/usuario/$id', useAuth: true);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Retorna o objeto completo!
    } else {
      throw Exception('Erro ao buscar usuário');
    }
  }

  static Future<bool> editarUsuario(int id, Map<String, dynamic> dados,) async {
    final response = await ApiService.post(
      '/usuario/$id',
      dados,
      useAuth: true,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final data = json.decode(response.body);
      final errorMsg = data['message'] ?? 'Erro ao editar usuário';
      throw Exception(errorMsg);
    }
  }
}
