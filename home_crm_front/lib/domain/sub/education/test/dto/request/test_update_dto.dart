import 'package:json_annotation/json_annotation.dart';

part 'test_update_dto.g.dart';

@JsonSerializable()
class TestUpdateDto {
  final int id;
  final String name;
  final int timeLimitMinutes;

  TestUpdateDto({
    required this.id,
    required this.name,
    required this.timeLimitMinutes,
  });

  Map<String, dynamic> toJson() {
    return _$TestUpdateDtoToJson(this);
  }

  factory TestUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$TestUpdateDtoFromJson(json);
}
