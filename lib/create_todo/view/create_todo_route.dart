import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../create_todo.dart';
import 'create_todo_view.dart';

class CreateTodoRoute extends StatelessWidget {
  const CreateTodoRoute({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (ctx) {
        return BlocProvider(
          create: (_) => CreateTodoBloc(),
          child: const CreateTodoView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const CreateTodoView();
  }
}