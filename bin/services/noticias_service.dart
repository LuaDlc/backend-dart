import 'generic_service.dart';
import '../models/noticia_model.dart';
import '../utils/list_extension.dart';

class NoticiasService implements GenericService<NoticiasModel> {
  final List<NoticiasModel> _fakeDB = [];
  @override
  List<NoticiasModel> findAll() {
    return _fakeDB;
  }

  @override
  NoticiasModel findOne(int id) {
    //return direto com firswhere para achar  mesmo id q é procurado
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  bool save(NoticiasModel value) {
    //busca o primeiro q fizer nossa condicao: ter o mesmo value inserido ou passar
    //ele pra traz com o return, ou seja trazer ele
    NoticiasModel? model = _fakeDB.firstWhereOrNull((e) => e.id == value.id);
    if (model == null) {
      //se nao encontrar é um novo objeto entao adiciona ele na lista fake
      _fakeDB.add(value);
    } else {
      var index = _fakeDB.indexOf(model);
      _fakeDB[index] = value;
    }

    return true;
  }

  @override
  bool delete(int id) {
    //procurar na lista o item e remover se for igual ao item q esta procurando
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }
}
