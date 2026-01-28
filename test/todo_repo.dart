import 'package:batch_four_exp/features/todo/service/todo_data.dart';
import 'package:batch_four_exp/features/todo/repo/todo_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'todo_repo.mocks.dart';

@GenerateMocks([TodoData])
void main() {
  late MockTodoData todoData;
  late TodoRepo todoRepo;
  setUp(() {
    todoData = MockTodoData();
    todoRepo = TodoRepo(todoData);
  });

  test('getDataFromServer', () async {
    final fakeList = ["A", "B", "C"];
    when(todoData.getTodoFromServer()).thenAnswer((_) async => fakeList);

    final result = await todoRepo.getTodoFromServer();
    expect(result, fakeList);
    verify(todoData.getTodoFromServer()).called(1);
    verifyNoMoreInteractions(todoData);
  });
}
