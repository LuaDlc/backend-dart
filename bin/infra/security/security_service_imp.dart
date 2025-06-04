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
}
