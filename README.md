# servinow_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 📁 Estrutura do Projeto

A seguir, a organização da pasta `lib/`, projetada para facilitar a escalabilidade e a manutenção do app Flutter:

```plaintext
lib/
├── main.dart                       # Ponto de entrada da aplicação
├── core/
│   ├── services/                   # Módulos de conexão com a API, autenticação, agendamentos, etc.
│   └── widgets/                    # Componentes reutilizáveis como botões, campos de texto, formulários, etc.
├── models/                         # Definição dos modelos de dados utilizados (ex: User, Servico, Agendamento)
├── screens/                        # Telas da aplicação divididas por responsabilidade
│   ├── auth/                       # Telas de login e cadastro (multi-etapas)
│   ├── home/                       # Tela inicial com listagem de serviços
│   ├── servico/                    # Visualização detalhada e agendamento de serviços
│   ├── perfil/                     # Visualização e edição de perfil do usuário
│   └── info/                       # Telas estáticas como Sobre Nós e Termos de Uso
└── providers/                      # Gerenciamento de estado (ex: autenticação, usuário logado, cache)
