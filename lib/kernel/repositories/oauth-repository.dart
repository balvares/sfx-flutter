import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:suflex/kernel/interfaces/login-repository-interface.dart';

class OauthRepository implements LoginRepositoryInterface {

  Future<oauth2.Credentials> grantToken({ String username, String password }) async {

    oauth2.Credentials credentials;

    final Uri url = Uri.parse('${DotEnv().env['URL_BASE']}/auth/users');

    await oauth2.resourceOwnerPasswordGrant(
      url, username, password,
    )
    .then((res) => credentials = res.credentials)
    .catchError((err) { 

      credentials = null;
    });

    if (credentials == null) {

      return Future.error('Usuário e/ou senha incorreto(s).');
    }

    return credentials;
  }

  Future revokeToken() async {

    // final Uri url = Uri.parse('${DotEnv().env['URL_BASE']}/users');

    // return ;
  }
}