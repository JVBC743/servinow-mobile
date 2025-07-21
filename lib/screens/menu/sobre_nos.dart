import 'package:flutter/material.dart';
import 'package:servinow_mobile/core/widgets/downbar.dart';

class SobreNosScreen extends StatelessWidget {
  const SobreNosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final integrantes = [
      {'nome': 'Matheus Pantoja de Morais', 'imagem': 'assets/matheus.jpg'},
      {
        'nome': 'Manoel de Jesus Moreira de Aguiar',
        'imagem': 'assets/manoel.png',
      },
      {'nome': 'José Claion Martins de Sousa', 'imagem': 'assets/claion.png'},
      {'nome': 'João Victor Brum de Castro', 'imagem': 'assets/joao.png'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Sobre Nós')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Olá! Somos um grupo sem fins lucrativos, afinal, o que importa para nós é aquela nota boa que devemos ter no final do semestre! Brincadeiras à parte, buscamos oferecer os melhores sistemas para cada contexto que os nossos clientes (no caso, o professor) solicitarem.\n\nAlém disso, se quiser, revise os Termos de Compromisso e de Privacidade que o site oferece aos nossos clientes.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(179, 0, 0, 0),
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 32),
            const Text(
              'Integrantes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 24,
              runSpacing: 24,
              children: integrantes.map((integrante) {
                return Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        integrante['imagem']!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      integrante['nome']!,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const DownBar(currentIndex: 1),
    );
  }
}
