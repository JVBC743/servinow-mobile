import 'dart:convert';
import 'package:http/http.dart' as http;

class CepService {
  static Future<Map<String, dynamic>?> buscarEndereco(String cep) async {
    try {
      final url = Uri.parse('https://brasilapi.com.br/api/cep/v1/$cep');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'street': data['street'],
          'neighborhood': data['neighborhood'],
          'city': data['city'],
          'state': data['state'],
        };
      }
    } catch (e) {
      print('Erro ao buscar CEP: $e');
    }
    return null;
  }
}

