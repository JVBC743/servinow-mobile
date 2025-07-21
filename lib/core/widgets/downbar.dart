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
        Navigator.pushReplacementNamed(context, '/menu');
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
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_drive_file),
          label: 'Termos de Uso',
        ), // ícone alterado
        BottomNavigationBarItem(icon: Icon(Icons.menu_open), label: 'Menu'),
      ],
    );
  }
}
