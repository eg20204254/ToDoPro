import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/allTaskspage.dart';
import 'package:flutter_application_1/Pages/editTaskpage.dart';
import 'package:flutter_application_1/bloc/taskBloc.dart';
import 'package:flutter_application_1/bloc/taskEvent.dart';
//import 'package:flutter_application_1/controllers/TaskController.dart';
import 'package:flutter_application_1/models/TaskModel.dart';
import 'package:flutter_application_1/themeData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;

  TaskDetailPage({Key? key, required this.task}) : super(key: key);
  //final TaskBloc taskBloc = Get.find<TaskBloc>();

  @override
  Widget build(BuildContext context) {
    //final TaskController taskController = Get.find<TaskController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Details',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Color.fromARGB(255, 50, 54, 112),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Center(
                    child: Image.asset(
                      'assets/k.webp',
                      scale: 1,
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Task ${task.id}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 50, 54, 112),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            getIcon(Icons.calendar_today),
                            SizedBox(width: 8),
                            Text(
                              "Title:",
                              style: fontStyle,
                            ),
                          ],
                        ),
                        /*SizedBox(height: 15),
                        Row(
                          children: [
                            getIcon(Icons.calendar_today),
                            SizedBox(width: 8),
                            Text(
                              "Date:",
                              style: fontStyle,
                            ),
                          ],
                        ),*/
                        SizedBox(height: 15),
                        Row(
                          children: [
                            getIcon(Icons.access_time),
                            SizedBox(width: 8),
                            Text(
                              "Alert Time:",
                              style: fontStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        /*Text(
                          "${DateFormat.yMMMd().format(task.date)}",
                          style: TextStyle(fontSize: 16),
                        ),*/
                        SizedBox(height: 8),
                        Text(
                          task.alertAt,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Spacer(),
                const Divider(color: Color.fromARGB(255, 50, 54, 112)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.edit,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditTaskPage(task: task)),
                            )),
                    IconButton(
                      icon: const Icon(Icons.delete,
                          color: Color.fromARGB(255, 164, 10, 10)),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Delete Task",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
          content: const Text("Are you sure you want to delete this Task?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Container(
                width: 60,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(255, 9, 1, 64),
                ),
                child: const Center(
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onPressed: () {
                _deleteTask(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(BuildContext context) {
    context.read<TaskBloc>().add(DeleteTask(task.id!));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task successfully deleted"),
        backgroundColor: Colors.green,
      ),
    );

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AllTasksPage()),
      );
    });
  }
}
