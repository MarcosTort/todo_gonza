// ignore_for_file: unused_local_variable
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:project/todos/models/todo.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc()
      //preguntar a gian que es el super
      : super(TodosState(
          status: TodosStatus.initial,
          todos: Todo.initialList,
        )) {
    on<TodoCompletedToggled>(_mapTodoCompletedToggledToState);
    on<TodoPriorityUpdated>(_mapTodoPriorityUpdatedToState);
    on<AddTodo>(_mapAddTodo);
  }

  Future<void> _mapTodoCompletedToggledToState(
      TodoCompletedToggled event, Emitter<TodosState> emit) async {
    final todoIndex = state.todos.indexOf(event.todo);

    final updatedTodos =
        state.todos.where((todo) => todo.id != event.todo.id).toList();

    final updatedTodo = event.todo.copyWith(completed: !event.todo.completed);

    updatedTodos.insert(todoIndex, updatedTodo);
    emit(state.copyWith(todos: updatedTodos));
  }

  Future<void> _mapTodoPriorityUpdatedToState(
      TodoPriorityUpdated event, Emitter<TodosState> emit) async {
    final updatedTodos =
        state.todos.where((todo) => todo.id != event.todo.id).toList();

    updatedTodos.insert(event.position, event.todo);

    emit(state.copyWith(todos: updatedTodos));
  }

  Future<void> _mapAddTodo(AddTodo event, Emitter<TodosState> emit) async {
    final newTodo = event.todo;
    final updatedTodos = List<Todo>.from(state.todos);
    updatedTodos.add(newTodo);
    emit(state.copyWith(todos: updatedTodos));
  }
}
