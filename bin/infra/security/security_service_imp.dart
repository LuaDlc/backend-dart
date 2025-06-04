import 'package:shelf/shelf.dart';
import 'package:shelf/src/middleware.dart';

import 'security_service.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import '../../utils/custom_env.dart';

class SecurityServiceImp implements SecurityService {
  @override
  Future<String> generateJWT(String userID) async {
    var jwt = JWT({
      //criando payload
      'iat':
          DateTime.now()
              .millisecondsSinceEpoch, //data transformada em formato numerico
      'userID': userID, //claim customizada
      'roles': ['admin', 'user'],
    });
    //recuperando a chave responsavel por assinar o token
    String key = await CustomEnv.get(key: 'jwt_key');
    //gerado o token
    String token = jwt.sign(SecretKey(key));
    return token;
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    String key = await CustomEnv.get(key: 'jwt_key');

    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidException {
      return null;
    } on JWTExpiredException {
      return null;
    } on JWTNotActiveException {
      return null;
    } on JWTUndefinedException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request req) async {
        String? authorizarionHeader = req.headers['Authorization'];
        JWT? jwt;

        if (authorizarionHeader != null) {
          if (authorizarionHeader.startsWith('Bearer ')) {
            String token = authorizarionHeader.substring(7);
            jwt = await validateJWT(token);
          }
        }
        // se  a req nao tiver valor o jwt estara nulo ou preenchido
        var request = req.change(context: {'jwt': jwt});

        return handler(request);
      };
    };
  }

  @override
  // TODO: implement verifyJwt
  Middleware get verifyJwt => throw UnimplementedError();
}
//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3NDkwNTA0MDYsInVzZXJJRCI6IjEiLCJyb2xlcyI6WyJhZG1pbiIsInVzZXIiXX0.aLVBzGgcaZoKjRpiYmojLCZwfCEnwCBagd0Z79zGO80