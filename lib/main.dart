import 'package:flutter/material.dart';
import 'package:servinow_mobile/screens/auth/cadastro_screen.dart';
import 'package:servinow_mobile/screens/auth/forgot_password_screen.dart';
import 'package:servinow_mobile/screens/auth/login_screen.dart';
import 'package:servinow_mobile/core/widgets/downbar.dart';
import 'package:servinow_mobile/screens/perfil/editar_perfil.dart';
import 'package:servinow_mobile/screens/servico/home_screen.dart';
import 'package:servinow_mobile/screens/menu/sobre_nos.dart';
import 'package:servinow_mobile/screens/menu/termos_de_uso.dart';
import 'package:servinow_mobile/core/theme/app_theme.dart';
import 'package:servinow_mobile/screens/info/menu_screem.dart';
import 'package:servinow_mobile/screens/servico/servicos_agendados.dart';
import 'package:servinow_mobile/screens/perfil/visualizar_perfil.dart';
import 'package:servinow_mobile/core/services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<int?> _getUsuarioId() async {
    final usuario = await AuthService.getUser();
    return usuario?['id'];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ServiNow',
      theme: AppTheme.lightTheme,
      initialRoute: '/home',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const CadastroScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/sobre-nos': (context) => const SobreNosScreen(),
        '/termos-uso': (context) => const TermosDeUsoScreen(),
        '/menu': (context) => const MenuScreen(),
        '/agendamentos': (context) => const ServicosAgendadosScreen(),
        '/perfil': (context) => FutureBuilder<int?>(
          future: _getUsuarioId(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return VisualizarPerfilScreen(usuarioId: snapshot.data!);
          },
        ),
        '/editar-perfil': (context) => FutureBuilder<int?>(
          future: _getUsuarioId(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return EditarPerfilScreen(usuarioId: snapshot.data!);
          },
        ),
      },
    );
  }
}
