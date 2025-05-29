import 'dart:io';
import 'parser_extension.dart';

class CustomEnv {
  static String _file = '.-dart';
  static Map<String, String> _map = {};

  CustomEnv._();

  factory CustomEnv.fromFile(String file) {
    _file = file;
    return CustomEnv._();
  }
  static Future<void> _load() async {
    List<String> linhas = (await _readFile()).split('\n');
    _map = {for (var l in linhas) l.split('=')[0]: l.split('=')[1]};
  }

  static Future<String> _readFile() async {
    return await File(_file).readAsString(); //read espera um future string
  }

  static Future<T> get<T>({required String key}) async {
    if (_map.isEmpty) await _load();
    return _map[key]!.toType(T);
  }
}
