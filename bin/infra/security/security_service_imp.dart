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
    String key = await CustomEnv.get(key: 'jwt_key');
    String token = await jwt.sign(SecretKey(key));
    return token;
  }

  @override
  JWT? validateJWT(String token) {
    // TODO: implement validateJWT
    throw UnimplementedError();
  }
}
