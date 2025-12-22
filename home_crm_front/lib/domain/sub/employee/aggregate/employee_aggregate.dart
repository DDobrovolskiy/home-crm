import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/role/aggregate/role_aggregate.dart';
import 'package:home_crm_front/domain/sub/role/store/role_store.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../support/components/aggregate/aggregate.dart';
import '../../../support/components/load/custom_load.dart';
import '../../user/aggregate/user_aggregate.dart';

part 'employee_aggregate.g.dart';

@JsonSerializable()
class EmployeeAggregate extends Aggregate {
  late UserAggregate user;
  late int roleId;

  EmployeeAggregate({
    super.id,
    super.active,
    super.version,
    super.createdAt,
    required this.user,
    required this.roleId,
  });

  Map<String, dynamic> toJson() {
    return _$EmployeeAggregateToJson(this);
  }

  factory EmployeeAggregate.fromJson(Map<String, dynamic> json) =>
      _$EmployeeAggregateFromJson(json);

  LoadStore<RoleAggregate?> getRole() {
    return GetIt.I.get<RoleStore>().get(roleId);
  }

  @override
  String getAbbreviate() {
    return 'СОТРУДНИК';
  }


  @override
  String getNewName() {
    return 'Новый сотрудник';
  }
}
