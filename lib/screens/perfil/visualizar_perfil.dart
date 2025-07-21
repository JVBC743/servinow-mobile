import 'package:flutter/material.dart';
import 'package:servinow_mobile/core/services/usuario_service.dart';
import 'package:servinow_mobile/core/widgets/downbar.dart';

class VisualizarPerfilScreen extends StatefulWidget {
  final int usuarioId;
  const VisualizarPerfilScreen({super.key, required this.usuarioId});

  @override
  State<VisualizarPerfilScreen> createState() => _VisualizarPerfilScreenState();
}

class _VisualizarPerfilScreenState extends State<VisualizarPerfilScreen> {
  late Future<Map<String, dynamic>?> _perfilFuture;

  @override
  void initState() {
    super.initState();
    _perfilFuture = UsuarioService.buscarUsuario(widget.usuarioId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _perfilFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final perfil = snapshot.data;
          if (perfil == null || perfil['usuario'] == null) {
            return const Center(child: Text('Usuário não encontrado.'));
          }
          final usuario = perfil['usuario'];
          final imagemUrl = perfil['imagem_url'];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar com efeito moderno
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyan.withOpacity(0.2),
                        blurRadius: 16,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 54,
                    backgroundColor: Colors.white,
                    backgroundImage: imagemUrl != null
                        ? NetworkImage(imagemUrl)
                        : null,
                    child: imagemUrl == null
                        ? const Icon(Icons.person, size: 54, color: Colors.grey)
                        : null,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  usuario['nome'] ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  usuario['email'] ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  usuario['telefone'] ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                if (usuario['cpf_cnpj'] != null)
                  Text(
                    'CPF/CNPJ: ${usuario['cpf_cnpj']}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                if (usuario['data_nascimento'] != null)
                  Text(
                    'Nascimento: ${usuario['data_nascimento']}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                const SizedBox(height: 16),
                if (usuario['formacao'] != null &&
                    usuario['formacao']['formacao'] != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.cyan.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.school, color: Colors.cyan),
                        const SizedBox(width: 8),
                        Text(
                          usuario['formacao']['formacao'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar Perfil'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/editar-perfil',
                        arguments: usuario['id'],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                if (usuario['descricao'] != null &&
                    usuario['descricao'].toString().isNotEmpty)
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Descrição:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(usuario['descricao']),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                // Endereço
                if (usuario['cep'] != null ||
                    usuario['logradouro'] != null ||
                    usuario['numero'] != null ||
                    usuario['bairro'] != null ||
                    usuario['cidade'] != null ||
                    usuario['uf'] != null)
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Endereço:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            [
                                  usuario['logradouro'],
                                  usuario['numero'],
                                  usuario['complemento'],
                                  usuario['bairro'],
                                  usuario['cidade'],
                                  usuario['uf'],
                                  usuario['cep'],
                                ]
                                .where(
                                  (e) => e != null && e.toString().isNotEmpty,
                                )
                                .join(', '),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const DownBar(currentIndex: 3),
    );
  }
}
