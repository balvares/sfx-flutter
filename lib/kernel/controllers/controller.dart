import 'package:suflex/kernel/interfaces/entity-interface.dart';
import 'package:suflex/kernel/interfaces/service-interface.dart';

class Controller {

  ServiceInterface _service;

  ///
  ///
  ///
  Controller({ ServiceInterface service }) {

    this._service = service;
  }

  ///
  ///
  ///
  ServiceInterface get service {

    return this._service;
  }

  ///
  ///
  ///
  Future<dynamic> list() async {

    List<EntityInterface> entities = await _service.list();

    return entities;
  }

  ///
  ///
  ///
  Future<dynamic> find(dynamic id) async {

    EntityInterface entity = await _service.find(id);

    return entity;
  }

  ///
  ///
  ///
  Future<dynamic> create(Map<String, dynamic> data) async {

    EntityInterface entity = await _service.create(data);

    return entity;
  }

  ///
  ///
  ///
  Future<dynamic> update(dynamic id, Map<String, dynamic> data) async {

    EntityInterface entity = await _service.update(id, data);

    return entity;
  }

  ///
  ///
  ///
  Future<dynamic> delete(dynamic id) async {

    EntityInterface entity = await _service.delete(id);

    return entity;
  }
}
