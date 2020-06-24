import 'dart:core';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:suflex/app/shared/repositories/auth/credentials-repository.dart';

class ClientRepository {

  Future<oauth2.Client> getClient() async {

    final oauth2.Credentials credentials = await CredentialsRepository().getCredentials();
    
    if (credentials == null && credentials?.accessToken == null) return null;
    
    return oauth2.Client(credentials);
  }
}