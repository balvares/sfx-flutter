import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:suflex/kernel/services/http-service.dart';
import 'package:suflex/kernel/interfaces/login-interface.dart';
import 'package:suflex/kernel/repositories/oauth-repository.dart';

class LoginService implements LoginInterface {

  static final LoginService _singleton = LoginService._internal();

  factory LoginService() => _singleton;

  LoginService._internal();

  ///
  ///
  ///
  Future<bool> isAuthenticated() async {

  final oauth2.Credentials credentials = await HttpService().getCredentials();

    return credentials != null && credentials.accessToken.isNotEmpty;
  }

  ///
  ///
  ///
  Future signIn(String username, String password) async {

    final oauth2.Credentials credentials = await OauthRepository().grantToken(
      username: username,
      password: password,
    );

    if (credentials != null) {

      return await HttpService().persistCredentials(credentials);
    }

    return Future.error('Empty credentials.');
  }

  ///
  ///
  ///
  Future signUp(String name, String email, String password) async {

    final Map data = {
      'username': email,
      'password': password,
    };

    final String url = '${DotEnv().env['URL_BASE']}/auth/users/oauth/token';

    final http.Response response = await http.post(
      Uri.encodeFull(url),
      body: json.encode(data),
      headers: { "Content-type": "application/json" },
    );

    if (response.statusCode != 200) {
      final Map res = json.decode(response.body);

      return Future.error(res['errors'][0]['detail'] ?? '');
    }

    final Map res = json.decode(response.body);

    final oauth2.Credentials credentials = oauth2.Credentials(
      res['access_token'], refreshToken: res['refresh_token'],
    );

    if (credentials != null) {

      return await HttpService().persistCredentials(credentials);
    }

    return Future.error('Empty credentials.');
  }

  ///
  ///
  ///
  Future signOut() async {

    if (await isAuthenticated()) {

      return await HttpService().revokeCredentials();
    }
  }
}