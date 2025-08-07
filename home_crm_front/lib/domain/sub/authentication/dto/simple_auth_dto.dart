import 'package:json_annotation/json_annotation.dart';

part 'simple_auth_dto.g.dart';

@JsonSerializable()
class SimpleAuthDto {
  final String phone;
  final String password;

  SimpleAuthDto({required this.phone, required this.password});

  Map<String, dynamic> toJson() {
    return _$SimpleAuthDtoToJson(this);
  }

  factory SimpleAuthDto.fromJson(Map<String, dynamic> json) =>
      _$SimpleAuthDtoFromJson(json);
}
