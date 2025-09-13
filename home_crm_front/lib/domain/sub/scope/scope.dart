enum ScopeType {
  ORGANIZATION_UPDATE(description: 'Изменение организации'),
  TEST_CREATE(description: 'Создание тестов');

  final String description;

  const ScopeType({required this.description});
}
