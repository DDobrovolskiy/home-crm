import 'package:home_crm_front/domain/sub/role/dto/role_dto.dart';

class RoleState {
  final int id;
  final String name;
  final String description;

  RoleState({required this.id, required this.name, required this.description});

  static RoleState from(RoleDto dto) {
    return RoleState(id: dto.id, name: dto.name, description: dto.description);
  }
}
