import 'package:json_annotation/json_annotation.dart';

part 'auth_response_dto.g.dart';

@JsonSerializable()
class AuthResponseDto {
  final String token;
  final int userId;

  AuthResponseDto({required this.token, required this.userId});

  Map<String, dynamic> toJson() {
    return _$AuthResponseDtoToJson(this);
  }

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);
}
