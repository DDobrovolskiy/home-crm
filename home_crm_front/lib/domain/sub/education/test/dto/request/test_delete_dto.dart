import 'package:json_annotation/json_annotation.dart';

part 'test_delete_dto.g.dart';

@JsonSerializable()
class TestDeleteDto {
  final int id;

  TestDeleteDto({required this.id});

  Map<String, dynamic> toJson() {
    return _$TestDeleteDtoToJson(this);
  }

  factory TestDeleteDto.fromJson(Map<String, dynamic> json) =>
      _$TestDeleteDtoFromJson(json);
}
