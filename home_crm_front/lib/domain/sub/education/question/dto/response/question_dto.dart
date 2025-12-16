import 'package:json_annotation/json_annotation.dart';

import '../../../option/dto/response/option_dto.dart';

part 'question_dto.g.dart';

@JsonSerializable()
class QuestionDto {
  late int? id;
  late String text;
  late List<OptionDto> options;

  QuestionDto({
    this.id,
    required this.text,
    required this.options,
  });

  Map<String, dynamic> toJson() {
    return _$QuestionDtoToJson(this);
  }

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);
}
