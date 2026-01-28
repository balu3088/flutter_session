import 'package:batch_four_exp/features/todo/repo/todo_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoController extends StateNotifier<AsyncValue<List<String>>> {
  final TodoRepo todoRepo;
  TodoController(this.todoRepo) : super(AsyncValue.data([]));

  Future<void> addTodo(String addTodo) async {
    final previousList = state.value ?? [];
    state = AsyncValue.loading();
    final todoList = await todoRepo.addTodo(addTodo, previousList);
    state = AsyncValue.data(todoList);
  }

  Future<void> getTodoFromServer() async {
    //state = AsyncValue.loading();
    final todoList = await todoRepo.getTodoFromServer();
    state = AsyncValue.data(todoList);
  }
}
