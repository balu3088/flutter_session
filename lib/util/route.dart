import 'package:batch_four_exp/features/todo/presentation/add_todo.dart';

import 'package:batch_four_exp/home.dart';

import 'package:batch_four_exp/features/auth/login_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Login());
      case '/home':
        print(args);
        if (args is Map) {
          final title = args['title'] ?? '';
          return MaterialPageRoute(builder: (_) => Home(homeTitle: title));
        } else {
          return MaterialPageRoute(builder: (_) => Login());
        }
      case '/addTodo':
        return MaterialPageRoute(builder: (_) => AddTodo());

      default:
        return MaterialPageRoute(builder: (_) => Login());
    }
  }
}
