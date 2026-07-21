import '../repositories/auth_repository.dart';

class LogoutUseCase {
  LogoutUseCase({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  Future<void> call() {
    return _repository.logout();
  }
}
