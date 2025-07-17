import 'package:flutter/material.dart';

class DownBar extends StatelessWidget {
  final int currentIndex;

  final Function(int) onTap;

  const DownBar({Key? key, required this.currentIndex, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,

      backgroundColor: Color(0xFF7DCCD8),
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0xFF4879BF),
      showUnselectedLabels: false,

      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Agendamentos',
        ),
        // BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ],
    );
  }
}
