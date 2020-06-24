abstract class ServiceInterface {

  ///
  ///
  ///
  Future list();

  ///
  ///
  ///
  Future find(dynamic id);

  ///
  ///
  ///
  Future create(Map<String, dynamic> data);

  ///
  ///
  ///
  Future update(dynamic id, Map<String, dynamic> data);

  ///
  ///
  ///
  Future delete(dynamic id);

}
