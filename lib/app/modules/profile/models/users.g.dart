// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) {

  return Users(
    id: json['id'] as String,
    nome: json['nome'] as String,
    sobrenome: json['sobrenome'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$UsersToJson(Users instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'sobrenome': instance.sobrenome,
      'username': instance.username,
    };