import 'package:flutter/material.dart';
import 'package:servinow_mobile/screens/auth/cadastro_screen.dart';
import 'package:servinow_mobile/screens/auth/forgot_password_screen.dart';
import 'package:servinow_mobile/screens/auth/login_screen.dart';
import 'package:servinow_mobile/core/widgets/downbar.dart';
import 'package:servinow_mobile/screens/servico/home_screen.dart';
import 'package:servinow_mobile/screens/menu/sobre_nos.dart';
import 'package:servinow_mobile/screens/menu/termos_de_uso.dart';

void main() {
  runApp(const ServinowApp());
}

class ServinowApp extends StatelessWidget {
  const ServinowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ServiNow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/home',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const CadastroScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/sobre-nos': (context) => const SobreNosScreen(),
        '/termos-uso': (context) => const TermosDeUsoScreen(),

      },
    );
  }
}
