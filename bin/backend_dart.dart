import 'package:shelf/shelf.dart';
import 'apis/noticias_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'utils/custom_env.dart';
import 'services/noticias_service.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service_imp.dart';
import 'infra/dependency_injector.dart';
import 'infra/security/security_service.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  final _di = DependencyInjector();

  _di.register<SecurityService>(() => SecurityServiceImp(), isSingleton: true);
  var _securityService = _di.get<SecurityService>();

  var cascadeHandler =
      Cascade()
          .add(LoginApi(_securityService).getHandler())
          .add(NoticiasApi(NoticiasService()).getHandler(isSecurity: true))
          .handler;

  var handler = Pipeline()
      .addMiddleware(MiddlewareInterception().middleware)
      .addMiddleware(logRequests())
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: 'server_address'),
    serverdoor: await CustomEnv.get<int>(key: 'server_door'),
  );
}
