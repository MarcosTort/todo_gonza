part of 'create_todo_bloc.dart';

enum CreateTodoStatus {
  initial,
  loading,
  loaded,
  error,
}

class CreateTodoState extends Equatable {
  const CreateTodoState({
    required this.todo,
    required this.status,
  });

  const CreateTodoState.initial()
      : this(
          todo: const Todo(
              id: 5,
              completed: false,
              task: 'task',
              description: 'description'),
          status: CreateTodoStatus.initial,
        );

  final CreateTodoStatus status;
  final Todo todo;

  CreateTodoState copyWith({
    CreateTodoStatus? status, Todo? todo,
  }) {
    return CreateTodoState(
      status: status ?? this.status,
      todo: todo ?? this.todo,
    );
  }

  @override
  List<Object> get props => [status, todo];
}
