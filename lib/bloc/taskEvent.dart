import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/models/TaskModel.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;

  const AddTask(this.task);

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;

  const UpdateTask(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final int id;

  const DeleteTask(this.id);

  @override
  List<Object> get props => [id];
}
