// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoticiasModel {
  int? id;
  String? title;
  String? description;
  String? imagem;
  DateTime? dtCreated;
  DateTime? dtAUpdated;
  int? userId;
  NoticiasModel();

  factory NoticiasModel.fromMap(Map map) {
    return NoticiasModel()
      ..id = map['id']?.toInt()
      ..title = map['title']
      ..description = map['description'].toString()
      ..dtCreated = map['dtCreated']
      ..dtAUpdated = map['dtCreated']
      ..userId = map['userId']?.toInt();
  }
  factory NoticiasModel.fromJson(Map map) {
    return NoticiasModel()
      ..id = map['id']
      ..title = map['title']
      ..description = map['description']
      ..userId = map['userId']?.toInt();
  }

  Map toJson() {
    return {'id': id, 'title': title, 'description': description};
  }

  @override
  String toString() {
    return 'BlogModel(id: $id, description: $title, description: $description, imagem: $imagem, dtCreated: $dtCreated, dtAUpdated: $dtAUpdated)';
  }
}
