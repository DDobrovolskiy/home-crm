import 'package:home_crm_front/domain/sub/education/session/dto/request/session_get_or_create_dto.dart';
import 'package:home_crm_front/domain/sub/education/session/dto/response/session_test_dto.dart';

import '../../../../support/port/port.dart';
import '../../result/dto/response/result_dto.dart';
import '../dto/request/session_result_dto.dart';

class SessionRepository {
  final String _path = 'education/session';
  final String _pathResult = 'education/session/result';

  Future<SessionTestDto?> getTest(SessionGetOrCreateDto dto) {
    return Port.post(
      _path,
      dto.toJson(),
      (j) => SessionTestDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<ResultDto?> sendResult(SessionResultDto dto) {
    return Port.post(
      _pathResult,
      dto.toJson(),
      (j) => ResultDto.fromJson(j as Map<String, dynamic>),
    );
  }
}
