import 'package:json_annotation/json_annotation.dart';

part 'simple_login_dto.g.dart';

@JsonSerializable()
class SimpleLoginDto {
  final String phone;
  final String password;

  SimpleLoginDto({required this.phone, required this.password});

  Map<String, dynamic> toJson() {
    return _$SimpleLoginDtoToJson(this);
  }

  factory SimpleLoginDto.fromJson(Map<String, dynamic> json) =>
      _$SimpleLoginDtoFromJson(json);
}
