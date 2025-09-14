import 'package:json_annotation/json_annotation.dart';

import '../../../session/dto/response/session_dto.dart';

part 'test_sessions_dto.g.dart';

@JsonSerializable()
class TestSessionsDto {
  final List<SessionDto> sessions;

  TestSessionsDto({required this.sessions});

  Map<String, dynamic> toJson() {
    return _$TestSessionsDtoToJson(this);
  }

  factory TestSessionsDto.fromJson(Map<String, dynamic> json) =>
      _$TestSessionsDtoFromJson(json);
}
