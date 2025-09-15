import 'package:json_annotation/json_annotation.dart';

part 'option_create_dto.g.dart';

@JsonSerializable()
class OptionCreateDto {
  final String text;
  final bool correct;
  final int questionId;

  OptionCreateDto({
    required this.correct,
    required this.text,
    required this.questionId,
  });

  Map<String, dynamic> toJson() {
    return _$OptionCreateDtoToJson(this);
  }

  factory OptionCreateDto.fromJson(Map<String, dynamic> json) =>
      _$OptionCreateDtoFromJson(json);
}
