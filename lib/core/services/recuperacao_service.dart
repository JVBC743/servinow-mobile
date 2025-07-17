import 'package:servinow_mobile/core/services/api_service.dart';

class RecuperacaoService {
  static Future<bool> enviarRecuperacaoPorTelefone(String telefone) async {
    final response = await ApiService.post(
      '/recuperar-senha',
      {'telefone': telefone},
      useAuth: false,
    );

    return response.statusCode == 200;
  }
}
