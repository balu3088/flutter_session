import 'package:batch_four_exp/features/todo/service/todo_data.dart';

class TodoRepo {
  final TodoData todoDataSource;
  TodoRepo(this.todoDataSource);
  Future<List<String>> addTodo(String todoData, List<String> todoList) async {
    return todoDataSource.addTodo(todoData, todoList);
  }

  Future<List<String>> getTodoFromServer() async {
    return todoDataSource.getTodoFromServer();
  }
}
