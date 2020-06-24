import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:suflex/kernel/json-api/handling.dart';
import 'package:suflex/kernel/json-api/query-builder.dart';
import 'package:suflex/app/shared/repositories/auth/client-repository.dart';

class EntityManager {

  ///
  ///
  ///
  Map<String, String> headers;
  
  ///
  ///
  ///
  String baseUrl, resourceName, _uri, _method;

  ///
  ///
  ///
  Handling _handling;

  ///
  ///
  ///
  QueryBuilder _queryBuilder;

  ///
  ///
  ///
  EntityManager(Handling handling, QueryBuilder queryBuilder) {

    this._handling = handling;
    this._queryBuilder = queryBuilder;
  }

  ///
  ///
  ///
  Future all() async {

    this._method = 'GET';
    this._uri = _queryBuilder.getQuery(this.baseUrl, this.resourceName);

    return await this._send();
  }

  ///
  ///
  ///
  Future find(dynamic id) async {

    this._method = 'GET';
    this._uri = _queryBuilder.getQuery(this.baseUrl, '${this.resourceName}/$id');

    return await this._send();
  }

  ///
  ///
  ///
  Future create(Map<String, dynamic> data) async {

    this._method = 'POST';
    this._uri = _queryBuilder.getQuery(this.baseUrl, this.resourceName);

    final oauth2.Client client = await ClientRepository().getClient();

    http.Response response = await client.post(
      Uri.encodeFull(_uri),
      body: json.encode(data),
      headers: headers,
    );
    
    return _parseResponse(response);
  }

  ///
  ///
  ///
  Future update(dynamic id, Map<String, dynamic> data) async {

    this._method = 'PUT';
    this._uri = _queryBuilder.getQuery(this.baseUrl, '${this.resourceName}/$id');

    final oauth2.Client client = await ClientRepository().getClient();

    http.Response response = await client.put(
      Uri.encodeFull(_uri),
      body: json.encode(data),
      headers: headers,
    );
    
    return _parseResponse(response);
  }

  ///
  ///
  ///
  Future delete(dynamic id) async {

    this._method = 'DELETE';
    this._uri = _queryBuilder.getQuery(this.baseUrl, '${this.resourceName}/$id');

    return await this._send();
  }

  ///
  ///
  ///
  dynamic _send({body = ''}) async {

    final http.Request request = http.Request(_method, Uri.parse(_uri));

    request.body = jsonEncode(body);

    final oauth2.Client client = await ClientRepository().getClient();

    final http.Response response = await http.Response.fromStream(
      await client.send(request)
    );

    _queryBuilder.disposeQuery();

    if (response.statusCode > 206) {
      return Future.error(response);
    }

    return Future.value(_handling.respond(response.body));
  }

  ///
  ///
  ///
  dynamic _parseResponse(response) {

    if (response.statusCode > 206) {
      return Future.error(response);
    }

    return Future.value(_handling.respond(response.body));
  }

  ///
  ///
  ///
  EntityManager include(List<String> includes) {

    _queryBuilder.includes = includes;

    return this;
  }

  ///
  ///
  ///
  EntityManager where(String key, dynamic value) {

    _queryBuilder.filter = { 'key': key, 'value': value };

    return this;
  }

  ///
  ///
  ///
  EntityManager sort(String sortBy, {String sortType: 'asc'}) {

    _queryBuilder.sort = { 'sortBy': sortBy, 'direction': sortType };

    return this;
  }
  
  ///
  ///
  ///
  EntityManager paginate({ int number: 1, int limit: 100 }) {

    _queryBuilder.page = { 'number': number, 'limit': limit };

    return this;
  }
}
