import 'package:suflex/kernel/services/service.dart';
import 'package:suflex/app/modules/profile/models/users.dart';
import 'package:suflex/app/modules/profile/repositories/user-repository.dart';

class UserService extends Service {

  Users _entity;
  UserRepository _repository;

  UserService() : super(repository: UserRepository(), entity: Users()) {

    this._entity = this.entity;
    this._repository = this.repository;
  }

  ///
  ///
  ///
  Future<Users> me() async {

    Map<String, dynamic> user = await _repository.me();

    // if (user['person'] != null) {
    //   user['person']['json_data'] = jsonDecode(user['person']['json_data']);
    // }

    return _entity.fromJson(user);
  }

  ///
  ///
  ///
  Future<Users> create(Map<String, dynamic> data) async {

    Map<String, dynamic> user = await _repository.create(data);

    return _entity.fromJson(user);
  }

  ///
  ///
  ///
  Future<bool> validateCurrentPassword(String id, Map<String, dynamic> data) async {

    Map<String, dynamic> result = await _repository.validateCurrentPassword(id, data);

    return result['data']['response'];
  }

  ///
  ///
  ///
  Future<bool> passwordForgot(Map<String, dynamic> data) async {

    return _repository.passwordForgot(data)
      .then((value) => true)
      .catchError((onError) => false);
  }

  ///
  ///
  ///
  Future<String> passwordEmailVerify(Map<String, dynamic> data) async {
    
    Map<String, dynamic> result = await _repository.passwordEmailVerify(data);

    return result['attributes']['user_id'];
  }

  ///
  ///
  ///
  Future<bool> passwordUpdate(Map<String, dynamic> data) async {

    return _repository.passwordUpdate(data)
      .then((value) => true)
      .catchError((onError) => false);
  }
}
