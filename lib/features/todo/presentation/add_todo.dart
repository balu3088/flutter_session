import 'package:batch_four_exp/features/todo/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTodo extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends ConsumerState<AddTodo> {
  TextEditingController _addTodo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constrains) {
        return Stack(children: [
          Positioned.fill(
              child: Image.asset(
            "assets/images/background.jpg",
            fit: BoxFit.cover,
          )),
          Center(
            child: Container(
                height: constrains.maxHeight * 0.3,
                width: constrains.maxWidth * 0.3,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        padding: EdgeInsets.all(10.0),
                        height: constrains.maxHeight * 0.1,
                        width: constrains.maxWidth * 0.2,
                        child: TextField(
                          style: TextStyle(fontSize: 12),
                          controller: _addTodo,
                          decoration: InputDecoration(
                              hintText: "Enter Todo",
                              border: OutlineInputBorder()),
                        )),
                    IconButton(
                        onPressed: () {
                          ref
                              .read(todoController.notifier)
                              .addTodo(_addTodo.text.toString());
                          _addTodo.clear();
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.add_circle_outline))
                  ],
                )),
          )
        ]);
      }),
    );
  }
}
