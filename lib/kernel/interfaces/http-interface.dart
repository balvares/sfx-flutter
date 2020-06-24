import 'package:oauth2/oauth2.dart';

abstract class HttpInterface {

  ///
  ///
  ///
  Future persistCredentials(Credentials credentials);

  ///
  ///
  ///
  Future revokeCredentials();

  ///
  ///
  ///
  Future<Credentials> getCredentials();

  ///
  ///
  ///
  Future<Client> getClient();
}