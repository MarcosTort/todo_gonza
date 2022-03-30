part of 'create_todo_bloc.dart';

@immutable
abstract class CreateTodoEvent extends ReplayEvent {
  const CreateTodoEvent();
}

class OnSubmittedTitle extends CreateTodoEvent {
  const OnSubmittedTitle({required this.title});
  final String title;
}

class OnSubmittedDescription extends CreateTodoEvent {
  const OnSubmittedDescription({required this.description});
  final String description;
}

class OnSubmittedCompleted extends CreateTodoEvent {
  const OnSubmittedCompleted({required this.completed});
  final bool completed;
}

class OnSubmittedId extends CreateTodoEvent {
  const OnSubmittedId({required this.id});
  final int id;
}

class TodoNewSubmit extends CreateTodoEvent {
  const TodoNewSubmit({required this.submit});
  final bool submit;
}