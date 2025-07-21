import 'package:flutter/material.dart';
import 'package:servinow_mobile/core/services/usuario_service.dart';
import 'package:servinow_mobile/core/services/cep_service.dart';
import 'package:servinow_mobile/core/widgets/downbar.dart';

class EditarPerfilScreen extends StatefulWidget {
  final int usuarioId;
  const EditarPerfilScreen({super.key, required this.usuarioId});

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic>? usuario;
  bool isLoading = false;
  bool buscandoCep = false;

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _cepController = TextEditingController();
  final _logradouroController = TextEditingController();
  final _numeroController = TextEditingController();
  final _complementoController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _ufController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarUsuario();
  }

  Future<void> _carregarUsuario() async {
    final perfil = await UsuarioService.buscarUsuario(widget.usuarioId);
    setState(() {
      usuario = perfil?['usuario'];
      _nomeController.text = usuario?['nome'] ?? '';
      _emailController.text = usuario?['email'] ?? '';
      _telefoneController.text = usuario?['telefone'] ?? '';
      _descricaoController.text = usuario?['descricao'] ?? '';
      _cepController.text = usuario?['cep'] ?? '';
      _logradouroController.text = usuario?['logradouro'] ?? '';
      _numeroController.text = usuario?['numero'] ?? '';
      _complementoController.text = usuario?['complemento'] ?? '';
      _bairroController.text = usuario?['bairro'] ?? '';
      _cidadeController.text = usuario?['cidade'] ?? '';
      _ufController.text = usuario?['uf'] ?? '';
    });
  }

  Future<void> _buscarEnderecoPorCep() async {
    final cep = _cepController.text.replaceAll(RegExp(r'\D'), '');
    if (cep.length != 8) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('CEP inválido')));
      return;
    }
    setState(() => buscandoCep = true);
    final endereco = await CepService.buscarEndereco(cep);
    setState(() => buscandoCep = false);
    if (endereco != null) {
      _logradouroController.text = endereco['street'] ?? '';
      _bairroController.text = endereco['neighborhood'] ?? '';
      _cidadeController.text = endereco['city'] ?? '';
      _ufController.text = endereco['state'] ?? '';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Endereço não encontrado para o CEP')),
      );
    }
  }

  Future<void> _salvar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => isLoading = true);

    final dados = {
      'nome': _nomeController.text,
      'email': _emailController.text,
      'telefone': _telefoneController.text,
      'descricao': _descricaoController.text,
      'cep': _cepController.text,
      'logradouro': _logradouroController.text,
      'numero': _numeroController.text,
      'complemento': _complementoController.text,
      'bairro': _bairroController.text,
      'cidade': _cidadeController.text,
      'uf': _ufController.text,
    };

    try {
      final resultado = await UsuarioService.editarUsuario(
        widget.usuarioId,
        dados,
      );
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );
      Navigator.of(
        context,
      ).pushReplacementNamed('/perfil', arguments: widget.usuarioId);
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao atualizar perfil: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Perfil')),
      body: usuario == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Informe o nome'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Informe o email'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _telefoneController,
                      decoration: const InputDecoration(labelText: 'Telefone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Informe o telefone'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descricaoController,
                      decoration: const InputDecoration(labelText: 'Descrição'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _cepController,
                      decoration: InputDecoration(
                        labelText: 'CEP',
                        suffixIcon: buscandoCep
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: _buscarEnderecoPorCep,
                              ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 9,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Informe o CEP';
                        if (value.replaceAll(RegExp(r'\D'), '').length != 8) {
                          return 'CEP inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _logradouroController,
                      decoration: const InputDecoration(
                        labelText: 'Logradouro',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _numeroController,
                      decoration: const InputDecoration(labelText: 'Número'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _complementoController,
                      decoration: const InputDecoration(
                        labelText: 'Complemento',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _bairroController,
                      decoration: const InputDecoration(labelText: 'Bairro'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _cidadeController,
                      decoration: const InputDecoration(labelText: 'Cidade'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _ufController,
                      decoration: const InputDecoration(labelText: 'UF'),
                      maxLength: 2,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _salvar,
                        child: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Salvar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: const DownBar(currentIndex: 3),
    );
  }
}
