import 'package:flutter/material.dart';
import 'package:servinow_mobile/core/services/agendamento_service.dart';
import 'package:servinow_mobile/core/widgets/downbar.dart';
import 'package:intl/intl.dart';

class ServicosAgendadosScreen extends StatefulWidget {
  const ServicosAgendadosScreen({super.key});

  @override
  State<ServicosAgendadosScreen> createState() =>
      _ServicosAgendadosScreenState();
}

class _ServicosAgendadosScreenState extends State<ServicosAgendadosScreen> {
  late Future<List<Map<String, dynamic>>> _agendamentosFuture;

  @override
  void initState() {
    super.initState();
    _agendamentosFuture = AgendamentoService.buscarAgendamentos();
  }

  String formatarData(String dataAmericana) {
    try {
      final date = DateTime.parse(dataAmericana);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return dataAmericana;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Serviços Agendados')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _agendamentosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final agendamentos = snapshot.data ?? [];
          if (agendamentos.isEmpty) {
            return const Center(child: Text('Nenhum serviço agendado.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: agendamentos.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final ag = agendamentos[index];
              final servico = ag['servico'] ?? {};
              final prestador = ag['prestador'] ?? {};
              final status =
                  ag['status_agendamento']?['status'] ?? 'Desconhecido';
              // Formata a data para BR
              final prazo =
                  ag['prazo_formatado'] ??
                  (ag['prazo'] != null ? formatarData(ag['prazo']) : '');

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        servico['nome_servico'] ?? 'Serviço sem nome',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Prestador: ${prestador['nome'] ?? 'Desconhecido'}'),
                      Text('Status: $status'),
                      Text('Prazo: $prazo'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const DownBar(currentIndex: 3),
    );
  }
}
