import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/models/TaskModel.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded([this.tasks = const []]);

  @override
  List<Object> get props => [tasks];
}

class TaskError extends TaskState {
  final String error;

  const TaskError(this.error);

  @override
  List<Object> get props => [error];
}
