import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/allTaskspage.dart';
import 'package:flutter_application_1/Widgets/button.dart';
import 'package:flutter_application_1/Widgets/inputField.dart';
import 'package:flutter_application_1/bloc/taskBloc.dart';
import 'package:flutter_application_1/bloc/taskEvent.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:flutter_application_1/models/TaskModel.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _alertTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  bool _isDone = false;

  //final taskBloc = Get.find<TaskBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Task',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Color.fromARGB(255, 50, 54, 112),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Image.asset(
                'assets/l.webp',
                scale: 1,
                width: 200,
                height: 200,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: SingleChildScrollView(
                  child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputField(
                      title: 'Title',
                      hint: 'Enter your title',
                      controller: _titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Title cannot be empty';
                        }
                        return null;
                      },
                    ),

                    /*InputField(
                      title: 'Date',
                      hint: DateFormat.yMd().format(_selectedDate),
                      widget: IconButton(
                          icon: const Icon(Icons.calendar_today_outlined,
                              color: Colors.grey),
                          onPressed: () {
                            _getDateFromUser();
                          }),
                    ),*/
                    Row(
                      children: [
                        Expanded(
                          child: InputField(
                            title: 'Start Time',
                            hint: _alertTime,
                            widget: IconButton(
                                onPressed: () {
                                  _getTimeFromeUser(isAlertTime: true);
                                },
                                icon: const Icon(
                                    Icons.access_time_filled_outlined,
                                    color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _isDone,
                          onChanged: (bool? newValue) {
                            setState(() {
                              _isDone = newValue!;
                            });
                          },
                        ),
                        const Text('Done'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(
                          label: "Create Task",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _createTask();
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2030));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      print("It is null or something went wrong");
    }
  }

  _getTimeFromeUser({required bool isAlertTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time canceled");
    } else if (isAlertTime == true) {
      setState(() {
        _alertTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          //_startTime --> 10:30 AM
          hour: int.parse(_alertTime.split(":")[0]),
          minute: int.parse(_alertTime.split(":")[1].split(" ")[0]),
        ));
  }

  Future<void> _createTask() async {
    Task newTask = Task(
      title: _titleController.text,
      //date: _selectedDate,
      alertAt: _alertTime,
      isDone: _isDone,
    );

    try {
      context.read<TaskBloc>().add(AddTask(newTask));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Task successfully created"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AllTasksPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create task: $e')),
      );
    }
  }
}
