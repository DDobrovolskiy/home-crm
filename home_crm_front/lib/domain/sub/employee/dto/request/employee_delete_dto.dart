import 'package:json_annotation/json_annotation.dart';

part 'employee_delete_dto.g.dart';

@JsonSerializable()
class EmployeeDeleteDto {
  final int id;

  EmployeeDeleteDto({required this.id});

  Map<String, dynamic> toJson() {
    return _$EmployeeDeleteDtoToJson(this);
  }

  factory EmployeeDeleteDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeDeleteDtoFromJson(json);
}
