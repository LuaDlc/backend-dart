//middle é uma classe que intercepta nossa requisicao e nosso response e faz coisa antes que isso seja processado
import 'package:shelf/shelf.dart';

class MiddlewareInterception {
  Middleware get middleware {
    return createMiddleware(
      responseHandler:
          (Response res) => res.change(
            headers: {'content-type': 'application/json', 'xpto': '123'},
          ),
    );
  }
}
