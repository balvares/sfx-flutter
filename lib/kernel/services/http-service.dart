import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:suflex/kernel/interfaces/http-interface.dart';

class HttpService implements HttpInterface {

  static final HttpService _singleton = HttpService._internal();

  factory HttpService() => _singleton;

  HttpService._internal();

  // 
  Future persistCredentials(oauth2.Credentials credentials) async {

    return null;
  }

  // 
  Future<void> revokeCredentials() async {
    
    return null;
  }

  // 
  Future<oauth2.Credentials> getCredentials() async {

    return null;
  }

  // 
  Future<oauth2.Client> getClient() async {

    final credentials = await getCredentials();
    
    if (credentials == null && credentials?.accessToken == null) {
      return null;
    }
    
    return oauth2.Client(credentials);
  }
}