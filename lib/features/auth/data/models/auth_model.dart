import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  const AuthModel({
    required this.id,
    required this.email,
    required this.name,
    required this.token,
    this.cpf,
    this.orgaoId,
    this.roles = const [],
  });

  final String id;
  final String email;
  final String name;
  final String token;
  final String? cpf;
  final String? orgaoId;
  final List<String> roles;

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      token: json['token'] as String,
      cpf: json['cpf'] as String?,
      orgaoId: json['orgao_id'] as String?,
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [id, email, name, token, cpf, orgaoId, roles];
}
