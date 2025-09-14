import 'package:home_crm_front/domain/sub/education/question/dto/response/question_dto.dart';
import 'package:home_crm_front/domain/sub/employee/dto/request/employee_create_dto.dart';
import 'package:home_crm_front/domain/sub/employee/dto/request/employee_delete_dto.dart';
import 'package:home_crm_front/domain/sub/employee/dto/request/employee_update_dto.dart';

import '../../../../support/port/port.dart';

class QuestionRepository {
  final String _path = 'education/question';

  Future<QuestionDto?> get(int id) {
    return Port.get(
      'education/question/${id}',
      (j) => QuestionDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<QuestionDto?> create(EmployeeCreateDto dto) {
    return Port.post(
      _path,
      dto.toJson(),
      (j) => QuestionDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<QuestionDto?> update(EmployeeUpdateDto dto) {
    return Port.put(
      _path,
      dto.toJson(),
      (j) => QuestionDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<int?> delete(EmployeeDeleteDto dto) {
    return Port.delete(_path, dto.toJson(), (j) => j as int);
  }
}
