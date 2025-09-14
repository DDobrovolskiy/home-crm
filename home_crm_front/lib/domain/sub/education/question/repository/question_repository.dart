import 'package:home_crm_front/domain/sub/education/question/dto/request/question_create_dto.dart';
import 'package:home_crm_front/domain/sub/education/question/dto/request/question_delete_dto.dart';
import 'package:home_crm_front/domain/sub/education/question/dto/request/question_update_dto.dart';
import 'package:home_crm_front/domain/sub/education/question/dto/response/question_dto.dart';
import 'package:home_crm_front/domain/sub/education/question/dto/response/question_options_dto.dart';

import '../../../../support/port/port.dart';

class QuestionRepository {
  final String _path = 'education/question';

  Future<QuestionDto?> get(int id) {
    return Port.get(
      'education/question/${id}',
      (j) => QuestionDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<QuestionOptionsDto?> getOptions(int id) {
    return Port.get(
      'education/question/${id}/options',
      (j) => QuestionOptionsDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<QuestionDto?> create(QuestionCreateDto dto) {
    return Port.post(
      _path,
      dto.toJson(),
      (j) => QuestionDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<QuestionDto?> update(QuestionUpdateDto dto) {
    return Port.put(
      _path,
      dto.toJson(),
      (j) => QuestionDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<int?> delete(QuestionDeleteDto dto) {
    return Port.delete(_path, dto.toJson(), (j) => j as int);
  }
}
