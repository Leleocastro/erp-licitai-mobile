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

### Para QAs — Apontar para o backend

> O app mobile depende do backend rodando. Suba o backend primeiro (veja o README do `erp-licitai-backend`).

Configure a URL da API no arquivo de configuracao de rede (`lib/core/network/`):

```dart
// lib/core/network/api_config.dart
static const String baseUrl = 'http://localhost:3000/api';
```

| Recurso | URL |
|---------|-----|
| Backend API | `http://localhost:3000/api` |
| Swagger | `http://localhost:3000/api/docs` |
| Login teste | `admin@orgao.gov.br` / `Admin@123` |

### Resetar ambiente para teste limpo

```bash
# No repo backend:
docker-compose down -v && docker-compose up -d
npm run migration:run && npm run seed
npm run start:dev
```

## Testes

```bash
flutter test                    # Unit + Widget
flutter test integration_test   # Integration
maestro test maestro/flows/     # Maestro E2E
```
