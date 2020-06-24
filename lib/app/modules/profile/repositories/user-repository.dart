import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:suflex/kernel/json-api/handling.dart';
import 'package:suflex/kernel/repositories/repository.dart';
import 'package:suflex/app/shared/repositories/auth/client-repository.dart';

class UserRepository extends Repository {

  UserRepository() {
    resourceName = 'users';
    baseUrl = getEnvironmentUrl(DotEnv().env['URL_BASE']);
  }

  Map<String, String> _headersCAPI = { 
    "Content-type": "application/json",
  };

  ///
  ///
  ///
  Future<Map<String, dynamic>> me() async {

    final oauth2.Client client = await ClientRepository().getClient();

    final http.Response response = await client.get(
      '$baseUrl/api/me?include=customer,person',
      headers: headers,
    );

    if (response.statusCode > 206) {
      return Future.error(response.body);
    }

    return Future.value(Handling().respond(response.body));
  }

  ///
  ///
  ///
  Future<Map<String, dynamic>> create(data) async {

    final response = await http.post(
      '$baseUrl/users',
      body: json.encode(data),
      headers: _headersCAPI,
    );

    if(response.statusCode > 206) {

      return Future.error('Erro ao criar usuário.');
    }

    if(response.body.isEmpty) {
      
      return Map();
    }

    return Future.value(Handling().respond(response.body));
  }

  ///
  ///
  ///
  Future<Map<String, dynamic>> passwordEmailVerify(Map<String, dynamic> data) async {

    final response = await http.post(
      '$baseUrl/users/password/forgot/validate',
      body: json.encode(data),
      headers: _headersCAPI,
    );

    if (response.statusCode > 206) {
      return Future.error(response.body);
    }

    return Future.value(jsonDecode(response.body));
  }

  ///
  ///
  ///
  Future<Map<String, dynamic>> validateCurrentPassword(String id, Map<String, dynamic> data) async {

    final oauth2.Client client = await ClientRepository().getClient();

    http.Response response = await client.post(
      '$baseUrl/users/validate-password/$id',
      body: json.encode(data),
      headers: headers,
    );
    
    if (response.statusCode > 206) {
      return Future.error(response.body);
    }

    return Future.value(jsonDecode(response.body));
  }

  ///
  ///
  ///
  Future<Map<String, dynamic>> passwordUpdate(Map<String, dynamic> data) async {

    final response = await http.post(
      '$baseUrl/users/reset-password',
      body: json.encode(data),
      headers: _headersCAPI,
    );

    if (response.statusCode > 206) {
      return Future.error(response.body);
    }

    return Future.value(jsonDecode(response.body));
  }

  ///
  ///
  ///
  Future<Map<String, dynamic>> passwordForgot(Map<String, dynamic> data) async {

    final response = await http.post(
      '$baseUrl/users/password/forgot',
      body: json.encode(data),
      headers: _headersCAPI,
    );

    if (response.statusCode > 206) {
      return Future.error(response.body);
    }

    return Future.value(jsonDecode(response.body));
  }

}