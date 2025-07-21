import 'package:flutter/material.dart';
import 'package:servinow_mobile/core/widgets/downbar.dart';

class TermosDeUsoScreen extends StatelessWidget {
  const TermosDeUsoScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Center(
                child: Text(
                  '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('1 - Objetivo'),
              _buildSectionContent(
                'O sistema ServiNow tem o objetivo de facilitar a conexão entre clientes e prestadores de serviço, por meio de funcionalidades como agendamento, avaliação e gerenciamento de serviços, acessíveis em diversos dispositivos.',
              ),
              _buildSectionTitle('2 - Funcionalidades'),
              _buildSectionContent(
                '2.1 O sistema oferece as seguintes funcionalidades:',
              ),
              _buildBulletList([
                'Cadastro e login de usuário;',
                'Cadastro e gerenciamento de serviços;',
                'Agendamento de serviços;',
                'Avaliação de serviços prestados;',
                'Canal de denúncias;',
                'Configurações de conta;',
                'Geração de relatórios e controle de histórico;',
                'Busca por categorias e prestadores.',
              ]),
              _buildSectionTitle('3 - Responsabilidades do Usuário'),
              _buildSubSectionTitle('3.1 Conduta Geral'),
              _buildBulletList([
                'Agir de forma ética, respeitosa e conforme as leis brasileiras;',
                'Fornecer informações verdadeiras e atualizadas;',
                'Não praticar discriminação, discurso de ódio ou assédio;',
                'Respeitar os limites técnicos e operacionais da plataforma.',
              ]),
              _buildSubSectionTitle('3.2 Proibições'),
              _buildBulletList([
                'Propor, anunciar ou solicitar serviços de natureza sexual, prostituição ou semelhantes;',
                'Anunciar, vender ou divulgar produtos ilegais ou sem autorização legal;',
                'Utilizar linguagem ofensiva ou xingamentos diretos em avaliações ou interações indevidas;',
                'Enviar avaliações sequenciais com objetivo de manipular ou sobrecarregar a listagem de comentários (“flood”);',
                'Tentar fraudar ou manipular o sistema de reputação da plataforma.',
              ]),
              _buildSubSectionTitle('3.3 Penalidades'),
              _buildBulletList([
                'Advertência;',
                'Suspensão temporária da conta;',
                'Banimento permanente do usuário.',
              ]),
              _buildSubSectionTitle('3.4 Usuário como Cliente'),
              _buildSectionContent(
                'O cliente é responsável por verificar a confiabilidade dos prestadores antes de efetuar o agendamento, e por utilizar os recursos da plataforma de maneira consciente.',
              ),
              _buildSubSectionTitle('3.5 Usuário como Prestador de Serviços'),
              _buildSectionContent(
                'O prestador deve garantir a veracidade das informações fornecidas, manter conduta profissional e cumprir com os prazos e condições oferecidos.',
              ),
              _buildSectionTitle('4 - Privacidade'),
              _buildSectionContent(
                'A ServiNow atua apenas como intermediadora e não compartilha informações dos usuários com terceiros, salvo por obrigação legal. Os dados são utilizados unicamente para o funcionamento do sistema.',
              ),
              _buildSectionTitle('4.1 Denúncia'),
              _buildSectionContent(
                'A plataforma disponibiliza um meio para denúncia de condutas inadequadas, que são os e-mails dos desenvolvedores, disponibilizados no item 6. Todas as denúncias são analisadas pela equipe do ServiNow com confidencialidade e imparcialidade.',
              ),
              _buildSectionTitle('5 - Proteção de Dados'),
              _buildSectionContent(
                'Os dados dos usuários (nome, e-mail, preferências, avaliações, etc.) são armazenados com segurança, conforme a Lei Geral de Proteção de Dados (LGPD - Lei nº 13.709/2018). O usuário pode solicitar a atualização ou exclusão de seus dados a qualquer momento.',
              ),
              _buildSectionTitle('6 - Disposições Finais'),
              _buildSectionContent(
                'A ServiNow poderá alterar estes Termos de Uso e Política de Privacidade a qualquer momento, com aviso prévio por e-mail ou na própria plataforma. O uso contínuo após as alterações indica concordância com os novos termos.',
              ),
              _buildSectionContent(
                'E-mails dos desenvolvedores:\n'
                'José Claion Martins de Sousa (joseclaionmartins@gmail.com)\n'
                'João Victor Brum de Castro (joaovictor.brumc@gmail.com)\n'
                'Matheus Pantoja de Morais (mateus4pantoja@gmail.com)\n'
                'Manoel de Jesus Moreira de Aguiar (manoelmaguiar@gmail.com)',
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.cyan,
        ),
      ),
    );
  }

  Widget _buildSubSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4, left: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.cyan,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
      child: Text(
        content,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  Widget _buildBulletList(List<String> items) {
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
                    const Text(
                      '• ',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
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
