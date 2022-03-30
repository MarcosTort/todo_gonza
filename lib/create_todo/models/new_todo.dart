// import 'package:equatable/equatable.dart';
// import 'package:project/todos/models/todo.dart';

// class NewTodo extends Equatable  {
//   const NewTodo({
//     required this.id,
//     required this.completed,
//     required this.task,
//     required this.description,
//   });

//   static get initialTodo =>
//       const NewTodo(id: 1, completed: false, task: '', description: '');

//   final int id;
//   final bool completed;
//   final String task;
//   final String description;
//   @override
//   List<Object> get props => [id, completed, task, description];

//   @override
//   NewTodo copyWith({int ? id, String? task, String? description}) {
//     return NewTodo(
//       id: id ?? this.id,
//       completed: completed,
//       task: task?? this.task,
//       description: description?? this.description,
//     );
//   }
// }
