import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/role/aggregate/role_aggregate.dart';
import 'package:home_crm_front/domain/sub/role/store/role_store.dart';

import '../../../support/components/aggregate/aggregate.dart';
import '../../../support/components/load/custom_load.dart';
import '../../user/aggregate/user_aggregate.dart';

class EmployeeAggregate extends Aggregate {
  final int? id;
  late UserAggregate user;
  late int roleId;

  EmployeeAggregate({this.id, required this.user, required this.roleId});

  LoadStore<RoleAggregate?> getRole() {
    return GetIt.I.get<RoleStore>().get(roleId);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'user': user.toJson(), 'roleId': roleId};
  }

  factory EmployeeAggregate.fromJson(Map<String, dynamic> json) {
    return EmployeeAggregate(
      id: (json['id'] as num?)?.toInt(),
      user: UserAggregate.fromJson(json['user'] as Map<String, dynamic>),
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
