part of 'todos_bloc.dart';

@immutable
abstract class TodosEvent extends ReplayEvent {
  const TodosEvent();
}
//evento para el completed checkbox
class TodoCompletedToggled extends TodosEvent {
  const TodoCompletedToggled({required this.completed, required this.todo});

  final bool completed;
  final Todo todo;
}

class TodoPriorityUpdated extends TodosEvent {
  const TodoPriorityUpdated({required this.position, required this.todo});

  final int position;
  final Todo todo;
}