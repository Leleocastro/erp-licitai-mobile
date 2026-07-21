# ERP Licitai - Mobile

App mobile Flutter do ERP governamental brasileiro Licitai.

## Stack

- **Flutter** 3.x + **Dart** 3.x
- **Clean Architecture** + **Bloc/Cubit**
- **Dio** (HTTP client) + **GoRouter** (navegacao)
- **Material Design 3**
- **Maestro** + **Cucumber BDD** + **Flutter Integration Tests**

## Estrutura

```
lib/
├── core/
│   ├── theme/       # Tema e cores
│   ├── routes/      # GoRouter config
│   ├── di/          # Dependency injection
│   └── network/     # Dio client, interceptors
└── features/
    ├── auth/        # Login, MFA, Gov.br
    └── core/        # Usuarios, orgaos, roles

test/
├── unit/
├── widget/
└── integration/

maestro/
└── flows/           # Maestro E2E flows
```

## Convencao Keys (data-cy)

```
Key('modulo_tela_tipo_acao')

Exemplos:
  Key('core_login_btn_submit')
  Key('core_login_input_email')
  Key('core_usuarios_list_view')
```

## Setup

```bash
flutter pub get
flutter run
```

## Testes

```bash
flutter test                    # Unit + Widget
flutter test integration_test   # Integration
maestro test maestro/flows/     # Maestro E2E
```
