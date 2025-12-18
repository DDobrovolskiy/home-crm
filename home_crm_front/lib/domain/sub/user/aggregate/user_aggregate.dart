import '../../../support/components/aggregate/aggregate.dart';

class UserAggregate extends Aggregate {
  late int? id;
  late bool active;
  late int version;
  late String name;
  late String? surname;
  late String? patronymic;
  late String phone;

  UserAggregate({
    this.id,
    this.active = true,
    this.version = 0,
    required this.name,
    this.surname,
    this.patronymic,
    required this.phone,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'version': version,
      'name': name,
      'surname': surname,
      'patronymic': patronymic,
      'phone': phone,
    };
  }

  factory UserAggregate.fromJson(Map<String, dynamic> json) {
    return UserAggregate(
      id: (json['id'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      version: (json['version'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      surname: json['surname'] as String?,
      patronymic: json['patronymic'] as String?,
      phone: json['phone'] as String? ?? '',
    );
  }

  @override
  String getAbbreviate() {
    return 'ПОЛЬЗОВАТЕЛЬ';
  }

  @override
  int? getId() {
    return id;
  }

  @override
  String getNewName() {
    return 'Новый пользователь';
  }
}
