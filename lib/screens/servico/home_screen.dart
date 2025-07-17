// home_screen.dart
import 'package:flutter/material.dart';
import 'package:servinow_mobile/core/utils/connectivity_util.dart';
import 'package:servinow_mobile/core/services/servico_service.dart';
import 'package:servinow_mobile/core/widgets/servico_card.dart';

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
  int? categoriaSelecionada; // categoria selecionada pelo usuário

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarServicosECategorias();
    _searchController.addListener(() {
      final texto = _searchController.text;
      if (texto != searchText) {
        searchText = texto;
        _carregarServicosECategorias();
      }
    });
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

  @override
  Widget build(BuildContext context) {
    if (!hasInternet) {
      return Scaffold(
        appBar: AppBar(title: const Text('Serviços')),
        body: const Center(child: Text('Sem conexão com a internet.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Serviços'), automaticallyImplyLeading: false,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar serviço',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          // Listener chamará _carregarServicosECategorias
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Dropdown para seleção de categoria
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonFormField<int>(
              decoration: InputDecoration(
                labelText: 'Filtrar por categoria',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Agendamento não implementado ainda',
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
