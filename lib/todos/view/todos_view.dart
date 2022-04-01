// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/create_todo/create_todo.dart';
import 'package:project/todos/bloc/todos_bloc.dart';
import 'package:project/todos/models/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal[100],
            title: const Text('Todos App'),
          ),
          body: const _TodosList(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal[200],
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                CreateTodoView.route(context),
              );
            },
          ),
        );
      }),
    );
  }
}

class _TodosList extends StatelessWidget {
  const _TodosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.select((TodosBloc bloc) => bloc.state.todos);

    return Container(
      padding: const EdgeInsets.all(14.0),
      child: ReorderableListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: todos.length,
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) newIndex -= 1;

          context.read<TodosBloc>().add(
                TodoPriorityUpdated(
                  position: newIndex,
                  todo: todos[oldIndex],
                ),
              );
        },
        itemBuilder: (_, index) {
          return _TodoListTile(
            key: ValueKey('todosPage_todosList_todosListTile_$index'),
            position: index,
            todo: todos[index],
          );
        },
      ),
    );
  }
}

class _TodoListTile extends StatelessWidget {
  const _TodoListTile({
    Key? key,
    required this.position,
    required this.todo,
  }) : super(key: key);

  final int position;
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: const [
          // A SlidableAction can have an icon and/or a label.
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => showDialog(
              context: context,
              builder: (BuildContext _) => AlertDialog(
                content: Text('Delete this task?'),
                actions: <Widget>[
                  MaterialButton(
                    child: Text('Cancel'),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 65,
                  ),
                  MaterialButton(
                    child: Text('Delete'),
                    onPressed: () {
                      context.read<TodosBloc>().add(RemoveTodo(id: todo.id));
                      
                    },
                  )
                ],
              ),
            ),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: CheckboxListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //tileColor: Colors.amber[100],
        activeColor: Colors.lightGreen[400],
        selectedTileColor: Colors.tealAccent[100],
        contentPadding: EdgeInsets.only(right: 30),
        value: todo.completed,
        onChanged: (value) {
          context
              .read<TodosBloc>()
              .add(TodoCompletedToggled(completed: value ?? false, todo: todo));
        },
        secondary: Container(
          alignment: Alignment.center,
          height: 40.0,
          width: 20.0,
          child: Text(
            position.toString(),
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
        title: Text(todo.task),
        subtitle: Text(todo.description),
      ),
    );
  }
}

class _PopUp extends StatelessWidget {
  const _PopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      actions: [TextField()],
    );
  }
}
