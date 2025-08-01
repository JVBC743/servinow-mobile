import 'dart:convert';
import 'api_service.dart';

class AgendamentoService {
  static Future<bool> Agendar(Map<String, dynamic> dados) async {
    final response = await ApiService.post(
      '/agendamentos',
      dados,
      useAuth: true,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = json.decode(response.body);
      return true;
    } else {
      final data = json.decode(response.body);
      final errorMsg = data['message'] ?? 'Erro desconhecido no cadastro';
      throw Exception(errorMsg);
    }
  }

  static Future<List<Map<String, dynamic>>> buscarAgendamentos() async {
    final response = await ApiService.get('/agendamentos', useAuth: true);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final agendamentos = data['agendamentos'] as List<dynamic>? ?? [];
      return agendamentos.map((e) => Map<String, dynamic>.from(e)).toList();
    } else {
      throw Exception('Erro ao buscar agendamentos');
    }
  }
}
