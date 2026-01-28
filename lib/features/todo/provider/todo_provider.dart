import 'package:batch_four_exp/features/todo/controller/todo_controller.dart';
import 'package:batch_four_exp/features/todo/service/todo_data.dart';
import 'package:batch_four_exp/features/todo/repo/todo_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final todoRepository = Provider<TodoRepo>((ref) {
  return TodoRepo(TodoData());
});
final todoController =
    StateNotifierProvider<TodoController, AsyncValue<List<String>>>((ref) {
  return TodoController(ref.watch(todoRepository));
});
