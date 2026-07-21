import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.cpf,
    this.orgaoId,
    this.roles = const [],
  });

  final String id;
  final String email;
  final String name;
  final String? cpf;
  final String? orgaoId;
  final List<String> roles;

  @override
  List<Object?> get props => [id, email, name, cpf, orgaoId, roles];
}
