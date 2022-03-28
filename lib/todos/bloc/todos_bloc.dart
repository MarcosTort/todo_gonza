// ignore_for_file: unused_local_variable
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:project/todos/models/todo.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc()
      : super(TodosState(
          status: TodosStatus.initial,
          todos: Todo.initialList,
        )) {
    on<TodoCompletedToggled>(_mapTodoCompletedToggledToState);
    on<TodoPriorityUpdated>(_mapTodoPriorityUpdatedToState);
  }

  Future<void> _mapTodoCompletedToggledToState(
      TodoCompletedToggled event, 
      Emitter<TodosState> emit) async {
    final todoIndex = state.todos.indexOf(event.todo);

    final updatedTodos =
        state.todos.where((todo) => todo.id != event.todo.id).toList();

    final updatedTodo = event.todo.copyWith(completed: !event.todo.completed);
    updatedTodos.insert(todoIndex, updatedTodo);
    emit(state.copyWith(todos: updatedTodos));
  }

  Future<void> _mapTodoPriorityUpdatedToState(
    TodoPriorityUpdated event,
    Emitter<TodosState> emit) async {
    final todoIndex = state.todos.indexOf(event.todo);

    final updatedTodos =
        state.todos.where((todo) => todo.id != event.todo.id).toList();

    final updatedTodo = event.todo.copyWith(completed: !event.todo.completed);
    updatedTodos.insert(todoIndex, updatedTodo);
    emit(state.copyWith(todos: updatedTodos));
  }
}
