import 'package:flutter/material.dart';

class DownBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap; // opcional se quiser override

  const DownBar({Key? key, required this.currentIndex, this.onTap})
    : super(key: key);

  void _handleTap(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
    }

    // Navega para a rota correspondente
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
      case 1:
       Navigator.pushReplacementNamed(context, '/termos-uso');
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
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Desconectar',
        ),
      ],
    );
  }
}
