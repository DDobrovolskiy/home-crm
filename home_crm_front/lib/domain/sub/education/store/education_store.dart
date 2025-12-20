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
          employeeId: 11,
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
        ),
        AppointedAggregate(
          employeeId: 13,
          deadline: DateTime.now(),
          sessions: [],
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
    return (await refresh(Loaded.ifNotLoad))[id];
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

  void save(TestAggregate test) {
    if (test.id == null) {
      test.id = 3;
      tests[test.id!] = test;
    } else {
      tests[test.id!] = test;
    }
    refresh(Loaded.ifLoad);
  }
}
