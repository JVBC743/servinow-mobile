import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:servinow_mobile/core/services/cep_service.dart';
import 'package:servinow_mobile/core/services/cadastro_service.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _pageController = PageController();
  int _currentStep = 0;

  final _formKeys = List.generate(3, (_) => GlobalKey<FormState>());

  // Formatadores
  final cpfMaskFormatter = MaskTextInputFormatter(mask: '###.###.###-##');
  final telefoneMaskFormatter = MaskTextInputFormatter(mask: '(##) #####-####');
  final nascimentoMaskFormatter = MaskTextInputFormatter(mask: '##/##/####');
  final cepMaskFormatter = MaskTextInputFormatter(mask: '#####-###');

  // Controllers
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final nascimentoController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();

  final cepController = TextEditingController();
  final logradouroController = TextEditingController();
  final numeroController = TextEditingController();
  final ufController = TextEditingController();
  final complementoController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();

  final senhaController = TextEditingController();
  final repetirSenhaController = TextEditingController();

  final FocusNode cepFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    cepFocusNode.addListener(() async {
      if (!cepFocusNode.hasFocus) {
        final cep = cepController.text.replaceAll(RegExp(r'[^0-9]'), '');
        if (cep.length == 8) {
          final endereco = await CepService.buscarEndereco(cep);
          if (endereco != null) {
            setState(() {
              logradouroController.text = endereco['street'] ?? '';
              bairroController.text = endereco['neighborhood'] ?? '';
              cidadeController.text = endereco['city'] ?? '';
              ufController.text = endereco['state'] ?? '';
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    cepFocusNode.dispose();
    super.dispose();
  }

  void _nextStep() async {
    final isValid = _formKeys[_currentStep].currentState!.validate();
    if (!isValid) return;

    if (_currentStep < 2) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      _submit();
    }
  }

  void _backStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  String _formatarData(String dataBr) {
    try {
      final partes = dataBr.split('/');
      if (partes.length != 3) return dataBr;

      final dia = int.parse(partes[0]);
      final mes = int.parse(partes[1]);
      final ano = int.parse(partes[2]);

      final data = DateTime(ano, mes, dia);
      return '${data.year.toString().padLeft(4, '0')}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return dataBr; // retorna como está se não conseguir formatar
    }
  }

  void _submit() async {
    final dadosCadastro = {
      'nome': nomeController.text.trim(),
      'cpf_cnpj': cpfController.text.replaceAll(RegExp(r'[^0-9]'), ''),
      'data_nascimento': _formatarData(nascimentoController.text.trim()),
      'email': emailController.text.trim(),
      'telefone': telefoneController.text.replaceAll(RegExp(r'[^0-9]'), ''),
      'cep': cepController.text.replaceAll(RegExp(r'[^0-9]'), ''),
      'logradouro': logradouroController.text.trim(),
      'numero': numeroController.text.trim(),
      'complemento': complementoController.text.trim(),
      'bairro': bairroController.text.trim(),
      'cidade': cidadeController.text.trim(),
      'uf': ufController.text.trim(),
      'password': senhaController.text,
      'password_confirmation': repetirSenhaController.text,
    };

    try {
      final sucesso = await CadastroService.cadastrar(dadosCadastro);
      if (sucesso) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastro realizado com sucesso!')),
        );
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao realizar cadastro. Verifique os dados.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro inesperado: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4879BF), Color(0xFF7FBFC9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                height: 150,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo.png', width: 300, height: 150),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildStep1(),
                            _buildStep2(),
                            _buildStep3(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _currentStep > 0
                              ? ElevatedButton.icon(
                                  onPressed: _backStep,
                                  icon: const Icon(Icons.arrow_back),
                                  label: const Text('Voltar'),
                                )
                              : ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.of(
                                      context,
                                    ).pushReplacementNamed('/login');
                                  },
                                  icon: const Icon(Icons.login),
                                  label: const Text('Já tenho conta'),
                                ),
                          ElevatedButton(
                            onPressed: _nextStep,
                            child: Text(
                              _currentStep < 2 ? 'Próximo' : 'Cadastrar',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Form(
      key: _formKeys[0],
      child: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            controller: nomeController,
            decoration: const InputDecoration(labelText: 'Nome'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: cpfController,
            inputFormatters: [cpfMaskFormatter],
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'CPF'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: nascimentoController,
            inputFormatters: [nascimentoMaskFormatter],
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(labelText: 'Data de Nascimento'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: telefoneController,
            inputFormatters: [telefoneMaskFormatter],
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Telefone'),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return Form(
      key: _formKeys[1],
      child: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            controller: cepController,
            focusNode: cepFocusNode,
            inputFormatters: [cepMaskFormatter],
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'CEP'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: logradouroController,
            decoration: const InputDecoration(labelText: 'Logradouro'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: numeroController,
            decoration: const InputDecoration(labelText: 'Número'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: complementoController,
            decoration: const InputDecoration(labelText: 'Complemento'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: bairroController,
            decoration: const InputDecoration(labelText: 'Bairro'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: cidadeController,
            decoration: const InputDecoration(labelText: 'Cidade'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: ufController,
            decoration: const InputDecoration(labelText: 'UF'),
          ),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return Form(
      key: _formKeys[2],
      child: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            controller: senhaController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Senha'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: repetirSenhaController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Repetir Senha'),
            validator: (value) =>
                value == senhaController.text ? null : 'Senhas não coincidem',
          ),
        ],
      ),
    );
  }
}
