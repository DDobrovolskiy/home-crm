import 'package:home_crm_front/domain/sub/education/aggregate/test_aggregate.dart';
import 'package:home_crm_front/domain/support/components/load/custom_load.dart';
import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

import '../../../support/components/status/doc.dart';
import '../../../support/port/port.dart';
import '../../../support/service/loaded.dart';
import '../aggregate/appointed_aggregate.dart';
import '../aggregate/option_aggregate.dart';
import '../aggregate/question_aggregate.dart';
import '../aggregate/session_aggregate.dart';

class EducationStore extends IsHasError {
  List<TestAggregate> testList = [
    TestAggregate(
      id: 1,
      name: 'Охрана труда',
      description: 'Вопросы по охране труда',
      status: StatusDoc.READY,
      timeLimitMinutes: 20,
      iteration: 3,
      answerCount: 2,
      questions: [
        QuestionAggregate(
          id: 1,
          text: 'Что нельзя делать с проводом?',
          options: [
            OptionAggregate(id: 1, text: 'Трогать', correct: false),
            OptionAggregate(id: 1, text: 'Думать о нем', correct: true),
          ],
        ),
        QuestionAggregate(
          id: 2,
          text: 'Какие ваши доказательства?',
          options: [
            OptionAggregate(id: 1, text: 'Трогать', correct: false),
            OptionAggregate(id: 1, text: 'Думать о нем', correct: true),
          ],
        ),
      ],
      appointed: [
        AppointedAggregate(
          id: 1,
          active: true,
          employeeId: 1,
          deadline: DateTime.now(),
          sessions: [
            SessionAggregate(
              id: 1,
              dateStart: DateTime.now(),
              dateEnd: DateTime.now().add(Duration(minutes: 20)),
              success: true,
              answers: 2,
            ),
          ],
          testId: 1,
        ),
        AppointedAggregate(
          id: 2,
          active: true,
          employeeId: 13,
          deadline: DateTime.now(),
          sessions: [],
          testId: 1,
        ),
      ],
    ),
    TestAggregate(
      id: 2,
      name: 'Пожарная безопасность',
      description: 'Вопросы по пожарнаой безопасность',
      status: StatusDoc.DRAFT,
      timeLimitMinutes: 0,
      iteration: 0,
      answerCount: 2,
      questions: [
        QuestionAggregate(
          id: 1,
          text: 'Что нельзя делать с проводом?',
          options: [
            OptionAggregate(id: 1, text: 'Трогать', correct: false),
            OptionAggregate(id: 1, text: 'Думать о нем', correct: true),
          ],
        ),
        QuestionAggregate(
          id: 2,
          text: 'Какие ваши доказательства?',
          options: [
            OptionAggregate(id: 1, text: 'Трогать', correct: false),
            OptionAggregate(id: 1, text: 'Думать о нем', correct: true),
          ],
        ),
      ],
      appointed: [
        AppointedAggregate(
          id: 3,
          active: false,
          employeeId: 1,
          deadline: DateTime.now(),
          sessions: [],
          testId: 2,
        ),
      ],
    ),
    TestAggregate(
      id: 3,
      name: 'Безопасность',
      description: 'Вопросы по безопасности',
      status: StatusDoc.READY,
      timeLimitMinutes: 20,
      iteration: 3,
      answerCount: 2,
      questions: [
        QuestionAggregate(
          id: 1,
          text: 'Что нельзя делать с проводом?',
          options: [
            OptionAggregate(id: 1, text: 'Трогать', correct: false),
            OptionAggregate(id: 1, text: 'Думать о нем', correct: true),
          ],
        ),
        QuestionAggregate(
          id: 2,
          text: 'Какие ваши доказательства?',
          options: [
            OptionAggregate(id: 1, text: 'Трогать', correct: false),
            OptionAggregate(id: 1, text: 'Думать о нем', correct: true),
          ],
        ),
      ],
      appointed: [
        AppointedAggregate(
          id: 3,
          active: true,
          employeeId: 1,
          deadline: DateTime.now(),
          sessions: [
            SessionAggregate(
              id: 1,
              dateStart: DateTime.now(),
              dateEnd: DateTime.now().add(Duration(minutes: 20)),
              success: false,
              answers: 2,
            ),
          ],
          testId: 3,
        ),
      ],
    ),
    TestAggregate(
      id: 4,
      name: 'Безопасность',
      description: 'Вопросы по безопасности',
      status: StatusDoc.READY,
      timeLimitMinutes: 20,
      iteration: 3,
      answerCount: 2,
      questions: [
        QuestionAggregate(
          id: 1,
          text: 'Что нельзя делать с проводом?',
          options: [
            OptionAggregate(id: 1, text: 'Трогать', correct: false),
            OptionAggregate(id: 1, text: 'Думать о нем', correct: true),
          ],
        ),
        QuestionAggregate(
          id: 2,
          text: 'Какие ваши доказательства?',
          options: [
            OptionAggregate(id: 1, text: 'Трогать', correct: false),
            OptionAggregate(id: 1, text: 'Думать о нем', correct: true),
          ],
        ),
      ],
      appointed: [
        AppointedAggregate(
          id: 4,
          active: true,
          employeeId: 1,
          deadline: DateTime.tryParse('2025-12-19'),
          sessions: [],
          testId: 4,
        ),
      ],
    ),
    TestAggregate(
      id: 5,
      name: 'Охрана труда new',
      description: 'Вопросы по охране труда',
      status: StatusDoc.READY,
      timeLimitMinutes: 20,
      iteration: 1,
      answerCount: 2,
      questions: [
        QuestionAggregate(
          id: 1,
          text: 'Что нельзя делать с проводом?',
          options: [
            OptionAggregate(id: 1, text: 'Трогать', correct: false),
            OptionAggregate(id: 1, text: 'Думать о нем', correct: true),
          ],
        ),
        QuestionAggregate(
          id: 2,
          text: 'Какие ваши доказательства?',
          options: [
            OptionAggregate(id: 1, text: 'Трогать', correct: false),
            OptionAggregate(id: 1, text: 'Думать о нем', correct: true),
          ],
        ),
      ],
      appointed: [
        AppointedAggregate(
          id: 5,
          active: true,
          employeeId: 1,
          deadline: DateTime.now(),
          sessions: [
            SessionAggregate(
              id: 1,
              dateStart: DateTime.now(),
              dateEnd: DateTime.now().add(Duration(minutes: 20)),
              success: false,
              answers: 2,
            ),
          ],
          testId: 5,
        ),
      ],
    ),
  ];

