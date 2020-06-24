import 'dart:core';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CredentialsRepository {

  // 
  Future<oauth2.Credentials> getCredentials() async {

    final String credentials = await FlutterSecureStorage().read(
      key: null
    ) ?? '';

    if (credentials.isEmpty) return null;
    
    return oauth2.Credentials.fromJson(credentials);
  }

  // 
  Future persistCredentials(oauth2.Credentials credentials) async {

    return null;
  }

  // 
  Future revokeCredentials() async {
    
    return null;
  }
}
