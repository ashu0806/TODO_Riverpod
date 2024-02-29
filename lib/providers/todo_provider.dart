import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/models/todo_model.dart';

part 'todo_provider.g.dart';

@riverpod
class Todo extends _$Todo {
  @override
  List<TodoModel> build() => [];

  void addTodo(TodoModel todoModel) {
    state = [todoModel, ...state];
  }

  void toggleTodo({
    required int id,
    required bool isCompleted,
  }) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(
            isCompleted: isCompleted,
          )
        else
          todo
    ];
  }
}
