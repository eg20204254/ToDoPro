import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/services/ApiService.dart';
import 'package:flutter_application_1/bloc/taskEvent.dart';
import 'package:flutter_application_1/bloc/taskState.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskApiService apiService;

  TaskBloc(this.apiService) : super(TaskLoading()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading()); // Emit loading state
      try {
        final tasks = await apiService.fetchTasks();
        emit(TaskLoaded(tasks)); // Emit loaded state with tasks
        print('Tasks loaded: $tasks'); // Debugging print
      } catch (e) {
        emit(TaskError('Failed to load tasks: $e')); // Emit error state
        print('Task loading error: $e'); // Debugging print
      }
    });

    on<AddTask>((event, emit) async {
      emit(TaskLoading()); // Emit loading state
      try {
        await apiService.createTask(event.task);
        final tasks = await apiService.fetchTasks();
        emit(TaskLoaded(tasks)); // Emit loaded state with tasks
        print('Task added: ${event.task}'); // Debugging print
      } catch (e) {
        emit(TaskError('Failed to add task: $e')); // Emit error state
        print('Task adding error: $e'); // Debugging print
      }
    });

    on<UpdateTask>((event, emit) async {
      emit(TaskLoading());
      try {
        print('Updating task: ${event.task}');
        await apiService.updateTask(event.task);
        final tasks = await apiService.fetchTasks();
        emit(TaskLoaded(tasks));
        print('Task updated: ${event.task}');
      } catch (e) {
        emit(TaskError('Failed to update task: $e'));
        print('Task updating error: $e');
      }
    });

    on<DeleteTask>((event, emit) async {
      emit(TaskLoading()); // Emit loading state
      try {
        await apiService.deleteTask(event.id);
        final tasks = await apiService.fetchTasks();
        emit(TaskLoaded(tasks)); // Emit loaded state with tasks
        print('Task deleted with id: ${event.id}'); // Debugging print
      } catch (e) {
        emit(TaskError('Failed to delete task: $e')); // Emit error state
        print('Task deleting error: $e'); // Debugging print
      }
    });
  }
}
