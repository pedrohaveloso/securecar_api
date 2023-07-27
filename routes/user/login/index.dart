import 'package:dart_frog/dart_frog.dart';
import 'package:securecar_api/controllers/user_controller/user_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  return UserController().login(context: context);
}
