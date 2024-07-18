import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/homePage.dart';
import 'package:flutter_application_1/Pages/taskDetail.dart';
import 'package:flutter_application_1/Widgets/taskContainer.dart';
import 'package:flutter_application_1/bloc/taskBloc.dart';
import 'package:flutter_application_1/bloc/taskEvent.dart';
import 'package:flutter_application_1/bloc/taskState.dart';
import 'package:flutter_application_1/models/TaskModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskBloc.add(LoadTasks());
    });

    return Scaffold(
      appBar: _appBar(context),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            return _buildTaskList(context, state.tasks);
          } else if (state is TaskError) {
            return Center(child: Text('Error loading tasks: ${state.error}'));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  Widget _buildTaskList(BuildContext context, List<Task> tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        Task task = tasks[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailPage(task: task),
              ),
            );
          },
          child: TaskContainer(task: task),
        );
      },
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
      ),
      title: const Text(
        'All Tasks',
        style: TextStyle(fontSize: 20),
      ),
      backgroundColor: Color.fromARGB(255, 50, 54, 112),
      foregroundColor: Colors.white,
    );
  }
}
