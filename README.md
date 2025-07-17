# ServiNow Mobile

Aplicativo Flutter para agendamento e visualização de serviços. Desenvolvido com boas práticas de arquitetura, uso de componentes reutilizáveis, integração com API e suporte a navegação entre múltiplas telas.

---

## 🚀 Funcionalidades

- Login e autenticação via API
- Cadastro de usuários com validação de CPF e data de nascimento
- Recuperação de senha usando número de telefone
- Visualização de serviços (cards com imagem e botão de agendamento)
- Agendamento de serviços (em desenvolvimento)
- Perfil do usuário (em desenvolvimento)
- Navegação por abas (DownBar)
- Tema global personalizado
- Tratamento de erros de rede e feedback ao usuário via SnackBar

---

## 📱 Tecnologias e Recursos Usados

### 🔹 Flutter/Dart

- Estrutura de projeto modular: `screens/`, `widgets/`, `services/`
- Navegação com **Named Routes** (`Navigator.pushReplacementNamed`)
- Requisições assíncronas com `Future`, `async/await`
- `BottomNavigationBar` customizada com `DownBar`
- Criação de **widgets personalizados** (ex: `ServicoCard`)
- Validação de formulários com `GlobalKey<FormState>`
- SnackBar para mensagens dinâmicas de sistema

### 🔹 Integração com API

- Consumo de API com `http` (via `ApiService`)
- Organização dos endpoints por serviços (`ServicoService`, `CadastroService`, etc.)
- Autenticação com `useAuth: true`
- Tratamento de erros de resposta e validação

### 🔹 UI e Experiência do Usuário

- Tema global com `ThemeData`, aplicado no `MaterialApp`
- Cores e fontes consistentes
- `Image.network` com `loadingBuilder` e `errorBuilder`
- Feedback visual para funcionalidades ainda em desenvolvimento

---

## 📁 Estrutura de Pastas

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


---

## 📌 Em Desenvolvimento

- Tela de **agendamento** com calendário
- Tela de **menu lateral**
- Integração com **notificações**
- Upload de arquivos e foto de perfil
