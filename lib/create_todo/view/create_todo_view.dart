import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/create_todo/create_todo.dart';
import 'package:project/create_todo/models/new_todo.dart';
import 'package:project/todos/bloc/todos_bloc.dart';
import 'package:project/todos/models/todo.dart';

class CreateTodoView extends StatelessWidget {
  const CreateTodoView({Key? key}) : super(key: key);
  static Route<void> route(TodosBloc bloc) {
    return MaterialPageRoute(
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CreateTodoBloc(),
            ),
            BlocProvider.value(value: bloc),
          ],
          child: const CreateTodoView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTodoBloc, CreateTodoState>(
      listenWhen: (previous, current) => current.status != previous.status,
      listener: (BuildContext context, CreateTodoState state) {
        if (state.status == CreateTodoStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Something went wrong'),
            ),
          );
        }

        if (state.status == CreateTodoStatus.loaded) {
          Navigator.pop(context);
        }
      },
      buildWhen: (previous, current) => current.status != previous.status,
      builder: (BuildContext context, CreateTodoState state) {
        if ([CreateTodoStatus.initial, CreateTodoStatus.loading]
            .contains(state.status)) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add new to-do'),
            ),
            body: Column(
              children: [
                const Text('Title'),
                const _CreateTodoTitle(),
                const Text('Description'),
                const _CreateTodoDescription(),
                MaterialButton(
                  color: Colors.black12,
                  onPressed: () {
                    context
                        .read<CreateTodoBloc>()
                        .add(const TodoNewSubmit(submit: true));
                    context.read<TodosBloc>().add(
                           AddTodo(todo: context.read<CreateTodoBloc>().state.todo)
                        );
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                if (state.status == CreateTodoStatus.loading) ...[
                  const CircularProgressIndicator(),
                  Text('Loading')
                ],
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

class _CreateTodoTitle extends StatelessWidget {
  const _CreateTodoTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        context
            .read<CreateTodoBloc>()
            .add(OnSubmittedTitle(title: value.toString()));
      },
    );
  }
}

class _CreateTodoDescription extends StatelessWidget {
  const _CreateTodoDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        context
            .read<CreateTodoBloc>()
            .add(OnSubmittedDescription(description: value.toString()));
      },
    );
  }
}