  bool load = false;
  PortException? error;
  LoadCallback loadCallback = LoadCallback();
  final Map<int, TestAggregate> tests = {};

  Future<Map<int, TestAggregate>> refresh(Loaded loaded) async {
    if (loaded.needLoad(this)) {
      try {
        //тут репа
        load = true;
        tests.clear();
        testList.forEach((e) {
          tests[e.id!] = e;
        });
        if (loaded != Loaded.ifNotLoad) {
          loadCallback.call();
        }
      } catch (e) {
        error = Port.errorHandler(e);
      }
    }
    return tests;
  }

  Future<List<TestAggregate>> _all() async {
    var list = (await refresh(Loaded.ifNotLoad)).values.toList();
    list.sort((a, b) => b.id!.compareTo(a.id!));
    return list;
  }

  LoadStore<List<TestAggregate>> getAll() {
    return LoadStore(value: () => _all(), callback: loadCallback);
  }

  Future<TestAggregate?> _id(int id) async {
    var testAggregate = (await refresh(Loaded.ifNotLoad))[id];
    return testAggregate;
  }

  LoadStore<TestAggregate?> get(int id) {
    return LoadStore(value: () => _id(id), callback: loadCallback);
  }

  @override
  PortException? getError() {
    return error;
  }

  @override
  bool loaded() {
    return load;
  }

  void save(List<TestAggregate> tests) {
    tests.where((t) => t.id == null).forEach((t) => t.id = testList.length + 1);
    testList.addAll(tests);
    refresh(Loaded.ifLoad);
  }

  void delete(Set<int> ids) {
    testList.removeWhere((t) => ids.contains(t.id));
    refresh(Loaded.ifLoad);
  }
}
