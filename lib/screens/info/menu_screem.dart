import 'package:flutter/material.dart';
import 'package:servinow_mobile/core/services/auth_service.dart';
import 'package:servinow_mobile/core/widgets/downbar.dart';
import 'package:servinow_mobile/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  ThemeMode _themeMode = MyApp.themeModeNotifier.value;

  @override
  void initState() {
    super.initState();
    _carregarTemaSalvo();
  }

  Future<void> _carregarTemaSalvo() async {
    final prefs = await SharedPreferences.getInstance();
    final themeStr = prefs.getString('theme_mode');
    setState(() {
      switch (themeStr) {
        case 'ThemeMode.dark':
          _themeMode = ThemeMode.dark;
          break;
        case 'ThemeMode.light':
          _themeMode = ThemeMode.light;
          break;
        default:
          _themeMode = ThemeMode.system;
      }
      MyApp.themeModeNotifier.value = _themeMode;
    });
  }

  Future<void> _salvarTemaEscolhido(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode.toString());
  }

  void _trocarTema(ThemeMode novoModo) {
    setState(() {
      _themeMode = novoModo;
    });
    MyApp.themeModeNotifier.value = novoModo;
    _salvarTemaEscolhido(novoModo);
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair'),
        content: const Text('Deseja realmente sair da sua conta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sair'),
          ),
        ],
      ),
    );

    if (result == true) {
      await AuthService.logout();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _MenuOption(
            label: 'Perfil',
            icon: Icons.person,
            onTap: () {
              Navigator.pushNamed(context, '/perfil');
            },
          ),
          const Divider(),
          _MenuOption(
            label: 'Serviços agendados',
            icon: Icons.calendar_today,
            onTap: () {
              Navigator.pushNamed(context, '/agendamentos');
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.brightness_6,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Tema', style: TextStyle(fontSize: 18)),
            subtitle: Text(
              _themeMode == ThemeMode.system
                  ? 'Automático'
                  : _themeMode == ThemeMode.dark
                  ? 'Escuro'
                  : 'Claro',
            ),
            trailing: DropdownButton<ThemeMode>(
              value: _themeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('Automático'),
                ),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Claro')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Escuro')),
              ],
              onChanged: (mode) {
                if (mode != null) _trocarTema(mode);
              },
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          const Divider(),
          _MenuOption(
            label: 'Logout',
            icon: Icons.logout,
            onTap: () {
              _confirmLogout(context);
            },
          ),
          const Divider(),
        ],
      ),
      bottomNavigationBar: const DownBar(currentIndex: 3),
    );
  }
}

class _MenuOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuOption({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(label, style: const TextStyle(fontSize: 18)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
