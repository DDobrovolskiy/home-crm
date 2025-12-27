import 'package:home_crm_front/domain/sub/education/aggregate/test_aggregate.dart';
import 'package:home_crm_front/domain/support/components/load/custom_load.dart';

import '../../../support/components/status/doc.dart';
import '../../../support/components/store/store.dart';
import '../../../support/service/loaded.dart';
import '../aggregate/appointed_aggregate.dart';
import '../aggregate/option_aggregate.dart';
import '../aggregate/question_aggregate.dart';
import '../aggregate/session_aggregate.dart';

class EducationStore extends Store<TestAggregate> {
  List<TestAggregate> testList1 = List.generate(
    3000,
        (id) =>
        TestAggregate(
          id: id,
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
              id: id,
              active: true,
              employeeId: 1,
              deadline: DateTime.now(),
              sessions: [
                SessionAggregate(
                  id: id,
                  dateStart: DateTime.now(),
                  dateEnd: DateTime.now().add(Duration(minutes: 20)),
                  success: true,
                  answers: 2,
                ),
              ],
              testId: id,
            ),
          ],
        ),
  );

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
          id: 2,
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

  Future<List<TestAggregate>> _all(bool showArchive) async {
    var list = (await refresh(
      Loaded.ifNotLoad,
    )).values.where((t) => t.active == true || showArchive).toList();
    list.sort((a, b) => b.id!.compareTo(a.id!));
    return list;
  }

  LoadStore<List<TestAggregate>> getAll(bool showArchive) {
    return LoadStore(
      value: () => _all(showArchive),
      callback: loadCallback,
    );
  }

  LoadStore<Map<int, TestAggregate>> getAllMap() {
    return LoadStore(
      value: () async => (await refresh(Loaded.ifNotLoad)),
      callback: loadCallback,
    );
  }

  void save(List<TestAggregate> tests) {
    //TODO
    tests.where((t) => t.id == null).forEach((t) => t.id = testList.length + 1);
    testList.addAll(tests);
    refresh(Loaded.ifLoad);
  }

  void toArchive(Set<int> ids) {
    //TODO
    testList.where((t) => ids.contains(t.id)).forEach((t) => t.doArchive());
    refreshOnIds(ids);
  }

  void delete(Set<int> ids) {
    //TODO
    testList.removeWhere((t) => ids.contains(t.id));
    refreshOnIds(ids);
  }

  @override
  Future<void> loadData() async {
    //TODO
    testList.forEach((e) {
      data[e.id!] = e;
    });
  }

  @override
  Future<List<TestAggregate>?> loadDataIds(Set<int> ids) async {
    return testList.where((t) => ids.contains(t.id)).toList();
  }
}
