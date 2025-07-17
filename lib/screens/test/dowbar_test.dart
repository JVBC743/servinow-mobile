import 'package:flutter/material.dart';
import 'package:servinow_mobile/core/widgets/downbar.dart'; 

class DownBarTeste extends StatefulWidget {
  const DownBarTeste({super.key});

  @override
  State<DownBarTeste> createState() => _DownBarTesteState();
}

class _DownBarTesteState extends State<DownBarTeste> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    Center(child: Text('Página Início')),
    Center(child: Text('Página Agendamentos')),
    Center(child: Text('Página Perfil')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: DownBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
