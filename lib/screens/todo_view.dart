import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/models/todo_model.dart';
import 'package:todo_riverpod/providers/todo_provider.dart';

class TodoView extends HookConsumerWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoController = useTextEditingController();
    var todos = ref.watch(todoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo List",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            children: [
              TextFormField(
                controller: todoController,
                onFieldSubmitted: (value) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  todoController.clear();
                  ref.read(todoProvider.notifier).addTodo(
                        TodoModel(
                          id: Random().nextInt(1000),
                          desc: value,
                          isCompleted: false,
                        ),
                      );
                },
                decoration: const InputDecoration(
                  hintText: "Add todo",
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  var todo = todos[index];
                  return ListTile(
                    title: Text(
                      todo.desc,
                    ),
                    trailing: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (value) {
                        ref.read(todoProvider.notifier).toggleTodo(
                              id: todo.id,
                              isCompleted: value!,
                            );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
