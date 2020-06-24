import 'package:suflex/kernel/interfaces/entity-interface.dart';
import 'package:suflex/kernel/interfaces/service-interface.dart';
import 'package:suflex/kernel/interfaces/repository-interface.dart';

abstract class Service implements ServiceInterface {

  RepositoryInterface _repository;
  EntityInterface _entity;

  Service({
    RepositoryInterface repository, EntityInterface entity
  }) {

    this._repository = repository;
    this._entity = entity;
  }

  ///
  ///
  ///
  RepositoryInterface get repository {
    return _repository;
  }

  ///
  ///
  ///
  EntityInterface get entity {
    return _entity;
  }

  ///
  ///
  ///
  Future list() async {

    List<Map<String, dynamic>> entities = await _repository.all();

    return entities.map((entity) {
      return _entity.fromJson(entity);
    }).toList();
  }

  ///
  ///
  ///
  Future find(dynamic id) async {

    dynamic entity = await _repository.find(id);

    return _entity.fromJson(entity);
  }

  ///
  ///
  ///
  Future create(Map<String, dynamic> data) async {

    dynamic entity = await _repository.create(data);

    return _entity.fromJson(entity);
  }

  ///
  ///
  ///
  Future update(dynamic id, Map<String, dynamic> data) async {

    dynamic entity = await _repository.update(id, data);

    return _entity.fromJson(entity);
  }

  ///
  ///
  ///
  Future delete(dynamic id) async {

    dynamic entity = await _repository.delete(id);

    return _entity.fromJson(entity);
  }

}
