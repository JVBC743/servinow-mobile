import 'package:flutter/material.dart';
import 'package:servinow_mobile/core/services/recuperacao_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final telefoneController = TextEditingController();
  bool isLoading = false;
  String? error;
  String? successMessage;

  void _enviarRecuperacao() async {
    final telefone = telefoneController.text.trim();

    if (telefone.isEmpty) {
      setState(() {
        error = 'Por favor, insira um número de telefone válido.';
        successMessage = null;
      });
      return;
    }

    setState(() {
      isLoading = true;
      error = null;
      successMessage = null;
    });

    final sucesso = await RecuperacaoService.enviarRecuperacaoPorTelefone(
      telefone,
    );

    setState(() {
      isLoading = false;
      if (sucesso) {
        successMessage = 'Solicitação enviada com sucesso.';
        error = null;
      } else {
        error = 'Erro ao enviar solicitação. Tente novamente.';
        successMessage = null;
      }
    });
  }

  @override
  void dispose() {
    telefoneController.dispose();
    super.dispose();
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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Card com logo igual ao login
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Informe seu número de telefone para receber o código de recuperação.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: telefoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Telefone',
                            hintText: '(99) 99999-9999',
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (error != null)
                          Text(
                            error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        if (successMessage != null)
                          Text(
                            successMessage!,
                            style: const TextStyle(color: Colors.green),
                          ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/login',
                                  );
                                },
                                child: const Text('Voltar'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ElevatedButton(
                                      onPressed: _enviarRecuperacao,
                                      child: const Text('Enviar'),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
