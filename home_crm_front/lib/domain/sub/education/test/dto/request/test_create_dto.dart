import 'package:json_annotation/json_annotation.dart';

part 'test_create_dto.g.dart';

@JsonSerializable()
class TestCreateDto {
  final String name;

  TestCreateDto({required this.name});

  Map<String, dynamic> toJson() {
    return _$TestCreateDtoToJson(this);
  }

  factory TestCreateDto.fromJson(Map<String, dynamic> json) =>
      _$TestCreateDtoFromJson(json);
}
