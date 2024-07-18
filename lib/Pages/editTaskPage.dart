import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/allTaskspage.dart';
import 'package:flutter_application_1/Widgets/button.dart';
import 'package:flutter_application_1/Widgets/inputField.dart';
import 'package:flutter_application_1/bloc/taskBloc.dart';
import 'package:flutter_application_1/bloc/taskEvent.dart';
import 'package:flutter_application_1/controllers/TaskController.dart';
import 'package:flutter_application_1/models/TaskModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  const EditTaskPage({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;
  final _formKey = GlobalKey<FormState>();

  late DateTime _selectedDate;
  late String _alertTime;
  late bool _isDone;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _alertTime = widget.task.alertAt;
    //_selectedDate = widget.task.date; *******************************
    _isDone = widget.task.isDone;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Color.fromARGB(255, 50, 54, 112),
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Center(
                    child: Image.asset(
                      'assets/t.png',
                      scale: 1,
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
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
                /*
                InputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    icon:
                        Icon(Icons.calendar_today_outlined, color: Colors.grey),
                    onPressed: () {
                      _getDateFromUser();
                    },
                  ),
                ),*/
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Start Time',
                        hint: _alertTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isAlertTime: true);
                          },
                          icon: const Icon(Icons.access_time_filled_outlined,
                              color: Colors.grey),
                        ),
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
                    const Text('Is Done'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button(
                      label: "Update Task",
                      onTap: () {
                        _updateTask();
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

  void _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _getTimeFromUser({required bool isAlertTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isAlertTime
          ? TimeOfDay.now() //TimeOfDay.fromDateTime(widget.task.date)
          : TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        String formattedTime = pickedTime.format(context);
        if (isAlertTime) {
          _alertTime = formattedTime;
        }
      });
    }
  }

  void _updateTask() {
    Task updatedTask = Task(
      title: _titleController.text,
      //date: _selectedDate,
      alertAt: _alertTime,
      isDone: _isDone,
    );

    context.read<TaskBloc>().add(UpdateTask(updatedTask));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task successfully updated"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AllTasksPage()),
    );
  }
}
