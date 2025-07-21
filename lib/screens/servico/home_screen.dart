import 'package:flutter/material.dart';
import 'package:servinow_mobile/core/utils/connectivity_util.dart';
import 'package:servinow_mobile/core/services/servico_service.dart';
import 'package:servinow_mobile/core/widgets/servico_card.dart';
import 'package:servinow_mobile/core/widgets/downbar.dart';
import 'package:servinow_mobile/core/services/auth_service.dart';
import 'package:servinow_mobile/core/services/agendamento_service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> servicos = [];
  List<Map<String, dynamic>> categorias = [];
  bool loading = true;
  bool hasInternet = true;
  String searchText = '';
  int? categoriaSelecionada;

  final TextEditingController _searchController = TextEditingController();

  int _selectedIndex = 0; // índice da DownBar
  int? usuarioLogadoId;

  @override
  void initState() {
    super.initState();

    // Executa após o frame inicial
    Future.microtask(() async {
      final logado = await _verificarLogin();
      if (logado) {
        final usuario = await AuthService.getUser();
        setState(() {
          usuarioLogadoId = usuario?['id'];
        });
        await _carregarServicosECategorias();
      }
    });

    _searchController.addListener(() {
      final texto = _searchController.text;
      if (texto != searchText) {
        searchText = texto;
        _carregarServicosECategorias();
      }
    });
  }

  // Verifica se o usuário está logado
  Future<bool> _verificarLogin() async {
    final token = await AuthService.isLoggedIn();

    if (!token) {
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _carregarServicosECategorias() async {
    final conectado = await ConnectivityUtil.hasInternetConnection();
    if (!conectado) {
      setState(() {
        hasInternet = false;
        loading = false;
      });
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final data = await ServicoService.listarServicosECategorias(
        search: searchText,
        categoriaId: categoriaSelecionada,
      );

      setState(() {
        servicos = data['servicos'];
        categorias = data['categorias'];
        hasInternet = true;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao carregar serviços: $e')));
    }
  }

  void _showAgendamentoDialog(BuildContext context, int idServico) {
    final _dataController = TextEditingController();
    final _descricaoController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    final _dataMaskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
    );
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Agendar Serviço'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _dataController,
                    inputFormatters: [_dataMaskFormatter],
                    decoration: const InputDecoration(
                      labelText: 'Data do agendamento',
                      hintText: 'dd/mm/aaaa',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a data';
                      }
                      if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
                        return 'Formato inválido';
                      }
                      return null;
                    },
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        _dataController.text =
                            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descricaoController,
                    decoration: const InputDecoration(
                      labelText: 'Descrição da solicitação',
                      hintText: 'Descreva sua necessidade (20-50 caracteres)',
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLength: 50,
                    minLines: 2,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a descrição';
                      }
                      if (value.length < 20) {
                        return 'Mínimo 20 caracteres';
                      }
                      if (value.length > 50) {
                        return 'Máximo 50 caracteres';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          setState(() => isLoading = true);
                          try {
                            final dados = {
                              'id_servico': idServico.toString(),
                              'data': _dataController.text,
                              'descricao': _descricaoController.text,
                            };
                            final sucesso = await AgendamentoService.Agendar(
                              dados,
                            );
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  sucesso
                                      ? 'Agendamento enviado com sucesso!'
                                      : 'Erro ao agendar serviço.',
                                ),
                              ),
                            );
                          } catch (e) {
                            setState(() => isLoading = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Erro ao agendar serviço: ${e.toString()}',
                                ),
                              ),
                            );
                          }
                        }
                      },
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Agendar'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!hasInternet) {
      return Scaffold(
        appBar: AppBar(title: const Text('Serviços')),
        body: const Center(child: Text('Sem conexão com a internet.')),
        bottomNavigationBar: DownBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Serviços')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar serviço',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                labelText: 'Filtrar por categoria',
              ),
              value: categoriaSelecionada,
              isExpanded: true,
              items: [
                const DropdownMenuItem<int>(
                  value: null,
                  child: Text('Todas categorias'),
                ),
                ...categorias.map(
                  (cat) => DropdownMenuItem<int>(
                    value: cat['id'] as int?,
                    child: Text(cat['nome'] ?? 'Categoria sem nome'),
                  ),
                ),
              ],
              onChanged: (valor) {
                setState(() {
                  categoriaSelecionada = valor;
                });
                _carregarServicosECategorias();
              },
            ),
          ),
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _carregarServicosECategorias,
                    child: servicos.isEmpty
                        ? const Center(
                            child: Text('Nenhum serviço encontrado.'),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: servicos.length,
                            itemBuilder: (_, index) {
                              final servico = Map<String, dynamic>.from(
                                servicos[index],
                              );

                              final categoriaMap = servico['categoria_r'];
                              String nomeCategoria = 'Sem categoria';

                              if (categoriaMap != null && categoriaMap is Map) {
                                nomeCategoria =
                                    categoriaMap['nome'] ?? nomeCategoria;
                              }

                              return ServicoCard(
                                imageUrl: servico['url_foto'] ?? '',
                                title:
                                    servico['nome_servico'] ??
                                    'Serviço sem nome',
                                category: nomeCategoria,
                                description: servico['desc_servico'] ?? '',
                                preco: servico['preco'] != null
                                    ? 'R\$ ${servico['preco']}'
                                    : null,
                                idProvedor: servico['prestador']?['id'],
                                idUsuarioLogado:
                                    usuarioLogadoId, // agora síncrono!
                                onPressed: () {
                                  _showAgendamentoDialog(
                                    context,
                                    servico['id'],
                                  );
                                },
                              );
                            },
                          ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: DownBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
