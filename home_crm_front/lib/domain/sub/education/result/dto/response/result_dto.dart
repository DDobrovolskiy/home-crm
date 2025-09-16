import 'package:home_crm_front/domain/sub/education/result/dto/response/result_detail_dto.dart';
import 'package:home_crm_front/domain/sub/education/session/dto/response/session_dto.dart';
import 'package:home_crm_front/domain/sub/education/test/dto/response/test_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result_dto.g.dart';

@JsonSerializable()
class ResultDto {
  final int id;
  final TestDto test;
  final String completedAt;
  final SessionDto session;
  final List<ResultDetailDto> details;

  ResultDto({
    required this.id,
    required this.test,
    required this.completedAt,
    required this.session,
    required this.details,
  });

  Map<String, dynamic> toJson() {
    return _$ResultDtoToJson(this);
  }

  factory ResultDto.fromJson(Map<String, dynamic> json) =>
      _$ResultDtoFromJson(json);
}
