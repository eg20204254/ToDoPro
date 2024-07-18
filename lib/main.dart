import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'To-do App',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TaskBloc(TaskApiService()),
        child: WelcomePage(),
      ),
    );
  }
}
