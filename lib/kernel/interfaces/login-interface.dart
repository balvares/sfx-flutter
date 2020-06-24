abstract class LoginInterface {

  ///
  ///
  ///
  Future<bool> isAuthenticated();

  ///
  ///
  ///
  Future signIn(String username, String password);

  ///
  ///
  ///
  Future signOut();
}