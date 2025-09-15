import 'package:json_annotation/json_annotation.dart';

part 'option_delete_dto.g.dart';

@JsonSerializable()
class OptionDeleteDto {
  final int id;

  OptionDeleteDto({required this.id});

  Map<String, dynamic> toJson() {
    return _$OptionDeleteDtoToJson(this);
  }

  factory OptionDeleteDto.fromJson(Map<String, dynamic> json) =>
      _$OptionDeleteDtoFromJson(json);
}
