import '../../../support/components/aggregate/aggregate.dart';

class EmployeeAggregate extends Aggregate {
  final int? id;
  final int userId;
  late int roleId;

  EmployeeAggregate({this.id, required this.userId, required this.roleId});

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'userId': userId, 'roleId': roleId};
  }

  factory EmployeeAggregate.fromJson(Map<String, dynamic> json) {
    return EmployeeAggregate(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num).toInt(),
      roleId: (json['roleId'] as num).toInt(),
    );
  }

  @override
  String getAbbreviate() {
    return 'СОТРУДНИК';
  }

  @override
  int? getId() {
    return id;
  }

  @override
  String getNewName() {
    return 'Новый сотрудник';
  }
}
