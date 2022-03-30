import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/create_todo/models/new_todo.dart';
import 'package:project/todos/bloc/todos_bloc.dart';
import 'package:project/todos/models/todo.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'create_todo_event.dart';
part 'create_todo_state.dart';

class CreateTodoBloc extends Bloc<CreateTodoEvent, CreateTodoState> {
  CreateTodoBloc() : super(const CreateTodoState.initial()) {
    on<OnSubmittedTitle>(_mapOnSubmittedTitle);
    on<TodoNewSubmit>(_mapOnSubmitButton);
  }

  Future<void> _mapOnSubmittedTitle(
      OnSubmittedTitle event, Emitter<CreateTodoState> emit) async {
    final todoTitle = event.title;
    final updatedNewTodo = state.todo.copyWith(task: todoTitle);
    emit(
        state.copyWith(todo: updatedNewTodo, status: CreateTodoStatus.loading));
  }

  Future<void> _mapOnSubmitButton(
      TodoNewSubmit event, Emitter<CreateTodoState> emit) async {
    emit(state.copyWith(status: CreateTodoStatus.loaded) );
  }

  // Future<void> _mapOnSubmittedDescription(
  //     CreateTodoEvent event, Emitter<CreateTodoEvent> emit) {}
  // Future<void> _mapOnSubmittedCompleted(
  //     CreateTodoEvent event, Emitter<CreateTodoEvent> emit) {}
  // Future<void> _mapOnSubmittedId(
  //     CreateTodoEvent event, Emitter<CreateTodoEvent> emit) {}
  // Future<void> _mapTodoNewSubmit(
  //     CreateTodoEvent event, Emitter<CreateTodoEvent> emit) {}
}
