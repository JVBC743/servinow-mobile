import 'package:flutter/material.dart';
import 'package:servinow_mobile/core/services/auth_service.dart';

class DownBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap; // opcional se quiser override

  const DownBar({Key? key, required this.currentIndex, this.onTap})
    : super(key: key);

  void _handleTap(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
    }

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/sobre-nos');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/termos-uso');
        break;
      case 3:
        showDialog(
          context: context,
          barrierDismissible: false, // impede fechar o diálogo tocando fora
          builder: (ctx) {
            bool isLoading = false;

            return StatefulBuilder(
              builder: (ctx, setState) {
                return AlertDialog(
                  title: const Text('Sair do App'),
                  content: isLoading
                      ? SizedBox(
                          height: 60,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const Text('Tem certeza que deseja sair?'),
                  actions: isLoading
                      ? []
                      : [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () async {
                              setState(() => isLoading = true);

                              await AuthService.logout();

                              // Fecha o diálogo após logout
                              Navigator.pop(ctx);

                              // Navega para login limpando histórico
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/login',
                                (route) => false,
                              );
                            },
                            child: const Text('Sair'),
                          ),
                        ],
                );
              },
            );
          },
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) => _handleTap(context, index),
      backgroundColor: const Color(0xFF7DCCD8),
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color(0xFF4879BF),
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Sobre nós'),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Termos de Uso'),
        BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Desconectar'),
      ],
    );
  }
}
