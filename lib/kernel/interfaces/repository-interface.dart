import 'package:suflex/kernel/json-api/entity-manager.dart';

abstract class RepositoryInterface {

  ///
  ///
  ///
  String getEnvironmentUrl(String baseUrl);

  ///
  ///
  ///
  Future all();

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

  ///
  ///
  ///
  EntityManager where(String key, String value);

  ///
  ///
  ///
  EntityManager include(List<String> includes);

}
