import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:servinow_mobile/core/utils/validators.dart';
import 'package:servinow_mobile/core/services/cep_service.dart';

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

  // FocusNode para o campo CEP
  final FocusNode cepFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    cepFocusNode.addListener(() async {
      // Quando perder foco do campo CEP, tenta buscar o endereço
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

  void _submit() {
    print('Cadastro concluído');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildStep1(),
          _buildStep2(),
          _buildStep3(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _nextStep,
          child: Text(_currentStep < 2 ? 'Próximo' : 'Cadastrar'),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Form(
      key: _formKeys[0],
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: nomeController,
            decoration: const InputDecoration(labelText: 'Nome'),
            validator: (value) =>
                value == null || value.isEmpty ? 'Informe seu nome' : null,
          ),
          TextFormField(
            controller: cpfController,
            decoration: const InputDecoration(labelText: 'CPF'),
            inputFormatters: [cpfMaskFormatter],
            validator: validateCPF,
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: nascimentoController,
            decoration:
                const InputDecoration(labelText: 'Data de Nascimento'),
            keyboardType: TextInputType.datetime,
            inputFormatters: [nascimentoMaskFormatter],
            validator: validateMaiorDeIdade,
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) =>
                value != null && value.contains('@') ? null : 'Email inválido',
          ),
          TextFormField(
            controller: telefoneController,
            decoration: const InputDecoration(labelText: 'Telefone'),
            inputFormatters: [telefoneMaskFormatter],
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return Form(
      key: _formKeys[1],
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: cepController,
            focusNode: cepFocusNode,
            decoration: const InputDecoration(labelText: 'CEP'),
            keyboardType: TextInputType.number,
            inputFormatters: [cepMaskFormatter],
            validator: (value) =>
                value == null || value.length < 9 ? 'CEP inválido' : null,
          ),
          TextFormField(
            controller: logradouroController,
            decoration: const InputDecoration(labelText: 'Logradouro'),
          ),
          TextFormField(
            controller: numeroController,
            decoration: const InputDecoration(labelText: 'Número'),
          ),
          TextFormField(
            controller: complementoController,
            decoration: const InputDecoration(labelText: 'Complemento'),
          ),
          TextFormField(
            controller: bairroController,
            decoration: const InputDecoration(labelText: 'Bairro'),
          ),
          TextFormField(
            controller: cidadeController,
            decoration: const InputDecoration(labelText: 'Cidade'),
          ),
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
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: senhaController,
            decoration: const InputDecoration(labelText: 'Senha'),
            obscureText: true,
            validator: validateSenhaSegura,
          ),
          TextFormField(
            controller: repetirSenhaController,
            decoration: const InputDecoration(labelText: 'Repetir Senha'),
            obscureText: true,
            validator: (value) =>
                value == senhaController.text ? null : 'Senhas não coincidem',
          ),
        ],
      ),
    );
  }
}
