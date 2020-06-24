import 'dart:convert';

class Handling {

  ///
  ///
  ///
  List<dynamic> _included = List();

  ///
  ///
  ///
  Map _hydrate(Map<String, dynamic> entity) {

    Map<String, dynamic> map = {};

    if (entity.containsKey('id')) {
      map["id"] = entity['id'];
    }

    if (entity.containsKey('attributes')) {
      map.addAll(Map<String, dynamic>.from(entity['attributes']));
    }

    if (entity.containsKey('relationships')) {
      map.addAll(Map<String, dynamic>.from(_resolveRelationships(entity['relationships'])));
    }

    return map;
  }

  ///
  ///
  ///
  List _hydrateCollection(List<dynamic> entities) {

    return entities.map((entity) {
      return this._hydrate(entity);
    }).toList();
  }

  ///
  ///
  ///
  Map<String, dynamic> _hydrateRelationship(Map<String, dynamic> entity) {

    Iterable<dynamic> attributes = this._included.where((include) {
      return entity['type'] == include['type'] && entity['id'] == include['id'];
    });

    if (attributes.isEmpty) return {};

    Map<String, dynamic> data = jsonDecode(jsonEncode(attributes.first));

    return _hydrate(data);
  }

  ///
  ///
  ///
  List _hydrateRelationshipCollection(List entities) {

    return entities.map((entity) {
      return _hydrateRelationship(entity);
    }).toList();
  }

  ///
  ///
  ///
  Map _resolveRelationships(Map<String, dynamic> relationships) {

    Map<String, dynamic> map = {};

    for (String key in relationships.keys) {

      dynamic data = relationships[key]['data'];

      if (data == null) continue;

      if (data is List) {
        map[key] = _hydrateRelationshipCollection(data);
      } else {
        map[key] = _hydrateRelationship(data);
      }
    }

    return map;
  }

  ///
  ///
  ///
  dynamic respond(String receivedJson) {
    
    final Map<String, dynamic> decodedJson = json.decode(receivedJson);

    if (decodedJson.isEmpty) {
      return [];
    }

    this._included = decodedJson['included'] ?? [];

    if (decodedJson['data'] is List) {
      return _hydrateCollection(decodedJson['data']);
    } else {
      return _hydrate(decodedJson['data']);
    }
  }
}