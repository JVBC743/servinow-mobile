import 'package:flutter/material.dart';
import 'package:servinow_mobile/screens/auth/cadastro_screen.dart';
import 'package:servinow_mobile/screens/auth/login_screen.dart';
import 'package:servinow_mobile/core/widgets/downbar.dart';
import 'package:servinow_mobile/screens/test/dowbar_test.dart'; //REMOVER DPS

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
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const Placeholder(),
        '/register': (context) => const CadastroScreen(),
        '/downbar-teste': (context) => const DownBarTeste(), //REMOVER DPS, CALMA JOSÉ, É SÓ UM TESTE
      },
    );
  }
}
