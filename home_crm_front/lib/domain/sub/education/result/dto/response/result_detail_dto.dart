import 'package:json_annotation/json_annotation.dart';

part 'result_detail_dto.g.dart';

@JsonSerializable()
class ResultDetailDto {
  final int id;
  final String questionText;
  final bool isCorrect;

  ResultDetailDto({
    required this.id,
    required this.questionText,
    required this.isCorrect,
  });

  Map<String, dynamic> toJson() {
    return _$ResultDetailDtoToJson(this);
  }

  factory ResultDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ResultDetailDtoFromJson(json);
}
