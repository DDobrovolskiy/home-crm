import 'package:json_annotation/json_annotation.dart';

part 'user_base_dto.g.dart';

@JsonSerializable()
class UserBaseDto {
  final int id;
  final String name;
  final String phone;

  UserBaseDto({required this.id, required this.name, required this.phone});

  Map<String, dynamic> toJson() {
    return _$UserBaseDtoToJson(this);
  }

  factory UserBaseDto.fromJson(Map<String, dynamic> json) =>
      _$UserBaseDtoFromJson(json);
}
