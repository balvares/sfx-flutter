import 'package:suflex/kernel/json-api/handling.dart';
import 'package:suflex/kernel/json-api/query-builder.dart';
import 'package:suflex/kernel/json-api/entity-manager.dart';
import 'package:suflex/kernel/interfaces/repository-interface.dart';

class Repository extends EntityManager implements RepositoryInterface {

  ///
  ///
  ///
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-type": "application/json",
  };

  ///
  ///
  ///
  Repository() : super(Handling(), QueryBuilder());

  ///
  ///
  ///
  String getEnvironmentUrl(String baseUrl) {

    return baseUrl;
  }
}
