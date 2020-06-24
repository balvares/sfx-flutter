import 'package:suflex/kernel/interfaces/entity-interface.dart';

part 'users.g.dart';

class Users implements EntityInterface {
  
  final String id;
  final String nome;
  final String sobrenome;
  final String username;
  final String senha;

  Users({
    this.id,
    this.nome,
    this.sobrenome,
    this.username,
    this.senha,
  });

  Users fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);
  
}
