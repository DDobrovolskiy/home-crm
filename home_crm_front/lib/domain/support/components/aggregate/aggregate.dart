abstract class Aggregate {
  int? getId();

  String getNewName();

  String getAbbreviate();

  bool isCreate() {
    return getId() == null;
  }

  String getNumber() {
    if (getId() == null) {
      return getNewName();
    } else {
      return '${getAbbreviate()}-${getId()}';
    }
  }

  Map<String, dynamic> toJson();
}
