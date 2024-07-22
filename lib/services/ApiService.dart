import 'dart:convert';
import 'package:flutter_application_1/models/TaskModel.dart';
import 'package:http/http.dart' as http;

class TaskApiService {
  static const String apiUrl = 'https://test1.apis.lk/api/todos';

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Iterable jsonResponse = jsonDecode(response.body);
      List<Task> tasks =
          jsonResponse.map((taskJson) => Task.fromJson(taskJson)).toList();
      return tasks;
    } else {
      throw Exception('Failed to load tasks from API');
    }
  }

  Future<Task> createTask(Task newTask) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newTask.toJson()),
    );

    if (response.statusCode == 201) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create task');
    }
  }

  Future<Task> updateTask(Task updatedTask) async {
    final String url = '$apiUrl/${updatedTask.id}';
    print('Updating task with ID: ${updatedTask.id} at URL: $url');
    print('Update task request body: ${jsonEncode(updatedTask.toJson())}');

    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedTask.toJson()),
    );
    print('Update task response status: ${response.statusCode}');
    print('Update task response body: ${response.body}');

    if (response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to update task: ${response.reasonPhrase}'); // Add this line
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int taskId) async {
    final String url = '$apiUrl/$taskId';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete task');
    }
  }
}
