import 'package:shelf/shelf.dart';
import 'apis/noticias_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'utils/custom_env.dart';
import 'services/noticias_service.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service_imp.dart';

void main() async {
  CustomEnv.fromFile('.env');

  var cascadeHandler =
      Cascade()
          .add(LoginApi(SecurityServiceImp()).handler)
          .add(NoticiasApi(NoticiasService()).handler)
          .handler;

  var handler = Pipeline()
      .addMiddleware(MiddlewareInterception().middleware)
      .addMiddleware(logRequests())
      .addMiddleware(SecurityServiceImp().authorization)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    server_door: await CustomEnv.get<int>(key: 'server_door'),
  );
}
