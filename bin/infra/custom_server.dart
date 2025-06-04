import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class CustomServer {
  Future<void> initialize({
    required Handler handler,
    required String address,
    required int server_door,
  }) async {
    await shelf_io.serve(handler, address, server_door);
    print('servidor inicializado -> http://$address:$server_door');
  }
}
