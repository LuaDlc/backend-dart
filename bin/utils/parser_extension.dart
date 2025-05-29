extension ParserExtension on String {
  dynamic toType(Type type) {
    if (type == String) {
      return this;
    } else if (type == int) {
      return int.parse(this);
    }

    return toString();
  }
}
