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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Agendamentos em desenvolvimento')),
        );
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Perfil em desenvolvimento')),
        );
        break;
      case 3:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Menu em desenvolvimento')),
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
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Agendamentos',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
      ],
    );
  }
}
