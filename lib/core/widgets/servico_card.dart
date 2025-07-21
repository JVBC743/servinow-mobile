import 'package:flutter/material.dart';

class ServicoCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final String description;
  final String? preco;
  final VoidCallback? onPressed;
  final int? idProvedor;
  final int? idUsuarioLogado;

  const ServicoCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.description,
    this.preco,
    this.onPressed,
    this.idProvedor,
    this.idUsuarioLogado,
  });

  @override
  Widget build(BuildContext context) {
    final isMeuServico =
        idProvedor != null &&
        idUsuarioLogado != null &&
        idProvedor == idUsuarioLogado;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📷 Imagem
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 160,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported),
              ),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  height: 160,
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),

          // 📄 Conteúdo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (preco != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          preco!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(category, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Text(description, maxLines: 3, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),

          // 💰 Rodapé com botão ou aviso
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isMeuServico)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Seu serviço aqui',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                else
                  ElevatedButton(
                    onPressed: onPressed,
                    child: const Text('Agendar'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
