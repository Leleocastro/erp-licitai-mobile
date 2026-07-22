import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  const AuthModel({
    required this.id,
    required this.email,
    required this.name,
    required this.accessToken,
    required this.refreshToken,
    this.cpf,
    this.orgaoId,
    this.roles = const [],
  });

  final String id;
  final String email;
  final String name;
  final String accessToken;
  final String refreshToken;
  final String? cpf;
  final String? orgaoId;
  final List<String> roles;

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final usuario = json['usuario'] as Map<String, dynamic>;
    return AuthModel(
      id: usuario['id'] as String,
      email: usuario['email'] as String,
      name: usuario['nome'] as String,
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      cpf: usuario['cpf'] as String?,
      orgaoId: usuario['orgao_id'] as String?,
      roles: (usuario['roles'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        accessToken,
        refreshToken,
        cpf,
        orgaoId,
        roles,
      ];
}
