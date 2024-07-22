import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/allTaskspage.dart';
import 'package:flutter_application_1/Pages/welcomePage.dart';
import 'package:flutter_application_1/services/ApiService.dart';
import 'package:flutter_application_1/bloc/taskBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _taskApiService = TaskApiService();

    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(_taskApiService),
        ),
      ],
      child: MaterialApp(
        title: 'To-do App',
        debugShowCheckedModeBanner: false,
        home: WelcomePage(taskProvider: _taskApiService),
      ),
    );
  }
}
