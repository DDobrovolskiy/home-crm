import 'package:json_annotation/json_annotation.dart';

part 'test_update_ready_dto.g.dart';

@JsonSerializable()
class TestUpdateReadyDto {
  final int id;
  final bool ready;

  TestUpdateReadyDto({required this.id, required this.ready});

  Map<String, dynamic> toJson() {
    return _$TestUpdateReadyDtoToJson(this);
  }

  factory TestUpdateReadyDto.fromJson(Map<String, dynamic> json) =>
      _$TestUpdateReadyDtoFromJson(json);
}
