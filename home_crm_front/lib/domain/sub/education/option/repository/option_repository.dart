import '../../../../support/port/port.dart';
import '../dto/request/option_create_dto.dart';
import '../dto/request/option_delete_dto.dart';
import '../dto/request/option_update_dto.dart';
import '../dto/response/option_dto.dart';

class OptionRepository {
  final String _path = 'education/option';

  Future<OptionDto?> get(int id) {
    return Port.get(
      'education/option/${id}',
      (j) => OptionDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<OptionDto?> create(OptionCreateDto dto) {
    return Port.post(
      _path,
      dto.toJson(),
      (j) => OptionDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<OptionDto?> update(OptionUpdateDto dto) {
    return Port.put(
      _path,
      dto.toJson(),
      (j) => OptionDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<int?> delete(OptionDeleteDto dto) {
    return Port.delete(_path, dto.toJson(), (j) => j as int);
  }
}
