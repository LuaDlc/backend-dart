import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models/noticia_model.dart';
import '../services/generic_service.dart';

class NoticiasApi {
  final GenericService<NoticiasModel> _service;
  NoticiasApi(this._service);

  Handler get handler {
    // List<Middleware>? middlewares,
    // bool isSecurity = false,

    Router router = Router();

    router.get('/blog/noticias', (Request req) {
      List<NoticiasModel> noticias = _service.findAll();
      return Response.ok(noticias);
    });

    router.post('/blog/noticias', (Request req) async {
      var body = await req.readAsString();
      _service.save(NoticiasModel.fromRequest(jsonDecode(body)));
      return Response(201);
    });

    router.put('/blog/noticias', (Request req) {
      // _service.save(3);
      String? id = req.url.queryParameters['id'];
      return Response.ok('chow bla');
    });

    router.delete('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      _service.delete(1);

      return Response.ok('deletado');
    });

    return router.call;
  }
}
