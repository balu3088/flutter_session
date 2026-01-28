import 'package:batch_four_exp/features/todo/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/todo/controller/todo_controller.dart';

class Home extends ConsumerStatefulWidget {
  final String homeTitle;
  Home({super.key, required this.homeTitle});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    ref.read(todoController.notifier).getTodoFromServer();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = ref.watch(todoController);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: todoProvider.when(
          data: (response) {
            final todoList = response ?? [];
            return LayoutBuilder(builder: (context, constrains) {
              return Stack(children: [
                Positioned.fill(
                    child: Image.asset(
                  "assets/images/background.jpg",
                  fit: BoxFit.cover,
                )),
                Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      Container(
                          height: constrains.maxHeight * 0.9,
                          width: constrains.maxWidth * 0.9,
                          padding:
                              EdgeInsets.only(top: 20, left: 10, right: 10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: ListView.builder(
                            itemCount: todoList.length,
                            itemBuilder: (context, index) {
                              return Text(todoList[index]);
                            },
                          ))
                    ]))
              ]);
            });
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Text(error.toString())),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addTodo');
          },
          child: Icon(Icons.add_circle_outline_rounded)),
    );
  }
}
