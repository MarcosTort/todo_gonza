import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project/todos/models/todo.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'create_todo_event.dart';
part 'create_todo_state.dart';

class CreateTodoBloc extends Bloc<CreateTodoEvent, CreateTodoState> {
  CreateTodoBloc() : super(const CreateTodoState.initial()) {
    on<OnSubmittedTitle>(_mapOnSubmittedTitle);
    on<TodoNewSubmit>(_mapOnSubmitButton);
    on<OnSubmittedDescription>(_mapOnSubmittedDescription);
  }

  Future<void> _mapOnSubmittedTitle(
      OnSubmittedTitle event, Emitter<CreateTodoState> emit) async {
    final todoTitle = event.title;
    final updatedNewTodo = state.todo.copyWith(task: todoTitle);
    emit(state.copyWith(
        todo: updatedNewTodo, status: CreateTodoStatus.submitted));
  }

  Future<void> _mapOnSubmittedDescription(
      OnSubmittedDescription event, Emitter<CreateTodoState> emit) async {
    final todoDescription = event.description;
    final updatedNewTodo = state.todo.copyWith(description: todoDescription);
    emit(state.copyWith(
        todo: updatedNewTodo, status: CreateTodoStatus.submitted));
  }

  Future<void> _mapOnSubmitButton(
      TodoNewSubmit event, Emitter<CreateTodoState> emit) async {
    emit(state.copyWith(status: CreateTodoStatus.loading));
    await  Future.delayed(const Duration(
      seconds: 3,
    ));
    emit(state.copyWith( status: CreateTodoStatus.loaded));
  }

 
}
