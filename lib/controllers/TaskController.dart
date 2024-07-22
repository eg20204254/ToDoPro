import 'package:flutter_application_1/models/TaskModel.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/ApiService.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;
  var isLoading = true.obs;
  final TaskApiService apiService = TaskApiService();

  @override
  void onInit() {
    super.onInit();
/*
    taskList.add(Task(
      title: "Task 1",
      date: DateTime.now(),
      alertAt: "10:00 PM",
    ));
    taskList.add(Task(
      title: "Task 2",
      date: DateTime.now(),
      alertAt: "10:00 PM",
    ));
    taskList.add(Task(
      title: "Task 3",
      date: DateTime.now().add(Duration(days: 1)),
      alertAt: "10:00 PM",
    ));
*/
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading(true);
      var tasks = await apiService.fetchTasks();
      taskList.assignAll(tasks);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> createTask(Task newTask) async {
    try {
      var createdTask = await apiService.createTask(newTask);
      taskList.add(createdTask);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    try {
      var index = taskList.indexWhere((task) => task.id == updatedTask.id);
      if (index != -1) {
        await apiService.updateTask(updatedTask);
        taskList[index] = updatedTask;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteTask(int taskId) async {
    try {
      await apiService.deleteTask(taskId);
      taskList.removeWhere((task) => task.id == taskId);
      update();
      taskList.refresh();
    } catch (e) {
      print(e.toString());
    }
  }
}
