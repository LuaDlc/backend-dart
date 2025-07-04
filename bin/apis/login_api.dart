import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../infra/security/security_service.dart';
import 'api.dart';

class LoginApi extends Api {
  final SecurityService _securityService;

  LoginApi(this._securityService);

  @override
  Handler getHandler({List<Middleware>? middleware, bool isSecurity = false}) {
    Router router = Router(); //router é um obejto que trata rotas

    router.post('/login', (Request req) async {
      var token = await _securityService.generateJWT('1');
      var result = await _securityService.validateJWT(token);

      return Response.ok(token);
    });

    return createHandler(router: router, middleware: middleware);
  }
}
