import 'package:suflex/kernel/controllers/controller.dart';
import 'package:suflex/app/modules/profile/models/users.dart';
import 'package:suflex/app/modules/profile/services/user-service.dart';

class UserController extends Controller {

  UserService _service;

  UserController() : super(service: UserService()) {

    this._service = service;
  }

  ///
  ///
  ///
  Future<Users> me() async {

    return await _service.me();
  }

  ///
  ///
  ///
  Future<Users> create(Map<String, dynamic> data) async {

    return await _service.create(data);
  }

  ///
  ///
  ///
  Future<bool> validateCurrentPassword(String id, Map<String, dynamic> data) async {

    return await _service.validateCurrentPassword(id, data);
  }

  ///
  ///
  ///
  Future<bool> passwordForgot(Map<String, dynamic> data) async {

    return await _service.passwordForgot(data);
  }

  ///
  ///
  ///
  Future<bool> passwordEmailVerify(Map<String, dynamic> data) async {
    
    return await _service.passwordUpdate(data);
  }

  ///
  ///
  ///
  Future<bool> passwordUpdate(Map<String, dynamic> data) async {

    return await _service.passwordUpdate(data);
  }
}
