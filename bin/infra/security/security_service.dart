import 'package:shelf/shelf.dart';

abstract class SecurityService<T> {
  Future<String> generateJWT(String userID);
  Future<T>? validateJWT(String token);
  //middle de seguranca responsavel por validar cada jwt
  Middleware get verifyJwt;
  //autorizacao pra cada api cada verify tenha dado certo
  Middleware get authorization;
}
