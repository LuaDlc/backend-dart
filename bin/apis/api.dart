import 'package:shelf/shelf.dart';
import '../infra/dependency_injector.dart';
import '../infra/security/security_service.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middleware, bool isSecurity});

  Handler createHandler({
    //recebe handler e pode ou nao receber uma lista de middles
    required Handler router,
    List<Middleware>? middleware,
    bool isSecurity = false,
  }) {
    //caso a lista seja nula atribuo lista vazia
    middleware ??= [];
    if (isSecurity) {
      var _securityService = DependencyInjector().get<SecurityService>();

      middleware.addAll([
        _securityService.authorization,
        _securityService.verifyJwt,
      ]);
    }

    //objeto de pipeline q pode conter varios midles
    var pipe = Pipeline();

    //adicionando os headers na pipeline
    //terar sobre a lista e adiciono o midle na pipe e atribuo o valor da midle na pipe
    middleware.forEach((m) => pipe.addMiddleware(m));
    return pipe.addHandler(router);
  }
}
