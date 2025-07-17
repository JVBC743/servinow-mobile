import 'dart:convert';
import 'package:servinow_mobile/core/services/api_service.dart';

class ServicoService {
  
  static Future<Map<String, dynamic>> listarServicosECategorias({String? search, int? categoriaId}) async {
    final queryParameters = <String, String>{};
    if (search != null && search.isNotEmpty) {
      queryParameters['search'] = search;
    }
    if (categoriaId != null) {
      queryParameters['categoria_id'] = categoriaId.toString();
    }

    final queryString = Uri(queryParameters: queryParameters).query;
    final url = '/servicos' + (queryString.isNotEmpty ? '?$queryString' : '');

    final response = await ApiService.get(url, useAuth: true);

    if (response.statusCode == 200) {
      final dynamic decoded = json.decode(response.body);

      if (decoded is Map<String, dynamic>) {
        if (decoded.containsKey('servicos') && decoded.containsKey('categorias')) {
          final servicosList = (decoded['servicos'] as List)
              .map((s) => Map<String, dynamic>.from(s))
              .toList();

          final categoriasList = (decoded['categorias'] as List)
              .map((c) => Map<String, dynamic>.from(c))
              .toList();

          return {
            'servicos': servicosList,
            'categorias': categoriasList,
          };
        } else {
          throw Exception('Resposta da API mal formatada');
        }
      } else {
        throw Exception('Formato inesperado da resposta da API');
      }
    } else {
      throw Exception('Erro ao carregar serviços');
    }
  }
}
