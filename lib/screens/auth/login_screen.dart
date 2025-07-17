import 'package:flutter/material.dart';
import 'package:servinow_mobile/core/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  bool isLoading = false;
  String? error;

  void _login() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    final success = await AuthService.login(
      emailController.text.trim(),
      senhaController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        error = 'E-mail ou senha inválidos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4879BF), Color(0xFF7FBFC9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Card pílula
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/logo.png', width: 300, height: 150),
                    ],
                  ),
                ),

                // Card do formulário
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'E-mail',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: senhaController,
                          obscureText: true,
                          decoration: const InputDecoration(labelText: 'Senha'),
                        ),
                        const SizedBox(height: 16),
                        if (error != null) ...[
                          Text(
                            error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 8),
                        ],
                        isLoading
                            ? const CircularProgressIndicator()
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: _login,
                                          child: const Text('Entrar'),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/register',
                                            );
                                          },
                                          child: const Text('Cadastrar'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/forgot-password',
                                      );
                                    },
                                    child: const Text(
                                      'Esqueci minha senha',
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),

                // SÓ TENTANDO, REMOVER DAKI
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700], 
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/downbar-teste');
                  },
                  child: const Text('Testar DownBar (pular login)'),
                ),
                const SizedBox(height: 16), 
                // ATÉ AKI

                const SizedBox(height: 32), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
