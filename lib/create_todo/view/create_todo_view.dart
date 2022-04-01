import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/create_todo/create_todo.dart';
import 'package:project/todos/bloc/todos_bloc.dart';

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
            const SnackBar(
              content: Text('Something went wrong'),
            ),
          );
        }

        if (state.status == CreateTodoStatus.loaded) {
          Navigator.pop(context);
        }
        if (state.status == CreateTodoStatus.submitted) {}
      },
      buildWhen: (previous, current) => current.status != previous.status,
      builder: (BuildContext context, CreateTodoState state) {
        if ([
          CreateTodoStatus.initial,
          CreateTodoStatus.loading,
          CreateTodoStatus.submitted
        ].contains(state.status)) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add new to-do'),
              backgroundColor: Colors.teal[100],
            ),
            body: Center(
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.teal[50],
                    elevation: 25,
                    margin: const EdgeInsets.symmetric(
                        vertical: 100, horizontal: 70),
                    child: Column(
                      children: const [
                        _CreateTodoTitle(),
                        _CreateTodoDescription(),
                        SizedBox(
                          height: 20,
                        ),
                        _SubmitButton(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  if (state.status == CreateTodoStatus.loading) ...[
                    const _WaitDataSubmittion(),
                    
                  ],
                ],
              ),
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
    return Center(
      child: SizedBox(
        width: 400,
        child: Column(
          children: [
            const Text(
              'Title',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            TextField(
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(gapPadding: 4.0),
                hintText: 'Tender la cama',
              ),
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                context
                    .read<CreateTodoBloc>()
                    .add(OnSubmittedTitle(title: value.toString()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateTodoDescription extends StatelessWidget {
  const _CreateTodoDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            'Description',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          SizedBox(
            width: 400,
            child: TextField(
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(gapPadding: 4.0),
                hintText: 'La de dos plazas',
              ),
              expands: false,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                context
                    .read<CreateTodoBloc>()
                    .add(OnSubmittedDescription(description: value.toString()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //select hace que escuche siempre los cambios de status en este caso
    // final status = context.select((CreateTodoBloc bloc) => bloc.state.status);
    // final isLoading = status == CreateTodoStatus.loading;
    return BlocBuilder<CreateTodoBloc, CreateTodoState>(
      builder: (context, state) {
        return MaterialButton(
          focusColor: Colors.black54,
          child: const Icon(
            Icons.check,
            color: Colors.white70,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.black54,
          onPressed: 
           state.status == CreateTodoStatus.loading ? null : (){
              context.read<CreateTodoBloc>().add(const TodoNewSubmit(submit: true));
              context.read<TodosBloc>()
                  .add(AddTodo(todo: context.read<CreateTodoBloc>().state.todo));
            }
          
          
        );
      },
    );
  }
}

class _WaitDataSubmittion extends StatelessWidget {
  const _WaitDataSubmittion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text('Loading'), CircularProgressIndicator()],
    );
  }
}
