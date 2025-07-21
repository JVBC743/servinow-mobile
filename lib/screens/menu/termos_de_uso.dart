import 'package:flutter/material.dart';
import 'package:servinow_mobile/core/widgets/downbar.dart';

class TermosDeUsoScreen extends StatelessWidget {
  const TermosDeUsoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : Colors.black;
    final bodyColor = isDark ? Colors.white70 : Colors.black87;
    final bulletColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Termos de Uso e Política de Privacidade'),
      ),
      bottomNavigationBar: const DownBar(currentIndex: 2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('1 - Objetivo', titleColor),
              _buildSectionContent(
                'O sistema ServiNow tem o objetivo de facilitar a conexão entre clientes e prestadores de serviço, por meio de funcionalidades como agendamento, avaliação e gerenciamento de serviços, acessíveis em diversos dispositivos.',
                bodyColor,
              ),
              _buildSectionTitle('2 - Funcionalidades', titleColor),
              _buildSectionContent(
                '2.1 O sistema oferece as seguintes funcionalidades:',
                bodyColor,
              ),
              _buildBulletList(
                [
                  'Cadastro e login de usuário;',
                  'Cadastro e gerenciamento de serviços;',
                  'Agendamento de serviços;',
                  'Avaliação de serviços prestados;',
                  'Canal de denúncias;',
                  'Configurações de conta;',
                  'Geração de relatórios e controle de histórico;',
                  'Busca por categorias e prestadores.',
                ],
                bulletColor,
                bodyColor,
              ),
              _buildSectionTitle(
                '3 - Responsabilidades do Usuário',
                titleColor,
              ),
              _buildSubSectionTitle('3.1 Conduta Geral', titleColor),
              _buildBulletList(
                [
                  'Agir de forma ética, respeitosa e conforme as leis brasileiras;',
                  'Fornecer informações verdadeiras e atualizadas;',
                  'Não praticar discriminação, discurso de ódio ou assédio;',
                  'Respeitar os limites técnicos e operacionais da plataforma.',
                ],
                bulletColor,
                bodyColor,
              ),
              _buildSubSectionTitle('3.2 Proibições', titleColor),
              _buildBulletList(
                [
                  'Propor, anunciar ou solicitar serviços de natureza sexual, prostituição ou semelhantes;',
                  'Anunciar, vender ou divulgar produtos ilegais ou sem autorização legal;',
                  'Utilizar linguagem ofensiva ou xingamentos diretos em avaliações ou interações indevidas;',
                  'Enviar avaliações sequenciais com objetivo de manipular ou sobrecarregar a listagem de comentários (“flood”);',
                  'Tentar fraudar ou manipular o sistema de reputação da plataforma.',
                ],
                bulletColor,
                bodyColor,
              ),
              _buildSubSectionTitle('3.3 Penalidades', titleColor),
              _buildBulletList(
                [
                  'Advertência;',
                  'Suspensão temporária da conta;',
                  'Banimento permanente do usuário.',
                ],
                bulletColor,
                bodyColor,
              ),
              _buildSubSectionTitle('3.4 Usuário como Cliente', titleColor),
              _buildSectionContent(
                'O cliente é responsável por verificar a confiabilidade dos prestadores antes de efetuar o agendamento, e por utilizar os recursos da plataforma de maneira consciente.',
                bodyColor,
              ),
              _buildSubSectionTitle(
                '3.5 Usuário como Prestador de Serviços',
                titleColor,
              ),
              _buildSectionContent(
                'O prestador deve garantir a veracidade das informações fornecidas, manter conduta profissional e cumprir com os prazos e condições oferecidos.',
                bodyColor,
              ),
              _buildSectionTitle('4 - Privacidade', titleColor),
              _buildSectionContent(
                'A ServiNow atua apenas como intermediadora e não compartilha informações dos usuários com terceiros, salvo por obrigação legal. Os dados são utilizados unicamente para o funcionamento do sistema.',
                bodyColor,
              ),
              _buildSectionTitle('4.1 Denúncia', titleColor),
              _buildSectionContent(
                'A plataforma disponibiliza um meio para denúncia de condutas inadequadas, que são os e-mails dos desenvolvedores, disponibilizados no item 6. Todas as denúncias são analisadas pela equipe do ServiNow com confidencialidade e imparcialidade.',
                bodyColor,
              ),
              _buildSectionTitle('5 - Proteção de Dados', titleColor),
              _buildSectionContent(
                'Os dados dos usuários (nome, e-mail, preferências, avaliações, etc.) são armazenados com segurança, conforme a Lei Geral de Proteção de Dados (LGPD - Lei nº 13.709/2018). O usuário pode solicitar a atualização ou exclusão de seus dados a qualquer momento.',
                bodyColor,
              ),
              _buildSectionTitle('6 - Disposições Finais', titleColor),
              _buildSectionContent(
                'A ServiNow poderá alterar estes Termos de Uso e Política de Privacidade a qualquer momento, com aviso prévio por e-mail ou na própria plataforma. O uso contínuo após as alterações indica concordância com os novos termos.',
                bodyColor,
              ),
              _buildSectionContent(
                'E-mails dos desenvolvedores:\n'
                'José Claion Martins de Sousa (joseclaionmartins@gmail.com)\n'
                'João Victor Brum de Castro (joaovictor.brumc@gmail.com)\n'
                'Matheus Pantoja de Morais (mateus4pantoja@gmail.com)\n'
                'Manoel de Jesus Moreira de Aguiar (manoelmaguiar@gmail.com)',
                bodyColor,
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildSubSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4, left: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
      child: Text(content, style: TextStyle(fontSize: 16, color: color)),
    );
  }

  Widget _buildBulletList(
    List<String> items,
    Color bulletColor,
    Color textColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: TextStyle(fontSize: 16, color: bulletColor),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 16, color: textColor),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
