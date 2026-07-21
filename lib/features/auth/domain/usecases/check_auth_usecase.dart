import '../repositories/auth_repository.dart';

class CheckAuthUseCase {
  CheckAuthUseCase({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  Future<bool> call() {
    return _repository.isAuthenticated();
  }
}
