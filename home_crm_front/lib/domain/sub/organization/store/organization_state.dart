import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';
import 'package:home_crm_front/domain/sub/user/store/user_state.dart';

class OrganizationState {
  final int id;
  final String name;
  final UserState owner;

  OrganizationState({
    required this.id,
    required this.name,
    required this.owner,
  });

  static OrganizationState from(OrganizationDto dto) {
    return OrganizationState(
      id: dto.id,
      name: dto.name,
      owner: UserState.fromBase(dto.owner),
    );
  }
}
