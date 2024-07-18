import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/services/ApiService.dart';
import 'taskEvent.dart';
import 'taskState.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskApiService apiService;

  TaskBloc(this.apiService) : super(TaskLoading());

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is LoadTasks) {
      yield* _mapLoadTasksToState();
    } else if (event is AddTask) {
      yield* _mapAddTaskToState(event);
    } else if (event is UpdateTask) {
      yield* _mapUpdateTaskToState(event);
    } else if (event is DeleteTask) {
      yield* _mapDeleteTaskToState(event);
    }
  }

  Stream<TaskState> _mapLoadTasksToState() async* {
    yield TaskLoading();
    try {
      final tasks = await apiService.fetchTasks();
      yield TaskLoaded(tasks);
    } catch (e) {
      yield TaskError('Failed to load tasks: $e');
    }
  }

  Stream<TaskState> _mapAddTaskToState(AddTask event) async* {
    try {
      await apiService.createTask(event.task);
      final tasks = await apiService.fetchTasks();
      yield TaskLoaded(tasks);
    } catch (e) {
      yield TaskError('Failed to add task: $e');
    }
  }

  Stream<TaskState> _mapUpdateTaskToState(UpdateTask event) async* {
    try {
      await apiService.updateTask(event.task);
      final tasks = await apiService.fetchTasks();
      yield TaskLoaded(tasks);
    } catch (e) {
      yield TaskError('Failed to update task: $e');
    }
  }

  Stream<TaskState> _mapDeleteTaskToState(DeleteTask event) async* {
    try {
      await apiService.deleteTask(event.id);
      final tasks = await apiService.fetchTasks();
      yield TaskLoaded(tasks);
    } catch (e) {
      yield TaskError('Failed to delete task: $e');
    }
  }
}
