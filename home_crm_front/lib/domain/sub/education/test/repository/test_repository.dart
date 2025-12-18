

class TestRepository {
  final String _path = 'education/test';
  final String _pathReady = 'education/test/ready';

  // Future<TestDto?> getTest(int id) {
  //   return Port.get(
  //     'education/test/${id}',
  //     (j) => TestDto.fromJson(j as Map<String, dynamic>),
  //   );
  // }
  //
  // Future<TestQuestionsDto?> getTestQuestions(int id) {
  //   return Port.get(
  //     'education/test/${id}/questions',
  //     (j) => TestQuestionsDto.fromJson(j as Map<String, dynamic>),
  //   );
  // }
  //
  // Future<TestDto?> create(TestCreateDto dto) {
  //   return Port.post(
  //     _path,
  //     dto.toJson(),
  //     (j) => TestDto.fromJson(j as Map<String, dynamic>),
  //   );
  // }

  // Future<TestDto?> update(TestUpdateDto dto) {
//   return Port.put(
//     _path,
//     dto.toJson(),
//     (j) => TestDto.fromJson(j as Map<String, dynamic>),
//   );
// }
//
// Future<TestDto?> updateReady(TestUpdateReadyDto dto) {
//   return Port.put(
//     _pathReady,
//     dto.toJson(),
//     (j) => TestDto.fromJson(j as Map<String, dynamic>),
//   );
// }
//
// Future<TestDto?> assign(TestAssignDto dto) {
//   return Port.put(
//     'education/test/assign',
//     dto.toJson(),
//     (j) => TestDto.fromJson(j as Map<String, dynamic>),
//   );
// }

  // Future<TestDto?> unassign(TestAssignDto dto) {
  //   return Port.put(
  //     'education/test/unassign',
  //     dto.toJson(),
  //     (j) => TestDto.fromJson(j as Map<String, dynamic>),
  //   );
  // }
  //
  // Future<int?> delete(TestDeleteDto dto) {
  //   return Port.delete(_path, dto.toJson(), (j) => j as int);
  // }
}
