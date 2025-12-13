import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final int id;
  final String name;
  final String phone;

  UserDto({
    required this.id,
    required this.name, required this.phone});

  Map<String, dynamic> toJson() {
    return _$UserDtoToJson(this);
  }

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  String getFullName() {
    return name;
  }
}
