import 'package:json_annotation/json_annotation.dart';

part 'option_update_dto.g.dart';

@JsonSerializable()
class OptionUpdateDto {
  final int id;
  final String text;
  final bool correct;

  OptionUpdateDto({
    required this.id,
    required this.text,
    required this.correct,
  });

  Map<String, dynamic> toJson() {
    return _$OptionUpdateDtoToJson(this);
  }

  factory OptionUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$OptionUpdateDtoFromJson(json);
}
